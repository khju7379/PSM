DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_PRESS;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_PRESS
-- �ۼ���     : �̻���
-- �ۼ���     : 2018-06-25
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_PRESS ()
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_PRESS 
( 
	
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
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