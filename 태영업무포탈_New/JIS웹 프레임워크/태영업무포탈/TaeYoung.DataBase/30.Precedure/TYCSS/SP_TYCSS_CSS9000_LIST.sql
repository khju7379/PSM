DROP PROCEDURE TYJINFWLIB.SP_TYCSS_CSS9000_LIST;

--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	21-05-11 15:58:37 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
SET PATH "QSYS","QSYS2","SYSPROC","SYSIBMADM","KSGPDM";

CREATE PROCEDURE TYJINFWLIB.SP_TYCSS_CSS9000_LIST
(
	IN P_CURRENTPAGEINDEX INTEGER,
	IN P_PAGESIZE INTEGER,
	IN P_YYMM  VARCHAR(6),
	IN P_GUBUN VARCHAR(1))
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSS_CSS9000_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD ,
	ALWCPYDTA = *OPTIMIZE ,
	COMMIT = *NONE ,
	DECRESULT = (31,31,00) ,
	DYNDFTCOL = *NO ,
	DYNUSRPRF = *USER ,
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 
	DECLARE P_STNUM INTEGER;
	DECLARE P_FNNUM INTEGER;
	DECLARE P_SQLSTRING VARCHAR(4000);
	DECLARE P_SQLTOTALROWCOUNT VARCHAR(4000);
	DECLARE P_TABLE_QUERY VARCHAR(5000);
	DECLARE P_COUNT_QUERY VARCHAR(5000);

	-- 임시테이블 변수
	DECLARE V_SHCOMPANY    VARCHAR(50);   -- 구분
	DECLARE V_SHVESSEL     VARCHAR(50);   -- 모선명
	DECLARE V_SKDESC       VARCHAR(50);   -- 협회
	DECLARE V_GKDESC       VARCHAR(50);   -- 곡종
	DECLARE V_WNDESC       VARCHAR(50);   -- 원산지
	DECLARE V_SHETAULSAN   VARCHAR(10);   -- 울산
	DECLARE V_SHULSANQTY   NUMERIC(12,3); -- B/L량
	DECLARE V_SHETABUSAN   VARCHAR(10);   -- 부산
	DECLARE V_SHBUSANQTY   NUMERIC(12,3); -- B/L량
	DECLARE V_SHETAINCHE   VARCHAR(10);   -- 평택
	DECLARE V_SHINCHEQTY   NUMERIC(12,3); -- B/L량
	DECLARE V_BL_TOTQTY    NUMERIC(12,3); -- 총B/L량
	DECLARE V_SHMONTHQTY   NUMERIC(12,3); -- 월누계량
	DECLARE V_SHANNUALQTY  NUMERIC(12,3); -- 년누계량
	DECLARE V_SHHWDATE     VARCHAR(6);    -- 적용년월
	DECLARE V_SHETBDATE    VARCHAR(8);    -- 접안일자
	DECLARE V_SHETCD       VARCHAR(30);   -- 작업기간
	DECLARE V_BRDESC       VARCHAR(50);   -- 대리점
	DECLARE V_SHREMARK     VARCHAR(50);   -- 비고
	DECLARE V_COLOR        VARCHAR(20);   -- COLOR

	DECLARE V_BLANK        VARCHAR(10);
	DECLARE V_NEXT_YYMM    VARCHAR(6);
	DECLARE V_STYYMM       VARCHAR(6);
	DECLARE V_EDYYMM       VARCHAR(6);

	DECLARE V_SHETCD_S     VARCHAR(8);
	DECLARE V_SHETCD_E     VARCHAR(8);
	DECLARE V_NOWDATE      VARCHAR(8);

	DECLARE V_YEAR         NUMERIC(4,0);
	DECLARE V_MONTH        NUMERIC(2,0);	

	DECLARE V_COUNT        INTEGER;


	SET V_SHCOMPANY    = '';   -- 구분
	SET V_SHVESSEL     = '';   -- 모선명
	SET V_SKDESC       = '';   -- 협회
	SET V_GKDESC       = '';   -- 곡종
	SET V_WNDESC       = '';   -- 원산지
	SET V_SHETAULSAN   = '';   -- 울산
	SET V_SHULSANQTY   = 0;    -- B/L량
	SET V_SHETABUSAN   = '';   -- 부산
	SET V_SHBUSANQTY   = 0;    -- B/L량
	SET V_SHETAINCHE   = '';   -- 평택
	SET V_SHINCHEQTY   = 0;    -- B/L량
	SET V_BL_TOTQTY    = 0;    -- 총B/L량
	SET V_SHMONTHQTY   = 0;    -- 월누계량
	SET V_SHANNUALQTY  = 0;    -- 년누계량
	SET V_SHHWDATE     = '';   -- 적용년월
	SET V_SHETBDATE    = '';   -- 접안일자
	SET V_SHETCD       = '';   -- 작업기간
	SET V_BRDESC       = '';   -- 대리점
	SET V_SHREMARK     = '';   -- 비고
	SET V_COLOR        = '';   -- COLOR

	SET V_BLANK        = '';

	SET V_YEAR         = 0;
	SET V_MONTH        = 0;
	SET V_NEXT_YYMM    = '';
	SET V_STYYMM       = '';
	SET V_EDYYMM       = '';

	SET V_SHETCD_S     = '';
	SET V_SHETCD_E     = '';
	SET V_NOWDATE      = '';

	SET V_COUNT        = 0;

	SET V_STYYMM = SUBSTR(P_YYMM,1,4)||'00';

	IF (SUBSTR(P_YYMM, 5, 2) = '01') THEN
		SET V_EDYYMM = SUBSTR(P_YYMM, 1, 4)||'00';
	ELSE
		SET V_MONTH = INT(SUBSTR(P_YYMM, 5, 2)) - 1;
		SET V_EDYYMM = SUBSTR(P_YYMM, 1, 4)||DIGITS(V_MONTH);
	END IF;

	IF (SUBSTR(P_YYMM, 5, 2) = '12') THEN
		SET V_YEAR = INT(SUBSTR(P_YYMM, 1, 4)) + 1;
		SET V_NEXT_YYMM = DIGITS(V_YEAR)||'01';
	ELSE
		SET V_MONTH = INT(SUBSTR(P_YYMM, 5, 2)) + 1;
		SET V_NEXT_YYMM = SUBSTR(P_YYMM, 1, 4)||DIGITS(V_MONTH);
	END IF;

	PREV : BEGIN  -- 값 설정 
		SET P_STNUM =(P_PAGESIZE *(P_CURRENTPAGEINDEX - 1)) + 1;
		SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX;
	END PREV;

	 -- 임시테이블
	DECLARE GLOBAL TEMPORARY TABLE SESSION.SILO_VESLSCHED(
			ROWNO       INTEGER
		,	SHCOMPANY   VARCHAR(50)   -- 구분
		,	SHVESSEL    VARCHAR(50)   -- 모선명
		,	SKDESC      VARCHAR(50)   -- 협회
		,	GKDESC      VARCHAR(50)   -- 곡종
		,	WNDESC      VARCHAR(50)   -- 원산지
		,	SHETAULSAN  VARCHAR(10)   -- 울산
		,	SHULSANQTY  NUMERIC(12,3) -- B/L량
		,	SHETABUSAN  VARCHAR(10)   -- 부산
		,	SHBUSANQTY  NUMERIC(12,3) -- B/L량
		,	SHETAINCHE  VARCHAR(10)   -- 평택
		,	SHINCHEQTY  NUMERIC(12,3) -- B/L량
		,	BL_TOTQTY   NUMERIC(12,3) -- 총B/L량
		,	SHMONTHQTY  NUMERIC(12,3) -- 월누계량
		,	SHANNUALQTY NUMERIC(12,3) -- 년누계량
		,	SHHWDATE    VARCHAR(6)    -- 적용년월
		,	SHETBDATE   VARCHAR(8)    -- 접안일자
		,	SHETCD      VARCHAR(30)   -- 작업기간
		,	BRDESC      VARCHAR(50)   -- 대리점
		,	SHREMARK    VARCHAR(50)   -- 비고
		,	COLOR       VARCHAR(20)   -- COLOR
	) WITH REPLACE;

	R1 : FOR C1 AS
			WITH TABLE1 AS
			(
				SELECT
				rownumber() over(ORDER BY (CASE WHEN SHCOMPANY = 'TY' THEN '1' ELSE '2' END),SHETAULSAN,SHETAULTIME,SHETABUSAN,SHETAINCHE) as NUM,
				SHDATE,
				SHSEQ,
				(CASE WHEN SHCOMPANY = 'TY' THEN '1' ELSE '2' END) AS ROWNUM,
				SHCOMPANY,
				SHVESSEL,
				SKCODE.CDDESC1 AS SKDESC,
				GKCODE.CDDESC1 AS GKDESC,
				WNCODE.CDDESC1 AS WNDESC,
				(CASE WHEN SHETAULSAN <> '' THEN SUBSTR(SHETAULSAN,5,2)||'/'||SUBSTR(SHETAULSAN,7,2) ELSE '' END) AS SHETAULSAN,
				SHULSANQTY,
				(CASE WHEN SHETABUSAN <> '' THEN SUBSTR(SHETABUSAN,5,2)||'/'||SUBSTR(SHETABUSAN,7,2) ELSE '' END) AS SHETABUSAN,
				SHBUSANQTY,
				(CASE WHEN SHETAINCHE <> '' THEN SUBSTR(SHETAINCHE,5,2)||'/'||SUBSTR(SHETAINCHE,7,2) ELSE '' END) AS SHETAINCHE,
				SHINCHEQTY,
				(SHULSANQTY+ SHBUSANQTY + SHINCHEQTY) AS BL_TOTQTY,

				VALUE((CASE WHEN SHHWDATE = P_YYMM THEN VALUE((CASE WHEN VALUE((IHBLQTY1 + IHBLQTY2 + IHBLQTY3),0) = 0 THEN SHULSANQTY ELSE VALUE((IHBLQTY1 + IHBLQTY2 + IHBLQTY3),0) END),0) END),0) AS SHQTY,
				VALUE((CASE WHEN SHHWDATE = V_NEXT_YYMM THEN VALUE((CASE WHEN VALUE((IHBLQTY1 + IHBLQTY2 + IHBLQTY3),0) = 0 THEN SHULSANQTY ELSE VALUE((IHBLQTY1 + IHBLQTY2 + IHBLQTY3),0) END),0) END),0) AS SHQTY_NEXT,
				(
					SELECT
					VALUE(SUM(JGBEJNQTY + JGBEIPQTY - JGBECHQTY),0)
					FROM TYSCMLIB.USIIPHAF AS IPHA
					LEFT OUTER JOIN TYSCMLIB.USIJEGOF AS JEGO
					ON      IPHA.IHHANGCHA = JEGO.JGHANGCHA
					WHERE SUBSTR(IHJAKENDAT,1,6) BETWEEN V_STYYMM AND V_EDYYMM
				) AS YEAR_QTY,
				(CASE WHEN SHETCD_S <> '' AND SHETCD_E <> '' THEN SUBSTR(SHETCD_S,5,2)||'/'||SUBSTR(SHETCD_S,7,2)||'~'||SUBSTR(SHETCD_E,5,2)||'/'||SUBSTR(SHETCD_E,7,2) ELSE '' END) AS SHETCD,
				BRCODE.CDDESC1 AS BRDESC,
				SHREMARK,
				SHETCD_S,
				SHETCD_E,
				SHETBDATE,
				SHHWDATE,
				CAST(P_YYMM AS CHAR(6)) AS DATE
				FROM TYSCMLIB.PSM_ShipSchedule_SILO
				LEFT OUTER JOIN TYSCMLIB.USICODEF AS VSCODE
				ON               'VS' = VSCODE.CDINDEX
				AND         SHHANGCHA = VSCODE.CDCODE
				LEFT OUTER JOIN TYSCMLIB.USICODEF AS GKCODE
				ON               'GK' = GKCODE.CDINDEX
				AND         SHGOKJONG = GKCODE.CDCODE
				LEFT OUTER JOIN TYSCMLIB.USICODEF AS SKCODE
				ON               'SK' = SKCODE.CDINDEX
				AND           SHSOSOK = SKCODE.CDCODE
				LEFT OUTER JOIN TYSCMLIB.USICODEF AS WNCODE
				ON               'WN' = WNCODE.CDINDEX
				AND          SHWONSAN = WNCODE.CDCODE
				LEFT OUTER JOIN TYSCMLIB.USICODEF AS BRCODE
				ON               'BR' = BRCODE.CDINDEX
				AND           SHAGENT = BRCODE.CDCODE
				LEFT OUTER JOIN TYSCMLIB.USIIPHAF AS IPHA
				ON          SHHANGCHA = IPHA.IHHANGCHA
				WHERE SHHWDATE BETWEEN P_YYMM AND V_NEXT_YYMM
			)
			SELECT
			NUM,
			SHDATE,
			SHSEQ,
			SHCOMPANY,
			SHVESSEL,
			SKDESC,
			GKDESC,
			WNDESC,
			SHETAULSAN,
			SHULSANQTY,
			SHETABUSAN,
			SHBUSANQTY,
			SHETAINCHE,
			SHINCHEQTY,
			BL_TOTQTY,
			SHQTY,
			SHHWDATE,
			(CASE WHEN SHCOMPANY = 'TY' THEN (CASE WHEN DATE = SHHWDATE THEN
			                                            (SELECT SUM(SHQTY) FROM TABLE1 AS B
								     WHERE B.NUM <= A.NUM)
							       ELSE 0
							       END)
				  ELSE 0 END) AS MONTH_QTY,
			(CASE WHEN SHCOMPANY = 'TY' THEN (CASE WHEN DATE = SHHWDATE THEN
			                                            (SELECT (A.YEAR_QTY) + SUM(SHQTY)
								     FROM TABLE1 AS B
								     WHERE B.NUM <= A.NUM)
							       ELSE 0
							       END)
				  ELSE 0 END)AS YEAR_QTY,
			SHETCD,
			BRDESC,
			SHREMARK,
			(CASE WHEN (TRIM(SHETCD_S) = '' OR TRIM(SHETCD_S) IS NULL) THEN '0' ELSE TRIM(SHETCD_S) END) AS SHETCD_S,
			(CASE WHEN (TRIM(SHETCD_E) = '' OR TRIM(SHETCD_E) IS NULL) THEN '0' ELSE TRIM(SHETCD_E) END) AS SHETCD_E,
			(CASE WHEN (TRIM(SHETBDATE) = '' OR TRIM(SHETBDATE) IS NULL) THEN '0' ELSE TRIM(SHETBDATE) END) AS SHETBDATE
			FROM TABLE1 AS A
			ORDER BY NUM
		DO

		SET V_SHCOMPANY   = '';   -- 구분
		SET V_SHVESSEL    = '';   -- 모선명
		SET V_SKDESC      = '';   -- 협회
		SET V_GKDESC      = '';   -- 곡종
		SET V_WNDESC      = '';   -- 원산지
		SET V_SHETAULSAN  = '';   -- 울산
		SET V_SHULSANQTY  = 0;    -- B/L량
		SET V_SHETABUSAN  = '';   -- 부산
		SET V_SHBUSANQTY  = 0;    -- B/L량
		SET V_SHETAINCHE  = '';   -- 평택
		SET V_SHINCHEQTY  = 0;    -- B/L량
		SET V_BL_TOTQTY   = 0;    -- 총B/L량
		SET V_SHMONTHQTY  = 0;    -- 월누계량
		SET V_SHANNUALQTY = 0;    -- 년누계량
		SET V_SHHWDATE    = '';   -- 적용년월
		SET V_SHETBDATE   = '';   -- 접안일자
		SET V_SHETCD      = '';   -- 작업기간
		SET V_BRDESC      = '';   -- 대리점
		SET V_SHREMARK    = '';   -- 비고
		SET V_SHETCD_S    = '';
		SET V_SHETCD_E    = '';

		SET V_NOWDATE     = '';

		SET V_SHETCD_S    = SHETCD_S;
		SET V_SHETCD_E    = SHETCD_E;


		SET V_SHCOMPANY   = SHCOMPANY;  -- 구분

		IF (V_SHCOMPANY <> 'TY') THEN

			IF (V_BLANK = '') THEN

				SET V_SHCOMPANY = '';   -- 구분
				SET V_BLANK     = 'GORYU';

				SET V_COUNT     = V_COUNT + 1;

				-- 생성
				INSERT INTO SESSION.SILO_VESLSCHED
				( 
					ROWNO,
					SHCOMPANY,   -- 구분
					SHVESSEL,    -- 모선명
					SKDESC,      -- 협회
					GKDESC,      -- 곡종
					WNDESC,      -- 원산지
					SHETAULSAN,  -- 울산
					SHULSANQTY,  -- B/L량
					SHETABUSAN,  -- 부산
					SHBUSANQTY,  -- B/L량
					SHETAINCHE,  -- 평택
					SHINCHEQTY,  -- B/L량
					BL_TOTQTY,   -- 총B/L량
					SHMONTHQTY,  -- 월누계량
					SHANNUALQTY, -- 년누계량
					SHHWDATE,    -- 적용년월
					SHETBDATE,   -- 접안일자
					SHETCD,      -- 작업기간
					BRDESC,      -- 대리점
					SHREMARK,    -- 비고
					COLOR        -- 색깔
				)
				VALUES 
				(
					V_COUNT,
					V_SHCOMPANY,   -- 구분
					V_SHVESSEL,    -- 모선명
					V_SKDESC,      -- 협회
					V_GKDESC,      -- 곡종
					V_WNDESC,      -- 원산지
					V_SHETAULSAN,  -- 울산
					V_SHULSANQTY,  -- B/L량
					V_SHETABUSAN,  -- 부산
					V_SHBUSANQTY,  -- B/L량
					V_SHETAINCHE,  -- 평택
					V_SHINCHEQTY,  -- B/L량
					V_BL_TOTQTY,   -- 총B/L량
					V_SHMONTHQTY,  -- 월누계량
					V_SHANNUALQTY, -- 년누계량
					V_SHHWDATE,    -- 적용년월
					V_SHETBDATE,   -- 접안일자
					V_SHETCD,      -- 작업기간
					V_BRDESC,      -- 대리점
					V_SHREMARK,    -- 비고
					''             -- 색깔
				);

			END IF;

		END IF;

		SET V_SHCOMPANY    = SHCOMPANY;  -- 구분
		SET V_SHVESSEL     = SHVESSEL;   -- 모선명
		SET V_SKDESC       = SKDESC;     -- 협회
		SET V_GKDESC       = GKDESC;     -- 곡종
		SET V_WNDESC       = WNDESC;     -- 원산지
		SET V_SHETAULSAN   = SHETAULSAN; -- 울산
		SET V_SHULSANQTY   = SHULSANQTY; -- B/L량
		SET V_SHETABUSAN   = SHETABUSAN; -- 부산
		SET V_SHBUSANQTY   = SHBUSANQTY; -- B/L량
		SET V_SHETAINCHE   = SHETAINCHE; -- 평택
		SET V_SHINCHEQTY   = SHINCHEQTY; -- B/L량
		SET V_BL_TOTQTY    = BL_TOTQTY;  -- 총B/L량
		SET V_SHMONTHQTY   = MONTH_QTY;  -- 월누계량
		SET V_SHANNUALQTY  = YEAR_QTY;   -- 년누계량
		SET V_SHHWDATE     = SHHWDATE;   -- 적용년월
		SET V_SHETBDATE    = SHETBDATE;  -- 접안일자
		SET V_SHETCD       = SHETCD;     -- 작업기간
		SET V_BRDESC       = BRDESC;     -- 대리점
		SET V_SHREMARK     = SHREMARK;   -- 비고

		SELECT
		SUBSTR(CHAR(CURRENT DATE),1,4)||SUBSTR(CHAR(CURRENT DATE),6,2)||SUBSTR(CHAR(CURRENT DATE),9,2) INTO V_NOWDATE
		FROM  SYSIBM.SYSDUMMY1;

		IF (V_SHCOMPANY = 'TY') THEN

			IF (V_COLOR = '') THEN

				IF ((INT(V_SHETCD_S) <= INT(V_NOWDATE)) AND (INT(V_SHETCD_E) >= INT(V_NOWDATE))) THEN

					SET V_COLOR = 'RED';

				END IF;

				IF (INT(V_SHETCD_S) > INT(V_NOWDATE))  THEN

					SET V_COLOR = 'BLUE';

				END IF;

			ELSEIF (V_COLOR = 'RED') THEN

				SET V_COLOR = 'BLUE';

			ELSEIF (V_COLOR = 'BLUE') THEN

				SET V_COLOR = '';

			ELSE

				SET V_COLOR = '';

			END IF;

		ELSE

			SET V_COLOR = '';

		END IF;




		IF (V_SHCOMPANY = 'TY') THEN

			SET V_SHCOMPANY = '태영';   -- 구분

		ELSE

			SET V_SHCOMPANY = '고려';   -- 구분

		END IF;

		SET V_COUNT = V_COUNT + 1;

		-- 생성
		INSERT INTO SESSION.SILO_VESLSCHED
		( 
			ROWNO,
			SHCOMPANY,   -- 구분
			SHVESSEL,    -- 모선명
			SKDESC,      -- 협회
			GKDESC,      -- 곡종
			WNDESC,      -- 원산지
			SHETAULSAN,  -- 울산
			SHULSANQTY,  -- B/L량
			SHETABUSAN,  -- 부산
			SHBUSANQTY,  -- B/L량
			SHETAINCHE,  -- 평택
			SHINCHEQTY,  -- B/L량
			BL_TOTQTY,   -- 총B/L량
			SHMONTHQTY,  -- 월누계량
			SHANNUALQTY, -- 년누계량
			SHHWDATE,    -- 적용년월
			SHETBDATE,   -- 접안일자
			SHETCD,      -- 작업기간
			BRDESC,      -- 대리점
			SHREMARK,    -- 비고
			COLOR        -- 색깔
		)
		VALUES 
		(
			V_COUNT,
			V_SHCOMPANY,   -- 구분
			V_SHVESSEL,    -- 모선명
			V_SKDESC,      -- 협회
			V_GKDESC,      -- 곡종
			V_WNDESC,      -- 원산지
			V_SHETAULSAN,  -- 울산
			V_SHULSANQTY,  -- B/L량
			V_SHETABUSAN,  -- 부산
			V_SHBUSANQTY,  -- B/L량
			V_SHETAINCHE,  -- 평택
			V_SHINCHEQTY,  -- B/L량
			V_BL_TOTQTY,   -- 총B/L량
			V_SHMONTHQTY,  -- 월누계량
			V_SHANNUALQTY, -- 년누계량
			V_SHHWDATE,    -- 적용년월
			V_SHETBDATE,   -- 접안일자
			V_SHETCD,      -- 작업기간
			V_BRDESC,      -- 대리점
			V_SHREMARK,    -- 비고
			V_COLOR        -- 색깔
		);

	END FOR R1;

	MAIN : BEGIN  -- 실행부
		IF P_GUBUN = 'S' THEN

			LIST : BEGIN  -- 리스트
				DECLARE REFCURSOR CURSOR WITH RETURN FOR

					SELECT 
					ROWNO,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHCOMPANY) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHCOMPANY) || '</div>' 
					      ELSE TRIM (SHCOMPANY) END ) AS SHCOMPANY,

					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHVESSEL) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHVESSEL) || '</div>' 
					      ELSE TRIM (SHVESSEL) END ) AS SHVESSEL,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SKDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SKDESC) || '</div>' 
					      ELSE TRIM (SKDESC) END ) AS SKDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (GKDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (GKDESC) || '</div>' 
					      ELSE TRIM (GKDESC) END ) AS GKDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (WNDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (WNDESC) || '</div>' 
					      ELSE TRIM (WNDESC) END ) AS WNDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETAULSAN) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETAULSAN) || '</div>' 
					      ELSE TRIM (SHETAULSAN) END ) AS SHETAULSAN,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHULSANQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHULSANQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHULSANQTY, '999,999,990.000')) END ) AS SHULSANQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETABUSAN) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETABUSAN) || '</div>' 
					      ELSE TRIM (SHETABUSAN) END ) AS SHETABUSAN,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHBUSANQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHBUSANQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHBUSANQTY, '999,999,990.000')) END ) AS SHBUSANQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETAINCHE) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETAINCHE) || '</div>' 
					      ELSE TRIM (SHETAINCHE) END ) AS SHETAINCHE,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHINCHEQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHINCHEQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHINCHEQTY, '999,999,990.000')) END ) AS SHINCHEQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(BL_TOTQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(BL_TOTQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(BL_TOTQTY, '999,999,990.000')) END ) AS BL_TOTQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHMONTHQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHMONTHQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHMONTHQTY, '999,999,990.000')) END ) AS SHMONTHQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHANNUALQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHANNUALQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHANNUALQTY, '999,999,990.000')) END ) AS SHANNUALQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHHWDATE) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHHWDATE) || '</div>' 
					      ELSE TRIM (SHHWDATE) END ) AS SHHWDATE,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETBDATE) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETBDATE) || '</div>' 
					      ELSE TRIM (SHETBDATE) END ) AS SHETBDATE,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETCD) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETCD) || '</div>' 
					      ELSE TRIM (SHETCD) END ) AS SHETCD,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (BRDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (BRDESC) || '</div>' 
					      ELSE TRIM (BRDESC) END ) AS BRDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHREMARK) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHREMARK) || '</div>' 
					      ELSE TRIM (SHREMARK) END ) AS SHREMARK,
					COLOR        -- 색깔
					FROM SESSION.SILO_VESLSCHED
					WHERE ROWNO BETWEEN CAST(P_STNUM AS VARCHAR(100))AND CAST(P_FNNUM AS VARCHAR(100))
					ORDER BY ROWNO;

				OPEN REFCURSOR;

			END LIST;

			PAGING : BEGIN  -- 페이징
				DECLARE REFCURSOR3 CURSOR WITH RETURN FOR

					SELECT 
					COUNT(*) AS TOTALCOUNT
					FROM SESSION.SILO_VESLSCHED;

				OPEN REFCURSOR3;

			END PAGING;

		ELSE
  
			PRINT : BEGIN  -- 페이징
				DECLARE REFCURSOR5 CURSOR WITH RETURN FOR 
  
					SELECT
					ROWNO,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHCOMPANY) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHCOMPANY) || '</div>' 
					      ELSE TRIM (SHCOMPANY) END ) AS SHCOMPANY,

					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHVESSEL) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHVESSEL) || '</div>' 
					      ELSE TRIM (SHVESSEL) END ) AS SHVESSEL,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SKDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SKDESC) || '</div>' 
					      ELSE TRIM (SKDESC) END ) AS SKDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (GKDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (GKDESC) || '</div>' 
					      ELSE TRIM (GKDESC) END ) AS GKDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (WNDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (WNDESC) || '</div>' 
					      ELSE TRIM (WNDESC) END ) AS WNDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETAULSAN) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETAULSAN) || '</div>' 
					      ELSE TRIM (SHETAULSAN) END ) AS SHETAULSAN,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHULSANQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHULSANQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHULSANQTY, '999,999,990.000')) END ) AS SHULSANQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETABUSAN) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETABUSAN) || '</div>' 
					      ELSE TRIM (SHETABUSAN) END ) AS SHETABUSAN,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHBUSANQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHBUSANQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHBUSANQTY, '999,999,990.000')) END ) AS SHBUSANQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETAINCHE) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETAINCHE) || '</div>' 
					      ELSE TRIM (SHETAINCHE) END ) AS SHETAINCHE,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHINCHEQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHINCHEQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHINCHEQTY, '999,999,990.000')) END ) AS SHINCHEQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(BL_TOTQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(BL_TOTQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(BL_TOTQTY, '999,999,990.000')) END ) AS BL_TOTQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHMONTHQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHMONTHQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHMONTHQTY, '999,999,990.000')) END ) AS SHMONTHQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM(TO_CHAR(SHANNUALQTY, '999,999,990.000')) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM(TO_CHAR(SHANNUALQTY, '999,999,990.000')) || '</div>' 
					      ELSE TRIM(TO_CHAR(SHANNUALQTY, '999,999,990.000')) END ) AS SHANNUALQTY,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHHWDATE) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHHWDATE) || '</div>' 
					      ELSE TRIM (SHHWDATE) END ) AS SHHWDATE,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETBDATE) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETBDATE) || '</div>' 
					      ELSE TRIM (SHETBDATE) END ) AS SHETBDATE,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHETCD) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHETCD) || '</div>' 
					      ELSE TRIM (SHETCD) END ) AS SHETCD,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (BRDESC) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (BRDESC) || '</div>' 
					      ELSE TRIM (BRDESC) END ) AS BRDESC,
					(CASE WHEN COLOR = 'BLUE' THEN '<div style="color:blue" >' || TRIM (SHREMARK) || '</div>' 
					      WHEN COLOR = 'RED'  THEN '<div style="color:red" >'  || TRIM (SHREMARK) || '</div>' 
					      ELSE TRIM (SHREMARK) END ) AS SHREMARK,
					COLOR        -- 색깔
					FROM SESSION.SILO_VESLSCHED
					ORDER BY ROWNO;

				OPEN REFCURSOR5;

			END PRINT;

		END IF;

	END MAIN;
END P1;

GRANT ALTER ,EXECUTE
ON SPECIFIC PROCEDURE TYJINFWLIB.SP_TYCSS_CSS9000_LIST
TO KSGPDM WITH GRANT OPTION;


CALL TYJINFWLIB.SP_TYCSS_CSS9000_LIST(1,15, '202106', 'S')