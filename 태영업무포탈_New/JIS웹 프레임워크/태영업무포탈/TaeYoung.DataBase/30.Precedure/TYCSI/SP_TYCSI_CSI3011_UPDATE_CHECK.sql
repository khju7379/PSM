   

--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_UPDATE_CHECK;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_UPDATE_CHECK ( 
	IN  P_JIYYMM NUMERIC(8, 0) ,
	IN  P_JISEQ NUMERIC(3, 0) ,
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
	DYNAMIC RESULT SETS 3
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI3011_UPDATE_CHECK 
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

      LIST1 : BEGIN  -- UTIORDERF CHECK

		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
			SELECT                           
			JIJANQTY,                        
			JIYYMM,                          
			JIIPHANG,                        
			JIBONSUN,                        
			JIHWAJU,                         
			JIHWAMUL,                        
			JIBLNO,                          
			JIMSNSEQ,                        
			JIHSNSEQ,                        
			JICUSTIL,                        
			JICHASU,                         
			JIACTHJ,                         
			JIJGHWAJU,                       
			JIYSHWAJU,                       
			JIYDHWAJU,                       
			JIYSDATE,                        
			JIYDSEQ,                         
			JIYSSEQ                          
			FROM TYSCMLIB.UTIORDERF         
			WHERE JIYYMM = P_JIYYMM
			AND JISEQ = P_JISEQ  ;

		OPEN REFCURSOR ;

	END LIST1 ; 

	LIST2 : BEGIN  -- GET JIJIQTY

			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR			
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
				FROM TYSCMLIB.UTIORDERF AS JISI                        
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

			OPEN REFCURSOR2 ;

	END LIST2 ; 

	LIST3 : BEGIN -- 
		
			DECLARE REFCURSOR3 CURSOR WITH RETURN FOR
				SELECT                            
				JIIPHANG,                         
				JIBONSUN,                         
				VSCODE.CDDESC1 AS VSDESC1,        
				JIHWAJU,                          
				VEND.VNSANGHO AS VEND,            
				JIHWAMUL,                         
				HMCODE.CDDESC1 AS HMDESC1,        
				JIBLNO,                           
				JIMSNSEQ,                         
				JIHSNSEQ,                         
				JIACTHJ,                          
				ACVEND.VNSANGHO AS ASVEND,        
				JICUSTIL,                         
				JICHASU,                          
				JIJGHWAJU,                        
				JGVEND.VNSANGHO AS JGVEND,        
				JIYSHWAJU,                        
				YSVEND.VNSANGHO AS YSVEND,        
				JIYDHWAJU,                        
				YDVEND.VNSANGHO AS YDVEND,        
				JIYSDATE,                         
				JIYDSEQ,                          
				JIYSSEQ,                          
				JICHHJ,                           
				DCCODE.CDDESC1 AS DCDESC1,        
				JITANKNO,                         
				JIIPTANK,                         
				JIIPQTY,                          
				JIJEQTY,                          
				JIJANQTY,                         
				JISTMTQTY,                        
				JIEDMTQTY,                        
				JISTLTQTY,                        
				JIEDLTQTY,                        
				JICHQTY,                          
				JIJIJAN,                          
				JIJANGB,                          
				JITRGUBN,                         
				JICARNO1,                         
				JICARNO2,                         
				JICHJANG,                         
				JICHTYPE,                         
				JIUNIT,                           
				JIWKTYPE,                         
				JIRACK,                           
				JIPUMP,                           
				JISINO1,                          
				JISINO2,                          
				JIORDNAME,                        
				JINAME,                           
				JIPHONE,                          
				JISEND,                           
				JICONTNUM,                        
				JISILNUM,                         
				JITMGUBN,                         
				JITIMEHH,                         
				JITIMEMM,                         
				JIDNST,                           
				DNCODE.CDINDEX AS DNDESC1,        
				CJJEQTY,                          
				JIHISAB,                          
				(SELECT COUNT(*) FROM TYSCMLIB.UTIJISIF JI   
				 WHERE JI.JIYYMM = ORDE.JISINO1              
				 AND   JI.JISEQ = ORDE.JISINO2 ) AS JISICNT, 
				(SELECT COUNT(*) FROM TYSCMLIB.UTICHULF      
				 WHERE DIGITS(CHJISINUM) = DIGITS(ORDE.JISINO1)||DIGITS(ORDE.JISINO2)  
				 AND   CHJISINUM > 0 )   AS CHULCNT         
				FROM TYSCMLIB.UTIORDERF AS ORDE             
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS VSCODE 
				ON             'VS' = VSCODE.CDINDEX        
				AND   ORDE.JIBONSUN = VSCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS HMCODE 
				ON             'HM' = HMCODE.CDINDEX        
				AND   ORDE.JIHWAMUL = HMCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS VEND   
				ON    ORDE.JIHWAJU  = VEND.VNCODE           
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS ACVEND 
				ON    ORDE.JIACTHJ  = ACVEND.VNCODE         
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS JGVEND 
				ON   ORDE.JIJGHWAJU = JGVEND.VNCODE         
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS YSVEND 
				ON   ORDE.JIYSHWAJU = YSVEND.VNCODE         
				LEFT OUTER JOIN TYSCMLIB.UTIVENDF AS YDVEND 
				ON   ORDE.JIYDHWAJU = YDVEND.VNCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DCCODE 
				ON             'DC' = DCCODE.CDINDEX        
				AND  ORDE.JICHHJ    = DCCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICODEF AS DNCODE 
				ON             'GS' = DNCODE.CDINDEX        
				AND   ORDE.JIDNST   = DNCODE.CDCODE         
				LEFT OUTER JOIN TYSCMLIB.UTICUHJF AS CUHJ   
				ON   CUHJ.CJIPHANG  = ORDE.JIIPHANG         
				AND  CUHJ.CJBONSUN  = ORDE.JIBONSUN         
				AND  CUHJ.CJHWAJU   = ORDE.JIHWAJU          
				AND  CUHJ.CJHWAMUL  = ORDE.JIHWAMUL         
				AND  CUHJ.CJBLNO    = ORDE.JIBLNO           
				AND  CUHJ.CJMSNSEQ  = ORDE.JIMSNSEQ         
				AND  CUHJ.CJHSNSEQ  = ORDE.JIHSNSEQ         
				AND  CUHJ.CJCUSTIL  = ORDE.JICUSTIL         
				AND  CUHJ.CJCHASU   = ORDE.JICHASU          
				AND  CUHJ.CJACTHJ   = ORDE.JIACTHJ          
				AND  CUHJ.CJJGHWAJU = ORDE.JIJGHWAJU        
				AND  CUHJ.CJYSHWAJU = ORDE.JIYSHWAJU        
				AND  CUHJ.CJYDHWAJU = ORDE.JIYDHWAJU        
				AND  CUHJ.CJYSDATE  = ORDE.JIYSDATE         
				AND  CUHJ.CJYDSEQ   = ORDE.JIYDSEQ          
				AND  CUHJ.CJYSSEQ   = ORDE.JIYSSEQ          
				WHERE JIYYMM  = P_JIYYMM
				AND   JISEQ   = P_JISEQ
				AND   JIJGHWAJU = P_JIACTHJ;

			OPEN REFCURSOR3 ;

	END LIST3; 

END MAIN ; 
END  ;





DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
			

OPEN REFCURSOR ;