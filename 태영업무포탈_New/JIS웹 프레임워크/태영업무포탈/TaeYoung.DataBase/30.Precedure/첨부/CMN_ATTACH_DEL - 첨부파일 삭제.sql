-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_ATTACH_DEL
-- �ۼ���     : ������
-- �ۼ���     : 2015-10-29
-- ����       : ÷�������� �����Ѵ�.
-- ����       : CALL CMN_ATTACH_DEL ('','')
--		DB2 ��ȯ : �������ν����� SP_ATTACH_FILE_DELETE
--		������ ��ȯ : PTCMMBAS20D1 -> CMN_ATTACH_DEL
-------------------------------------------------------------------------------------------
CREATE PROCEDURE PSSCMLIB.CMN_ATTACH_DEL 
(
	IN P_ATTACH_UNID VARCHAR(50)
)
	RESULT SETS 1
	LANGUAGE SQL

P1 : BEGIN
	IF EXISTS(SELECT * FROM PSSCMLIB.PSM_CMN_ATTACH WHERE ATTACH_UNID = P_ATTACH_UNID) THEN
		DELETE FROM PSSCMLIB.PSM_CMN_ATTACH WHERE ATTACH_UNID = P_ATTACH_UNID;
	END IF;

	S1: BEGIN
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			SELECT * FROM PSSCMLIB.PSM_CMN_ATTACH WHERE ATTACH_UNID = P_ATTACH_UNID;
		OPEN REFCURSOR;	
	END S1;
END P1
