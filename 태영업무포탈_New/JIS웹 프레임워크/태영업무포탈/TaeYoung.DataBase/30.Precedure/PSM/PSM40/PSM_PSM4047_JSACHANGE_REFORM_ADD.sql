DROP PROCEDURE PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_ADD;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_ADD ( 
	IN P_JSEWKGUBN VARCHAR(1),
	IN P_JSEPOTEAM VARCHAR(6),
	IN P_JSEPODATE VARCHAR(8),
	IN P_JSEPOSEQ NUMERIC(3,0),
	IN P_JSEDATE VARCHAR(8),
	IN P_JSEMSEQ NUMERIC(3,0),
	IN P_JSEBLASS VARCHAR(2) , 
	IN P_JSEMLASS VARCHAR(2) , 
	IN P_JSESLASS VARCHAR(3) , 
	IN P_JSESEQ NUMERIC(3,0) , 
	IN P_JSEITEMSEQ NUMERIC(3,0) ,
	IN P_JSESUBSEQ NUMERIC(3,0),
	IN P_JSEREFORMTEXT VARCHAR(400),
	IN P_JSEREFORMCNT NUMERIC(1,0),
	IN P_JSEREFORMSOLID NUMERIC(1,0),
	IN P_JSEREFORMDEGREE NUMERIC(1,0),
	IN P_JSEHISAB VARCHAR(6),
	IN P_GUBUN VARCHAR (1)) 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_ADD 
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
  
		INSERT INTO PSSCMLIB.PSM_JSACHANGE_REFORM
		(
		JSEWKGUBN,
		JSEPOTEAM,
		JSEPODATE,
		JSEPOSEQ,
		JSEDATE,
		JSEMSEQ,
		JSEBLASS,
		JSEMLASS,
		JSESLASS,
		JSESEQ,
		JSEITEMSEQ,
		JSESUBSEQ,
		JSEREFORMTEXT,
		JSEREFORMCNT,
		JSEREFORMSOLID,
		JSEREFORMDEGREE,
		JSEHIGB,
		JSEHIDAT,
		JSEHITIM,
		JSEHISAB
		)
		VALUES
		(
		P_JSEWKGUBN,
		P_JSEPOTEAM,
		P_JSEPODATE,
		P_JSEPOSEQ,
		P_JSEDATE,
		P_JSEMSEQ,
		P_JSEBLASS,
		P_JSEMLASS,
		P_JSESLASS,
		P_JSESEQ,
		P_JSEITEMSEQ,
		P_JSESUBSEQ,
		P_JSEREFORMTEXT,
		P_JSEREFORMCNT,
		P_JSEREFORMSOLID,
		P_JSEREFORMDEGREE,
		'A',
		CURRENT_DATE,
		CURRENT_TIME,
		P_JSEHISAB
		);
  
	ELSE 
  
		UPDATE PSSCMLIB.PSM_JSACHANGE_REFORM SET
		JSEREFORMTEXT   = P_JSEREFORMTEXT,
		JSEREFORMCNT    = P_JSEREFORMCNT,
		JSEREFORMSOLID  = P_JSEREFORMSOLID,
		JSEREFORMDEGREE = P_JSEREFORMDEGREE,
		JSEHIGB         = 'C',
		JSEHIDAT        = CURRENT_DATE,
		JSEHITIM        = CURRENT_TIME,
		JSEHISAB        = P_JSEHISAB
		WHERE JSEWKGUBN  = P_JSEWKGUBN
		AND   JSEPOTEAM  = P_JSEPOTEAM
		AND   JSEPODATE  = P_JSEPODATE
		AND   JSEPOSEQ   = P_JSEPOSEQ
		AND   JSEDATE    = P_JSEDATE
		AND   JSEMSEQ    = P_JSEMSEQ  
		AND   JSEBLASS   = P_JSEBLASS
		AND   JSEMLASS   = P_JSEMLASS
		AND   JSESLASS   = P_JSESLASS
		AND   JSESEQ     = P_JSESEQ
		AND   JSEITEMSEQ = P_JSEITEMSEQ
		AND   JSESUBSEQ  = P_JSESUBSEQ ;
  
	END IF ; 
  
END P1  ; 
  