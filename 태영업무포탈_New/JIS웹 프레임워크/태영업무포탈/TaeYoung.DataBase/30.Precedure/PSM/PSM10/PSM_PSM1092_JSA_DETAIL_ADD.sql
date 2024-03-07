DROP PROCEDURE PSSCMLIB.PSM_PSM1092_JSA_DETAIL_ADD;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1092_JSA_DETAIL_ADD ( 
	IN P_JSDBLASS VARCHAR(2) , 
	IN P_JSDMLASS VARCHAR(2) , 
	IN P_JSDSLASS VARCHAR(3) , 
	IN P_JSDSEQ NUMERIC(3,0) , 
	IN P_JSDITEMSEQ NUMERIC(3,0),
	IN P_JSDITEMTEXT VARCHAR(400),
	IN P_JSDTOOLTEXT VARCHAR(400),
	IN P_JSDHISAB VARCHAR(6),
	IN P_GUBUN VARCHAR (1)) 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1092_JSA_DETAIL_ADD 
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
	P1 : BEGIN 
	 
	IF P_GUBUN = 'A' THEN
  
		INSERT INTO PSSCMLIB.PSM_JSA_DETAIL
		(
		JSDBLASS,
		JSDMLASS,
		JSDSLASS,
		JSDSEQ,
		JSDITEMSEQ,
		JSDITEMTEXT,
		JSDTOOLTEXT,
		JSDHIGB,
		JSDHIDAT,
		JSDHITIM,
		JSDHISAB
		)
		VALUES
		(
		P_JSDBLASS,
		P_JSDMLASS,
		P_JSDSLASS,
		P_JSDSEQ,
		P_JSDITEMSEQ,
		P_JSDITEMTEXT,
		P_JSDTOOLTEXT,
		'A',
		CURRENT_DATE,
		CURRENT_TIME,
		P_JSDHISAB
		);
  
	ELSE 
  
		UPDATE PSSCMLIB.PSM_JSA_DETAIL SET
		JSDITEMTEXT = P_JSDITEMTEXT,
		JSDTOOLTEXT = P_JSDTOOLTEXT,
		JSDHIGB     = 'C',
		JSDHIDAT    = CURRENT_DATE,
		JSDHITIM    = CURRENT_TIME,
		JSDHISAB    = P_JSDHISAB
		WHERE JSDBLASS   = P_JSDBLASS
		AND   JSDMLASS   = P_JSDMLASS
		AND   JSDSLASS   = P_JSDSLASS
		AND   JSDSEQ     = P_JSDSEQ
		AND   JSDITEMSEQ = P_JSDITEMSEQ ;
  
	END IF ; 
  
END P1  ; 
  