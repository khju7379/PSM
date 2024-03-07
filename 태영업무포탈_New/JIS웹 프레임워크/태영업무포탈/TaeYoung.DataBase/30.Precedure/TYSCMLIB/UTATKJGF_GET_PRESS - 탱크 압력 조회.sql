DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_PRESS;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : UTATKJGF_GET_PRESS
-- 작성자     : 이상현
-- 작성일     : 2018-06-25
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.UTATKJGF_GET_PRESS ()
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_PRESS 
( 
	
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
			TRIM(JEGOTK) AS JEGOTK,
			TRUNC(JEPRESS,0) AS JEPRESS,
			SUBSTR(JEGOIL,1,4) ||'-'|| SUBSTR(JEGOIL,5,2) ||'-'|| SUBSTR(JEGOIL,7,2) ||' / '|| SUBSTR(JEGOTM,1,2) ||':'|| SUBSTR(JEGOTM,3,2) ||':'|| SUBSTR(JEGOTM,5,2) AS JEGOTM
		FROM TYSCMLIB.UTATKJGF
		WHERE JEGOTK NOT IN(' 904','3007','5007')
		ORDER BY JEGOTK;

		
	OPEN REFCURSOR;

END