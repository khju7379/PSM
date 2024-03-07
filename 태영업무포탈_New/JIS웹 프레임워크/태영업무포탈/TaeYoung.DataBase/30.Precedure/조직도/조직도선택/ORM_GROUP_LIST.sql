
-------------------------------------------------------------------------------------------
--
-- ���ν����� : ORM_GROUP_LIST
-- �ۼ���     : ���ȯ
-- �ۼ���     : 2010-07-13
-- ����       : �׷� ����Ʈ�� ��ȸ�Ѵ�.
-- ����       : CALL TYJINFWLIB.ORM_GROUP_LIST('1000', 'ko')
-- DB2 ��ȯ   : �������ν����� up_OrgChart_Select_Group
--
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.ORM_GROUP_LIST
CREATE PROCEDURE TYJINFWLIB.ORM_GROUP_LIST
(
		P_COMPANYCODE	VARCHAR(50)
	 ,	P_LANGCODE		VARCHAR(10)
)

	LANGUAGE SQL
	RESULT SETS 1
	
P1 : BEGIN
  	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	SELECT
			G.GRPID AS GROUPCODE
		,	(CASE WHEN COALESCE(GL.GRPNAME, '') = '' THEN GK.GRPNAME ELSE GL.GRPNAME END) AS GROUPNAME
		,	'' AS GROUPMAIL
	FROM
			TYJINFWLIB.ORG_GROUP AS G
			LEFT JOIN TYJINFWLIB.ORG_GROUPLANG	AS GL
					ON	G.GRPID		= GL.GRPID
					AND	GL.LANGCODE	= P_LANGCODE
			LEFT JOIN TYJINFWLIB.ORG_GROUPLANG	AS GK
					ON	G.GRPID		= GK.GRPID
					AND	GK.LANGCODE	= 'KO'
	WHERE
			G.GRPTYPE = 'AM02040';				-- ���ڰ���
	OPEN REFCURSOR;
END P1