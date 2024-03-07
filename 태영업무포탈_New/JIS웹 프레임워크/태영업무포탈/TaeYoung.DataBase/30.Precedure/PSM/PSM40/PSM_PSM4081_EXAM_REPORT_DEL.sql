--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 14:26:26 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM4081_EXAM_REPORT_DEL ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4081_EXAM_REPORT_DEL ( 
	IN P_PERTCTEAM VARCHAR(6),
	IN P_PERTCDATE VARCHAR(8),
	IN P_PERTCSEQ NUMERIC(3,0),
	IN P_PERDATE VARCHAR(8),
	IN P_PERSEQ NUMERIC(1,0),
	IN P_PERNUM NUMERIC(3,0)) 
	LANGUAGE SQL 

	P1 : BEGIN 

	DECLARE V_CNT INT ; 

	SET V_CNT = 0 ; 
  
		DELETE FROM PSSCMLIB.PSM_EXAM_REPORT
		WHERE PERTCTEAM = P_PERTCTEAM
		AND    PERTCDATE = P_PERTCDATE
		AND    PERTCSEQ = P_PERTCSEQ
		AND    PERDATE = P_PERDATE
		AND    PERSEQ = P_PERSEQ
		AND    PERNUM = P_PERNUM ;

		SELECT  COUNT(*) INTO V_CNT
		FROM PSSCMLIB.PSM_EXAM_REPORT
		WHERE PERTCTEAM  = P_PERTCTEAM
		AND   PERTCDATE  = P_PERTCDATE
		AND   PERTCSEQ   = P_PERTCSEQ
		AND   PERDATE    = P_PERDATE
		AND   PERSEQ     = P_PERSEQ ;

		IF V_CNT = 0 THEN 

			UPDATE PSSCMLIB.PSM_EXAM_CHECK SET
			PECRDATE = '',
			PECRSEQ = 0
			WHERE PECTEAM = P_PERTCTEAM
			AND   PECDATE = P_PERTCDATE
			AND   PECSEQ  = P_PERTCSEQ;

		END IF;
  
END P1  ; 
  