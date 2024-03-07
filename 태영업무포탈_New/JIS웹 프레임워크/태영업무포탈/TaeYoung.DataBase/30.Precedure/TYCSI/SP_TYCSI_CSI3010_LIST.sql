DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3010_LIST;
--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	21-07-13 13:38:45 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
SET PATH "QSYS","QSYS2","SYSPROC","SYSIBMADM","LSHPDM" ; 
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3010_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE    VARCHAR(8),
	IN P_EDATE    VARCHAR(8),
    IN P_HWAJU    VARCHAR(50),
	IN P_HWAMUL   VARCHAR(3),
	IN P_CHHJ     VARCHAR(3),
	IN P_CARNO    VARCHAR(4),
	IN P_TANKNO   VARCHAR(4)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI3010_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
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
LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
			WITH TABLE1 AS(
			SELECT 
			JISI.JIYYMM,
			JISI.JISEQ,
			HMCODE.CDDESC1 AS HMDESC1, -- 출고화물
			DCCODE.CDDESC1 AS DCDESC1, -- 도착지
			JISI.JITANKNO,             -- 출고탱크
			CHMTQTY AS JICHQTY,        -- 출고수량
			JISI.JICARNO2,             -- 차량번호
			JISI.JICONTNUM,            -- 컨테이너번호
			(CASE WHEN JISI.JITMGUBN = '1' THEN '일반'
			      WHEN JISI.JITMGUBN = '2' THEN '조출'
			      WHEN JISI.JITMGUBN = '3' THEN '특허' ELSE '' END) AS JITMGUBN, -- 특허구분
			(CASE WHEN JISI.JIWKTYPE = '01' THEN 'TANK LORRY' 
			      WHEN JISI.JIWKTYPE = '02' THEN 'ISO TANK' 
			      WHEN JISI.JIWKTYPE = '03' THEN 'FLEXI BAG' ELSE '' END) AS JIWKTYPE,-- 출고유형
			(CASE WHEN JISI.JISTMTQTY <> 0 THEN 'MT' ELSE 'L' END) AS QTYGUBN,                     -- 수량구분
			(CASE WHEN JISI.JISTMTQTY = 0 THEN JISI.JISTLTQTY ELSE JISI.JISTMTQTY END) AS JISTQTY, -- 지시수량
			(CASE WHEN JISI.JIEDMTQTY = 0 THEN JISI.JIEDLTQTY ELSE JISI.JIEDMTQTY END) AS JIEDQTY, -- 지시수량
			
			(CASE WHEN JI.JIYYMM > 0 THEN 
				(CASE WHEN CHUL.CHMTQTY > 0 THEN  
				  	       '출고완료' 
				      ELSE 
					       '지시완료' 
			         END)
			ELSE '대 기' END) AS JISTATUS,-- 출고상태
			JISI.JICARNO1   -- 지시사항
			FROM TYSCMLIB.UTIORDERF AS JISI 
			LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS JGVEND 
			ON JISI.JIJGHWAJU = JGVEND.VNCODE 
			LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
			ON 'HM' = HMCODE.CDINDEX 
			AND JISI.JIHWAMUL = HMCODE.CDCODE 
			LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
			ON 'VS' = VSCODE.CDINDEX 
			AND JISI.JIBONSUN = VSCODE.CDCODE 
			LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND 
			ON JISI.JIHWAJU = VEND.VNCODE 
			LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE 
			ON 'DC' = DCCODE.CDINDEX 
			AND JISI.JICHHJ = DCCODE.CDCODE 
			LEFT OUTER JOIN TYSCMLIB.UTIJISIF AS JI 
			ON DIGITS(JI.JIYYMM) || DIGITS(JI.JISEQ) = DIGITS(JISI.JISINO1) || DIGITS(JISI.JISINO2) 
			AND JI.JIYYMM > 0 
			LEFT OUTER JOIN TYSCMLIB.UTICHULF AS CHUL 
			ON DIGITS(CHUL.CHJISINUM) = DIGITS(JISI.JISINO1) || DIGITS(JISI.JISINO2) 
			AND CHUL.CHJISINUM > 0 
			WHERE JISI.JIYYMM BETWEEN P_SDATE AND P_EDATE
			AND   JISI.JIJGHWAJU IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST( P_HWAJU AS VARCHAR(100)), ',')) AS InTable ) 
			AND   JISI.JIHWAMUL LIKE  P_HWAMUL||'%'
			AND   JISI.JICHHJ   LIKE  P_CHHJ||'%'
			AND   JISI.JICARNO2 LIKE  '%'||P_CARNO||'%'
			AND   TRIM(JISI.JITANKNO)  LIKE P_TANKNO||'%'
			ORDER BY JISI.JIYYMM,JISI.JISEQ 
			),ORIGINAL_DATA AS(
			SELECT ROW_NUMBER() OVER(ORDER BY JIYYMM,JISEQ) AS ROWNO,
				JIYYMM,
				JISEQ,
				HMDESC1,
				DCDESC1,
				JITANKNO,  -- 출고탱크
				JICHQTY,   -- 출고수량
				JICARNO2,  -- 차량번호
				JICONTNUM, -- 컨테이너번호
				JITMGUBN,  -- 특허구분
				JIWKTYPE,  -- 출고유형
				JISTQTY,
				JIEDQTY,
				JISTATUS,
				JICARNO1,
				QTYGUBN    -- 수량구분
			FROM TABLE1 
			) 
			SELECT ROWNO,
				JIYYMM,
				JISEQ,
				HMDESC1,
				DCDESC1,
				JITANKNO,  -- 출고탱크
				JICARNO2,  -- 차량번호
				JICONTNUM, -- 컨테이너번호
				JITMGUBN,  -- 특허구분
				JIWKTYPE,  -- 출고유형
				(CASE WHEN QTYGUBN = 'MT' THEN (CASE WHEN JIEDQTY = 0 THEN TRIM(TO_CHAR(JISTQTY,'9,999,990.000')) || ' (MT)'
				                                     ELSE TRIM(TO_CHAR(JISTQTY,'9,999,990.000')) || '~' || TRIM(TO_CHAR(JIEDQTY,'9,999,990.000')) || ' (MT)' END)
				      ELSE (CASE WHEN JIEDQTY = 0 THEN TRIM(TO_CHAR(JISTQTY,'9,999,990')) || ' (L)' 
				                 ELSE TRIM(TO_CHAR(JISTQTY,'9,999,990')) || '~' || TRIM(TO_CHAR(JIEDQTY,'9,999,990')) || ' (L)' END)
				      END) AS JIQTY,

				TRIM(TO_CHAR(JISTQTY,'9,999,990.000')) AS JISTQTY,
				TRIM(TO_CHAR(JIEDQTY,'9,999,990.000')) AS JIEDQTY,
				TRIM(TO_CHAR(JICHQTY,'9,999,990.000')) AS JICHQTY,
				JISTATUS,
				JICARNO1,
				QTYGUBN    -- 수량구분
			FROM ORIGINAL_DATA 
			WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM 
			ORDER BY ROWNO ASC ; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
	PAGING : BEGIN  -- 페이징 					 
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR			 
				WITH TABLE1 AS ( 
				SELECT 
				JISI . JIYYMM , 
				JISI . JISEQ , 
				JGVEND . VNSANGHO AS JGVEND , 
				HMCODE . CDDESC1 AS HMDESC1 , 
				DCCODE . CDDESC1 AS DCDESC1 , 
				( CASE WHEN JISI . JIWKTYPE = '01' THEN 'TANK LORRY' 
				WHEN JISI . JIWKTYPE = '02' THEN 'ISO TANK' 
				WHEN JISI . JIWKTYPE = '03' THEN 'FLEXI BAG' ELSE '' END ) AS JIWKTYPE , 
				JISI . JICARNO2 , 
				JISI . JICONTNUM , 
				( CASE WHEN JISI . JISTMTQTY = 0 THEN JISI . JISTLTQTY ELSE JISI . JISTMTQTY END ) AS JISTQTY , 
				( CASE WHEN JISI . JIEDMTQTY = 0 THEN JISI . JIEDLTQTY ELSE JISI . JIEDMTQTY END ) AS JIEDQTY , 
				CHMTQTY AS JICHQTY , 
				CASE WHEN JI . JIYYMM > 0 THEN 
					CASE WHEN CHUL . CHMTQTY > 0 THEN 
						'출고완료' 
					ELSE 
						'지시완료' 
					END 
				ELSE 
				'대 기' 
				END AS JISTATUS , 
				JISI . JICARNO1 
				FROM TYSCMLIB . UTIORDERF AS JISI 
				LEFT OUTER JOIN TYSCMLIB . UTIVENDF AS JGVEND 
				ON JISI . JIJGHWAJU = JGVEND . VNCODE 
				LEFT OUTER JOIN TYSCMLIB . UTICODEF AS HMCODE 
				ON 'HM' = HMCODE . CDINDEX 
				AND JISI . JIHWAMUL = HMCODE . CDCODE 
				LEFT OUTER JOIN TYSCMLIB . UTICODEF AS VSCODE 
				ON 'VS' = VSCODE . CDINDEX 
				AND JISI . JIBONSUN = VSCODE . CDCODE 
				LEFT OUTER JOIN TYSCMLIB . UTIVENDF AS VEND 
				ON JISI . JIHWAJU = VEND . VNCODE 
				LEFT OUTER JOIN TYSCMLIB . UTICODEF AS DCCODE 
				ON 'DC' = DCCODE . CDINDEX 
				AND JISI . JICHHJ = DCCODE . CDCODE 
				LEFT OUTER JOIN TYSCMLIB . UTIJISIF AS JI 
				ON DIGITS ( JI . JIYYMM ) || DIGITS ( JI . JISEQ ) = DIGITS ( JISI . JISINO1 ) || DIGITS ( JISI . JISINO2 ) 
				AND JI . JIYYMM > 0 
				LEFT OUTER JOIN TYSCMLIB . UTICHULF AS CHUL 
				ON DIGITS ( CHUL . CHJISINUM ) = DIGITS ( JISI . JISINO1 ) || DIGITS ( JISI . JISINO2 ) 
				AND CHUL . CHJISINUM > 0 
				WHERE JISI.JIYYMM BETWEEN P_SDATE AND P_EDATE
				AND   JISI.JIJGHWAJU IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST( P_HWAJU AS VARCHAR(100)), ',')) AS InTable ) 
				AND   JISI.JIHWAMUL LIKE  P_HWAMUL||'%'
				AND   JISI.JICHHJ   LIKE  P_CHHJ||'%'
				AND   JISI.JICARNO2 LIKE  '%'||P_CARNO||'%'
				AND   TRIM(JISI.JITANKNO)  LIKE P_TANKNO||'%'

				ORDER BY JISI . JIYYMM , JISI . JISEQ 
				) , ORIGINAL_DATA AS ( 
				SELECT ROW_NUMBER ( ) OVER ( ORDER BY JIYYMM , JISEQ ) AS ROWNO , 
					JIYYMM , 
					JISEQ , 
					JGVEND , 
					HMDESC1 , 
					DCDESC1 , 
					JIWKTYPE , 
					JICARNO2 , 
					JICONTNUM , 
					JISTQTY , 
					JIEDQTY , 
					JICHQTY , 
					JISTATUS , 
					JICARNO1 
				FROM TABLE1 
				)						 
				SELECT 
					COUNT ( * ) AS TOTALCOUNT 
				FROM ORIGINAL_DATA ; 
  
			OPEN REFCURSOR2 ; 
  
	END PAGING ; 
  
END MAIN ; 
END  ; 
  
GRANT ALTER , EXECUTE   
ON SPECIFIC PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3010_LIST 
TO LSHPDM WITH GRANT OPTION ;
