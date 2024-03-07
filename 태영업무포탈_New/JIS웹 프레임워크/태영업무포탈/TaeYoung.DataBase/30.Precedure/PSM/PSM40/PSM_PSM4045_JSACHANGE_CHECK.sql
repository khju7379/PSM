--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM4045_JSACHANGE_CHECK ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4045_JSACHANGE_CHECK ( 
	IN P_WOORTEAM VARCHAR(6), 
	IN P_WOORDATE VARCHAR(8),
	IN P_WOSEQ NUMERIC(3,0),
	IN P_SMWKORAPPDATE VARCHAR(8),
	IN P_WKGUBUN VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 

	P1 : BEGIN  -- 시작 
MAIN : BEGIN  -- 실행부 

	--IF P_WKGUBUN != 'D' THEN

		P2 : BEGIN  -- 작업요청 
			DECLARE REFCURSOR CURSOR WITH RETURN FOR 
				 
				SELECT
				*
				FROM PSSCMLIB.PSM_WORKORDER
				WHERE WOORTEAM = P_WOORTEAM
				AND    WOORDATE = P_WOORDATE
				AND    WOSEQ = P_WOSEQ
				AND    WOFINISHDATE <> ''
				AND    WOFINISHSABUN <> ''
				AND    WOFINISHTEXT <> '' ; 
	  
			OPEN REFCURSOR ; 
	  
		END P2 ; 

		P3 : BEGIN  -- 작업허가
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR 
				 
				SELECT
				*
				FROM PSSCMLIB.PSM_SafeOrder_MASTER
				WHERE SMWKTEAM = P_WOORTEAM
				AND    SMWKDATE = P_WOORDATE
				AND    SMWKSEQ = P_WOSEQ
				AND    SMWKORAPPDATE = P_SMWKORAPPDATE ; 
	  
			OPEN REFCURSOR2 ; 
	  
		END P3 ; 

	--END IF;
  
END MAIN ; 
END  ; 