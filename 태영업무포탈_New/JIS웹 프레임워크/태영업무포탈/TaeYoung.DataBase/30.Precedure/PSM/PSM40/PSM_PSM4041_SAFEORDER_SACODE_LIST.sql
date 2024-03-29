  
DROP PROCEDURE PSSCMLIB.PSM_PSM4041_SAFEORDER_SACODE_LIST;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4041_SAFEORDER_SACODE_LIST ( 
	IN P_SSWKTEAM VARCHAR(6) , 
	IN P_SSWKDATE VARCHAR(8) , 
	IN P_SSWKSEQ NUMERIC(3, 0),
	IN P_SSORAPPDATE VARCHAR(8) , 
	IN P_SSORSEQ NUMERIC(3, 0)
	) 
	DYNAMIC RESULT SETS 2
	LANGUAGE SQL 
	
MAIN : BEGIN  -- 시작 
	P1 : BEGIN  -- 조치요구사항 그룹별 최대개수
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
			 
			WITH MAST AS
			(
			   SELECT
			   SUBSTR(CDCODE,1,1) AS CODE
			   FROM PSSCMLIB.PSM_CODEMF
			   LEFT OUTER JOIN PSSCMLIB.PSM_SAFEORDER_SACODE
			   ON    SSSACODE    = CDCODE
			   AND   SSWKTEAM    = P_SSWKTEAM
			   AND   SSWKDATE    = P_SSWKDATE
			   AND   SSWKSEQ     = P_SSWKSEQ
			   AND   SSORAPPDATE = P_SSORAPPDATE
			   AND   SSORSEQ     = P_SSORSEQ
			   WHERE CDINDEX     = 'SA'
			)
			SELECT
			MAX(CNT) AS CNT
			FROM
			(
			   SELECT
			   CODE,
			   COUNT(*) AS CNT
			   FROM MAST
			   GROUP BY CODE
			) AS TEMP ; 
  
		OPEN REFCURSOR ; 
	END P1 ; 

	P2 : BEGIN  -- 조치요구사항 조회
		DECLARE REFCURSOR2 CURSOR WITH RETURN FOR 
			 
			WITH MAST AS
			(
			SELECT
			CDCODE AS CODE,
			CDDESC1 AS NAME,
			SSPUBSEL,
			SSREVSEL,
			SSFIXSEL
			FROM PSSCMLIB.PSM_CODEMF
			LEFT OUTER JOIN PSSCMLIB.PSM_SAFEORDER_SACODE
			ON       SSSACODE    = CDCODE
			AND      SSWKTEAM    = P_SSWKTEAM
			AND      SSWKDATE    = P_SSWKDATE
			AND      SSWKSEQ     = P_SSWKSEQ
			AND      SSORAPPDATE = P_SSORAPPDATE
			AND      SSORSEQ     = P_SSORSEQ
			WHERE CDINDEX = 'SA'
			)

			SELECT
			ROWNUMBER() OVER(ORDER BY CODE) AS RUM,
			CODE,
			NAME,
			(CASE WHEN SSPUBSEL IS NULL THEN 'N' ELSE SSPUBSEL END) AS SSPUBSEL,
			(CASE WHEN SSREVSEL IS NULL THEN 'N' ELSE SSREVSEL END) AS SSREVSEL,
			(CASE WHEN SSFIXSEL IS NULL THEN 'N' ELSE SSFIXSEL END) AS SSFIXSEL
			FROM MAST ; 
  
		OPEN REFCURSOR2 ; 
	END P2 ; 
END;