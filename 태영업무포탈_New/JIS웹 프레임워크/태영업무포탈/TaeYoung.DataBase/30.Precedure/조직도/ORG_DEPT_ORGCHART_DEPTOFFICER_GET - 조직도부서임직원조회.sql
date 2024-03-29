----DROP PROCEDURE TYJINFWLIB.ORG_DEPT_ORGCHART_DEPTOFFICER_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_DEPT_ORGCHART_DEPTOFFICER_GET 
-- 작성자     : 박제영
-- 작성일     : 2015-09-21
-- 설명       : 조직도 부서에 속한 임직원을 조회한다.
-- 예문       : CALL ORG_DEPT_ORGCHART_DEPTOFFICER_GET  ()
--		프렌지 변환 : PTORGUSR20L9 -> ORG_DEPT_ORGCHART_DEPTOFFICER_GET   
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_DEPT_ORGCHART_DEPTOFFICER_GET
( 
	IN P_DEPTCODE CHAR(12),
    IN P_COMPANYCODE CHAR(10),
    IN P_LANGCODE VARCHAR(10),
    IN P_SEARCHSTRING VARCHAR(100) 
)
	RESULT SETS 2
	LANGUAGE SQL
	SPECIFIC TYJINFWLIB.ORG_DEPT_ORGCHART_DEPTOFFICER_GET_TMP

