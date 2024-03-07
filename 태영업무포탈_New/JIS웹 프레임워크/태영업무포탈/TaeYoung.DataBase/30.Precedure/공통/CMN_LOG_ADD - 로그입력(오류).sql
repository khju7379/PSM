--DROP PROCEDURE TYJINFWLIB.CMN_LOG_ADD;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_LOG_ADD
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : �����α������� �Է��Ѵ�.
-- ����       : CALL CMN_LOG_ADD ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� SP_SYSTEM_LOG_INSERT
--		������ ��ȯ : PTLOGBAS10I2 -> CMN_LOG_ADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LOG_ADD
(
		P_LOG_TYPE				VARCHAR(5)
	,	P_BIZ_TYPE				VARCHAR(10)
	,	P_OCCUR_TIME			VARCHAR(20)
	,	P_FORM_ID				VARCHAR(1000)
	,	P_MESSAGE				VARCHAR(1000)
	,	P_MESSAGE_DETAIL		VARCHAR(4000)
	,	P_USER_IP				VARCHAR(15)
	,	P_USER_ID				VARCHAR(100)
	,	P_EXECUTION_TIME		VARCHAR(20)
	,	P_MACHINE_NAME			VARCHAR(30)
)
	--RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	INSERT INTO TYJINFWLIB.CMN_SYSTEMLOG 
	(
			LOG_TYPE
		,	BIZ_TYPE
		,	OCCUR_TIME
		,	FORM_ID
		,	MESSAGE
		,	MESSAGE_DETAIL
		,	USER_IP
		,	USER_ID
		,	EXECUTION_TIME
		,	MACHINE_NAME
	)
	VALUES
	(
			P_LOG_TYPE
		,	P_BIZ_TYPE
		,	P_OCCUR_TIME
		,	P_FORM_ID
		,	P_MESSAGE
		,	P_MESSAGE_DETAIL
		,	P_USER_IP
		,	P_USER_ID
		,	P_EXECUTION_TIME
		,	P_MACHINE_NAME
	);

END P1