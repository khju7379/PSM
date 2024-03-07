-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_CODE_ADD
-- 작성자     : 김희섭
-- 작성일     : 2016-08-16
-- 설명       : 공통코드 입력
-- 예문       : EXEC CMN_CODE_ADD
-- DB2 변환   :
--		프렌지 변환 : PTCMMBAS70I1 -> CMN_CODE_ADD
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_ADD
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_ADD
(
    P_COMPANYCODE CHAR(10)
   ,P_DCODE       CHAR(12)
   ,P_PCODE       CHAR(12)
   ,P_CODE        CHAR(12)
   ,P_SODR        INTEGER
   ,P_CODTXT_KR   VARGRAPHIC(200) CCSID 1200
   ,P_CODTXT_EN   VARGRAPHIC(200) CCSID 1200
   ,P_CODTXT_ZH   VARGRAPHIC(200) CCSID 1200
   ,P_CODTXT_RU   VARGRAPHIC(200) CCSID 1200
   ,P_ERPCODE     VARCHAR(12)
   ,P_CODEXT1     VARCHAR(50)
   ,P_CODEXT2     VARCHAR(50)
   ,P_CODEXT3     VARCHAR(50)
   ,P_CODEXTN1    INTEGER
   ,P_CODEXTN2    INTEGER
   ,P_CODEXTN3    INTEGER
   ,P_USEYN       CHAR(1)
   ,P_REGID       VARCHAR(20)
)
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_CODE_ADD
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

P1: BEGIN
    IF NOT EXISTS(SELECT * FROM TYJINFWLIB.CMN_CODE WHERE COMPANYCODE = P_COMPANYCODE AND CODE = P_CODE)
    THEN
        INSERT INTO TYJINFWLIB.CMN_CODE
        ( COMPANYCODE
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
        , REGID
        , REGDT
        , UPDID
        , UPDDT
        )VALUES(
          P_COMPANYCODE
        , P_DCODE
        , P_PCODE
        , P_CODE
        , P_SODR
        , P_CODTXT_KR
        , P_CODTXT_EN
        , P_CODTXT_ZH
        , P_CODTXT_RU
        , P_ERPCODE
        , P_CODEXT1
        , P_CODEXT2
        , P_CODEXT3
        , P_CODEXTN1
        , P_CODEXTN2
        , P_CODEXTN3
        , P_USEYN
        , P_REGID
        , CURRENT DATE
        , P_REGID
        , CURRENT DATE
        );
    ELSE
        UPDATE TYJINFWLIB.CMN_CODE
           SET DCODE       = P_DCODE
             , PCODE       = P_PCODE
             , SODR        = P_SODR
             , CODTXT_KR   = P_CODTXT_KR  
             , CODTXT_EN   = P_CODTXT_EN  
             , CODTXT_ZH   = P_CODTXT_ZH  
             , CODTXT_RU   = P_CODTXT_RU  
             , ERPCODE     = P_ERPCODE
             , CODEXT1     = P_CODEXT1    
             , CODEXT2     = P_CODEXT2    
             , CODEXT3     = P_CODEXT3    
             , CODEXTN1    = P_CODEXTN1   
             , CODEXTN2    = P_CODEXTN2   
             , CODEXTN3    = P_CODEXTN3   
             , USEYN       = P_USEYN      
             , UPDID       = P_REGID      
             , UPDDT       = CURRENT DATE
         WHERE COMPANYCODE = P_COMPANYCODE
           AND CODE        = P_CODE;
    END IF;
END P1

