-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_GROUP_ACLEXISTS_LIST
-- �ۼ���     : ������
-- �ۼ���     : 2016-11-11
-- ����       : �׷��� ��ȸ�Ѵ�.
-- ����       : CALL ORG_GROUP_ACLEXISTS_LIST 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.ORG_GROUP_ACLEXISTS_LIST
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP_ACLEXISTS_LIST
(
		P_LANGCODE				VARCHAR(10)				-- ����ڵ�
	,   P_SEARCHCONDITION		VARCHAR(4000)           -- ��ȸ���� ����  	
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN	-- ����
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	SELECT
			A.GRPID
		,	A.SHRRNG
		,	B.LANGCODE
		,	B.GRPNAME
		,	CASE
				WHEN C.ACL_GRP IS NULL
				THEN '0'
				ELSE '1'
			END AS CHK
	FROM
			TYJINFWLIB.ORG_GROUP AS A
			 LEFT OUTER JOIN TYJINFWLIB.ORG_GROUPLANG AS B
				ON	A.GRPID					= B.GRPID
				AND LOWER(B.LANGCODE)		= P_LANGCODE
				AND A.USEYN					= 1
			 LEFT OUTER JOIN TYJINFWLIB.CMN_ACL AS C
				ON	A.GRPID					= C.ACL_GRP
				AND C.ACL_TYPE				= 'MENU'
				AND C.ACL_ID				= P_SEARCHCONDITION
	;
	OPEN REFCURSOR ;

END P1
	
