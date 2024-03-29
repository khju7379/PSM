--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM1082_JSA_CLASS2_SEQ ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1082_JSA_CLASS2_SEQ ( 
	IN P_J2BCODE VARCHAR(2)) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1082_JSA_CLASS2_SEQ 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	DECRESULT = (31, 31, 00) , 
	DFTRDBCOL = *NONE , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 
MAIN : BEGIN  -- 실행부 
LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 

			SELECT   VALUE(MAX(J2MCODE), 0) + 1 AS J2MCODE
			FROM PSSCMLIB.PSM_JSA_CLASS2
			WHERE J2BCODE = P_J2BCODE;
			
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 