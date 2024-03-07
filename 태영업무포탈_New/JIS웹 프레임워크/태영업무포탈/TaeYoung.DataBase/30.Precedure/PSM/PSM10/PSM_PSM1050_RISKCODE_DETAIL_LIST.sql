--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE PSSCMLIB.PSM_PSM1050_RISKCODE_DETAIL_LIST;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1050_RISKCODE_DETAIL_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_RLYEAR VARCHAR(4),
	IN P_RLSEQ VARCHAR(3),
	IN P_RLCODE VARCHAR(1)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1050_RISKCODE_DETAIL_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	CLOSQLCSR = *ENDMOD , 
	DECRESULT = (31, 31, 00) , 
	DFTRDBCOL = *NONE , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
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
			ROW_NUMBER() OVER(ORDER BY RLSEQ, RLCODE, RLITEMCODE) AS ROWNO,
			'수정' AS RLEDIT,
			RLYEAR,
			RLSEQ,
			RLCODE,
			RLITEMCODE,
			RLNAME,
			RLITEMNAME,
			RLRSINDEX0,
			RLRSINDEX1,
			RLRSINDEX2,
			RLRSINDEX3,
			RLHIGB,
			RLHIDAT,
			RLHITIM,
			RLHISAB
			FROM PSSCMLIB.PSM_RISKCODE_LIST
			WHERE RLYEAR = P_RLYEAR
			AND RLSEQ = P_RLSEQ
			AND   (CASE WHEN P_RLCODE = '' THEN 1 ELSE RLCODE END) = (CASE WHEN P_RLCODE = '' THEN 1 ELSE P_RLCODE END)
			ORDER BY RLSEQ, RLCODE, RLITEMCODE
			)
			SELECT
			*
			FROM ORIGINAL_DATA
			WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
			ORDER BY ROWNO ASC ;

		OPEN REFCURSOR ;

	END LIST ;  

	PAGING : BEGIN  -- 페이징 
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR  -- 커서생성 
				SELECT   COUNT(*) AS TOTALCOUNT
				FROM PSSCMLIB.PSM_RISKCODE_LIST
				WHERE RLYEAR = P_RLYEAR
				AND RLSEQ = P_RLSEQ
				AND   (CASE WHEN P_RLCODE = '' THEN 1 ELSE RLCODE END) = (CASE WHEN P_RLCODE = '' THEN 1 ELSE P_RLCODE END) ;
			OPEN REFCURSOR2 ; 
	END PAGING ; 
END MAIN ; 
END  ;
