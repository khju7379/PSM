-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_ACL_ADD
-- 작성자     : 서정민
-- 작성일     : 2015-09-04
-- 설명       : 권한 입력
-- 예문       : EXEC CMN_ACL_ADD 'ID', 'GROUP'
--		DB2 변환 : 이전프로시져명 UP_ACL_INSERT
--		프렌지 변환 : PTCMMBAS10I1 -> CMN_ACL_ADD
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_ACL_ADD
CREATE PROCEDURE TYJINFWLIB.CMN_ACL_ADD
(
		P_ACL_ID		VARCHAR(50)
	,	P_ACL_GRP		VARCHAR(50)
)
	LANGUAGE SQL

P1: BEGIN
	INSERT INTO TYJINFWLIB.CMN_ACL
		(
				ACL_TYPE
			,	ACL_ID
			,	ACL_GRP
		)
		VALUES 
		(
				'MENU'
			,	P_ACL_ID
			,	P_ACL_GRP
		);
END P1

