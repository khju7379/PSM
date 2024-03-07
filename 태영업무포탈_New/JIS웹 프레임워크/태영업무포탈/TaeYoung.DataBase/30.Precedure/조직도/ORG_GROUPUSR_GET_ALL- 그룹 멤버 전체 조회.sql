-------------------------------------------------------------------------------------------
--
-- ���ν����� : ORG_GROUPUSR_GET_ALL 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-03
-- ����       : �׷� �����ü ��ȸ
-- ����       : CALL ORG_GROUPUSR_GET_ALL  ('')
--		DB2 ��ȯ : �������ν����� UP_GROUPMEMBER_LIST_BYALLUSER
--		������ ��ȯ : PTORGUSR40S2 -> ORG_GROUPUSR_GET_ALL   
-------------------------------------------------------------------------------------------
CREATE PROCEDURE ORG_GROUPUSR_GET_ALL 
(
		P_NAME		VARCHAR(10)   -- ����ڸ�
)
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN	-- ����
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	SELECT
			A.LOGINID
		 ,	A.EMPID
		 ,	A.DISPLAYNAME
		 ,	B.COMPANY 
		 ,	A.COMPANYCODE
	FROM ORG_USER A 

	LEFT JOIN ORG_COMPANYLANG B ON (A.COMPANYCODE = B.COMPANYCODE AND B.LANGUAGECODE = 'KO')
	
	WHERE A.DISPLAYNAME LIKE '%' || P_NAME || '%'
	ORDER BY A.DISPLAYNAME ASC;

	OPEN REFCURSOR;
END P1
	
