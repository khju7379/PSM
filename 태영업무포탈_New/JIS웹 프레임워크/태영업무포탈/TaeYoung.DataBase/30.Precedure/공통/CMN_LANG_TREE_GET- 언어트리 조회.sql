--DROP PROCEDURE TYJINFWLIB.CMN_LANGTREE_GET;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_LANGTREE_GET
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-01
-- ����       : �ٱ��� Ʈ�� ���
-- ����       : EXEC CMN_LANG_TREE_GET '��'
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_TREE_SELECT_LANG
--		������ ��ȯ : PTCMMBAS30L2 -> CMN_LANG_TREE_GET 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG_TREE_GET
(
	P_PROGRAMID			VARCHAR(50)			-- ���α׷� ���̵�
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

