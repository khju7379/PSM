DROP PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1070_LIST;

--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	21-05-11 16:02:14 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
SET PATH "QSYS","QSYS2","SYSPROC","SYSIBMADM","KSGPDM" ; 
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1070_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_DATE VARCHAR(8) , 
	IN P_HWAJU VARCHAR(50) , 
	IN P_GUBUN VARCHAR(1) ) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSS_CSS1070_LIST 
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
  
	 -- 임시 테이블 
	DECLARE V_ROWNO INTEGER ; 
	DECLARE V_HAPBAE NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPHWAK NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPCS NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPCHUL NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPYD NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPYS NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPYSYD NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPYSCH NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HAPJAE NUMERIC ( 12 , 3 ) ; 
	DECLARE V_HANGCHA VARCHAR ( 6 ) ; 
	DECLARE V_BLNO VARCHAR ( 16 ) ; 
	DECLARE V_BLMSN VARCHAR ( 4 ) ; 
	DECLARE V_BLHSN VARCHAR ( 4 ) ; 
	DECLARE V_CSHMNO2 VARCHAR ( 6 ) ; 
	DECLARE V_CSDATE VARCHAR ( 11 ) ; 
	DECLARE V_CSSINNO VARCHAR ( 20 ) ; 
  
	 -- SELECT 
	DECLARE V_IHIPHANG VARCHAR ( 10 ) ; 
	DECLARE V_JBHANGCHA VARCHAR ( 6 ) ; 
	DECLARE V_JBGOKJONG VARCHAR ( 3 ) ; 
	DECLARE V_JBBLNO VARCHAR ( 16 ) ; 
	DECLARE V_JBBLMSN VARCHAR ( 4 ) ; 
	DECLARE V_JBBLHSN VARCHAR ( 4 ) ; 
	DECLARE V_JBHMNO1 VARCHAR ( 4 ) ; 
	DECLARE V_JBHMNO2 VARCHAR ( 6 ) ; 
	DECLARE V_VSDESC1 VARCHAR ( 50 ) ; 
	DECLARE V_GKDESC1 VARCHAR ( 50 ) ; 
	DECLARE V_JBBEJNQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBHWAKQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBYDQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBYSQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBYSYDQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBCSQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBCHQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBYSCHQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_JBJEGOQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_IBHWAKQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_CSQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_CHMTQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_CHYNCHQTY NUMERIC ( 12 , 3 ) ; 
  
	DECLARE V_COUNT INTEGER ;	 
  
	DECLARE V_YNQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_YSQTY NUMERIC ( 12 , 3 ) ; 
	DECLARE V_YSYDQTY NUMERIC ( 12 , 3 ) ; 
  
  
	 -- 임시 테이블 
	SET V_ROWNO = 0 ; 
	SET V_HAPBAE = 0 ; 
	SET V_HAPHWAK = 0 ; 
	SET V_HAPCS = 0 ; 
	SET V_HAPCHUL = 0 ; 
	SET V_HAPYD = 0 ; 
	SET V_HAPYS = 0 ; 
	SET V_HAPYSYD = 0 ; 
	SET V_HAPYSCH = 0 ; 
	SET V_HAPJAE = 0 ; 
	SET V_HANGCHA = '' ; 
	SET V_BLNO = '' ; 
	SET V_BLMSN = '' ; 
	SET V_BLHSN = '' ; 
	SET V_CSHMNO2 = '' ; 
	SET V_CSDATE = '' ; 
	SET V_CSSINNO = '' ; 
  
	 -- SELECT 
	SET V_IHIPHANG = '' ; 
	SET V_JBHANGCHA = '' ; 
	SET V_JBGOKJONG = '' ; 
	SET V_JBBLNO = '' ; 
	SET V_JBBLMSN = '' ; 
	SET V_JBBLHSN = '' ; 
	SET V_JBHMNO1 = '' ; 
	SET V_JBHMNO2 = '' ; 
	SET V_VSDESC1 = '' ; 
	SET V_GKDESC1 = '' ; 
	SET V_JBBEJNQTY = 0 ; 
	SET V_JBHWAKQTY = 0 ; 
	SET V_JBYDQTY = 0 ; 
	SET V_JBYSQTY = 0 ; 
	SET V_JBYSYDQTY = 0 ; 
	SET V_JBCSQTY = 0 ; 
	SET V_JBCHQTY = 0 ; 
	SET V_JBYSCHQTY = 0 ; 
	SET V_JBJEGOQTY = 0 ; 
	SET V_IBHWAKQTY = 0 ; 
	SET V_CSQTY = 0 ; 
	SET V_CHMTQTY = 0 ; 
	SET V_CHYNCHQTY = 0 ; 
	 
  
	SET V_COUNT = 0 ;	 
  
	SET V_YNQTY = 0 ; 
	SET V_YSQTY = 0 ; 
	SET V_YSYDQTY = 0 ; 
  
  
	PREV : BEGIN  -- 값 설정 
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
	SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
	END PREV ; 
  
  
	 -- 임시테이블부 
	DECLARE GLOBAL TEMPORARY TABLE SESSION . SILO_CSS1070 ( 
			ROWNO			INTEGER 
		,	HAPBAE NUMERIC ( 12 , 3 ) 
		,	HAPHWAK NUMERIC ( 12 , 3 ) 
		,	HAPCS NUMERIC ( 12 , 3 ) 
		,	HAPCHUL NUMERIC ( 12 , 3 ) 
		,	HAPYD NUMERIC ( 12 , 3 ) 
		,	HAPYS NUMERIC ( 12 , 3 ) 
		,	HAPYSYD NUMERIC ( 12 , 3 ) 
		,	HAPYSCH NUMERIC ( 12 , 3 ) 
		,	HAPJAE NUMERIC ( 12 , 3 ) 
		,	VSDESC1 VARCHAR ( 50 ) 
		,	GKDESC1 VARCHAR ( 50 ) 
		,	IHIPHANG VARCHAR ( 10 ) 
		,	HANGCHA VARCHAR ( 6 ) 
		, BLNO VARCHAR ( 16 ) 
		,	CSHMNO2 VARCHAR ( 6 ) 
		,	CSDATE VARCHAR ( 11 ) 
		,	CSSINNO VARCHAR ( 20 ) 
	) WITH REPLACE ; 
  
	R1 : FOR C1 AS 
			 
			SELECT 
			JBHANGCHA , 
			( SUBSTR ( CHAR ( IHIPHANG ) , 1 , 4 ) || '-' || SUBSTR ( CHAR ( IHIPHANG ) , 5 , 2 ) || '-' || SUBSTR ( CHAR ( IHIPHANG ) , 7 , 2 ) ) AS IHIPHANG , 
			JBGOKJONG , 
			JBBLNO , 
			DIGITS ( JBBLMSN ) AS JBBLMSN , 
			DIGITS ( JBBLHSN ) AS JBBLHSN , 
			( JBBEJNQTY + JBBEIPQTY - JBBECHQTY ) AS JBBEJNQTY , 
			( JBHWAKQTY + JBHWIPQTY - JBHWCHQTY ) AS JBHWAKQTY , 
			JBYDQTY , 
			JBYSQTY , 
			JBYSYDQTY , 
			JBCSQTY , 
			JBCHQTY , 
			JBYSCHQTY , 
			JBJEGOQTY , 
			VSCODE . CDDESC1 AS VSDESC1 , 
			GKCODE . CDDESC1 AS GKDESC1 , 
			DIGITS ( JBHMNO1 ) AS JBHMNO1 , 
			DIGITS ( JBHMNO2 ) AS JBHMNO2 , 
			--DIGITS ( CSHMNO2 ) AS CSHMNO2 , 
			--TRIM ( DIGITS ( CSDATE ) || '-' || DIGITS ( CSSEQ ) ) AS CSDATE , 
			--CSSINNO , 
			( 
				SELECT 
				COALESCE ( SUM ( IBHWAKQTY + IBHWIPQTY - IBHWCHQTY ) , 0 ) 
				FROM TYSCMLIB . USIIPBLF 
				WHERE IBHANGCHA = JEBL . JBHANGCHA 
				AND IBGOKJONG = JEBL . JBGOKJONG 
				AND IBHWAJU = JEBL . JBHWAJU 
				AND IBBLNO = JEBL . JBBLNO 
				AND IBBLMSN = JEBL . JBBLMSN 
				AND IBBLHSN = JEBL . JBBLHSN 
				AND IBHMNO1 = JEBL.JBHMNO1
				AND IBHMNO2 = JEBL.JBHMNO2
				AND IBDATE > INT ( P_DATE ) 
			) AS IBHWAKQTY , 
			( 
				SELECT 
				COALESCE ( SUM ( CS . CSQTY ) , 0 ) 
				FROM TYSCMLIB . USICUSTF AS CS 
				WHERE CS . CSHANGCHA = JEBL . JBHANGCHA 
				AND CS . CSGOKJONG = JEBL . JBGOKJONG 
				AND CS . CSHWAJU = JEBL . JBHWAJU 
				AND CS . CSBLNO = JEBL . JBBLNO 
				AND CS . CSBLMSN = JEBL . JBBLMSN 
				AND CS . CSBLHSN = JEBL . JBBLHSN 
				AND CS.CSHMNO1 = JEBL.JBHMNO1
				AND CS.CSHMNO2 = JEBL.JBHMNO2
				AND CS . CSDATE > INT ( P_DATE ) 
			) AS CSQTY , 
			( 
				SELECT 
				COALESCE ( SUM ( CASE WHEN CHYNCHQTY = 0 THEN CHMTQTY 
				ELSE 0 END ) , 0 ) AS CHMTQTY 
				FROM TYSCMLIB . USICHULF AS CHUL 
				WHERE CHUL . CHHANGCHA = JEBL . JBHANGCHA 
				AND CHUL . CHGOKJONG = JEBL . JBGOKJONG 
				AND CHUL . CHHWAJU = JEBL . JBHWAJU 
				AND CHUL . CHBLNO = JEBL . JBBLNO 
				AND CHUL . CHBLMSN = JEBL . JBBLMSN 
				AND CHUL . CHBLHSN = JEBL . JBBLHSN 
				AND CHUL.CHHMNO1 = JEBL.JBHMNO1
				AND CHUL.CHHMNO2 = JEBL.JBHMNO2
				AND CHUL . CHCHULDAT > INT ( P_DATE ) 
			) AS CHMTQTY , 
			( 
				SELECT 
				COALESCE ( SUM ( CHYNCHQTY ) , 0 ) AS CHYNCHQTY 
				FROM TYSCMLIB . USICHULF AS CHUL 
				WHERE CHUL . CHHANGCHA = JEBL . JBHANGCHA 
				AND CHUL . CHGOKJONG = JEBL . JBGOKJONG 
				AND CHUL . CHHWAJU = JEBL . JBHWAJU 
				AND CHUL . CHBLNO = JEBL . JBBLNO 
				AND CHUL . CHBLMSN = JEBL . JBBLMSN 
				AND CHUL . CHBLHSN = JEBL . JBBLHSN 
				AND CHUL.CHHMNO1 = JEBL.JBHMNO1
				AND CHUL.CHHMNO2 = JEBL.JBHMNO2
				AND CHUL . CHCHULDAT > INT ( P_DATE ) 
			) AS CHYNCHQTY 
			 
			FROM TYSCMLIB . USIJEBLF AS JEBL 
			LEFT OUTER JOIN TYSCMLIB . USIIPHAF AS IPHA 
			ON JEBL . JBHANGCHA = IPHA . IHHANGCHA 
			LEFT OUTER JOIN TYSCMLIB . USICODEF AS VSCODE 
			ON 'VS' = VSCODE . CDINDEX 
			AND JEBL . JBHANGCHA = VSCODE . CDCODE 
			LEFT OUTER JOIN TYSCMLIB . USICODEF AS GKCODE 
			ON 'GK' = GKCODE . CDINDEX 
			AND JEBL . JBGOKJONG = GKCODE . CDCODE 
			WHERE JBHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
			AND JBHANGCHA >= '200901' 
			ORDER BY JBGOKJONG , IHIPHANG , JBHANGCHA 
  
		DO 
  
		SET V_IHIPHANG = '' ; 
		SET V_JBHANGCHA = '' ; 
		SET V_JBGOKJONG = '' ; 
		SET V_JBBLNO = '' ; 
		SET V_JBBLMSN = '' ; 
		SET V_JBBLHSN = '' ; 
		SET V_JBHMNO1 = '' ; 
		SET V_JBHMNO2 = '' ; 
		SET V_VSDESC1 = '' ; 
		SET V_GKDESC1 = '' ; 
		SET V_JBBEJNQTY = 0 ; 
		SET V_JBHWAKQTY = 0 ; 
		SET V_JBYDQTY = 0 ; 
		SET V_JBYSQTY = 0 ; 
		SET V_JBYSYDQTY = 0 ; 
		SET V_JBCSQTY = 0 ; 
		SET V_JBCHQTY = 0 ; 
		SET V_JBYSCHQTY = 0 ; 
		SET V_JBJEGOQTY = 0 ; 
		SET V_IBHWAKQTY = 0 ; 
		SET V_CSQTY = 0 ; 
		SET V_CHMTQTY = 0 ; 
		SET V_CHYNCHQTY = 0 ; 
		SET V_CSHMNO2 = '' ; 
		SET V_CSDATE = '' ; 
		SET V_CSSINNO = '' ; 
  
		SET V_IHIPHANG = IHIPHANG ; 
		SET V_JBHANGCHA = JBHANGCHA ; 
		SET V_JBGOKJONG = JBGOKJONG ; 
		SET V_JBBLNO = JBBLNO ; 
		SET V_JBBLMSN = JBBLMSN ; 
		SET V_JBBLHSN = JBBLHSN ; 
		SET V_JBHMNO1 = JBHMNO1 ; 
		SET V_JBHMNO2 = JBHMNO2 ; 
		SET V_VSDESC1 = VSDESC1 ; 
		SET V_GKDESC1 = GKDESC1 ; 
		SET V_JBBEJNQTY = JBBEJNQTY ; 
		SET V_JBHWAKQTY = JBHWAKQTY ; 
		SET V_JBYDQTY = JBYDQTY ; 
		SET V_JBYSQTY = JBYSQTY ; 
		SET V_JBYSYDQTY = JBYSYDQTY ; 
		SET V_JBCSQTY = JBCSQTY ; 
		SET V_JBCHQTY = JBCHQTY ; 
		SET V_JBYSCHQTY = JBYSCHQTY ; 
		SET V_JBJEGOQTY = JBJEGOQTY ; 

		SELECT
		CHAR(CSHMNO2),
		(CHAR(CSDATE)||'-'||CHAR(CSSEQ)),
		CSSINNO
		INTO V_CSHMNO2, V_CSDATE, V_CSSINNO
		FROM TYSCMLIB.USICUSTF
		WHERE CSHANGCHA = V_JBHANGCHA
		AND   CSGOKJONG = V_JBGOKJONG
		AND   CSHWAJU   IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(P_HWAJU AS VARCHAR(100)), ',')) AS InTable )
		AND   CSBLNO    = V_JBBLNO
		AND   CSBLMSN   = V_JBBLMSN
		AND   CSBLHSN   = V_JBBLHSN
		ORDER BY CSDATE, CSSEQ
		FETCH FIRST 1 ROWS ONLY;

		--SET V_CSHMNO2 = CSHMNO2 ; 
		--SET V_CSDATE = CSDATE ; 
		--SET V_CSSINNO = CSSINNO ; 
  
		SET V_IBHWAKQTY = IBHWAKQTY ; 
		SET V_CSQTY = CSQTY ; 
		SET V_CHMTQTY = CHMTQTY ; 
		SET V_CHYNCHQTY = CHYNCHQTY ; 
  
		SET V_YNQTY = 0 ; 
		SET V_YSQTY = 0 ; 
		SET V_YSYDQTY = 0 ; 
  
		IF ( V_IBHWAKQTY = 0 OR V_JBHWAKQTY <> V_IBHWAKQTY ) THEN 
  
			SET V_YNQTY = 0 ; 
			SET V_YSQTY = 0 ; 
			SET V_YSYDQTY = 0 ; 
  
			SET V_COUNT = 0 ; 
  
			R11 : FOR C11 AS 
  
						 -- 양도량 
						SELECT 
						COALESCE ( SUM ( YNQTY ) , 0 ) AS YNQTY 
						FROM TYSCMLIB . USIYANGNF 
						WHERE YNHANGCHA = V_JBHANGCHA 
						AND YNGOKJONG = V_JBGOKJONG 
						AND YNBLNO = V_JBBLNO 
						AND YNBLMSN = INT ( V_JBBLMSN ) 
						AND YNBLHSN = INT ( V_JBBLHSN ) 
						AND YNHMNO1 = INT( V_JBHMNO1)
						AND YNHMNO2 = INT( V_JBHMNO2)
						AND YNHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
						AND YNYNHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
  
						AND YNYSDATE > INT ( P_DATE ) 
						AND YNQTY > 0 
						UNION ALL 
						 -- 양수량 
						SELECT 
						COALESCE ( SUM ( YNQTY + YNYSYDQTY ) , 0 ) AS YNQTY 
						FROM TYSCMLIB . USIYANGNF 
						WHERE YNHANGCHA = V_JBHANGCHA 
						AND YNGOKJONG = V_JBGOKJONG 
						AND YNBLNO = V_JBBLNO 
						AND YNBLMSN = INT ( V_JBBLMSN ) 
						AND YNBLHSN = INT ( V_JBBLHSN ) 
						AND YNHMNO1 = INT( V_JBHMNO1)
						AND YNHMNO2 = INT( V_JBHMNO2)
						AND YNYSHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
						AND YNYSDATE > INT ( P_DATE ) 
						UNION ALL 
						 -- 양수양도량 
						SELECT 
						COALESCE ( SUM ( YNYSYDQTY ) , 0 ) AS YNQTY 
						FROM TYSCMLIB . USIYANGNF 
						WHERE YNHANGCHA = V_JBHANGCHA 
						AND YNGOKJONG = V_JBGOKJONG 
						AND YNBLNO = V_JBBLNO 
						AND YNBLMSN = INT ( V_JBBLMSN ) 
						AND YNBLHSN = INT ( V_JBBLHSN ) 
						AND YNHMNO1 = INT( V_JBHMNO1)
						AND YNHMNO2 = INT( V_JBHMNO2)
						AND YNHWAJU IN ( SELECT * FROM TABLE ( TYSCMLIB . SF_GB_REVCOLROW ( CAST ( P_HWAJU AS VARCHAR ( 100 ) ) , ',' ) ) AS INTABLE ) 
						AND YNYSDATE > INT ( P_DATE ) 
						AND YNYSYDQTY > 0 
  
					DO					 
  
					IF V_COUNT = 0 THEN 
  
						SET V_YNQTY = YNQTY ; 
  
					ELSEIF V_COUNT = 1 THEN 
  
						SET V_YSQTY = YNQTY ; 
  
					ELSEIF V_COUNT = 2 THEN 
  
						SET V_YSYDQTY = YNQTY ; 
  
					END IF ; 
  
					SET V_COUNT = V_COUNT + 1 ; 
  
			END FOR R11 ; 
  
			SET V_HAPBAE = 0 ; 
			SET V_HAPHWAK = 0 ; 
			SET V_HAPCS = 0 ; 
			SET V_HAPCHUL = 0 ; 
			SET V_HAPYD = 0 ; 
			SET V_HAPYS = 0 ; 
			SET V_HAPYSYD = 0 ; 
			SET V_HAPYSCH = 0 ; 
			SET V_HAPJAE = 0 ; 
  
			SET V_HAPBAE = V_JBBEJNQTY ; 
			SET V_HAPHWAK = V_JBHWAKQTY - V_IBHWAKQTY ; 
			SET V_HAPCS = V_JBCSQTY - V_CSQTY ; 
			SET V_HAPCHUL = V_JBCHQTY - V_CHMTQTY ; 
			SET V_HAPYD = V_JBYDQTY - V_YNQTY ; 
			SET V_HAPYS = V_JBYSQTY - V_YSQTY ; 
			SET V_HAPYSYD = V_JBYSYDQTY - V_YSYDQTY ; 
			SET V_HAPYSCH = V_JBYSCHQTY - V_CHYNCHQTY ; 
			SET V_HAPJAE = ( V_HAPYS + V_HAPHWAK ) - ( V_HAPYD + V_HAPCHUL + V_HAPYSYD + V_HAPYSCH ) ; 
  
			IF V_HAPJAE <> 0 THEN 
  
				SET V_ROWNO = V_ROWNO + 1 ; 
  
				SET V_COUNT = 0 ; 
  
				INSERT INTO SESSION . SILO_CSS1070 
				( 
					ROWNO , 
					HAPBAE , 
					HAPHWAK , 
					HAPCS , 
					HAPCHUL , 
					HAPYD , 
					HAPYS , 
					HAPYSYD , 
					HAPYSCH , 
					HAPJAE , 
					VSDESC1 , 
					GKDESC1 , 
					IHIPHANG , 
					HANGCHA , 
					BLNO , 
					CSHMNO2 , 
					CSDATE , 
					CSSINNO 
				) 
				VALUES 
				( 
					V_ROWNO , 
					V_HAPBAE , 
					V_HAPHWAK , 
					V_HAPCS , 
					V_HAPCHUL , 
					V_HAPYD , 
					V_HAPYS , 
					V_HAPYSYD , 
					V_HAPYSCH , 
					V_HAPJAE , 
					V_VSDESC1 , 
					V_GKDESC1 , 
					V_IHIPHANG , 
					V_JBHANGCHA , 
					V_JBBLNO , 
					V_CSHMNO2 , 
					V_CSDATE , 
					V_CSSINNO 
				) ; 
  
			END IF ; 
  
		END IF ; 
  
	END FOR R1 ; 
  
	MAIN : BEGIN  -- 실행부      
		IF P_GUBUN = 'S' THEN 
  
			LIST : BEGIN  -- 리스트 
				DECLARE REFCURSOR CURSOR WITH RETURN FOR 
  
					SELECT 
					ROWNO , 
					IHIPHANG , 
					HANGCHA , 
					VSDESC1 , 
					GKDESC1 , 
					BLNO , 
					CSHMNO2 , 
					CSDATE , 
					CSSINNO , 
					TRIM(TO_CHAR(HAPBAE, '9,999,990.000')) AS HAPBAE , 
					TRIM(TO_CHAR(HAPHWAK, '9,999,990.000')) AS HAPHWAK , 
					TRIM(TO_CHAR(HAPCS, '9,999,990.000')) AS HAPCS , 
					TRIM(TO_CHAR(HAPCHUL, '9,999,990.000')) AS HAPCHUL , 
					TRIM(TO_CHAR(HAPYD, '9,999,990.000')) AS HAPYD , 
					TRIM(TO_CHAR(HAPYS, '9,999,990.000')) AS HAPYS , 
					TRIM(TO_CHAR(HAPYSYD, '9,999,990.000')) AS HAPYSYD , 
					TRIM(TO_CHAR(HAPYSCH, '9,999,990.000')) AS HAPYSCH , 
					TRIM(TO_CHAR(HAPJAE, '9,999,990.000')) AS HAPJAE 
					FROM SESSION . SILO_CSS1070 
					WHERE ROWNO BETWEEN CAST ( P_STNUM AS VARCHAR ( 100 ) )AND CAST ( P_FNNUM AS VARCHAR ( 100 ) )
					ORDER BY ROWNO ; 
  
				OPEN REFCURSOR ; 
  
			END LIST ; 
  
			PAGING : BEGIN  -- 페이징 
				DECLARE REFCURSOR3 CURSOR WITH RETURN FOR 
  
					SELECT 
					COUNT ( * ) AS TOTALCOUNT 
					FROM SESSION . SILO_CSS1070 ; 
  
				OPEN REFCURSOR3 ; 
  
			END PAGING ; 
  
		ELSE 
  
			PRINT : BEGIN  -- 페이징 
				DECLARE REFCURSOR5 CURSOR WITH RETURN FOR 
  
					SELECT 
					ROWNO , 
					IHIPHANG , 
					HANGCHA , 
					VSDESC1 , 
					GKDESC1 , 
					BLNO , 
					CSHMNO2 , 
					CSDATE , 
					CSSINNO , 
					HAPBAE , 
					HAPHWAK , 
					HAPCS , 
					HAPCHUL , 
					HAPYD , 
					HAPYS , 
					HAPYSYD , 
					HAPYSCH , 
					HAPJAE 
					FROM SESSION . SILO_CSS1070 
					ORDER BY ROWNO ; 
  
				OPEN REFCURSOR5 ; 
  
			END PRINT ; 
  
		END IF ; 
  
	END MAIN ; 
END P1  ; 
  
GRANT ALTER , EXECUTE   
ON SPECIFIC PROCEDURE TYJINFWLIB.SP_TYCSS_CSS1070_LIST 
TO KSGPDM WITH GRANT OPTION ;


CALL TYJINFWLIB.SP_TYCSS_CSS1070_LIST(1,15, '20210203', 'J39', 'S')