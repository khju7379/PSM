--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1090_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1090_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE     VARCHAR(8),
	IN P_EDATE     VARCHAR(8),
    IN P_HWAJU     VARCHAR(50),
	IN P_HWAMUL    VARCHAR(3),
	IN P_JGCHECK   VARCHAR(3),
	IN P_GUBUN     VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI1090_LIST 
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
					 IPIPHANG, 
					 IPBONSUN, 
					 VSCODE.CDDESC1 AS VSDESC1, 
					 IPHWAJU,  
					 IPBLNO,   
					 IPHWAMUL, 
					 HMCODE.CDDESC1 AS HMDESC1, 
					 IPBSQTY,  
					 IPMTQTY,  
					 IPPAQTY,  
					 (IPMTQTY - IPPAQTY) AS REIPPAQTY,
					 (  SELECT  VALUE(SUM(CHMTQTY),0) AS CHMTQTY 
					 FROM TYSCMLIB.UTICHULF          
					 WHERE CHIPHANG =  IPIPHANG
					 AND   CHBONSUN =  IPBONSUN
					 AND   CHHWAJU  =  IPHWAJU
					 AND   CHHWAMUL =   IPHWAMUL
					 AND   CHBLNO   =  IPBLNO ) AS CHMTQTY
					 FROM TYSCMLIB.UTIIPGOF AS IPGO  
					 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
					 ON              'VS' = VSCODE.CDINDEX        
					 AND    IPGO.IPBONSUN = VSCODE.CDCODE         
					 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
					 ON              'HM' = HMCODE.CDINDEX        
					 AND    IPGO.IPHWAMUL = HMCODE.CDCODE         
					 WHERE IPHWAJU  IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
					 AND   IPIPHANG BETWEEN P_SDATE AND P_EDATE
					 AND   IPHWAMUL LIKE P_HWAMUL||'%'
					 ORDER BY IPIPHANG, IPBONSUN, IPHWAMUL, IPBLNO 
					) , TABLE2 AS (
					  SELECT   CHCHULIL, CHIPHANG, CHBONSUN, CHHWAJU, CHHWAMUL, CHBLNO,
								  SUM(CHUL.CHMTQTY) AS CHMTQTY 
					 FROM TYSCMLIB.UTICHULF AS CHUL 
					 LEFT OUTER JOIN TABLE1
					   ON   1 = 1
					 WHERE CHIPHANG =  IPIPHANG
					 AND   CHBONSUN =  IPBONSUN
					 AND   CHHWAJU  =  IPHWAJU
					 AND   CHHWAMUL =  IPHWAMUL
					 AND   CHBLNO   =  IPBLNO
					 GROUP BY CHCHULIL, CHIPHANG, CHBONSUN, CHHWAJU, CHHWAMUL,CHBLNO
					 ORDER BY CHCHULIL                 
					), TABLE_LIST AS (
					SELECT     ROW_NUMBER() OVER(partition by IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO ORDER BY IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO, CHCHULIL ) AS COLNO,     
					           IPIPHANG, 
								IPBONSUN, 
								VSDESC1, 
								IPHWAJU,  
								IPBLNO,   
								IPHWAMUL, 
								HMDESC1, 
								IPBSQTY,  
								IPMTQTY,  
								IPPAQTY,  
								REIPPAQTY,
								A.CHMTQTY ,
								CASE   WHEN A.CHMTQTY <= 0 THEN 
												   'ALL'
										   WHEN   A.IPMTQTY - A.CHMTQTY > 0 THEN 
												'Y'
								   WHEN   A.IPMTQTY - A.CHMTQTY <= 0 THEN 
												  'N'
								ELSE 'ALL' END AS JEGOCHECK,
								 B.CHCHULIL,
								VALUE(B.CHMTQTY,0) AS CHULQTY,
								(A.IPMTQTY -  
								( SELECT   VALUE(SUM(C.CHMTQTY),0)
									FROM TABLE2 C
									WHERE   C.CHIPHANG =  A.IPIPHANG
									   AND   C.CHBONSUN =  A.IPBONSUN
										AND   C.CHHWAJU  =  A.IPHWAJU
										AND   C.CHHWAMUL =  A.IPHWAMUL
										AND   C.CHBLNO   =  A.IPBLNO
										AND  C.CHCHULIL <= B.CHCHULIL ) ) AS JEGOQTY,
								(A.IPPAQTY -  
								( SELECT   VALUE(SUM(C.CHMTQTY),0)
									FROM TABLE2 C
									WHERE   C.CHIPHANG =  A.IPIPHANG
									   AND   C.CHBONSUN =  A.IPBONSUN
										AND   C.CHHWAJU  =  A.IPHWAJU
										AND   C.CHHWAMUL =  A.IPHWAMUL
										AND   C.CHBLNO   =  A.IPBLNO
										AND  C.CHCHULIL <= B.CHCHULIL ) ) AS TONGJEGOQTY
					FROM TABLE1 A
					LEFT OUTER JOIN TABLE2  B
					  ON     B.CHIPHANG =  A.IPIPHANG
					 AND   B.CHBONSUN =  A.IPBONSUN
					 AND   B.CHHWAJU  =  A.IPHWAJU
					 AND   B.CHHWAMUL =  A.IPHWAMUL
					 AND   B.CHBLNO   =  A.IPBLNO
					), ORIGINAL_DATA AS (
					SELECT      ROW_NUMBER() OVER(ORDER BY IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO, COLNO ) AS ROWNO,   
					            COLNO, 
								CASE WHEN COLNO = 1 THEN 
									(SUBSTR(CHAR(IPIPHANG),1,4)||'/'||SUBSTR(CHAR(IPIPHANG),5,2)||'/'||SUBSTR(CHAR(IPIPHANG),7,2))
								ELSE '' END AS IPIPHANG,  
									IPBONSUN, 
														CASE WHEN COLNO = 1 THEN 
									VSDESC1
								ELSE '' END AS VSDESC1,  
									IPHWAJU,  
														CASE WHEN COLNO = 1 THEN 
									IPBLNO
								ELSE '' END AS IPBLNO,  
									IPHWAMUL, 
														CASE WHEN COLNO = 1 THEN 
									HMDESC1
								ELSE '' END AS HMDESC1,  

														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(IPBSQTY, '9,999,990.000'))
								ELSE '' END AS IPBSQTY,  
														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(IPMTQTY, '9,999,990.000'))
								ELSE '' END AS IPMTQTY,  
														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(IPPAQTY, '9,999,990.000'))
								ELSE '' END AS IPPAQTY,  
														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(REIPPAQTY, '9,999,990.000'))
								ELSE '' END AS REIPPAQTY,  
								CHMTQTY ,         
								JEGOCHECK,								
								(SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL,  
								TRIM(TO_CHAR(CHULQTY, '9,999,990.000')) as CHULQTY,
								TRIM(TO_CHAR(JEGOQTY, '9,999,990.000')) as JEGOQTY,
								TRIM(TO_CHAR(TONGJEGOQTY, '9,999,990.000')) as TONGJEGOQTY
					FROM TABLE_LIST
					WHERE CASE WHEN P_JGCHECK = 'ALL' THEN 
								   ''
						  ELSE  JEGOCHECK END  =  CASE WHEN P_JGCHECK = 'ALL' THEN  '' ELSE P_JGCHECK END
					ORDER BY  ROW_NUMBER() OVER(ORDER BY IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO, COLNO )
					)
					SELECT  *
					FROM ORIGINAL_DATA
					WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
					ORDER BY ROWNO ASC ;

			OPEN REFCURSOR ;

		END LIST ; 
	  
		PAGING : BEGIN  -- 페이징 					

				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR				
				    WITH TABLE1 AS (
					 SELECT    
					 IPIPHANG, 
					 IPBONSUN, 
					 VSCODE.CDDESC1 AS VSDESC1, 
					 IPHWAJU,  
					 IPBLNO,   
					 IPHWAMUL, 
					 HMCODE.CDDESC1 AS HMDESC1, 
					 IPBSQTY,  
					 IPMTQTY,  
					 IPPAQTY,  
					 (IPMTQTY - IPPAQTY) AS REIPPAQTY,
					 (  SELECT  VALUE(SUM(CHMTQTY),0) AS CHMTQTY 
					 FROM TYSCMLIB.UTICHULF          
					 WHERE CHIPHANG =  IPIPHANG
					 AND   CHBONSUN =  IPBONSUN
					 AND   CHHWAJU  =  IPHWAJU
					 AND   CHHWAMUL =   IPHWAMUL
					 AND   CHBLNO   =  IPBLNO ) AS CHMTQTY
					 FROM TYSCMLIB.UTIIPGOF AS IPGO  
					 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
					 ON              'VS' = VSCODE.CDINDEX        
					 AND    IPGO.IPBONSUN = VSCODE.CDCODE         
					 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
					 ON              'HM' = HMCODE.CDINDEX        
					 AND    IPGO.IPHWAMUL = HMCODE.CDCODE         
					 WHERE IPHWAJU  IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
					 AND   IPIPHANG BETWEEN P_SDATE AND P_EDATE
					 AND   IPHWAMUL LIKE P_HWAMUL||'%'
					 ORDER BY IPIPHANG, IPBONSUN, IPHWAMUL, IPBLNO 
					) , TABLE2 AS (
					  SELECT   CHCHULIL, CHIPHANG, CHBONSUN, CHHWAJU, CHHWAMUL, CHBLNO,
								  SUM(CHUL.CHMTQTY) AS CHMTQTY 
					 FROM TYSCMLIB.UTICHULF AS CHUL 
					 LEFT OUTER JOIN TABLE1
					   ON   1 = 1
					 WHERE CHIPHANG =  IPIPHANG
					 AND   CHBONSUN =  IPBONSUN
					 AND   CHHWAJU  =  IPHWAJU
					 AND   CHHWAMUL =  IPHWAMUL
					 AND   CHBLNO   =  IPBLNO
					 GROUP BY CHCHULIL, CHIPHANG, CHBONSUN, CHHWAJU, CHHWAMUL,CHBLNO
					 ORDER BY CHCHULIL                 
					), TABLE_LIST AS (
					SELECT     ROW_NUMBER() OVER(partition by IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO ORDER BY IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO, CHCHULIL ) AS COLNO,     
					           IPIPHANG, 
								IPBONSUN, 
								VSDESC1, 
								IPHWAJU,  
								IPBLNO,   
								IPHWAMUL, 
								HMDESC1, 
								IPBSQTY,  
								IPMTQTY,  
								IPPAQTY,  
								REIPPAQTY,
								A.CHMTQTY ,
								CASE   WHEN A.CHMTQTY <= 0 THEN 
												   'ALL'
										   WHEN   A.IPMTQTY - A.CHMTQTY > 0 THEN 
												'Y'
								   WHEN   A.IPMTQTY - A.CHMTQTY <= 0 THEN 
												  'N'
								ELSE 'ALL' END AS JEGOCHECK,
								 B.CHCHULIL,
								VALUE(B.CHMTQTY,0) AS CHULQTY,
								(A.IPMTQTY -  
								( SELECT   VALUE(SUM(C.CHMTQTY),0)
									FROM TABLE2 C
									WHERE   C.CHIPHANG =  A.IPIPHANG
									   AND   C.CHBONSUN =  A.IPBONSUN
										AND   C.CHHWAJU  =  A.IPHWAJU
										AND   C.CHHWAMUL =  A.IPHWAMUL
										AND   C.CHBLNO   =  A.IPBLNO
										AND  C.CHCHULIL <= B.CHCHULIL ) ) AS JEGOQTY,
								(A.IPPAQTY -  
								( SELECT   VALUE(SUM(C.CHMTQTY),0)
									FROM TABLE2 C
									WHERE   C.CHIPHANG =  A.IPIPHANG
									   AND   C.CHBONSUN =  A.IPBONSUN
										AND   C.CHHWAJU  =  A.IPHWAJU
										AND   C.CHHWAMUL =  A.IPHWAMUL
										AND   C.CHBLNO   =  A.IPBLNO
										AND  C.CHCHULIL <= B.CHCHULIL ) ) AS TONGJEGOQTY
					FROM TABLE1 A
					LEFT OUTER JOIN TABLE2  B
					  ON     B.CHIPHANG =  A.IPIPHANG
					 AND   B.CHBONSUN =  A.IPBONSUN
					 AND   B.CHHWAJU  =  A.IPHWAJU
					 AND   B.CHHWAMUL =  A.IPHWAMUL
					 AND   B.CHBLNO   =  A.IPBLNO
					), ORIGINAL_DATA AS (
					SELECT      ROW_NUMBER() OVER(ORDER BY IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO, COLNO ) AS ROWNO,   
					            COLNO, 
								CASE WHEN COLNO = 1 THEN 
									(SUBSTR(CHAR(IPIPHANG),1,4)||'/'||SUBSTR(CHAR(IPIPHANG),5,2)||'/'||SUBSTR(CHAR(IPIPHANG),7,2))
								ELSE '' END AS IPIPHANG,  
									IPBONSUN, 
														CASE WHEN COLNO = 1 THEN 
									VSDESC1
								ELSE '' END AS VSDESC1,  
									IPHWAJU,  
														CASE WHEN COLNO = 1 THEN 
									IPBLNO
								ELSE '' END AS IPBLNO,  
									IPHWAMUL, 
														CASE WHEN COLNO = 1 THEN 
									HMDESC1
								ELSE '' END AS HMDESC1,  

														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(IPBSQTY, '9,999,990.000'))
								ELSE '' END AS IPBSQTY,  
														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(IPMTQTY, '9,999,990.000'))
								ELSE '' END AS IPMTQTY,  
														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(IPPAQTY, '9,999,990.000'))
								ELSE '' END AS IPPAQTY,  
														CASE WHEN COLNO = 1 THEN 
									TRIM(TO_CHAR(REIPPAQTY, '9,999,990.000'))
								ELSE '' END AS REIPPAQTY,  
								CHMTQTY ,         
								JEGOCHECK,								
								(SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL,  
								TRIM(TO_CHAR(CHULQTY, '9,999,990.000')) as CHULQTY,
								TRIM(TO_CHAR(JEGOQTY, '9,999,990.000')) as JEGOQTY,
								TRIM(TO_CHAR(TONGJEGOQTY, '9,999,990.000')) as TONGJEGOQTY
					FROM TABLE_LIST
					WHERE CASE WHEN P_JGCHECK = 'ALL' THEN 
								   ''
						  ELSE  JEGOCHECK END  =  CASE WHEN P_JGCHECK = 'ALL' THEN  '' ELSE P_JGCHECK END
					ORDER BY  ROW_NUMBER() OVER(ORDER BY IPIPHANG, IPBONSUN, IPHWAJU, IPHWAMUL, IPBLNO, COLNO )
					)
					SELECT  COUNT(*) AS TOTALCOUNT
					FROM ORIGINAL_DATA;

				OPEN REFCURSOR2 ;

		END PAGING ; 

	ELSE
		PRINT : BEGIN  -- 출력 

			DECLARE REFCURSOR3 CURSOR WITH RETURN FOR

				WITH TABLE1 AS
				(
				SELECT
				IPIPHANG,
				IPBONSUN,
				VSCODE.CDDESC1 AS VSDESC1, 
				IPHWAJU,
				VEND.VNSANGHO AS HJDESC1,  
				IPHWAMUL,
				HMCODE.CDDESC1 AS HMDESC1, 
				IPBLNO,
				DIGITS(IPMSNSEQ) AS IPMSNSEQ,
				DIGITS(IPHSNSEQ) AS IPHSNSEQ,
				(CASE WHEN IPGO.IPHWAJU <> CSACTHJ THEN 0 ELSE IPMTQTY END) AS IPMTQTY, 
				IPCHQTY,
				IPPAQTY,
				(CASE WHEN IPGO.IPHWAJU <> CSACTHJ THEN 0 ELSE SUM(CSCUQTY) END) AS CSCUQTY,
				COALESCE(SUM(CHUL.CHMTQTY),0) AS CHMTQTY,

				(SELECT VALUE(SUM(IPMTQTY),0) 
					FROM TYSCMLIB.UTIIPGOF
					WHERE IPIPHANG = IPGO.IPIPHANG
					AND   IPBONSUN = IPGO.IPBONSUN
					AND   IPHWAJU = IPGO.IPHWAJU
					AND   IPHWAMUL = IPGO.IPHWAMUL
					AND   IPBLNO = IPGO.IPBLNO
					AND   IPMSNSEQ = IPGO.IPMSNSEQ
					AND   IPJNHSNSEQ = IPGO.IPHSNSEQ
					AND   IPCHGUBN = 'Y' ) AS JUNIPMTQTY,

				(SELECT COALESCE(SUM(CHMTQTY),0) 
					FROM TYSCMLIB.UTICHULF 
					WHERE CHIPHANG = IPGO.IPIPHANG
					AND    CHBONSUN = IPGO.IPBONSUN
					AND    CHHWAJU = IPGO.IPHWAJU
					AND    CHHWAMUL = IPGO.IPHWAMUL
					AND    CHBLNO = IPGO.IPBLNO
					AND    CHMSNSEQ = IPGO.IPMSNSEQ
					AND    CHHSNSEQ = IPGO.IPHSNSEQ
					AND    CHCHULIL <= P_DATE) AS CHMTQTY1,

				(SELECT COALESCE(SUM(CHMTQTY),0) 
					FROM TYSCMLIB.UTICHULF 
					WHERE CHIPHANG = IPGO.IPIPHANG
					AND    CHBONSUN = IPGO.IPBONSUN
					AND    CHHWAJU = IPGO.IPHWAJU
					AND    CHHWAMUL = IPGO.IPHWAMUL
					AND    CHBLNO = IPGO.IPBLNO
					AND    CHMSNSEQ = IPGO.IPMSNSEQ
					AND    CHHSNSEQ = IPGO.IPHSNSEQ
						      AND    CHACTHJ IN( SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
					AND    CHCHULIL <= P_DATE) AS CHMTQTY2

				FROM TYSCMLIB.UTICUSTF AS CUST
				LEFT OUTER JOIN TYSCMLIB.UTIIPGOF AS IPGO
				ON    IPGO.IPIPHANG = CUST.CSIPHANG
				AND   IPGO.IPBONSUN = CUST.CSBONSUN
				AND   IPGO.IPHWAJU = CUST.CSHWAJU
				AND   IPGO.IPHWAMUL = CUST.CSHWAMUL
				AND   IPGO.IPBLNO = CUST.CSBLNO
				AND   IPGO.IPMSNSEQ = CUST.CSMSNSEQ
				AND   IPGO.IPHSNSEQ = CUST.CSHSNSEQ
				LEFT OUTER JOIN ( SELECT CHIPHANG, 
							 CHBONSUN, 
					   CHHWAJU,  
					   CHHWAMUL, 
							 CHBLNO,   
							 CHMSNSEQ, 
							 CHHSNSEQ, 
					   CHCUSTIL, 
					   CHACTHJ,  
					   SUM(CHMTQTY) AS CHMTQTY 
					FROM TYSCMLIB.UTICHULF 
					WHERE  CHCHULIL <= P_DATE
					AND  CHCUSTIL <= P_DATE
					GROUP BY CHIPHANG, CHBONSUN, CHHWAJU, CHHWAMUL,CHBLNO,CHMSNSEQ, CHHSNSEQ ,CHCUSTIL, CHACTHJ ) CHUL 
				ON         IPGO.IPIPHANG = CHUL.CHIPHANG             
				AND        IPGO.IPBONSUN = CHUL.CHBONSUN             
				AND        IPGO.IPHWAJU  = CHUL.CHHWAJU              
				AND        IPGO.IPHWAMUL = CHUL.CHHWAMUL             
				AND        IPGO.IPBLNO   = CHUL.CHBLNO               
				AND        IPGO.IPMSNSEQ = CHUL.CHMSNSEQ             
				AND        IPGO.IPHSNSEQ = CHUL.CHHSNSEQ             
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE        
				 ON                  'VS' = VSCODE.CDINDEX          
				 AND        IPGO.IPBONSUN = VSCODE.CDCODE           
				 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND          
				 ON         IPGO.IPHWAJU  = VEND.VNCODE             
				 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE        
				 ON                  'HM' = HMCODE.CDINDEX           
				 AND        IPGO.IPHWAMUL = HMCODE.CDCODE            
				WHERE CUST.CSCUSTIL <= P_DATE
				AND    CUST.CSACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
				AND    IPGO.IPIPHANG BETWEEN 20060101 AND P_DATE

				GROUP BY IPIPHANG,IPBONSUN,IPHWAJU,IPHWAMUL,IPBLNO,IPMSNSEQ,IPHSNSEQ, 
					 IPMTQTY,IPCHQTY,IPPAQTY, CSACTHJ, VSCODE.CDDESC1,    
					  VEND.VNSANGHO,HMCODE.CDDESC1              
				HAVING IPPAQTY - COALESCE(SUM(CHMTQTY),0) > 0       
				 ORDER BY IPHWAMUL,IPIPHANG DESC         
				), TABLE2 AS (
				SELECT
					IPIPHANG,
					IPBONSUN,
					VSDESC1, 
					IPHWAJU,
					HJDESC1,  
					IPHWAMUL,
					HMDESC1, 
					IPBLNO,
					IPMSNSEQ,
					IPHSNSEQ,
					IPMTQTY, 
					IPCHQTY,
					IPPAQTY,
					CSCUQTY,
					CHMTQTY,
					JUNIPMTQTY,
					CHMTQTY1,
					CHMTQTY2,
					CASE WHEN JUNIPMTQTY > 0 THEN CHMTQTY1 ELSE CHMTQTY2 END AS PCHQTY,
					CSCUQTY AS PPAQTY,
					CSCUQTY - (CASE WHEN JUNIPMTQTY > 0 THEN CHMTQTY1 ELSE CHMTQTY2 END) AS BCHQTY,
					IPMTQTY - CSCUQTY AS BPAQTY
				FROM TABLE1
				), TABLE3 AS (
				SELECT
					IPHWAMUL,
					HMDESC1,
					IPIPHANG,
					VSDESC1, 
					HJDESC1, 
					IPBLNO,
					IPMSNSEQ,
					IPHSNSEQ,
					IPMTQTY, 
					PPAQTY AS CSCUQTY,
					PCHQTY AS CHMTQTY,
					JUNIPMTQTY,
					BCHQTY AS REJEGOQTY,
					BPAQTY - JUNIPMTQTY AS REPAQTY
				FROM TABLE2
				WHERE JUNIPMTQTY <> 0
				AND    ((IPMTQTY - JUNIPMTQTY) <> PCHQTY OR (IPMTQTY - JUNIPMTQTY) <> PPAQTY)

				UNION ALL

				SELECT
					IPHWAMUL,
					HMDESC1,
					IPIPHANG,
					VSDESC1, 
					HJDESC1, 
					IPBLNO,
					IPMSNSEQ,
					IPHSNSEQ,
					IPMTQTY,
					CSCUQTY,
					CHMTQTY2 AS CHMTQTY,
					JUNIPMTQTY,
					CSCUQTY - CHMTQTY2 AS REJEGOQTY,
					0 AS REPAQTY
				FROM TABLE2
				WHERE JUNIPMTQTY = 0 
				)
				SELECT
					'A' AS GUBUN,
					ROW_NUMBER() OVER(ORDER BY IPHWAMUL,IPIPHANG DESC) AS ROWNO,    
					IPHWAMUL,
					HMDESC1,
					SUBSTR(IPIPHANG,1,4) || '/' || SUBSTR(IPIPHANG,5,2) || '/' || SUBSTR(IPIPHANG,7,2) AS IPIPHANG,
					VSDESC1, 
					HJDESC1, 
					IPBLNO,
					IPMSNSEQ,
					IPHSNSEQ,
					IPMSNSEQ||'/'||IPHSNSEQ AS MSHSNSEQ,
					IPMTQTY,
					CSCUQTY,
					CHMTQTY,
					JUNIPMTQTY,
					REJEGOQTY,
					REPAQTY
				FROM TABLE3
				ORDER BY IPHWAMUL,IPIPHANG DESC ;                            

			OPEN REFCURSOR3 ;

		END PRINT;

	END IF;

END MAIN ; 
END  ;
