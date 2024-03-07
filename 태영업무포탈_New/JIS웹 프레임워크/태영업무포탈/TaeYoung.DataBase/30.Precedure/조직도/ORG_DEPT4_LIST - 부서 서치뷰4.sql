-------------------------------------------------------------------------------------------
--
-- 프로시저명  : ORG_DEPT4_LIST
-- 작성자     : 김희섭
-- 작성일     : 2015-09-16
-- 설명       : 부서 서치뷰4
-- 예문       : CALL ORG_DEPT4_LIST (1,20,'','ko')
-- DB2 변환   : 이전프로시져명 UP_DEPT_SEARCHVIEW4
--		프렌지 변환 : PTORGUSR20L4 -> ORG_DEPT4_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE ORG_DEPT4_LIST (
    P_CURRENTPAGEINDEX           INTEGER,       -- 목록의 현재페이지 번호
    P_PAGESIZE                   INTEGER,       -- 목록의 한 페이지에 표현되는 글 목록수
    P_SEARCHCONDITION            VARCHAR(4000)  ,       -- 조회조건 내용
    P_LANGCODE                   VARCHAR(2)
)
    LANGUAGE SQL
    RESULT SETS 2

P1: BEGIN
    DECLARE P_STNUM INTEGER ;
    DECLARE P_FNNUM INTEGER ;

    DECLARE GLOBAL TEMPORARY TABLE SESSION . T (
                DEPTCODE        VARCHAR (50)                 --부서코드
            ,   DEPTNAME        VARGRAPHIC(100)  CCSID 1200  -- 부서명
    ) WITH REPLACE ;

    S1 : BEGIN -- 값 설정
        SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
    END S1 ;

    INSERT INTO SESSION.T
        SELECT DEPTCODE
                     ,DEPTNAME
                 FROM(SELECT A.DEPTCODE
                            ,COALESCE(B.DEPTNAME, A.DISPLAYNAME) AS DEPTNAME
                        FROM ORG_DEPT AS A
                        LEFT OUTER JOIN ORG_DEPTLANG AS B
                          ON A.COMPANYCODE = B.COMPANYCODE
                         AND A.DEPTCODE    = B.DEPTCODE
                         AND B.LANGCODE    = P_LANGCODE
                       UNION ALL
                      SELECT A.EMPID AS DEPTCODE
                            ,B.USERLNAME || B.USERFNAME AS DEPTNAME
                        FROM ORG_USER AS A
                        LEFT OUTER JOIN ORG_USERLANG AS B
                          ON A.COMPANYCODE = B.COMPANYCODE
                         AND A.EMPID       = B.EMPID
                         AND B.LANGCODE    = P_LANGCODE
                 ) AS A
                WHERE A.DEPTCODE LIKE P_SEARCHCONDITION || '%'
                   OR A.DEPTNAME LIKE P_SEARCHCONDITION || '%'
                   ;

    M1 : BEGIN

        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        SELECT DEPTCODE
              ,DEPTNAME
          FROM(SELECT DEPTCODE
                     ,DEPTNAME
                     ,ROW_NUMBER ( ) OVER ( ORDER BY DEPTCODE ) AS ROWNO
                 FROM SESSION.T
          ) AS A
         WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM;


        OPEN REFCURSOR ;
    END M1;

    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
          SELECT COUNT ( * ) AS TOTALCOUNT FROM SESSION . T ;


        OPEN REFCURSOR2;

    END TOTAL;
END P1