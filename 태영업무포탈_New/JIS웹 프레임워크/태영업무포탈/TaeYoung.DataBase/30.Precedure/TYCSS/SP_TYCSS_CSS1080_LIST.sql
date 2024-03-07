DROP PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1080_LIST;
CREATE PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1080_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE VARCHAR(8) , 
	IN P_EDATE VARCHAR(8) , 
	IN P_HWAJU VARCHAR(50) , 
	IN P_GUBUN VARCHAR(1) ) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSS_CSS1080_LIST 
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
	P1 : BEGIN  -- ���� 
	DECLARE P_STNUM INTEGER ; 
	DECLARE P_FNNUM INTEGER ; 
	DECLARE P_SQLSTRING VARCHAR ( 4000 ) ; 
	DECLARE P_SQLTOTALROWCOUNT VARCHAR ( 4000 ) ; 
	DECLARE P_TABLE_QUERY			VARCHAR ( 5000 ) ; 
	DECLARE P_COUNT_QUERY			VARCHAR ( 5000 ) ; 
  
	PREV : BEGIN  -- �� ���� 
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
	SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
	END PREV ; 
  
	MAIN : BEGIN  -- ����� 
		IF P_GUBUN = 'S' THEN 
  
			LIST : BEGIN  -- ����Ʈ 
				DECLARE REFCURSOR CURSOR WITH RETURN FOR 
  
					WITH MAST AS 
					( 
						SELECT 
						'A' AS GUBUN , 
						CHGOKJONG , 
						GKCODE . CDDESC1 AS GKDESC1 , 
						CHHANGCHA , 
						VSCODE . CDDESC1 AS VSDESC1 , 
						CHBLNO , 
						CHCHULDAT , 
						CHTKNO , 
						CHCUSTIL , 
						CHSEQ , 
						CHEMPTY , 
						CHTOTAL , 
						CHMTQTY , 
						SUBSTR ( DIGITS ( CHIPTIME ) , 1 , 2 ) || ':' || SUBSTR ( DIGITS ( CHIPTIME ) , 3 , 2 ) || '-' || SUBSTR ( DIGITS ( CHCHTIME ) , 1 , 2 ) || ':' || SUBSTR ( DIGITS ( CHCHTIME ) , 3 , 2 ) AS CHTIME , 
						CHNUMBER , 
						HJCODE . CDDESC1 AS HJDESC1 
						FROM TYSCMLIB . USICHULF AS CHUL 
						LEFT OUTER JOIN TYSCMLIB . USICODEF AS VSCODE 
						ON 'VS' = VSCODE . CDINDEX 
						AND CHUL . CHHANGCHA = VSCODE . CDCODE 
						LEFT OUTER JOIN TYSCMLIB . USICODEF AS GKCODE 
						ON 'GK' = GKCODE . CDINDEX 
						AND CHUL . CHGOKJONG = GKCODE . CDCODE 
						LEFT OUTER JOIN TYSCMLIB . USICODEF AS HJCODE 
						ON 'HJ' = HJCODE . CDINDEX 
						AND CHUL . CHYNHWAJU = HJCODE . CDCODE 
						WHERE CHCHULDAT BETWEEN P_SDATE AND P_EDATE 
						AND CHUL . CHHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					) , 
  
					HAP AS 
					( 
						SELECT 
						'B' AS GUBUN , 
						CHGOKJONG , 
						GKDESC1 , 
						'' AS CHHANGCHA , 
						'' AS VSDESC1 , 
						'' AS CHBLNO , 
						CHCHULDAT , 
						0 AS CHTKNO , 
						0 AS CHCUSTIL , 
						0 AS CHSEQ , 
						0 AS CHEMPTY , 
						0 AS CHTOTAL , 
						SUM ( CHMTQTY ) AS CHMTQTY , 
						'' AS CHTIME , 
						CHAR ( COUNT ( * ) ) AS CHNUMBER , 
						'' AS HJDESC1 
						FROM MAST 
						GROUP BY GROUPING SETS ( ( CHGOKJONG , GKDESC1 ) , ( CHCHULDAT , CHGOKJONG , GKDESC1 ) , '' ) 
					) , 
  
					DETAIL AS 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						GUBUN , 
						CHGOKJONG , 
						GKDESC1 , 
						CHHANGCHA , 
						VSDESC1 , 
						CHBLNO , 
						CHCHULDAT , 
						CHAR ( CHTKNO ) AS CHTKNO , 
						CHAR ( CHCUSTIL ) AS CHCUSTIL , 
						CHAR ( CHSEQ ) AS CHSEQ , 
						CHAR ( CHEMPTY ) AS CHEMPTY , 
						CHAR ( CHTOTAL ) AS CHTOTAL , 
						CHMTQTY , 
						CHTIME , 
						CHNUMBER , 
						HJDESC1 
						FROM MAST 
  
						UNION ALL 
  
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						GUBUN , 
						CHGOKJONG , 
						GKDESC1 , 
						CHHANGCHA , 
						VSDESC1 , 
						CHBLNO , 
						CHCHULDAT , 
						( CASE WHEN ( CHGOKJONG IS NULL AND GKDESC1 IS NULL AND CHHANGCHA = '' AND VSDESC1 = '' AND CHBLNO = '' AND CHCHULDAT IS NULL ) THEN '���հ�' 
							WHEN ( CHGOKJONG <> '' AND GKDESC1 <> '' AND CHHANGCHA = '' AND VSDESC1 = '' AND CHBLNO = '' AND CHCHULDAT IS NULL ) THEN '������' 
						ELSE '���ڰ�' END ) AS CHTKNO , 
						'' AS CHCUSTIL , 
						'' AS CHSEQ , 
						'' AS CHEMPTY , 
						'' AS CHTOTAL , 
						CHMTQTY , 
						'�������' AS CHTIME , 
						CHNUMBER , 
						'' AS HJDESC1 
						FROM HAP 
						ORDER BY CHGOKJONG , GKDESC1 , CHCHULDAT , GUBUN , CHHANGCHA , VSDESC1 , CHBLNO 
					) 
					 
					SELECT 
					* 
					FROM 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ORDER BY CHGOKJONG , GKDESC1 , CHCHULDAT , GUBUN , CHHANGCHA , VSDESC1 , CHBLNO ) AS ROWNO , 
						GUBUN , 
						GKDESC1 , 
						VSDESC1 , 
						CHBLNO , 
						( CASE WHEN CHTKNO = '���ڰ�' THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( CHCHULDAT ) ) || '</div>' 
							WHEN CHTKNO = '������' THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( CHCHULDAT ) ) || '</div>' 
							WHEN CHTKNO = '���հ�' THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( CHCHULDAT ) ) || '</div>' 
							ELSE TRIM ( TO_CHAR ( CHCHULDAT ) ) END ) AS CHCHULDAT , 
						( CASE WHEN CHTKNO = '���ڰ�' THEN '<div style="color:blue" >���ں� �Ұ�</div>' 
							WHEN CHTKNO = '������' THEN '<div style="color:red" >������ �Ұ�</div>' 
							WHEN CHTKNO = '���հ�' THEN '<div style="color:blue" >�� �� ��</div>' 
							ELSE CHTKNO END ) AS CHTKNO , 
						CHCUSTIL , 
						CHSEQ , 
						CHEMPTY , 
						CHTOTAL , 
						( CASE WHEN CHTKNO = '���ڰ�' THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( CHMTQTY , '9,999,990.000' ) ) || '</div>' 
							WHEN CHTKNO = '������' THEN '<div style="color:red" >' || TRIM ( TO_CHAR ( CHMTQTY , '9,999,990.000' ) ) || '</div>' 
							WHEN CHTKNO = '���հ�' THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( CHMTQTY , '9,999,990.000' ) ) || '</div>' 
							ELSE TRIM ( TO_CHAR ( CHMTQTY , '9,999,990.000' ) ) END ) AS CHMTQTY , 
						( CASE WHEN CHTKNO = '���ڰ�' THEN '<div style="color:blue" >' || TRIM ( CHTIME ) || '</div>' 
							WHEN CHTKNO = '������' THEN '<div style="color:red" >' || TRIM ( CHTIME ) || '</div>' 
							WHEN CHTKNO = '���հ�' THEN '<div style="color:blue" >' || TRIM ( CHTIME ) || '</div>' 
							ELSE TRIM ( CHTIME ) END ) AS CHTIME , 
						( CASE WHEN CHTKNO = '���ڰ�' THEN '<div style="color:blue" >' || TRIM ( CHNUMBER ) || '</div>' 
							WHEN CHTKNO = '������' THEN '<div style="color:red" >' || TRIM ( CHNUMBER ) || '</div>' 
							WHEN CHTKNO = '���հ�' THEN '<div style="color:blue" >' || TRIM ( CHNUMBER ) || '</div>' 
							ELSE TRIM ( CHNUMBER ) END ) AS CHNUMBER , 
						HJDESC1 
						FROM DETAIL 
					) AS TEMP 
					WHERE ROWNO BETWEEN CAST ( P_STNUM AS VARCHAR ( 100 ) ) AND CAST ( P_FNNUM AS VARCHAR ( 100 ) ) ; 
  
				OPEN REFCURSOR ; 
			 
			END LIST ; 
  
			PAGING : BEGIN  -- ����¡ 
				DECLARE REFCURSOR3 CURSOR WITH RETURN FOR 
  
					WITH MAST AS 
					( 
						SELECT 
						'A' AS GUBUN , 
						CHGOKJONG , 
						GKCODE . CDDESC1 AS GKDESC1 , 
						CHHANGCHA , 
						VSCODE . CDDESC1 AS VSDESC1 , 
						CHBLNO , 
						CHCHULDAT , 
						CHTKNO , 
						CHCUSTIL , 
						CHSEQ , 
						CHEMPTY , 
						CHTOTAL , 
						CHMTQTY , 
						SUBSTR ( DIGITS ( CHIPTIME ) , 1 , 2 ) || ':' || SUBSTR ( DIGITS ( CHIPTIME ) , 3 , 2 ) || '-' || SUBSTR ( DIGITS ( CHCHTIME ) , 1 , 2 ) || ':' || SUBSTR ( DIGITS ( CHCHTIME ) , 3 , 2 ) AS CHTIME , 
						CHNUMBER , 
						HJCODE . CDDESC1 AS HJDESC1 
						FROM TYSCMLIB . USICHULF AS CHUL 
						LEFT OUTER JOIN TYSCMLIB . USICODEF AS VSCODE 
						ON 'VS' = VSCODE . CDINDEX 
						AND CHUL . CHHANGCHA = VSCODE . CDCODE 
						LEFT OUTER JOIN TYSCMLIB . USICODEF AS GKCODE 
						ON 'GK' = GKCODE . CDINDEX 
						AND CHUL . CHGOKJONG = GKCODE . CDCODE 
						LEFT OUTER JOIN TYSCMLIB . USICODEF AS HJCODE 
						ON 'HJ' = HJCODE . CDINDEX 
						AND CHUL . CHYNHWAJU = HJCODE . CDCODE 
						WHERE CHCHULDAT BETWEEN P_SDATE AND P_EDATE 
						AND CHUL . CHHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					) , 
  
					HAP AS 
					( 
						SELECT 
						'B' AS GUBUN , 
						CHGOKJONG , 
						GKDESC1 , 
						'' AS CHHANGCHA , 
						'' AS VSDESC1 , 
						'' AS CHBLNO , 
						CHCHULDAT , 
						0 AS CHTKNO , 
						0 AS CHCUSTIL , 
						0 AS CHSEQ , 
						0 AS CHEMPTY , 
						0 AS CHTOTAL , 
						SUM ( CHMTQTY ) AS CHMTQTY , 
						'' AS CHTIME , 
						CHAR ( COUNT ( * ) ) AS CHNUMBER , 
						'' AS HJDESC1 
						FROM MAST 
						GROUP BY GROUPING SETS ( ( CHGOKJONG , GKDESC1 ) , ( CHCHULDAT , CHGOKJONG , GKDESC1 ) , '' ) 
					) , 
  
					DETAIL AS 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						GUBUN , 
						CHGOKJONG , 
						GKDESC1 , 
						CHHANGCHA , 
						VSDESC1 , 
						CHBLNO , 
						CHCHULDAT , 
						CHAR ( CHTKNO ) AS CHTKNO , 
						CHAR ( CHCUSTIL ) AS CHCUSTIL , 
						CHAR ( CHSEQ ) AS CHSEQ , 
						CHAR ( CHEMPTY ) AS CHEMPTY , 
						CHAR ( CHTOTAL ) AS CHTOTAL , 
						CHMTQTY , 
						CHTIME , 
						CHNUMBER , 
						HJDESC1 
						FROM MAST 
  
						UNION ALL 
  
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						GUBUN , 
						CHGOKJONG , 
						GKDESC1 , 
						CHHANGCHA , 
						VSDESC1 , 
						CHBLNO , 
						CHCHULDAT , 
						( CASE WHEN ( CHGOKJONG IS NULL AND GKDESC1 IS NULL AND CHHANGCHA = '' AND VSDESC1 = '' AND CHBLNO = '' AND CHCHULDAT IS NULL ) THEN '���հ�' 
							WHEN ( CHGOKJONG <> '' AND GKDESC1 <> '' AND CHHANGCHA = '' AND VSDESC1 = '' AND CHBLNO = '' AND CHCHULDAT IS NULL ) THEN '������' 
						ELSE '���ڰ�' END ) AS CHTKNO , 
						'' AS CHCUSTIL , 
						'' AS CHSEQ , 
						'' AS CHEMPTY , 
						'' AS CHTOTAL , 
						CHMTQTY , 
						'�������' AS CHTIME , 
						CHNUMBER , 
						'' AS HJDESC1 
						FROM HAP 
						ORDER BY CHGOKJONG , GKDESC1 , CHCHULDAT , GUBUN , CHHANGCHA , VSDESC1 , CHBLNO 
					) 
  
					SELECT 
					COUNT ( * ) AS TOTALCOUNT 
					FROM DETAIL ; 
  
				OPEN REFCURSOR3 ; 
  
			END PAGING ; 
  
		ELSE 
  
			PRINT : BEGIN  -- ����Ʈ 
				DECLARE REFCURSOR5 CURSOR WITH RETURN FOR 
  
					SELECT 
					'A' AS GUBUN , 
					CHGOKJONG , 
					GKCODE . CDDESC1 AS GKDESC1 , 
					CHHANGCHA , 
					VSCODE . CDDESC1 AS VSDESC1 , 
					CHBLNO , 
					CHCHULDAT , 
					CHTKNO , 
					CHCUSTIL , 
					CHSEQ , 
					CHEMPTY , 
					CHTOTAL , 
					CHMTQTY , 
					SUBSTR ( DIGITS ( CHIPTIME ) , 1 , 2 ) || ':' || SUBSTR ( DIGITS ( CHIPTIME ) , 3 , 2 ) || '-' || SUBSTR ( DIGITS ( CHCHTIME ) , 1 , 2 ) || ':' || SUBSTR ( DIGITS ( CHCHTIME ) , 3 , 2 ) AS CHTIME , 
					CHNUMBER , 
					HJCODE . CDDESC1 AS HJDESC1 
					FROM TYSCMLIB . USICHULF AS CHUL 
					LEFT OUTER JOIN TYSCMLIB . USICODEF AS VSCODE 
					ON 'VS' = VSCODE . CDINDEX 
					AND CHUL . CHHANGCHA = VSCODE . CDCODE 
					LEFT OUTER JOIN TYSCMLIB . USICODEF AS GKCODE 
					ON 'GK' = GKCODE . CDINDEX 
					AND CHUL . CHGOKJONG = GKCODE . CDCODE 
					LEFT OUTER JOIN TYSCMLIB . USICODEF AS HJCODE 
					ON 'HJ' = HJCODE . CDINDEX 
					AND CHUL . CHYNHWAJU = HJCODE . CDCODE 
					WHERE CHCHULDAT BETWEEN P_SDATE AND P_EDATE 
					AND CHUL . CHHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
					ORDER BY CHGOKJONG , GKDESC1 , CHCHULDAT , GUBUN , CHHANGCHA , VSDESC1 , CHBLNO ; 
  
				OPEN REFCURSOR5 ; 
  
			END PRINT ; 
  
		END IF ; 
  
	END MAIN ; 
  
END P1  ; 
  
GRANT ALTER , EXECUTE   
ON SPECIFIC PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1080_LIST 
TO KSGPDM WITH GRANT OPTION ; 


CALL TYJINFWLIB.SP_TYCSS_CSS1080_LIST(1,15, '20210501', '20210504', 'C02', 'S');