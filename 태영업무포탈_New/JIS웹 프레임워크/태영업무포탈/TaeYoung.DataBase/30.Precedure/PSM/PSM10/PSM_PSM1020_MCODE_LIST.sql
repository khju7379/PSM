--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM1020_MCODE_LIST ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1020_MCODE_LIST ( 
	IN P_SAUP VARCHAR(1),
	IN P_LCODE VARCHAR(1),
	IN P_GUBUN VARCHAR(1)) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1020_MCODE_LIST 
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

			SELECT
			'' AS L2SAUP,
			'' AS L2BCODE,
			'' AS L2BCODENM,
			'' AS L2MCODE,
			'' AS L2NAME,
			'전체' AS L2CODENAME,
			'' AS L2BIGO
			FROM SYSIBM.SYSDUMMY1
			WHERE CASE WHEN P_GUBUN = '' THEN '1' ELSE '' END = CASE WHEN P_GUBUN = '' THEN '2' ELSE '' END

			UNION ALL
			 
			SELECT  L2SAUP   , 
				L2BCODE  , 
				L1NAME AS L2BCODENM,
				DIGITS(L2MCODE) AS L2MCODE,
				L2NAME,
				DIGITS(L2MCODE)||'-'||L2NAME   AS L2CODENAME, 
				L2BIGO    
			FROM PSSCMLIB.PSM_LOCATION_CLASS2
			LEFT OUTER JOIN PSSCMLIB.PSM_LOCATION_CLASS1
			      ON  L1SAUP   = L2SAUP
			    AND   L1CODE  = L2BCODE
			WHERE  L2SAUP =  P_SAUP
			   AND   L2BCODE = P_LCODE
			ORDER BY L2SAUP,L2BCODE, L2MCODE
			 ; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 