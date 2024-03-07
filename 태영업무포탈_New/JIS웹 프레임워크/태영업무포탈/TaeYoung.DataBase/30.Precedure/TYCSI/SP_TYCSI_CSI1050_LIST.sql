--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1050_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI1050_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE   VARCHAR(8),
	IN P_EDATE   VARCHAR(8),
        IN P_HWAJU   VARCHAR(50),
	IN P_GUBUN   VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI1050_LIST 
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
				WITH TABLE1 AS
				(
				SELECT              
				'A' AS GUBUN,
				ROW_NUMBER() OVER() AS ROWNO,  
				CHHWAMUL,                  
				HMCODE.CDDESC1 AS HMDESC1, 
				(SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL, 
				CHAR(CHTKNO) AS CHTKNO,					   
				(SUBSTR(CHAR(CHIPHANG),1,4)||'/'||SUBSTR(CHAR(CHIPHANG),5,2)||'/'||SUBSTR(CHAR(CHIPHANG),7,2)) AS CHIPHANG, 
				VSCODE.CDDESC1 AS VSDESC1, 
				DCCODE.CDDESC1 AS CHDESC1, 
				CHBLNO,                     
				(DIGITS(CHMSNSEQ)||'-'||DIGITS(CHHSNSEQ)) AS MSHSNSEQ,
				(DIGITS(CHCUSTIL)||'-'||DIGITS(CHCHASU)) AS CUSTIL, 
				CHMTQTY,                   
				(SUBSTR(DIGITS(CHCHSTR),1,2)||':'||SUBSTR(DIGITS(CHCHSTR),3,2)||'~'||SUBSTR(DIGITS(CHCHEND),1,2)||':'||SUBSTR(DIGITS(CHCHEND),3,2)) AS CHCHTIME, 
				CHOVQTY,                   
				(SUBSTR(DIGITS(CHOVSTR),1,2)||':'||SUBSTR(DIGITS(CHOVSTR),3,2)||'~'||SUBSTR(DIGITS(CHOVEND),1,2)||':'||SUBSTR(DIGITS(CHOVEND),3,2)) AS CHOVTIME, 
				CHCARNO AS CHNUMBER,                         
				(CHHWAMUL||''||CHAR(CHCHULIL)) AS CHGUBUN,     
				(CASE WHEN CHHWAJU = 'GSG' THEN  CHTEMP      
				  ELSE 0 END) AS CHTEMP,                     
				CHCHTANK                                      
				FROM TYSCMLIB.UTICHULF AS CHUL              
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
				ON               'HM' = HMCODE.CDINDEX       
				AND     CHUL.CHHWAMUL = HMCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE  
				ON               'DC' = DCCODE.CDINDEX       
				AND     CHUL.CHCHHJ   = DCCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
				ON               'VS' = VSCODE.CDINDEX       
				AND     CHUL.CHBONSUN = VSCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				ON      CHUL.CHACTHJ  = VEND.VNCODE          
				WHERE CHCHULIL BETWEEN P_SDATE AND P_EDATE
				AND   CHUL.CHACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				ORDER BY CHHWAMUL,CHCHULIL                   
				), TABLE_HAP AS (
				SELECT
				'B' AS GUBUN,
				ROW_NUMBER() OVER( ORDER BY CHGUBUN ) AS ROWNO,
				'' AS CHHWAMUL,                  
				'' AS HMDESC1, 
				'' AS CHCHULIL,				   
				'' AS CHTKNO,					   
				'' AS CHIPHANG, 
				'' AS VSDESC1, 
				'' AS CHDESC1, 
				'' AS CHBLNO,                     
				'' AS MSHSNSEQ,
				'' AS CUSTIL, 
				SUM(CHMTQTY) AS CHMTQTY,                   
				'' AS CHCHTIME, 
				SUM(CHOVQTY) AS CHOVQTY,                   
				'' AS CHOVTIME, 
				'' AS CHNUMBER,                         
				CHGUBUN,     
				'' AS CHTEMP,                     
				'' AS CHCHTANK     
				FROM TABLE1
				GROUP BY CHGUBUN
				UNION ALL
				SELECT
				'C' AS GUBUN,
				ROW_NUMBER() OVER( ORDER BY CHHWAMUL ) AS ROWNO,
				CHHWAMUL,                  
				'' AS HMDESC1, 
				'' AS CHCHULIL,				   
				'' AS CHTKNO,					   
				'' AS CHIPHANG, 
				'' AS VSDESC1, 
				'' AS CHDESC1, 
				'' AS CHBLNO,                     
				'' AS MSHSNSEQ,
				'' AS CUSTIL, 
				SUM(CHMTQTY) AS CHMTQTY,                   
				'' AS CHCHTIME, 
				SUM(CHOVQTY) AS CHOVQTY,                   
				'' AS CHOVTIME, 
				'' AS CHNUMBER,                         
				MAX(CHGUBUN) AS CHGUBUN,     
				'' AS CHTEMP,                     
				'' AS CHCHTANK     
				FROM TABLE1
				GROUP BY CHHWAMUL
				), TABLE_LIST AS (
				SELECT
					GUBUN,
					ROWNO,
					CHHWAMUL,                  
					HMDESC1, 
					CHCHULIL,				   
					CHTKNO,					   
					CHIPHANG, 
					VSDESC1, 
					CHDESC1, 
					CHBLNO,                     
					MSHSNSEQ,
					CUSTIL, 
					CHMTQTY,                   
					CHCHTIME, 
					CHOVQTY,                   
					CHOVTIME, 
					CHNUMBER,                         
					CHGUBUN,     
					TRIM(TO_CHAR(CHTEMP, '9,999,990.0')) AS CHTEMP,                     
					CHCHTANK     
				FROM TABLE1
				UNION ALL
				SELECT
					GUBUN,
					ROWNO,
					CHHWAMUL,                  
					HMDESC1, 
					CHCHULIL,				   
					CHTKNO,					   
					CHIPHANG, 
					VSDESC1, 
					CHDESC1, 
					CHBLNO,                     
					MSHSNSEQ,
					CUSTIL, 
					CHMTQTY,                   
					CHCHTIME, 
					CHOVQTY,                   
					CHOVTIME, 
					CHNUMBER,                         
					CHGUBUN,     
					CHTEMP,                     
					CHCHTANK     
				FROM TABLE_HAP
				UNION ALL
				SELECT
					'D' AS GUBUN,
					9999 AS ROWNO,
					'' AS CHHWAMUL,                  
					'' AS HMDESC1, 
					'' AS CHCHULIL,				   
					'' AS CHTKNO,					   
					'' AS CHIPHANG, 
					'' AS VSDESC1, 
					'' AS CHDESC1, 
					'' AS CHBLNO,                     
					'' AS MSHSNSEQ,
					'' AS CUSTIL, 
					SUM(CHMTQTY) AS CHMTQTY,
					'' AS CHCHTIME, 
					SUM(CHOVQTY) AS CHOVQTY,
					'' AS CHOVTIME, 
					'' AS CHNUMBER,                         
					'99999999' AS CHGUBUN,     
					'' AS CHTEMP,                     
					'' AS CHCHTANK     
				FROM TABLE_HAP
				WHERE GUBUN = 'C'
				), ORIGINAL_DATA AS  (
				SELECT
					GUBUN,    					
					ROW_NUMBER() OVER(ORDER BY CHGUBUN, GUBUN, ROWNO) AS ROWNO,     	
					CHHWAMUL,                  
					CASE WHEN GUBUN = 'B' THEN  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >일자별계</div>' 
					WHEN GUBUN = 'C' THEN '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >화물누계</div>' 
					WHEN GUBUN = 'D' THEN '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:blue" >총합계</div>' 
					ELSE HMDESC1 END AS HMDESC1, 
					CHCHULIL,				   
					CHTKNO,					   
					CHIPHANG, 
					VSDESC1, 
					CHDESC1, 
					CHBLNO,                     
					MSHSNSEQ,
					CUSTIL, 
					CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))|| '</div>' 
					WHEN GUBUN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CHMTQTY, '9,999,990.000'))||'</div>'
					ELSE TRIM(TO_CHAR(CHMTQTY, '9,999,990.000')) END AS CHMTQTY, 
					CHCHTIME, 
					CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:blue" > '||TRIM(TO_CHAR(CHOVQTY, '9,999,990.000'))|| '</div>' 
					WHEN GUBUN = 'C' THEN '<div style="text-align:right;width:110px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red;" > '||TRIM(TO_CHAR(CHOVQTY, '9,999,990.000'))||'</div>'
					ELSE TRIM(TO_CHAR(CHOVQTY, '9,999,990.000')) END AS CHOVQTY, 
					CHOVTIME, 
					CHNUMBER,                         
					CHGUBUN,     
					CHTEMP,                     
					CHCHTANK     
				FROM TABLE_LIST
				ORDER BY CHGUBUN, GUBUN, ROWNO
				)
				SELECT
					GUBUN,
					ROWNO,
					CHHWAMUL,                  
					HMDESC1, 
					CHCHULIL,				   
					CHTKNO,					   
					CHIPHANG, 
					VSDESC1, 
					CHDESC1, 
					CHBLNO,                     
					MSHSNSEQ,
					CUSTIL, 
					CHMTQTY,
					CHCHTIME, 
					CHOVQTY,
					CHOVTIME, 
					CHNUMBER,                         
					CHGUBUN,     
					CHTEMP,                     
					CHCHTANK
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
				'A' AS GUBUN,
				ROW_NUMBER() OVER() AS ROWNO,  
				CHHWAMUL,                  
				HMCODE.CDDESC1 AS HMDESC1, 
				(SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL, 
				CHAR(CHTKNO) AS CHTKNO,					   
				(SUBSTR(CHAR(CHIPHANG),1,4)||'/'||SUBSTR(CHAR(CHIPHANG),5,2)||'/'||SUBSTR(CHAR(CHIPHANG),7,2)) AS CHIPHANG, 
				VSCODE.CDDESC1 AS VSDESC1, 
				DCCODE.CDDESC1 AS CHDESC1, 
				CHBLNO,                     
				(DIGITS(CHMSNSEQ)||'-'||DIGITS(CHHSNSEQ)) AS MSHSNSEQ,
				(DIGITS(CHCUSTIL)||'-'||DIGITS(CHCHASU)) AS CUSTIL, 
				CHMTQTY,                   
				(SUBSTR(DIGITS(CHCHSTR),1,2)||':'||SUBSTR(DIGITS(CHCHSTR),3,2)||'~'||SUBSTR(DIGITS(CHCHEND),1,2)||':'||SUBSTR(DIGITS(CHCHEND),3,2)) AS CHCHTIME, 
				CHOVQTY,                   
				(SUBSTR(DIGITS(CHOVSTR),1,2)||':'||SUBSTR(DIGITS(CHOVSTR),3,2)||'~'||SUBSTR(DIGITS(CHOVEND),1,2)||':'||SUBSTR(DIGITS(CHOVEND),3,2)) AS CHOVTIME, 
				CHCARNO AS CHNUMBER,                         
				(CHHWAMUL||''||CHAR(CHCHULIL)) AS CHGUBUN,     
				(CASE WHEN CHHWAJU = 'GSG' THEN  CHTEMP      
				  ELSE 0 END) AS CHTEMP,                     
				CHCHTANK                                      
				FROM TYSCMLIB.UTICHULF AS CHUL              
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
				ON               'HM' = HMCODE.CDINDEX       
				AND     CHUL.CHHWAMUL = HMCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE  
				ON               'DC' = DCCODE.CDINDEX       
				AND     CHUL.CHCHHJ   = DCCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
				ON               'VS' = VSCODE.CDINDEX       
				AND     CHUL.CHBONSUN = VSCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				ON      CHUL.CHACTHJ  = VEND.VNCODE          
				WHERE CHCHULIL BETWEEN P_SDATE AND P_EDATE
				AND   CHUL.CHACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				ORDER BY CHHWAMUL,CHCHULIL                   
				), TABLE_HAP AS (
				SELECT
				'B' AS GUBUN,
				ROW_NUMBER() OVER( ORDER BY CHGUBUN ) AS ROWNO,
				'' AS CHHWAMUL,                  
				'' AS HMDESC1, 
				'' AS CHCHULIL,				   
				'' AS CHTKNO,					   
				'' AS CHIPHANG, 
				'' AS VSDESC1, 
				'' AS CHDESC1, 
				'' AS CHBLNO,                     
				'' AS MSHSNSEQ,
				'' AS CUSTIL, 
				SUM(CHMTQTY) AS CHMTQTY,                   
				'' AS CHCHTIME, 
				SUM(CHOVQTY) AS CHOVQTY,                   
				'' AS CHOVTIME, 
				'' AS CHNUMBER,                         
				CHGUBUN,     
				'' AS CHTEMP,                     
				'' AS CHCHTANK     
				FROM TABLE1
				GROUP BY CHGUBUN
				UNION ALL
				SELECT
				'C' AS GUBUN,
				ROW_NUMBER() OVER( ORDER BY CHHWAMUL ) AS ROWNO,
				CHHWAMUL,                  
				'' AS HMDESC1, 
				'' AS CHCHULIL,				   
				'' AS CHTKNO,					   
				'' AS CHIPHANG, 
				'' AS VSDESC1, 
				'' AS CHDESC1, 
				'' AS CHBLNO,                     
				'' AS MSHSNSEQ,
				'' AS CUSTIL, 
				SUM(CHMTQTY) AS CHMTQTY,                   
				'' AS CHCHTIME, 
				SUM(CHOVQTY) AS CHOVQTY,                   
				'' AS CHOVTIME, 
				'' AS CHNUMBER,                         
				MAX(CHGUBUN) AS CHGUBUN,     
				'' AS CHTEMP,                     
				'' AS CHCHTANK     
				FROM TABLE1
				GROUP BY CHHWAMUL
				), TABLE_LIST AS (
				SELECT
					GUBUN,
					ROWNO,
					CHHWAMUL,                  
					HMDESC1, 
					CHCHULIL,				   
					CHTKNO,					   
					CHIPHANG, 
					VSDESC1, 
					CHDESC1, 
					CHBLNO,                     
					MSHSNSEQ,
					CUSTIL, 
					CHMTQTY,                   
					CHCHTIME, 
					CHOVQTY,                   
					CHOVTIME, 
					CHNUMBER,                         
					CHGUBUN,     
					TRIM(TO_CHAR(CHTEMP, '9,999,990.0')) AS CHTEMP,                     
					CHCHTANK     
				FROM TABLE1
				UNION ALL
				SELECT
					GUBUN,
					ROWNO,
					CHHWAMUL,                  
					HMDESC1, 
					CHCHULIL,				   
					CHTKNO,					   
					CHIPHANG, 
					VSDESC1, 
					CHDESC1, 
					CHBLNO,                     
					MSHSNSEQ,
					CUSTIL, 
					CHMTQTY,                   
					CHCHTIME, 
					CHOVQTY,                   
					CHOVTIME, 
					CHNUMBER,                         
					CHGUBUN,     
					CHTEMP,                     
					CHCHTANK     
				FROM TABLE_HAP
				UNION ALL
				SELECT
					'D' AS GUBUN,
					9999 AS ROWNO,
					'' AS CHHWAMUL,                  
					'' AS HMDESC1, 
					'' AS CHCHULIL,				   
					'' AS CHTKNO,					   
					'' AS CHIPHANG, 
					'' AS VSDESC1, 
					'' AS CHDESC1, 
					'' AS CHBLNO,                     
					'' AS MSHSNSEQ,
					'' AS CUSTIL, 
					SUM(CHMTQTY) AS CHMTQTY,
					'' AS CHCHTIME, 
					SUM(CHOVQTY) AS CHOVQTY,
					'' AS CHOVTIME, 
					'' AS CHNUMBER,                         
					'99999999' AS CHGUBUN,     
					'' AS CHTEMP,                     
					'' AS CHCHTANK     
				FROM TABLE_HAP
				), ORIGINAL_DATA AS  (
				SELECT
					GUBUN,    					
					ROW_NUMBER() OVER(ORDER BY CHGUBUN, GUBUN, ROWNO) AS ROWNO,     	
					CHHWAMUL,                  
					CASE WHEN GUBUN = 'B' THEN  '일자별계' 
					WHEN GUBUN = 'C' THEN '화물누계' 
					WHEN GUBUN = 'D' THEN '총합계' 
					ELSE HMDESC1 END AS HMDESC1, 
					CHCHULIL,				   
					CHTKNO,					   
					CHIPHANG, 
					VSDESC1, 
					CHDESC1, 
					CHBLNO,                     
					MSHSNSEQ,
					CUSTIL, 
					CHMTQTY, 
					CHCHTIME, 
					CHOVQTY, 
					CHOVTIME, 
					CHNUMBER,                         
					CHGUBUN,     
					CHTEMP,                     
					CHCHTANK     
				FROM TABLE_LIST
				ORDER BY CHGUBUN, GUBUN, ROWNO
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
				CHHWAMUL,                  
				HMCODE.CDDESC1 AS HMDESC1, 
				(SUBSTR(CHAR(CHCHULIL),1,4)||'/'||SUBSTR(CHAR(CHCHULIL),5,2)||'/'||SUBSTR(CHAR(CHCHULIL),7,2)) AS CHCHULIL, 
				CHAR(CHTKNO) AS CHTKNO,					   
				(SUBSTR(CHAR(CHIPHANG),1,4)||'/'||SUBSTR(CHAR(CHIPHANG),5,2)||'/'||SUBSTR(CHAR(CHIPHANG),7,2)) AS CHIPHANG, 
				VSCODE.CDDESC1 AS VSDESC1, 
				DCCODE.CDDESC1 AS CHDESC1, 
				CHBLNO,                     
				(DIGITS(CHMSNSEQ)||'-'||DIGITS(CHHSNSEQ)) AS MSHSNSEQ,
				(DIGITS(CHCUSTIL)||'-'||DIGITS(CHCHASU)) AS CUSTIL, 
				CHMTQTY,                   
				(SUBSTR(DIGITS(CHCHSTR),1,2)||':'||SUBSTR(DIGITS(CHCHSTR),3,2)||'~'||SUBSTR(DIGITS(CHCHEND),1,2)||':'||SUBSTR(DIGITS(CHCHEND),3,2)) AS CHCHTIME, 
				CHOVQTY,                   
				(SUBSTR(DIGITS(CHOVSTR),1,2)||':'||SUBSTR(DIGITS(CHOVSTR),3,2)||'~'||SUBSTR(DIGITS(CHOVEND),1,2)||':'||SUBSTR(DIGITS(CHOVEND),3,2)) AS CHOVTIME, 
				CHCARNO AS CHNUMBER,                         
				(CHHWAMUL||''||CHAR(CHCHULIL)) AS CHGUBUN,     
				(CASE WHEN CHHWAJU = 'GSG' THEN  CHTEMP      
				  ELSE 0 END) AS CHTEMP,                     
				CHCHTANK                                      
				FROM TYSCMLIB.UTICHULF AS CHUL              
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
				ON               'HM' = HMCODE.CDINDEX       
				AND     CHUL.CHHWAMUL = HMCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE  
				ON               'DC' = DCCODE.CDINDEX       
				AND     CHUL.CHCHHJ   = DCCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
				ON               'VS' = VSCODE.CDINDEX       
				AND     CHUL.CHBONSUN = VSCODE.CDCODE        
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND    
				ON      CHUL.CHACTHJ  = VEND.VNCODE          
				WHERE CHCHULIL BETWEEN P_SDATE AND P_EDATE
				AND   CHUL.CHACTHJ IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
				ORDER BY CHHWAMUL,CHCHULIL           ;            

			OPEN REFCURSOR3 ;

		END PRINT;

	END IF;

END MAIN ; 
END  ;
