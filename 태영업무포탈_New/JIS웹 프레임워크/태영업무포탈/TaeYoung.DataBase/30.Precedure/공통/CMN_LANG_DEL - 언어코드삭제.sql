--DROP PROCEDURE TYJINFWLIB.CMN_LANG_DEL;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_LANG_DEL
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : ����ڵ带 �����Ѵ�.
-- ����       : CALL CMN_LANG_DEL ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� UP_LANG_CODE_DELETE 
--		������ ��ȯ : PTCMMBAS30D1 -> CMN_LANG_DEL
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG_DEL 
(
	P_ProgramId			VARCHAR(50)
)
	--RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DELETE FROM	TYJINFWLIB.CMN_LANG
	WHERE	PROGRAMID = P_ProgramId;
			--AND ISNULL(EN, '') = ''
			--AND ISNULL(ZH, '') = ''
			--AND ISNULL(RU, '') = ''
	
END P1