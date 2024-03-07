-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_CONNLOGTABLE_GET
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 존재하는 로그테이블을 조회한다. 
-- 예문       : CALL CMN_CONNLOGTABLE_GET ('2006909','1000','TS1301')
--		DB2 변환 : 이전프로시져명 UP_LOGGING_TABLE_SELECT
-------------------------------------------------------------------------------------------
CREATE PROCEDURE CMN_CONNLOGTABLE_GET ()
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT * FROM INFORMATION_SCHEMA.Tables WHERE TABLE_SCHEMA = 'TYJINFWLIB' AND TABLE_NAME LIKE 'LOG_%';
	
	OPEN REFCURSOR;
    
END P1