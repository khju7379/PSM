-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_ATTACH_ADD
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-09
-- ����       : ÷������ ����Ʈ�� ��ȸ�Ѵ�.
-- ����       : CALL CMN_ATTACH_ADD ('TEMPLETE01','10')
--		DB2 ��ȯ : �������ν����� SP_ATTACH_FILE_INSERT
-- ����       : FILE_NAME ������Ÿ�Ժ���(VARCHAR->VARGRAPHIC,VARCHAR->CHAR) 2015-12-24 ������
--		������ ��ȯ : PTCMMBAS20I1 -> CMN_ATTACH_ADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_ATTACH_ADD 
(
	P_ATTACH_TYPE	CHAR(50),
	P_ATTACH_NO		CHAR(50),
	P_ATTACH_UNID	CHAR(50),
	P_FILE_NAME		VARGRAPHIC(500) CCSID 1200,
	P_FILE_SIZE		BIGINT,
	P_FILE_MIME		VARCHAR(100),
	P_FILE_EXT		VARCHAR(50),
	P_FILE_PATH		VARCHAR(4000)
)
	--RESULT SETS 1
	LANGUAGE SQL
M1: BEGIN
	
	INSERT INTO CMN_ATTACH
	(
		ATTACH_TYPE
	,	ATTACH_NO
	,	ATTACH_UNID
	,	FILE_NAME
	,	FILE_SIZE
	,	FILE_MIME
	,	FILE_EXT
	,	FILE_PATH
	)
	VALUES
	(
		P_ATTACH_TYPE
	,	P_ATTACH_NO
	,	P_ATTACH_UNID
	,	P_FILE_NAME
	,	P_FILE_SIZE
	,	P_FILE_MIME
	,	P_FILE_EXT
	,	P_FILE_PATH
	);

END M1;