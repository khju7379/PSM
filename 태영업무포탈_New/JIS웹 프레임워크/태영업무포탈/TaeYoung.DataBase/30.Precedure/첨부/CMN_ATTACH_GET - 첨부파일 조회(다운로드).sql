-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_ATTACH_GET
-- 작성자     : 문광복
-- 작성일     : 2015-09-09
-- 설명       : 첨부파일 리스트를 조회한다.
-- 예문       : CALL CMN_ATTACH_GET ('TEMPLETE01','10')
--		DB2 변환 : 이전프로시져명 SP_ATTACH_FILE_SELECT
--		프렌지 변환 : PTCMMBAS20S1 -> CMN_ATTACH_GET
-------------------------------------------------------------------------------------------
CREATE PROCEDURE PSSCMLIB.CMN_ATTACH_GET 
(
	P_UNID	VARCHAR(50)
)
	RESULT SETS 1
	LANGUAGE SQL
M1: BEGIN
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT * 
		FROM PSSCMLIB.PSM_CMN_ATTACH
		WHERE ATTACH_UNID = P_UNID;	
		
	OPEN REFCURSOR;
	
END M1