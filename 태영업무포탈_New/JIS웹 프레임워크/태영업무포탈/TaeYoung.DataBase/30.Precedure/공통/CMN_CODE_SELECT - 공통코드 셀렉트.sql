-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_CODE_SELECT
-- 작성자     : 장윤호
-- 작성일     : 2017-04-03
-- 설명       : 공통코드 셀렉트
-- 예문       : CALL CMN_CODE_SELECT ('TEMPLETE01','10')
-- DB2 변환   :
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_SELECT
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_SELECT 
(
		P_COMPANYCODE		CHAR(10)
	,	P_LANGCODE			CHAR(2)
	,	P_DCODE				CHAR(12)
	,	P_PCODE				CHAR(12)
	,	P_CODE				CHAR(12)
)

    RESULT SETS 1
    LANGUAGE SQL

M1: BEGIN
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
    SELECT
			COMPANYCODE
		,	CODE
		,	DCODE
		,	PCODE
		,	SODR
		,	CODTXT_KR
		,	CODTXT_EN
		,	CODTXT_ZH
		,	CODTXT_RU
		,	ERPCODE
		,	CODEXT1
		,	CODEXT2
		,	CODEXT3
		,	CODEXTN1
		,	CODEXTN2
		,	CODEXTN3
		,	USEYN
		,	REGID
		,	REGDT
		,	UPDID
		,	UPDDT
		,	CASE UCASE(P_LANGCODE)	WHEN 'KO' THEN CODTXT_KR
									WHEN 'EN' THEN CODTXT_EN
									WHEN 'ZH' THEN CODTXT_ZH
									WHEN 'RU' THEN CODTXT_RU
									ELSE CODTXT_KR END AS CODTXT
	FROM
			CMN_CODE
    WHERE
			COMPANYCODE				= P_COMPANYCODE 
	AND		DCODE					= P_DCODE
	AND		PCODE					= P_PCODE
	AND		CODE					= P_CODE
	AND		COALESCE(USEYN,'N')		= 'Y'
    ORDER BY COMPANYCODE ASC, SODR;

    OPEN REFCURSOR;

END M1