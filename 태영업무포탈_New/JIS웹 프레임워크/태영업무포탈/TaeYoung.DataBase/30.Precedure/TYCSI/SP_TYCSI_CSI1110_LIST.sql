--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1110_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1110_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE    VARCHAR(8),
	IN P_EDATE    VARCHAR(8),
    IN P_HWAJU    VARCHAR(50),
	IN P_HWAMUL   VARCHAR(3),
	IN P_CHHJ     VARCHAR(3),
	IN P_CARNO    VARCHAR(4),
	IN P_TANKNO   VARCHAR(4),
	IN P_GUBUN    VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI1110_LIST 
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
								 (SELECT DIGITS(ORDER.JIYYMM)||'-'||DIGITS(ORDER.JISEQ) 
								  FROM TYSCMLIB.UTIORDERF AS ORDER             
								  WHERE JISI.JIYYMM = ORDER.JISINO1            
								  AND   JISI.JISEQ  = ORDER.JISINO2            
								 ) AS ORNUM,                                   
								 DIGITS(JIYYMM)||'-'||DIGITS(JISEQ) AS JISI,   
								 ACVEND.VNSANGHO AS ACVEND,                    
								 HMCODE.CDDESC1 AS HMDESC11,                   
								 (JITANKNO||', '||JICHJANG) AS JITANKNO,       
								 HJCODE.CDDESC1 AS HJDESC1,                    
								 (CASE WHEN JITMGUBN = '1' THEN '일반'         
									   WHEN JITMGUBN = '2' THEN '조출'         
									   WHEN JITMGUBN = '3' THEN '특허'         
									   ELSE '일반' END) AS JITMGUBN,           
								 JICARNO2,                                     
								 JICONTNUM,                                                
								 JICARNO1,                                     
								 (CASE WHEN JISTMTQTY <> 0 THEN JISTMTQTY ELSE JISTLTQTY END) AS JIJIQTY, 
								 JICHQTY,                                      
								 (SUBSTR(CHAR(JIIPHANG),1,4)||'/'||SUBSTR(CHAR(JIIPHANG),5,2)||'/'||SUBSTR(CHAR(JIIPHANG),7,2)) AS JIIPHANG,
								 VSCODE.CDDESC1 AS VSDESC1,                    
								 JIBLNO                                        
								 FROM TYSCMLIB.UTIJISIF AS JISI                
								 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS ACVEND   
								 ON      ACVEND.VNCODE = JISI.JIACTHJ          
								 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HJCODE   
								 ON               'DC' = HJCODE.CDINDEX        
								 AND       JISI.JICHHJ = HJCODE.CDCODE         
								 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE   
								 ON               'HM' = HMCODE.CDINDEX        
								 AND     JISI.JIHWAMUL = HMCODE.CDCODE         

								 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE   
								 ON               'VS' = VSCODE.CDINDEX        
								 AND     JISI.JIBONSUN = VSCODE.CDCODE         
								 WHERE JIYYMM BETWEEN P_SDATE AND P_EDATE
								   AND JIACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST( P_HWAJU AS VARCHAR(100)), ',')) AS InTable ) 
								   AND JIHWAMUL LIKE  P_HWAMUL||'%'
								   AND JICHHJ   LIKE  P_CHHJ||'%'
								   AND JICARNO2 LIKE  '%'||P_CARNO||'%'
								   AND TRIM(JITANKNO)  LIKE P_TANKNO||'%'
								 ORDER BY JIYYMM, JISEQ, ACVEND.VNSANGHO, HMCODE.CDDESC1 
						), ORIGINAL_DATA AS (
						SELECT   ROW_NUMBER() OVER(ORDER BY ORNUM) AS ROWNO, 
							     ORNUM,                                   
								 JISI,   
								 ACVEND,                    
								 HMDESC11,                   
								 JITANKNO,       
								 HJDESC1,                    
								 JITMGUBN,           
								 JICARNO2,                                     
								 JICONTNUM,                                                
								 JICARNO1,                                     
								 JIJIQTY, 
								 JICHQTY,                                      
								 JIIPHANG,
								 VSDESC1,                    
								 JIBLNO                      
						FROM TABLE1
						)
						SELECT   ROWNO, 
								 ORNUM,                                   
								 JISI,   
								 ACVEND,                    
								 HMDESC11,                   
								 JITANKNO,       
								 HJDESC1,                    
								 JITMGUBN,           
								 JICARNO2,                                     
								 JICONTNUM,                                                
								 JICARNO1,                                     								 
								 TRIM(TO_CHAR(JIJIQTY, '9,999,990.000')) AS JIJIQTY,         								 
								 TRIM(TO_CHAR(JICHQTY, '9,999,990.000')) AS JICHQTY,         
								 JIIPHANG,
								 VSDESC1,                    
								 JIBLNO     
						FROM ORIGINAL_DATA
						WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
						ORDER BY ROWNO ASC ;

			OPEN REFCURSOR ;

		END LIST ; 
	  
		PAGING : BEGIN  -- 페이징 					

				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR			
				   WITH TABLE1 AS (
						   SELECT                                        
								 (SELECT DIGITS(ORDER.JIYYMM)||'-'||DIGITS(ORDER.JISEQ) 
								  FROM TYSCMLIB.UTIORDERF AS ORDER             
								  WHERE JISI.JIYYMM = ORDER.JISINO1            
								  AND   JISI.JISEQ  = ORDER.JISINO2            
								 ) AS ORNUM,                                   
								 DIGITS(JIYYMM)||'-'||DIGITS(JISEQ) AS JISI,   
								 ACVEND.VNSANGHO AS ACVEND,                    
								 HMCODE.CDDESC1 AS HMDESC11,                   
								 (JITANKNO||', '||JICHJANG) AS JITANKNO,       
								 HJCODE.CDDESC1 AS HJDESC1,                    
								 (CASE WHEN JITMGUBN = '1' THEN '일반'         
									   WHEN JITMGUBN = '2' THEN '조출'         
									   WHEN JITMGUBN = '3' THEN '특허'         
									   ELSE '일반' END) AS JITMGUBN,           
								 JICARNO2,                                     
								 JICONTNUM,                                                
								 JICARNO1,                                     
								 (CASE WHEN JISTMTQTY <> 0 THEN JISTMTQTY ELSE JISTLTQTY END) AS JIJIQTY, 
								 JICHQTY,                                      
								 (SUBSTR(CHAR(JIIPHANG),1,4)||'/'||SUBSTR(CHAR(JIIPHANG),5,2)||'/'||SUBSTR(CHAR(JIIPHANG),7,2)) AS JIIPHANG,
								 VSCODE.CDDESC1 AS VSDESC1,                    
								 JIBLNO                                        
								 FROM TYSCMLIB.UTIJISIF AS JISI                
								 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS ACVEND   
								 ON      ACVEND.VNCODE = JISI.JIACTHJ          
								 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HJCODE   
								 ON               'DC' = HJCODE.CDINDEX        
								 AND       JISI.JICHHJ = HJCODE.CDCODE         
								 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE   
								 ON               'HM' = HMCODE.CDINDEX        
								 AND     JISI.JIHWAMUL = HMCODE.CDCODE         

								 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE   
								 ON               'VS' = VSCODE.CDINDEX        
								 AND     JISI.JIBONSUN = VSCODE.CDCODE         
								 WHERE JIYYMM BETWEEN P_SDATE AND P_EDATE
								   AND JIACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST( P_HWAJU AS VARCHAR(100)), ',')) AS InTable ) 
								   AND JIHWAMUL LIKE  P_HWAMUL||'%'
								   AND JICHHJ   LIKE  P_CHHJ||'%'
								   AND JICARNO2 LIKE  '%'||P_CARNO||'%'
								   AND TRIM(JITANKNO)  LIKE P_TANKNO||'%'
								 ORDER BY JIYYMM, JISEQ, ACVEND.VNSANGHO, HMCODE.CDDESC1 
						), ORIGINAL_DATA AS (
						SELECT   ROW_NUMBER() OVER(ORDER BY ORNUM) AS ROWNO, 
							     ORNUM,                                   
								 JISI,   
								 ACVEND,                    
								 HMDESC11,                   
								 JITANKNO,       
								 HJDESC1,                    
								 JITMGUBN,           
								 JICARNO2,                                     
								 JICONTNUM,                                                
								 JICARNO1,                                     
								 JIJIQTY, 
								 JICHQTY,                                      
								 JIIPHANG,
								 VSDESC1,                    
								 JIBLNO                      
						FROM TABLE1
						)						
				        SELECT
					        COUNT(*) AS TOTALCOUNT
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
