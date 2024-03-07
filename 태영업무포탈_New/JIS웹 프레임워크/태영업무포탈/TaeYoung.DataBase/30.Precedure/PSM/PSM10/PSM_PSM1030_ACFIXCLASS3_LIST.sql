--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE PSSCMLIB.PSM_PSM1030_ACFIXCLASS3_LIST;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1030_ACFIXCLASS3_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SAUP VARCHAR(1),
	IN P_BCODE VARCHAR(2),
	IN P_MCODE VARCHAR(4),
	IN P_SCODE VARCHAR(3),
	IN P_SNAME VARCHAR(100)) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1030_ACFIXCLASS3_LIST 
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
			SELECT ROW_NUMBER() OVER(ORDER BY FXC3SAUP, FXC3BCODE, FXC3MCODE, FXC3SCODE) AS ROWNO,
			       FXC3SAUP AS C3SAUP,   
			       FXC3BCODE AS C3BCODE,
			       FXC1DESC AS C3BCODENM,
			       DIGITS(FXC3MCODE) AS C3MCODE,   
			       FXC2DESC AS C3MCODENM,
			       DIGITS(FXC3SCODE) AS C3SCODE,
			       FXC3DESC AS C3NAME,   
			       FXC3LINKCODE1 AS C3LINKCODE1,
			       ( SELECT A.FXC3DESC AS C3NAME FROM TYSCMLIB.ACFIXCLASS3 A
			       WHERE A.FXC3SAUP||A.FXC3BCODE||DIGITS(A.FXC3MCODE)||DIGITS(A.FXC3SCODE) = C.FXC3LINKCODE1) AS C3LINKCODE1NM,
			       FXC3LINKCODE2 AS C3LINKCODE2,
			       ( SELECT B.FXC3DESC AS C3NAME FROM TYSCMLIB.ACFIXCLASS3  B
			       WHERE B.FXC3SAUP||B.FXC3BCODE||DIGITS(B.FXC3MCODE)||DIGITS(B.FXC3SCODE) = C.FXC3LINKCODE2) AS C3LINKCODE2NM,
			       FXC3BIGO AS C3BIGO
			FROM TYSCMLIB.ACFIXCLASS3 C
			LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS1
			ON    FXC1SAUP  = FXC3SAUP
			AND   FXC1CODE  = FXC3BCODE
			LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS2
			ON    FXC2SAUP  = FXC3SAUP
			AND   FXC2BCODE = FXC3BCODE
			AND   FXC2MCODE = FXC3MCODE 
			WHERE FXC3BCODE IN('20', '30', '40', '90')
			AND   FXC3SAUP = P_SAUP
			AND   (CASE WHEN P_BCODE = '' THEN 1 ELSE FXC3BCODE END) = (CASE WHEN P_BCODE = '' THEN 1 ELSE P_BCODE END)
			AND   (CASE WHEN P_MCODE = '' THEN 1 ELSE DIGITS(FXC3MCODE) END) = (CASE WHEN P_MCODE = '' THEN 1 ELSE P_MCODE END)
			AND   (CASE WHEN P_SCODE = '' THEN 1 ELSE DIGITS(FXC3SCODE) END) = (CASE WHEN P_SCODE = '' THEN 1 ELSE P_SCODE END)
			AND   FXC3DESC   LIKE  '%' || P_SNAME || '%'
			ORDER BY FXC3SAUP, FXC3BCODE, FXC3MCODE, FXC3SCODE
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
				FROM TYSCMLIB.ACFIXCLASS3 C
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS1
				ON    FXC1SAUP  = FXC3SAUP
				AND   FXC1CODE  = FXC3BCODE
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS2
				ON    FXC2SAUP  = FXC3SAUP
				AND   FXC2BCODE = FXC3BCODE
				AND   FXC2MCODE = FXC3MCODE 
				WHERE FXC3BCODE IN('20', '30', '40', '90')
				AND   FXC3SAUP = P_SAUP
				AND   (CASE WHEN P_BCODE = '' THEN 1 ELSE FXC3BCODE END) = (CASE WHEN P_BCODE = '' THEN 1 ELSE P_BCODE END)
				AND   (CASE WHEN P_MCODE = '' THEN 1 ELSE DIGITS(FXC3MCODE) END) = (CASE WHEN P_MCODE = '' THEN 1 ELSE P_MCODE END)
				AND   (CASE WHEN P_SCODE = '' THEN 1 ELSE DIGITS(FXC3SCODE) END) = (CASE WHEN P_SCODE = '' THEN 1 ELSE P_SCODE END)
				AND   FXC3DESC   LIKE  '%' || P_SNAME || '%'  ;
			OPEN REFCURSOR2 ; 
	END PAGING ; 
END MAIN ; 
END  ;
