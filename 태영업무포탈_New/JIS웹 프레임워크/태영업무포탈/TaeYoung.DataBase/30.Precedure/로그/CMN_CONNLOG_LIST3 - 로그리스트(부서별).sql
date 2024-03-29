--DROP PROCEDURE CMN_LOG_LIST3;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_LOG_LIST3
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 뷰서별 로그리스트를 조회한다.
-- 예문       : CALL CMN_LOG_LIST3 ('2006909','1000','TS1301')
--		DB2 변환 : 이전프로시져명 UP_CONNECTION_LOG_LIST_DEPT
-------------------------------------------------------------------------------------------
CREATE PROCEDURE CMN_LOG_LIST3
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
		SET P_STNUM = (P_PAGESIZE * (P_CURRENTPAGEINDEX - 1))  ||  1;   
		SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX;   
	END S1; 
	
	S2: BEGIN -- 실행부
		C1 : BEGIN -- 리스트
			DECLARE REFCURSOR  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S1 ;  -- 커서생성 
			SET P_TABLE_QUERY = '
				WITH ORIGINAL_DATA AS (  
					SELECT 
						ROW_NUMBER() OVER() AS ROWNO
						, A.*
					FROM (
							SELECT COUNT(*) AS CNT, B.MAINDEPTCODE, C.DISPLAYNAME, D.COMPANY AS COMPANYNAME FROM TYJINFWLIB.' || P_DATE || ' A 
								JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID=B.EMPID
								JOIN TYJINFWLIB.ORG_DEPT C ON B.MAINDEPTCODE=C.DEPTCODE
								JOIN TYJINFWLIB. ORG_COMPANYLANG D ON B.COMPANYCODE=D.COMPANYCODE AND D.LANGUAGECODE=''ko''
							WHERE LOG_TYPE = ''LOGIN''
							AND MACHINE_NAME=''EPWAS'' 
							AND NOT B.MAINDEPTCODE = ''VENDOR''
							' || P_SEARCHCONDITION || '
							GROUP BY B.MAINDEPTCODE, C.DISPLAYNAME, D.COMPANY
						) A 
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
				FROM (
						SELECT COUNT(*) AS CNT, B.MAINDEPTCODE, C.DISPLAYNAME FROM TYJINFWLIB.' || P_DATE || ' A 
							JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID=B.EMPID
							JOIN TYJINFWLIB.ORG_DEPT C ON B.MAINDEPTCODE=C.DEPTCODE
						WHERE LOG_TYPE = ''LOGIN''
						AND MACHINE_NAME=''EPWAS'' 
						AND NOT B.MAINDEPTCODE = ''VENDOR''
						' || P_SEARCHCONDITION || '
						GROUP BY B.MAINDEPTCODE, C.DISPLAYNAME
				) A
			
			';
			PREPARE S2 FROM P_COUNT_QUERY;
			OPEN REFCURSOR2;
		END C2;
	END S2;
END P1