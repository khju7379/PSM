-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_MENU_DEL
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-14
-- ����       : �޴� ����
-- ����       : EXEC CMN_MENU_DEL ''
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_MENU_DELETE
--		������ ��ȯ : PTCMMBAS40D1 -> CMN_MENU_DEL 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_DEL
(
	P_MENUID				VARCHAR(50)				-- �޴� ���̵�
)
	LANGUAGE SQL

P1: BEGIN

	-- �ٱ��� ����
	DELETE FROM TYJINFWLIB.CMN_LANG
	WHERE PROGRAMID IN (SELECT PROGRAMID FROM TYJINFWLIB.CMN_PROGRAM WHERE MENUID = P_MENUID);

	-- ���α׷� ����
	DELETE FROM TYJINFWLIB.CMN_PROGRAM
	WHERE MENUID = P_MENUID;

	-- �ش�޴��� ���� �޴� ����
	DELETE FROM TYJINFWLIB.CMN_LANG
	WHERE CODE IN (SELECT MENUID FROM TYJINFWLIB.CMN_MENU WHERE PRTMENU = P_MENUID);

	DELETE FROM TYJINFWLIB.CMN_MENU
	WHERE PRTMENU = P_MENUID;

	-- �޴� ����
	DELETE FROM TYJINFWLIB.CMN_LANG
	WHERE CODE = P_MENUID;

	DELETE FROM TYJINFWLIB.CMN_MENU
	WHERE MENUID = P_MENUID;

END P1

