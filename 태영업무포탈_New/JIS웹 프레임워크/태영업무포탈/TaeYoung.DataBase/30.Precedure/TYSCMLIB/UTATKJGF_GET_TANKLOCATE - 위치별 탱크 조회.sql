--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKLOCATE;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_TANKLOCATE
-- �ۼ���     : �̻���
-- �ۼ���     : 2018-02-13
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_TANKLOCATE ('0403-M',1)
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKLOCATE 
( 
	IN_TNLOCATE           VARCHAR(1)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
		TNTANKNO
		FROM TYSCMLIB.UTITANKF
		WHERE TNLOCATE = IN_TNLOCATE
		AND    TNTANKNO NOT IN ('5007','9001','9002');
		
	OPEN REFCURSOR;

END