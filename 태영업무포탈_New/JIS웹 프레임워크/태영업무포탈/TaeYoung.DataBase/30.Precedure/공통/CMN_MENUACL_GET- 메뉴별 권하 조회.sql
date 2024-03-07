--DROP PROCEDURE TYJINFWLIB.CMN_MENUACL_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_MENUACL_GET
-- 작성자     : 문광복
-- 작성일     : 2015-09-03
-- 설명       : 메뉴트리(좌측메뉴) 조회
-- 예문       : EXEC CMN_MENUACL_GET 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENUACL_GET
(
	P_ACL_GRP				VARCHAR(50)
)
	
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT * FROM TYJINFWLIB.CMN_ACL A 
			LEFT JOIN TYJINFWLIB.CMN_LANG B ON A.ACL_ID=B.CODE AND B.PROGRAMID='MENU'
		WHERE A.ACL_GRP = P_ACL_GRP;

	OPEN REFCURSOR;

END P1

