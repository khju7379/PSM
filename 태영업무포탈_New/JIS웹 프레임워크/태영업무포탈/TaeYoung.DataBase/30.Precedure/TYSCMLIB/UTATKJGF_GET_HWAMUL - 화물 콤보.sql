DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_HWAMUL;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_HWAMUL
-- �ۼ���     : ������
-- �ۼ���     : 2016-09-02
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_HWAMUL ()
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_HWAMUL 
( 

)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
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