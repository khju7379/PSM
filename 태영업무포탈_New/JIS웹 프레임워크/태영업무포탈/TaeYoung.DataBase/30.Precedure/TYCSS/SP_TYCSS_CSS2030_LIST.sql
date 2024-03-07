--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSS_CSS2030_LIST;
  

  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSS_CSS2030_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_DATE VARCHAR(6) , 
	IN P_HWAJU VARCHAR(50) , 
	IN P_GUBUN VARCHAR(1) ) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSS_CSS2030_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	DECRESULT = (31, 31, 00) , 
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
  
					WITH ORIGINAL_DATA AS 
					( 
						SELECT 
						( SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 1 , 4 ) || '/' || SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 5 , 2 ) || '/' || SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 7 , 2 ) ) AS IHIPHANG , 
						USHANGCHA , 
						USGOKJONG , 
						CODE . CDDESC1 AS HANGCHNM , 
						GKCD . CDDESC1 AS GOKJGNM , 
						USHWAKQTY , 
						CNSISULAMT , 
						USUSEDAMT , 
						USUSEDVAT , 
						( USUSEDAMT + USUSEDVAT ) AS TOTAL 
						FROM TYSCMLIB . USIMCUSF 
						LEFT OUTER JOIN TYSCMLIB . USIVENDF VEND 
						ON VEND . VNCODE = USHWAJU 
						LEFT OUTER JOIN TYSCMLIB . USIIPHAF IPHA 
						ON IPHA . IHHANGCHA = USHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICODEF GKCD 
						ON GKCD . CDINDEX = 'GK' 
						AND GKCD . CDCODE = USGOKJONG 
						LEFT OUTER JOIN TYSCMLIB . USICODEF CODE 
						ON CODE . CDINDEX = 'VS' 
						AND CODE . CDCODE = USHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICONTF CONT 
						ON CONT . CNYEAR = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 1 , 4 ) ) 
						AND CONT . CNSEQ = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 5 , 2 ) ) 
						WHERE USMCYYMM = P_DATE 
						AND USHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					) , 
  
					DETAIL AS 
					( 
						SELECT 
						'1' AS GUBUN , 
						IHIPHANG , 
						USHANGCHA , 
						USGOKJONG , 
						HANGCHNM , 
						GOKJGNM , 
						USHWAKQTY , 
						CNSISULAMT , 
						USUSEDAMT , 
						USUSEDVAT , 
						TOTAL 
						FROM ORIGINAL_DATA 
  
						UNION ALL 
  
						SELECT 
						'2' AS GUBUN , 
						'' AS IHIPHANG , 
						'' AS USHANGCHA , 
						'' AS USGOKJONG , 
						'' AS HANGCHNM , 
						'' AS GOKJGNM , 
						0 AS USHWAKQTY , 
						0 AS CNSISULAMT , 
						VALUE ( SUM ( USUSEDAMT ) , 0 ) AS USUSEDAMT , 
						VALUE ( SUM ( USUSEDVAT ) , 0 ) AS USUSEDVAT , 
						VALUE ( SUM ( TOTAL ) , 0 ) AS TOTAL 
						FROM ORIGINAL_DATA 
					) 
  
					SELECT 
					ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
					IHIPHANG , 
					HANGCHNM , 
					GOKJGNM , 
					TRIM(TO_CHAR(USHWAKQTY, '9,999,990.000')) AS USHWAKQTY , 
					CNSISULAMT , 
					USUSEDAMT , 
					USUSEDVAT , 
					TOTAL 
					FROM 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >합     계</div>' 
				ELSE IHIPHANG END ) AS IHIPHANG , 
						USHANGCHA , 
						USGOKJONG , 
						HANGCHNM , 
						GOKJGNM , 
						USHWAKQTY , 
						CNSISULAMT , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( USUSEDAMT , '999,999,999,990' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( USUSEDAMT , '999,999,999,990' ) ) END ) AS USUSEDAMT , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( USUSEDVAT , '999,999,999,990' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( USUSEDVAT , '999,999,999,990' ) ) END ) AS USUSEDVAT , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( TOTAL , '999,999,999,990' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( TOTAL , '999,999,999,990' ) ) END ) AS TOTAL 
						FROM DETAIL 
						ORDER BY GUBUN , USHANGCHA 
					) AS TEMP 
					WHERE ROWNO BETWEEN CAST ( P_STNUM AS VARCHAR ( 100 ) ) AND CAST ( P_FNNUM AS VARCHAR ( 100 ) ) ; 
				 
				OPEN REFCURSOR ; 
  
			END LIST ; 
  
			PAGING : BEGIN  -- 페이징 
				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR 
  
					WITH ORIGINAL_DATA AS 
					( 
						SELECT 
						( SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 1 , 4 ) || '/' || SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 5 , 2 ) || '/' || SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 7 , 2 ) ) AS IHIPHANG , 
						USHANGCHA , 
						USGOKJONG , 
						CODE . CDDESC1 AS HANGCHNM , 
						GKCD . CDDESC1 AS GOKJGNM , 
						USHWAKQTY , 
						CNSISULAMT , 
						USUSEDAMT , 
						USUSEDVAT , 
						( USUSEDAMT + USUSEDVAT ) AS TOTAL 
						FROM TYSCMLIB . USIMCUSF 
						LEFT OUTER JOIN TYSCMLIB . USIVENDF VEND 
						ON VEND . VNCODE = USHWAJU 
						LEFT OUTER JOIN TYSCMLIB . USIIPHAF IPHA 
						ON IPHA . IHHANGCHA = USHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICODEF GKCD 
						ON GKCD . CDINDEX = 'GK' 
						AND GKCD . CDCODE = USGOKJONG 
						LEFT OUTER JOIN TYSCMLIB . USICODEF CODE 
						ON CODE . CDINDEX = 'VS' 
						AND CODE . CDCODE = USHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICONTF CONT 
						ON CONT . CNYEAR = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 1 , 4 ) ) 
						AND CONT . CNSEQ = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 5 , 2 ) ) 
						WHERE USMCYYMM = P_DATE 
						AND USHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					) , 
  
					DETAIL AS 
					( 
						SELECT 
						'1' AS GUBUN , 
						IHIPHANG , 
						USHANGCHA , 
						USGOKJONG , 
						HANGCHNM , 
						GOKJGNM , 
						USHWAKQTY , 
						CNSISULAMT , 
						USUSEDAMT , 
						USUSEDVAT , 
						TOTAL 
						FROM ORIGINAL_DATA 
  
						UNION ALL 
  
						SELECT 
						'2' AS GUBUN , 
						'' AS IHIPHANG , 
						'' AS USHANGCHA , 
						'' AS USGOKJONG , 
						'' AS HANGCHNM , 
						'' AS GOKJGNM , 
						0 AS USHWAKQTY , 
						0 AS CNSISULAMT , 
						VALUE ( SUM ( USUSEDAMT ) , 0 ) AS USUSEDAMT , 
						VALUE ( SUM ( USUSEDVAT ) , 0 ) AS USUSEDVAT , 
						VALUE ( SUM ( TOTAL ) , 0 ) AS TOTAL 
						FROM ORIGINAL_DATA 
					) 
  
					SELECT 
					COUNT ( * ) AS TOTALCOUNT 
					FROM DETAIL ; 
  
				OPEN REFCURSOR2 ; 
  
			END PAGING ; 
  
		ELSE 
  
			PRINT : BEGIN  -- 페이징 
				DECLARE REFCURSOR3 CURSOR WITH RETURN FOR 
  
					SELECT 
					USHANGCHA , 
					USHWAJU , 
					SUBSTR ( VEND . VNSAUPJA , 1 , 3 ) || '-' || SUBSTR ( VEND . VNSAUPJA , 4 , 2 ) || '-' || SUBSTR ( VEND . VNSAUPJA , 6 , 5 ) AS VNSAUPJA , 
					VEND . VNSANGHO , 
					VEND . VNIRUM , 
					( CASE WHEN VEND . VNNEWADD = '' THEN VEND . VNTAXJUSO ELSE VEND . VNNEWADD END ) AS VNTAXJUSO , 
					( SUBSTR ( DIGITS ( USMCYYMM ) , 1 , 4 ) || '/' || SUBSTR ( DIGITS ( USMCYYMM ) , 5 , 2 ) ) AS MONTH , 
					( SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 1 , 4 ) || '/' || SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 5 , 2 ) || '/' || SUBSTR ( DIGITS ( IPHA . IHIPHANG ) , 7 , 2 ) ) AS IHIPHANG , 
					CODE . CDDESC1 AS HANGCHNM , 
					GKCD . CDDESC1 AS GOKJGNM , 
					( CASE WHEN CONT . CNSISULGB = '1' THEN '배정량' 
					WHEN CONT . CNSISULGB = '2' THEN '확정량' END ) AS QTYNM , 
					( CASE WHEN CONT1 . CNSISULGB = '1' THEN USBEJNQTY 
					WHEN CONT1 . CNSISULGB = '2' THEN USHWAKQTY END ) AS BEJNQTY , 
					CONT . CNSISULAMT , 
					USUSEDAMT , 
					USUSEDVAT , 
					( USUSEDAMT + USUSEDVAT ) AS TOTAMT , 
					( DIGITS ( USYYMMDD ) || USHANGCHA || USGOKJONG || USHWAJU || DIGITS ( USSEQ ) || USJPNO ) AS GUBUN 
					FROM TYSCMLIB . USIMCUSF 
					LEFT OUTER JOIN TYSCMLIB . USIVENDF VEND 
					ON VEND . VNCODE = USHWAJU 
					LEFT OUTER JOIN TYSCMLIB . USIIPHAF IPHA 
					ON IPHA . IHHANGCHA = USHANGCHA 
					LEFT OUTER JOIN TYSCMLIB . USICODEF GKCD 
					ON GKCD . CDINDEX = 'GK' 
					AND GKCD . CDCODE = USGOKJONG 
					LEFT OUTER JOIN TYSCMLIB . USICODEF CODE 
					ON CODE . CDINDEX = 'VS' 
					AND CODE . CDCODE = USHANGCHA 
					LEFT OUTER JOIN TYSCMLIB . USICONTF CONT 
					ON CONT . CNYEAR = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 1 , 4 ) ) 
					AND CONT . CNSEQ = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 5 , 2 ) ) 
					LEFT OUTER JOIN TYSCMLIB . USICONTF CONT1 
					ON CONT1 . CNYEAR = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 1 , 4 ) ) 
					AND CONT1 . CNSEQ = DECIMAL ( SUBSTR ( CHAR ( USCONTNO ) , 5 , 2 ) ) 
					WHERE USMCYYMM = P_DATE 
					AND USHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					ORDER BY USHANGCHA , USHWAJU ; 
  
				OPEN REFCURSOR3 ; 
  
			END PRINT ; 
  
		END IF ; 
  
	END MAIN ; 
END P1  ; 
  
GRANT ALTER , EXECUTE   
ON SPECIFIC PROCEDURE TYJINFWLIB.SP_TYCSS_CSS2030_LIST 
TO KSGPDM WITH GRANT OPTION ; 


CALL TYJINFWLIB.SP_TYCSS_CSS2030_LIST(1, 15, 202104, 'C02', 'S');