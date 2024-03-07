DROP PROCEDURE TYJINFWLIB.SP_TGCSI_CSG1020_DETAIL;
  
CREATE PROCEDURE TYJINFWLIB.SP_TGCSI_CSG1020_DETAIL ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_COMPANY VARCHAR(20) , 
	IN P_HANGCHA VARCHAR(7) , 
	IN P_GOKJONG VARCHAR(2) , 
	IN P_HWAJU VARCHAR(50) ) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TGCSI_CSG1020_DETAIL 
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
		IF P_COMPANY = '그레인' THEN 
  
			LIST_T : BEGIN  -- 리스트 
				DECLARE REFCURSOR_T CURSOR WITH RETURN FOR 
  
					WITH ORIGINAL_DATA AS 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ORDER BY GUBUN , JBHANGCHA , JBGOKJONG ) AS ROWNO , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >소     계</div>' 
						ELSE HJDESC1 END ) AS HJDESC1 , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( JBBEJNQTY , '999,999,999,990.000' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( JBBEJNQTY , '999,999,999,990.000' ) ) END ) AS JBBEJNQTY , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( JBHWAKQTY , '999,999,999,990.000' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( JBHWAKQTY , '999,999,999,990.000' ) ) END ) AS JBHWAKQTY , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( GAMQTY , '999,999,999,990.000' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( GAMQTY , '999,999,999,990.000' ) ) END ) AS GAMQTY 
						FROM 
						( 
							SELECT 
							ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
							'1' AS GUBUN , 
							HJCODE . CDDESC1 AS HJDESC1 , 
							JBHANGCHA , 
							JBGOKJONG , 
							( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) AS JBBEJNQTY , 
							( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) AS JBHWAKQTY , 
							( ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) - ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) ) AS GAMQTY 
							FROM TGSCMLIB . USIJEBLF AS JEBL 
							LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
							ON 'HJ' = HJCODE . CDINDEX 
							AND JEBL . JBHWAJU = HJCODE . CDCODE 
							WHERE JEBL . JBHANGCHA = P_HANGCHA 
							AND JEBL . JBGOKJONG = P_GOKJONG 
							AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
							AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
							AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
  
							UNION ALL 
  
							SELECT 
							ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
							'2' AS GUBUN , 
							'' AS HJDESC1 , 
							'' AS JBHANGCHA , 
							'' AS JBGOKJONG , 
							VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) AS JBBEJNQTY , 
							VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) AS JBHWAKQTY , 
							( VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) - VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) ) AS GAMQTY 
							FROM TGSCMLIB . USIJEBLF AS JEBL 
							LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
							ON 'HJ' = HJCODE . CDINDEX 
							AND JEBL . JBHWAJU = HJCODE . CDCODE 
							WHERE JEBL . JBHANGCHA = P_HANGCHA 
							AND JEBL . JBGOKJONG = P_GOKJONG 
							AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
							AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
							AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
						) AS TEMP 
					) 
  
					SELECT 
					* 
					FROM ORIGINAL_DATA AS A 
					WHERE ROWNO BETWEEN CAST ( P_STNUM AS VARCHAR ( 100 ) ) AND CAST ( P_FNNUM AS VARCHAR ( 100 ) ) 
					ORDER BY ROWNO ; 
  
				OPEN REFCURSOR_T ; 
  
			END LIST_T ; 
  
			PAGING_T : BEGIN  -- 페이징 
				DECLARE REFCURSOR_T CURSOR WITH RETURN FOR 
					 
					WITH ORIGINAL_DATA AS 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						'1' AS GUBUN , 
						HJCODE . CDDESC1 AS HJDESC1 , 
						JBHANGCHA , 
						JBGOKJONG , 
						( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) AS JBBEJNQTY , 
						( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) AS JBHWAKQTY , 
						( ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) - ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) ) AS GAMQTY 
						FROM TGSCMLIB . USIJEBLF AS JEBL 
						LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
						ON 'HJ' = HJCODE . CDINDEX 
						AND JEBL . JBHWAJU = HJCODE . CDCODE 
						WHERE JEBL . JBHANGCHA = P_HANGCHA 
						AND JEBL . JBGOKJONG = P_GOKJONG 
						AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
						AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
						AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
  
						UNION ALL 
  
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						'2' AS GUBUN , 
						'' AS HJDESC1 , 
						'' AS JBHANGCHA , 
						'' AS JBGOKJONG , 
						VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) AS JBBEJNQTY , 
						VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) AS JBHWAKQTY , 
						( VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) - VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) ) AS GAMQTY 
						FROM TGSCMLIB . USIJEBLF AS JEBL 
						LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
						ON 'HJ' = HJCODE . CDINDEX 
						AND JEBL . JBHWAJU = HJCODE . CDCODE 
						WHERE JEBL . JBHANGCHA = P_HANGCHA 
						AND JEBL . JBGOKJONG = P_GOKJONG 
						AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
						AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
						AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
					) 
  
					SELECT 
					COUNT ( * ) AS TOTALCOUNT 
					FROM ORIGINAL_DATA ; 
  
				OPEN REFCURSOR_T ; 
  
			END PAGING_T ; 
		ELSE 
  
			LIST_P : BEGIN  -- 리스트 
				DECLARE REFCURSOR_P CURSOR WITH RETURN FOR 
  
					WITH ORIGINAL_DATA AS 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ORDER BY GUBUN , JBHANGCHA , JBGOKJONG ) AS ROWNO , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >소     계</div>' 
						ELSE HJDESC1 END ) AS HJDESC1 , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( JBBEJNQTY , '999,999,999,990.000' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( JBBEJNQTY , '999,999,999,990.000' ) ) END ) AS JBBEJNQTY , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( JBHWAKQTY , '999,999,999,990.000' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( JBHWAKQTY , '999,999,999,990.000' ) ) END ) AS JBHWAKQTY , 
						( CASE WHEN GUBUN IN ( '2' ) THEN '<div style="color:blue" >' || TRIM ( TO_CHAR ( GAMQTY , '999,999,999,990.000' ) ) || '</div>' 
						ELSE TRIM ( TO_CHAR ( GAMQTY , '999,999,999,990.000' ) ) END ) AS GAMQTY 
						FROM 
						( 
							SELECT 
							ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
							'1' AS GUBUN , 
							HJCODE . CDDESC1 AS HJDESC1 , 
							JBHANGCHA , 
							JBGOKJONG , 
							( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) AS JBBEJNQTY , 
							( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) AS JBHWAKQTY , 
							( ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) - ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) ) AS GAMQTY 
							FROM PTSCMLIB . USIJEBLF AS JEBL 
							LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
							ON 'HJ' = HJCODE . CDINDEX 
							AND JEBL . JBHWAJU = HJCODE . CDCODE 
							WHERE JEBL . JBHANGCHA = P_HANGCHA 
							AND JEBL . JBGOKJONG = P_GOKJONG 
							AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
							AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
							AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
  
							UNION ALL 
  
							SELECT 
							ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
							'2' AS GUBUN , 
							'' AS HJDESC1 , 
							'' AS JBHANGCHA , 
							'' AS JBGOKJONG , 
							VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) AS JBBEJNQTY , 
							VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) AS JBHWAKQTY , 
							( VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) - VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) ) AS GAMQTY 
							FROM PTSCMLIB . USIJEBLF AS JEBL 
							LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
							ON 'HJ' = HJCODE . CDINDEX 
							AND JEBL . JBHWAJU = HJCODE . CDCODE 
							WHERE JEBL . JBHANGCHA = P_HANGCHA 
							AND JEBL . JBGOKJONG = P_GOKJONG 
							AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
							AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
							AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
						) AS TEMP 
					) 
  
					SELECT 
					* 
					FROM ORIGINAL_DATA AS A 
					WHERE ROWNO BETWEEN CAST ( P_STNUM AS VARCHAR ( 100 ) ) AND CAST ( P_FNNUM AS VARCHAR ( 100 ) ) 
					ORDER BY ROWNO ; 
  
				OPEN REFCURSOR_P ; 
  
			END LIST_P ; 
  
			PAGING_P : BEGIN  -- 페이징 
				DECLARE REFCURSOR_P CURSOR WITH RETURN FOR 
  
					WITH ORIGINAL_DATA AS 
					( 
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						'1' AS GUBUN , 
						HJCODE . CDDESC1 AS HJDESC1 , 
						JBHANGCHA , 
						JBGOKJONG , 
						( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) AS JBBEJNQTY , 
						( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) AS JBHWAKQTY , 
						( ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) - ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) ) AS GAMQTY 
						FROM PTSCMLIB . USIJEBLF AS JEBL 
						LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
						ON 'HJ' = HJCODE . CDINDEX 
						AND JEBL . JBHWAJU = HJCODE . CDCODE 
						WHERE JEBL . JBHANGCHA = P_HANGCHA 
						AND JEBL . JBGOKJONG = P_GOKJONG 
						AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
						AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
						AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
  
						UNION ALL 
  
						SELECT 
						ROW_NUMBER ( ) OVER ( ) AS ROWNO , 
						'2' AS GUBUN , 
						'' AS HJDESC1 , 
						'' AS JBHANGCHA , 
						'' AS JBGOKJONG , 
						VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) AS JBBEJNQTY , 
						VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) AS JBHWAKQTY , 
						( VALUE ( SUM ( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) , 0 ) - VALUE ( SUM ( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) , 0 ) ) AS GAMQTY 
						FROM PTSCMLIB . USIJEBLF AS JEBL 
						LEFT OUTER JOIN TGSCMLIB . USICODEF AS HJCODE 
						ON 'HJ' = HJCODE . CDINDEX 
						AND JEBL . JBHWAJU = HJCODE . CDCODE 
						WHERE JEBL . JBHANGCHA = P_HANGCHA 
						AND JEBL . JBGOKJONG = P_GOKJONG 
						AND JEBL . JBHWAJU IN ( SELECT * FROM TABLE ( PTSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
						AND ( JEBL . JBBEJNQTY + JEBL . JBBEIPQTY - JEBL . JBBECHQTY ) <> 0 
						AND ( JEBL . JBHWAKQTY + JEBL . JBHWIPQTY - JEBL . JBHWCHQTY ) <> 0 
					) 
  
					SELECT 
					COUNT ( * ) AS TOTALCOUNT 
					FROM ORIGINAL_DATA ; 
  
				OPEN REFCURSOR_P ; 
  
			END PAGING_P ; 
  
		END IF ; 
  
	END MAIN ; 
END P1  ; 

