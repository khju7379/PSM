--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2031_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2031_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_MCDATE    VARCHAR(8),	
	IN P_MCHWAJU   VARCHAR(3),	
    IN P_MCHWAMUL   VARCHAR(3)	
	) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI2031_LIST 
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
				   WITH ORIGINAL_DATA AS 
							 (
							 SELECT  
									 ROW_NUMBER() OVER(ORDER BY MCDATE) AS ROWNO,     
									 (SUBSTR(CHAR(MCDATE),1,4)||'-'||SUBSTR(CHAR(MCDATE),5,2)||'-'||SUBSTR(CHAR(MCDATE),7,2)) AS MCDATE,
									 MCHWAJU,                       
									 MCHWAMUL,                      
									 (HMCODE.CDDESC1) AS HMCDDESC1, 
									 MCTANKNO,                      
									 MCREQGB,                       
									 MCENBOAMT,                     
									 (MCENIPAMT  +                  
									  MCENCHAMT  +                  
									  MCENISAMT  +                  
									  MCENCANAMT +                  
									  MCENDRAMT  +                  
									  MCENBOJAMT) AS HANDAMT,       
    									(MCENIPOVAM +                  
									  MCENCHOVAM) AS OVERTIMEAMT,   
									 (CASE WHEN MCREQGB = '1' THEN  
										   (MCENBUDUAM +            
											MCENTOJIAM +            
											MCENJILAMT +            
											MCENGAAMT  +            
											MCENCLEAMT +            
											MCENVOCAMT)             
										  WHEN MCREQGB = '2' THEN   
											(MCENBUDUAM/MCENRATE) +  
											(MCENTOJIAM/MCENRATE) +  
											(MCENJILQTY*MCENJILRAT/MCENRATE) +  
											(MCENGAAMT/MCENRATE)             +  
											(MCENCLEAMT/MCENRATE)            + 
											(MCENVOCAMT/MCENRATE)               
									 END) AS ETCAMT                             
							 FROM   TYSCMLIB.UTIMECHF                         
							 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE      
							   ON  HMCODE.CDINDEX = 'HM'                       
							  AND  HMCODE.CDCODE  = MCHWAMUL                   
							 WHERE  TRIM(CHAR(MCDATE))   =  P_MCDATE
							   AND  MCHWAJU  =  P_MCHWAJU
							   AND  MCHWAMUL =  P_MCHWAMUL
							)
							SELECT *
							 FROM ORIGINAL_DATA
							WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
							ORDER BY ROWNO ASC;
			OPEN REFCURSOR ;

		END LIST ; 
	  
		PAGING : BEGIN  -- 페이징 					

				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR				
				     WITH ORIGINAL_DATA AS 
							 (
							 SELECT  
									 ROW_NUMBER() OVER(ORDER BY MCDATE) AS ROWNO,     
									 (SUBSTR(CHAR(MCDATE),1,4)||'-'||SUBSTR(CHAR(MCDATE),5,2)||'-'||SUBSTR(CHAR(MCDATE),7,2)) AS MCDATE,
									 MCHWAJU,                       
									 MCHWAMUL,                      
									 (HMCODE.CDDESC1) AS HMCDDESC1, 
									 MCTANKNO,                      
									 MCREQGB,                       
									 MCENBOAMT,                     
									 (MCENIPAMT  +                  
									  MCENCHAMT  +                  
									  MCENISAMT  +                  
									  MCENCANAMT +                  
									  MCENDRAMT  +                  
									  MCENBOJAMT) AS HANDAMT,       
    									(MCENIPOVAM +                  
									  MCENCHOVAM) AS OVERTIMEAMT,   
									 (CASE WHEN MCREQGB = '1' THEN  
										   (MCENBUDUAM +            
											MCENTOJIAM +            
											MCENJILAMT +            
											MCENGAAMT  +            
											MCENCLEAMT +            
											MCENVOCAMT)             
										  WHEN MCREQGB = '2' THEN   
											(MCENBUDUAM/MCENRATE) +  
											(MCENTOJIAM/MCENRATE) +  
											(MCENJILQTY*MCENJILRAT/MCENRATE) +  
											(MCENGAAMT/MCENRATE)             +  
											(MCENCLEAMT/MCENRATE)            + 
											(MCENVOCAMT/MCENRATE)               
									 END) AS ETCAMT                             
							 FROM   TYSCMLIB.UTIMECHF                         
							 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE      
							   ON  HMCODE.CDINDEX = 'HM'                       
							  AND  HMCODE.CDCODE  = MCHWAMUL                   
							 WHERE  TRIM(CHAR(MCDATE))   =  P_MCDATE
							   AND  MCHWAJU  =  P_MCHWAJU
							   AND  MCHWAMUL =  P_MCHWAMUL
							)
							SELECT
							     COUNT(*) AS TOTALCOUNT
						    FROM ORIGINAL_DATA;					

				OPEN REFCURSOR2 ;

		END PAGING ; 	
	

END MAIN ; 
END  ;
