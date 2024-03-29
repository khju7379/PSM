-------------------------------------------------------------------------------------------
--
-- 프로시저명 : ORG_GROUP_GET
-- 작성자     : 문광복
-- 작성일     : 2016-11-11
-- 설명       : 그룹을 조회한다.
-- 예문       : CALL ORG_GROUP_GET ('9999')
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.ORG_GROUP_GET
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP_GET
(
		P_GRPID			VARCHAR(10)	
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN	-- 시작
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
	SELECT
			G.GRPID
		,	G.GRPTYPE
		,	G.GRPEXT
		,	G.USEYN
		,	GL.GRPNAME AS GRPNAME_KO
		,	GL2.GRPNAME AS GRPNAME_EN
		,	GL3.GRPNAME AS GRPNAME_CN
		,	GL4.GRPNAME AS GRPNAME_ES
		,	GL5.GRPNAME AS GRPNAME_ET1
	FROM
			TYJINFWLIB.ORG_GROUP		AS G
			LEFT JOIN	TYJINFWLIB.ORG_GROUPLANG	AS GL
				ON	G.GRPID					= GL.GRPID
				AND	LOWER(GL.LANGCODE)		= 'ko'
			LEFT JOIN	TYJINFWLIB.ORG_GROUPLANG	AS GL2
				ON	G.GRPID					= GL2.GRPID
				AND	LOWER(GL2.LANGCODE)		= 'en'
			LEFT JOIN	TYJINFWLIB.ORG_GROUPLANG	AS GL3
				ON	G.GRPID					= GL3.GRPID
				AND	LOWER(GL3.LANGCODE)		= 'cn'
			LEFT JOIN	TYJINFWLIB.ORG_GROUPLANG	AS GL4
				ON	G.GRPID					= GL4.GRPID
				AND	LOWER(GL4.LANGCODE)		= 'es'
			LEFT JOIN	TYJINFWLIB.ORG_GROUPLANG	AS GL5
				ON	G.GRPID					= GL5.GRPID
				AND	LOWER(GL5.LANGCODE)		= 'et1'
	WHERE
			G.GRPID				= P_GRPID
	;
	OPEN REFCURSOR;
END P1
	