P1 : BEGIN
	DECLARE GLOBAL TEMPORARY TABLE SESSION . T1 (
				EMPID			CHAR ( 20 )
			,	REMPID			CHAR ( 12 )
			,	EXTENSIONNUMBER	VARCHAR ( 50 )
			,	CELLPHONE		VARCHAR ( 50 )
			,	PHONE1			VARCHAR ( 50 )
			,	PHONE2			VARCHAR ( 50 )
			,	LOCATIONCODE	VARCHAR ( 50 )
			,	TEAMCHIEFYN		VARCHAR ( 2 )
			,	USERNAME		VARGRAPHIC ( 200 ) ALLOCATE(100) CCSID 1200
			,	DISPLAYNAME		VARGRAPHIC ( 200 ) ALLOCATE(100) CCSID 1200
			,	EMAIL			VARCHAR ( 80 )
			,	DEPTCODE		VARCHAR ( 50 )
			,	DEPTNAME		VARGRAPHIC ( 200 ) ALLOCATE(100) CCSID 1200
			,	JOBDESC			VARGRAPHIC ( 200 ) ALLOCATE(100) CCSID 1200
			,	COMPANYCODE		VARCHAR ( 10 )
			,	COMPANYNAME		VARCHAR ( 50 )
			,	RANKCODE		VARCHAR ( 50 )
			,	RANKNAME		VARGRAPHIC (40) CCSID 1200
			,	DUTYCODE		VARCHAR ( 50 )
			,	DUTYNAME		VARGRAPHIC (40) CCSID 1200
			,	FAXNUMBER		VARCHAR ( 50 )
			,	DATEOFBIRTH		VARCHAR ( 10 )
			,	KOSTL			VARCHAR ( 10 )
			,	ICON			VARCHAR ( 10 )
			,	DSORTNO			VARCHAR ( 20 )
			,	RSORTNO			VARCHAR ( 20 )
			,	ORGCOMCODE		CHAR(10)
	) WITH REPLACE ;
				
	S1 : BEGIN -- 값 설정
		SET P_COMPANYCODE = COALESCE ( P_COMPANYCODE , '' ) ;
		SET P_LANGCODE = LOWER ( COALESCE ( P_LANGCODE , 'ko' ) ) ;
		
		IF NOT EXISTS ( SELECT EMPID FROM TYJINFWLIB . ORG_USERLANG WHERE LANGCODE = P_LANGCODE AND COMPANYCODE = P_COMPANYCODE ) THEN
			SET P_LANGCODE = 'ko' ;
		END IF ;
	END S1 ;
	
    --입력 전 세션 데이블 초기화
    DELETE FROM SESSION . T1;

	INSERT INTO SESSION . T1 (
			EMPID			
		,	REMPID			
		,	EXTENSIONNUMBER	
		,	CELLPHONE		
		,	PHONE1			
		,	PHONE2			
		,	LOCATIONCODE	
		,	TEAMCHIEFYN		
		,	USERNAME		
		,	DISPLAYNAME		
		,	EMAIL			
		,	DEPTCODE		
		,	DEPTNAME		
		,	JOBDESC	
		,	COMPANYCODE		
		,	COMPANYNAME		
		,	RANKCODE		
		,	RANKNAME		
		,	DUTYCODE		
		,	DUTYNAME		
		,	FAXNUMBER		
		,	DATEOFBIRTH		
		,	KOSTL			
		,	ICON			
		,	DSORTNO			
		,	RSORTNO	
		,	ORGCOMCODE
	)
	WITH CTE(EMPID,REMPID,EXTENSIONNUMBER,CELLPHONE,PHONE1,PHONE2,LOCATIONCODE,TEAMCHIEFYN,USERNAME,DISPLAYNAME,EMAIL,DEPTCODE,DEPTNAME, JOBDESC,COMPANYCODE,COMPANYNAME,RANKCODE,RANKNAME,DUTYCODE,DUTYNAME,FAXNUMBER,DATEOFBIRTH,KOSTL,ICON,DSORTNO,RSORTNO,ORGCOMCODE) AS(		
		SELECT	LOWER ( M . LOGINID )				AS EMPID
			,	LOWER ( M . EMPID )					AS REMPID
			,	COALESCE ( M . EXTENSIONNUMBER , '' )	AS EXTENSIONNUMBER
			,	COALESCE ( M . CELLPHONE , '' )		AS CELLPHONE
			,	COALESCE ( M . PHONE1 , '' )			AS PHONE1
			,	COALESCE ( M . PHONE2 , '' )			AS PHONE2
			,	COALESCE ( M . LOCATIONCODE , '' )		AS LOCATIONCODE
			,	COALESCE ( D . TEAMCHIEFYN , 'N' )	AS TEAMCHIEFYN
			,	COALESCE ( UL . USERLNAME , '' )	|| COALESCE ( UL . USERFNAME , '' ) AS USERNAME
			,	COALESCE ( M . DISPLAYNAME , '' )		AS DISPLAYNAME
			,	COALESCE ( M . EMAIL , '' )			AS EMAIL
			,	COALESCE ( M . MAINDEPTCODE , '' )		AS DEPTCODE
			,	COALESCE ( DL . DEPTNAME , '' )		AS DEPTNAME
			,	COALESCE ( M.JOBDESC,'') AS JOBDESC
			,	COALESCE ( CL . COMPANYCODE , '' )		AS COMPANYCODE
			,	COALESCE ( CL . COMPANY , '' )			AS COMPANYNAME
			,	COALESCE ( M . RANKCODE , '' )			AS RANKCODE
			,	COALESCE ( R . RANKNAME , '' )			AS RANKNAME
			--,	COALESCE(J.JOBCODE,'')		AS JOBCODE,
			--,	BO.UF_USERINFO_JOBNAME2(M.COMPANYCODE, M.EMPID, @LANGCODE) AS JOBNAME,
			,	COALESCE ( D . DUTYCODE , '' )			AS DUTYCODE
			,	COALESCE ( D . DUTYNAME , '' )			AS DUTYNAME
			,	COALESCE ( M . FAXNUMBER , '' )		AS FAXNUMBER
			--,	COALESCE(DBO.UF_USERINFO_SIGN(M.COMPANYCODE, M.EMPID), '') AS SIGNID
			--,	COALESCE(M.LOCATIONCODE, '')	AS LOCATIONCODE
			,	COALESCE ( M . DATEOFBIRTH , '' )		AS DATEOFBIRTH
			,	COALESCE ( DP . KOSTL , '' )			AS KOSTL
			,	''								AS ICON
			,	COALESCE ( D . SORTNO , 9999 )		AS DSORTNO
			,	COALESCE ( R . SORTNO , 9999 )		AS RSORTNO
			,	CL.COMPANYCODE AS ORGCOMCODE
		FROM TYJINFWLIB . ORG_USER AS M LEFT OUTER JOIN TYJINFWLIB . ORG_USERLANG AS UL ON M . EMPID = UL . EMPID AND	UL . LANGCODE = P_LANGCODE AND M . COMPANYCODE = UL . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_DEPTLANG AS DL ON M . MAINDEPTCODE = DL . DEPTCODE AND DL . LANGCODE = P_LANGCODE AND M . COMPANYCODE = DL . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_COMPANYLANG AS CL ON M . COMPANYCODE = CL . COMPANYCODE AND CL . LANGUAGECODE = P_LANGCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_RANK AS R ON M . RANKCODE = R . RANKCODE AND R . LANGCODE = P_LANGCODE --AND M . COMPANYCODE = R . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_DUTY AS D ON M . DUTYCODE = D . DUTYCODE AND D . LANGCODE = P_LANGCODE --AND M . COMPANYCODE = D . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_DEPT AS DP ON M . MAINDEPTCODE = DP . DEPTCODE AND M . COMPANYCODE = DP . COMPANYCODE
									--LEFT OUTER JOIN DBO.TB_JOB J ON M.JOBCODE = J.JOBCODE AND J.LANGCODE = P_LANGCODE AND M.COMPANYCODE = J.COMPANYCODE 								 
		WHERE
				( COALESCE ( P_DEPTCODE , '' ) = '' OR M . MAINDEPTCODE	= P_DEPTCODE )
		AND		M . DISPLAYYN		= 'Y'
		AND		M . COMPANYCODE	= CASE WHEN P_COMPANYCODE = '' THEN M . COMPANYCODE ELSE P_COMPANYCODE	END
		AND		M . ONSITE IS NULL
		AND		M.DPARTNER <> '1'

		UNION ALL

		SELECT	LOWER ( M . LOGINID )				AS EMPID
			,	LOWER ( M . EMPID )					AS REMPID
			,	COALESCE ( M . EXTENSIONNUMBER , '' )	AS EXTENSIONNUMBER
			,	COALESCE ( M . CELLPHONE , '' )		AS CELLPHONE
			,	COALESCE ( M . PHONE1 , '' )			AS PHONE1
			,	COALESCE ( M . PHONE2 , '' )			AS PHONE2
			,	COALESCE ( M . LOCATIONCODE , '' )		AS LOCATIONCODE
			,	COALESCE ( D . TEAMCHIEFYN , 'N' )	AS TEAMCHIEFYN
			,	COALESCE ( UL . USERLNAME , '' )	|| COALESCE ( UL . USERFNAME , '' ) AS USERNAME
			,	COALESCE ( M . DISPLAYNAME , '' )		AS DISPLAYNAME
			,	COALESCE ( M . EMAIL , '' )			AS EMAIL
			,	COALESCE ( AD . DEPTCODE , '' )		AS DEPTCODE
			,	COALESCE ( DL . DEPTNAME , '' )		AS DEPTNAME
			,	COALESCE ( AD.JOBDESC,'') AS JOBDESC
			,	COALESCE ( CL . COMPANYCODE , '' )		AS COMPANYCODE
			,	COALESCE ( CL . COMPANY , '' )			AS COMPANYNAME
			,	COALESCE ( AD . RANKCODE , '' )			AS RANKCODE
			,	COALESCE ( R . RANKNAME , '' )			AS RANKNAME
			--,	COALESCE(J.JOBCODE,'')		AS JOBCODE,
			--,	BO.UF_USERINFO_JOBNAME2(M.COMPANYCODE, M.EMPID, @LANGCODE) AS JOBNAME,
			,	COALESCE ( D . DUTYCODE , '' )			AS DUTYCODE
			,	COALESCE ( D . DUTYNAME , '' )			AS DUTYNAME
			,	COALESCE ( M . FAXNUMBER , '' )		AS FAXNUMBER
			--,	COALESCE(DBO.UF_USERINFO_SIGN(M.COMPANYCODE, M.EMPID), '') AS SIGNID
			--,	COALESCE(M.LOCATIONCODE, '')	AS LOCATIONCODE
			,	COALESCE ( M . DATEOFBIRTH , '' )		AS DATEOFBIRTH
			,	COALESCE ( DP . KOSTL , '' )			AS KOSTL
			,	''								AS ICON
			,	COALESCE ( D . SORTNO , 9999 )		AS DSORTNO
			,	COALESCE ( R . SORTNO , 9999 )		AS RSORTNO
			,	M.COMPANYCODE AS ORGCOMCODE
		FROM TYJINFWLIB . ORG_ADDITIONALJOB AS AD
									LEFT OUTER JOIN TYJINFWLIB . ORG_USER AS M ON AD.EMPID = M.EMPID AND AD.COMPANYCODE = P_COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_USERLANG AS UL ON AD . EMPID = UL . EMPID AND	UL . LANGCODE = P_LANGCODE AND M . COMPANYCODE = UL . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_DEPTLANG AS DL ON AD . DEPTCODE = DL . DEPTCODE AND DL . LANGCODE = P_LANGCODE AND AD . COMPANYCODE = DL . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_COMPANYLANG AS CL ON AD . COMPANYCODE = CL . COMPANYCODE AND CL . LANGUAGECODE = P_LANGCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_RANK AS R ON AD . RANKCODE = R . RANKCODE AND R . LANGCODE = P_LANGCODE --AND AD . COMPANYCODE = R . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_DUTY AS D ON AD . DUTYCODE = D . DUTYCODE AND D . LANGCODE = P_LANGCODE --AND AD . COMPANYCODE = D . COMPANYCODE
									LEFT OUTER JOIN TYJINFWLIB . ORG_DEPT AS DP ON AD . DEPTCODE = DP . DEPTCODE AND AD . COMPANYCODE = DP . COMPANYCODE	 								 
		WHERE
				( COALESCE ( P_DEPTCODE , '' ) = '' OR AD . DEPTCODE	= P_DEPTCODE )
		AND		M . DISPLAYYN		= 'Y'
		--AND		AD . COMPANYCODE	= P_COMPANYCODE	
		AND		AD . COMPANYCODE	= CASE WHEN P_COMPANYCODE = '' THEN AD . COMPANYCODE ELSE P_COMPANYCODE	END

	)
	SELECT	EMPID			
		,	REMPID			
		,	EXTENSIONNUMBER	
		,	CELLPHONE		
		,	PHONE1			
		,	PHONE2			
		,	LOCATIONCODE	
		,	TEAMCHIEFYN		
		,	USERNAME		
		,	DISPLAYNAME		
		,	EMAIL			
		,	DEPTCODE		
		,	DEPTNAME  
		,	JOBDESC		
		,	COMPANYCODE		
		,	COMPANYNAME		
		,	RANKCODE		
		,	RANKNAME		
		,	DUTYCODE		
		,	DUTYNAME		
		,	FAXNUMBER		
		,	DATEOFBIRTH		
		,	KOSTL			
		,	ICON			
		,	DSORTNO			
		,	RSORTNO
		,	ORGCOMCODE
	FROM CTE
	WHERE USERNAME				LIKE '%' || P_SEARCHSTRING || '%'		
		OR	REMPID				LIKE '%' || P_SEARCHSTRING || '%'
		OR	EMAIL				LIKE '%' || P_SEARCHSTRING || '%'
		OR	DEPTNAME			LIKE '%' || P_SEARCHSTRING || '%'
		OR	DUTYNAME			LIKE '%' || P_SEARCHSTRING || '%'
		OR	RANKNAME			LIKE '%' || P_SEARCHSTRING || '%'
		OR	EXTENSIONNUMBER		LIKE '%' || P_SEARCHSTRING || '%'
		OR	CELLPHONE			LIKE '%' || P_SEARCHSTRING || '%'
		OR	PHONE1				LIKE '%' || P_SEARCHSTRING || '%'
		OR	PHONE2				LIKE '%' || P_SEARCHSTRING || '%'
		OR	EMPID				LIKE '%' || P_SEARCHSTRING || '%';
		--OR	JOBNAME				LIKE '%' || P_SEARCHSTRING || '%'
		
				
	S2 : BEGIN -- 실행부
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			SELECT	EMPID			
				,	REMPID			
				,	EXTENSIONNUMBER	
				,	CELLPHONE		
				,	PHONE1			
				,	PHONE2			
				,	LOCATIONCODE	
				,	TEAMCHIEFYN		
				,	USERNAME		
				,	DISPLAYNAME		
				,	CELLPHONE AS EMAIL			
				,	DEPTCODE		
				,	DEPTNAME	
				,	JOBDESC	
				,	COMPANYCODE		
				,	COMPANYNAME		
				,	RANKCODE		
				,	RANKNAME		
				,	DUTYCODE		
				,	DUTYNAME		
				,	FAXNUMBER		
				,	DATEOFBIRTH		
				,	KOSTL			
				,	ICON			
				,	DSORTNO
				,	RSORTNO
				,	ORGCOMCODE
			FROM SESSION . T1
			WHERE REMPID <> '000000'
			ORDER BY DSORTNO ASC , TEAMCHIEFYN DESC , RSORTNO ASC , REMPID ASC , USERNAME ASC ;
				
		OPEN REFCURSOR ;
	END S2 ;
	
	S3 : BEGIN -- 실행부
		DECLARE REFCURSOR CURSOR WITH RETURN FOR		
			SELECT T . TOTALCOUNT
				,	DL . DEPTNAME
				,	D . DEPTCODE
				,	D . COMPANYCODE AS COMPANYCODE
				,	COALESCE ( CL . COMPANY , '' ) AS COMPANYNAME
				,	COALESCE ( D . DEPTEMAIL , '' ) AS DEPTEMAIL
				,	T . SEARCH
			FROM
				( SELECT P_COMPANYCODE AS COMPANYCODE , ( SELECT COUNT ( * ) AS TOTALCOUNT FROM SESSION . T1 ) AS TOTALCOUNT , P_SEARCHSTRING AS SEARCH FROM SYSIBM . SYSDUMMY1 ) AS T
				LEFT OUTER JOIN TYJINFWLIB . ORG_DEPT AS D ON T . COMPANYCODE = D . COMPANYCODE AND	D . DEPTCODE = P_DEPTCODE
				LEFT OUTER JOIN TYJINFWLIB . ORG_DEPTLANG AS DL ON DL . DEPTCODE = D . DEPTCODE AND	DL . LANGCODE = P_LANGCODE AND DL . COMPANYCODE = D . COMPANYCODE
				LEFT OUTER JOIN TYJINFWLIB . ORG_COMPANYLANG AS CL ON D . COMPANYCODE = CL . COMPANYCODE AND CL . LANGUAGECODE = P_LANGCODE ;			
		OPEN REFCURSOR ;
	END S3 ;
	--TYJINFWLIB.PTORGUSR40
	--TYJINFWLIB.PTORGUSR41
END P1
