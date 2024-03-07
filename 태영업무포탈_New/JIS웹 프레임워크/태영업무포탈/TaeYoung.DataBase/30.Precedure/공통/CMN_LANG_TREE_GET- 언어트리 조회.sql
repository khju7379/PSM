--DROP PROCEDURE TYJINFWLIB.CMN_LANGTREE_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_LANGTREE_GET
-- 작성자     : 문광복
-- 작성일     : 2015-09-01
-- 설명       : 다국어 트리 목록
-- 예문       : EXEC CMN_LANG_TREE_GET '그'
--		DB2 변환 : 이전프로시져명 SP_MENU_MANAGEMENT_TREE_SELECT_LANG
--		프렌지 변환 : PTCMMBAS30L2 -> CMN_LANG_TREE_GET 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG_TREE_GET
(
	P_PROGRAMID			VARCHAR(50)			-- 프로그램 아이디
)
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN

	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT PROGRAMID, CODE, KO, EN, ZH, RU
		FROM TYJINFWLIB.CMN_LANG
		WHERE PROGRAMID = P_PROGRAMID;

	OPEN REFCURSOR;

END P1

