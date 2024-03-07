-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_CODE_LIST2
-- 작성자     : 김희섭
-- 작성일     : 2016-08-16
-- 설명       : 공콩코드 서치뷰 조회
-- 예문       : CALL CMN_CODE_LIST2 ('TEMPLETE01','10')
-- DB2 변환   : 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_LIST2;
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_LIST2
(
     IN P_CURRENTPAGEINDEX    INTEGER
   , IN P_PAGESIZE            INTEGER
   , IN P_LANGCODE            CHAR(2)
   , IN P_COMPANYCODE         CHAR(10)
   , IN P_DCODE               CHAR(12)
   , IN P_PCODE               CHAR(12)
   , IN P_SEARCHCONDITION     VARGRAPHIC(4000) CCSID 1200
)

     RESULT SETS 2
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_CODE_LIST2
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

M1: BEGIN
      --페이징 변수
    DECLARE P_STNUM      INTEGER;
    DECLARE P_FNNUM      INTEGER;

    --페이징 값 세팅
    P1: BEGIN
        SET P_STNUM = (P_PAGESIZE * (P_CURRENTPAGEINDEX - 1)) + 1;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX;
    END P1;

    S1 : BEGIN 
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        SELECT *
          FROM(
                SELECT COMPANYCODE
                     , CODE
                     , PCODE
                     , SODR
                     , ERPCODE
                     , CODTXT
					 , CODEXT1
					 , CODEXT2
					 , CODEXT3
                     , ROW_NUMBER() OVER(ORDER BY COMPANYCODE, PCODE , SODR , CODE)   AS ROWNO
                  FROM ( SELECT COMPANYCODE
                              , CODE
                              , PCODE
                              , SODR
                              , ERPCODE
							  , CODEXT1
							  , CODEXT2
							  , CODEXT3
                              , CASE ucase(P_LANGCODE) WHEN 'KO' THEN CODTXT_KR
                                                       WHEN 'EN' THEN CODTXT_EN
                                                       WHEN 'ZH' THEN CODTXT_ZH
                                                       WHEN 'RU' THEN CODTXT_RU
                                                       ELSE CODTXT_KR END AS CODTXT 
                           FROM TYJINFWLIB.CMN_CODE
                          WHERE COMPANYCODE         = P_COMPANYCODE 
                            AND COALESCE(DCODE ,'') = COALESCE(TRIM(P_DCODE),'')
                            AND COALESCE(PCODE ,'') = COALESCE(TRIM(P_PCODE),'')
                            AND COALESCE(USEYN,'N') = 'Y'
                  ) AS A
                 WHERE (CODTXT LIKE P_SEARCHCONDITION || '%'
                    OR  CODE   LIKE P_SEARCHCONDITION || '%'
                       )
          ) AS A
         WHERE  ROWNO BETWEEN P_STNUM AND P_FNNUM
         ORDER BY ROWNO;
        
        OPEN REFCURSOR;
    END S1;

    S2 : BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT
          FROM ( SELECT COMPANYCODE
                        , CODE
                        , PCODE
                        , SODR
                        , ERPCODE
                        , CASE ucase(P_LANGCODE) WHEN 'KO' THEN CODTXT_KR
                                                 WHEN 'EN' THEN CODTXT_EN
                                                 WHEN 'ZH' THEN CODTXT_ZH
                                                 WHEN 'RU' THEN CODTXT_RU
                                                 ELSE CODTXT_KR END AS CODTXT 
                     FROM TYJINFWLIB.CMN_CODE
                    WHERE COMPANYCODE         = P_COMPANYCODE 
                      AND COALESCE(DCODE ,'') = COALESCE(TRIM(P_DCODE),'')
                      AND COALESCE(PCODE ,'') = COALESCE(TRIM(P_PCODE),'')
                      AND COALESCE(USEYN,'N') = 'Y'
            ) AS A
           WHERE (CODTXT LIKE P_SEARCHCONDITION || '%'
              OR  CODE   LIKE P_SEARCHCONDITION || '%'
                 )
           ;

        OPEN REFCURSOR;
    END S2;

END M1