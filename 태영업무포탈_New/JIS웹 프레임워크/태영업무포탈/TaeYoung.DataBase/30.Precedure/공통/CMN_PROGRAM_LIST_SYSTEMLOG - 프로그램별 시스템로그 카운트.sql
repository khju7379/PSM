-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_PROGRAM_LIST_SYSTEMLOG
-- 작성자     : 장윤호	
-- 작성일     : 2017-07-10
-- 설명       : 프로그램별 시스템로그 카운트
-- 예문       : CALL TYJINFWLIB.CMN_PROGRAM_LIST_SYSTEMLOG('SEOHAN', 'SH2017T07')
-- DB2 변환   : 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_PROGRAM_LIST_SYSTEMLOG
CREATE PROCEDURE TYJINFWLIB.CMN_PROGRAM_LIST_SYSTEMLOG
(
		P_STDT				VARCHAR(8)
	,	P_EDDT				VARCHAR(8)
)

     RESULT SETS 2
    LANGUAGE SQL

M1: BEGIN
	S1 : BEGIN
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
		WITH PROG AS (
			SELECT
					PROGRAMPATH
				,	MIN(DESCRIPTION) AS DESCRIPTION
			FROM
					TYJINFWLIB.CMN_PROGRAM
			GROUP BY PROGRAMPATH
		)
		, SYSLOG AS (
			SELECT
					SL.*
				, 	REPLACE(REPLACE(CASE
										WHEN LOCATE('?', SL.FORM_ID) != 0
										THEN SUBSTR(SL.FORM_ID, 1, (LOCATE('?', SL.FORM_ID) - 1))
										ELSE SL.FORM_ID
									END , 'http://localhost:8092', ''), 'http://ep.iseohan.com', '') AS PROGRAMPATH
			FROM
					TYJINFWLIB.CMN_SYSTEMLOG AS SL
			WHERE
					SL.LOG_TYPE 									IN ('TIME', 'AUDIT')
			AND		VARCHAR_FORMAT(SL.OCCUR_TIME, 'yyyyMMdd')		BETWEEN P_STDT AND P_EDDT
			AND		USER_IP											NOT IN ('::1', '127.0.0.1')		-- 로컬에서 접속한것 카운팅 제외
		)
		SELECT
				P.PROGRAMPATH
			,	MIN(P.DESCRIPTION) AS DESCRIPTION
			,	SUM(CASE
						WHEN COALESCE(S.PROGRAMPATH, '') != ''
						THEN 1
						ELSE 0
					END) AS PROGRAM_CNT
		FROM
				PROG AS P
				LEFT OUTER JOIN SYSLOG AS S
					ON	S.PROGRAMPATH	= P.PROGRAMPATH
		GROUP BY P.PROGRAMPATH
		ORDER BY MIN(P.DESCRIPTION) ASC
		;
		OPEN REFCURSOR;
	END S1;
END M1;