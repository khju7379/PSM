   

--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_JEGO_CHECK;
  
CREATE PROCEDURE TYJINFWLIB.SP_TYCSI_CSI3011_JEGO_CHECK ( 
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
	IN  P_JIYSSEQ NUMERIC(2, 0),
	IN  P_JITANKNO VARCHAR(4),
	IN  P_JIIPTANK VARCHAR(4),
	IN  P_JICARNO2 VARCHAR(20)) 
	DYNAMIC RESULT SETS 11
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSI_CSI3011_JEGO_CHECK 
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

      LIST1 : BEGIN  -- 입고파일 체크

		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
			SELECT                                    
			IPMTQTY,                                  
			IPPAQTY,                                  
			IPCHQTY,                                  
			(IPPAQTY - IPCHQTY) AS IPJEQTY,           
			(IPMTQTY - IPPAQTY) AS IPJANQTY           
			FROM TYSCMLIB.UTIIPGOF AS IPGO           
			WHERE IPGO.IPIPHANG = P_JIIPHANG
			AND   IPGO.IPBONSUN = P_JIBONSUN
			AND   IPGO.IPHWAJU  = P_JIHWAJU
			AND   IPGO.IPHWAMUL = P_JIHWAMUL
			AND   IPGO.IPBLNO   = P_JIBLNO
			AND   IPGO.IPMSNSEQ = P_JIMSNSEQ
			AND   IPGO.IPHSNSEQ = P_JIHSNSEQ;

		OPEN REFCURSOR ;

	END LIST1 ; 

	LIST2 : BEGIN  -- 이전 HSN 데이터 체크

		DECLARE REFCURSOR2 CURSOR WITH RETURN FOR			
			SELECT 
			VALUE(SUM(IPMTQTY),0) AS IPMTQTY 
			FROM TYSCMLIB.UTIIPGOF          
			WHERE IPIPHANG   = P_JIIPHANG  
			AND   IPBONSUN   = P_JIBONSUN
			AND   IPHWAJU    = P_JIHWAJU
			AND   IPHWAMUL   = P_JIHWAMUL
			AND   IPBLNO     = P_JIBLNO
			AND   IPMSNSEQ   = P_JIMSNSEQ
			AND   IPJNHSNSEQ = P_JIHSNSEQ
			AND   IPCHGUBN   = 'Y'                 ;

		OPEN REFCURSOR2 ;

	END LIST2 ; 

	LIST3 : BEGIN -- 이고여부 체크
		
		DECLARE REFCURSOR3 CURSOR WITH RETURN FOR
			SELECT       
			SVMOGB       
			FROM TYSCMLIB.UTISURVF 
			WHERE SVIPHANG = P_JIIPHANG
			AND   SVBONSUN = P_JIBONSUN
			AND   SVHWAJU  = P_JIHWAJU
			AND   SVHWAMUL = P_JIHWAMUL
			AND   SVTANKNO = P_JITANKNO
			AND   SVMOGB   = ''                        
			AND   (SVMTQTY - SVCHULQTY) > 0          ;  

		OPEN REFCURSOR3 ;

	END LIST3; 

	LIST4 : BEGIN -- 차량번호 체크
		
		DECLARE REFCURSOR4 CURSOR WITH RETURN FOR
			SELECT TRNUMNO2 AS NAME 
			FROM   TYSCMLIB.UTATRUKF
			WHERE  TRIM((TRIM(TRNUMNO1)||''||TRIM(TRNUMNO2))) = P_JICARNO2       ;  

		OPEN REFCURSOR4 ;

	END LIST4; 

	LIST5: BEGIN -- 입고화물 체크
		
		DECLARE REFCURSOR5 CURSOR WITH RETURN FOR
			SELECT                                
			*                                     
			FROM TYSCMLIB.UTICMDTF               
			WHERE CMIPHANG  = P_JIIPHANG
			AND   CMBONSUN  = P_JIBONSUN
			AND   CMHWAJU   = P_JIHWAJU
			AND   CMHWAMUL  = P_JIHWAMUL;  

		OPEN REFCURSOR5 ;

	END LIST5; 

	LIST6: BEGIN -- 입고 체크
		
		DECLARE REFCURSOR6 CURSOR WITH RETURN FOR
			SELECT                               
			*                                    
			FROM TYSCMLIB.UTIIPGOF              
			WHERE IPIPHANG = P_JIIPHANG
			AND   IPBONSUN = P_JIBONSUN
			AND   IPHWAJU  = P_JIHWAJU
			AND   IPHWAMUL = P_JIHWAMUL
			AND   IPBLNO   = P_JIBLNO
			AND   IPMSNSEQ = P_JIMSNSEQ
			AND   IPHSNSEQ = P_JIHSNSEQ;  

		OPEN REFCURSOR6 ;

	END LIST6; 

	LIST7: BEGIN -- SURVEY 체크
		
		DECLARE REFCURSOR7 CURSOR WITH RETURN FOR
			SELECT                                
			(SVMTQTY - SVCHULQTY) AS JEGO         
			FROM TYSCMLIB.UTISURVF                
			WHERE SVIPHANG  = P_JIIPHANG
			AND   SVBONSUN  = P_JIBONSUN
			AND   SVHWAJU   = P_JIHWAJU
			AND   SVHWAMUL  = P_JIHWAMUL
			AND   SVTANKNO  = P_JITANKNO
			AND   (SVMTQTY - SVCHULQTY) > 0             ;  

		OPEN REFCURSOR7 ;

	END LIST7; 

	LIST8: BEGIN -- 매출입고할증 체크
		
		DECLARE REFCURSOR8 CURSOR WITH RETURN FOR
			SELECT                                
			(COMTQTY - COCHQTY) AS JEGO           
			FROM TYSCMLIB.UTICOMEF                
			WHERE COIPHANG  = P_JIIPHANG
			AND   COBONSUN  = P_JIBONSUN
			AND   COHWAJU   = P_JIHWAJU
			AND   COHWAMUL  = P_JIHWAMUL
			AND   COTANKNO  = P_JIIPTANK
			AND   (COMTQTY - COCHQTY) > 0             ;  

		OPEN REFCURSOR8 ;

	END LIST8; 

	LIST9: BEGIN -- 통관파일 체크
		
		DECLARE REFCURSOR9 CURSOR WITH RETURN FOR
			SELECT                               
			CSACTHJ,                             
			CSBANGB,                             
			CSCUQTY,                             
			CSCHQTY,                             
			(CSCUQTY - CSCHQTY) AS CJJEQTY       
			FROM TYSCMLIB.UTICUSTF              
			WHERE CSIPHANG = P_JIIPHANG
			AND   CSBONSUN = P_JIBONSUN
			AND   CSHWAJU  = P_JIHWAJU
			AND   CSHWAMUL = P_JIHWAMUL
			AND   CSBLNO   = P_JIBLNO
			AND   CSMSNSEQ = P_JIMSNSEQ
			AND   CSHSNSEQ = P_JIHSNSEQ
			AND   CSCUSTIL = P_JICUSTIL
			AND   CSCHASU  = P_JICHASU           ;  

		OPEN REFCURSOR9 ;

	END LIST9; 

	LIST10: BEGIN -- 통관화주 체크
		
		DECLARE REFCURSOR10 CURSOR WITH RETURN FOR
			SELECT                                 
			CJJGHWAJU,                             
			CJJEQTY                                
			FROM TYSCMLIB.UTICUHJF                 
			WHERE CJACTHJ   = P_JIACTHJ
			AND   CJJGHWAJU = P_JIJGHWAJU
			AND   CJIPHANG  = P_JIIPHANG
			AND   CJBONSUN  = P_JIBONSUN
			AND   CJHWAJU   = P_JIHWAJU
			AND   CJHWAMUL  = P_JIHWAMUL
			AND   CJBLNO    = P_JIBLNO
			AND   CJMSNSEQ  = P_JIMSNSEQ
			AND   CJHSNSEQ  = P_JIHSNSEQ
			AND   CJCUSTIL  = P_JICUSTIL
			AND   CJCHASU   = P_JICHASU
			AND   CJYSHWAJU = P_JIYSHWAJU
			AND   CJYDHWAJU = P_JIYDHWAJU
			AND   CJYSDATE  = P_JIYSDATE
			AND   CJYDSEQ   = P_JIYDSEQ
			AND   CJYSSEQ   = P_JIYSSEQ      ;  

		OPEN REFCURSOR10 ;

	END LIST10; 

	LIST11: BEGIN -- 양수도 체크
		
		DECLARE REFCURSOR11 CURSOR WITH RETURN FOR
			SELECT                       
			*                            
			FROM TYSCMLIB.UTIYANGF       
			WHERE YNIPHANG  = P_JIIPHANG
			AND   YNBONSUN  = P_JIBONSUN
			AND   YNHWAJU   = P_JIHWAJU
			AND   YNHWAMUL  = P_JIHWAMUL
			AND   YNBLNO    = P_JIBLNO
			AND   YNMSNSEQ  = P_JIMSNSEQ
			AND   YNHSNSEQ  = P_JIHSNSEQ
			AND   YNCUSTIL  = P_JICUSTIL
			AND   YNCHASU   = P_JICHASU
			AND   YNACTHJ   = P_JIACTHJ
			AND   YNYDHWAJU = P_JIYDHWAJU
			AND   YNYSHWAJU = P_JIYSHWAJU
			AND   YNYSDATE  = P_JIYSDATE
			AND   YNYDSEQ   = P_JIYDSEQ
			AND   YNYSSEQ   = P_JIYSSEQ;  

		OPEN REFCURSOR11 ;

	END LIST11; 
	             

END MAIN ; 
END  ;





DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
			

OPEN REFCURSOR ;