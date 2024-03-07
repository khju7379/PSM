-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_SYSTEMLOG_TIME_LIST
-- 작성자     : 김희섭
-- 작성일     : 2016-10-28
-- 설명       : 시스템 타임 로그 조회
-- 예문       : CALL TYJINFWLIB.CMN_SYSTEMLOG_TIME_LIST ('2017', '', '', 0)
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_SYSTEMLOG_TIME_LIST
CREATE PROCEDURE TYJINFWLIB.CMN_SYSTEMLOG_TIME_LIST
(
    P_YEAR          VARCHAR(4)
   ,P_MONTH         VARCHAR(2)
   ,P_DAY           VARCHAR(2)
   ,P_DIV_TOP       INTEGER 
)
    RESULT SETS 4
    LANGUAGE SQL
M1: BEGIN

    S1 : BEGIN
        --년도별 오류 집계
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH MAIN_DATA AS (
            SELECT LOG.IDX
                 , LOG.MESSAGE
                 , LOG.USER_IP
                 , LOG.USER_ID
                 , LOG.MESSAGE_DETAIL
                 , REPLACE(FORM_ID , 'http://localhost:8092','') AS PROGRAMPATH
                 , ABS(OCCUR_TIME - EXECUTION_TIME) AS DIFF_TIME
                 , TO_CHAR(OCCUR_TIME ,'YYYY') AS OCCUR_YEAR
                 , TO_CHAR(OCCUR_TIME ,'MM'  ) AS OCCUR_MONTH
                 , TO_CHAR(OCCUR_TIME ,'DD'  ) AS OCCUR_DAY
              FROM TYJINFWLIB.CMN_SYSTEMLOG AS LOG
             WHERE LOG.LOG_TYPE = 'TIME'
               AND TO_CHAR(LOG.OCCUR_TIME ,'YYYY') = P_YEAR
             ORDER BY IDX DESC
        )
        SELECT OCCUR_YEAR
             , OCCUR_MONTH 
             , SUM(LOG_CNT) AS LOG_CNT
         FROM (SELECT OCCUR_YEAR
                    , OCCUR_MONTH
                    , 1 AS LOG_CNT
                 FROM MAIN_DATA
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '01' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '02' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '03' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '04' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '05' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '06' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '07' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '08' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '09' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '10' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '11' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , '12' AS OCCUR_MONTH , 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
         ) AS A
        GROUP BY OCCUR_YEAR , OCCUR_MONTH 
        ORDER BY OCCUR_YEAR , OCCUR_MONTH ;

        OPEN REFCURSOR;
    END S1;

    S2 : BEGIN
        --월별 오류 집계
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH MAIN_DATA AS (
        SELECT LOG.IDX
             , LOG.MESSAGE
             , LOG.USER_IP
             , LOG.USER_ID
             , LOG.MESSAGE_DETAIL
             , REPLACE(FORM_ID , 'http://localhost:8092','') AS PROGRAMPATH
             , ABS(OCCUR_TIME - EXECUTION_TIME) AS DIFF_TIME
             , TO_CHAR(OCCUR_TIME ,'YYYY') AS OCCUR_YEAR
             , TO_CHAR(OCCUR_TIME ,'MM'  ) AS OCCUR_MONTH
             , TO_CHAR(OCCUR_TIME ,'DD'  ) AS OCCUR_DAY
          FROM TYJINFWLIB.CMN_SYSTEMLOG AS LOG
         WHERE LOG.LOG_TYPE = 'TIME'
           AND TO_CHAR(LOG.OCCUR_TIME ,'YYYY') = P_YEAR
           AND TO_CHAR(LOG.OCCUR_TIME ,'MM')   = P_MONTH
         ORDER BY IDX DESC
        )
        ,SUM_MONTH AS (
            SELECT COUNT(*) AS LOG_TOTAL
              FROM MAIN_DATA
             GROUP BY OCCUR_YEAR , OCCUR_MONTH
        )

        SELECT OCCUR_DAY
             , (SELECT LOG_TOTAL FROM SUM_MONTH) AS LOG_TOTAL
             , SUM(LOG_CNT) AS LOG_CNT
         FROM (SELECT OCCUR_YEAR
                    , OCCUR_MONTH
                    , OCCUR_DAY
                    , 1 AS LOG_CNT
                 FROM MAIN_DATA
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '01' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '02' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '03' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '04' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '05' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '06' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '07' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '08' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '09' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '10' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '11' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '12' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '13' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '14' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '15' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '16' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '17' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '18' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '19' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '20' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '21' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '22' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '23' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '24' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '25' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '26' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '27' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '28' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '29' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '30' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
                UNION ALL SELECT P_YEAR AS OCCUR_YEAR , P_MONTH AS OCCUR_MONTH , '31' AS OCCUR_DAY, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
         ) AS A
        --WHERE OCCUR_DAY <= TO_CHAR(CAST( P_YEAR || (RIGHT('00' || CAST(CAST(P_MONTH AS INTEGER) + 1 AS VARCHAR(2)), 2 )) || '01'||'000000' AS TIMESTAMP) - 1 DAY,'DD')
        WHERE OCCUR_DAY		<= CASE
								WHEN P_MONTH = ''
								THEN 0
								ELSE TO_CHAR(CAST( P_YEAR || (RIGHT('00' || CAST(CAST(P_MONTH AS INTEGER) + 1 AS VARCHAR(2)), 2 )) || '01'||'000000' AS TIMESTAMP) - 1 DAY,'DD')
								END
        GROUP BY OCCUR_YEAR , OCCUR_MONTH , OCCUR_DAY
        ORDER BY OCCUR_YEAR , OCCUR_MONTH , OCCUR_DAY;

        OPEN REFCURSOR;
    END S2;


    S3 : BEGIN
        -- 시간별 조회
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH MAIN_DATA AS (
            SELECT LOG.IDX
                 , LOG.MESSAGE
                 , LOG.USER_IP
                 , LOG.USER_ID
                 , LOG.MESSAGE_DETAIL
                 , REPLACE(FORM_ID , 'http://localhost:8092','') AS PROGRAMPATH
                 , ABS(OCCUR_TIME - EXECUTION_TIME) AS DIFF_TIME
                 , TO_CHAR(OCCUR_TIME ,'YYYY')            AS OCCUR_YEAR
                 , TO_CHAR(OCCUR_TIME ,'MM'  )            AS OCCUR_MONTH
                 , TO_CHAR(OCCUR_TIME ,'DD'  )            AS OCCUR_DAY
                 , TO_CHAR(OCCUR_TIME , 'HH24') || ':00'	AS OCCUR_TIME_FORMAT
                 --, TO_CHAR(OCCUR_TIME , 'HH24:MI')          AS OCCUR_TIME_FORMAT
              FROM TYJINFWLIB.CMN_SYSTEMLOG AS LOG
             WHERE LOG.LOG_TYPE = 'TIME'
               AND TO_CHAR(LOG.OCCUR_TIME ,'YYYY') = P_YEAR
               AND TO_CHAR(LOG.OCCUR_TIME ,'MM')   = P_MONTH
               AND TO_CHAR(LOG.OCCUR_TIME ,'DD')   = P_DAY
             ORDER BY IDX DESC
        )
        ,SUM_DATA AS (
            SELECT COUNT(*) AS LOG_TOTAL
              FROM MAIN_DATA
             GROUP BY OCCUR_YEAR , OCCUR_MONTH, OCCUR_DAY
        )
        SELECT OCCUR_TIME_FORMAT
             , (SELECT LOG_TOTAL FROM SUM_DATA) AS LOG_TOTAL
             , SUM(LOG_CNT)                     AS LOG_CNT
          FROM (
            SELECT OCCUR_TIME_FORMAT
                 , 1 AS LOG_CNT
              FROM MAIN_DATA
             UNION ALL SELECT '00:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '01:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '02:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '03:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '04:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '05:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '06:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '07:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '08:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '09:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '10:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '11:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '12:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '13:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '14:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '15:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '16:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '17:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '18:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '19:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '20:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '21:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '22:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             UNION ALL SELECT '23:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             --UNION ALL SELECT '00:00' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
             --UNION ALL SELECT '23:59' AS OCCUR_TIME_FORMAT, 0 AS LOG_CNT FROM SYSIBM.SYSDUMMY1
          ) AS A
          GROUP BY OCCUR_TIME_FORMAT
          ORDER BY OCCUR_TIME_FORMAT
		  ;
        OPEN REFCURSOR;
    END S3;

    S4: BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH MAIN_DATA AS (
            SELECT LOG.IDX
                 , LOG.MESSAGE
                 , LOG.USER_IP
                 , LOG.USER_ID
                 , LOG.MESSAGE_DETAIL
                 , REPLACE(FORM_ID , 'http://localhost:8092','') AS PROGRAMPATH
                 , ABS(OCCUR_TIME - EXECUTION_TIME) AS DIFF_TIME
                 , TO_CHAR(OCCUR_TIME ,'YYYY')            AS OCCUR_YEAR
                 , TO_CHAR(OCCUR_TIME ,'MM'  )            AS OCCUR_MONTH
                 , TO_CHAR(OCCUR_TIME ,'DD'  )            AS OCCUR_DAY
                 , TO_CHAR(OCCUR_TIME , 'HH24:MI')          AS OCCUR_TIME_FORMAT
              FROM TYJINFWLIB.CMN_SYSTEMLOG AS LOG
             WHERE LOG.LOG_TYPE = 'TIME'
               AND TO_CHAR(LOG.OCCUR_TIME ,'YYYY') = P_YEAR
               AND TO_CHAR(LOG.OCCUR_TIME ,'MM')   = P_MONTH
               AND TO_CHAR(LOG.OCCUR_TIME ,'DD')   = P_DAY
             ORDER BY IDX DESC
        )
        ,SUM_DATA AS (
            SELECT PROGRAMPATH
                 , COUNT(*) AS LOG_CNT
                 , ROW_NUMBER() OVER(ORDER BY PROGRAMPATH) AS ROW_ID
              FROM MAIN_DATA
             GROUP BY PROGRAMPATH
        )
        SELECT A.PROGRAMPATH
             , A.LOG_CNT
             , IFNULL(B.DESCRIPTION,A.PROGRAMPATH) AS DESCRIPTION
          FROM SUM_DATA AS A
          LEFT OUTER JOIN CMN_PROGRAM AS B
            ON A.PROGRAMPATH = B.PROGRAMPATH
         WHERE ROW_ID <= P_DIV_TOP
		 ;
        OPEN REFCURSOR;
    END S4;
END M1