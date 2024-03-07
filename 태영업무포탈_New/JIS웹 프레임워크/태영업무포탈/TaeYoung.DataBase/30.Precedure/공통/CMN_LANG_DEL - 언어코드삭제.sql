--DROP PROCEDURE TYJINFWLIB.CMN_LANG_DEL;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_LANG_DEL
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 언어코드를 삭제한다.
-- 예문       : CALL CMN_LANG_DEL ('2006909','1000','TS1301')
--		DB2 변환 : 이전프로시져명 UP_LANG_CODE_DELETE 
--		프렌지 변환 : PTCMMBAS30D1 -> CMN_LANG_DEL
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