--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_LIST ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_LIST ( 
	IN P_PBDCNTCODE VARCHAR(2),
	IN P_PBDLCODE VARCHAR(3),
	IN P_PBDMCODE VARCHAR(3),
	IN P_PBDSCODE VARCHAR(3),
	IN P_PBDNUM NUMERIC(3,0)
	) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_LIST 
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
			PBDLCODE,
			PBDMCODE,
			PBDSCODE,
			PBDNUM,
			PBDMOSEQ,
			PBDMOSABUN,
			KBHANGL,
			PBDMODESC,
			SUBSTR(PBDMODATE,1,4) || '-' || SUBSTR(PBDMODATE,5,2) || '-' || SUBSTR(PBDMODATE,7,2) AS PBDMODATE
			FROM PSSCMLIB.PSM_BOARD_DETAIL
			LEFT OUTER JOIN TYSCMLIB.INKIBNMF
			ON   KBSABUN = PBDMOSABUN
			WHERE PBDCNTCODE = P_PBDCNTCODE
			AND    PBDLCODE = P_PBDLCODE
			AND    PBDMCODE = P_PBDMCODE
			AND    PBDSCODE = P_PBDSCODE
			AND    PBDNUM = P_PBDNUM
			ORDER BY PBDMOSEQ DESC
			 ; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 