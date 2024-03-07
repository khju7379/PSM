--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_GET_LASTSAB;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_GET_LASTSAB ( 
	IN P_HWAJU    VARCHAR(3))  
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI3011_GET_LASTSAB 
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
			JIHISAB,                         
			JIORDNAME,                       
			JITMGUBN,                       
			JIWKTYPE,                       
			JISEQ,
			JINAME,
			JIPHONE,
			JISEND             ,
			EMSABUN              
			FROM TYSCMLIB.UTIORDERF 
			LEFT OUTER JOIN TYSCMLIB.WEDIUSEF 
			ON   EMHWAJU = JIHWAJU
			WHERE JIHWAJU  = P_HWAJU 
			ORDER BY JIYYMM DESC       
			FETCH FIRST 1 ROWS ONLY                    ;

		OPEN REFCURSOR ;

	END LIST ; 

END MAIN ; 
END  ;



    