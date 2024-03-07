-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_PROGRAM_DEL
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-01
-- ����       : ���α׷� ����
-- ����       : EXEC CMN_PROGRAM_DEL '',''
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_PROGRAM_DELETE
--		������ ��ȯ : PTCMMBAS50D1 -> CMN_PROGRAM_DEL
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_PROGRAM_DEL
(
	P_PROGRAMID			VARCHAR(200),				-- ���α׷� ���̵�
	P_MENUID			VARCHAR(200)				-- �޴����̵�
)
	LANGUAGE SQL
P1: BEGIN

	DELETE FROM TYJINFWLIB.CMN_LANG 
		WHERE PROGRAMID = P_PROGRAMID;

	DELETE FROM TYJINFWLIB.CMN_PROGRAM
		WHERE MENUID = P_MENUID AND PROGRAMID = P_PROGRAMID;

END P1

