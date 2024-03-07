--DROP PROCEDURE TYJINFWLIB.CMN_LANG_ADD;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_LANG_ADD
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 언어코드를 입력한다.
-- 예문       : CALL CMN_LANG_ADD ('2006909','1000','TS1301')
--		DB2 변환 : 이전프로시져명 UP_LANG_CODE_INSERT
--		프렌지 변환 : PTCMMBAS30I1 -> CMN_LANG_ADD
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