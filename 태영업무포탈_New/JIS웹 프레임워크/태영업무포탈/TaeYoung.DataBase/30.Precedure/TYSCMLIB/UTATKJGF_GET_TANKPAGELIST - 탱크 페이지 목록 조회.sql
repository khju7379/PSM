--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKPAGELIST;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_TANKPAGE
-- �ۼ���     : �̻���
-- �ۼ���     : 2018-02-13
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_TANKPAGELIST ('0403-M')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKPAGELIST 
( 
	IN_TKSABUN			VARCHAR(8)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
		TKINDEX
		FROM 
		TYSCMLIB.PSTKMONITORF
		WHERE TKSABUN = IN_TKSABUN
		ORDER BY TKINDEX;
		
	OPEN REFCURSOR;

END