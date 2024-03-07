-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_ATTACH_LIST
-- 작성자     : 문광복
-- 작성일     : 2015-09-09
-- 설명       : 첨부파일 리스트를 조회한다.
-- 예문       : CALL CMN_ATTACH_LIST ('TEMPLETE01','10')
--		DB2 변환 : 이전프로시져명 SP_ATTACH_FILE_LIST
--		프렌지 변환 : PTCMMBAS20L1 -> CMN_ATTACH_LIST
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