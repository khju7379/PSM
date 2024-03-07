--DROP PROCEDURE PSSCMLIB.PSM_WORKORDER_LIST;  

CREATE PROCEDURE PSSCMLIB.PSM_WORKORDER_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_SDATE VARCHAR(8) , 
	IN P_EDATE VARCHAR(8) , 
	IN P_WKGUBN VARCHAR(1) , 
	IN P_WKSTATUS VARCHAR(1) , 
	IN P_WKTEAM VARCHAR(1) , 
	IN P_ORSABUN VARCHAR(50) ) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_WORKORDER_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	DECRESULT = (31, 31, 00) , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	M1 : BEGIN 
  
	DECLARE P_STNUM			INTEGER ; 
DECLARE P_FNNUM			INTEGER ; 
  
	PREV : BEGIN  -- 값 설정 
SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
		SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
END PREV ; 
  
	 -- 임시테이블부 
	DECLARE GLOBAL TEMPORARY TABLE SESSION . PSM_WORKORDER_LIST ( 
			ROWNO			INTEGER 
		,	APP_NUM			VARCHAR ( 200 ) 
		,	WOWORKTITLE			NVARCHAR ( 120 ) 
		,	WODSDATE1			VARCHAR ( 10 ) 
		,	WODSDATE2		VARCHAR ( 10 ) 
		,	WOFROMTODATE		VARCHAR ( 100 ) 
		,	WOSOTEAMNM		VARCHAR ( 20 ) 
		,	WORETEAMNM		VARCHAR ( 20 ) 
		,	WOSTATUSCODE		VARCHAR ( 20 ) 
		,	WOSTATUS		VARCHAR ( 30 ) 
		,	WOAPPORSABUNNM		VARCHAR ( 30 ) 
		,	WOAPPREVSABUNNM		VARCHAR ( 30 ) 
		,	WKSTATUS		VARCHAR ( 1 ) 
		,	WOORDATE		VARCHAR ( 8 ) 
) WITH REPLACE ; 
	 -- 임시테이블부 끝 
	 -- 임시테이블 입력부 
	INSERT INTO SESSION . PSM_WORKORDER_LIST 
	SELECT ROWNUMBER ( ) OVER ( ) AS ROWNO , A . * 
	FROM ( 
		SELECT 
				WOORTEAM || '-' || WOORDATE || '-' || DIGITS ( WOSEQ ) AS APP_NUM ,  -- 요청번호 
				WOWORKTITLE ,  -- 작업내용 
				CASE WHEN WODSDATE1 = '' THEN '' ELSE 
					SUBSTR ( WODSDATE1 , 1 , 4 ) || '-' || SUBSTR ( WODSDATE1 , 5 , 2 ) || '-' || SUBSTR ( WODSDATE1 , 7 , 2 ) 
				END AS WODSDATE1 , 
				CASE WHEN WODSDATE2 = '' THEN '' ELSE 
					SUBSTR ( WODSDATE2 , 1 , 4 ) || '-' || SUBSTR ( WODSDATE2 , 5 , 2 ) || '-' || SUBSTR ( WODSDATE2 , 7 , 2 ) 
				END AS WODSDATE2 , 
				CASE WHEN WODSDATE1 = '' THEN '' ELSE 
					SUBSTR ( WODSDATE1 , 1 , 4 ) || '-' || SUBSTR ( WODSDATE1 , 5 , 2 ) || '-' || SUBSTR ( WODSDATE1 , 7 , 2 ) 
				END || ' ~ ' || 
				CASE WHEN WODSDATE2 = '' THEN '' ELSE 
					SUBSTR ( WODSDATE2 , 1 , 4 ) || '-' || SUBSTR ( WODSDATE2 , 5 , 2 ) || '-' || SUBSTR ( WODSDATE2 , 7 , 2 ) 
				END AS WOFROMTODATE ,  -- 작업기간          
				TYSCMLIB . SF_GB_ORGNAME ( WOSOTEAM , WOORDATE ) AS WOSOTEAMNM ,  -- 요청팀  
				TYSCMLIB . SF_GB_ORGNAME ( WORETEAM , WOORDATE ) AS WORETEAMNM ,  -- 수신팀 
				( SELECT A . WOSTATUSCODE 
				FROM PSSCMLIB . CV_PSM_WORKSTATUSLIST A 
				WHERE A . APP_NUM = C . WOORTEAM || '-' || C . WOORDATE || '-' || DIGITS ( C . WOSEQ ) ) AS WOSTATUSCODE , 
				( SELECT A . WOSTATUS 
				FROM PSSCMLIB . CV_PSM_WORKSTATUSLIST A 
				WHERE A . APP_NUM = C . WOORTEAM || '-' || C . WOORDATE || '-' || DIGITS ( C . WOSEQ ) ) AS WOSTATUS ,  -- 상태 
				PSSCMLIB . SF_PSM_WOAPPNEXT ( WOORTEAM , WOORDATE , DIGITS ( WOSEQ ) , 'NAME' , 'OR' ) AS WOAPPORSABUNNM ,  -- 요청자 
				PSSCMLIB . SF_PSM_WOAPPNEXT ( WOORTEAM , WOORDATE , DIGITS ( WOSEQ ) , 'NAME' , 'RE' ) AS WOAPPREVSABUNNM ,  -- 수신자 
				( CASE WHEN C . WOSTATUS = '1' AND C . WOAPPSTATUS = 'F' THEN '작업요청 완료' 
				WHEN C . WOSTATUS = '1' AND C . WOAPPSTATUS = '' THEN '작업요청중' 
				WHEN C . WOSTATUS = '2' AND ( SELECT COUNT ( * ) FROM PSSCMLIB . PSM_SAFEORDER_MASTER WHERE SMWKTEAM = C . WOORTEAM AND SMWKDATE = WOORDATE AND SMWKSEQ = WOSEQ ) > 0 THEN '안전작업허가 작업중' 
				WHEN C . WOSTATUS = '2' AND C . WOAPPSTATUS = 'F' THEN 'JSA 완료' 
				WHEN C . WOSTATUS = '3' AND C . WOAPPSTATUS = 'F' THEN '가동전점검 완료' 
				WHEN C . WOSTATUS = '5' AND C . WOAPPSTATUS = 'F' THEN '공사 완료' 
				WHEN C . WOSTATUS = 'A' AND C . WOAPPSTATUS = 'F' THEN '변경요구서 완료' 
				WHEN C . WOSTATUS = 'R' AND C . WOAPPSTATUS = 'F' THEN '변경검토서 완료' 
				ELSE ( SELECT A . WOSTATUS 
				       FROM PSSCMLIB . CV_PSM_WORKSTATUSLIST A 
				       WHERE A . APP_NUM = C . WOORTEAM || '-' || C . WOORDATE || '-' || DIGITS ( C . WOSEQ ) ) END ) AS WKSTATUSNM , 
				       
				PAR . WKSTATUS AS WKSTATUS , 
				WOORDATE 
		FROM PSSCMLIB . PSM_WORKORDER C 
		LEFT OUTER JOIN TYSCMLIB . ACFIXCLASS3 S1 
			ON S1 . FXC3SAUP || S1 . FXC3BCODE || DIGITS ( S1 . FXC3MCODE ) || DIGITS ( S1 . FXC3SCODE ) = WOLOCATIONCODE1 
		LEFT OUTER JOIN TYSCMLIB . ACFIXCLASS3 S2 
			ON S2 . FXC3SAUP || S2 . FXC3BCODE || DIGITS ( S2 . FXC3MCODE ) || DIGITS ( S2 . FXC3SCODE ) = WOLOCATIONCODE2 
		LEFT OUTER JOIN TYSCMLIB . ACFIXCLASS3 S3 
			ON S3 . FXC3SAUP || S3 . FXC3BCODE || DIGITS ( S3 . FXC3MCODE ) || DIGITS ( S3 . FXC3SCODE ) = WOLOCATIONCODE3 
		LEFT OUTER JOIN TYSCMLIB . ACFIXCLASS3 S4 
			ON S4 . FXC3SAUP || S4 . FXC3BCODE || DIGITS ( S4 . FXC3MCODE ) || DIGITS ( S4 . FXC3SCODE ) = WOLOCATIONCODE4 
		LEFT OUTER JOIN TYSCMLIB . ACFIXCLASS3 S5 
			ON S5 . FXC3SAUP || S5 . FXC3BCODE || DIGITS ( S5 . FXC3MCODE ) || DIGITS ( S5 . FXC3SCODE ) = WOLOCATIONCODE5 
		LEFT OUTER JOIN TYSCMLIB . INKIBNMF K1 
			ON K1 . KBSABUN = WOORSABUN 
		LEFT OUTER JOIN TYSCMLIB . INKIBNMF K2 
			ON K2 . KBSABUN = WOSAFESABUN 
		LEFT OUTER JOIN ( SELECT CAST ( P_SDATE AS VARCHAR ( 8 ) ) AS SDATE , 
								CAST ( P_EDATE AS VARCHAR ( 8 ) ) AS EDATE , 
								CAST ( P_WKGUBN AS VARCHAR ( 1 ) ) AS WKGUBN , 
								CAST ( P_WKSTATUS AS VARCHAR ( 1 ) ) AS WKSTATUS , 
					CAST ( P_WKTEAM AS VARCHAR ( 1 ) ) AS WKTEAM 
					FROM SYSIBM . SYSDUMMY1 ) AS PAR 
			ON 1 = 1 
		WHERE WOORDATE BETWEEN SDATE AND EDATE 
			AND SUBSTR ( WOSOTEAM , 1 , 1 ) || SUBSTR ( WORETEAM , 1 , 1 ) LIKE '%' || PAR . WKTEAM || '%' 
			AND WOORSABUN LIKE P_ORSABUN || '%' 
		AND CASE WHEN WKGUBN = 'A' THEN '1' ELSE WOCHANGEWKDIV END = 
			CASE WHEN WKGUBN = 'A' THEN '1' ELSE WKGUBN END 
		) A 
		WHERE CASE WHEN WKSTATUS = 'A' OR WKSTATUS = '1' THEN '1' ELSE WOSTATUSCODE END = 
			CASE WHEN WKSTATUS = 'A' OR WKSTATUS = '1' THEN '1' ELSE WKSTATUS END 
		ORDER BY WOORDATE DESC , APP_NUM DESC , WOSTATUSCODE 
	; 
	 -- 임시테이블 입력부 끝 
	LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
		WITH MST AS ( 
			SELECT 
					* 
			FROM 
					SESSION . PSM_WORKORDER_LIST AS A 
		) 
		SELECT 
				M . * 
		FROM 
				MST AS M 
		WHERE 
				M . ROWNO		BETWEEN P_STNUM AND P_FNNUM 
		; 
		OPEN REFCURSOR ; 
END LIST ; 
  
  
  
PAGING : BEGIN  -- 페이징 
		DECLARE REFCURSOR2 CURSOR WITH RETURN FOR 
		SELECT 
				COUNT ( * ) AS TOTALCOUNT 
		FROM 
				SESSION . PSM_WORKORDER_LIST AS A 
		; 
		OPEN REFCURSOR2 ; 
END PAGING ; 
END M1;