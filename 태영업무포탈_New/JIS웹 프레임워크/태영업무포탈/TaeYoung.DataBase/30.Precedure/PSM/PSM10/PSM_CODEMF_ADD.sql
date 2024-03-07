--DROP PROCEDURE TYJINFWLIB.PSM_CODEMF_ADD;

CREATE PROCEDURE TYJINFWLIB.PSM_CODEMF_ADD 
(
	  P_CDINDEX       VARCHAR (10) 
	, P_CDCODE        VARCHAR (10) 
	, P_CDDESC1       VARCHAR (100) 
	, P_CDDESC2       VARCHAR (100) 
	, P_CDBIGO       VARCHAR (100) 
	, P_CDHISAB       VARCHAR (10) 
)
	LANGUAGE SQL
P1: BEGIN
	
	IF NOT EXISTS(	SELECT CDINDEX FROM TYSCMLIB.PSM_CODEMF WHERE CDINDEX=P_CDINDEX AND CDCODE=P_CDCODE	) THEN

		INSERT INTO  TYSCMLIB.PSM_CODEMF 
		(
			CDINDEX, CDCODE, CDDESC1, CDDESC2, CDBIGO, CDHIGB, CDHIDAT, CDHITIM, CDHISAB   
		)
		VALUES
		(
			P_CDINDEX, P_CDCODE, P_CDDESC1, P_CDDESC2, P_CDBIGO, 'A', CURRENT_DATE, CURRENT_TIME, P_CDHISAB   
		);

	ELSE

		UPDATE TYSCMLIB.PSM_CODEMF 
		SET
			CDDESC1 = P_CDDESC1, 
			CDDESC2 = P_CDDESC2, 
			CDBIGO  = P_CDBIGO,
			CDHIGB  = 'C' ,
			CDHIDAT = CURRENT_DATE, 
			CDHITIM = CURRENT_TIME, 
			CDHISAB = P_CDHISAB
		WHERE CDINDEX= P_CDINDEX 
			AND CDCODE=P_CDCODE;

	END IF;

END P1