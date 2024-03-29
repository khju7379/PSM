--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM1021_SAFEORDER_CHECK ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1021_SAFEORDER_CHECK ( 
	IN P_L3SAUP VARCHAR(1), 
	IN P_L3BCODE VARCHAR(1),
	IN P_L3MCODE VARCHAR(4),
	IN P_L3SCODE VARCHAR(3)) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1021_SAFEORDER_CHECK 
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
			 
			SELECT  COUNT(*) AS CNT
			FROM PSSCMLIB.PSM_SafeOrder_MASTER
			 LEFT OUTER JOIN (SELECT CAST(P_L3SAUP||P_L3BCODE||P_L3MCODE||P_L3SCODE AS VARCHAR(9))  AS AREACODE    FROM SYSIBM.SYSDUMMY1) AS PAR
				 ON 1 = 1
			WHERE (SMAREACODE1 = PAR.AREACODE OR SMAREACODE2 = PAR.AREACODE OR SMAREACODE3 = PAR.AREACODE OR SMAREACODE4 = PAR.AREACODE OR SMAREACODE5 = PAR.AREACODE) ; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 