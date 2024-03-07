-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_ATTACH_LIST
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-09
-- ����       : ÷������ ����Ʈ�� ��ȸ�Ѵ�.
-- ����       : CALL CMN_ATTACH_LIST ('TEMPLETE01','10')
--		DB2 ��ȯ : �������ν����� SP_ATTACH_FILE_LIST
--		������ ��ȯ : PTCMMBAS20L1 -> CMN_ATTACH_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_ATTACH_LIST 
(
	P_ATTACH_TYPE	VARCHAR(50),
	P_ATTACH_NO	VARCHAR(50)
)
	RESULT SETS 1
	LANGUAGE SQL
M1: BEGIN
	DECLARE REFCURSOR CURSOR WITH RETURN FOR

	SELECT
			* 
	FROM
			TYJINFWLIB.CMN_ATTACH
	WHERE
			RTRIM(ATTACH_TYPE)	= P_ATTACH_TYPE 
	AND		RTRIM(ATTACH_NO)	= P_ATTACH_NO
	ORDER BY FILE_NAME ASC
	;
		
	OPEN REFCURSOR;
	
END M1