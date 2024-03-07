--DROP PROCEDURE TYJINFWLIB.ORG_GROUP2_DEL;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUP2_DEL 
-- 작성자     : 문광복
-- 작성일     : 2015-09-21
-- 설명       : 그룹코드 입력
-- 예문       : CALL ORG_GROUP2_DEL  ()
--		프렌지 변환 : PTORGUSR40D1 -> ORG_GROUP2_DEL 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP2_DEL 
(
	P_GRPID VARCHAR(50)
)
	LANGUAGE SQL
P1: BEGIN
	
	DELETE
	FROM TYJINFWLIB.ORG_GROUP
	WHERE GRPID = P_GRPID;

END P1