-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_PROGRAM_DEL
-- 작성자     : 문광복
-- 작성일     : 2015-09-01
-- 설명       : 프로그램 삭제
-- 예문       : EXEC CMN_PROGRAM_DEL '',''
--		DB2 변환 : 이전프로시져명 SP_MENU_MANAGEMENT_PROGRAM_DELETE
--		프렌지 변환 : PTCMMBAS50D1 -> CMN_PROGRAM_DEL
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_PROGRAM_DEL
(
	P_PROGRAMID			VARCHAR(200),				-- 프로그램 아이디
	P_MENUID			VARCHAR(200)				-- 메뉴아이디
)
	LANGUAGE SQL
P1: BEGIN

	DELETE FROM TYJINFWLIB.CMN_LANG 
		WHERE PROGRAMID = P_PROGRAMID;

	DELETE FROM TYJINFWLIB.CMN_PROGRAM
		WHERE MENUID = P_MENUID AND PROGRAMID = P_PROGRAMID;

END P1

