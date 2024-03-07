--DROP PROCEDURE TYJINFWLIB.ORG_GROUPUSR_DEL;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUPUSR_DEL 
-- 작성자     : 문광복
-- 작성일     : 2015-09-21
-- 설명       : 그룹맴버 입력
-- 예문       : CALL ORG_GROUPUSR_ADD  ()
--		프렌지 변환 : PTORGUSR42I1 -> ORG_GROUPUSR_DEL  
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUPUSR_DEL
(
	  P_GRPID       VARCHAR (10) 
)
	LANGUAGE SQL
P1: BEGIN
	
	DELETE FROM TYJINFWLIB.ORG_GROUPUSR
	WHERE GRPID = P_GRPID;

END P1