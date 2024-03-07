-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_CODE_GET
-- 작성자     : 김희섭
-- 작성일     : 2016-08-16
-- 설명       : 공콩코드 콤보 조회
-- 예문       : CALL CMN_CODE_GET ('TEMPLETE01','10')
-- DB2 변환   :
--		프렌지 변환 : PTCMMBAS10I1 -> CMN_CODE_GET
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_GET
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_GET 
(
    P_COMPANYCODE CHAR(10),
    P_LANGCODE    CHAR(2),
    P_DCODE       CHAR(12),
    P_PCODE       CHAR(12)
)

    RESULT SETS 1
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_CODE_GET
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

M1: BEGIN
    DECLARE REFCURSOR CURSOR WITH RETURN FOR
    SELECT COMPANYCODE
         , CODE
         , PCODE
         , SODR
         , CASE P_LANGCODE WHEN 'ko' THEN CODTXT_KR
                           WHEN 'en' THEN CODTXT_EN
                           WHEN 'zh' THEN CODTXT_ZH
                           WHEN 'ru' THEN CODTXT_RU
                           ELSE CODTXT_KR END AS CODTXT
         , CODEXT1
         , CODEXT2
         , CODEXT3
         , COALESCE(CODEXTN1,0) AS CODEXTN1
         , COALESCE(CODEXTN2,0) AS CODEXTN2
         , COALESCE(CODEXTN3,0) AS CODEXTN3
         , USEYN
         , REGID
         , REGDT
         , UPDID
         , UPDDT
      FROM CMN_CODE
     WHERE COMPANYCODE         = P_COMPANYCODE 
       AND DCODE               = P_DCODE
       AND PCODE               = P_PCODE
       AND COALESCE(USEYN,'N') = 'Y'
     ORDER BY COMPANYCODE ASC, SODR;

    OPEN REFCURSOR;

END M1