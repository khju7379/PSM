--DROP PROCEDURE TYJINFWLIB.ORG_USER_PASS_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_USER_PASS_GET 
-- 작성자     : 
-- 작성일     : 2017-06-28
-- 설명       : 비밀번호 조회
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_USER_PASS_GET  
(
    P_COMPANYCODE CHAR(20)
  , P_LOGINID     CHAR(20)
)
  RESULT SETS 1
  LANGUAGE SQL
  SET OPTION
  ALWCPYDTA = *OPTIMIZE
M1: BEGIN 
  
    DECLARE REFCURSOR CURSOR WITH RETURN FOR
		SELECT * FROM TYJINFWLIB.ORG_PASSWORD
		WHERE COMPANYCODE = P_COMPANYCODE
		AND EMPID     = P_LOGINID;

    OPEN REFCURSOR;
  
END M1