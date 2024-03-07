-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_CODE_DEL
-- 작성자     : 김희섭
-- 작성일     : 2016-08-16
-- 설명       : 공통코드 삭제
-- 예문       : EXEC CMN_CODE_DEL
-- DB2 변환   :
--		프렌지 변환 : PTCMMBAS70D1 -> CMN_CODE_DEL
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_DEL
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_DEL
(
    P_COMPANYCODE CHAR(10)
   ,P_CODE        CHAR(12)
   ,P_REGID       CHAR(20)
)
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_CODE_DEL
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

P1: BEGIN
    --UPDATE TYJINFWLIB.CMN_CODE
    --   SET USEYN = P_USEYN
    --     , UPDID = P_REGID
    --     , UPDDT = CURRENT DATE
    -- WHERE COMPANYCODE = P_COMPANYCODE
    --   AND CODE        = P_CODE;

    DELETE FROM TYJINFWLIB.CMN_CODE WHERE COMPANYCODE = P_COMPANYCODE AND CODE = P_CODE;
END P1

