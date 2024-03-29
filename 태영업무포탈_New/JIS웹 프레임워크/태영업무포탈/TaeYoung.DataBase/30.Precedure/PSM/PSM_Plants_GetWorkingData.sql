DROP PROCEDURE PSSCMLIB.PSM_Plants_GetWorkingData;

CREATE PROCEDURE PSSCMLIB.PSM_Plants_GetWorkingData
( 
	P_C2SAUP     VARCHAR(1)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR	
						
	SELECT  SMWKTEAM||'-'||SMWKDATE||'-'||DIGITS(SMWKSEQ) AS PONUM, --요청번호
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
            SMSYSTEMCODE1, --설비코드
            S1.FXC3DESC AS SMSYSTEMCODE1NM, --설비명
            SMSYSTEMCODE2,  --설비코드
            S2.FXC3DESC AS SMSYSTEMCODE2NM, --설비명
            SMSYSTEMCODE3, --설비코드
            S3.FXC3DESC AS SMSYSTEMCODE3NM, --설비명
            SMSYSTEMCODE4, --설비코드
            S4.FXC3DESC AS SMSYSTEMCODE4NM, --설비명
            SMSYSTEMCODE5, --설비코드
            S5.FXC3DESC AS SMSYSTEMCODE5NM, --설비명
            SMAREACODE1, --주변지역1
            L1.L3NAME AS SMAREACODE1NM, --주변지역명1
            SMAREACODE2,--주변지역2
            L2.L3NAME AS SMAREACODE2NM, --주변지역명2
            SMAREACODE3, --주변지역3
            L3.L3NAME AS SMAREACODE3NM, --주변지역명3
            SMAREACODE4, --주변지역4
            L4.L3NAME AS SMAREACODE4NM, --주변지역명4
            SMAREACODE5 , --주변지역5
            L5.L3NAME AS SMAREACODE5NM, --주변지역명5
            SMCONNCODE11,
            S11.FXC3DESC AS SMCONNCODE11NM, --연관설비명
            SMCONNCODE12,
            S12.FXC3DESC AS SMCONNCODE12NM, --연관설비명
            SMCONNCODE21,
            S21.FXC3DESC AS SMCONNCODE21NM, --연관설비명
            SMCONNCODE22,
            S22.FXC3DESC AS SMCONNCODE22NM, --연관설비명
            SMCONNCODE31,
            S31.FXC3DESC AS SMCONNCODE31NM, --연관설비명
            SMCONNCODE32,
            S32.FXC3DESC AS SMCONNCODE32NM, --연관설비명
            SMCONNCODE41,
            S41.FXC3DESC AS SMCONNCODE41NM, --연관설비명
            SMCONNCODE42,
            S42.FXC3DESC AS SMCONNCODE42NM, --연관설비명
            SMCONNCODE51,
            S51.FXC3DESC AS SMCONNCODE51NM, --연관설비명
            SMCONNCODE52,
            S52.FXC3DESC AS SMCONNCODE52NM, --연관설비명
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
				ORDER BY  SMWKTEAM, SMWKDATE, SMWKSEQ, SMWKORAPPDATE,  SMWKORSEQ DESC;  
		
	OPEN REFCURSOR;

END