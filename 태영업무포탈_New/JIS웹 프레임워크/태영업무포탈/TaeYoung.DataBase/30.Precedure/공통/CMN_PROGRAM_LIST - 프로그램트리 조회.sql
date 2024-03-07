--DROP PROCEDURE TYJINFWLIB.CMN_PROGRAM_LIST;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_PROGRAM_LIST
-- 작성자     : 문광복
-- 작성일     : 2015-09-01
-- 설명       : 프로그램 관리 트리 목록
-- 예문       : EXEC CMN_PROGRAM_LIST '테스트1-1'
--		DB2 변환 : 이전프로시져명 SP_MENU_MANAGEMENT_TREE_SELECT_PROGRAM
--		프렌지 변환 : PTCMMBAS50L1 -> CMN_PROGRAM_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_PROGRAM_LIST
(
	P_MENUID			VARCHAR(50)	
)
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN

	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT MENUID, PROGRAMID, PROGRAMPATH, DESCRIPTION, POPUP, POPUP_SIZE,MENUTYPE
		FROM TYJINFWLIB.CMN_PROGRAM
		WHERE MENUID = P_MENUID;

	OPEN REFCURSOR;

END P1