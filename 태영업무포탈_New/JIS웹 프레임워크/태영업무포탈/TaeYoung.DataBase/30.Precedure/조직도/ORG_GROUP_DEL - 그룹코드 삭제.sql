--DROP PROCEDURE TYJINFWLIB.PTORGUSR40D1;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUP_DEL 
-- 작성자     : 문광복
-- 작성일     : 2015-09-21
-- 설명       : 그룹코드 입력
-- 예문       : CALL ORG_GROUP_DEL  ()
--		프렌지 변환 : PTORGUSR40D1 -> ORG_GROUP_DEL 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP_DEL 
	LANGUAGE SQL
P1: BEGIN
	
	DELETE
	FROM ORG_GROUP;

END P1