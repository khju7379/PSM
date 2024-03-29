--DROP PROCEDURE PSSCMLIB.PSM_WORKORDER_FINISH_UPT;
  
CREATE PROCEDURE PSSCMLIB.PSM_WORKORDER_FINISH_UPT ( 
	IN P_WOFINISHDATE  VARCHAR(8),
	IN P_WOFINISHSABUN VARCHAR(6),
	IN P_WOFINISHTEXT  VARCHAR(200),
	IN P_WOORTEAM      VARCHAR(6),
	IN P_WOORDATE      VARCHAR(8),
	IN P_WOSEQ         NUMERIC(3,0))
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_WORKORDER_FINISH_UPT 
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

	UPDATE PSSCMLIB.PSM_WorkOrder SET
		WOFINISHDATE  = P_WOFINISHDATE,
		WOFINISHSABUN = P_WOFINISHSABUN,
		WOFINISHTEXT  = P_WOFINISHTEXT
	WHERE WOORTEAM = P_WOORTEAM
	AND   WOORDATE = P_WOORDATE
	AND   WOSEQ    = P_WOSEQ;

END P1;