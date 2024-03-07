

DROP PROCEDURE PSSCMLIB.PSM_PSM1051_RISKCODE_VER_ADD;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1051_RISKCODE_VER_ADD ( 
	IN P_RSYEAR VARCHAR(4) , 
	IN P_RSUSDPMK VARCHAR(1) , 
	IN P_RSUSSDATE VARCHAR(8) , 
	IN P_RSUSEDATE VARCHAR(8) , 
	IN P_RSHISAB VARCHAR(6)) 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1051_RISKCODE_VER_ADD 
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
	P1 : BEGIN 

	DECLARE V_RSSEQ	NUMERIC ( 3, 0 ) ; 
	 
	SELECT VALUE(MAX(RSSEQ),0) + 1 INTO V_RSSEQ
	FROM PSSCMLIB.PSM_RISKCODE_VER
	WHERE RSYEAR = P_RSYEAR ;

	INSERT INTO PSSCMLIB.PSM_RISKCODE_VER
	(RSYEAR, 
	 RSSEQ, 
	 RSUSDPMK, 
	 RSUSSDATE, 
	 RSUSEDATE, 
	 RSHIGB, 
	 RSHIDAT, 
	 RSHITIM, 
	 RSHISAB)
	VALUES
	(P_RSYEAR,
	 V_RSSEQ,
	 P_RSUSDPMK,
	 P_RSUSSDATE,
	 P_RSUSEDATE,
	 'A',
	 CURRENT_DATE,
	 CURRENT_TIME, 
	 P_RSHISAB) ;

  
END P1  ; 
  