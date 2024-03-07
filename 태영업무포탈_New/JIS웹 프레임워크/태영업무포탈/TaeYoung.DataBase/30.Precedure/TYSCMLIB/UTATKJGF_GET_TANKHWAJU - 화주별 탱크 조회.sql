--DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKHWAJU;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : UTATKJGF_GET_TANKHWAJU
-- �ۼ���     : �̻���
-- �ۼ���     : 2018-02-13
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.UTATKJGF_GET_TANKHWAJU ('CRU','(��)�ڷ���')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANKHWAJU ( 
	IN IN_JEHWAJU VARCHAR(3) , 
	IN IN_JEHJNAME VARCHAR(50) ) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.UTATKJGF_GET_TANKHWAJU 
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
		TNTANKNO 
		FROM TYSCMLIB . UTITANKF 
		WHERE TNHWAJU = IN_JEHWAJU 
		AND TNTANKNO NOT IN ( '5007' , '9001' , '9002' ) 
		; 
		 
	OPEN REFCURSOR ; 
  
END  ; 