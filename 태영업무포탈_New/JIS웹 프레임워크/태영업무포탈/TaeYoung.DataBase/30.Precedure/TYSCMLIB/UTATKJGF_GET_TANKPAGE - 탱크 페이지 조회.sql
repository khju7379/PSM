--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKPAGE;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_TANKPAGE
-- �ۼ���     : �̻���
-- �ۼ���     : 2018-02-13
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_TANKPAGE ('0403-M',1)
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKPAGE 
( 
	P_TKSABUN			VARCHAR(8),
	P_TKINDEX           VARCHAR(2)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT                         
			TKSABUN,                       
			TKINDEX,                       
			TKNO1,
			TKNO2,
			TKNO3,
			TKNO4,
			TKNO5,
			TKNO6,
			TKNO7,
			TKNO8,
			TKNO9,
			TKNO10               
		FROM TYSCMLIB.PSTKMONITORF     
		WHERE TKSABUN = P_TKSABUN
		AND TKINDEX = P_TKINDEX;
		
	OPEN REFCURSOR;

END