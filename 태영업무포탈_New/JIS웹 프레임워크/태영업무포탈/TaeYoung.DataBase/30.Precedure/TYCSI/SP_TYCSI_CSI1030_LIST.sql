--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1030_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1030_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_DATE    VARCHAR(8),
        IN P_HWAJU   VARCHAR(50),
	IN P_GUBUN   VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI1030_LIST 
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
					VEND.VNSANGHO AS HJDESC1, 
					IPHWAMUL,                  
					HMCODE.CDDESC1 AS HMDESC1, 
					IPBLNO,                    
					DIGITS(IPMSNSEQ) AS IPMSNSEQ,   
					DIGITS(IPHSNSEQ) AS IPHSNSEQ,   
					IPMTQTY,                   
					COALESCE(IPCHQTY,0) AS IPCHQTY,                 
					COALESCE(IPPAQTY,0) AS IPPAQTY,                 
					COALESCE(SUM(CSCUQTY),0) AS CSCUQTY,
					(SELECT
					VALUE(SUM(IPMTQTY),0) 
				FROM TYSCMLIB.UTIIPGOF
				WHERE IPIPHANG = IPGO.IPIPHANG
				AND    IPBONSUN = IPGO.IPBONSUN
				AND    IPHWAJU = IPGO.IPHWAJU
				AND    IPHWAMUL = IPGO.IPHWAMUL
				AND    IPBLNO = IPGO.IPBLNO
				AND    IPMSNSEQ = IPGO.IPMSNSEQ
				AND    IPJNHSNSEQ = IPGO.IPHSNSEQ
				AND    IPCHGUBN = 'Y' ) AS JUNIPMTQTY,
				(SELECT
					COALESCE(SUM(CHMTQTY),0) 
					FROM TYSCMLIB.UTICHULF 
					WHERE CHIPHANG = IPGO.IPIPHANG
					AND    CHBONSUN = IPGO.IPBONSUN
					AND    CHHWAJU = IPGO.IPHWAJU
					AND    CHHWAMUL = IPGO.IPHWAMUL
					AND    CHBLNO = IPGO.IPBLNO
					AND    CHMSNSEQ = IPGO.IPMSNSEQ
					AND    CHHSNSEQ = IPGO.IPHSNSEQ
					AND    CHCHULIL > P_DATE ) AS CHMTQTY
				FROM TYSCMLIB.UTIIPGOF AS IPGO                 
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE    
				ON                  'VS' = VSCODE.CDINDEX       
				AND        IPGO.IPBONSUN = VSCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND       
				ON         IPGO.IPACTHJ  = VEND.VNCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE    
				ON                  'HM' = HMCODE.CDINDEX       
				AND        IPGO.IPHWAMUL = HMCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICUSTF AS CUST      
				ON         IPGO.IPIPHANG = CUST.CSIPHANG        
				AND        IPGO.IPBONSUN = CUST.CSBONSUN        
				AND        IPGO.IPHWAJU  = CUST.CSHWAJU         
				AND        IPGO.IPHWAMUL = CUST.CSHWAMUL        
				AND        IPGO.IPBLNO   = CUST.CSBLNO          
				AND        IPGO.IPMSNSEQ = CUST.CSMSNSEQ        
				AND        IPGO.IPHSNSEQ = CUST.CSHSNSEQ        
				AND        CUST.CSCUSTIL >  P_DATE
				WHERE      IPGO.IPIPHANG BETWEEN 20040121 AND P_DATE
				AND        IPGO.IPHWAJU  IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				GROUP BY IPIPHANG,IPBONSUN,IPHWAJU,IPHWAMUL,IPBLNO, IPMSNSEQ, IPHSNSEQ, 
					 IPMTQTY,VSCODE.CDDESC1,VEND.VNSANGHO,HMCODE.CDDESC1, 
					 IPCHQTY,IPPAQTY 
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
					JUNIPMTQTY,
					CHMTQTY,
					(IPCHQTY - CHMTQTY) AS PCHQTY,
					(IPPAQTY - CSCUQTY) AS PPAQTY,
					(IPPAQTY - CSCUQTY) - (IPCHQTY - CHMTQTY) AS BCHQTY,
					IPMTQTY - (IPPAQTY - CSCUQTY) AS BPAQTY
				FROM TABLE1
				), TABLE3 AS (
				SELECT
					'A' AS GUBN,    					
					ROW_NUMBER() OVER( ORDER BY IPHWAMUL, IPIPHANG DESC) AS ROWNO,       
					IPHWAMUL,
					HMDESC1,
					SUBSTR(IPIPHANG,1,4) || '/' || SUBSTR(IPIPHANG,5,2) || '/' || SUBSTR(IPIPHANG,7,2) AS IPIPHANG,
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
				WHERE ((IPMTQTY - JUNIPMTQTY) <> PCHQTY OR (IPMTQTY - JUNIPMTQTY) <> PPAQTY)
				ORDER BY IPHWAMUL,IPIPHANG DESC 
				), TABLE_HAP AS (
				SELECT
					'B' AS GUBN,    					
					ROW_NUMBER() OVER( ORDER BY IPHWAMUL) AS ROWNO,      
					IPHWAMUL,
					'' AS HMDESC1,
					'' AS IPIPHANG, 
					'' AS VSDESC1, 
					'' AS HJDESC1, 
					'' AS IPBLNO,                  
					'' AS IPMSNSEQ,   
					'' AS IPHSNSEQ,   
					SUM(IPMTQTY) AS IPMTQTY,  
					SUM(CSCUQTY) AS CSCUQTY,
					SUM(CHMTQTY) AS CHMTQTY,
					SUM(JUNIPMTQTY) AS JUNIPMTQTY,
					SUM(REJEGOQTY) AS REJEGOQTY,
					SUM(REPAQTY) AS REPAQTY
				FROM TABLE3
				GROUP BY IPHWAMUL
				), TABLE_LIST AS (
				SELECT 
					GUBN,    					
					ROWNO,      
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
					CHMTQTY,
					JUNIPMTQTY,
					REJEGOQTY,
					REPAQTY
				FROM TABLE3
				UNION ALL
				SELECT 
					GUBN,    					
					ROWNO,      
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
					CHMTQTY,
					JUNIPMTQTY,
					REJEGOQTY,
					REPAQTY
				FROM TABLE_HAP
				UNION ALL
				SELECT 
					'C' AS GUBN,    					
					9999 AS ROWNO,      
					'0' AS IPHWAMUL,
					'' ASHMDESC1,
					'' AS IPIPHANG, 
					'' AS VSDESC1, 
					'' AS HJDESC1, 
					'' AS IPBLNO,                  
					'' AS IPMSNSEQ,   
					'' AS IPHSNSEQ,   
					SUM(IPMTQTY) AS IPMTQTY,  
					SUM(CSCUQTY) AS CSCUQTY,
					SUM(CHMTQTY) AS CHMTQTY,
					SUM(JUNIPMTQTY) AS JUNIPMTQTY,
					SUM(REJEGOQTY) AS REJEGOQTY,
					SUM(REPAQTY) AS REPAQTY
				FROM TABLE_HAP
				), ORIGINAL_DATA AS  (
				SELECT
					GUBN,    					
					ROW_NUMBER() OVER(ORDER BY IPHWAMUL, GUBN, ROWNO) AS ROWNO,     
					IPHWAMUL,
					CASE WHEN GUBN = 'B' THEN '<div style="text-align:center;width:120px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >화 물 계</div>' 
							      WHEN GUBN = 'C' THEN '<div style="text-align:center;width:120px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >총 합 계</div>' 
							      ELSE HMDESC1 END AS HMDESC1,
					IPIPHANG, 
					VSDESC1, 
					HJDESC1, 
					IPBLNO,                  
					IPMSNSEQ,   
					IPHSNSEQ,   
					CASE WHEN GUBN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(IPMTQTY, '9,999,990.000'))|| '</div>' 
							      WHEN GUBN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(IPMTQTY, '9,999,990.000'))||'</div>'
							      ELSE TRIM(TO_CHAR(IPMTQTY, '9,999,990.000')) END AS IPMTQTY,  
					CASE WHEN GUBN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CSCUQTY, '9,999,990.000'))|| '</div>' 
							      WHEN GUBN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CSCUQTY, '9,999,990.000'))||'</div>'
							      ELSE TRIM(TO_CHAR(CSCUQTY, '9,999,990.000')) END AS CSCUQTY,  
					CASE WHEN GUBN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))|| '</div>' 
							      WHEN GUBN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))||'</div>'
							      ELSE TRIM(TO_CHAR(CHMTQTY, '9,999,990.000')) END AS CHMTQTY,  
					CASE WHEN GUBN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(JUNIPMTQTY, '9,999,990.000'))|| '</div>' 
							      WHEN GUBN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(JUNIPMTQTY, '9,999,990.000'))||'</div>'
							      ELSE TRIM(TO_CHAR(JUNIPMTQTY, '9,999,990.000')) END AS JUNIPMTQTY,  
					CASE WHEN GUBN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(REJEGOQTY, '9,999,990.000'))|| '</div>' 
							      WHEN GUBN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(REJEGOQTY, '9,999,990.000'))||'</div>'
							      ELSE TRIM(TO_CHAR(REJEGOQTY, '9,999,990.000')) END AS REJEGOQTY,  
					CASE WHEN GUBN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(REPAQTY, '9,999,990.000'))|| '</div>' 
							      WHEN GUBN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(REPAQTY, '9,999,990.000'))||'</div>'
							      ELSE TRIM(TO_CHAR(REPAQTY, '9,999,990.000')) END AS REPAQTY
				FROM TABLE_LIST
				ORDER BY IPHWAMUL, GUBN, ROWNO
				)
				SELECT
					GUBN,    					
					ROWNO,      
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
					CHMTQTY,
					JUNIPMTQTY,
					REJEGOQTY,
					REPAQTY
				FROM ORIGINAL_DATA
				WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
				ORDER BY ROWNO ASC;


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
					VEND.VNSANGHO AS HJDESC1, 
					IPHWAMUL,                  
					HMCODE.CDDESC1 AS HMDESC1, 
					IPBLNO,                    
					DIGITS(IPMSNSEQ) AS IPMSNSEQ,   
					DIGITS(IPHSNSEQ) AS IPHSNSEQ,   
					IPMTQTY,                   
					COALESCE(IPCHQTY,0) AS IPCHQTY,                 
					COALESCE(IPPAQTY,0) AS IPPAQTY,                 
					COALESCE(SUM(CSCUQTY),0) AS CSCUQTY,
					(SELECT
					VALUE(SUM(IPMTQTY),0) 
				FROM TYSCMLIB.UTIIPGOF
				WHERE IPIPHANG = IPGO.IPIPHANG
				AND    IPBONSUN = IPGO.IPBONSUN
				AND    IPHWAJU = IPGO.IPHWAJU
				AND    IPHWAMUL = IPGO.IPHWAMUL
				AND    IPBLNO = IPGO.IPBLNO
				AND    IPMSNSEQ = IPGO.IPMSNSEQ
				AND    IPJNHSNSEQ = IPGO.IPHSNSEQ
				AND    IPCHGUBN = 'Y' ) AS JUNIPMTQTY,
				(SELECT
					COALESCE(SUM(CHMTQTY),0) 
					FROM TYSCMLIB.UTICHULF 
					WHERE CHIPHANG = IPGO.IPIPHANG
					AND    CHBONSUN = IPGO.IPBONSUN
					AND    CHHWAJU = IPGO.IPHWAJU
					AND    CHHWAMUL = IPGO.IPHWAMUL
					AND    CHBLNO = IPGO.IPBLNO
					AND    CHMSNSEQ = IPGO.IPMSNSEQ
					AND    CHHSNSEQ = IPGO.IPHSNSEQ
					AND    CHCHULIL > P_DATE ) AS CHMTQTY
				FROM TYSCMLIB.UTIIPGOF AS IPGO                 
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE    
				ON                  'VS' = VSCODE.CDINDEX       
				AND        IPGO.IPBONSUN = VSCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND       
				ON         IPGO.IPACTHJ  = VEND.VNCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE    
				ON                  'HM' = HMCODE.CDINDEX       
				AND        IPGO.IPHWAMUL = HMCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICUSTF AS CUST      
				ON         IPGO.IPIPHANG = CUST.CSIPHANG        
				AND        IPGO.IPBONSUN = CUST.CSBONSUN        
				AND        IPGO.IPHWAJU  = CUST.CSHWAJU         
				AND        IPGO.IPHWAMUL = CUST.CSHWAMUL        
				AND        IPGO.IPBLNO   = CUST.CSBLNO          
				AND        IPGO.IPMSNSEQ = CUST.CSMSNSEQ        
				AND        IPGO.IPHSNSEQ = CUST.CSHSNSEQ        
				AND        CUST.CSCUSTIL >  P_DATE
				WHERE      IPGO.IPIPHANG BETWEEN 20040121 AND P_DATE
				AND        IPGO.IPHWAJU  IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				GROUP BY IPIPHANG,IPBONSUN,IPHWAJU,IPHWAMUL,IPBLNO, IPMSNSEQ, IPHSNSEQ, 
					 IPMTQTY,VSCODE.CDDESC1,VEND.VNSANGHO,HMCODE.CDDESC1, 
					 IPCHQTY,IPPAQTY 
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
					JUNIPMTQTY,
					CHMTQTY,
					(IPCHQTY - CHMTQTY) AS PCHQTY,
					(IPPAQTY - CSCUQTY) AS PPAQTY,
					(IPPAQTY - CSCUQTY) - (IPCHQTY - CHMTQTY) AS BCHQTY,
					IPMTQTY - (IPPAQTY - CSCUQTY) AS BPAQTY
				FROM TABLE1
				ORDER BY IPHWAMUL,IPIPHANG DESC 
				), TABLE3 AS (
				SELECT
					'A' AS GUBN,    					
					ROW_NUMBER() OVER() AS ROWNO,      
					IPHWAMUL,
					HMDESC1,
					SUBSTR(IPIPHANG,1,4) || '/' || SUBSTR(IPIPHANG,5,2) || '/' || SUBSTR(IPIPHANG,7,2) AS IPIPHANG,
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
				WHERE ((IPMTQTY - JUNIPMTQTY) <> PCHQTY OR (IPMTQTY - JUNIPMTQTY) <> PPAQTY)
				ORDER BY IPHWAMUL,IPIPHANG DESC 
				), TABLE_HAP AS (
				SELECT
					'B' AS GUBN,    					
					ROW_NUMBER() OVER( ORDER BY IPHWAMUL) AS ROWNO,      
					IPHWAMUL,
					'' AS HMDESC1,
					'' AS IPIPHANG, 
					'' AS VSDESC1, 
					'' AS HJDESC1, 
					'' AS IPBLNO,                  
					'' AS IPMSNSEQ,   
					'' AS IPHSNSEQ,   
					SUM(IPMTQTY) AS IPMTQTY,  
					SUM(CSCUQTY) AS CSCUQTY,
					SUM(CHMTQTY) AS CHMTQTY,
					SUM(JUNIPMTQTY) AS JUNIPMTQTY,
					SUM(REJEGOQTY) AS REJEGOQTY,
					SUM(REPAQTY) AS REPAQTY
				FROM TABLE3
				GROUP BY IPHWAMUL
				), TABLE_LIST AS (
				SELECT 
					GUBN,    					
					ROWNO,      
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
					CHMTQTY,
					JUNIPMTQTY,
					REJEGOQTY,
					REPAQTY
				FROM TABLE3
				UNION ALL
				SELECT 
					GUBN,    					
					ROWNO,      
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
					CHMTQTY,
					JUNIPMTQTY,
					REJEGOQTY,
					REPAQTY
				FROM TABLE_HAP
				UNION ALL
				SELECT 
					'C' AS GUBN,    					
					9999 AS ROWNO,      
					'0' AS IPHWAMUL,
					'' ASHMDESC1,
					'' AS IPIPHANG, 
					'' AS VSDESC1, 
					'' AS HJDESC1, 
					'' AS IPBLNO,                  
					'' AS IPMSNSEQ,   
					'' AS IPHSNSEQ,   
					SUM(IPMTQTY) AS IPMTQTY,  
					SUM(CSCUQTY) AS CSCUQTY,
					SUM(CHMTQTY) AS CHMTQTY,
					SUM(JUNIPMTQTY) AS JUNIPMTQTY,
					SUM(REJEGOQTY) AS REJEGOQTY,
					SUM(REPAQTY) AS REPAQTY
				FROM TABLE_HAP
				), ORIGINAL_DATA AS  (
				SELECT
					GUBN,    					
					ROW_NUMBER() OVER(ORDER BY IPHWAMUL, GUBN, ROWNO) AS ROWNO,     
					IPHWAMUL,
					CASE WHEN GUBN = 'B' THEN '화물계' 
							      WHEN GUBN = 'C' THEN '총합계' 
							      ELSE HMDESC1 END AS HMDESC1,
					IPIPHANG, 
					VSDESC1, 
					HJDESC1, 
					IPBLNO,                  
					IPMSNSEQ,   
					IPHSNSEQ,   
					IPMTQTY,  
					CSCUQTY,  
					CHMTQTY,  
					JUNIPMTQTY,  
					REJEGOQTY,  
					REPAQTY
				FROM TABLE_LIST
				ORDER BY IPHWAMUL, GUBN, ROWNO
				)
				SELECT
					COUNT(*) AS TOTALCOUNT
				FROM ORIGINAL_DATA;

				OPEN REFCURSOR2 ;

		END PAGING ; 

	ELSE
		PRINT : BEGIN  -- 출력 

			DECLARE REFCURSOR3 CURSOR WITH RETURN FOR

				WITH TABLE1 AS (
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
					IPMTQTY,                   
					COALESCE(IPCHQTY,0) AS IPCHQTY,                 
					COALESCE(IPPAQTY,0) AS IPPAQTY,                 
					COALESCE(SUM(CSCUQTY),0) AS CSCUQTY,
					(SELECT
					VALUE(SUM(IPMTQTY),0) 
				FROM TYSCMLIB.UTIIPGOF
				WHERE IPIPHANG = IPGO.IPIPHANG
				AND    IPBONSUN = IPGO.IPBONSUN
				AND    IPHWAJU = IPGO.IPHWAJU
				AND    IPHWAMUL = IPGO.IPHWAMUL
				AND    IPBLNO = IPGO.IPBLNO
				AND    IPMSNSEQ = IPGO.IPMSNSEQ
				AND    IPJNHSNSEQ = IPGO.IPHSNSEQ
				AND    IPCHGUBN = 'Y' ) AS JUNIPMTQTY,
				(SELECT
					COALESCE(SUM(CHMTQTY),0) 
					FROM TYSCMLIB.UTICHULF 
					WHERE CHIPHANG = IPGO.IPIPHANG
					AND    CHBONSUN = IPGO.IPBONSUN
					AND    CHHWAJU = IPGO.IPHWAJU
					AND    CHHWAMUL = IPGO.IPHWAMUL
					AND    CHBLNO = IPGO.IPBLNO
					AND    CHMSNSEQ = IPGO.IPMSNSEQ
					AND    CHHSNSEQ = IPGO.IPHSNSEQ
					AND    CHCHULIL > P_DATE ) AS CHMTQTY
				FROM TYSCMLIB.UTIIPGOF AS IPGO                 
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE    
				ON                  'VS' = VSCODE.CDINDEX       
				AND        IPGO.IPBONSUN = VSCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND       
				ON         IPGO.IPACTHJ  = VEND.VNCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE    
				ON                  'HM' = HMCODE.CDINDEX       
				AND        IPGO.IPHWAMUL = HMCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICUSTF AS CUST      
				ON         IPGO.IPIPHANG = CUST.CSIPHANG        
				AND        IPGO.IPBONSUN = CUST.CSBONSUN        
				AND        IPGO.IPHWAJU  = CUST.CSHWAJU         
				AND        IPGO.IPHWAMUL = CUST.CSHWAMUL        
				AND        IPGO.IPBLNO   = CUST.CSBLNO          
				AND        IPGO.IPMSNSEQ = CUST.CSMSNSEQ        
				AND        IPGO.IPHSNSEQ = CUST.CSHSNSEQ        
				AND        CUST.CSCUSTIL >  P_DATE
				WHERE      IPGO.IPIPHANG BETWEEN 20040121 AND P_DATE
				AND        IPGO.IPHWAJU  IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				GROUP BY IPIPHANG,IPBONSUN,IPHWAJU,IPHWAMUL,IPBLNO, IPMSNSEQ, IPHSNSEQ, 
					 IPMTQTY,VSCODE.CDDESC1,VEND.VNSANGHO,HMCODE.CDDESC1, 
					 IPCHQTY,IPPAQTY 
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
					JUNIPMTQTY,
					CHMTQTY,
					(IPCHQTY - CHMTQTY) AS PCHQTY,
					(IPPAQTY - CSCUQTY) AS PPAQTY,
					(IPPAQTY - CSCUQTY) - (IPCHQTY - CHMTQTY) AS BCHQTY,
					IPMTQTY - (IPPAQTY - CSCUQTY) AS BPAQTY
				FROM TABLE1
				)
				SELECT
					'A' AS GUBN,    					
					ROW_NUMBER() OVER() AS ROWNO,      
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
					PPAQTY AS CSCUQTY,
					PCHQTY AS CHMTQTY,
					JUNIPMTQTY,
					BCHQTY AS REJEGOQTY,
					BPAQTY - JUNIPMTQTY AS REPAQTY
				FROM TABLE2
				WHERE ((IPMTQTY - JUNIPMTQTY) <> PCHQTY OR (IPMTQTY - JUNIPMTQTY) <> PPAQTY)
				ORDER BY IPHWAMUL,IPIPHANG DESC ;                            

			OPEN REFCURSOR3 ;

		END PRINT;

	END IF;

END MAIN ; 
END  ;
