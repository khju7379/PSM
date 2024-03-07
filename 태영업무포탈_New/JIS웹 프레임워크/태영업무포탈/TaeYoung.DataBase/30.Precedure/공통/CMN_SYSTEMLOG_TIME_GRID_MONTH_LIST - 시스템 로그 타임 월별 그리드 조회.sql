-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_SYSTEMLOG_TIME_GRID_LIST
-- 작성자     : 김희섭
-- 작성일     : 2016-10-28
-- 설명       : 시스템 타임 로그 그리드 조회
-- 예문       : CALL CMN_SYSTEMLOG_TIME_GRID_LIST ('TEMPLETE01','10')
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_SYSTEMLOG_TIME_GRID_MONTH_LIST
CREATE PROCEDURE TYJINFWLIB.CMN_SYSTEMLOG_TIME_GRID_MONTH_LIST
(
    P_YEAR          VARCHAR(4)
   ,P_DIV_TOP       INTEGER  
)
    RESULT SETS 1
    LANGUAGE SQL
M1: BEGIN
    S1: BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH MAIN_DATA AS (
            SELECT LOG.IDX
                 , LOG.MESSAGE
                 , LOG.USER_IP
                 , LOG.USER_ID
                 , LOG.MESSAGE_DETAIL
                 , REPLACE(REPLACE(FORM_ID , 'http://localhost:8092', ''), 'http://ep.iseohan.com', '') AS PROGRAMPATH
                 , ABS(OCCUR_TIME - EXECUTION_TIME) AS DIFF_TIME
                 , TO_CHAR(OCCUR_TIME ,'YYYY') AS OCCUR_YEAR
                 , TO_CHAR(OCCUR_TIME ,'MM'  ) AS OCCUR_MONTH
                 , TO_CHAR(OCCUR_TIME ,'DD'  ) AS OCCUR_DAY
              FROM CMN_SYSTEMLOG AS LOG
             WHERE LOG.LOG_TYPE = 'TIME'
               AND TO_CHAR(LOG.OCCUR_TIME ,'YYYY') = P_YEAR
             ORDER BY IDX DESC
        )
        SELECT *
          FROM(
            SELECT A.PROGRAMPATH
                 , COALESCE(B.DESCRIPTION, A.PROGRAMPATH) AS DESCRIPTION
                 , A.LOG_CNT_TOTAL
                 , A.LOG_CNT_1
                 , A.LOG_CNT_2
                 , A.LOG_CNT_3
                 , A.LOG_CNT_4
                 , A.LOG_CNT_5
                 , A.LOG_CNT_6
                 , A.LOG_CNT_7
                 , A.LOG_CNT_8
                 , A.LOG_CNT_9
                 , A.LOG_CNT_10
                 , A.LOG_CNT_11
                 , A.LOG_CNT_12
                 , ROW_NUMBER() OVER(ORDER BY LOG_CNT_TOTAL DESC, A.PROGRAMPATH) AS ROW_ID
               FROM(
                SELECT PROGRAMPATH
                     , SUM(LOG_CNT_TOTAL) AS LOG_CNT_TOTAL
                     , SUM(LOG_CNT_1) AS LOG_CNT_1
                     , SUM(LOG_CNT_2) AS LOG_CNT_2
                     , SUM(LOG_CNT_3) AS LOG_CNT_3
                     , SUM(LOG_CNT_4) AS LOG_CNT_4
                     , SUM(LOG_CNT_5) AS LOG_CNT_5
                     , SUM(LOG_CNT_6) AS LOG_CNT_6
                     , SUM(LOG_CNT_7) AS LOG_CNT_7
                     , SUM(LOG_CNT_8) AS LOG_CNT_8
                     , SUM(LOG_CNT_9) AS LOG_CNT_9
                     , SUM(LOG_CNT_10) AS LOG_CNT_10
                     , SUM(LOG_CNT_11) AS LOG_CNT_11
                     , SUM(LOG_CNT_12) AS LOG_CNT_12
                 FROM (SELECT PROGRAMPATH
                         , 1 AS LOG_CNT_TOTAL
                         , CASE WHEN OCCUR_MONTH = '01' THEN 1 ELSE 0 END AS LOG_CNT_1
                         , CASE WHEN OCCUR_MONTH = '02' THEN 1 ELSE 0 END AS LOG_CNT_2
                         , CASE WHEN OCCUR_MONTH = '03' THEN 1 ELSE 0 END AS LOG_CNT_3
                         , CASE WHEN OCCUR_MONTH = '04' THEN 1 ELSE 0 END AS LOG_CNT_4
                         , CASE WHEN OCCUR_MONTH = '05' THEN 1 ELSE 0 END AS LOG_CNT_5
                         , CASE WHEN OCCUR_MONTH = '06' THEN 1 ELSE 0 END AS LOG_CNT_6
                         , CASE WHEN OCCUR_MONTH = '07' THEN 1 ELSE 0 END AS LOG_CNT_7
                         , CASE WHEN OCCUR_MONTH = '08' THEN 1 ELSE 0 END AS LOG_CNT_8
                         , CASE WHEN OCCUR_MONTH = '09' THEN 1 ELSE 0 END AS LOG_CNT_9
                         , CASE WHEN OCCUR_MONTH = '10' THEN 1 ELSE 0 END AS LOG_CNT_10
                         , CASE WHEN OCCUR_MONTH = '11' THEN 1 ELSE 0 END AS LOG_CNT_11
                         , CASE WHEN OCCUR_MONTH = '12' THEN 1 ELSE 0 END AS LOG_CNT_12
                         FROM MAIN_DATA
                  ) AS A
                GROUP BY PROGRAMPATH
             ) AS A
             LEFT OUTER JOIN (	SELECT
										PROGRAMPATH
									,	MIN(DESCRIPTION) AS DESCRIPTION
								FROM
										CMN_PROGRAM
								GROUP BY PROGRAMPATH) AS B
               ON A.PROGRAMPATH = B.PROGRAMPATH
        ) AS A
        WHERE ROW_ID <= P_DIV_TOP
        ORDER BY ROW_ID;

        OPEN REFCURSOR;
    END S1;


END M1