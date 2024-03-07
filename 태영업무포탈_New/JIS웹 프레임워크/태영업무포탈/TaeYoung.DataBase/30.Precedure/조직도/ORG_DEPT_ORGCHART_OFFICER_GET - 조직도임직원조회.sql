-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_DEPT_ORGCHART_OFFICER_GET
-- 작성자     : 박제영
-- 작성일     : 2015-10-06
-- 설명       : 조직도 임직원을 조회한다.
-- 예문       : CALL ORG_DEPT_ORGCHART_OFFICER_GET ()
--		프렌지 변환 : PTORGUSR20L11 -> ORG_DEPT_ORGCHART_OFFICER_GET
-------------------------------------------------------------------------------------------
----DROP PROCEDURE TYJINFWLIB.ORG_DEPT_ORGCHART_OFFICER_GET;
CREATE PROCEDURE TYJINFWLIB.ORG_DEPT_ORGCHART_OFFICER_GET 
(
		P_EMPID			VARCHAR(20)
	,	P_COMPANYCODE	VARCHAR(10)
	,	P_LANGCODE		VARCHAR(10)
)
RESULT SETS 1
LANGUAGE SQL
SPECIFIC TYJINFWLIB.ORG_DEPT_ORGCHART_OFFICER_GET

P1 : BEGIN
	S1 : BEGIN -- 값 설정
		SET P_COMPANYCODE = COALESCE ( P_COMPANYCODE , '' ) ;
		SET P_LANGCODE = LOWER ( COALESCE ( P_LANGCODE , 'ko' ) ) ;
	END S1 ;

	S2 : BEGIN -- 실행부
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			SELECT * FROM (
				SELECT
						U.EMPID
					,	U.LOGINID
					,	U.EMAIL
					,	U.MAINDEPTCODE
					,	DP.DEPTNAME AS MAINDEPTNAME
					,	U.CREATEDDT
					,	U.DISPLAYNAME
					,	UL . USERLNAME || ( CASE WHEN P_LANGCODE NOT IN ( 'ko' , 'en' , 'cn' , 'ru' ) THEN ' ' ELSE '' END ) || UL . USERFNAME AS USERNAME
					,	DU . DUTYNAME				AS DUTYNAME
					,	RA . RANKNAME				AS RANKNAME
					,	U . CELLPHONE				AS CELLPHONE
					,	U . FAXNUMBER				AS FAXNUMBER
					,	U . EXTENSIONNUMBER			AS EXTENSIONNUMBER
					,	U . LOCATIONCODE			AS LOCATIONCODE
					, COM . COMPANY					AS COMPANYNAME
					,	U . DATEOFBIRTH				AS DATEOFBIRTH
					,	COALESCE ( DU . TEAMCHIEFYN , 'N' ) AS TEAMCHIEFYN
					,	U . PHONE1					AS PHONE1
					,	U . PHONE2					AS PHONE2
					,	U.JOBDESC
					,	U.COMPANYCODE
				FROM TYJINFWLIB.ORG_USER AS U
				LEFT OUTER JOIN TYJINFWLIB.ORG_USERLANG AS UL
					ON	U.EMPID				= UL.EMPID
					AND	UL.LANGCODE			= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_DEPTLANG AS DP
					ON	U.MAINDEPTCODE		= DP.DEPTCODE
					AND DP.COMPANYCODE		= P_COMPANYCODE
					AND DP.LANGCODE			= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_DUTY AS DU
					ON  U.DUTYCODE			= DU.DUTYCODE
					AND DU.LANGCODE			= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_RANK AS RA
					ON  U.RANKCODE			= RA.RANKCODE
					AND RA.LANGCODE			= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_COMPANYLANG AS COM
					ON	U.COMPANYCODE		= COM.COMPANYCODE
					AND COM.LANGUAGECODE	= P_LANGCODE 
				WHERE
						(
							LOWER(U.EMPID)		= LOWER(P_EMPID)
						OR	LOWER(U.LOGINID)	= LOWER(P_EMPID)
						)
				AND		U . COMPANYCODE			= CASE
													WHEN P_COMPANYCODE = ''
													THEN U . COMPANYCODE
													ELSE P_COMPANYCODE END
				AND		U.DISPLAYYN = 'Y'


				UNION ALL

				SELECT
						U.EMPID
					,	U.LOGINID
					,	U.EMAIL
					,	A.DEPTCODE AS MAINDEPTCODE
					,	DP.DEPTNAME AS MAINDEPTNAME
					,	U.CREATEDDT
					,	U.DISPLAYNAME
					,	UL . USERLNAME || ( CASE WHEN P_LANGCODE NOT IN ( 'ko' , 'en' , 'cn' , 'ru' ) THEN ' ' ELSE '' END ) || UL . USERFNAME AS USERNAME
					,	DU . DUTYNAME				AS DUTYNAME
					,	RA . RANKNAME				AS RANKNAME
					,	U . CELLPHONE				AS CELLPHONE
					,	U . FAXNUMBER				AS FAXNUMBER
					,	U . EXTENSIONNUMBER			AS EXTENSIONNUMBER
					,	U . LOCATIONCODE			AS LOCATIONCODE
					, COM . COMPANY					AS COMPANYNAME
					,	U . DATEOFBIRTH				AS DATEOFBIRTH
					,	COALESCE ( DU . TEAMCHIEFYN , 'N' ) AS TEAMCHIEFYN
					,	U . PHONE1					AS PHONE1
					,	U . PHONE2					AS PHONE2
					,	U.JOBDESC
					,	U.COMPANYCODE
				FROM TYJINFWLIB.ORG_ADDITIONALJOB AS A
				LEFT JOIN TYJINFWLIB.ORG_USER AS U
					ON A.EMPID 	= U.EMPID
				LEFT OUTER JOIN TYJINFWLIB.ORG_USERLANG AS UL
					ON	U.EMPID				= UL.EMPID
					AND	UL.LANGCODE			= P_LANGCODE
					AND	U.COMPANYCODE 	= UL.COMPANYCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_DEPTLANG AS DP
					ON	A.DEPTCODE		= DP.DEPTCODE
					AND DP.COMPANYCODE		= P_COMPANYCODE
					AND DP.LANGCODE			= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_DUTY AS DU
					ON  A.DUTYCODE			= DU.DUTYCODE
					AND DU.LANGCODE			= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_RANK AS RA
					ON  A.RANKCODE			= RA.RANKCODE
					AND RA.LANGCODE			= P_LANGCODE
				LEFT OUTER JOIN TYJINFWLIB.ORG_COMPANYLANG AS COM
					ON	A.COMPANYCODE		= COM.COMPANYCODE
					AND COM.LANGUAGECODE	= P_LANGCODE
				WHERE
						(
							LOWER(A.EMPID)		= LOWER(P_EMPID)
						OR	LOWER(A.LOGINID)	= LOWER(P_EMPID)
						)
				AND		A . COMPANYCODE			= CASE
													WHEN P_COMPANYCODE = ''
													THEN A . COMPANYCODE
													ELSE P_COMPANYCODE END
				AND		U.DISPLAYYN = 'Y'
			) DD 
			FETCH FIRST 1 ROW ONLY ;
		OPEN REFCURSOR ;
	END S2 ;
END P1