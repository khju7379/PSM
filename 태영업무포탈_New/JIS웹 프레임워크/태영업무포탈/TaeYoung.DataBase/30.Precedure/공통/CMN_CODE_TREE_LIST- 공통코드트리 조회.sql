
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_CODE_TREE_LIST
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 공통코드를 조회한다.
-- 예문       : CALL CMN_CODE_TREE_LIST ('2006909','1000','TS1301')
--      DB2 변환 : 이전프로시져명 UP_GBLCOD_SELECT
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_TREE_LIST;
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_TREE_LIST 
( 
    IN P_COMPANYCODE CHAR(10),
    IN P_DCODE       CHAR(12),
    IN P_PCODE       CHAR(12),
    IN P_USEYN       CHAR(1),
    IN P_LANGCODE    CHAR(2) 
)
    RESULT SETS 1
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_CODE_TREE_LIST

P1 : BEGIN
    -- #######################################################################
    -- # Returns all tables created by NVHTLIB
    -- #######################################################################
    -- Declare cursor
    DECLARE REFCURSOR CURSOR WITH RETURN FOR

    SELECT COMPANYCODE
         , DCODE
         , PCODE
         , CODE
         , SODR
         , CODTXT_KR
         , CODTXT_EN
         , CODTXT_ZH
         , CODTXT_RU
         , ERPCODE
         , CODEXT1
         , CODEXT2
         , CODEXT3
         , CODEXTN1
         , CODEXTN2
         , CODEXTN3
         , USEYN
         , CASE ucase(P_LANGCODE) WHEN 'KO' THEN CODTXT_KR
                                  WHEN 'EN' THEN CODTXT_EN
                                  WHEN 'ZH' THEN CODTXT_ZH
                                  WHEN 'RU' THEN CODTXT_RU
                                  ELSE CODTXT_KR END AS CODTXT 
      FROM TYJINFWLIB.CMN_CODE
     WHERE COMPANYCODE              = CASE WHEN P_COMPANYCODE = '' THEN COMPANYCODE        ELSE P_COMPANYCODE END
       AND COALESCE(TRIM(DCODE),'') = CASE WHEN P_DCODE       = '' THEN COALESCE(DCODE,'') ELSE P_DCODE       END 
       AND COALESCE(TRIM(PCODE),'') = CASE WHEN P_PCODE       = '' THEN COALESCE(PCODE,'') ELSE P_PCODE       END 
       AND USEYN                    = CASE WHEN P_USEYN       = '' THEN USEYN              ELSE P_USEYN       END
     ORDER BY COMPANYCODE, COALESCE(PCODE,CODE), PCODE DESC, SODR ;
        
    -- Cursor left open for client application
    OPEN REFCURSOR ;
END