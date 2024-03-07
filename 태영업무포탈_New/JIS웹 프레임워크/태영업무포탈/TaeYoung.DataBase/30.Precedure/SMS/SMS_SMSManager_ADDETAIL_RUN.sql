--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SMS_SMSManager_ADDETAIL_RUN;
  
CREATE PROCEDURE TYJINFWLIB.SMS_SMSManager_ADDETAIL_RUN ( 
    IN P_ADDGROUP		VARCHAR(5) ,   
	IN P_ADDSABUN		VARCHAR(10)
	) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SMS_SMSManager_ADDETAIL_RUN 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	CLOSQLCSR = *ENDMOD , 
	DECRESULT = (31, 31, 00) , 
	DFTRDBCOL = TYSCMLIB , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 

  
MAIN : BEGIN  -- 실행부 

      LIST : BEGIN  -- 리스트 

		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
			SELECT   ADDSABUN, 
			         ADDGROUP, 
					 ADDTEAM, 
					 ADDNAME, 
					 ADDTEL, 
					 ADDEMAIL, 
					 ADDBIGO			      
			FROM TYSCMLIB.PSM_SMSManager_ADDETAIL 		     
			WHERE ADDGROUP  = P_ADDGROUP
			AND   ADDSABUN  = P_ADDSABUN;
			
		OPEN REFCURSOR ;

	END LIST ; 

END MAIN ; 
END  ;




