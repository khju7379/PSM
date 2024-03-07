--DROP PROCEDURE TYJINFWLIB.CMN_LANG_ADD;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_LANG_ADD
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : ����ڵ带 �Է��Ѵ�.
-- ����       : CALL CMN_LANG_ADD ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� UP_LANG_CODE_INSERT
--		������ ��ȯ : PTCMMBAS30I1 -> CMN_LANG_ADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG_ADD 
(
	P_PROGRAMID			VARCHAR(50),
	P_CODE				VARCHAR(50),
	P_KO				VARGRAPHIC(2000) CCSID 1200,
	P_EN				VARGRAPHIC(2000) CCSID 1200,
	P_ZH				VARGRAPHIC(2000) CCSID 1200,
	P_RU				VARGRAPHIC(2000) CCSID 1200
)
	--RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
		
	IF NOT EXISTS(SELECT * FROM TYJINFWLIB.CMN_LANG WHERE PROGRAMID = P_PROGRAMID AND CODE = P_CODE )
	THEN
		INSERT INTO TYJINFWLIB.CMN_LANG
		(
			PROGRAMID,
			CODE,
			KO,
			EN,
			ZH,
			RU
		)
		VALUES
		(
			P_PROGRAMID,
			P_CODE,
			P_KO,
			P_EN,
			P_ZH,
			P_RU
		);
	ELSE
		UPDATE TYJINFWLIB.CMN_LANG SET
			KO		= P_KO,
			EN		= CASE WHEN COALESCE(P_EN, '') = '' THEN EN ELSE P_EN END,
			ZH		= CASE WHEN COALESCE(P_ZH, '') = '' THEN ZH ELSE P_ZH END,
			RU		= CASE WHEN COALESCE(P_RU, '') = '' THEN RU ELSE P_RU END
		WHERE PROGRAMID = P_PROGRAMID AND CODE = P_CODE;
	END IF;
	
END P1