-------------------------------------------------------------------------------------------
--
-- 프로시저명 : ORG_GROUPUSR_GET_ALL 
-- 작성자     : 서정민
-- 작성일     : 2015-09-03
-- 설명       : 그룹 멤버전체 조회
-- 예문       : CALL ORG_GROUPUSR_GET_ALL  ('')
--		DB2 변환 : 이전프로시져명 UP_GROUPMEMBER_LIST_BYALLUSER
--		프렌지 변환 : PTORGUSR40S2 -> ORG_GROUPUSR_GET_ALL   
-------------------------------------------------------------------------------------------
CREATE PROCEDURE ORG_GROUPUSR_GET_ALL 
(
		P_NAME		VARCHAR(10)   -- 사용자명
)
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN	-- 시작
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	SELECT
			A.LOGINID
		 ,	A.EMPID
		 ,	A.DISPLAYNAME
		 ,	B.COMPANY 
		 ,	A.COMPANYCODE
	FROM ORG_USER A 

	LEFT JOIN ORG_COMPANYLANG B ON (A.COMPANYCODE = B.COMPANYCODE AND B.LANGUAGECODE = 'KO')
	
	WHERE A.DISPLAYNAME LIKE '%' || P_NAME || '%'
	ORDER BY A.DISPLAYNAME ASC;

	OPEN REFCURSOR;
END P1
	
