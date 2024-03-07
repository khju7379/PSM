-------------------------------------------------------------------------------------------
--
-- 프로시저명 : ORM_DEPT_LIST_SEARCH
-- 작성자     : 장경환
-- 작성일     : 2010-07-13
-- 설명       : 부서를 검색하여 조회한다..
-- 예문       : CALL TYJINFWLIB.ORM_DEPT_LIST_SEARCH '2100', '',  'CN'
-- DB2 변환   : 이전프로시져명 up_OrgChart_Select_SearchDept
--
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.ORM_DEPT_LIST_SEARCH
CREATE PROCEDURE TYJINFWLIB.ORM_DEPT_LIST_SEARCH
(
		P_COMPANYCODE	VARCHAR(50)
	,	P_KEYWORD		VARCHAR(20)
	,	P_LANGCODE		VARCHAR(10)
)
	LANGUAGE SQL
	RESULT SETS 1
	
P1 : BEGIN
	IF P_COMPANYCODE IS NULL THEN
		SET P_COMPANYCODE = 'enf';
	END IF;
	
	IF NOT EXISTS(SELECT DEPTCODE FROM TYJINFWLIB.ORG_DEPTLANG WHERE LANGCODE = P_LANGCODE AND COMPANYCODE = P_COMPANYCODE) THEN
		SET P_LANGCODE = 'en';
	END IF;
	
	MAIN : BEGIN
		-- 자회사
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
		SELECT
				COALESCE(D.DISPLAYNAME,'')				AS DISPLAYNAME,
				COALESCE(D.DEPTEMAIL,'')				AS EMAIL,
				COALESCE(D.DEPTCODE,'')					AS DEPTCODE,
				COALESCE(DL.DEPTNAME, D.DISPLAYNAME)	AS DEPTNAME,
				COALESCE(CL.COMPANYCODE,'')				AS COMPANYCODE,
				COALESCE(CL.COMPANY,'')					AS COMPANYNAME
		FROM 
				TYJINFWLIB.ORG_DEPT AS D
				LEFT OUTER JOIN  TYJINFWLIB.ORG_DEPTLANG AS DL
					ON	D.COMPANYCODE 	= DL.COMPANYCODE 
					AND	D.DEPTCODE 		= DL.DEPTCODE
					AND	DL.LANGCODE 	= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_COMPANYLANG AS CL
					ON 	D.COMPANYCODE 	= CL.COMPANYCODE
					AND CL.LANGUAGECODE = P_LANGCODE
		WHERE 
				COALESCE(DL.DEPTNAME, D.DISPLAYNAME) LIKE '%' || P_KEYWORD || '%'
		AND		D.DISPLAYYN 	= 'Y'
		AND		D.COMPANYCODE 	= P_COMPANYCODE
		ORDER BY D.DEPTORDER;
		OPEN REFCURSOR;
	END MAIN;
END P1;