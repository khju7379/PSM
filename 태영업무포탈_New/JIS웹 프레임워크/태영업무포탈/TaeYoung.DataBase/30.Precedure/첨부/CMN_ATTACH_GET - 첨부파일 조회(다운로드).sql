-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_ATTACH_GET
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-09
-- ����       : ÷������ ����Ʈ�� ��ȸ�Ѵ�.
-- ����       : CALL CMN_ATTACH_GET ('TEMPLETE01','10')
--		DB2 ��ȯ : �������ν����� SP_ATTACH_FILE_SELECT
--		������ ��ȯ : PTCMMBAS20S1 -> CMN_ATTACH_GET
-------------------------------------------------------------------------------------------
CREATE PROCEDURE PSSCMLIB.CMN_ATTACH_GET 
(
	P_UNID	VARCHAR(50)
)
	RESULT SETS 1
	LANGUAGE SQL
M1: BEGIN
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT * 
		FROM PSSCMLIB.PSM_CMN_ATTACH
		WHERE ATTACH_UNID = P_UNID;	
		
	OPEN REFCURSOR;
	
END M1