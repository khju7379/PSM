--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE PSSCMLIB.PSM_PSM4080_EXAM_CHECK_LIST;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4080_EXAM_CHECK_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_STDATE VARCHAR(8),
	IN P_EDDATE VARCHAR(8),
	IN P_PECTEAM VARCHAR(6),
	IN P_PECTITLE VARCHAR(200),
	IN P_PECSGUBUN VARCHAR(1),
	IN P_WKSAUP VARCHAR(1),
	IN P_DEPT VARCHAR(6),
	IN P_STATUS VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	
	P1 : BEGIN  -- 시작 
	DECLARE P_STNUM INTEGER ; 
	DECLARE P_FNNUM INTEGER ; 
	DECLARE P_SQLSTRING VARCHAR ( 4000 ) ; 
	DECLARE P_SQLTOTALROWCOUNT VARCHAR ( 4000 ) ; 
	DECLARE P_TABLE_QUERY			VARCHAR ( 4000 ) ; 
	DECLARE P_COUNT_QUERY			VARCHAR ( 4000 ) ; 
  
PREV : BEGIN  -- 값 설정 
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
	END PREV ; 
  
MAIN : BEGIN  -- 실행부 
      LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR  -- 커서생성 
			WITH ORIGINAL_DATA AS (
			SELECT
				ROW_NUMBER() OVER(ORDER BY PECTEAM, PECDATE DESC , PECSEQ DESC) AS ROWNO,
				PECWOTEAM || '-' || PECWODATE || '-' || DIGITS(PECWOSEQ) AS APP_NUM,
				PECTEAM || '-' || PECDATE || '-' || DIGITS(PECSEQ) AS PEC_NUM,
				PECTEAM,
				TYSCMLIB.SF_GB_ORGNAME(PECTEAM, CAST(PECDATE AS VARCHAR(8))) AS PECTEAMNM,
				PECDATE,
				PECSEQ,
				PECWOTEAM,
				TYSCMLIB.SF_GB_ORGNAME(PECWOTEAM, CAST(PECWODATE AS VARCHAR(8))) AS PECWOTEAMNM,
				PECWODATE,
				PECWOSEQ,
				PECTITLE,
				SUBSTR(PECINSDATE,1,4) || '-' || SUBSTR(PECINSDATE,5,2) || '-' || SUBSTR(PECINSDATE,7,2) AS PECINSDATE,
				PECSGUBUN,
				CASE WHEN PECSGUBUN = '1' THEN '일반' ELSE '화물' END PECSGUBUNNM,
				PECSDATE,
				PECSSEQ,
				CASE WHEN PECRDATE <> '' THEN PECRDATE || '-' || DIGITS(PECRSEQ) ELSE '' END AS REP_NUM,
				PECRDATE,
				PECRSEQ,
				PECTANKNO,
				PECFAULTNM,
				PECIMPROVE,
				CASE WHEN PECRDATE <> '' THEN '2' ELSE '1' END AS WKSTATE,
				CASE WHEN PECRDATE <> '' THEN '작업완료' ELSE '보고서미작성' END AS WKSTATENM
			FROM PSSCMLIB.PSM_EXAM_CHECK
			WHERE PECDATE BETWEEN P_STDATE AND P_EDDATE
			AND ( SUBSTR ( PECTEAM , 1 , 1 ) || SUBSTR ( PECWOTEAM , 1 , 1 ) LIKE '%' || P_WKSAUP || '%' OR PECTEAM = P_DEPT ) 
			AND    PECTEAM LIKE '%' || P_PECTEAM || '%'
			AND    PECTITLE LIKE '%' || P_PECTITLE || '%'
			AND   (CASE WHEN P_PECSGUBUN = '' THEN '' ELSE PECSGUBUN END) = (CASE WHEN P_PECSGUBUN = '' THEN '' ELSE P_PECSGUBUN END)
			ORDER BY PECTEAM, PECDATE DESC , PECSEQ DESC
			)
			SELECT
			*
			FROM ORIGINAL_DATA
			WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
			AND   WKSTATE LIKE '%' || P_STATUS || '%'
			ORDER BY ROWNO ASC ;

		OPEN REFCURSOR ;

	END LIST ;  

	PAGING : BEGIN  -- 페이징 
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR  -- 커서생성 
				WITH ORIGINAL_DATA AS (
				SELECT
					ROW_NUMBER() OVER(ORDER BY PECTEAM, PECDATE DESC , PECSEQ DESC) AS ROWNO,
					PECWOTEAM || '-' || PECWODATE || '-' || DIGITS(PECWOSEQ) AS APP_NUM,
					PECTEAM || '-' || PECDATE || '-' || DIGITS(PECSEQ) AS PEC_NUM,
					PECTEAM,
					TYSCMLIB.SF_GB_ORGNAME(PECTEAM, CAST(PECDATE AS VARCHAR(8))) AS PECTEAMNM,
					PECDATE,
					PECSEQ,
					PECWOTEAM,
					TYSCMLIB.SF_GB_ORGNAME(PECWOTEAM, CAST(PECWODATE AS VARCHAR(8))) AS PECWOTEAMNM,
					PECWODATE,
					PECWOSEQ,
					PECTITLE,
					SUBSTR(PECINSDATE,1,4) || '-' || SUBSTR(PECINSDATE,5,2) || '-' || SUBSTR(PECINSDATE,7,2) AS PECINSDATE,
					PECSGUBUN,
					CASE WHEN PECSGUBUN = '1' THEN '일반' ELSE '화물' END PECSGUBUNNM,
					PECSDATE,
					PECSSEQ,
					CASE WHEN PECRDATE <> '' THEN PECRDATE || '-' || DIGITS(PECRSEQ) ELSE '' END AS REP_NUM,
					PECRDATE,
					PECRSEQ,
					PECTANKNO,
					PECFAULTNM,
					PECIMPROVE,
					CASE WHEN PECRDATE <> '' THEN '2' ELSE '1' END AS WKSTATE,
					CASE WHEN PECRDATE <> '' THEN '작업완료' ELSE '' END AS WKSTATENM
				FROM PSSCMLIB.PSM_EXAM_CHECK
				WHERE PECDATE BETWEEN P_STDATE AND P_EDDATE
				AND ( SUBSTR ( PECTEAM , 1 , 1 ) || SUBSTR ( PECWOTEAM , 1 , 1 ) LIKE '%' || P_WKSAUP || '%' OR PECTEAM = P_DEPT ) 
				AND    PECTEAM LIKE '%' || P_PECTEAM || '%'
				AND    PECTITLE LIKE '%' || P_PECTITLE || '%'
				AND   (CASE WHEN P_PECSGUBUN = '' THEN '' ELSE PECSGUBUN END) = (CASE WHEN P_PECSGUBUN = '' THEN '' ELSE P_PECSGUBUN END)
				ORDER BY PECTEAM, PECDATE DESC , PECSEQ DESC
				)
				SELECT
				COUNT(*) AS TOTALCOUNT
				FROM ORIGINAL_DATA
				WHERE WKSTATE LIKE '%' || P_STATUS || '%';

			OPEN REFCURSOR2 ; 
	END PAGING ; 
END MAIN ; 
END  ;
