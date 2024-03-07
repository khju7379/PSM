--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKHWAMUL;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_TANKHWAMUL
-- �ۼ���     : �̻���
-- �ۼ���     : 2018-02-13
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_TANKHWAMUL ('0403-M',1)
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKHWAMUL
( 
	IN_JEHWAMUL           VARCHAR(3),
	IN_JEHMNAME          VARCHAR(50)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
		JEGOTK AS TNTANKNO
		FROM TYSCMLIB.UTATKJGF
		WHERE JEHWAMUL = IN_JEHWAMUL
		AND JEHMNAME = IN_JEHMNAME;
		
	OPEN REFCURSOR;

END