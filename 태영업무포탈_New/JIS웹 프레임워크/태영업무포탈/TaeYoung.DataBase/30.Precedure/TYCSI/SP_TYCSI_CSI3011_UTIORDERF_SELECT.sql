--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_UTIORDERF_SELECT;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_UTIORDERF_SELECT ( 
        IN P_JIYYMM		NUMERIC(8, 0) ,   
	IN P_JISEQ		NUMERIC(3, 0),
	IN P_JIJGHWAJU		VARCHAR(100)) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI3011_UTIORDERF_SELECT 
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
			 AND   CHJISINUM > 0 )   AS CHULCNT,
			( SELECT COALESCE(SUM(JICHQTY),0) FROM TYSCMLIB.UTIJISIF JI 
			 WHERE  JI.JIYYMM = ORDE .JISINO1             
			 AND     JI.JISEQ = ORDE .JISINO2 ) AS SUMCHQTY
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
			AND   JIJGHWAJU IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(P_JIJGHWAJU AS VARCHAR(100)), ',')) AS InTable ) ;

		OPEN REFCURSOR ;

	END LIST ; 

END MAIN ; 
END  ;




