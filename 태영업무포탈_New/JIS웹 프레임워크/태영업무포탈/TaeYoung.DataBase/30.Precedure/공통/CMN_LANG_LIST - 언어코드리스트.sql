-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_LANG_LIST
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 언어코드리스트를 조회한다.
-- 예문       : CALL CMN_LANG_LIST ('2006909','1000','TS1301')
--		DB2 변환 : 이전프로시져명 UP_LANG_CODE_LIST
--		프렌지 변환 : PTCMMBAS30L1 -> CMN_LANG_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG_LIST 
(
	P_PROGRAMID VARCHAR(50),
	P_CODE VARCHAR(4000),
	P_LANGCODE CHAR(2)
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE P_QUERY VARCHAR(4000);
	
	--DECLARE REFCURSOR CURSOR WITH RETURN FOR P_QUERY;
	DECLARE REFCURSOR  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S1 ;  -- 커서생성 

	SET P_QUERY = '
			SELECT CODE,
				CASE LENGTH(COALESCE(' || P_LANGCODE || ', '''')) 
					WHEN 0 
		   				THEN KO 
		   			ELSE 
		   				' || P_LANGCODE || ' END AS LANG_TEXT 
			FROM TYJINFWLIB.CMN_LANG
			WHERE PROGRAMID = ''' || P_PROGRAMID || ''' AND CODE IN (' || P_CODE || ')
		';
	
	PREPARE S1 FROM P_QUERY;
	
	OPEN REFCURSOR;
END P1