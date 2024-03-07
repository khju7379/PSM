-------------------------------------------------------------------------------------------
--
-- ���ν����� : ORG_GROUPUSR_GET 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-03
-- ����       : �׷� �����ȸ ��ȸ
-- ����       : CALL ORG_GROUPUSR_GET  ('GRPID')
--		DB2 ��ȯ : �������ν����� UP_GROUPMEMBER_SELECT
--		������ ��ȯ : PTORGUSR40S1 -> ORG_GROUPUSR_GET  
-------------------------------------------------------------------------------------------
----DROP PROCEDURE ORG_GROUPUSR_GET
CREATE PROCEDURE ORG_GROUPUSR_GET
(
		P_GRPID		VARCHAR(10)   --�׷�ID
)
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN	-- ����
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	SELECT 
			GM.GRPID
		,	GM.USRID
		,	GM.COMPANYCODE
		,	GM.USRTYPE
		,	CASE GM.USRTYPE
				WHEN 1
				THEN TYJINFWLIB.UF_USERINFO_USERNAME2(GM.USRID, 'ko')
				WHEN 2
				THEN TYJINFWLIB.UF_DEPTNAME(GM.COMPANYCODE, 'ko', GM.USRID)
			END AS USRNM
		,	G.COMPANY AS COMPANYNAME
	FROM
			TYJINFWLIB.ORG_GROUPUSR AS GM
			LEFT JOIN TYJINFWLIB.ORG_COMPANYLANG AS G
				ON	GM.COMPANYCODE		= G.COMPANYCODE
				AND G.LANGUAGECODE		= 'ko'
	WHERE
			GRPID = P_GRPID
	;
	OPEN REFCURSOR;
END P1
	