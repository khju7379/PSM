-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_ACL_DEL
-- 작성자     : 서정민
-- 작성일     : 2015-09-03
-- 설명       : 전체 권한 삭제
-- 예문       : EXEC CMN_ACL_DEL 'GRP'
--		DB2 변환 : 이전프로시져명 UP_ACL_DELETE
--		프렌지 변환 : PTCMMBAS10D1 -> CMN_ACL_DEL
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_ACL_DEL
(
	P_ACL_GRP VARCHAR(50)
)
	LANGUAGE SQL

P1: BEGIN

	DELETE FROM TYJINFWLIB.CMN_ACL
	WHERE ACL_TYPE='MENU' AND ACL_GRP = P_ACL_GRP;

END P1

