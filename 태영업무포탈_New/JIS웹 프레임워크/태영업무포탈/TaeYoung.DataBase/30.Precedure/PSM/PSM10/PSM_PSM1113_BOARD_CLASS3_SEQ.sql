--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM1113_BOARD_CLASS3_SEQ ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1113_BOARD_CLASS3_SEQ ( 
	IN P_PBC3NTCODE VARCHAR(2),
	IN P_PBC3LCODE VARCHAR(3),
	IN P_PBC2MCODE VARCHAR(3)) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1113_BOARD_CLASS3_SEQ 
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

			SELECT   VALUE(MAX(PBC3SCODE), 0) + 1 AS PBC3SCODE
			FROM PSSCMLIB.PSM_BOARD_CLASS3 
			WHERE PBC3NTCODE = P_PBC3NTCODE
			AND   PBC3LCODE   = P_PBC3LCODE
			AND   PBC3MCODE   = P_PBC2MCODE;
			
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 