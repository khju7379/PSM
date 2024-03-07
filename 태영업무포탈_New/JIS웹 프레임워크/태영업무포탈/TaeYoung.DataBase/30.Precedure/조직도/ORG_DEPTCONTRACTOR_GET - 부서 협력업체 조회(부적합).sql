--DROP PROCEDURE TYJINFWLIB.ORG_DEPTCONTRACTOR_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_DEPTCONTRACTOR_GET
-- 작성자     : 김희섭
-- 작성일     : 2015-09-02
-- 설명       : 업체 정보 조회
-- 예문       : CALL ORG_DEPTCONTRACTOR_GET (1, 20, '', 'ko', '1000')
-- DB2 변환 : 이전프로시져명 SP_USER_SELECT_VENDOR
--		프렌지 변환 : PTORGUSR70L1 -> ORG_DEPTCONTRACTOR_GET
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_DEPTCONTRACTOR_GET
(
    P_CURRENTPAGEINDEX       INTEGER,       -- 목록의 현재페이지 번호  
    P_PAGESIZE               INTEGER,       -- 목록의 한 페이지에 표현되는 글 목록수  
    P_SEARCHCONDITION        VARCHAR(4000)  ,       -- 조회조건 내용
    P_LANGCODE               CHAR(2),
    P_COMPANYCODE            CHAR(10)
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

    DECLARE GLOBAL TEMPORARY TABLE SESSION.PTORGUSR70L6(
               COMPANYCODE      VARCHAR(10)
            ,  EMPID            VARCHAR(10)
            ,  USERNAME         VARGRAPHIC(2000) CCSID 1200
    ) WITH REPLACE ;

    INSERT INTO SESSION.PTORGUSR70L6
    SELECT A.COMPANYCODE
         , A.DEPTCODE    AS EMPID
         , B.DEPTNAME    AS USERNAME
     FROM ORG_DEPT AS A
     LEFT OUTER JOIN ORG_DEPTLANG AS B
       ON A.COMPANYCODE = B.COMPANYCODE
      AND A.DEPTCODE    = B.DEPTCODE
      AND B.LANGCODE    = P_LANGCODE
    WHERE 1=1
      AND A.COMPANYCODE     = P_COMPANYCODE
      AND A.PARENTDEPTCODE != ''
      AND (A.DEPTCODE    LIKE '%'|| P_SEARCHCONDITION || '%'
       OR  B.DEPTNAME    LIKE '%'|| P_SEARCHCONDITION || '%'
          );
          
    INSERT INTO SESSION.PTORGUSR70L6
    SELECT A.COMPANYCODE
         , A.EMPID
         , C.USERLNAME || C.USERFNAME AS USERNAME
      FROM ORG_USER AS A
     INNER JOIN ORG_USERLANG AS C
        ON A.COMPANYCODE = C.COMPANYCODE 
       AND A.EMPID       = C.EMPID 
       AND C.LANGCODE    = P_LANGCODE
     WHERE A.COMPANYCODE = P_COMPANYCODE
       AND (C.USERLNAME || C.USERFNAME LIKE  '%'|| P_SEARCHCONDITION || '%' 
        OR  A.EMPID  LIKE P_SEARCHCONDITION || '%')
       AND SUBSTRING(A.MAINDEPTCODE ,1,1) = 'Z'
       AND A.EMPID IS NOT NULL
       AND A.EMPID != '';

    M1 : BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        SELECT COMPANYCODE
             , EMPID
             , USERNAME
         FROM(
        SELECT ROW_NUMBER() OVER() AS ROWNO
             , COMPANYCODE
             , EMPID
             , USERNAME
          FROM SESSION.PTORGUSR70L6
          ) AS A
         WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
         ;

        OPEN REFCURSOR ;
    END M1;
    
    M2 : BEGIN
    DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT
          FROM SESSION.PTORGUSR70L6
         ;

        OPEN REFCURSOR2 ;
    END M2;
END P1