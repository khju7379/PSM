--DROP PROCEDURE TYJINFWLIB.UTITANKF_GET_HWAJU;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTITANKF_GET_HWAJU
-- �ۼ���     : �̻���
-- �ۼ���     : 2023-05-31
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTITANKF_GET_HWAJU ()
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTITANKF_GET_HWAJU ( ) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.UTITANKF_GET_HWAJU 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	DECRESULT = (31, 31, 00) , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	P1 : BEGIN  -- ���� 
	DECLARE REFCURSOR CURSOR WITH RETURN FOR 
		 
		SELECT
			TNHWAJU || ':' || TNHWAJUNM AS NAME,
			TNHWAJU AS CODE
		FROM TYSCMLIB.UTITANKF
		WHERE TNHWAJU <> ''
		AND    TNHWAJUNM <> ''
		GROUP BY TNHWAJU, TNHWAJUNM
		ORDER BY TNHWAJU;
		 
	OPEN REFCURSOR ; 
  
END  ; 