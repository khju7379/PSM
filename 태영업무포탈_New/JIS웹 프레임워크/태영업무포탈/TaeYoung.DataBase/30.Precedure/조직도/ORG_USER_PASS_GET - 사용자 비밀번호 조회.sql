--DROP PROCEDURE TYJINFWLIB.ORG_USER_PASS_GET;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_USER_PASS_GET 
-- �ۼ���     : 
-- �ۼ���     : 2017-06-28
-- ����       : ��й�ȣ ��ȸ
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