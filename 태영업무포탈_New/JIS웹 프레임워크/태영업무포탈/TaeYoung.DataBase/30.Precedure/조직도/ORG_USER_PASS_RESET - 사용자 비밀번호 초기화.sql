--DROP PROCEDURE TYJINFWLIB.ORG_USER_PASS_RESET;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_USER_PASS_GET 
-- �ۼ���     : 
-- �ۼ���     : 2017-06-28
-- ����       : ��й�ȣ ��ȸ
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