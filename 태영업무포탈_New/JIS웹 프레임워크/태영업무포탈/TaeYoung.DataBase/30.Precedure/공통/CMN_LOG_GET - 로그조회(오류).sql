--DROP PROCEDURE CMN_LOG_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_LOG_GET
-- 작성자     : 문광복
-- 작성일     : 2015-09-07
-- 설명       : 오류로그정보를 입력한다.
-- 예문       : CALL CMN_LOG_GET (1)
--		DB2 변환 : 이전프로시져명 SP_SYSTEM_LOG
--		프렌지 변환 : PTCMMBAS60S1 -> CMN_LOG_GET
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