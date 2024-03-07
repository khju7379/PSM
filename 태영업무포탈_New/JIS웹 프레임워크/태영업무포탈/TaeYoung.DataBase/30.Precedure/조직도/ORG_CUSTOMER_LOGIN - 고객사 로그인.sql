--DROP PROCEDURE TYJINFWLIB.ORG_CUSTOMER_LOGIN;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_CUSTOMER_LOGIN
-- �ۼ���     : ������
-- �ۼ���     : 2021-04-12
-- ����       : ���� ���� �� ��й�ȣ�� �α����� �����Ѵ�.
-- ����       : CALL ORG_CUSTOMER_LOGIN ('','')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_CUSTOMER_LOGIN
(
	P_LOGINID VARCHAR(50),
	P_PASSWORD VARCHAR(50)
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN


	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	
	WITH TABLE1 AS (
	   SELECT  EMUSERID,
			   EMPASSWD,
			   EMPASGB
	   FROM TYSCMLIB.WEDIUSEF
		UNION ALL
	   SELECT  EMUSERID,
			   EMPASSWD,
			   EMPASGB
	   FROM TGSCMLIB.WEDIUSEF
	)
	SELECT COUNT(*) 
	FROM TABLE1
	WHERE EMUSERID = P_LOGINID
	   AND EMPASSWD = P_PASSWORD
	   AND EMPASGB = 'Y';
	
	OPEN REFCURSOR;
END P1