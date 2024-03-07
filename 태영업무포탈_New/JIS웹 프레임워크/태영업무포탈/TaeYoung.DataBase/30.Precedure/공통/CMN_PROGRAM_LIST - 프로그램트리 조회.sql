--DROP PROCEDURE TYJINFWLIB.CMN_PROGRAM_LIST;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_PROGRAM_LIST
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-01
-- ����       : ���α׷� ���� Ʈ�� ���
-- ����       : EXEC CMN_PROGRAM_LIST '�׽�Ʈ1-1'
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_TREE_SELECT_PROGRAM
--		������ ��ȯ : PTCMMBAS50L1 -> CMN_PROGRAM_LIST
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