-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_ATTACH_ADD
-- 작성자     : 문광복
-- 작성일     : 2015-09-09
-- 설명       : 첨부파일 리스트를 조회한다.
-- 예문       : CALL CMN_ATTACH_ADD ('TEMPLETE01','10')
--		DB2 변환 : 이전프로시져명 SP_ATTACH_FILE_INSERT
-- 수정       : FILE_NAME 데이터타입변경(VARCHAR->VARGRAPHIC,VARCHAR->CHAR) 2015-12-24 박제영
--		프렌지 변환 : PTCMMBAS20I1 -> CMN_ATTACH_ADD
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