   

--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_INSERT_CHECK;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_INSERT_CHECK ( 
	IN  P_JIYYMM NUMERIC(8, 0) ,
	IN  P_JIIPHANG NUMERIC(8, 0) ,
	IN  P_JIBONSUN VARCHAR(3),
	IN  P_JIHWAJU VARCHAR(3),
	IN  P_JIHWAMUL VARCHAR(3),
	IN  P_JIBLNO VARCHAR(20),
	IN  P_JIMSNSEQ NUMERIC(4, 0),
	IN  P_JIHSNSEQ NUMERIC(4, 0),
	IN  P_JICUSTIL NUMERIC(8, 0),
	IN  P_JICHASU NUMERIC(3, 0),
	IN  P_JIACTHJ VARCHAR(3),
	IN  P_JIJGHWAJU VARCHAR(3),
	IN  P_JIYSHWAJU VARCHAR(3),
	IN  P_JIYDHWAJU VARCHAR(3),
	IN  P_JIYSDATE NUMERIC(8, 0),
	IN  P_JIYDSEQ NUMERIC(2, 0),
	IN  P_JIYSSEQ NUMERIC(2, 0)) 
	DYNAMIC RESULT SETS 2
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI3011_INSERT_CHECK 
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

      LIST1 : BEGIN  -- 리스트 

		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
			SELECT                          
			VALUE(SUM(A.JISTMTQTY),0) AS JISTMTQTY 
			FROM(                           
			SELECT                          
			JISI.JISTMTQTY,                   
			CASE WHEN JI.JIYYMM > 0 THEN    
			     CASE WHEN CHUL.CHMTQTY > 0 THEN 
			     '출고완료'                 
			     ELSE                       
			     '지시완료'                 
			     END                        
			ELSE                            
			'대기'                          
			END AS JISTATUS                 
			FROM TYSCMLIB.UTIORDERF         
			 AS JISI                        
			LEFT OUTER JOIN TYSCMLIB.UTIJISIF AS JI      
			ON   DIGITS( JI.JIYYMM)||DIGITS(JI.JISEQ) = DIGITS(JISI.JISINO1)||DIGITS(JISI.JISINO2) 
			AND  JI.JIYYMM > 0                           
			LEFT OUTER JOIN TYSCMLIB.UTICHULF AS CHUL    
			ON   DIGITS(CHUL.CHJISINUM) = DIGITS(JISI.JISINO1)||DIGITS(JISI.JISINO2)               
			AND  CHUL.CHJISINUM > 0                        
			WHERE JISI.JIYYMM    = P_JIYYMM
			AND   JISI.JIIPHANG  = P_JIIPHANG
			AND   JISI.JIBONSUN  = P_JIBONSUN
			AND   JISI.JIHWAJU   = P_JIHWAJU
			AND   JISI.JIHWAMUL  = P_JIHWAMUL
			AND   JISI.JIBLNO    = P_JIBLNO
			AND   JISI.JIMSNSEQ  = P_JIMSNSEQ
			AND   JISI.JIHSNSEQ  = P_JIHSNSEQ
			AND   JISI.JICUSTIL  = P_JICUSTIL
			AND   JISI.JICHASU   = P_JICHASU
			AND   JISI.JIACTHJ   = P_JIACTHJ
			AND   JISI.JIJGHWAJU = P_JIJGHWAJU
			AND   JISI.JIYSHWAJU = P_JIYSHWAJU
			AND   JISI.JIYDHWAJU = P_JIYDHWAJU
			AND   JISI.JIYSDATE  = P_JIYSDATE
			AND   JISI.JIYDSEQ   = P_JIYDSEQ
			AND   JISI.JIYSSEQ   = P_JIYSSEQ
			) AS A                              
			WHERE A.JISTATUS <> '출고완료'   ;

		OPEN REFCURSOR ;

	END LIST1 ; 

	LIST2 : BEGIN  -- 페이징 					

			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR			
				SELECT                           
				JIIPHANG,                        
				JIBONSUN,                        
				JIHWAJU,                         
				JIACTHJ,                         
				JIHWAMUL,                        
				JITANKNO,                        
				JIIPTANK,                        
				JICHHJ,                          
				JICARNO2,                        
				JISEQ,                           
				JIBLNO,                          
				JIMSNSEQ,                        
				JIHSNSEQ,                        
				JICUSTIL,                        
				JICHASU,                         
				JIJGHWAJU,                       
				JIYSHWAJU,                       
				JIYDHWAJU,                       
				JIYSDATE,                        
				JIYDSEQ,                         
				JIYSSEQ                          
				FROM TYSCMLIB.UTIORDERF          
				WHERE JIYYMM = P_JIYYMM;

			OPEN REFCURSOR2 ;

	END LIST2 ; 

END MAIN ; 
END  ;





DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
			

		OPEN REFCURSOR ;