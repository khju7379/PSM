--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1010_DETAIL;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1010_DETAIL ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_HANGCHA VARCHAR(6),
	IN P_GOKJONG VARCHAR(2)) 

LANGUAGE SQL
RESULT SETS 2
    
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

	      LIST : BEGIN  -- 리스트 
			DECLARE REFCURSOR CURSOR WITH RETURN FOR

				WITH ORIGINAL_DATA AS
				(
					SELECT 
					ROW_NUMBER() OVER(ORDER BY IPIPDAT) AS ROWNO,
					IPIPDAT, 
					TRIM(TO_CHAR(SUM(IPIPPQTY), '9,999,990.000')) AS IPIPQTY,
					IHHANGCHA,
					VSCODE.CDDESC1 AS VSDESC1,
					IHIPHANG,
					IHGOKJONG1,
					GKCODE.CDDESC1 AS GKDESC1,
					SKCODE.CDDESC1 AS SKDESC1,
					IHBLQTY1
					FROM 
					(    
						SELECT                  
						IPIPDAT1 AS IPIPDAT,    
						IPIPPQTY1 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY1 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT2 AS IPIPDAT,    
						IPIPPQTY2 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY2 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT3 AS IPIPDAT,    
						IPIPPQTY3 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY3 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT4 AS IPIPDAT,    
						IPIPPQTY4 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY4 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT5 AS IPIPDAT,    
						IPIPPQTY5 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY5 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT6 AS IPIPDAT,    
						IPIPPQTY6 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY6 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT7 AS IPIPDAT,    
						IPIPPQTY7 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY7 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT8 AS IPIPDAT,    
						IPIPPQTY8 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY8 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT9 AS IPIPDAT,    
						IPIPPQTY9 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY9 <> 0    

						UNION ALL               

						SELECT                  
						IPIPDAT10 AS IPIPDAT,   
						IPIPPQTY10 AS IPIPPQTY  
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIPPQTY10 <> 0   

						UNION ALL               

						SELECT                  
						IPIDDAT1 AS IPIPDAT,    
						IPIDQTY1 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY1 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT2 AS IPIPDAT,    
						IPIDQTY2 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY2 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT3 AS IPIPDAT,    
						IPIDQTY3 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY3 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT4 AS IPIPDAT,    
						IPIDQTY4 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY4 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT5 AS IPIPDAT,    
						IPIDQTY5 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY5 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT6 AS IPIPDAT,    
						IPIDQTY6 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY6 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT7 AS IPIPDAT,    
						IPIDQTY7 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY7 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT8 AS IPIPDAT,    
						IPIDQTY8 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY8 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT9 AS IPIPDAT,    
						IPIDQTY9 AS IPIPPQTY    
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY9 <> 0     

						UNION ALL               

						SELECT                  
						IPIDDAT10 AS IPIPDAT,   
						IPIDQTY10 AS IPIPPQTY   
						FROM TYSCMLIB.USIIPGOF 
						WHERE IPHANGCHA = P_HANGCHA
						AND   IPGOKJONG = P_GOKJONG
						AND   IPIDQTY10 <> 0    
					) AS TEMP 
					LEFT OUTER JOIN TYSCMLIB.USIIPHAF AS IPHA
					ON      IPHA.IHHANGCHA  = P_HANGCHA
					LEFT OUTER JOIN TYSCMLIB.USICODEF AS GKCODE
					ON                 'GK' = GKCODE.CDINDEX
					AND     IPHA.IHGOKJONG1 = GKCODE.CDCODE
					LEFT OUTER JOIN TYSCMLIB.USICODEF AS SKCODE
					ON                 'SK' = SKCODE.CDINDEX
					AND     IPHA.IHSOSOK    = SKCODE.CDCODE
					LEFT OUTER JOIN TYSCMLIB.USICODEF AS VSCODE
					ON                 'VS' = VSCODE.CDINDEX
					AND      IPHA.IHHANGCHA = VSCODE.CDCODE
					GROUP BY IPIPDAT, IHHANGCHA, VSCODE.CDDESC1, IHIPHANG, IHGOKJONG1, GKCODE.CDDESC1, SKCODE.CDDESC1, IHBLQTY1
				)

				SELECT
				*
				FROM ORIGINAL_DATA AS A
				WHERE ROWNO BETWEEN CAST ( P_STNUM AS VARCHAR ( 100 ) )AND CAST ( P_FNNUM AS VARCHAR ( 100 ) )
				ORDER BY ROWNO ASC;
			
			OPEN REFCURSOR;

		END LIST;
	  
		PAGING : BEGIN  -- 페이징 
			
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR

						SELECT
						COUNT(*) AS TOTALCOUNT
						FROM
						(
							SELECT
							IPIPDAT,
							SUM(IPIPPQTY)
							FROM 
							(    
								SELECT                  
								IPIPDAT1 AS IPIPDAT,    
								IPIPPQTY1 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY1 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT2 AS IPIPDAT,    
								IPIPPQTY2 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY2 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT3 AS IPIPDAT,    
								IPIPPQTY3 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY3 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT4 AS IPIPDAT,    
								IPIPPQTY4 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY4 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT5 AS IPIPDAT,    
								IPIPPQTY5 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY5 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT6 AS IPIPDAT,    
								IPIPPQTY6 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY6 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT7 AS IPIPDAT,    
								IPIPPQTY7 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY7 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT8 AS IPIPDAT,    
								IPIPPQTY8 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY8 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT9 AS IPIPDAT,    
								IPIPPQTY9 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY9 <> 0    

								UNION ALL               

								SELECT                  
								IPIPDAT10 AS IPIPDAT,   
								IPIPPQTY10 AS IPIPPQTY  
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIPPQTY10 <> 0   

								UNION ALL               

								SELECT                  
								IPIDDAT1 AS IPIPDAT,    
								IPIDQTY1 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY1 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT2 AS IPIPDAT,    
								IPIDQTY2 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY2 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT3 AS IPIPDAT,    
								IPIDQTY3 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY3 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT4 AS IPIPDAT,    
								IPIDQTY4 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY4 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT5 AS IPIPDAT,    
								IPIDQTY5 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY5 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT6 AS IPIPDAT,    
								IPIDQTY6 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY6 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT7 AS IPIPDAT,    
								IPIDQTY7 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY7 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT8 AS IPIPDAT,    
								IPIDQTY8 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY8 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT9 AS IPIPDAT,    
								IPIDQTY9 AS IPIPPQTY    
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY9 <> 0     

								UNION ALL               

								SELECT                  
								IPIDDAT10 AS IPIPDAT,   
								IPIDQTY10 AS IPIPPQTY   
								FROM TYSCMLIB.USIIPGOF 
								WHERE IPHANGCHA = P_HANGCHA
								AND   IPGOKJONG = P_GOKJONG
								AND   IPIDQTY10 <> 0    
							) AS TEMP
							GROUP BY IPIPDAT
						) AS TEMP1;

			OPEN REFCURSOR2;

		END PAGING;

	END MAIN;
END P1;

CALL TYJINFWLIB.SP_TYCSS_CSS1010_DETAIL(1, 15, '201920', '11');