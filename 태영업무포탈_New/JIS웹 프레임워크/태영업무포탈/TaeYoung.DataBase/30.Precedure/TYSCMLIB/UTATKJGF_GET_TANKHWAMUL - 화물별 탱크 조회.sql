--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKHWAMUL;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : UTATKJGF_GET_TANKHWAMUL
-- 작성자     : 이상현
-- 작성일     : 2018-02-13
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.UTATKJGF_GET_TANKHWAMUL ('0403-M',1)
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKHWAMUL
( 
	IN_JEHWAMUL           VARCHAR(3),
	IN_JEHMNAME          VARCHAR(50)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
		JEGOTK AS TNTANKNO
		FROM TYSCMLIB.UTATKJGF
		WHERE JEHWAMUL = IN_JEHWAMUL
		AND JEHMNAME = IN_JEHMNAME;
		
	OPEN REFCURSOR;

END