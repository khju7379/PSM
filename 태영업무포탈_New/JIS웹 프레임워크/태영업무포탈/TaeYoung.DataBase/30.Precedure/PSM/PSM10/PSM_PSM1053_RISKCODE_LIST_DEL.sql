--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 14:26:26 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_DEL;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_DEL ( 
	IN P_RLYEAR VARCHAR(4), 
	IN P_RLSEQ VARCHAR(3),
	IN P_RLCODE VARCHAR(1),
	IN P_RLITEMCODE VARCHAR(1)) 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_DEL 
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
	 
  
		DELETE FROM PSSCMLIB.PSM_RISKCODE_LIST
		WHERE RLYEAR = P_RLYEAR
		AND RLSEQ = P_RLSEQ
		AND RLCODE = P_RLCODE
		AND RLITEMCODE = P_RLITEMCODE ;
  
END P1  ; 
  