-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_GROUP_LIST
-- �ۼ���     : ������
-- �ۼ���     : 2016-11-11
-- ����       : �׷��� ��ȸ�Ѵ�.
-- ����       : CALL ORG_GROUP_LIST 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.ORG_GROUP_LIST
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP_LIST
(
		P_CURRENTPAGEINDEX          INTEGER					-- ����� ���������� ��ȣ  
	,   P_PAGESIZE                  INTEGER					-- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  	
	,	P_LANGCODE					VARCHAR(10)				-- ����ڵ�
	,   P_GRPTYPE					NVARCHAR(10)			-- �׷�����	
	,   P_GRPNAME					NVARCHAR(50)			-- �׷�����	
	,	P_GRPID						NVARCHAR(50)			-- �׷�ID
)
	RESULT SETS 2
	LANGUAGE SQL
P1: BEGIN	-- ����
	DECLARE	P_STIDX INTEGER;
	DECLARE P_FNIDX INTEGER;
	S1 : BEGIN
		SET P_STIDX = ((P_CURRENTPAGEINDEX - 1) * P_PAGESIZE) + 1;
		SET P_FNIDX = P_CURRENTPAGEINDEX * P_PAGESIZE;
	END S1 ;

	MAIN : BEGIN -- �����
        LIST : BEGIN -- ����Ʈ
			DECLARE REFCURSOR CURSOR WITH RETURN FOR
			WITH MST AS (
				SELECT 
						ROW_NUMBER() OVER(ORDER BY OG.GRPID ASC) AS ROW_NO
					,	OG.GRPID
					,	OG.SHRRNG
					,	LOWER(OGL.LANGCODE) AS LANGCODE
					,	OGL.GRPNAME
					,	'' AS GRPTYPENM -- TYJINFWLIB.UF_GET_CODENAME('', P_LANGCODE, '', '', OG.GRPID) AS GRPTYPENM
					,	(SELECT COUNT(*) FROM TYJINFWLIB.CMN_ACL WHERE ACL_GRP = OG.GRPID AND ACL_TYPE = 'MENU') AS CNT
				FROM
						TYJINFWLIB.ORG_GROUP AS OG
						LEFT OUTER JOIN TYJINFWLIB.ORG_GROUPLANG AS OGL
							ON	OG.GRPID 				= OGL.GRPID
							AND	LOWER(OGL.LANGCODE)		= P_LANGCODE
				WHERE
						OG.USEYN						= '1'
				AND		COALESCE(OG.GRPTYPE,'') 		LIKE P_GRPTYPE || '%'
				AND		COALESCE(OGL.GRPNAME,'') 		LIKE '%' || P_GRPNAME || '%'
				AND		COALESCE(OG.GRPID,'') 			LIKE '%' || P_GRPID || '%'
			)
			SELECT
					*
			FROM
					MST
			WHERE
					ROW_NO BETWEEN P_STIDX AND P_FNIDX
			ORDER BY ROW_NO ASC
			;
			OPEN REFCURSOR ;
        END LIST ;

        PAGING : BEGIN -- ����¡
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
			SELECT
					COUNT(*) AS TOTALCOUNT
			FROM
					TYJINFWLIB.ORG_GROUP AS OG
					LEFT OUTER JOIN TYJINFWLIB.ORG_GROUPLANG AS OGL
						ON	OG.GRPID 				= OGL.GRPID
						AND	LOWER(OGL.LANGCODE)		= P_LANGCODE
			WHERE
					OG.USEYN						= '1'
			AND		COALESCE(OG.GRPTYPE,'') 		LIKE P_GRPTYPE || '%'
			AND		COALESCE(OGL.GRPNAME,'') 		LIKE '%' || P_GRPNAME || '%'
			AND		COALESCE(OG.GRPID,'') 			LIKE '%' || P_GRPID || '%'
			;
			OPEN REFCURSOR2 ;
		END PAGING ;

    END MAIN ;
END P1
	
