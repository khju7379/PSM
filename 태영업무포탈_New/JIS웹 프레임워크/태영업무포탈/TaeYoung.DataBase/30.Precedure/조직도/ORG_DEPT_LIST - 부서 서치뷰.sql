-------------------------------------------------------------------------------------------
--
-- 프로시저명  : ORG_DEPT_LIST 
-- 작성자     : 김희섭
-- 작성일     : 2015-09-16
-- 설명       : 부서 서치뷰
-- 예문       : CALL ORG_DEPT_LIST  (1,20,'')
-- DB2 변환   : 이전프로시져명 UP_DEPT_SEARCHVIEW
--		프렌지 변환 : PTORGUSR20L1 -> ORG_DEPT_LIST 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE ORG_DEPT_LIST  (

    P_CURRENTPAGEINDEX           INTEGER             ,  -- 목록의 현재페이지 번호  
    P_PAGESIZE                   INTEGER             ,  -- 목록의 한 페이지에 표현되는 글 목록수  
    P_SEARCHCONDITION            VARCHAR(4000)          -- 조회조건 내용  

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
        WITH ORIGINAL_DATA AS (
            SELECT ROW_NUMBER() OVER (ORDER BY DEPTCODE ASC) AS ROWNO
                  ,COMPANYCODE
                  ,DEPTCODE
                  ,DEPTORDER
                  ,PARENTDEPTCODE
                  ,DISPLAYNAME
              FROM ORG_DEPT
             WHERE 1=1
               AND COMPANYCODE     = '1000'
               AND PARENTDEPTCODE != ''
               AND (DEPTCODE    LIKE '%'|| P_SEARCHCONDITION || '%'
                OR  DISPLAYNAME LIKE '%'|| P_SEARCHCONDITION || '%'
                )
        )
        
        SELECT (SELECT COUNT(*) FROM ORIGINAL_DATA) + 1 - A.ROWNO AS NO
             ,A.*
          FROM ORIGINAL_DATA AS A
         WHERE (ROWNO BETWEEN P_STNUM AND P_FNNUM)
           AND COMPANYCODE    =  '1000'
           AND PARENTDEPTCODE != ''
         ORDER BY A.ROWNO ASC;
    
        OPEN REFCURSOR;
    END MAIN;
    
    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT
          FROM ORG_DEPT
         WHERE 1=1
           AND COMPANYCODE     = '1000'
           AND PARENTDEPTCODE != ''
           AND (DEPTCODE    LIKE '%'|| P_SEARCHCONDITION || '%'
            OR  DISPLAYNAME LIKE '%'|| P_SEARCHCONDITION || '%'
            );
    
        OPEN REFCURSOR2;
    END TOTAL;
END P1