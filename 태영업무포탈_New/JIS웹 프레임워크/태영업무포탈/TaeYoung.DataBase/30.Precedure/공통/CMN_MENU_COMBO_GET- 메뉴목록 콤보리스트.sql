--DROP PROCEDURE TYJINFWLIB.CMN_MENUCOMBO_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_MENU_COMBO_GET
-- 작성자     : 문광복
-- 작성일     : 2015-09-01
-- 설명       : 메뉴관리 검색 콤보
-- 예문       : EXEC CMN_MENU_COMBO_GET 
--		DB2 변환 : 이전프로시져명 SP_MENU_MANAGEMENT_SELECT_SEARCH
--		프렌지 변환 : PTCMMBAS40S2 -> CMN_MENU_COMBO_GET 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_COMBO_GET()
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT	'MENU00' AS MENUID,
				'전체보기' AS KO,
				'' AS EN,
				'' AS ZH,
				'' AS RU
		FROM SYSIBM.SYSDUMMY1

		UNION ALL

		SELECT M.MENUID, L.KO, L.EN, L.ZH, L.RU
		FROM TYJINFWLIB.CMN_MENU M
			INNER JOIN TYJINFWLIB.CMN_LANG L
				ON M.MENUID = L.CODE
		WHERE COALESCE(M.PRTMENU,'') = '';

	OPEN REFCURSOR;

END P1

