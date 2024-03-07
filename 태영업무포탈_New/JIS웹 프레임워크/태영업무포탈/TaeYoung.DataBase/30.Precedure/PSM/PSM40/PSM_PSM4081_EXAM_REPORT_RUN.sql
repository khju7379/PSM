DROP PROCEDURE PSSCMLIB.PSM_PSM4081_EXAM_REPORT_RUN;

CREATE PROCEDURE PSSCMLIB.PSM_PSM4081_EXAM_REPORT_RUN( 
	IN P_PERTCTEAM VARCHAR(6) , 
	IN P_PERTCDATE VARCHAR(8) , 
	IN P_PERTCSEQ NUMERIC(3,0),
	IN P_PERDATE VARCHAR(8),
	IN P_PERSEQ NUMERIC(1,0))
	RESULT SETS 1
	LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
		PERTCTEAM  ,
		TYSCMLIB.SF_GB_ORGNAME(PERTCTEAM, CAST(PERTCDATE AS VARCHAR(8))) AS PERTCTEAMNM,
		PERTCDATE  ,
		PERTCSEQ   ,
		PERDATE    ,
		PERSEQ     ,
		PERNUM    , 
		PERSUBJECTS,
		PERRESULTS ,
		PERSABUN   ,
		KBHANGL,
		PERCONTENTS,
		PERBIGO    ,
		PECDATE1
		FROM PSSCMLIB.PSM_EXAM_REPORT
		LEFT OUTER JOIN PSSCMLIB.PSM_EXAM_CHECK 
		ON   PECTEAM = PERTCTEAM
		AND   PECDATE = PERTCDATE
		AND   PECSEQ = PERTCSEQ
		LEFT OUTER JOIN TYSCMLIB.INKIBNMF
		ON   KBSABUN = PERSABUN
		WHERE PERTCTEAM = P_PERTCTEAM
		AND    PERTCDATE = P_PERTCDATE
		AND    PERTCSEQ = P_PERTCSEQ
		AND    PERDATE = P_PERDATE
		AND    PERSEQ = P_PERSEQ

		ORDER BY PERTCTEAM, PERTCDATE, PERTCSEQ, PERDATE, PERSEQ;

		
	OPEN REFCURSOR;

END