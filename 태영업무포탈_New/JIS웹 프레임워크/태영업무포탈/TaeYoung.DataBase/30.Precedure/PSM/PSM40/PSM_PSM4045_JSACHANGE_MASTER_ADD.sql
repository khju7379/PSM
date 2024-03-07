DROP PROCEDURE PSSCMLIB.PSM_PSM4045_JSACHANGE_MASTER_ADD;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4045_JSACHANGE_MASTER_ADD ( 
	IN P_JSMWKGUBN   VARCHAR(1),
	IN P_JSMPOTEAM   VARCHAR(6),
	IN P_JSMPODATE   VARCHAR(8),
	IN P_JSMPOSEQ   NUMERIC(3,0),
	IN P_JSMDATE   VARCHAR(8),
	IN P_JSMMSEQ   NUMERIC(3,0),
	IN P_JSMBLASS VARCHAR(2) , 
	IN P_JSMMLASS VARCHAR(2) , 
	IN P_JSMSLASS VARCHAR(3) , 
	IN P_JSMSEQ NUMERIC(3,0) , 
	IN P_JSMWKNAME VARCHAR(400) , 
	IN P_JSMSYSTEM VARCHAR(200) , 
	IN P_JSMWKDATE VARCHAR(8) , 
	IN P_JSMADDATE VARCHAR(8) , 
	IN P_JSMADCHASU VARCHAR(3) , 
	IN P_JSMWKSABUN VARCHAR(6) , 
	IN P_JSMSANAME VARCHAR(200) , 
	IN P_JSMSECTIONNUM VARCHAR(20) , 
	IN P_JSMMSDSCODE VARCHAR(3) , 
	IN P_JSMMSDSSEQ NUMERIC(3,0) , 
	IN P_JSMWKSUMMARY VARCHAR(500) , 
	IN P_JSMNEEDDATA VARCHAR(400) , 
	IN P_JSMRISKCASE VARCHAR(400) , 
	IN P_JSMSELFNAME1 VARCHAR(50) , 
	IN P_JSMSELFTEXT1 VARCHAR(100) , 
	IN P_JSMSELFNAME2 VARCHAR(50) , 
	IN P_JSMSELFTEXT2 VARCHAR(100) , 
	IN P_JSMSELFNAME3 VARCHAR(50) , 
	IN P_JSMSELFTEXT3 VARCHAR(100) , 
	IN P_JSMSELFNAME4 VARCHAR(50) , 
	IN P_JSMSELFTEXT4 VARCHAR(100) , 
	IN P_JSMSELFNAME5 VARCHAR(50) , 
	IN P_JSMSELFTEXT5 VARCHAR(100) , 
	IN P_JSMSCOMNAME1 VARCHAR(50) , 
	IN P_JSMSCOMTEXT1 VARCHAR(100) , 
	IN P_JSMSCOMNAME2 VARCHAR(50) , 
	IN P_JSMSCOMTEXT2 VARCHAR(100) , 
	IN P_JSMHISAB VARCHAR(6),
	IN P_GUBUN VARCHAR(1)) 
	LANGUAGE SQL 
	
	P1 : BEGIN 
	 
	IF P_GUBUN = 'A' THEN
  
		INSERT INTO PSSCMLIB.PSM_JSACHANGE_MASTER
		(
		JSMWKGUBN,
		JSMPOTEAM,
		JSMPODATE,
		JSMPOSEQ,
		JSMDATE,
		JSMMSEQ,
		JSMBLASS     ,
		JSMMLASS     ,
		JSMSLASS     ,
		JSMSEQ       ,
		JSMWKNAME    ,
		JSMSYSTEM    ,
		JSMWKDATE    ,
		JSMADDATE    ,
		JSMADCHASU   ,
		JSMWKSABUN   ,
		JSMSANAME    ,
		JSMSECTIONNUM,
		JSMMSDSCODE  ,
		JSMMSDSSEQ   ,
		JSMWKSUMMARY ,
		JSMNEEDDATA  ,
		JSMRISKCASE  ,
		JSMSELFNAME1 ,
		JSMSELFTEXT1 ,
		JSMSELFNAME2 ,
		JSMSELFTEXT2 ,
		JSMSELFNAME3 ,
		JSMSELFTEXT3 ,
		JSMSELFNAME4 ,
		JSMSELFTEXT4 ,
		JSMSELFNAME5 ,
		JSMSELFTEXT5 ,
		JSMSCOMNAME1 ,
		JSMSCOMTEXT1 ,
		JSMSCOMNAME2 ,
		JSMSCOMTEXT2 ,
		JSMHIGB      ,
		JSMHIDAT     ,
		JSMHITIM     ,
		JSMHISAB
		)
		VALUES
		(
		P_JSMWKGUBN,
		P_JSMPOTEAM,
		P_JSMPODATE,
		P_JSMPOSEQ,
		P_JSMDATE,
		P_JSMMSEQ,
		P_JSMBLASS     ,
		P_JSMMLASS     ,
		P_JSMSLASS     ,
		P_JSMSEQ       ,
		P_JSMWKNAME    ,
		P_JSMSYSTEM    ,
		P_JSMWKDATE    ,
		P_JSMADDATE    ,
		P_JSMADCHASU   ,
		P_JSMWKSABUN   ,
		P_JSMSANAME    ,
		P_JSMSECTIONNUM,
		P_JSMMSDSCODE  ,
		P_JSMMSDSSEQ   ,
		P_JSMWKSUMMARY ,
		P_JSMNEEDDATA  ,
		P_JSMRISKCASE  ,
		P_JSMSELFNAME1 ,
		P_JSMSELFTEXT1 ,
		P_JSMSELFNAME2 ,
		P_JSMSELFTEXT2 ,
		P_JSMSELFNAME3 ,
		P_JSMSELFTEXT3 ,
		P_JSMSELFNAME4 ,
		P_JSMSELFTEXT4 ,
		P_JSMSELFNAME5 ,
		P_JSMSELFTEXT5 ,
		P_JSMSCOMNAME1 ,
		P_JSMSCOMTEXT1 ,
		P_JSMSCOMNAME2 ,
		P_JSMSCOMTEXT2 ,
		'A',
		CURRENT_DATE,
		CURRENT_TIME,
		P_JSMHISAB
		);
  
	ELSE 
  
		UPDATE PSSCMLIB.PSM_JSACHANGE_MASTER SET
		JSMWKNAME     = P_JSMWKNAME,
		JSMSYSTEM     = P_JSMSYSTEM,
		JSMWKDATE     = P_JSMWKDATE,
		JSMADDATE     = P_JSMADDATE,
		JSMADCHASU    = P_JSMADCHASU,
		JSMWKSABUN    = P_JSMWKSABUN,
		JSMSANAME     = P_JSMSANAME,
		JSMSECTIONNUM = P_JSMSECTIONNUM,
		JSMMSDSCODE   = P_JSMMSDSCODE,
		JSMMSDSSEQ    = P_JSMMSDSSEQ,
		JSMWKSUMMARY  = P_JSMWKSUMMARY,
		JSMNEEDDATA   = P_JSMNEEDDATA,
		JSMRISKCASE   = P_JSMRISKCASE,
		JSMSELFNAME1  = P_JSMSELFNAME1,
		JSMSELFTEXT1  = P_JSMSELFTEXT1,
		JSMSELFNAME2  = P_JSMSELFNAME2,
		JSMSELFTEXT2  = P_JSMSELFTEXT2,
		JSMSELFNAME3  = P_JSMSELFNAME3,
		JSMSELFTEXT3  = P_JSMSELFTEXT3,
		JSMSELFNAME4  = P_JSMSELFNAME4,
		JSMSELFTEXT4  = P_JSMSELFTEXT4,
		JSMSELFNAME5  = P_JSMSELFNAME5,
		JSMSELFTEXT5  = P_JSMSELFTEXT5,
		JSMSCOMNAME1  = P_JSMSCOMNAME1,
		JSMSCOMTEXT1  = P_JSMSCOMTEXT1,
		JSMSCOMNAME2  = P_JSMSCOMNAME2,
		JSMSCOMTEXT2  = P_JSMSCOMTEXT2,
		JSMHIGB       = 'C',
		JSMHIDAT      = CURRENT_DATE,
		JSMHITIM      = CURRENT_TIME,
		JSMHISAB      = P_JSMHISAB
		WHERE JSMWKGUBN = P_JSMWKGUBN
		AND   JSMPOTEAM = P_JSMPOTEAM
		AND   JSMPODATE = P_JSMPODATE
		AND   JSMPOSEQ  = P_JSMPOSEQ
		AND   JSMDATE   = P_JSMDATE
		AND   JSMMSEQ   = P_JSMMSEQ
		AND   JSMBLASS  = P_JSMBLASS
		AND   JSMMLASS  = P_JSMMLASS
		AND   JSMSLASS  = P_JSMSLASS
		AND   JSMSEQ    = P_JSMSEQ ;
  
	END IF ; 
  
END P1  ; 
  