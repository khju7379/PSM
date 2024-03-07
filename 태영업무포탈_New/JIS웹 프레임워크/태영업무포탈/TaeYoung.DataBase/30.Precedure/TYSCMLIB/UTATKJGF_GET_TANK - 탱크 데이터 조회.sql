DROP PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANK;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : UTATKJGF_GET_TANK
-- 작성자     : 문광복
-- 작성일     : 2016-09-02
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.UTATKJGF_GET_TANK (1,20,'')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.UTATKJGF_GET_TANK 
( 
	P_JEGOTK           VARCHAR(10)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT                          
			JEGOTK,                         
			JEGOIL,                         
			SUBSTR(JEGOTM,1,2) ||':'|| SUBSTR(JEGOTM,3,2) ||':'|| SUBSTR(JEGOTM,5,2) AS JEGOTM,  
			JEGOMASS,                       
			JEGOTEMP,                       
			JECAPA,                         
			JEHIGH,                         
			JEGKLQTY,                       
			ROUND((JEGOMASS/JEGKLQTY)*JECAPA,2) AS JENKLQTY,                    
			JEHWAMUL,                       
			SUBSTR(JEHMNAME,1,8) AS JEHMNAME,                         
			JEHMNAME AS JEHMFULLNAME,                         
			TANK.TNHWAJUNM,                 
			HMBJ.HMTEMPH TEMPH,               
			HMBJ.HMTEMPL AS TEMPL,       
			TKJW.TANKTEMPH AS TKTEMPH,
			TKJW.TANKTEMPL AS TKTEMPL,              
			TKJW.TANKLEVEL AS LEVEL_H,                   
			(TANK.TNL) * 100 AS LEVEL_L,                    
			(TNHIGH * 100) AS LEVEL,
			CAST(ROUND((JEHIGH *100) / (TANKHIGH),2) AS NUMERIC(4,1)) AS JEGOPER,
			CASE WHEN (JEHIGH *100) / (TANKHIGH) > 100 THEN '100' ELSE (JEHIGH*100) / (TANKHIGH) END AS JEGOPERL,
			CASE WHEN 100 - ((JEHIGH *100) / (TANKHIGH)) < 0 THEN '0' ELSE 100 - ((JEHIGH *100) / (TANKHIGH)) END AS JEGOPERH,
			'' AS BLANK,
			HMBJ.HMVCF,   
			TANK.TNBIJUNG AS HMWCF,
			TRUNC(JEPRESS,0) AS JEPRESS
		FROM TYSCMLIB.UTATKJGF AS TKJG
			LEFT OUTER JOIN TYSCMLIB.UTITANKF AS TANK
				ON TRIM(TANK.TNTANKNO) = TRIM(TKJG.JEGOTK)         
			LEFT OUTER JOIN TYSCMLIB.UTAHMBJF HMBJ
				ON   HMBJ.HMCODE = TKJG.JEHWAMUL
			LEFT OUTER JOIN TYSCMLIB.UTATKJWF TKJW
				ON   TRIM(TKJW.TANKNO) = TRIM(TKJG.JEGOTK)    
		WHERE JEGOTK = (CASE WHEN LENGTH(P_JEGOTK) = 3 THEN ' '|| P_JEGOTK ELSE P_JEGOTK END);

		
	OPEN REFCURSOR;

END