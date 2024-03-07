-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_SYSTEMLOG_TIME_GRID_DAY_LIST 
-- 작성자     : 김희섭
-- 작성일     : 2016-10-28
-- 설명       : 시스템 타임 로그 그리드 조회
-- 예문       : CALL CMN_SYSTEMLOG_TIME_GRID_DAY_LIST  ('TEMPLETE01','10')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_SYSTEMLOG_TIME_GRID_DAY_LIST  
(
    P_YEAR          VARCHAR(4)
   ,P_MONTH         VARCHAR(2)
   ,P_DAY           VARCHAR(2)
   ,P_DIV_TOP       INTEGER   
)
    RESULT SETS 2
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
                 , REPLACE(FORM_ID , 'http://localhost:8092','') AS PROGRAMPATH
                 , ABS(OCCUR_TIME - EXECUTION_TIME) AS DIFF_TIME
                 , TO_CHAR(OCCUR_TIME ,'YYYY')            AS OCCUR_YEAR
                 , TO_CHAR(OCCUR_TIME ,'MM'  )            AS OCCUR_MONTH
                 , TO_CHAR(OCCUR_TIME ,'DD'  )            AS OCCUR_DAY
				 , '' AS OCCUR_TIME_FORMAT
                 --, TO_CHAR(OCCUR_TIME , 'HH:MI')          AS OCCUR_TIME_FORMAT
              FROM CMN_SYSTEMLOG AS LOG
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
         ORDER BY LOG_CNT DESC;

        OPEN REFCURSOR;
    END S1;

    S2: BEGIN
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
				 , '' AS OCCUR_TIME_FORMAT
                 --, TO_CHAR(OCCUR_TIME , 'HH:MI')          AS OCCUR_TIME_FORMAT
              FROM CMN_SYSTEMLOG AS LOG
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
        SELECT COUNT(*) AS TOTALCOUNT
          FROM SUM_DATA AS A
          LEFT OUTER JOIN CMN_PROGRAM AS B
            ON A.PROGRAMPATH = B.PROGRAMPATH
         WHERE ROW_ID <= P_DIV_TOP;

        OPEN REFCURSOR;
    END S2;
END M1