--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2020_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2020_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_MDATE   VARCHAR(6),	
    IN P_HWAJU   VARCHAR(50),
	IN P_GUBUN   VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI2020_LIST 
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
								(substr(char(M1DATE),1,4)||'-'||substr(char(M1DATE),5,2)||'-'||substr(char(M1DATE),7,2)) AS M1DATE ,  
								 (substr(char(M1IPHANG),1,4)||'-'||substr(char(M1IPHANG),5,2)||'-'||substr(char(M1IPHANG),7,2)) AS M1IPHANG, 
								 M1BONSUN,
								 (VSCODE.CDDESC1) AS VSCDDESC1,
								 M1HWAJU ,
								 VEND.VNSANGHO,
								 M1HWAMUL ,
								 (HMCODE.CDDESC1) AS HMCDDESC1,
								 M1EDIPGO ,
								 M1EDBBLS ,
								 M1EDHMAM  ,
								 M1EDTUCK ,
								 M1EDINJI ,
								 M1EDHAY  ,
								 M1EDJUB ,
								 M1ENIPGO ,
								 M1ENBBLS ,
								 M1ENHMAM ,
								 M1ENTUCK ,
								 M1ENINJI ,
								 M1ENHAY ,
								 M1ENJUB ,
								 M1RATE ,
								 M1CMHJ ,
								 M1JPNO  
						 FROM   TYSCMLIB.UTIMEC1F 
						 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
						   ON  VSCODE.CDINDEX = 'VS' 
						  AND  VSCODE.CDCODE = M1BONSUN 
						 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND 
						   ON  VEND.VNCODE = M1HWAJU 
						 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
						   ON  HMCODE.CDINDEX = 'HM' 
						  AND  HMCODE.CDCODE = M1HWAMUL 
						 WHERE  SUBSTR(TRIM(CHAR(M1DATE)),1,6) =  P_MDATE
						   AND  M1HWAJU IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
						), TABLE_HAP AS (
						SELECT
							'B' AS GUBUN,
							 '' AS M1DATE ,  
								 '' AS M1IPHANG, 
								 '' AS M1BONSUN,
								 '' AS VSCDDESC1,
								 '' AS M1HWAJU ,
								 '' AS VNSANGHO,
								 '' AS M1HWAMUL ,
								 '' AS HMCDDESC1,
								 '' AS M1EDIPGO ,
								 '' AS M1EDBBLS ,
								 '' AS M1EDHMAM  ,
								 '' AS M1EDTUCK ,
								 '' AS M1EDINJI ,
								 '' AS M1EDHAY  ,
								 '' AS M1EDJUB ,
								 VALUE(SUM(M1ENIPGO),0) AS M1ENIPGO ,
								 VALUE(SUM(M1ENBBLS),0) AS M1ENBBLS ,
								 VALUE(SUM(M1ENHMAM),0) AS M1ENHMAM ,
								 '' AS M1ENTUCK ,
								 '' AS M1ENINJI ,
								 VALUE(SUM(M1ENHAY),0) AS M1ENHAY ,
								 '' AS M1ENJUB ,
								 '' AS M1RATE ,
								 '' AS M1CMHJ ,
								 '' AS M1JPNO   
						FROM TABLE1
						), TABLE_LIST AS (
						SELECT *
						FROM TABLE1
						UNION ALL
						SELECT *
						FROM TABLE_HAP
						), ORIGINAL_DATA AS  (
						SELECT
								  GUBUN,
							  ROW_NUMBER() OVER(ORDER BY GUBUN, M1DATE,M1IPHANG) AS ROWNO,     	 
							  M1DATE ,  
								  M1IPHANG, 
								  M1BONSUN,
								  VSCDDESC1,
								  M1HWAJU ,
								  VNSANGHO,
								  M1HWAMUL ,								  
							  CASE WHEN GUBUN = 'B' THEN  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >합 계</div>' 
							  ELSE HMCDDESC1 END AS HMCDDESC1, 
								  M1EDIPGO ,
								  M1EDBBLS ,
								  M1EDHMAM  ,
								  M1EDTUCK ,
								  M1EDINJI ,
								  M1EDHAY  ,
								  M1EDJUB ,
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENIPGO, '9,999,990.000'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENIPGO, '9,999,990.000')) END AS M1ENIPGO, 
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENBBLS, '9,999,990.000'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENBBLS, '9,999,990.000')) END AS M1ENBBLS, 
								  
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENHMAM, '9,999,990.00'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENHMAM, '9,999,990.00')) END AS M1ENHMAM, 

								  M1ENTUCK ,
								  M1ENINJI ,
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENHAY, '9,999,990.00'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENHAY, '9,999,990.00')) END AS M1ENHAY, 
								  M1ENJUB ,
								  M1RATE ,
								  M1CMHJ ,
								  M1JPNO  
						FROM TABLE_LIST 	 
						)
						SELECT *
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
								(substr(char(M1DATE),1,4)||'-'||substr(char(M1DATE),5,2)||'-'||substr(char(M1DATE),7,2)) AS M1DATE ,  
								 (substr(char(M1IPHANG),1,4)||'-'||substr(char(M1IPHANG),5,2)||'-'||substr(char(M1IPHANG),7,2)) AS M1IPHANG, 
								 M1BONSUN,
								 (VSCODE.CDDESC1) AS VSCDDESC1,
								 M1HWAJU ,
								 VEND.VNSANGHO,
								 M1HWAMUL ,
								 (HMCODE.CDDESC1) AS HMCDDESC1,
								 M1EDIPGO ,
								 M1EDBBLS ,
								 M1EDHMAM  ,
								 M1EDTUCK ,
								 M1EDINJI ,
								 M1EDHAY  ,
								 M1EDJUB ,
								 M1ENIPGO ,
								 M1ENBBLS ,
								 M1ENHMAM ,
								 M1ENTUCK ,
								 M1ENINJI ,
								 M1ENHAY ,
								 M1ENJUB ,
								 M1RATE ,
								 M1CMHJ ,
								 M1JPNO  
						 FROM   TYSCMLIB.UTIMEC1F 
						 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
						   ON  VSCODE.CDINDEX = 'VS' 
						  AND  VSCODE.CDCODE = M1BONSUN 
						 LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND 
						   ON  VEND.VNCODE = M1HWAJU 
						 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
						   ON  HMCODE.CDINDEX = 'HM' 
						  AND  HMCODE.CDCODE = M1HWAMUL 
						 WHERE  SUBSTR(TRIM(CHAR(M1DATE)),1,6) =  P_MDATE
						   AND  M1HWAJU IN (SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable ) 
						), TABLE_HAP AS (
						SELECT
							'B' AS GUBUN,
							 '' AS M1DATE ,  
								 '' AS M1IPHANG, 
								 '' AS M1BONSUN,
								 '' AS VSCDDESC1,
								 '' AS M1HWAJU ,
								 '' AS VNSANGHO,
								 '' AS M1HWAMUL ,
								 '' AS HMCDDESC1,
								 '' AS M1EDIPGO ,
								 '' AS M1EDBBLS ,
								 '' AS M1EDHMAM  ,
								 '' AS M1EDTUCK ,
								 '' AS M1EDINJI ,
								 '' AS M1EDHAY  ,
								 '' AS M1EDJUB ,
								 VALUE(SUM(M1ENIPGO),0) AS M1ENIPGO ,
								 VALUE(SUM(M1ENBBLS),0) AS M1ENBBLS ,
								 VALUE(SUM(M1ENHMAM),0) AS M1ENHMAM ,
								 '' AS M1ENTUCK ,
								 '' AS M1ENINJI ,
								 VALUE(SUM(M1ENHAY),0) AS M1ENHAY ,
								 '' AS M1ENJUB ,
								 '' AS M1RATE ,
								 '' AS M1CMHJ ,
								 '' AS M1JPNO   
						FROM TABLE1
						), TABLE_LIST AS (
						SELECT *
						FROM TABLE1
						UNION ALL
						SELECT *
						FROM TABLE_HAP
						), ORIGINAL_DATA AS  (
						SELECT
								  GUBUN,
							  ROW_NUMBER() OVER(ORDER BY GUBUN, M1DATE,M1IPHANG) AS ROWNO,     	 
							  M1DATE ,  
								  M1IPHANG, 
								  M1BONSUN,
								  VSCDDESC1,
								  M1HWAJU ,
								  VNSANGHO,
								  M1HWAMUL ,								  
							  CASE WHEN GUBUN = 'B' THEN  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >합 계</div>' 
							  ELSE HMCDDESC1 END AS HMCDDESC1, 
								  M1EDIPGO ,
								  M1EDBBLS ,
								  M1EDHMAM  ,
								  M1EDTUCK ,
								  M1EDINJI ,
								  M1EDHAY  ,
								  M1EDJUB ,
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENIPGO, '9,999,990.000'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENIPGO, '9,999,990.000')) END AS M1ENIPGO, 
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENBBLS, '9,999,990.000'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENBBLS, '9,999,990.000')) END AS M1ENBBLS, 
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENHMAM, '9,999,990.00'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENHMAM, '9,999,990.00')) END AS M1ENHMAM, 								  
								  M1ENTUCK ,
								  M1ENINJI ,
							  CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:1px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(M1ENHAY, '9,999,990'))|| '</div>' 
							  ELSE TRIM(TO_CHAR(M1ENHAY, '9,999,990')) END AS M1ENHAY, 
								  M1ENJUB ,
								  M1RATE ,
								  M1CMHJ ,
								  M1JPNO  
						FROM TABLE_LIST 	 
						)
						SELECT
							COUNT(*) AS TOTALCOUNT
						FROM ORIGINAL_DATA;					

				OPEN REFCURSOR2 ;

		END PAGING ; 
		
	END IF;

END MAIN ; 
END  ;
