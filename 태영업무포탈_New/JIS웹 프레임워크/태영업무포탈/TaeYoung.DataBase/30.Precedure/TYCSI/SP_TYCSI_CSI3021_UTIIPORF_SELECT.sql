--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3021_UTIIPORF_SELECT;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3021_UTIIPORF_SELECT ( 
        IN P_IOIPDATE		NUMERIC(8, 0) ,   
	IN P_IOTKNO		NUMERIC(3, 0),
	IN P_IOHWAJU		VARCHAR(100)) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI3021_UTIIPORF_SELECT 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	CLOSQLCSR = *ENDMOD , 
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
			IOHWAJU,                            
			VEND.VNSANGHO,                      
			IOHWAMUL,                           
			HMCODE.CDDESC1 AS HMDESC1,          
			IOTANKNO,                           
			IOIPQTY,                            
			IOWKTYPE,                           
			IOCARNO,                            
			IOCONTAIN,                          
			IOSEALNUM,                          
			IOTMGUBN,                           
			DIGITS(IOIPTIME) AS IPTIME,         
			IODESC,                             
			(CASE WHEN IOJIDATE = 0 AND IOJISEQ = 0 THEN ''                     
			      ELSE DIGITS(IOJIDATE)||'-'||DIGITS(IOJISEQ) END) AS IOJIDATE,
			(CASE WHEN IPJI.IJIPDATE > 0 THEN             
				   (CASE WHEN   CHJI.CJIPQTY > 0 THEN 
					       '입고완료'             
					 WHEN   CHJI.CJEMPTY > 0 THEN 
					       '입고중'               
				    ELSE                              
					      '지시완료'              
				    END)                              
			 ELSE                                         
			     '대 기'                                  
			 END) AS JISTATUS,                                                 
			IOHISAB                                                            
			FROM TYSCMLIB.UTIIPORF AS IPOR                
			LEFT OUTER JOIN TYSCMLIB.UTIIPJIF AS IPJI     
			ON   DIGITS(IOIPDATE)||DIGITS(IOTKNO) = DIGITS(IJIPORNUM)            
			LEFT OUTER JOIN TYSCMLIB.UTICHJIF AS CHJI                            
			ON    DIGITS(IPJI.IJIPDATE)||DIGITS(IPJI.IJTKNO) = DIGITS(CJJISINO1) 
			LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND   
			ON    IPOR.IOHWAJU  = VEND.VNCODE           
			LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
			ON             'HM' = HMCODE.CDINDEX        
			AND   IPOR.IOHWAMUL = HMCODE.CDCODE         
			WHERE IOIPDATE = P_IOIPDATE
			AND   IOTKNO   = P_IOTKNO
			AND   IPOR.IOHWAJU IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(P_IOHWAJU AS VARCHAR(100)), ',')) AS InTable ) ;

		OPEN REFCURSOR ;

	END LIST ; 

END MAIN ; 
END  ;




