-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_LANG2_DEL
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-11
-- ����       : �ٱ��� �ڵ� ����
-- ����       : EXEC CMN_LANG2_DEL ''
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_LANG_DELETE
--		������ ��ȯ : PTCMMBAS30D2 -> CMN_LANG2_DEL
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

