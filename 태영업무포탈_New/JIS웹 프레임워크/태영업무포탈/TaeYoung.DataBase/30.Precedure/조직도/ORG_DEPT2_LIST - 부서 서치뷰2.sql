-------------------------------------------------------------------------------------------
--
-- 프로시저명  : ORG_DEPT2_LIST
-- 작성자     : 김희섭
-- 작성일     : 2015-09-16
-- 설명       : 부서 서치뷰2
-- 예문       : CALL ORG_DEPT2_LIST (1,20,'','ko')
-- DB2 변환   : 이전프로시져명 UP_DEPT_SEARCHVIEW2
--		프렌지 변환 : PTORGUSR20L2 -> ORG_DEPT2_LIST 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_DEPT2_LIST 
(
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
    
    S1 : BEGIN -- 값 설정
        SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
    END S1 ;
    
    MAIN : BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        SELECT DEPTCODE
              ,DEPTNAME
          FROM(SELECT A.DEPTCODE
                     ,COALESCE(B.DEPTNAME,A.DISPLAYNAME) AS DEPTNAME
                     ,ROW_NUMBER() OVER (ORDER BY A.DEPTCODE) AS ROWNO
                 FROM ORG_DEPT AS A
                 LEFT OUTER JOIN ORG_DEPTLANG AS B
                   ON A.COMPANYCODE = B.COMPANYCODE
                  AND A.DEPTCODE    = B.DEPTCODE
                  AND B.LANGCODE    = P_LANGCODE
                WHERE A.DEPTCODE LIKE P_SEARCHCONDITION || '%'
                   OR COALESCE(B.DEPTNAME,A.DISPLAYNAME) LIKE P_SEARCHCONDITION || '%'
          ) AS A
         WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM;
    
        OPEN REFCURSOR;
    END MAIN;
    
    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT  
          FROM ORG_DEPT AS A
          LEFT OUTER JOIN ORG_DEPTLANG AS B
            ON A.COMPANYCODE = B.COMPANYCODE
           AND A.DEPTCODE    = B.DEPTCODE
           AND B.LANGCODE    = P_LANGCODE
         WHERE A.DEPTCODE LIKE P_SEARCHCONDITION || '%'
            OR COALESCE(B.DEPTNAME,A.DISPLAYNAME) LIKE P_SEARCHCONDITION || '%';

          OPEN REFCURSOR2;
    END TOTAL;
END P1