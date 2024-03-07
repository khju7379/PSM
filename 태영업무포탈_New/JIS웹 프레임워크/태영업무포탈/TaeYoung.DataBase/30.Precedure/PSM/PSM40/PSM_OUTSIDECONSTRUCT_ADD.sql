--DROP PROCEDURE PSSCMLIB.PSM_OUTSIDECONSTRUCT_ADD;

CREATE PROCEDURE PSSCMLIB.PSM_OUTSIDECONSTRUCT_ADD 
(
	P_OSDATE	VARCHAR(8)    ,
	P_OSSEQ		NUMERIC(3, 0) ,
	P_OSLOCATIONCODE1 VARCHAR(10)   ,
	P_OSAREACODE1	  VARCHAR(9)    ,
	P_OSLOCATIONCODE2 VARCHAR(10)   ,
	P_OSAREACODE2	  VARCHAR(9)    ,
	P_OSLOCATIONCODE3 VARCHAR(10)   ,
	P_OSAREACODE3	  VARCHAR(9)    ,
	P_OSLOCATIONCODE4 VARCHAR(10)   ,
	P_OSAREACODE4	  VARCHAR(9)    ,
	P_OSLOCATIONCODE5 VARCHAR(10)   ,
	P_OSAREACODE5	  VARCHAR(9)    ,
	P_OSMETHODCODE	  VARCHAR(100)  ,
	P_OSCOMPANY	  VARCHAR(100)  ,
	P_OSBUSEO	  VARCHAR(6)    ,
	P_OSSABUN	  VARCHAR(6)    ,
	P_OSWKSDATE	 VARCHAR(8)    ,
	P_OSWKEDATE	 VARCHAR(8)    ,
	P_OSWKCLOSE	 VARCHAR(1)    ,
	P_OSWKCLDATE	 VARCHAR(8)    ,
	P_OSHISAB	 VARCHAR(6)    
)
	LANGUAGE SQL
P1: BEGIN
	
	IF NOT EXISTS(	SELECT OSDATE FROM PSSCMLIB.PSM_OUTSIDECONSTRUCT WHERE OSDATE = P_OSDATE AND OSSEQ = P_OSSEQ	) THEN

	   SELECT VALUE(MAX(OSSEQ),0) + 1
	     INTO P_OSSEQ
	    FROM PSSCMLIB.PSM_OUTSIDECONSTRUCT
		WHERE OSDATE = P_OSDATE;

		INSERT INTO  PSSCMLIB.PSM_OUTSIDECONSTRUCT
		(
			OSDATE		,
			OSSEQ		,
			OSLOCATIONCODE1 ,
			OSAREACODE1	,
			OSLOCATIONCODE2 ,
			OSAREACODE2	,
			OSLOCATIONCODE3 ,
			OSAREACODE3	,
			OSLOCATIONCODE4 ,
			OSAREACODE4	,
			OSLOCATIONCODE5 ,
			OSAREACODE5	,
			OSMETHODCODE,
			OSCOMPANY	,
			OSBUSEO		,
			OSSABUN		,
			OSWKSDATE	,
			OSWKEDATE	,
			OSWKCLOSE	,
			OSWKCLDATE	,
			OSHIGB		,
			OSHIDAT		,
			OSHITIM		,
			OSHISAB		
		)
		VALUES
		(
			P_OSDATE		,
			P_OSSEQ		,
			P_OSLOCATIONCODE1 ,
			P_OSAREACODE1	,
			P_OSLOCATIONCODE2 ,
			P_OSAREACODE2	,
			P_OSLOCATIONCODE3 ,
			P_OSAREACODE3	,
			P_OSLOCATIONCODE4 ,
			P_OSAREACODE4	,
			P_OSLOCATIONCODE5 ,
			P_OSAREACODE5	,
			P_OSMETHODCODE,
			P_OSCOMPANY	,
			P_OSBUSEO		,
			P_OSSABUN		,
			P_OSWKSDATE	,
			P_OSWKEDATE	,
			P_OSWKCLOSE	,
			P_OSWKCLDATE	,
			'A', CURRENT_DATE, CURRENT_TIME, P_OSHISAB
		);

	ELSE

		UPDATE PSSCMLIB.PSM_OUTSIDECONSTRUCT
		SET
			OSLOCATIONCODE1 = P_OSLOCATIONCODE1 ,     
			OSAREACODE1	= P_OSAREACODE1	,       
			OSLOCATIONCODE2 = P_OSLOCATIONCODE2 ,     
			OSAREACODE2	= P_OSAREACODE2	,       
			OSLOCATIONCODE3 = P_OSLOCATIONCODE3 ,     
			OSAREACODE3	= P_OSAREACODE3	,       
			OSLOCATIONCODE4 = P_OSLOCATIONCODE4 ,     
			OSAREACODE4	= P_OSAREACODE4	,       
			OSLOCATIONCODE5 = P_OSLOCATIONCODE5 ,     
			OSAREACODE5	= P_OSAREACODE5	,       
			OSMETHODCODE = P_OSMETHODCODE,         
			OSCOMPANY	 = P_OSCOMPANY	,       
			OSBUSEO		 = P_OSBUSEO		,
			OSSABUN		 = P_OSSABUN		,
			OSWKSDATE	 = P_OSWKSDATE	,       
			OSWKEDATE	 = P_OSWKEDATE	,       
			OSWKCLOSE	 = P_OSWKCLOSE	,       
			OSWKCLDATE	 = P_OSWKCLDATE	,       
			OSHIGB		 = 'C',                    
			OSHIDAT		 = CURRENT_DATE,           
			OSHITIM		 = CURRENT_TIME,           
			OSHISAB		 =  P_OSHISAB         
		WHERE OSDATE = P_OSDATE 
		  AND OSSEQ  = P_OSSEQ;

	END IF;

END P1