--DROP PROCEDURE TYJINFWLIB.PTCMMMSG31L2;
-------------------------------------------------------------------------------------------
-- 프로시저명 : MSG_CONVUSR_LIST 
-- 작성자     : 문광복
-- 작성일     : 2015-09-14
-- 설명       : 메시지 대화목록을 조회하여 없을시 생성하고 있으면 대화목록리스트를 가져온다.
-- 예문       : CALL MSG_CONVUSR_LIST  ('2006909','1000','TS1301')
--		프렌지 변환 : PTCMMMSG31L2 -> MSG_CONVUSR_LIST 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.MSG_CONVUSR_LIST  
(
	P_CONVERSATIONID		INTEGER
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN

	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT * FROM TYJINFWLIB.MSG_CONVUSR WHERE CONVERSATIONID=P_CONVERSATIONID;

	OPEN REFCURSOR;

END P1