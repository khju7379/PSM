-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_ACL_GRP_DEL 
-- 작성자     : 서정민
-- 작성일     : 2015-09-03
-- 설명       : 권한 삭제
-- 예문       : EXEC CMN_ACL_GRP_DEL  'GRP'
--		DB2 변환 : 이전프로시져명 UP_ACL_GRP_DELETE
--		프렌지 변환 : PTCMMBAS10D2 -> CMN_ACL_GRP_DEL 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_ACL_GRP_DEL
CREATE PROCEDURE TYJINFWLIB.CMN_ACL_GRP_DEL
(
	P_ACL_ID		VARCHAR(50)
)
	LANGUAGE SQL

P1: BEGIN

	DELETE FROM TYJINFWLIB.CMN_ACL 
	WHERE
			ACL_TYPE	= 'MENU'
	AND		ACL_ID		= P_ACL_ID
	;
END P1

