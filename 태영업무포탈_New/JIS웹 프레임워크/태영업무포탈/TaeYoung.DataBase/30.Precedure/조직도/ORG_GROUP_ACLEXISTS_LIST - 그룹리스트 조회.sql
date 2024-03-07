-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUP_ACLEXISTS_LIST
-- 작성자     : 문광복
-- 작성일     : 2016-11-11
-- 설명       : 그룹을 조회한다.
-- 예문       : CALL ORG_GROUP_ACLEXISTS_LIST 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.ORG_GROUP_ACLEXISTS_LIST
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP_ACLEXISTS_LIST
(
		P_LANGCODE				VARCHAR(10)				-- 언어코드
	,   P_SEARCHCONDITION		VARCHAR(4000)           -- 조회조건 내용  	
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN	-- 시작
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	SELECT
			A.GRPID
		,	A.SHRRNG
		,	B.LANGCODE
		,	B.GRPNAME
		,	CASE
				WHEN C.ACL_GRP IS NULL
				THEN '0'
				ELSE '1'
			END AS CHK
	FROM
			TYJINFWLIB.ORG_GROUP AS A
			 LEFT OUTER JOIN TYJINFWLIB.ORG_GROUPLANG AS B
				ON	A.GRPID					= B.GRPID
				AND LOWER(B.LANGCODE)		= P_LANGCODE
				AND A.USEYN					= 1
			 LEFT OUTER JOIN TYJINFWLIB.CMN_ACL AS C
				ON	A.GRPID					= C.ACL_GRP
				AND C.ACL_TYPE				= 'MENU'
				AND C.ACL_ID				= P_SEARCHCONDITION
	;
	OPEN REFCURSOR ;

END P1
	
