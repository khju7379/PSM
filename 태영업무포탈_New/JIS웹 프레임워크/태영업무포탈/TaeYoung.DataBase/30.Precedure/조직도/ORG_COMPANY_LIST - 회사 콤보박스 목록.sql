-------------------------------------------------------------------------------------------
--
-- ���ν����� : ORG_COMPANY_LIST
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-02
-- ����       : ȸ�� �޺��ڽ� ���
-- ����       : CALL ORG_COMPANY_LIST ('KO')
--		DB2 ��ȯ : �������ν����� UP_COMPANY_COMBO
--		������ ��ȯ : PTORGUSR10L1 -> ORG_COMPANY_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_COMPANY_LIST
(
	P_LANGUAGECODE VARCHAR(50)
)
	RESULT SETS 2
	LANGUAGE SQL
P1: BEGIN


	DECLARE REFCURSOR CURSOR WITH RETURN FOR

	SELECT '' AS COMPANYCODE , '' AS COMPANY, '' AS DISPLAYORDER
	FROM SYSIBM.SYSDUMMY1
	UNION ALL

	SELECT
		CP.COMPANYCODE,			-- ȸ���ڵ�
		CPG.COMPANY,			-- ȸ���
		CP.DISPLAYORDER
	FROM
		TYJINFWLIB.ORG_COMPANY CP
		LEFT OUTER JOIN TYJINFWLIB.ORG_COMPANYLANG CPG ON CP.COMPANYCODE = CPG.COMPANYCODE 
		AND CPG.LANGUAGECODE = P_LANGUAGECODE
	ORDER BY DISPLAYORDER ASC;
	OPEN REFCURSOR;
END P1