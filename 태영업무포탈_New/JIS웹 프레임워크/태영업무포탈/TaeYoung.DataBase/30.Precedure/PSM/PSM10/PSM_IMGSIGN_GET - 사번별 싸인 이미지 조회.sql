--DROP PROCEDURE TYSCMLIB.PSM_IMGSIGN_GET ;
-------------------------------------------------------------------------------------------
-- ���ν����� : PSM_IMGSIGN_GET
-- �ۼ���     : ������
-- �ۼ���     : 2019-02-21
-- ����       : ������� �����̹����� �����´�.
-- ����       : CALL TYSCMLIB.PSM_IMGSIGN_GET ('0311-M')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYSCMLIB.PSM_IMGSIGN_GET 
(
	P_IMGSABUN			VARCHAR(100)
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		SELECT	*
		FROM	TYSCMLIB.PSM_IMGSIGN
		WHERE	IMGSABUN = P_IMGSABUN;
	OPEN REFCURSOR;
	
END P1