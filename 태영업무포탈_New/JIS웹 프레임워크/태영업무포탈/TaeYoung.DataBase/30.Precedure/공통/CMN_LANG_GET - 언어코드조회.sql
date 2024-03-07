--DROP PROCEDURE TYJINFWLIB.CMN_LANG_GET;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_LANG_GET
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : ����ڵ带 ��ȸ�Ѵ�.
-- ����       : CALL CMN_LANG_GET ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� UP_LANG_CODE_SELECT
--		������ ��ȯ : PTCMMBAS30S1 -> CMN_LANG_GET
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG_GET
(
	P_PROGRAMID			VARCHAR(50),
	P_LANGCODE			VARCHAR(2)
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		SELECT	CODE, CASE P_LANGCODE WHEN 'KO' THEN KO
									 WHEN 'EN' THEN EN
									 WHEN 'ZH' THEN ZH
									 WHEN 'RU' THEN RU
									 ELSE KO END AS LANG_TEXT
		FROM	TYJINFWLIB.CMN_LANG
		WHERE	PROGRAMID = P_PROGRAMID;
	OPEN REFCURSOR;
END P1