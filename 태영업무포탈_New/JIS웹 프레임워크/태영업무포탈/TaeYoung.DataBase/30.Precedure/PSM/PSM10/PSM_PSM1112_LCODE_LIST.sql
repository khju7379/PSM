--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM1112_LCODE_LIST ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1112_LCODE_LIST ( 
	IN P_PBC1NTCODE VARCHAR(2) ,
	IN P_GUBUN VARCHAR(1))
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1112_LCODE_LIST 
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
			'' AS PBC1LCODE,
			'' AS PBC1LCODENM,
			'전체' AS PBC1LCODENAME
			FROM SYSIBM.SYSDUMMY1
			WHERE CASE WHEN P_GUBUN = '' THEN '1' ELSE '' END = CASE WHEN P_GUBUN = '' THEN '2' ELSE '' END

			UNION ALL

			SELECT PBC1LCODE,
			       PBC1NAME as PBC1LCODENM,			       
			       PBC1LCODE||'-'||PBC1NAME as PBC1LCODENAME
			FROM  PSSCMLIB.PSM_BOARD_CLASS1			
			WHERE PBC1NTCODE = P_PBC1NTCODE
			ORDER BY PBC1LCODE ; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 