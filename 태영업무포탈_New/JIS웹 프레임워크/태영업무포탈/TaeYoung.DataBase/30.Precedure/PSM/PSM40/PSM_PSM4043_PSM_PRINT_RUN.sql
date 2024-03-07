--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM4043_PSM_PRINT_RUN ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4043_PSM_PRINT_RUN ( 
	IN P_PRSITE VARCHAR(2))
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	
	P1 : BEGIN  -- 시작 
MAIN : BEGIN  -- 실행부 
LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
			 
		SELECT
		PRNAME
		FROM PSSCMLIB.PSM_Print
		WHERE PRSITE = P_PRSITE
					 ; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 