--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1070_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1070_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE    VARCHAR(8),
	IN P_EDATE    VARCHAR(8),
    IN P_HWAJU    VARCHAR(50),
	IN P_GUBUN    VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI1070_LIST 
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
				  'A' AS GUBN,    
				  ROW_NUMBER() OVER() AS ROWNO,       
				 CHHWAMUL,                  
				 HMCODE.CDDESC1 AS HMDESC1, 
				 (SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL, 
				 (SUBSTR(CHAR(CHIPHANG),1,4)||'/'||SUBSTR(CHAR(CHIPHANG),5,2)||'/'||SUBSTR(CHAR(CHIPHANG),7,2)) AS CHIPHANG, 
				 VSCODE.CDDESC1 AS VSDESC1, 
				 VEND.VNSANGHO AS HJDESC1,  
				 CHBLNO,                    
				 TRIM(CHAR(CHMSNSEQ)) AS CHMSNSEQ,                  
				 TRIM(CHAR(CHHSNSEQ)) AS CHHSNSEQ,                  
				 TRIM(TO_CHAR(CHJUNG, '0.000')) AS CHJUNG,                    
				 TRIM(TO_CHAR(CHQTY, '9,990')) AS CHQTY,                                
				 CHMTQTY,                   
				 (SUBSTR(DIGITS(CHCHSTR),1,2)||':'||SUBSTR(DIGITS(CHCHSTR),3,2)||'~'||SUBSTR(DIGITS(CHCHEND),1,2)||':'||SUBSTR(DIGITS(CHCHEND),3,2)) AS CHCHTIME, 
				 DCCODE.CDDESC1 AS CHDESC1, 
				 (CHAR(CHCHULIL)||''||CHHWAMUL) AS GUBUN      
				 FROM TYSCMLIB.UTICHULF AS CHUL               
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE  
				 ON               'HM' = HMCODE.CDINDEX       
				 AND     CHUL.CHHWAMUL = HMCODE.CDCODE        
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE  
				 ON               'DC' = DCCODE.CDINDEX       
				 AND     CHUL.CHCHHJ   = DCCODE.CDCODE        
				 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				 ON      CHUL.CHHWAJU  = VEND.VNCODE          
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE  
				 ON               'VS' = VSCODE.CDINDEX       
				 AND     CHUL.CHBONSUN = VSCODE.CDCODE        
				 WHERE CHCHULIL BETWEEN P_SDATE AND P_EDATE
				 AND     CHUL.CHACTHJ IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
				 AND     CHUL.CHDANYI  = '2'                  
				 ORDER BY CHHWAMUL,CHCHULIL                   	
				), TABLE_HAP AS (
				SELECT
						  'B' AS GUBN,    
						   ROW_NUMBER() OVER( ORDER BY CHHWAMUL, CHCHULIL ) AS ROWNO,       
						   CHHWAMUL,                  
							'' AS HMDESC1, 
						   CHCHULIL, 
						   ''  AS CHIPHANG, 
						   ''  AS VSDESC1, 
						   ''  AS HJDESC1,  
						   '' AS  CHBLNO,                    
						  '' AS CHMSNSEQ,                  
						  '' AS CHHSNSEQ,                  
						  '' AS CHJUNG,                    
						  '' AS CHQTY,                     
						  SUM(CHMTQTY) AS CHMTQTY,                    
						  ''  AS CHCHTIME, 
						  ''  AS CHDESC1, 
						  ''  AS  GUBUN   
				FROM TABLE1
				GROUP BY CUBE( CHHWAMUL,CHCHULIL  )
				ORDER BY CHHWAMUL,CHCHULIL 
				) , TABLE_LIST AS (
				SELECT 
						   GUBN,    
						   ROWNO,       
						   CHHWAMUL,                  
						   HMDESC1, 
						   CHCHULIL, 
						   CHIPHANG, 
							VSDESC1, 
							HJDESC1,  
							 CHBLNO,                    
						   CHMSNSEQ,                  
						   CHHSNSEQ,                  
						   CHJUNG,                    
						   CHQTY,                     
						   CHMTQTY,                    
						   CHCHTIME, 
						   CHDESC1, 
						   GUBUN 
				FROM TABLE1 
				UNION ALL
				SELECT 
						   GUBN,    
						   ROWNO,       
						   CHHWAMUL,                  
						   HMDESC1, 
						   CHCHULIL, 
						   CHIPHANG, 
							VSDESC1, 
							HJDESC1,  
							 CHBLNO,                    
						   CHMSNSEQ,                  
						   CHHSNSEQ,                  
						   CHJUNG,                    
						   CHQTY,                     
						   CHMTQTY,                    
						   CHCHTIME, 
						   CHDESC1, 
						   GUBUN 
				FROM TABLE_HAP
				WHERE CHHWAMUL IS NOT NULL
				), ORIGINAL_DATA AS (
				SELECT  
						  ROW_NUMBER() OVER(ORDER BY CHHWAMUL, CHCHULIL) AS ROWNO, 
						  GUBN,    
							CHHWAMUL,                  
						   CASE WHEN GUBN = 'B' AND CHCHULIL != ''  THEN 
											  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >화물 소계</div>'
					WHEN GUBN = 'B' AND CHCHULIL IS NULL  THEN 
											  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >화물 누계</div>'
						   ELSE  HMDESC1 END AS  HMDESC1, 
						   CASE WHEN GUBN = 'A' THEN CHCHULIL ELSE '' END AS CHCHULIL,
						   CHIPHANG, 
							VSDESC1, 
							HJDESC1,  
							 CHBLNO,                    
							 CHMSNSEQ,
							CHHSNSEQ,						   
						   CHJUNG,						   
						   CHQTY,
						   CASE WHEN GUBN = 'B' AND CHCHULIL != ''  THEN  '<div style="text-align:right;width:70px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))|| '</div>'
									     WHEN GUBN = 'B' AND CHCHULIL IS NULL  THEN '<div style="text-align:right;width:70px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))||'</div>'												
						   ELSE TRIM(TO_CHAR(CHMTQTY, '9,999,990.000')) END AS  CHMTQTY, 						                 
						   CHCHTIME, 
						   CHDESC1, 
						   GUBUN 
				FROM TABLE_LIST
				WHERE ROWNO > 0
				ORDER BY  CHHWAMUL,  CHCHULIL, GUBN, ROWNO
				)
				SELECT  
						   ROWNO, 
						   GUBN,    
						   CHHWAMUL,                  
						   HMDESC1, 
						   CHCHULIL, 
						   CHIPHANG, 
							VSDESC1, 
							HJDESC1,  
							 CHBLNO,                    
						   CHMSNSEQ,                  
						   CHHSNSEQ,                  
						   CHJUNG,                    
						   CHQTY,                     
						   CHMTQTY,                    
						   CHCHTIME, 
						   CHDESC1, 
						   GUBUN 
				FROM ORIGINAL_DATA
				WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
				ORDER BY ROWNO ASC ;

			OPEN REFCURSOR ;

		END LIST ; 
	  
		PAGING : BEGIN  -- 페이징 					

				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR				
				WITH TABLE1 AS (
				 SELECT                    
				  'A' AS GUBN,    
				  ROW_NUMBER() OVER() AS ROWNO,       
				 CHHWAMUL,                  
				 HMCODE.CDDESC1 AS HMDESC1, 
				 (SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL, 
				 (SUBSTR(CHAR(CHIPHANG),1,4)||'/'||SUBSTR(CHAR(CHIPHANG),5,2)||'/'||SUBSTR(CHAR(CHIPHANG),7,2)) AS CHIPHANG, 
				 VSCODE.CDDESC1 AS VSDESC1, 
				 VEND.VNSANGHO AS HJDESC1,  
				 CHBLNO,                    
				 TRIM(CHAR(CHMSNSEQ)) AS CHMSNSEQ,                  
				 TRIM(CHAR(CHHSNSEQ)) AS CHHSNSEQ,                  
				 TRIM(TO_CHAR(CHJUNG, '0.000')) AS CHJUNG,                    
				 TRIM(TO_CHAR(CHQTY, '9,990')) AS CHQTY,                                             
				 CHMTQTY,                   
				 (SUBSTR(DIGITS(CHCHSTR),1,2)||':'||SUBSTR(DIGITS(CHCHSTR),3,2)||'~'||SUBSTR(DIGITS(CHCHEND),1,2)||':'||SUBSTR(DIGITS(CHCHEND),3,2)) AS CHCHTIME, 
				 DCCODE.CDDESC1 AS CHDESC1, 
				 (CHAR(CHCHULIL)||''||CHHWAMUL) AS GUBUN      
				 FROM TYSCMLIB.UTICHULF AS CHUL               
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE  
				 ON               'HM' = HMCODE.CDINDEX       
				 AND     CHUL.CHHWAMUL = HMCODE.CDCODE        
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE  
				 ON               'DC' = DCCODE.CDINDEX       
				 AND     CHUL.CHCHHJ   = DCCODE.CDCODE        
				 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				 ON      CHUL.CHHWAJU  = VEND.VNCODE          
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE  
				 ON               'VS' = VSCODE.CDINDEX       
				 AND     CHUL.CHBONSUN = VSCODE.CDCODE        
				 WHERE CHCHULIL BETWEEN P_SDATE AND P_EDATE
				 AND     CHUL.CHACTHJ IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
				 AND     CHUL.CHDANYI  = '2'                  
				 ORDER BY CHHWAMUL,CHCHULIL                   	
				), TABLE_HAP AS (
				SELECT
						  'B' AS GUBN,    
						   ROW_NUMBER() OVER( ORDER BY CHHWAMUL, CHCHULIL ) AS ROWNO,       
						   CHHWAMUL,                  
							'' AS HMDESC1, 
						   CHCHULIL, 
						   ''  AS CHIPHANG, 
						   ''  AS VSDESC1, 
						   ''  AS HJDESC1,  
						   '' AS  CHBLNO,                    
						  '' AS CHMSNSEQ,                  
						  '' AS CHHSNSEQ,                  
						  '' AS CHJUNG,                    
						  '' AS CHQTY,                     
						  SUM(CHMTQTY) AS CHMTQTY,                    
						  ''  AS CHCHTIME, 
						  ''  AS CHDESC1, 
						  ''  AS  GUBUN   
				FROM TABLE1
				GROUP BY CUBE( CHHWAMUL,CHCHULIL  )
				ORDER BY CHHWAMUL,CHCHULIL 
				) , TABLE_LIST AS (
				SELECT 
						   GUBN,    
						   ROWNO,       
						   CHHWAMUL,                  
						   HMDESC1, 
						   CHCHULIL, 
						   CHIPHANG, 
							VSDESC1, 
							HJDESC1,  
							 CHBLNO,                    
						   CHMSNSEQ,                  
						   CHHSNSEQ,                  
						   CHJUNG,                    
						   CHQTY,                     
						   CHMTQTY,                    
						   CHCHTIME, 
						   CHDESC1, 
						   GUBUN 
				FROM TABLE1 
				UNION ALL
				SELECT 
						   GUBN,    
						   ROWNO,       
						   CHHWAMUL,                  
						   HMDESC1, 
						   CHCHULIL, 
						   CHIPHANG, 
							VSDESC1, 
							HJDESC1,  
							 CHBLNO,                    
						   CHMSNSEQ,                  
						   CHHSNSEQ,                  
						   CHJUNG,                    
						   CHQTY,                     
						   CHMTQTY,                    
						   CHCHTIME, 
						   CHDESC1, 
						   GUBUN 
				FROM TABLE_HAP
				WHERE CHHWAMUL IS NOT NULL
				), ORIGINAL_DATA AS (
				SELECT  
						  ROW_NUMBER() OVER(ORDER BY CHHWAMUL, CHCHULIL) AS ROWNO, 
						  GUBN,    
							CHHWAMUL,                  
						   CASE WHEN GUBN = 'B' AND CHCHULIL != ''  THEN 
											  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >화물 소계</div>'
					WHEN GUBN = 'B' AND CHCHULIL IS NULL  THEN 
											  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >화물 누계</div>'
						   ELSE  HMDESC1 END AS  HMDESC1, 
						   CASE WHEN GUBN = 'A' THEN CHCHULIL ELSE '' END AS CHCHULIL,
						   CHIPHANG, 
							VSDESC1, 
							HJDESC1,  
						   CHBLNO,                    
						   CHMSNSEQ,
						   CHHSNSEQ,						   
						   CHJUNG,						   
						   CHQTY,
						   CASE WHEN GUBN = 'B' AND CHCHULIL != ''  THEN  '<div style="text-align:right;width:70px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))|| '</div>'
									     WHEN GUBN = 'B' AND CHCHULIL IS NULL  THEN '<div style="text-align:right;width:70px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))||'</div>'												
						   ELSE TRIM(TO_CHAR(CHMTQTY, '9,999,990.000')) END AS  CHMTQTY, 						                 
						   CHCHTIME, 
						   CHDESC1, 
						   GUBUN 
				FROM TABLE_LIST
				WHERE ROWNO > 0
				ORDER BY  CHHWAMUL,  CHCHULIL, GUBN, ROWNO
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
				  'A' AS GUBN,    
				  ROW_NUMBER() OVER() AS ROWNO,       
				 CHHWAMUL,                  
				 HMCODE.CDDESC1 AS HMDESC1, 
				 (SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL, 
				 (SUBSTR(CHAR(CHIPHANG),1,4)||'/'||SUBSTR(CHAR(CHIPHANG),5,2)||'/'||SUBSTR(CHAR(CHIPHANG),7,2)) AS CHIPHANG, 
				 VSCODE.CDDESC1 AS VSDESC1, 
				 VEND.VNSANGHO AS HJDESC1,  
				 CHBLNO,                    
				 TRIM(CHAR(CHMSNSEQ)) AS CHMSNSEQ,                  
				 TRIM(CHAR(CHHSNSEQ)) AS CHHSNSEQ,                  
				 TRIM(TO_CHAR(CHJUNG, '0.000')) AS CHJUNG,                    
				 TRIM(TO_CHAR(CHQTY, '9,990')) AS CHQTY,                                
				 CHMTQTY,                   
				 (SUBSTR(DIGITS(CHCHSTR),1,2)||':'||SUBSTR(DIGITS(CHCHSTR),3,2)||'~'||SUBSTR(DIGITS(CHCHEND),1,2)||':'||SUBSTR(DIGITS(CHCHEND),3,2)) AS CHCHTIME, 
				 DCCODE.CDDESC1 AS CHDESC1, 
				 (CHAR(CHCHULIL)||''||CHHWAMUL) AS GUBUN      
				 FROM TYSCMLIB.UTICHULF AS CHUL               
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE  
				 ON               'HM' = HMCODE.CDINDEX       
				 AND     CHUL.CHHWAMUL = HMCODE.CDCODE        
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE  
				 ON               'DC' = DCCODE.CDINDEX       
				 AND     CHUL.CHCHHJ   = DCCODE.CDCODE        
				 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				 ON      CHUL.CHHWAJU  = VEND.VNCODE          
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE  
				 ON               'VS' = VSCODE.CDINDEX       
				 AND     CHUL.CHBONSUN = VSCODE.CDCODE        
				 WHERE CHCHULIL BETWEEN P_SDATE AND P_EDATE
				 AND     CHUL.CHACTHJ IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
				 AND     CHUL.CHDANYI  = '2'                  
				 ORDER BY CHHWAMUL,CHCHULIL      ;                           

			OPEN REFCURSOR3 ;

		END PRINT;

	END IF;

END MAIN ; 
END  ;
