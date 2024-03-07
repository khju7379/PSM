--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSS_CSS2050_LIST;
  
SET PATH "QSYS","QSYS2","SYSPROC","SYSIBMADM","KSGPDM" ; 
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSS_CSS2050_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_DATE VARCHAR(6) , 
	IN P_HWAJU VARCHAR(50) , 
	IN P_GUBUN VARCHAR(1) ) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSS_CSS2050_LIST 
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
	DECLARE P_TABLE_QUERY VARCHAR ( 5000 ) ; 
	DECLARE P_COUNT_QUERY VARCHAR ( 5000 ) ; 
  
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
						HMMCYYMM , 
						( SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 1 , 4 ) || ' / ' || SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 5 , 2 ) || ' / ' || SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 7 , 2 ) ) AS IPHANG , 
						VSCD . CDDESC1 AS VSDESC1 , 
						GKCD . CDDESC1 AS GKDESC1 , 
						HMBEJNQTY , 
						CONT . CNHMAMT AS CNHMAMT , 
						HMHAMULAMT , 
						HMHAMULVAT , 
						( HMHAMULAMT + HMHAMULVAT ) AS TOTAMT , 
						HMHANGCHA , 
						HMGOKJONG 
						FROM TYSCMLIB . USIMCHMF 
						LEFT OUTER JOIN TYSCMLIB . USICODEF VSCD 
						ON VSCD . CDINDEX = 'VS' 
						AND VSCD . CDCODE = HMHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICODEF GKCD 
						ON GKCD . CDINDEX = 'GK' 
						AND GKCD . CDCODE = HMGOKJONG 
						LEFT OUTER JOIN TYSCMLIB . USIIPHAF IPHA 
						ON IPHA . IHHANGCHA = HMHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICONTF CONT 
						ON CONT . CNYEAR = DECIMAL ( SUBSTR ( CHAR ( HMCONTNO ) , 1 , 4 ) ) 
						AND CONT . CNSEQ = DECIMAL ( SUBSTR ( CHAR ( HMCONTNO ) , 5 , 2 ) ) 
						WHERE HMMCYYMM = P_DATE 
						AND HMHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					) , 
  
					DETAIL AS 
					( 
						SELECT 
						'1' AS GUBUN , 
						DIGITS ( HMMCYYMM ) AS HMMCYYMM , 
						IPHANG , 
						HMHANGCHA , 
						HMGOKJONG , 
						VSDESC1 , 
						GKDESC1 , 
						HMBEJNQTY , 
						CNHMAMT , 
						HMHAMULAMT , 
						HMHAMULVAT , 
						TOTAMT 
						FROM ORIGINAL_DATA 
  
						UNION ALL 
  
						SELECT 
						'2' AS GUBUN , 
						'' AS HMMCYYMM , 
						'' AS IPHANG , 
						'' AS HMHANGCHA , 
						'' AS HMGOKJONG , 
						'' AS VSDESC1 , 
						'' AS GKDESC1 , 
						0 AS HMBEJNQTY , 
						0 AS CNHMAMT , 
						VALUE ( SUM ( HMHAMULAMT ) , 0 ) AS HMHAMULAMT , 
						VALUE ( SUM ( HMHAMULVAT ) , 0 ) AS HMHAMULVAT , 
						VALUE ( SUM ( TOTAMT ) , 0 ) AS TOTAMT 
						FROM ORIGINAL_DATA 
					) 
					 
					SELECT 
					ROWNO , 
					HMMCYYMM , 
					IPHANG , 
					HMHANGCHA , 
					HMGOKJONG , 
					VSDESC1 , 
					GKDESC1 , 
					TRIM(TO_CHAR(HMBEJNQTY, '9,999,990.000')) AS HMBEJNQTY , 
					CNHMAMT , 
					HMHAMULAMT , 
					HMHAMULVAT , 
					TOTAMT 
					FROM 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >합     계</div>' 
				ELSE HMMCYYMM END ) AS HMMCYYMM , 
						IPHANG , 
						HMHANGCHA , 
						HMGOKJONG , 
						VSDESC1 , 
						GKDESC1 , 
						HMBEJNQTY , 
						CNHMAMT , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( HMHAMULAMT , '999,999,999,990' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( HMHAMULAMT , '999,999,999,990' ) ) END ) AS HMHAMULAMT , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( HMHAMULVAT , '999,999,999,990' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( HMHAMULVAT , '999,999,999,990' ) ) END ) AS HMHAMULVAT , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( TOTAMT , '999,999,999,990' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( TOTAMT , '999,999,999,990' ) ) END ) AS TOTAMT 
						FROM DETAIL 
						ORDER BY GUBUN , HMMCYYMM , HMHANGCHA , HMGOKJONG 
					) AS TEMP 
					WHERE ROWNO BETWEEN CAST ( P_STNUM AS VARCHAR ( 100 ) ) AND CAST ( P_FNNUM AS VARCHAR ( 100 ) ) ; 
				 
				OPEN REFCURSOR ; 
  
			END LIST ; 
  
			PAGING : BEGIN  -- 페이징 
				DECLARE REFCURSOR2 CURSOR WITH RETURN FOR 
  
					WITH ORIGINAL_DATA AS 
					( 
						SELECT 
						HMMCYYMM , 
						( SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 1 , 4 ) || ' / ' || SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 5 , 2 ) || ' / ' || SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 7 , 2 ) ) AS IPHANG , 
						VSCD . CDDESC1 AS VSDESC1 , 
						GKCD . CDDESC1 AS GKDESC1 , 
						HMBEJNQTY , 
						CONT . CNHMAMT AS CNHMAMT , 
						HMHAMULAMT , 
						HMHAMULVAT , 
						( HMHAMULAMT + HMHAMULVAT ) AS TOTAMT , 
						HMHANGCHA , 
						HMGOKJONG 
						FROM TYSCMLIB . USIMCHMF 
						LEFT OUTER JOIN TYSCMLIB . USICODEF VSCD 
						ON VSCD . CDINDEX = 'VS' 
						AND VSCD . CDCODE = HMHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICODEF GKCD 
						ON GKCD . CDINDEX = 'GK' 
						AND GKCD . CDCODE = HMGOKJONG 
						LEFT OUTER JOIN TYSCMLIB . USIIPHAF IPHA 
						ON IPHA . IHHANGCHA = HMHANGCHA 
						LEFT OUTER JOIN TYSCMLIB . USICONTF CONT 
						ON CONT . CNYEAR = DECIMAL ( SUBSTR ( CHAR ( HMCONTNO ) , 1 , 4 ) ) 
						AND CONT . CNSEQ = DECIMAL ( SUBSTR ( CHAR ( HMCONTNO ) , 5 , 2 ) ) 
						WHERE HMMCYYMM = P_DATE 
						AND HMHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					) , 
  
					DETAIL AS 
					( 
						SELECT 
						'1' AS GUBUN , 
						DIGITS ( HMMCYYMM ) AS HMMCYYMM , 
						IPHANG , 
						HMHANGCHA , 
						HMGOKJONG , 
						VSDESC1 , 
						GKDESC1 , 
						HMBEJNQTY , 
						CNHMAMT , 
						HMHAMULAMT , 
						HMHAMULVAT , 
						TOTAMT 
						FROM ORIGINAL_DATA 
  
						UNION ALL 
  
						SELECT 
						'2' AS GUBUN , 
						'합 계' AS HMMCYYMM , 
						'' AS IPHANG , 
						'' AS HMHANGCHA , 
						'' AS HMGOKJONG , 
						'' AS VSDESC1 , 
						'' AS GKDESC1 , 
						0 AS HMBEJNQTY , 
						0 AS CNHMAMT , 
						SUM ( HMHAMULAMT ) AS HMHAMULAMT , 
						SUM ( HMHAMULVAT ) AS HMHAMULVAT , 
						SUM ( TOTAMT ) AS TOTAMT 
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
					( SUBSTR ( VEND . VNSAUPJA , 1 , 3 ) || '-' || SUBSTR ( VEND . VNSAUPJA , 4 , 2 ) || '-' || SUBSTR ( VEND . VNSAUPJA , 6 , 5 ) ) AS VNSAUPJA , 
					VEND . VNSANGHO , 
					VEND . VNIRUM , 
					VEND . VNTAXJUSO , 
					( SUBSTR ( CHAR ( HMMCYYMM ) , 1 , 4 ) || ' / ' || SUBSTR ( CHAR ( HMMCYYMM ) , 5 , 2 ) ) AS MONTH , 
					HMMCYYMM , 
					( SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 1 , 4 ) || ' / ' || SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 5 , 2 ) || ' / ' || SUBSTR ( CHAR ( IPHA . IHIPHANG ) , 7 , 2 ) ) AS IPHANG , 
					VSCD . CDDESC1 AS VSDESC1 , 
					GKCD . CDDESC1 AS GKDESC1 , 
					HMBEJNQTY , 
					CONT . CNHMAMT AS CNHMAMT , 
					HMHAMULAMT , 
					HMHAMULVAT , 
					( HMHAMULAMT + HMHAMULVAT ) AS TOTAMT , 
					DIGITS ( HMMCYYMM ) || HMHANGCHA || HMGOKJONG AS GUBUN 
					FROM TYSCMLIB . USIMCHMF 
					LEFT OUTER JOIN TYSCMLIB . USIVENDF VEND 
					ON VEND . VNCODE = HMHWAJU 
					LEFT OUTER JOIN TYSCMLIB . USICODEF VSCD 
					ON VSCD . CDINDEX = 'VS' 
					AND VSCD . CDCODE = HMHANGCHA 
					LEFT OUTER JOIN TYSCMLIB . USICODEF GKCD 
					ON GKCD . CDINDEX = 'GK' 
					AND GKCD . CDCODE = HMGOKJONG 
					LEFT OUTER JOIN TYSCMLIB . USIIPHAF IPHA 
					ON IPHA . IHHANGCHA = HMHANGCHA 
					LEFT OUTER JOIN TYSCMLIB . USICONTF CONT 
					ON CONT . CNYEAR = DECIMAL ( SUBSTR ( CHAR ( HMCONTNO ) , 1 , 4 ) ) 
					AND CONT . CNSEQ = DECIMAL ( SUBSTR ( CHAR ( HMCONTNO ) , 5 , 2 ) ) 
					WHERE HMMCYYMM = P_DATE 
					AND HMHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					ORDER BY HMMCYYMM , HMHANGCHA , HMGOKJONG ; 
			 
				OPEN REFCURSOR3 ; 
  
			END PRINT ; 
  
		END IF ; 
  
	END MAIN ; 
END P1  ; 
  
GRANT ALTER , EXECUTE   
ON SPECIFIC PROCEDURE TYJINFWLIB.SP_TYCSS_CSS2050_LIST 
TO KSGPDM WITH GRANT OPTION ; 


CALL TYJINFWLIB.SP_TYCSS_CSS2050_LIST(1, 15, 201710, 'C02', 'S');