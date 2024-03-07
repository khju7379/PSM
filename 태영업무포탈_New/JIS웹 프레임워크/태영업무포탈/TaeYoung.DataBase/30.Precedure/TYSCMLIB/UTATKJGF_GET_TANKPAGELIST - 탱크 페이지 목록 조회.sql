--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKPAGELIST;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : UTATKJGF_GET_TANKPAGE
-- 작성자     : 이상현
-- 작성일     : 2018-02-13
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.UTATKJGF_GET_TANKPAGELIST ('0403-M')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKPAGELIST 
( 
	IN_TKSABUN			VARCHAR(8)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
		TKINDEX
		FROM 
		TYSCMLIB.PSTKMONITORF
		WHERE TKSABUN = IN_TKSABUN
		ORDER BY TKINDEX;
		
	OPEN REFCURSOR;

END