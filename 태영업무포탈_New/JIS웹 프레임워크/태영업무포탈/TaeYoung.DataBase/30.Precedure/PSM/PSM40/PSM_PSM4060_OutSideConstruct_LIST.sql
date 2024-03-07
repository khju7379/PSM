--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE PSSCMLIB.PSM_PSM4060_OutSideConstruct_LIST;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4060_OutSideConstruct_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 	
	IN P_SDATE VARCHAR(8),
	IN P_EDATE VARCHAR(8)	
	) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM4060_OutSideConstruct_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	CLOSQLCSR = *ENDMOD , 
	DECRESULT = (31, 31, 00) , 
	DFTRDBCOL = *NONE , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   

P1 : BEGIN  -- 시작 

	DECLARE P_STNUM INTEGER ; 
	DECLARE P_FNNUM INTEGER ; 	
  
PREV : BEGIN  -- 값 설정 
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
	END PREV ; 
  
MAIN : BEGIN  -- 실행부 
      LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR  -- 커서생성 

			WITH ORIGINAL_DATA AS (
			     SELECT  ROW_NUMBER() OVER(ORDER BY OSDATE, OSSEQ ) AS ROWNO,
						(OSDATE||'-'||DIGITS(OSSEQ)) AS OS_NUM,
						OSMETHODCODE,
					(SUBSTR(OSWKSDATE,1,4)||'-'||SUBSTR(OSWKSDATE,5,2)||'-'||SUBSTR(OSWKSDATE,7,2)||' ~ '||SUBSTR(OSWKEDATE,1,4)||'-'||SUBSTR(OSWKEDATE,5,2)||'-'||SUBSTR(OSWKEDATE,7,2)) OSWKDATE,
					OSCOMPANY,
					LCT1.FXC3DESC AS OSLOCATIONCODENM,
					L1.L3NAME AS OSAREACODENM,
					OSWKCLDATE,
					OSWKCLOSE,
					OSDATE,
					DIGITS(OSSEQ) AS OSSEQ,
					OSWKCLOSE AS CLOSE
				FROM PSSCMLIB.PSM_OutSideConstruct
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 AS LCT1
				ON   OSLOCATIONCODE1 = LCT1.FXC3SAUP||LCT1.FXC3BCODE||DIGITS(LCT1.FXC3MCODE)||DIGITS(LCT1.FXC3SCODE)
				LEFT OUTER JOIN PSSCMLIB.PSM_LOCATION_CLASS3 L1
				ON   L1.L3SAUP||L1.L3BCODE||DIGITS(L1.L3MCODE)||DIGITS(L1.L3SCODE) = OSAREACODE1
					LEFT OUTER JOIN (SELECT CAST(P_SDATE  AS VARCHAR(8)) AS SDATE, 
											CAST(P_EDATE  AS VARCHAR(8)) AS EDATE
								FROM SYSIBM.SYSDUMMY1) AS PAR
					ON 1 = 1
				WHERE OSDATE BETWEEN SDATE AND EDATE
			)
			SELECT	*
			FROM ORIGINAL_DATA
			WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
			ORDER BY ROWNO ASC ;

		OPEN REFCURSOR ;

	END LIST ;  

	PAGING : BEGIN  -- 페이징 
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR  -- 커서생성 
				
				SELECT  COUNT(*) AS TOTALCOUNT
				FROM PSSCMLIB.PSM_OutSideConstruct
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 AS LCT1
				ON   OSLOCATIONCODE1 = LCT1.FXC3SAUP||LCT1.FXC3BCODE||DIGITS(LCT1.FXC3MCODE)||DIGITS(LCT1.FXC3SCODE)
				LEFT OUTER JOIN PSSCMLIB.PSM_LOCATION_CLASS3 L1
				ON   L1.L3SAUP||L1.L3BCODE||DIGITS(L1.L3MCODE)||DIGITS(L1.L3SCODE) = OSAREACODE1
					LEFT OUTER JOIN (SELECT CAST(P_SDATE  AS VARCHAR(8)) AS SDATE, 
											CAST(P_EDATE  AS VARCHAR(8)) AS EDATE
								FROM SYSIBM.SYSDUMMY1) AS PAR
					ON 1 = 1
				WHERE OSDATE BETWEEN SDATE AND EDATE;

			OPEN REFCURSOR2 ; 
	END PAGING ; 
END MAIN ; 
END  ;
