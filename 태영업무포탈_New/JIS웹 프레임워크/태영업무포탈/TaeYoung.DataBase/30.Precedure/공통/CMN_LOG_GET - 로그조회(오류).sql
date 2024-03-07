--DROP PROCEDURE CMN_LOG_GET;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_LOG_GET
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-07
-- ����       : �����α������� �Է��Ѵ�.
-- ����       : CALL CMN_LOG_GET (1)
--		DB2 ��ȯ : �������ν����� SP_SYSTEM_LOG
--		������ ��ȯ : PTCMMBAS60S1 -> CMN_LOG_GET
-------------------------------------------------------------------------------------------
CREATE PROCEDURE CMN_LOG_GET
(
		P_IDX		INTEGER
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT	MESSAGE, MESSAGE_DETAIL
		FROM	TYJINFWLIB.CMN_LOG
		WHERE	IDX = P_IDX;

	OPEN REFCURSOR;

END P1