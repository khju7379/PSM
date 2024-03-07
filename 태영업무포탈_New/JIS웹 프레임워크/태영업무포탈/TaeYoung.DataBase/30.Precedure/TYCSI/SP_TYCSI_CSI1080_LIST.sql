--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1080_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1080_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
    IN P_HWAJU    VARCHAR(50),
	IN P_GUBUN    VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI1080_LIST 
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
				 DJHWAMUL,                  
				 HMCODE.CDDESC1 AS HMDESC1,  
				 (SUBSTR(CHAR(DJIPHANG),1,4)||'/'||SUBSTR(CHAR(DJIPHANG),5,2)||'/'||SUBSTR(CHAR(DJIPHANG),7,2)) AS DJIPHANG, 
				 VSCODE.CDDESC1 AS VSDESC1, 
				 DJBLNO,                    
				 TRIM(CHAR(DJMSNSEQ)) AS DJMSNSEQ,                  
				 TRIM(CHAR(DJHSNSEQ)) AS DJHSNSEQ,                  
				 TRIM(TO_CHAR(DJJUNG, '0.000')) AS DJJUNG,                    
				 DJPOQTY,                   
				 DJCHQTY,                   
				 DJJEQTY                    
				 FROM TYSCMLIB.UTIDRUJF AS DRUJ                 
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE    
				 ON               'HM'   = HMCODE.CDINDEX        
				 AND     DRUJ.DJHWAMUL   = HMCODE.CDCODE         
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE    
				 ON               'VS'   = VSCODE.CDINDEX        
				 AND     DRUJ.DJBONSUN   = VSCODE.CDCODE         
				 WHERE   DRUJ.DJACTHWAJU IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
				  AND    DRUJ.DJJEQTY   <> 0 				  
				 ORDER BY DJHWAMUL                           
				), TABLE_HAP AS (
				SELECT 
						'B' AS GUBN,    
						ROW_NUMBER() OVER( ORDER BY DJHWAMUL) AS ROWNO,       
						DJHWAMUL,                  
						'' AS  HMDESC1,  
						'' AS DJIPHANG, 
						'' AS VSDESC1, 
						'' AS DJBLNO,                    
						'' AS DJMSNSEQ,                  
						'' AS DJHSNSEQ,                  
						'' AS DJJUNG,                    
						VALUE(SUM(DJPOQTY),0) AS DJPOQTY,                   
						 VALUE(SUM(DJCHQTY),0)  AS DJCHQTY ,                   
						 VALUE(SUM(DJJEQTY),0) AS  DJJEQTY
				FROM TABLE1
				GROUP BY CUBE( DJHWAMUL  )
				ORDER BY  DJHWAMUL, DJIPHANG
				), TABLE_LIST AS (
				SELECT 
						GUBN,    
						ROWNO,       
						DJHWAMUL,                  
						 HMDESC1,  
						 DJIPHANG, 
						 VSDESC1, 
						 DJBLNO,                    
						 DJMSNSEQ,                  
						DJHSNSEQ,                  
						 DJJUNG,                    
						 DJPOQTY,                   
						 DJCHQTY ,                   
						 DJJEQTY
				FROM TABLE1
				UNION ALL
				SELECT 
						GUBN,    
						ROWNO,       
						DJHWAMUL,                  
						 HMDESC1,  
						 DJIPHANG, 
						 VSDESC1, 
						 DJBLNO,                    
						 DJMSNSEQ,                  
						DJHSNSEQ,                  
						 DJJUNG,                    
						 DJPOQTY,                   
						 DJCHQTY ,                   
						 DJJEQTY
				FROM TABLE_HAP
				), ORIGINAL_DATA AS (
				SELECT  ROW_NUMBER() OVER(ORDER BY DJHWAMUL, GUBN) AS ROWNO, 
						GUBN,    
						DJHWAMUL,                  
						CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN 
								 '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >화물 소계</div>'
							  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
								'<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >총 합 계</div>'
						 ELSE  HMDESC1 END AS  HMDESC1, 
						 DJIPHANG, 
						 VSDESC1, 
						 DJBLNO,                    
						 DJMSNSEQ,                  
						 DJHSNSEQ,                  
						 DJJUNG,                
						 CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN  
							'<div style="text-align:right;width:80px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(DJPOQTY, '9,999,990.000'))|| '</div>'
 						  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
							'<div style="text-align:right;width:80px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(DJPOQTY, '9,999,990.000'))||'</div>'												
						 ELSE TRIM(TO_CHAR(DJPOQTY, '9,999,990.000')) END AS  DJPOQTY,     
						 CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN  
							'<div style="text-align:right;width:80px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(DJCHQTY, '9,999,990.000'))|| '</div>'
 						  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
							'<div style="text-align:right;width:80px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(DJCHQTY, '9,999,990.000'))||'</div>'												
						 ELSE TRIM(TO_CHAR(DJCHQTY, '9,999,990.000')) END AS  DJCHQTY,     
						 CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN  
							'<div style="text-align:right;width:80px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(DJJEQTY, '9,999,990.000'))|| '</div>'
 						  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
							'<div style="text-align:right;width:80px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(DJJEQTY, '9,999,990.000'))||'</div>'												
						 ELSE TRIM(TO_CHAR(DJJEQTY, '9,999,990.000')) END AS  DJJEQTY
				FROM  TABLE_LIST
				WHERE ROWNO > 0
				ORDER BY  DJHWAMUL,  GUBN, ROWNO
				)
				SELECT  ROWNO,
					GUBN,                   
						DJHWAMUL,                  
						 HMDESC1,  
						 DJIPHANG, 
						 VSDESC1, 
						 DJBLNO,                    
						 DJMSNSEQ,                  
						DJHSNSEQ,                  
						 DJJUNG,                    
						 DJPOQTY,                   
						 DJCHQTY ,                   
						 DJJEQTY	
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
				 DJHWAMUL,                  
				 HMCODE.CDDESC1 AS HMDESC1,  
				 (SUBSTR(CHAR(DJIPHANG),1,4)||'/'||SUBSTR(CHAR(DJIPHANG),5,2)||'/'||SUBSTR(CHAR(DJIPHANG),7,2)) AS DJIPHANG, 
				 VSCODE.CDDESC1 AS VSDESC1, 
				 DJBLNO,                    
				 TRIM(CHAR(DJMSNSEQ)) AS DJMSNSEQ,                  
				 TRIM(CHAR(DJHSNSEQ)) AS DJHSNSEQ,                  
				 TRIM(TO_CHAR(DJJUNG, '0.000')) AS DJJUNG,                    
				 DJPOQTY,                   
				 DJCHQTY,                   
				 DJJEQTY                    
				 FROM TYSCMLIB.UTIDRUJF AS DRUJ                 
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE    
				 ON               'HM'   = HMCODE.CDINDEX        
				 AND     DRUJ.DJHWAMUL   = HMCODE.CDCODE         
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE    
				 ON               'VS'   = VSCODE.CDINDEX        
				 AND     DRUJ.DJBONSUN   = VSCODE.CDCODE         
				 WHERE   DRUJ.DJACTHWAJU IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
				  AND    DRUJ.DJJEQTY  <> 0 				  
				 ORDER BY DJHWAMUL                           
				), TABLE_HAP AS (
				SELECT 
						'B' AS GUBN,    
						ROW_NUMBER() OVER( ORDER BY DJHWAMUL) AS ROWNO,       
						DJHWAMUL,                  
						'' AS  HMDESC1,  
						'' AS DJIPHANG, 
						'' AS VSDESC1, 
						'' AS DJBLNO,                    
						'' AS DJMSNSEQ,                  
						'' AS DJHSNSEQ,                  
						'' AS DJJUNG,                    
						VALUE(SUM(DJPOQTY),0) AS DJPOQTY,                   
						 VALUE(SUM(DJCHQTY),0)  AS DJCHQTY ,                   
						 VALUE(SUM(DJJEQTY),0) AS  DJJEQTY
				FROM TABLE1
				GROUP BY CUBE( DJHWAMUL  )
				ORDER BY  DJHWAMUL, DJIPHANG
				), TABLE_LIST AS (
				SELECT 
						GUBN,    
						ROWNO,       
						DJHWAMUL,                  
						 HMDESC1,  
						 DJIPHANG, 
						 VSDESC1, 
						 DJBLNO,                    
						 DJMSNSEQ,                  
						DJHSNSEQ,                  
						 DJJUNG,                    
						 DJPOQTY,                   
						 DJCHQTY ,                   
						 DJJEQTY
				FROM TABLE1
				UNION ALL
				SELECT 
						GUBN,    
						ROWNO,       
						DJHWAMUL,                  
						 HMDESC1,  
						 DJIPHANG, 
						 VSDESC1, 
						 DJBLNO,                    
						 DJMSNSEQ,                  
						DJHSNSEQ,                  
						 DJJUNG,                    
						 DJPOQTY,                   
						 DJCHQTY ,                   
						 DJJEQTY
				FROM TABLE_HAP
				), ORIGINAL_DATA AS (
				SELECT  ROW_NUMBER() OVER(ORDER BY DJHWAMUL, GUBN) AS ROWNO, 
						GUBN,    
						DJHWAMUL,                  
						CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN 
								 '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >화물 소계</div>'
							  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
								'<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >총 합 계</div>'
						 ELSE  HMDESC1 END AS  HMDESC1, 
						 DJIPHANG, 
						 VSDESC1, 
						 DJBLNO,                    
						 DJMSNSEQ,                  
						 DJHSNSEQ,                  
						 DJJUNG,                
						 CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN  
							'<div style="text-align:right;width:70px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(DJPOQTY, '9,999,990.000'))|| '</div>'
 						  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
							'<div style="text-align:right;width:70px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(DJPOQTY, '9,999,990.000'))||'</div>'												
						 ELSE TRIM(TO_CHAR(DJPOQTY, '9,999,990.000')) END AS  DJPOQTY,     
						 CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN  
							'<div style="text-align:right;width:70px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(DJCHQTY, '9,999,990.000'))|| '</div>'
 						  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
							'<div style="text-align:right;width:70px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(DJCHQTY, '9,999,990.000'))||'</div>'												
						 ELSE TRIM(TO_CHAR(DJCHQTY, '9,999,990.000')) END AS  DJCHQTY,     
						 CASE WHEN GUBN = 'B' AND DJHWAMUL != ''  THEN  
							'<div style="text-align:right;width:70px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(DJJEQTY, '9,999,990.000'))|| '</div>'
 						  WHEN GUBN = 'B' AND DJHWAMUL IS NULL  THEN 
							'<div style="text-align:right;width:70px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(DJJEQTY, '9,999,990.000'))||'</div>'												
						 ELSE TRIM(TO_CHAR(DJJEQTY, '9,999,990.000')) END AS  DJJEQTY
				FROM  TABLE_LIST
				WHERE ROWNO > 0
				ORDER BY  DJHWAMUL,  GUBN, ROWNO
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
				 DJHWAMUL,                  
				 HMCODE.CDDESC1 AS HMDESC1,  
				 (SUBSTR(CHAR(DJIPHANG),1,4)||'/'||SUBSTR(CHAR(DJIPHANG),5,2)||'/'||SUBSTR(CHAR(DJIPHANG),7,2)) AS DJIPHANG, 
				 VSCODE.CDDESC1 AS VSDESC1, 
				 DJBLNO,                    
				 TRIM(CHAR(DJMSNSEQ)) AS DJMSNSEQ,                  
				 TRIM(CHAR(DJHSNSEQ)) AS DJHSNSEQ,                  
				 TRIM(TO_CHAR(DJJUNG, '0.000')) AS DJJUNG,                    
				 DJPOQTY,                   
				 DJCHQTY,                   
				 DJJEQTY                    
				 FROM TYSCMLIB.UTIDRUJF AS DRUJ                 
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE    
				 ON               'HM'   = HMCODE.CDINDEX        
				 AND     DRUJ.DJHWAMUL   = HMCODE.CDCODE         
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE    
				 ON               'VS'   = VSCODE.CDINDEX        
				 AND     DRUJ.DJBONSUN   = VSCODE.CDCODE         
				 WHERE   DRUJ.DJACTHWAJU IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
				  AND    DRUJ.DJJEQTY   <> 0 				  
				 ORDER BY DJHWAMUL   ;                            

			OPEN REFCURSOR3 ;

		END PRINT;

	END IF;

END MAIN ; 
END  ;
