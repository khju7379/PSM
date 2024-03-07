DROP PROCEDURE PSSCMLIB.PSM_TEMP_ATTACH_GET ;
-------------------------------------------------------------------------------------------
-- ���ν����� : PSM_IMGSIGN_GET
-- �ۼ���     : ������
-- �ۼ���     : 2019-02-21
-- ����       : ������� �����̹����� �����´�.
-- ����       : CALL TYSCMLIB.PSM_IMGSIGN_GET ('0311-M')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE PSSCMLIB.PSM_TEMP_ATTACH_GET 
(
	P_ATTACH_TYPE			VARCHAR(50),
	P_ATTACH_UNID			VARCHAR(50)
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		SELECT	ATTACH_TYPE,
		        ATTACH_UNID,
				FILE_NAME,
				FILE_SIZE,
				FILE_PATH,
				ATTACH_BYTE
		FROM	PSSCMLIB.PSM_TEMP_ATTACH 
		WHERE ATTACH_TYPE = P_ATTACH_TYPE
		 AND  ATTACH_UNID = P_ATTACH_UNID;

	OPEN REFCURSOR;
	
END P1