DROP PROCEDURE PSSCMLIB.PSM_PSM1051_RISKCODE_COPY;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1051_RISKCODE_COPY ( 
	IN P_PREYEAR VARCHAR(4) , 
	IN P_PRESEQ VARCHAR (3) ,
	IN P_RSYEAR VARCHAR(4) , 
	IN P_RSUSDPMK VARCHAR(1) , 
	IN P_RSUSSDATE VARCHAR(8) , 
	IN P_RSUSEDATE VARCHAR(8) , 
	IN P_RSHISAB VARCHAR(6)) 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1051_RISKCODE_COPY 
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
	SELECT
		P_RSYEAR AS RSYEAR,
		V_RSSEQ AS RSSEQ,
		P_RSUSDPMK AS RSUSDPMK,
		P_RSUSSDATE AS RSUSSDATE,
		P_RSUSEDATE AS RSUSEDATE,
		RSHIGB,
		CURRENT_DATE AS RSHIDAT,
		CURRENT_TIME AS RSHITIM,
		P_RSHISAB AS RSHISAB
	FROM PSSCMLIB.PSM_RISKCODE_VER
	WHERE RSYEAR = P_PREYEAR
	AND    RSSEQ = P_PRESEQ ;

	INSERT INTO PSSCMLIB.PSM_RISKCODE_MASTER
	SELECT
		P_RSYEAR AS RMYEAR,
		V_RSSEQ AS RMSEQ,
		RMCODE,
		RMNAME,
		RMHIGB,
		CURRENT_DATE AS RMHIDAT,
		CURRENT_TIME AS RMHITIM,
		P_RSHISAB AS RMHISAB
	FROM PSSCMLIB.PSM_RISKCODE_MASTER
	WHERE RMYEAR = P_PREYEAR
	AND RMSEQ = P_PRESEQ ;

	INSERT INTO PSSCMLIB.PSM_RISKCODE_LIST
	SELECT
		P_RSYEAR AS RLYEAR,
		V_RSSEQ AS RLSEQ,
		RLCODE,
		RLITEMCODE,
		RLNAME,
		RLITEMNAME,
		RLRSINDEX0,
		RLRSINDEX1,
		RLRSINDEX2,
		RLRSINDEX3,
		RLHIGB,
		CURRENT_DATE AS RLHIDAT,
		CURRENT_TIME AS RLHITIM,
		P_RSHISAB AS RLHISAB
	FROM PSSCMLIB.PSM_RISKCODE_LIST
	WHERE RLYEAR = P_PREYEAR
	AND    RLSEQ = P_PRESEQ ;

  
END P1  ; 