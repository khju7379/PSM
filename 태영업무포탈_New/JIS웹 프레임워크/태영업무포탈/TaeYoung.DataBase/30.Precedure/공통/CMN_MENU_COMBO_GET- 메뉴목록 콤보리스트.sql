--DROP PROCEDURE TYJINFWLIB.CMN_MENUCOMBO_GET;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_MENU_COMBO_GET
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-01
-- ����       : �޴����� �˻� �޺�
-- ����       : EXEC CMN_MENU_COMBO_GET 
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_SELECT_SEARCH
--		������ ��ȯ : PTCMMBAS40S2 -> CMN_MENU_COMBO_GET 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_COMBO_GET()
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT	'MENU00' AS MENUID,
				'��ü����' AS KO,
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

