DROP PROCEDURE PSSCMLIB.PSM_PSM2011_BOARD_MAST_ADD;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM2011_BOARD_MAST_ADD ( 
	IN P_PBMCNTCODE VARCHAR(2) , 
	IN P_PBMLCODE VARCHAR(3) , 
	IN P_PBMMCODE VARCHAR(3) , 
	IN P_PBMSCODE VARCHAR(3) , 
	IN P_PBMNUM NUMERIC(3,0) , 
	IN P_PBMPUDATE VARCHAR(8),
	IN P_PBMPUSABUN VARCHAR(6),
	IN P_PBMTITLE VARCHAR(100),
	IN P_PBMHISAB VARCHAR(6),
	IN P_PBDMODESC VARCHAR(100),
	IN P_PBDMOSABUN VARCHAR(6),
	IN P_PBDMODATE VARCHAR(8),
	IN P_GUBUN VARCHAR (1)) 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM2011_BOARD_MAST_ADD 
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

	DECLARE V_PBDMOSEQ NUMERIC(3,0) ; 
	 
	IF P_GUBUN = 'A' THEN
  
		INSERT INTO PSSCMLIB.PSM_BOARD_MAST
		(
		PBMCNTCODE ,
		PBMLCODE  ,
		PBMMCODE  ,
		PBMSCODE  ,
		PBMNUM    ,
		PBMPUDATE ,
		PBMPUSABUN,
		PBMTITLE  ,
		PBMHIGB   ,
		PBMHIDAT  ,
		PBMHITIM  ,
		PBMHISAB  
		)
		VALUES
		(
		P_PBMCNTCODE ,
		P_PBMLCODE  ,
		P_PBMMCODE  ,
		P_PBMSCODE  ,
		P_PBMNUM    ,
		P_PBMPUDATE ,
		P_PBMPUSABUN,
		P_PBMTITLE  ,
		'A',
		CURRENT_DATE,
		CURRENT_TIME,
		P_PBMHISAB
		);
  
	ELSE 
  
		UPDATE PSSCMLIB.PSM_BOARD_MAST SET
		PBMPUDATE = P_PBMPUDATE,
		PBMPUSABUN = P_PBMPUSABUN,
		PBMTITLE = P_PBMTITLE,
		PBMHIGB     = 'C',
		PBMHIDAT    = CURRENT_DATE,
		PBMHITIM    = CURRENT_TIME,
		PBMHISAB    = P_PBMHISAB
		WHERE PBMCNTCODE = P_PBMCNTCODE
		AND   PBMLCODE   = P_PBMLCODE
		AND   PBMMCODE   = P_PBMMCODE
		AND   PBMSCODE   = P_PBMSCODE
		AND   PBMNUM     = P_PBMNUM ;
		
		--SELECT   VALUE(MAX(PBDMOSEQ), 0) + 1 INTO V_PBDMOSEQ
		--FROM PSSCMLIB.PSM_BOARD_DETAIL
		--WHERE PBDLCODE   = P_PBMLCODE
		--AND   PBDMCODE   = P_PBMMCODE
		--AND   PBDSCODE   = P_PBMSCODE 
		--AND   PBDNUM   = P_PBMNUM ;

		--INSERT INTO PSSCMLIB.PSM_BOARD_DETAIL
		--(
		--PBDLCODE  ,
		--PBDMCODE  ,
		--PBDSCODE  ,
		--PBDNUM    ,
		--PBDMOSEQ  ,	
		--PBDMOSABUN,
		--PBDMODESC ,
		--PBDMODATE ,
		--PBDHIGB   ,
		--PBDHIDAT  ,
		--PBDHITIM  ,
		--PBDHISAB  
		--)
		--VALUES
		--(
		--P_PBMLCODE  ,
		--P_PBMMCODE  ,
		--P_PBMSCODE  ,
		--P_PBMNUM    ,
		--V_PBDMOSEQ ,
		--P_PBDMOSABUN ,
		--P_PBDMODESC ,
		--P_PBDMODATE ,
		--'A',
		--CURRENT_DATE,
		--CURRENT_TIME,
		--P_PBMHISAB
		--);
  
	END IF ; 
  
END P1  ; 
  
  
