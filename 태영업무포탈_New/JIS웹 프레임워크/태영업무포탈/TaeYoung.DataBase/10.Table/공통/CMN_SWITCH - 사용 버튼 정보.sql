-- 권한정보
-- TB_ACL
CREATE TABLE TYJINFWLIB.CMN_SWITCH 
(
      COMPANYCODE CHAR(20)
    , CVYN        CHAR(1)
    , REGCO       CHAR(10)                       -- 수정자법인
    , REGID       CHAR(20)                       -- 등록자
    , REGDAT      TIMESTAMP                      -- 등록일
    , UPDCO       CHAR(10)                       -- 수정자법인
    , UPDID       CHAR(20)                       -- 수정자
    , UPDDAT      TIMESTAMP                      -- 수정일
    , PRIMARY KEY (COMPANYCODE)
);

COMMENT ON TABLE TYJINFWLIB.CMN_SWITCH IS '공통-사용 버튼 정보'; 

COMMENT ON COLUMN TYJINFWLIB.CMN_SWITCH
(
    COMPANYCODE IS '법인',
    CVYN        IS '사용 권한'
); 

