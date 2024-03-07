--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1040_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1040_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE   VARCHAR(8),
	IN P_EDATE   VARCHAR(8),
        IN P_HWAJU   VARCHAR(50),
	IN P_GUBUN   VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI1040_LIST 
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

      IF P_GUBUN = 'S' THEN

	      LIST : BEGIN  -- 리스트 
			DECLARE REFCURSOR CURSOR WITH RETURN FOR
				WITH TABLE1 AS (
				SELECT         
				'A' AS GUBUN,
				ROW_NUMBER() OVER() AS ROWNO,                       
				SUBSTR(CSIPHANG,1,4) ||'/'|| SUBSTR(CSIPHANG,5,2) ||'/'|| SUBSTR(CSIPHANG,7,2) AS CSIPHANG,
				CSBONSUN,                                           
				VSCODE.CDDESC1 AS VSDESC1,                          
				VEND.VNSANGHO  AS HJDESC1,                          
				HMCODE.CDDESC1 AS HMDESC1,                          
				CSBLNO,                                             
				(DIGITS(CSMSNSEQ)||'-'||DIGITS(CSHSNSEQ)) AS MSHSNSEQ,
				(CHAR(CSCUSTIL)||'-'||DIGITS(CSCHASU)) AS CSCUSTIL, 
				CSCUQTY,                                            
				COALESCE(SUM(CHMTQTY),0) AS CHMTQTY,                
				COALESCE((CSCUQTY - SUM(CHMTQTY)),0) AS JEGOQTY,    
				CSSINNO,                                            
				(CHAR(CSIPHANG)||''||CSBONSUN) CSGUBUN                
				FROM TYSCMLIB.UTICUSTF AS CUST                     
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
				ON              'VS' = VSCODE.CDINDEX        
				AND    CUST.CSBONSUN = VSCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				ON     CUST.CSHWAJU  = VEND.VNCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
				ON              'HM' = HMCODE.CDINDEX        
				AND    CUST.CSHWAMUL = HMCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICHULF AS CHUL   
				ON     CUST.CSIPHANG = CHUL.CHIPHANG         
				AND    CUST.CSBONSUN = CHUL.CHBONSUN         
				AND    CUST.CSHWAJU  = CHUL.CHHWAJU          
				AND    CUST.CSHWAMUL = CHUL.CHHWAMUL         
				AND    CUST.CSBLNO   = CHUL.CHBLNO           
				AND    CUST.CSMSNSEQ = CHUL.CHMSNSEQ         
				AND    CUST.CSHSNSEQ = CHUL.CHHSNSEQ         
				AND    CUST.CSCUSTIL = CHUL.CHCUSTIL         
				AND    CUST.CSCHASU  = CHUL.CHCHASU          
				WHERE CSCUSTIL BETWEEN  P_SDATE AND P_EDATE
				AND   CUST.CSACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				GROUP BY CSIPHANG,CSBONSUN,VSCODE.CDDESC1,VEND.VNSANGHO,                
					 HMCODE.CDDESC1,CSBLNO,CSMSNSEQ,CSHSNSEQ,CSCUSTIL,CSCHASU,CSCUQTY,CSSINNO 
				ORDER BY CSIPHANG, CSBONSUN
				), TABLE_HAP AS (
				SELECT
					'B' AS GUBUN,    					
					ROW_NUMBER() OVER( ORDER BY CSGUBUN) AS ROWNO,      
					'' AS CSIPHANG,                                           
					'' AS CSBONSUN,                                           
					'' AS VSDESC1,                          
					'' AS HJDESC1,                          
					'' AS HMDESC1,                          
					'' AS CSBLNO,                                             
					'' AS MSHSNSEQ,
					'' AS CSCUSTIL, 
					SUM(CSCUQTY) AS CSCUQTY,  
					SUM(CHMTQTY) AS CHMTQTY,                
					SUM(JEGOQTY) AS JEGOQTY,    
					'' AS CSSINNO,                                            
					CSGUBUN          
				FROM TABLE1
				GROUP BY CSGUBUN
				), TABLE_LIST AS (
				SELECT
					GUBUN,    					
					ROWNO,      
					CSIPHANG,                                           
					CSBONSUN,                                           
					VSDESC1,                          
					HJDESC1,                          
					HMDESC1,                          
					CSBLNO,                                             
					MSHSNSEQ,
					CSCUSTIL, 
					CSCUQTY,  
					CHMTQTY,                
					JEGOQTY,    
					CSSINNO,                                            
					CSGUBUN         
				FROM TABLE1
				UNION ALL
				SELECT
					GUBUN,    					
					ROWNO,      
					CSIPHANG,                                           
					CSBONSUN,                                           
					VSDESC1,                          
					HJDESC1,                          
					HMDESC1,                          
					CSBLNO,                                             
					MSHSNSEQ,
					CSCUSTIL, 
					CSCUQTY,  
					CHMTQTY,                
					JEGOQTY,    
					CSSINNO,                                            
					CSGUBUN         
				FROM TABLE_HAP
				UNION ALL
				SELECT
					'C' AS GUBUN,    					
					9999 AS ROWNO,      
					'' AS CSIPHANG,                                           
					'' AS CSBONSUN,                                           
					'' AS VSDESC1,                          
					'' AS HJDESC1,                          
					'' AS HMDESC1,                          
					'' AS CSBLNO,                                             
					'' AS MSHSNSEQ,
					'' AS CSCUSTIL, 
					SUM(CSCUQTY) AS CSCUQTY,  
					SUM(CHMTQTY) AS CHMTQTY,                
					SUM(JEGOQTY) AS JEGOQTY,    
					'' AS CSSINNO,                                            
					'9999999' AS CSGUBUN         
				FROM TABLE_HAP
				), ORIGINAL_DATA AS  (
				SELECT
					GUBUN,    					
					ROW_NUMBER() OVER(ORDER BY CSGUBUN, GUBUN, ROWNO) AS ROWNO,     
					CSIPHANG,    
					CSBONSUN,                                       
					CASE WHEN GUBUN = 'B' THEN '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >통관소계</div>' 
					WHEN GUBUN = 'C' THEN '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >총합계</div>' 
					ELSE VSDESC1 END AS VSDESC1,                                           					
					HJDESC1,                          
					HMDESC1,                          
					CSBLNO,                                             
					MSHSNSEQ,
					CSCUSTIL, 
					CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CSCUQTY, '9,999,990.000'))|| '</div>' 
					WHEN GUBUN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CSCUQTY, '9,999,990.000'))||'</div>'
					ELSE TRIM(TO_CHAR(CSCUQTY, '9,999,990.000')) END AS CSCUQTY, 
					CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))|| '</div>' 
					WHEN GUBUN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))||'</div>'
					ELSE TRIM(TO_CHAR(CHMTQTY, '9,999,990.000')) END AS CHMTQTY, 
					CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(JEGOQTY, '9,999,990.000'))|| '</div>' 
					WHEN GUBUN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(JEGOQTY, '9,999,990.000'))||'</div>'
					ELSE TRIM(TO_CHAR(JEGOQTY, '9,999,990.000')) END AS JEGOQTY, 
					CSSINNO,                                            
					CSGUBUN         
				FROM TABLE_LIST
				ORDER BY CSGUBUN, GUBUN, ROWNO
				)
				SELECT
					GUBUN,    					
					ROWNO,      
					CSIPHANG,                                           
					CSBONSUN,                                           
					VSDESC1,                          
					HJDESC1,                          
					HMDESC1,                          
					CSBLNO,                                             
					MSHSNSEQ,
					CSCUSTIL, 
					CSCUQTY,  
					CHMTQTY,                
					JEGOQTY,    
					CSSINNO,                                            
					CSGUBUN         
				FROM ORIGINAL_DATA
				WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
				ORDER BY ROWNO ASC;


			OPEN REFCURSOR ;

		END LIST ; 
	  
		PAGING : BEGIN  -- 페이징 					

				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR				
				WITH TABLE1 AS (
				SELECT         
				'A' AS GUBUN,
				ROW_NUMBER() OVER() AS ROWNO,                       
				SUBSTR(CSIPHANG,1,4) ||'/'|| SUBSTR(CSIPHANG,5,2) ||'/'|| SUBSTR(CSIPHANG,7,2) AS CSIPHANG,
				CSBONSUN,                                           
				VSCODE.CDDESC1 AS VSDESC1,                          
				VEND.VNSANGHO  AS HJDESC1,                          
				HMCODE.CDDESC1 AS HMDESC1,                          
				CSBLNO,                                             
				(DIGITS(CSMSNSEQ)||'-'||DIGITS(CSHSNSEQ)) AS MSHSNSEQ,
				(CHAR(CSCUSTIL)||'-'||DIGITS(CSCHASU)) AS CSCUSTIL, 
				CSCUQTY,                                            
				COALESCE(SUM(CHMTQTY),0) AS CHMTQTY,                
				COALESCE((CSCUQTY - SUM(CHMTQTY)),0) AS JEGOQTY,    
				CSSINNO,                                            
				(CHAR(CSIPHANG)||''||CSBONSUN) CSGUBUN                
				FROM TYSCMLIB.UTICUSTF AS CUST                     
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
				ON              'VS' = VSCODE.CDINDEX        
				AND    CUST.CSBONSUN = VSCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				ON     CUST.CSHWAJU  = VEND.VNCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
				ON              'HM' = HMCODE.CDINDEX        
				AND    CUST.CSHWAMUL = HMCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICHULF AS CHUL   
				ON     CUST.CSIPHANG = CHUL.CHIPHANG         
				AND    CUST.CSBONSUN = CHUL.CHBONSUN         
				AND    CUST.CSHWAJU  = CHUL.CHHWAJU          
				AND    CUST.CSHWAMUL = CHUL.CHHWAMUL         
				AND    CUST.CSBLNO   = CHUL.CHBLNO           
				AND    CUST.CSMSNSEQ = CHUL.CHMSNSEQ         
				AND    CUST.CSHSNSEQ = CHUL.CHHSNSEQ         
				AND    CUST.CSCUSTIL = CHUL.CHCUSTIL         
				AND    CUST.CSCHASU  = CHUL.CHCHASU          
				WHERE CSCUSTIL BETWEEN  P_SDATE AND P_EDATE
				AND   CUST.CSACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				GROUP BY CSIPHANG,CSBONSUN,VSCODE.CDDESC1,VEND.VNSANGHO,                
					 HMCODE.CDDESC1,CSBLNO,CSMSNSEQ,CSHSNSEQ,CSCUSTIL,CSCHASU,CSCUQTY,CSSINNO 
				ORDER BY CSIPHANG, CSBONSUN
				), TABLE_HAP AS (
				SELECT
					'B' AS GUBUN,    					
					ROW_NUMBER() OVER( ORDER BY CSGUBUN) AS ROWNO,      
					'' AS CSIPHANG,                                           
					'' AS CSBONSUN,                                           
					'' AS VSDESC1,                          
					'' AS HJDESC1,                          
					'' AS HMDESC1,                          
					'' AS CSBLNO,                                             
					'' AS MSHSNSEQ,
					'' AS CSCUSTIL, 
					SUM(CSCUQTY) AS CSCUQTY,  
					SUM(CHMTQTY) AS CHMTQTY,                
					SUM(JEGOQTY) AS JEGOQTY,    
					'' AS CSSINNO,                                            
					CSGUBUN          
				FROM TABLE1
				GROUP BY CSGUBUN
				), TABLE_LIST AS (
				SELECT
					GUBUN,    					
					ROWNO,      
					CSIPHANG,                                           
					CSBONSUN,                                           
					VSDESC1,                          
					HJDESC1,                          
					HMDESC1,                          
					CSBLNO,                                             
					MSHSNSEQ,
					CSCUSTIL, 
					CSCUQTY,  
					CHMTQTY,                
					JEGOQTY,    
					CSSINNO,                                            
					CSGUBUN         
				FROM TABLE1
				UNION ALL
				SELECT
					GUBUN,    					
					ROWNO,      
					CSIPHANG,                                           
					CSBONSUN,                                           
					VSDESC1,                          
					HJDESC1,                          
					HMDESC1,                          
					CSBLNO,                                             
					MSHSNSEQ,
					CSCUSTIL, 
					CSCUQTY,  
					CHMTQTY,                
					JEGOQTY,    
					CSSINNO,                                            
					CSGUBUN         
				FROM TABLE_HAP
				UNION ALL
				SELECT
					'C' AS GUBUN,    					
					9999 AS ROWNO,      
					'' AS CSIPHANG,                                           
					'' AS CSBONSUN,                                           
					'' AS VSDESC1,                          
					'' AS HJDESC1,                          
					'' AS HMDESC1,                          
					'' AS CSBLNO,                                             
					'' AS MSHSNSEQ,
					'' AS CSCUSTIL, 
					SUM(CSCUQTY) AS CSCUQTY,  
					SUM(CHMTQTY) AS CHMTQTY,                
					SUM(JEGOQTY) AS JEGOQTY,    
					'' AS CSSINNO,                                            
					'' AS CSGUBUN         
				FROM TABLE_HAP
				), ORIGINAL_DATA AS  (
				SELECT
					GUBUN,    					
					ROW_NUMBER() OVER(ORDER BY CSGUBUN, GUBUN, ROWNO) AS ROWNO,     
					CSIPHANG,                                           
					CASE WHEN GUBUN = 'B' THEN '통관소계' 
					WHEN GUBUN = 'C' THEN '총합계' 
					ELSE CSBONSUN END AS CSBONSUN,                                           
					VSDESC1,                          
					HJDESC1,                          
					HMDESC1,                          
					CSBLNO,                                             
					MSHSNSEQ,
					CSCUSTIL, 
					CSCUQTY, 
					CHMTQTY, 
					JEGOQTY, 
					CSSINNO,                                            
					CSGUBUN         
				FROM TABLE_LIST
				ORDER BY CSGUBUN, GUBUN, ROWNO
				)
				SELECT
					COUNT(*) AS TOTALCOUNT
				FROM ORIGINAL_DATA;
					

				OPEN REFCURSOR2 ;

		END PAGING ; 

	ELSE
		PRINT : BEGIN  -- 출력 

			DECLARE REFCURSOR3 CURSOR WITH RETURN FOR

				SELECT         
				'A' AS GUBUN,
				ROW_NUMBER() OVER() AS ROWNO,                       
				SUBSTR(CSIPHANG,1,4) ||'/'|| SUBSTR(CSIPHANG,5,2) ||'/'|| SUBSTR(CSIPHANG,7,2) AS CSIPHANG,
				CSBONSUN,                                           
				VSCODE.CDDESC1 AS VSDESC1,                          
				VEND.VNSANGHO  AS HJDESC1,                          
				HMCODE.CDDESC1 AS HMDESC1,                          
				CSBLNO,                                             
				(DIGITS(CSMSNSEQ)||'-'||DIGITS(CSHSNSEQ)) AS MSHSNSEQ,
				(CHAR(CSCUSTIL)||'-'||DIGITS(CSCHASU)) AS CSCUSTIL, 
				CSCUQTY,                                            
				COALESCE(SUM(CHMTQTY),0) AS CHMTQTY,                
				COALESCE((CSCUQTY - SUM(CHMTQTY)),0) AS JEGOQTY,    
				CSSINNO,                                            
				(CHAR(CSIPHANG)||''||CSBONSUN) CSGUBUN                
				FROM TYSCMLIB.UTICUSTF AS CUST                     
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
				ON              'VS' = VSCODE.CDINDEX        
				AND    CUST.CSBONSUN = VSCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				ON     CUST.CSHWAJU  = VEND.VNCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
				ON              'HM' = HMCODE.CDINDEX        
				AND    CUST.CSHWAMUL = HMCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICHULF AS CHUL   
				ON     CUST.CSIPHANG = CHUL.CHIPHANG         
				AND    CUST.CSBONSUN = CHUL.CHBONSUN         
				AND    CUST.CSHWAJU  = CHUL.CHHWAJU          
				AND    CUST.CSHWAMUL = CHUL.CHHWAMUL         
				AND    CUST.CSBLNO   = CHUL.CHBLNO           
				AND    CUST.CSMSNSEQ = CHUL.CHMSNSEQ         
				AND    CUST.CSHSNSEQ = CHUL.CHHSNSEQ         
				AND    CUST.CSCUSTIL = CHUL.CHCUSTIL         
				AND    CUST.CSCHASU  = CHUL.CHCHASU          
				WHERE CSCUSTIL BETWEEN  P_SDATE AND P_EDATE
				AND   CUST.CSACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				GROUP BY CSIPHANG,CSBONSUN,VSCODE.CDDESC1,VEND.VNSANGHO,                
					 HMCODE.CDDESC1,CSBLNO,CSMSNSEQ,CSHSNSEQ,CSCUSTIL,CSCHASU,CSCUQTY,CSSINNO 
				ORDER BY CSIPHANG, CSBONSUN;                            

			OPEN REFCURSOR3 ;

		END PRINT;

	END IF;

END MAIN ; 
END  ;
