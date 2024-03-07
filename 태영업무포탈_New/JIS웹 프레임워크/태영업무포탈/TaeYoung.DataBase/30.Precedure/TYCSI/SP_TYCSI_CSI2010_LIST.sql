--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2010_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI2010_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_MCDATE   VARCHAR(6),	
    IN P_MCHWAJU  VARCHAR(3),
	IN P_GUBUN   VARCHAR(1)
	) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI2010_LIST 
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
						 SELECT  'A' AS GUBUN,
								 (SUBSTR(CHAR(JBDATE),1,4)||'-'||SUBSTR(CHAR(JBDATE),5,2)||'-'||SUBSTR(CHAR(JBDATE),7,2)) AS JBDATE,
								 (SUBSTR(CHAR(JBIPHANG),1,4)||'-'||SUBSTR(CHAR(JBIPHANG),5,2)||'-'||SUBSTR(CHAR(JBIPHANG),7,2)) AS JBIPHANG,
								 JBBONSUN,          
								 CDDESC1,           
								 TRIM(CHAR(JBGROSS)) AS JBGROSS,           
								 ((SUBSTR(CHAR(JBJBDAT),1,4)||'-'||SUBSTR(CHAR(JBJBDAT),5,2)||'-'||SUBSTR(CHAR(JBJBDAT),7,2))||' '||SUBSTR(DIGITS(JBJBTIM),1,2)||':'||SUBSTR(DIGITS(JBJBTIM),3,2)) AS JBINDATE,
								 ((SUBSTR(CHAR(JBIANDAT),1,4)||'-'||SUBSTR(CHAR(JBIANDAT),5,2)||'-'||SUBSTR(CHAR(JBIANDAT),7,2))||' '||SUBSTR(DIGITS(JBIANTIM),1,2)||':'||SUBSTR(DIGITS(JBIANTIM),3,2)) AS JBOUTDATE, 						 
						 TRIM(CHAR(JBTOTTIM)) AS JBTOTTIM,           
						 JBAMT,              
						 JBVAT,              
						 (JBAMT+JBVAT) AS JBHAP   
						 FROM TYSCMLIB.UTIJUBNF  
						 LEFT OUTER JOIN  TYSCMLIB.UTICODEF  
						 ON                'VS'   = CDINDEX      
						 AND             JBBONSUN = CDCODE       
						 WHERE SUBSTR(TRIM(CHAR(JBDATE)),1,6)  =  P_MCDATE
						 AND   JBBRANCH  =  P_MCHWAJU
						 ), TABLE_HAP AS (

								SELECT    'B' AS GUBUN,
									  '' AS JBDATE,
								  '' AS JBIPHANG,
								  '' AS JBBONSUN,          
								 '' AS CDDESC1,           
								 '' AS JBGROSS,           
								 '' AS JBINDATE,
								 '' AS JBOUTDATE, 
										'' AS JBTOTTIM,           
                						 VALUE(SUM(JBAMT),0) AS JBAMT,              
             								VALUE(SUM(JBVAT),0) AS JBVAT,              
     										VALUE(SUM(JBHAP),0) AS JBHAP   	     
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
								  ROW_NUMBER() OVER(ORDER BY GUBUN, JBDATE ) AS ROWNO,     	  
									  JBDATE,
								  JBIPHANG,
								  JBBONSUN,          
								CDDESC1,           
								JBGROSS,           
								JBINDATE,
								CASE WHEN GUBUN = 'B' THEN  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >합 계</div>' 
												  ELSE JBOUTDATE END AS JBOUTDATE, 
										JBTOTTIM,   
								CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(JBAMT, '9,999,990'))|| '</div>' 
												  ELSE TRIM(TO_CHAR(JBAMT, '9,999,990')) END AS JBAMT, 
								CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(JBVAT, '9,999,990'))|| '</div>' 
												  ELSE TRIM(TO_CHAR(JBVAT, '9,999,990')) END AS JBVAT, 
								CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(JBHAP, '9,999,990'))|| '</div>' 
												  ELSE TRIM(TO_CHAR(JBHAP, '9,999,990')) END AS JBHAP 

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
				        WITH TABLE1 AS 
						 (
						 SELECT  'A' AS GUBUN,
									  (SUBSTR(CHAR(JBDATE),1,4)||'-'||SUBSTR(CHAR(JBDATE),5,2)||'-'||SUBSTR(CHAR(JBDATE),7,2)) AS JBDATE,
								 (SUBSTR(CHAR(JBIPHANG),1,4)||'-'||SUBSTR(CHAR(JBIPHANG),5,2)||'-'||SUBSTR(CHAR(JBIPHANG),7,2)) AS JBIPHANG,
								 JBBONSUN,          
								 CDDESC1,           
								 TRIM(CHAR(JBGROSS)) AS JBGROSS,           
								 ((SUBSTR(CHAR(JBJBDAT),1,4)||'-'||SUBSTR(CHAR(JBJBDAT),5,2)||'-'||SUBSTR(CHAR(JBJBDAT),7,2))||' '||SUBSTR(DIGITS(JBJBTIM),1,2)||':'||SUBSTR(DIGITS(JBJBTIM),3,2)) AS JBINDATE,
								 ((SUBSTR(CHAR(JBIANDAT),1,4)||'-'||SUBSTR(CHAR(JBIANDAT),5,2)||'-'||SUBSTR(CHAR(JBIANDAT),7,2))||' '||SUBSTR(DIGITS(JBIANTIM),1,2)||':'||SUBSTR(DIGITS(JBIANTIM),3,2)) AS JBOUTDATE, 
						 TRIM(CHAR(JBTOTTIM)) AS JBTOTTIM,           
						 JBAMT,              
						 JBVAT,              
						 (JBAMT+JBVAT) AS JBHAP   
						 FROM TYSCMLIB.UTIJUBNF  
						 LEFT OUTER JOIN  TYSCMLIB.UTICODEF  
						 ON                'VS'   = CDINDEX      
						 AND             JBBONSUN = CDCODE       
						 WHERE SUBSTR(TRIM(CHAR(JBDATE)),1,6)  =  P_MCDATE
						 AND   JBBRANCH  =  P_MCHWAJU
						 ), TABLE_HAP AS (

								SELECT    'B' AS GUBUN,
									  '' AS JBDATE,
								  '' AS JBIPHANG,
								  '' AS JBBONSUN,          
								 '' AS CDDESC1,           
								 '' AS JBGROSS,           
								 '' AS JBINDATE,
								 '' AS JBOUTDATE, 
										'' AS JBTOTTIM,           
                						 VALUE(SUM(JBAMT),0) AS JBAMT,              
             								VALUE(SUM(JBVAT),0) AS JBVAT,              
     										VALUE(SUM(JBHAP),0) AS JBHAP   	     
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
								  ROW_NUMBER() OVER(ORDER BY GUBUN, JBDATE ) AS ROWNO,     	  
									  JBDATE,
								  JBIPHANG,
								  JBBONSUN,          
								CDDESC1,           
								JBGROSS,           
								JBINDATE,
								CASE WHEN GUBUN = 'B' THEN  '<div style="text-align:center;width:80px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:left;color:red" >합 계</div>' 
												  ELSE JBOUTDATE END AS JBOUTDATE, 
										JBTOTTIM,   
								CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(JBAMT, '9,999,990'))|| '</div>' 
												  ELSE TRIM(TO_CHAR(JBAMT, '9,999,990')) END AS JBAMT, 
								CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(JBVAT, '9,999,990'))|| '</div>' 
												  ELSE TRIM(TO_CHAR(JBVAT, '9,999,990')) END AS JBVAT, 
								CASE WHEN GUBUN = 'B' THEN '<div style="text-align:right;width:90px;margin-right:10px;font-size:13px;height:18px;padding-top:2px;float:right;color:red" > '||TRIM(TO_CHAR(JBHAP, '9,999,990'))|| '</div>' 
												  ELSE TRIM(TO_CHAR(JBHAP, '9,999,990')) END AS JBHAP 

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
