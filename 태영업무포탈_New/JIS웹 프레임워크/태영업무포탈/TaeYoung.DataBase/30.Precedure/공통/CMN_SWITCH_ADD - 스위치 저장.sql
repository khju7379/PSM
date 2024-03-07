-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_SWITCH_ADD 
-- 작성자     : 김희섭
-- 작성일     : 2016-08-16
-- 설명       : 공콩코드 콤보 조회
-- 예문       : CALL TYJINFWLIB.CMN_SWITCH_ADD  ('SEOHAN','CMN0100106', 'IR08', 'KO)
-- DB2 변환   : 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_SWITCH_ADD;
CREATE PROCEDURE TYJINFWLIB.CMN_SWITCH_ADD
(
    P_COMPANYCODE CHAR(10),
    P_CVYN        CHAR(1),
    P_REGCO       CHAR(10),
    P_REGID       CHAR(20)
)

    --RESULT SETS 1
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_SWITCH_ADD
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

M1: BEGIN

    IF EXISTS (SELECT * FROM TYJINFWLIB.CMN_SWITCH WHERE COMPANYCODE = P_COMPANYCODE) THEN
        UPDATE TYJINFWLIB.CMN_SWITCH
           SET CVYN   = P_CVYN
             , UPDCO  = P_REGCO
             , UPDID  = P_REGID
             , UPDDAT = CURRENT TIMESTAMP
         WHERE COMPANYCODE = P_COMPANYCODE
         ;
    ELSE
        INSERT INTO TYJINFWLIB.CMN_SWITCH
        ( COMPANYCODE --CHAR(20)
        , CVYN        --CHAR(1)
        , REGCO       --CHAR(10)                       -- 수정자법인
        , REGID       --CHAR(20)                       -- 등록자
        , REGDAT      --TIMESTAMP                      -- 등록일
        , UPDCO       --CHAR(10)                       -- 수정자법인
        , UPDID       --CHAR(20)                       -- 수정자
        , UPDDAT      --TIMESTAMP                      -- 수정일
        ) 
        VALUES 
        ( P_COMPANYCODE --CHAR(20)
        , P_CVYN        --CHAR(1)
        , P_REGCO
        , P_REGID       --CHAR(20)                       -- 등록자
        , CURRENT TIMESTAMP      --TIMESTAMP                      -- 등록일
        , P_REGCO       --CHAR(10)                       -- 수정자법인
        , P_REGID       --CHAR(20)                       -- 수정자
        , CURRENT TIMESTAMP      --TIMESTAMP                      -- 수정일
        );
    END IF;

END M1