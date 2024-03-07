--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	23-06-26 15:18:05 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
DROP PROCEDURE PSSCMLIB.PSM_PSM1093_JSA_REFORM_LIST ; 
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1093_JSA_REFORM_LIST ( 
	IN P_JSDBLASS VARCHAR(2),
	IN P_JSDMLASS VARCHAR(2),
	IN P_JSDSLASS VARCHAR(3),
	IN P_JSDSEQ NUMERIC(3,0),
	IN P_JSDITEMSEQ NUMERIC(3,0))
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1093_JSA_REFORM_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	DECRESULT = (31, 31, 00) , 
	DFTRDBCOL = *NONE , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 
MAIN : BEGIN  -- 실행부 
LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
			 
		SELECT
		*
		FROM
		(
		SELECT
		J1NAME AS JBCODE,
		J2NAME AS JMCODE,
		J3NAME AS JSCODE,
		JSDITEMTEXT,
		VALUE(JSESUBSEQ,0) AS JSESUBSEQ,
		JSEREFORMTEXT,
		JSEREFORMCNT,
		JSEREFORMSOLID,
		JSEREFORMDEGREE
		FROM PSSCMLIB.PSM_JSA_DETAIL
		LEFT OUTER JOIN PSSCMLIB.PSM_JSA_CLASS1 AS JBCODE
		ON    JSDBLASS = J1CODE
		LEFT OUTER JOIN PSSCMLIB.PSM_JSA_CLASS2
		ON    JSDBLASS = J2BCODE
		AND   JSDMLASS = J2MCODE
		LEFT OUTER JOIN PSSCMLIB.PSM_JSA_CLASS3
		ON    JSDBLASS = J3BCODE
		AND   JSDMLASS = J3MCODE
		AND   JSDSLASS = J3SCODE
		LEFT OUTER JOIN PSSCMLIB.PSM_JSA_REFORM AS RISK
		ON    JSDBLASS = JSEBLASS
		AND   JSDMLASS = JSEMLASS
		AND   JSDSLASS = JSESLASS
		AND   JSDSEQ = JSESEQ
		AND   JSDITEMSEQ = JSEITEMSEQ
		WHERE JSDBLASS   = P_JSDBLASS
		AND   JSDMLASS   = P_JSDMLASS
		AND   JSDSLASS   = P_JSDSLASS
		AND   JSDSEQ     = P_JSDSEQ
		AND   JSDITEMSEQ = P_JSDITEMSEQ
		)
		WHERE JSESUBSEQ <> 0
		ORDER BY JSESUBSEQ 
					 ; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 