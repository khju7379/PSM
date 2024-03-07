-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_LANG2_DEL
-- 작성자     : 문광복
-- 작성일     : 2014-04-11
-- 설명       : 다국어 코드 삭제
-- 예문       : EXEC CMN_LANG2_DEL ''
--		DB2 변환 : 이전프로시져명 SP_MENU_MANAGEMENT_LANG_DELETE
--		프렌지 변환 : PTCMMBAS30D2 -> CMN_LANG2_DEL
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG2_DEL
(
	P_CODE			VARCHAR(200),
	P_PROGRAMID		VARCHAR(200)
)
	LANGUAGE SQL

P1: BEGIN

	DELETE FROM TYJINFWLIB.CMN_LANG
	WHERE CODE = P_CODE AND PROGRAMID = P_PROGRAMID;

END P1

