--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKLOCATE;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : UTATKJGF_GET_TANKLOCATE
-- 작성자     : 이상현
-- 작성일     : 2018-02-13
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.UTATKJGF_GET_TANKLOCATE ('0403-M',1)
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKLOCATE 
( 
	IN_TNLOCATE           VARCHAR(1)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
		TNTANKNO
		FROM TYSCMLIB.UTITANKF
		WHERE TNLOCATE = IN_TNLOCATE
		AND    TNTANKNO NOT IN ('5007','9001','9002');
		
	OPEN REFCURSOR;

END