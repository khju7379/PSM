--DROP PROCEDURE TYJINFWLIB.ORG_GROUPUSER_SV_LST;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUPUSER_SV_LST
-- 작성자     : 이영헌
-- 작성일     : 2017-09-21
-- 설명       : 그룹유저 사용자정보
-- 예문       : CALL TYJINFWLIB.ORG_GROUPUSER_SV_LST 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUPUSER_SV_LST
(
		IN P_CURRENTPAGEINDEX		INTEGER
	,	IN P_PAGESIZE				INTEGER
	,	IN P_COMPANYCODE			CHAR(10)
	,	IN P_GRPID					CHAR(10)
	,	IN P_LANGCODE				CHAR(2)
	,	IN P_SEARCHCONDITION		VARCHAR(100)
)
RESULT SETS 2
LANGUAGE SQL

P1: BEGIN

	DECLARE P_STNUM INTEGER;
	DECLARE P_FNNUM INTEGER;

	DECLARE GLOBAL TEMPORARY TABLE SESSION.T(
			COMPANYCODE			CHAR(10)
		,	COMPANY				VARGRAPHIC(2000) CCSID 1200
		,	EMPID				CHAR(10)
		,	USERNAME			VARGRAPHIC(2000) CCSID 1200
		,	DEPTNAME			VARGRAPHIC(2000) CCSID 1200
		,	RANKCODE			CHAR(3)
		,	RANKNAME			VARGRAPHIC(2000) CCSID 1200
		,	MAINDEPTCODE		CHAR(10)
		,	CELLPHONE			VARCHAR(100)
		,	SITECOMPANY			CHAR(10)
	) WITH REPLACE ;

	S1 : BEGIN -- 값 설정
		SET P_CURRENTPAGEINDEX = COALESCE ( P_CURRENTPAGEINDEX , 1 ) ;
		SET P_PAGESIZE = COALESCE ( P_PAGESIZE , 10 ) ;
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
		SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
		SET P_LANGCODE = LOWER(P_LANGCODE);
	END S1 ;

	INSERT INTO SESSION.T
	SELECT
			A.COMPANYCODE
		,	B.COMPANY
		,	A.EMPID
		,	C.USERLNAME || C.USERFNAME AS USERNAME
		,	D.DEPTNAME
		,	A.RANKCODE
		,	E.RANKNAME
		,	A.MAINDEPTCODE
		,	COALESCE(A.CELLPHONE,A.EXTENSIONNUMBER) AS CELLPHONE
		,	A.SITECOMPANY
	FROM TYJINFWLIB.ORG_USER AS A
	JOIN TYJINFWLIB.ORG_COMPANYLANG AS B ON A.COMPANYCODE  = B.COMPANYCODE AND B.LANGUAGECODE = P_LANGCODE
	JOIN TYJINFWLIB.ORG_USERLANG AS C ON A.COMPANYCODE = C.COMPANYCODE AND A.EMPID = C.EMPID AND C.LANGCODE = P_LANGCODE
	JOIN TYJINFWLIB.ORG_DEPTLANG AS D ON A.COMPANYCODE = D.COMPANYCODE AND A.MAINDEPTCODE = D.DEPTCODE AND D.LANGCODE = P_LANGCODE
	LEFT OUTER JOIN TYJINFWLIB.ORG_RANK AS E ON A.COMPANYCODE = E.COMPANYCODE AND A.RANKCODE = E.RANKCODE AND E.LANGCODE = P_LANGCODE
	INNER JOIN TYJINFWLIB.ORG_GROUPUSR AS GUSR
	ON GUSR.GRPID = P_GRPID AND A.COMPANYCODE = GUSR.COMPANYCODE AND A.EMPID = TRIM(GUSR.USRID) AND GUSR.USRTYPE = '1'
	WHERE A.COMPANYCODE = P_COMPANYCODE AND
	(C.USERLNAME || C.USERFNAME LIKE P_SEARCHCONDITION || '%' OR A.EMPID LIKE P_SEARCHCONDITION || '%') AND A.EMPID IS NOT NULL;

	M1 : BEGIN
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			SELECT
					COMPANYCODE
				,	COMPANY
				,	EMPID
				,	USERNAME
				,	MAINDEPTCODE
				,	DEPTNAME
				,	RANKCODE
				,	RANKNAME
				,	CELLPHONE
				,	SITECOMPANY
			 FROM(
				 SELECT ROW_NUMBER() OVER() AS ROWNO
					 , COMPANYCODE
					 , COMPANY
					 , EMPID
					 , USERNAME
					 , DEPTNAME
					 , RANKCODE
					 , RANKNAME
					 , MAINDEPTCODE
					 , CELLPHONE
					 , SITECOMPANY
				FROM SESSION.T
			) AS A
			WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM;
		OPEN REFCURSOR;
	END M1;

	M2 : BEGIN
		DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
			SELECT COUNT(*) AS TOTALCOUNT FROM SESSION.T;
		OPEN REFCURSOR2 ;
	END M2;

END P1