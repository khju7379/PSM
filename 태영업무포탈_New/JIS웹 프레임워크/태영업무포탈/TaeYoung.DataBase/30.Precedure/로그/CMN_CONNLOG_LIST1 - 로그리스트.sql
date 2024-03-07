--DROP PROCEDURE CMN_LOG_LIST1;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_LOG_LIST1
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 로그리스트를 조회한다.
-- 예문       : CALL CMN_LOG_LIST1 ('2006909','1000','TS1301')
--		DB2 변환 : 이전프로시져명 UP_CONNECTION_LOG_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE CMN_LOG_LIST1 
(
		P_CURRENTPAGEINDEX       INTEGER             -- 목록의 현재페이지 번호  
	,   P_PAGESIZE               INTEGER             -- 목록의 한 페이지에 표현되는 글 목록수  
	,   P_SEARCHCONDITION        VARCHAR(4000) 	 	 -- 조회조건 내용  
	,	P_DATE					 VARCHAR(10)		 -- 테이블명(조회테이블명)
)
	RESULT SETS 2
	LANGUAGE SQL
P1: BEGIN -- 시작
	
	DECLARE P_STNUM                  INTEGER;   
	DECLARE P_FNNUM                  INTEGER;
	DECLARE P_SQLSTRING              VARCHAR(4000);   
	DECLARE P_SQLTOTALROWCOUNT       VARCHAR(4000);  
	DECLARE P_TABLE_QUERY 			 VARCHAR(4000);
	DECLARE P_COUNT_QUERY 			 VARCHAR(4000);
	   
	S1: BEGIN -- 값 설정
		SET P_STNUM = (P_PAGESIZE * (P_CURRENTPAGEINDEX - 1)) + 1;   
		SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX;   
	END S1; 
	
	S2: BEGIN -- 실행부
		C1 : BEGIN -- 리스트
			DECLARE REFCURSOR  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S1 ;  -- 커서생성 
			SET P_TABLE_QUERY = '
				WITH ORIGINAL_DATA AS (  
					SELECT 
						ROW_NUMBER() OVER() AS ROWNO, 
						A.IDX
						, CASE WHEN A.BIZ_TYPE = ''PASSCHG'' THEN ''비밀번호변경'' ELSE CASE WHEN A.BIZ_TYPE = ''SUPERPW'' THEN ''관리자접속'' ELSE ''구글로그인'' END END AS BIZ_TYPE  
						, A.OCCUR_TIME
						, A.USER_IP
						, A.USER_ID
						,B.DISPLAYNAME 
						,C.DISPLAYNAME AS DEPTNAME
						,D.COMPANY AS COMPANYNAME
					FROM TYJINFWLIB.' || P_DATE || ' A 
						LEFT JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID = B.EMPID
						LEFT JOIN TYJINFWLIB.ORG_DEPT C ON B.MAINDEPTCODE = C.DEPTCODE
						LEFT JOIN TYJINFWLIB.ORG_COMPANYGLO D ON B.COMPANYCODE=D.COMPANYCODE AND D.LANGUAGECODE=''ko''
					WHERE A.LOG_TYPE = ''LOGIN''
						--AND A.MACHINE_NAME=''EPWAS'' 
						' || P_SEARCHCONDITION || '
				) 
			  
				SELECT 
					* 
				FROM ORIGINAL_DATA
				WHERE ROWNO BETWEEN ' || CAST(P_STNUM AS VARCHAR(100)) || ' AND ' || CAST(P_FNNUM AS VARCHAR(100)) || '
				ORDER BY ROWNO ASC 
			';
			PREPARE S1 FROM P_TABLE_QUERY;
			OPEN REFCURSOR;
		END C1;
		C2: BEGIN -- 페이징
			DECLARE REFCURSOR2  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S2 ;  -- 커서생성 
			SET P_COUNT_QUERY = '
				SELECT 
						COUNT(*) AS TOTALCOUNT  
					FROM TYJINFWLIB.' || P_DATE || ' A LEFT JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID = B.EMPID
					WHERE LOG_TYPE = ''LOGIN''
						--AND A.MACHINE_NAME=''EPWAS''
						' || P_SEARCHCONDITION || '
			
			';
			PREPARE S2 FROM P_COUNT_QUERY;
			OPEN REFCURSOR2;
		END C2;
	END S2;
END P1