DROP PROCEDURE PSSCMLIB.PSM_PSM4073_EXAM_CHECK_DETAIL_ADD;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4073_EXAM_CHECK_DETAIL_ADD ( 
	IN P_PECDTCTEAM  VARCHAR(6),
	IN P_PECDTCDATE  VARCHAR(8),
	IN P_PECDTCSEQ   NUMERIC(3,0),
	IN P_PECDGUBUN   VARCHAR(1),
	IN P_PECDDATE    VARCHAR(8),
	IN P_PECDSEQ     NUMERIC(3,0),
	IN P_PECDNUM     NUMERIC(3,0),
	IN P_PECDDESC    VARCHAR(300),
	IN P_PECDCHECK   VARCHAR(1),
	IN P_PECDHISAB   VARCHAR(6), 
	IN P_GUBUN       VARCHAR(1)) 
	LANGUAGE SQL 
	
	P1 : BEGIN 

	IF P_GUBUN = 'A' THEN

		INSERT INTO PSSCMLIB.PSM_EXAM_CHECK_DETAIL
		(
		PECDTCTEAM ,
		PECDTCDATE ,
		PECDTCSEQ   ,
		PECDGUBUN  ,
		PECDDATE    ,
		PECDSEQ      ,
		PECDNUM     ,
		PECDDESC    ,
		PECDCHECK  , 
		PECDHIGB     ,
		PECDHIDAT   ,
		PECDHITIM    ,
		PECDHISAB  
		)
		VALUES
		(
		P_PECDTCTEAM ,
		P_PECDTCDATE ,
		P_PECDTCSEQ   ,
		P_PECDGUBUN  ,
		P_PECDDATE    ,
		P_PECDSEQ      ,
		P_PECDNUM     ,
		P_PECDDESC    ,
		P_PECDCHECK  , 
		'A',
		CURRENT_DATE,
		CURRENT_TIME,
		P_PECDHISAB
		)
		;
  
	ELSE 
  
		UPDATE PSSCMLIB.PSM_EXAM_CHECK_DETAIL SET
		PECDDESC     = P_PECDDESC   ,
		PECDCHECK    = P_PECDCHECK ,
		PECDHIGB     = 'C'          ,
		PECDHIDAT    = CURRENT_DATE ,
		PECDHITIM    = CURRENT_TIME ,
		PECDHISAB    = P_PECDHISAB
		WHERE PECDTCTEAM = P_PECDTCTEAM
		AND   PECDTCDATE = P_PECDTCDATE
		AND   PECDTCSEQ  = P_PECDTCSEQ
		AND   PECDGUBUN  = P_PECDGUBUN
		AND   PECDDATE   = P_PECDDATE
		AND   PECDSEQ    = P_PECDSEQ
		AND   PECDNUM    = P_PECDNUM  ;
  
	END IF ; 
  
END P1  ; 
  