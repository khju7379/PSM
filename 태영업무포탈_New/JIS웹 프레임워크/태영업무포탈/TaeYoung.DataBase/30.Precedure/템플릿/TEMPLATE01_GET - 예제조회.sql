
--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_COMBO;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_COMBO
-- �ۼ���     : ������
-- �ۼ���     : 2016-09-02
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_COMBO (1,20,'')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_COMBO ()
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT DISTINCT JEGOTK FROM  TYFILELIB.UTATKJGF ORDER BY JEGOTK ASC;
		
	OPEN REFCURSOR;

END