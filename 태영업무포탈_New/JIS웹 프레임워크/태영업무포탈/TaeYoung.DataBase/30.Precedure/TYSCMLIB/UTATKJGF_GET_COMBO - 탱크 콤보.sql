DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_COMBO;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_COMBO
-- �ۼ���     : ������
-- �ۼ���     : 2016-09-02
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_COMBO ()
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_COMBO 
( 

)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT                         
		TNTANKNO AS TANKNO,            
		TRIM(TNTANKNO) AS TANKNOVALUE       
		FROM TYSCMLIB.UTITANKF     
		WHERE TNTANKNO NOT IN ('5007','9001','9002')   
		ORDER BY TNTANKNO;
		
	OPEN REFCURSOR;

END