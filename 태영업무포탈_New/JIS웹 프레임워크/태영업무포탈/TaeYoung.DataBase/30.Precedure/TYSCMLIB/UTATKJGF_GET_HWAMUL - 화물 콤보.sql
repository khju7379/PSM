DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_HWAMUL;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : UTATKJGF_GET_HWAMUL
-- 작성자     : 문광복
-- 작성일     : 2016-09-02
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.UTATKJGF_GET_HWAMUL ()
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_HWAMUL 
( 

)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT 
			JEHWAMUL || ':' || JEHMNAME AS NAME,
			JEHWAMUL AS CODE
		FROM TYSCMLIB.UTATKJGF
		WHERE JEHWAMUL <> ''
		AND JEHMNAME <> ''
		GROUP BY JEHWAMUL, JEHMNAME
		ORDER BY JEHWAMUL
		
	OPEN REFCURSOR;

END