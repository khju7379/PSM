
--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_COMBO;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : UTATKJGF_GET_COMBO
-- 작성자     : 문광복
-- 작성일     : 2016-09-02
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.UTATKJGF_GET_COMBO (1,20,'')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_COMBO ()
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT DISTINCT JEGOTK FROM  TYFILELIB.UTATKJGF ORDER BY JEGOTK ASC;
		
	OPEN REFCURSOR;

END