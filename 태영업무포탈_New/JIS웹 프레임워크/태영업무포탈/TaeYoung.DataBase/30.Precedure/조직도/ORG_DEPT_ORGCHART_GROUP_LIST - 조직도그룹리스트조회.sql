--DROP PROCEDURE TYJINFWLIB.ORG_DEPT_ORGCHART_GROUP_LIST;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_DEPT_ORGCHART_GROUP_LIST 
-- 작성자     : 박제영
-- 작성일     : 2015-10-06
-- 설명       : 조직도 그룹을 조회한다.
-- 예문       : CALL ORG_DEPT_ORGCHART_GROUP_LIST  ()
--		프렌지 변환 : PTORGUSR20L8 -> ORG_DEPT_ORGCHART_GROUP_LIST  
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_DEPT_ORGCHART_GROUP_LIST  
( 
	IN P_COMPANYCODE CHAR(10),
    IN P_LANGCODE VARCHAR(10) 
)
	RESULT SETS 1
	LANGUAGE SQL
	SPECIFIC TYJINFWLIB.ORG_DEPT_ORGCHART_GROUP_LIST

P1 : BEGIN	
	S1 : BEGIN -- 값 설정
		SET P_COMPANYCODE = COALESCE ( P_COMPANYCODE , '1000' ) ;
		SET P_LANGCODE = LOWER ( COALESCE ( P_LANGCODE , 'ko' ) ) ;
	END S1 ;

	S2 : BEGIN -- 실행부
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			SELECT
					G . GRPID AS GROUPCODE
				,	GL . GRPNAME AS GROUPNAME
				,	'' AS GROUPMAIL	
			FROM ORG_GROUP AS G LEFT OUTER JOIN ORG_GROUPLANG AS GL ON G . GRPID = GL . GRPID
			WHERE GL . LANGCODE = P_LANGCODE
			AND G . GRPTYPE = 'AM02030' ;			
		OPEN REFCURSOR ;
	END S2 ;	
END P1
