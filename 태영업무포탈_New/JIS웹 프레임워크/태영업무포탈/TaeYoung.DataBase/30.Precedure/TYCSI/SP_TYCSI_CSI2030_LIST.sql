--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2030_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2030_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_MDATE   VARCHAR(6),	
    IN P_HWAJU   VARCHAR(50)	
	) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI2030_LIST 
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
	DECLARE P_TABLE_QUERY			VARCHAR ( 5000 ) ; 
	DECLARE P_COUNT_QUERY			VARCHAR ( 5000 ) ; 
  
PREV : BEGIN  -- 값 설정 
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
	END PREV ; 
  
MAIN : BEGIN  -- 실행부 

      

	      LIST : BEGIN  -- 리스트 
			DECLARE REFCURSOR CURSOR WITH RETURN FOR
				   WITH TABLE1 AS 
						 (
						 SELECT       	 
								 (SUBSTR(CHAR(MCDATE),1,4)||'-'||SUBSTR(CHAR(MCDATE),5,2)||'-'||SUBSTR(CHAR(MCDATE),7,2)) AS MCDATE, 
								 MCHWAJU,     
								 MCHWAMUL,    
								 (HMCODE.CDDESC1) AS HMCDDESC1, 
							 SUM(MCENBOAMT  + 
								 MCENIPAMT  + 
								 MCENCHAMT  + 
								 MCENISAMT  + 
								 MCENCANAMT + 
								 MCENDRAMT  + 
								 MCENBOJAMT + 
								MCENIPOVAM + 
								 MCENCHOVAM + 
								 MCENBUDUAM + 
								 MCENTOJIAM + 
								 MCENJILAMT + 
								 MCENGAAMT  + 
								 MCENCLEAMT + 
								 MCENVOCAMT) AS MCHAP 
						 FROM   TYSCMLIB.UTIMECHF    
						 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
						   ON  HMCODE.CDINDEX = 'HM'                  
						  AND  HMCODE.CDCODE  = MCHWAMUL              
						 WHERE  SUBSTR(TRIM(CHAR(MCDATE)),1,6)  =  P_MDATE
						   AND  MCHWAJU IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
						  GROUP BY MCDATE, MCHWAJU, MCHWAMUL, CDDESC1 
						), ORIGINAL_DATA AS (
						SELECT  
								ROW_NUMBER() OVER(ORDER BY A.MCDATE, A.MCHWAMUL) AS ROWNO,
							A.MCDATE, 
							A.MCHWAJU,     
							A.MCHWAMUL,    
							A.HMCDDESC1, 
							A.MCHAP,
								 B.MCTANKNO,                      
							 B.MCREQGB,                       
							 B.MCENBOAMT,                     
							 (B.MCENIPAMT  +                  
							  B.MCENCHAMT  +                  
							  B.MCENISAMT  +                  
							  B.MCENCANAMT +                  
							  B.MCENDRAMT  +                  
							  B.MCENBOJAMT) AS HANDAMT,       
							(B.MCENIPOVAM + B.MCENCHOVAM) AS OVERTIMEAMT,   
							 (CASE WHEN B.MCREQGB = '1' THEN  
								   (B.MCENBUDUAM +            
									B.MCENTOJIAM +            
									B.MCENJILAMT +            
									B.MCENGAAMT  +            
									B.MCENCLEAMT +            
									B.MCENVOCAMT)             
								  WHEN B.MCREQGB = '2' THEN   
									(B.MCENBUDUAM/B.MCENRATE) +  
									(B.MCENTOJIAM/B.MCENRATE) +  
									(B.MCENJILQTY*B.MCENJILRAT/B.MCENRATE) +  
									(B.MCENGAAMT/B.MCENRATE)             +  
									(B.MCENCLEAMT/B.MCENRATE)            + 
									(B.MCENVOCAMT/B.MCENRATE)               
							 END) AS ETCAMT                     
						 FROM TABLE1 A
						 LEFT OUTER JOIN TYSCMLIB.UTIMECHF  AS B
							ON  TRIM(CHAR(B.MCDATE))   =  TRIM(REPLACE(A.MCDATE,'-',''))
						   AND  B.MCHWAJU  =  A.MCHWAJU
						   AND  B.MCHWAMUL =  A.MCHWAMUL
						)
						SELECT *
						 FROM ORIGINAL_DATA
						WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
						 ORDER BY ROWNO ASC;
			OPEN REFCURSOR ;

		END LIST ; 
	  
		PAGING : BEGIN  -- 페이징 					

				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR				
				      WITH TABLE1 AS 
						 (
						 SELECT       	 
								 (SUBSTR(CHAR(MCDATE),1,4)||'-'||SUBSTR(CHAR(MCDATE),5,2)||'-'||SUBSTR(CHAR(MCDATE),7,2)) AS MCDATE, 
								 MCHWAJU,     
								 MCHWAMUL,    
								 (HMCODE.CDDESC1) AS HMCDDESC1, 
							 SUM(MCENBOAMT  + 
								 MCENIPAMT  + 
								 MCENCHAMT  + 
								 MCENISAMT  + 
								 MCENCANAMT + 
								 MCENDRAMT  + 
								 MCENBOJAMT + 
								MCENIPOVAM + 
								 MCENCHOVAM + 
								 MCENBUDUAM + 
								 MCENTOJIAM + 
								 MCENJILAMT + 
								 MCENGAAMT  + 
								 MCENCLEAMT + 
								 MCENVOCAMT) AS MCHAP 
						 FROM   TYSCMLIB.UTIMECHF    
						 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
						   ON  HMCODE.CDINDEX = 'HM'                  
						  AND  HMCODE.CDCODE  = MCHWAMUL              
						 WHERE  SUBSTR(TRIM(CHAR(MCDATE)),1,6)  =  P_MDATE
						   AND  MCHWAJU IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
						  GROUP BY MCDATE, MCHWAJU, MCHWAMUL, CDDESC1 
						), ORIGINAL_DATA AS (
						SELECT  
								ROW_NUMBER() OVER(ORDER BY A.MCDATE, A.MCHWAMUL) AS ROWNO,
							A.MCDATE, 
							A.MCHWAJU,     
							A.MCHWAMUL,    
							A.HMCDDESC1, 
							A.MCHAP,
								 B.MCTANKNO,                      
							 B.MCREQGB,                       
							 B.MCENBOAMT,                     
							 (B.MCENIPAMT  +                  
							  B.MCENCHAMT  +                  
							  B.MCENISAMT  +                  
							  B.MCENCANAMT +                  
							  B.MCENDRAMT  +                  
							  B.MCENBOJAMT) AS HANDAMT,       
							(B.MCENIPOVAM + B.MCENCHOVAM) AS OVERTIMEAMT,   
							 (CASE WHEN B.MCREQGB = '1' THEN  
								   (B.MCENBUDUAM +            
									B.MCENTOJIAM +            
									B.MCENJILAMT +            
									B.MCENGAAMT  +            
									B.MCENCLEAMT +            
									B.MCENVOCAMT)             
								  WHEN B.MCREQGB = '2' THEN   
									(B.MCENBUDUAM/B.MCENRATE) +  
									(B.MCENTOJIAM/B.MCENRATE) +  
									(B.MCENJILQTY*B.MCENJILRAT/B.MCENRATE) +  
									(B.MCENGAAMT/B.MCENRATE)             +  
									(B.MCENCLEAMT/B.MCENRATE)            + 
									(B.MCENVOCAMT/B.MCENRATE)               
							 END) AS ETCAMT                     
						 FROM TABLE1 A
						 LEFT OUTER JOIN TYSCMLIB.UTIMECHF  AS B
							ON  TRIM(CHAR(B.MCDATE))   =  TRIM(REPLACE(A.MCDATE,'-',''))
						   AND  B.MCHWAJU  =  A.MCHWAJU
						   AND  B.MCHWAMUL =  A.MCHWAMUL
						)				
						SELECT
							COUNT(*) AS TOTALCOUNT
						FROM ORIGINAL_DATA;					

				OPEN REFCURSOR2 ;

		END PAGING ; 
		
	

END MAIN ; 
END  ;
