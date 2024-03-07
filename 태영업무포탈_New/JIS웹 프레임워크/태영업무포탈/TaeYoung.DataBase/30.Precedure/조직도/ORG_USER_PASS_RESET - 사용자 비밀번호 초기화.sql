--DROP PROCEDURE TYJINFWLIB.ORG_USER_PASS_RESET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_USER_PASS_GET 
-- 작성자     : 
-- 작성일     : 2017-06-28
-- 설명       : 비밀번호 조회
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_USER_PASS_RESET
(
    P_COMPANYCODE CHAR(20)
  , P_LOGINID     CHAR(20)
  ,	P_PASSWORD	  CHAR(20)
)
  LANGUAGE SQL
  SET OPTION
  ALWCPYDTA = *OPTIMIZE
M1: BEGIN 
  
    UPDATE TYJINFWLIB.ORG_PASSWORD
		SET PASSWORD = P_PASSWORD
		WHERE COMPANYCODE = P_COMPANYCODE
		AND EMPID     = P_LOGINID;
  
END M1