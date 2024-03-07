DROP PROCEDURE PSSCMLIB.PSM_Plants_GetWorkingData_Run;

CREATE PROCEDURE PSSCMLIB.PSM_Plants_GetWorkingData_Run
( 
	P_C2SAUP     VARCHAR(1),
	P_CODE     VARCHAR(10)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR	
	
        
        WITH TABLE1 AS (							
	SELECT  
	    SMWKTEAM||'-'||SMWKDATE||'-'||DIGITS(SMWKSEQ) AS PONUM, --요청번호
            SMWKORAPPDATE,  --허가일자
            DIGITS(SMWKORSEQ) AS SMWKORSEQ, --허가순번
            WOWORKTITLE AS SMAREATEXT1, --작업내용            
            SMREVTEAM,  --작업부서
            TYSCMLIB.SF_GB_ORGNAME( SMREVTEAM,SMWKDATE) AS SMREVTEAMNM, --작업부서명
            PSSCMLIB.SF_PSM_SAFEMETHOD( SMWKTEAM||SMWKDATE||DIGITS(SMWKSEQ), SMWKORAPPDATE||DIGITS(SMWKORSEQ), 'CODE') AS SMMETHODCODE, --작업구분코드
            PSSCMLIB.SF_PSM_SAFEMETHOD( SMWKTEAM||SMWKDATE||DIGITS(SMWKSEQ), SMWKORAPPDATE||DIGITS(SMWKORSEQ), 'NAME') AS SMMETHODCODENM,--작업구분명          
            SMWKMETHOD,  --작업방법코드
            CASE WHEN SMWKMETHOD = '1' THEN '자체' 
            ELSE '외주' ||'('||SMSUBVEND||')' END AS SMWKMETHODNM, --작업방법
            SMRESSABUN,  --작업자사번
            SMORNAME AS SMRESSABUNNM, --작업자이름    
	    
	    CASE WHEN SUBSTR(SMSYSTEMCODE1,1,7) = SUBSTR(P_CODE, 1, 7) THEN SMSYSTEMCODE1
		 WHEN SUBSTR(SMSYSTEMCODE2,1,7) = SUBSTR(P_CODE, 1, 7) THEN SMSYSTEMCODE2
		 WHEN SUBSTR(SMSYSTEMCODE3,1,7) = SUBSTR(P_CODE, 1, 7) THEN SMSYSTEMCODE3
		 WHEN SUBSTR(SMSYSTEMCODE4,1,7) = SUBSTR(P_CODE, 1, 7) THEN SMSYSTEMCODE4
		 WHEN SUBSTR(SMSYSTEMCODE5,1,7) = SUBSTR(P_CODE, 1, 7) THEN SMSYSTEMCODE5
	    ELSE '' END SMSYSTEMCODE,

	    CASE WHEN SUBSTR(SMSYSTEMCODE1,1,7) = SUBSTR(P_CODE, 1, 7) THEN S1.FXC3DESC
		 WHEN SUBSTR(SMSYSTEMCODE2,1,7) = SUBSTR(P_CODE, 1, 7) THEN S2.FXC3DESC
		 WHEN SUBSTR(SMSYSTEMCODE3,1,7) = SUBSTR(P_CODE, 1, 7) THEN S3.FXC3DESC
		 WHEN SUBSTR(SMSYSTEMCODE4,1,7) = SUBSTR(P_CODE, 1, 7) THEN S4.FXC3DESC
		 WHEN SUBSTR(SMSYSTEMCODE5,1,7) = SUBSTR(P_CODE, 1, 7) THEN S5.FXC3DESC
	    ELSE '' END SMSYSTEMCODENM,
	    
	    CASE WHEN SMAREACODE1 = P_CODE THEN SMAREACODE1
		 WHEN SMAREACODE2 = P_CODE THEN SMAREACODE2
		 WHEN SMAREACODE3 = P_CODE THEN SMAREACODE3
		 WHEN SMAREACODE4 = P_CODE THEN SMAREACODE4
		 WHEN SMAREACODE5 = P_CODE THEN SMAREACODE5 
	    ELSE '' END AS SMAREACODE,

	    CASE WHEN SMAREACODE1 = P_CODE THEN L1.L3NAME
		 WHEN SMAREACODE2 = P_CODE THEN L2.L3NAME
		 WHEN SMAREACODE3 = P_CODE THEN L3.L3NAME
		 WHEN SMAREACODE4 = P_CODE THEN L4.L3NAME
		 WHEN SMAREACODE5 = P_CODE THEN L5.L3NAME 
	    ELSE '' END AS SMAREACODENM,

	    CASE WHEN SMCONNCODE11 = P_CODE THEN SMCONNCODE11
		 WHEN SMCONNCODE12 = P_CODE THEN SMCONNCODE12
		 WHEN SMCONNCODE21 = P_CODE THEN SMCONNCODE21
		 WHEN SMCONNCODE22 = P_CODE THEN SMCONNCODE22
		 WHEN SMCONNCODE31 = P_CODE THEN SMCONNCODE31
		 WHEN SMCONNCODE32 = P_CODE THEN SMCONNCODE32
		 WHEN SMCONNCODE41 = P_CODE THEN SMCONNCODE41
		 WHEN SMCONNCODE42 = P_CODE THEN SMCONNCODE42
		 WHEN SMCONNCODE51 = P_CODE THEN SMCONNCODE51
		 WHEN SMCONNCODE52 = P_CODE THEN SMCONNCODE52
	    ELSE '' END AS SMCONNCODE,

	    CASE WHEN SMCONNCODE11 = P_CODE THEN S11.FXC3DESC
		 WHEN SMCONNCODE12 = P_CODE THEN S12.FXC3DESC
		 WHEN SMCONNCODE21 = P_CODE THEN S21.FXC3DESC
		 WHEN SMCONNCODE22 = P_CODE THEN S22.FXC3DESC
		 WHEN SMCONNCODE31 = P_CODE THEN S31.FXC3DESC
		 WHEN SMCONNCODE32 = P_CODE THEN S32.FXC3DESC
		 WHEN SMCONNCODE41 = P_CODE THEN S41.FXC3DESC
		 WHEN SMCONNCODE42 = P_CODE THEN S42.FXC3DESC
		 WHEN SMCONNCODE51 = P_CODE THEN S51.FXC3DESC
		 WHEN SMCONNCODE52 = P_CODE THEN S52.FXC3DESC
	    ELSE '' END AS SMCONNCODENM,          

            PSSCMLIB.SF_PSM_SAFEMETHOD( SMWKTEAM||SMWKDATE||DIGITS(SMWKSEQ), SMWKORAPPDATE||DIGITS(SMWKORSEQ), 'RISK') AS  DSPCOLOR --색깔(1-빨강 2-노랑 3-파랑)
				FROM PSSCMLIB.PSM_SafeOrder_MASTER
				LEFT OUTER JOIN PSSCMLIB.PSM_WorkOrder
					ON WOORTEAM = SMWKTEAM
				   AND WOORDATE = SMWKDATE
				   AND WOSEQ    = SMWKSEQ
				LEFT OUTER JOIN TYSCMLIB.INKIBNMF
					 ON KBSABUN = SMRESSABUN
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S1
					  ON   S1.FXC3SAUP||S1.FXC3BCODE||DIGITS(S1.FXC3MCODE)||DIGITS(S1.FXC3SCODE) = SMSYSTEMCODE1
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S2
					  ON   S2.FXC3SAUP||S2.FXC3BCODE||DIGITS(S2.FXC3MCODE)||DIGITS(S2.FXC3SCODE) = SMSYSTEMCODE2
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S3
					  ON   S3.FXC3SAUP||S3.FXC3BCODE||DIGITS(S3.FXC3MCODE)||DIGITS(S3.FXC3SCODE) = SMSYSTEMCODE3
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S4
					  ON   S4.FXC3SAUP||S4.FXC3BCODE||DIGITS(S4.FXC3MCODE)||DIGITS(S4.FXC3SCODE) = SMSYSTEMCODE4
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S5
					  ON   S5.FXC3SAUP||S5.FXC3BCODE||DIGITS(S5.FXC3MCODE)||DIGITS(S5.FXC3SCODE) = SMSYSTEMCODE5
				LEFT OUTER JOIN TYSCMLIB.PSM_LOCATION_CLASS3 L1
					  ON L1.L3SAUP||L1.L3BCODE||DIGITS(L1.L3MCODE)||DIGITS(L1.L3SCODE) = SMAREACODE1
				LEFT OUTER JOIN TYSCMLIB.PSM_LOCATION_CLASS3 L2
					  ON L2.L3SAUP||L2.L3BCODE||DIGITS(L2.L3MCODE)||DIGITS(L2.L3SCODE) = SMAREACODE2 
				LEFT OUTER JOIN TYSCMLIB.PSM_LOCATION_CLASS3 L3
					  ON L3.L3SAUP||L3.L3BCODE||DIGITS(L3.L3MCODE)||DIGITS(L3.L3SCODE) = SMAREACODE3
				LEFT OUTER JOIN TYSCMLIB.PSM_LOCATION_CLASS3 L4
					  ON L4.L3SAUP||L4.L3BCODE||DIGITS(L4.L3MCODE)||DIGITS(L4.L3SCODE) = SMAREACODE4
				LEFT OUTER JOIN TYSCMLIB.PSM_LOCATION_CLASS3 L5
					  ON L5.L3SAUP||L5.L3BCODE||DIGITS(L5.L3MCODE)||DIGITS(L5.L3SCODE) = SMAREACODE5 
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S11
					  ON   S11.FXC3SAUP||S11.FXC3BCODE||DIGITS(S11.FXC3MCODE)||DIGITS(S11.FXC3SCODE) = SMCONNCODE11
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S12
					  ON   S12.FXC3SAUP||S12.FXC3BCODE||DIGITS(S12.FXC3MCODE)||DIGITS(S12.FXC3SCODE) = SMCONNCODE12
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S21
					  ON   S21.FXC3SAUP||S21.FXC3BCODE||DIGITS(S21.FXC3MCODE)||DIGITS(S21.FXC3SCODE) = SMCONNCODE21
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S22
					  ON   S22.FXC3SAUP||S22.FXC3BCODE||DIGITS(S22.FXC3MCODE)||DIGITS(S22.FXC3SCODE) = SMCONNCODE22
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S31
					  ON   S31.FXC3SAUP||S31.FXC3BCODE||DIGITS(S31.FXC3MCODE)||DIGITS(S31.FXC3SCODE) = SMCONNCODE31
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S32
					  ON   S32.FXC3SAUP||S32.FXC3BCODE||DIGITS(S32.FXC3MCODE)||DIGITS(S32.FXC3SCODE) = SMCONNCODE32
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S41
					  ON   S41.FXC3SAUP||S41.FXC3BCODE||DIGITS(S41.FXC3MCODE)||DIGITS(S41.FXC3SCODE) = SMCONNCODE41
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S42
					  ON   S42.FXC3SAUP||S42.FXC3BCODE||DIGITS(S42.FXC3MCODE)||DIGITS(S42.FXC3SCODE) = SMCONNCODE42
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S51
					  ON   S51.FXC3SAUP||S51.FXC3BCODE||DIGITS(S51.FXC3MCODE)||DIGITS(S51.FXC3SCODE) = SMCONNCODE51
				LEFT OUTER JOIN TYSCMLIB.ACFIXCLASS3 S52
					  ON   S52.FXC3SAUP||S52.FXC3BCODE||DIGITS(S52.FXC3MCODE)||DIGITS(S52.FXC3SCODE) = SMCONNCODE52
				WHERE SUBSTR(SMSYSTEMCODE1,1,1) = P_C2SAUP
				 AND  SMCOSABUN <> ''
				 AND  SMCOAPPDATE <> ''
				 AND  SMCOAPPTIME <> ''
				 AND  SMFSDATE = ''
				 AND  SMFSTIME = ''
				 AND  (SUBSTR(SMSYSTEMCODE1,1,7) = SUBSTR(P_CODE, 1, 7) OR
				      SUBSTR(SMSYSTEMCODE2,1,7) = SUBSTR(P_CODE, 1, 7) OR
				      SUBSTR(SMSYSTEMCODE3,1,7) = SUBSTR(P_CODE, 1, 7) OR
				      SUBSTR(SMSYSTEMCODE4,1,7) = SUBSTR(P_CODE, 1, 7) OR
				      SUBSTR(SMSYSTEMCODE5,1,7) = SUBSTR(P_CODE, 1, 7) OR
                                      SMAREACODE1 =  P_CODE OR
				      SMAREACODE2 =  P_CODE OR
				      SMAREACODE3 =  P_CODE OR
				      SMAREACODE4 =  P_CODE OR
				      SMAREACODE5 =  P_CODE OR
				      SMCONNCODE11 =  P_CODE OR 
				      SMCONNCODE12 =  P_CODE OR 
				      SMCONNCODE21 =  P_CODE OR 
				      SMCONNCODE22 =  P_CODE OR 
				      SMCONNCODE31 =  P_CODE OR 
				      SMCONNCODE32 =  P_CODE OR 
				      SMCONNCODE41 =  P_CODE OR 
				      SMCONNCODE42 =  P_CODE OR 
				      SMCONNCODE51 =  P_CODE OR 
				      SMCONNCODE52 =  P_CODE )				      
				ORDER BY  SMWKTEAM, SMWKDATE, SMWKSEQ, SMWKORAPPDATE,  SMWKORSEQ DESC
               )
	       SELECT       PONUM, --요청번호
                            SMWKORAPPDATE,  --허가일자
			    SMWKORSEQ, --허가순번
			    SMAREATEXT1, --작업내용            
			    SMREVTEAM,  --작업부서
			    SMREVTEAMNM, --작업부서명
			    SMMETHODCODE, --작업구분코드
			    SMMETHODCODENM,--작업구분명          
			    SMWKMETHOD,  --작업방법코드
			    SMWKMETHODNM, --작업방법
			    SMRESSABUN,  --작업자사번
			    SMRESSABUNNM, --작업자이름            

			    CASE WHEN SMSYSTEMCODE != '' THEN SMSYSTEMCODE
			         WHEN SMAREACODE != '' THEN SMAREACODE
				 WHEN SMCONNCODE != '' THEN SMCONNCODE
		            ELSE '' END AS SMSYSTEMCODE,	
			    
                            CASE WHEN SMSYSTEMCODE != '' THEN SMSYSTEMCODENM
			         WHEN SMAREACODE != '' THEN SMAREACODENM
				 WHEN SMCONNCODE != '' THEN SMCONNCODENM
		            ELSE '' END AS SMSYSTEMCODENM		   
			    
	        FROM TABLE1;

		
	OPEN REFCURSOR;

END