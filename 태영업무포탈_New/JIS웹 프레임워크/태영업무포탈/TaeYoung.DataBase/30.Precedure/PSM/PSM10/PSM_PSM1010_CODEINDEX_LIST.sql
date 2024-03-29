--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE PSSCMLIB.PSM_PSM1010_CODEINDEX_LIST;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1010_CODEINDEX_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SEARCHCONDITION VARCHAR(4000) ) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1010_CODEINDEX_LIST 
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
	DECLARE P_SQLSTRING VARCHAR ( 4000 ) ; 
	DECLARE P_SQLTOTALROWCOUNT VARCHAR ( 4000 ) ; 
	DECLARE P_TABLE_QUERY			VARCHAR ( 4000 ) ; 
	DECLARE P_COUNT_QUERY			VARCHAR ( 4000 ) ; 
  
PREV : BEGIN  -- 값 설정 
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
	END PREV ; 
  
MAIN : BEGIN  -- 실행부 
      LIST : BEGIN  -- 리스트 
			DECLARE REFCURSOR INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR1 ;  -- 커서생성 
			SET P_TABLE_QUERY = '
							WITH ORIGINAL_DATA AS (  
								 SELECT ROW_NUMBER() OVER() AS ROWNO,
								 ''U'' AS CDSTATE,
								CDINDEX,
								CDCODE,
							    CDDESC1,
								CDDESC2,
								CDBIGO
					   FROM PSSCMLIB.PSM_CODEMF
								WHERE 1=1
									' || P_SEARCHCONDITION || '
							)               
							SELECT *
					FROM ORIGINAL_DATA
	  				WHERE ROWNO BETWEEN ' || CAST ( P_STNUM AS VARCHAR ( 100 ) ) || ' AND ' || CAST ( P_FNNUM AS VARCHAR ( 100 ) ) || '
	  				ORDER BY ROWNO ASC 
						' ; 
			PREPARE CUR1 FROM P_TABLE_QUERY ; 
			OPEN REFCURSOR ; 
			END LIST ; 
  
			PAGING : BEGIN  -- 페이징 
					DECLARE REFCURSOR2 INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR2 ;  -- 커서생성 
					SET P_COUNT_QUERY = '
									SELECT 
											COUNT(*) AS TOTALCOUNT  
										FROM PSSCMLIB.PSM_CODEMF
										WHERE 1=1
											' || P_SEARCHCONDITION || '
								' ; 
					PREPARE CUR2 FROM P_COUNT_QUERY ; 
					OPEN REFCURSOR2 ; 
			END PAGING ; 
END MAIN ; 
END  ;
