-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_CODE_FOR_ERPCODE_LIST
-- 작성자     : 김희섭
-- 작성일     : 2016-08-16
-- 설명       : 공콩코드 콤보 조회
-- 예문       : CALL TYJINFWLIB.CMN_CODE_FOR_ERPCODE_LIST ('SEOHAN','CMN0100106', 'IR08', 'KO)
-- DB2 변환   : 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_FOR_ERPCODE_LIST;
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_FOR_ERPCODE_LIST
(
    P_COMPANYCODE CHAR(10),
    P_DCODE       CHAR(12),
    P_PCODE       CHAR(12),
    P_ERPCODE     CHAR(12),
    P_LANGCODE    CHAR(2)
)

     RESULT SETS 1
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_CODE_FOR_ERPCODE_LIST
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

M1: BEGIN
    DECLARE REFCURSOR CURSOR WITH RETURN FOR
    SELECT COMPANYCODE
         , CODE
         , DCODE
         , PCODE
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
         , REGID
         , REGDT
         , UPDID
         , UPDDT
         , CASE ucase(P_LANGCODE) WHEN 'KO' THEN CODTXT_KR
                                  WHEN 'EN' THEN CODTXT_EN
                                  WHEN 'ZH' THEN CODTXT_ZH
                                  WHEN 'RU' THEN CODTXT_RU
                                  ELSE CODTXT_KR END AS CODTXT 
         , ROW_NUMBER() OVER(ORDER BY COMPANYCODE, PCODE, CODE, SODR)   AS ROWNO
      FROM TYJINFWLIB.CMN_CODE
     WHERE COMPANYCODE           = P_COMPANYCODE 
       AND COALESCE(DCODE   ,'') = COALESCE(TRIM(P_DCODE),'')
       AND COALESCE(PCODE   ,'') = COALESCE(TRIM(P_PCODE),'')
       AND COALESCE(ERPCODE ,'') = CASE WHEN P_ERPCODE != '2' THEN COALESCE(ERPCODE,'') ELSE P_ERPCODE END
       AND COALESCE(USEYN,'N') = 'Y'
     ORDER BY COMPANYCODE ASC, SODR;

    OPEN REFCURSOR;

END M1