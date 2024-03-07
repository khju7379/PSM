

DROP PROCEDURE PSSCMLIB.PSM_Area_GetUnitData;

CREATE PROCEDURE PSSCMLIB.PSM_Area_GetUnitData
( 
	P_C2SAUP     VARCHAR(1)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ½ÃÀÛ
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR	
						
			WITH  TABLE1 AS (
                SELECT  C2SAUP,
                            C2BCODE||DIGITS(C2MCODE)||'000' AS C2KEYCODE,
                            C2NAME ,
                            C2XPOINT,
                            C2YPOINT,
                            C2DSGUBN,
                            C2SCGUBN
                FROM PSSCMLIB.PSM_SYSTEM_CLASS2
                WHERE C2BCODE IN ('2','3','4')
                UNION ALL
                SELECT  C3SAUP AS C2SAUP,
                            C3BCODE||DIGITS(C3MCODE)||DIGITS(C3SCODE) AS C2KEYCODE, 
                            C3NAME  AS C2NAME,
                            C3XPOINT  AS C2XPOINT,
                            C3YPOINT AS C2YPOINT,
                            C3DSGUBN AS C2DSGUBN,
                            C3SCGUBN AS C2SCGUBN
                FROM  PSSCMLIB.PSM_SYSTEM_CLASS3
                WHERE C3BCODE IN ('2','3','4')
                AND    C3XPOINT > 0 
                UNION ALL
                SELECT L3SAUP  AS C2SAUP,
                          L3BCODE||DIGITS(L3MCODE)||DIGITS(L3SCODE) AS C2KEYCODE, 
                         L3NAME  AS C2NAME,  
                         L3XPOINT  AS C2XPOINT,
                         L3YPOINT AS C2YPOINT, 
                     L3DSGUBN AS C2DSGUBN, 
                     L3SCGUBN AS C2SCGUBN
                FROM PSSCMLIB.PSM_LOCATION_CLASS3

                )
                SELECT  C2SAUP,
                            C2SAUP||C2KEYCODE AS C2KEYCODE,
                            C2NAME ,
                            C2XPOINT,
                            C2YPOINT,
                            C2DSGUBN,
                            C2SCGUBN
                FROM TABLE1 
                WHERE C2SAUP = P_C2SAUP
                ORDER BY C2KEYCODE;

		
	OPEN REFCURSOR;

END