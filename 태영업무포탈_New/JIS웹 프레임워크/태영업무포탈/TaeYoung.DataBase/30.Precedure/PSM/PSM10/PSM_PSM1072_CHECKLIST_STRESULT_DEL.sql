--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 14:26:26 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 

DROP PROCEDURE PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_DEL;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_DEL ( 
	IN P_CSTSBCODE VARCHAR(1), 
	IN P_CSTGRCODE VARCHAR(2),
	IN P_CSTGRSEQ VARCHAR(4),
	IN P_CSTITEMNUM VARCHAR(2),
	IN P_CSTSEQ VARCHAR(2)) 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_DEL 
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
	 
  
		DELETE FROM PSSCMLIB.PSM_CHECKLIST_STRESULT
		WHERE CSTSBCODE  = P_CSTSBCODE
		AND   CSTGRCODE  = P_CSTGRCODE 
		AND   CSTGRSEQ   = P_CSTGRSEQ 
		AND   CSTITEMNUM = P_CSTITEMNUM 
		AND   CSTSEQ     = P_CSTSEQ   ;
  
END P1  ; 