DROP PROCEDURE PSSCMLIB.PSM_Plants_GetShipListData;

CREATE PROCEDURE PSSCMLIB.PSM_Plants_GetShipListData
( 
	P_SDATE     VARCHAR(6),
	P_YEAR      VARCHAR(4),
	P_EISDATE   VARCHAR(6)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- Ω√¿€
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR							
		   

         WITH TABLE1 AS (
                SELECT  ROWNUMBER() OVER(ORDER BY CASE WHEN SHETBDATE = '' THEN  SHETAULSAN ELSE SHETBDATE END , SHDATE, SHSEQ) AS ROWNUM,
                     SHDATE   ,    
                     SHSEQ    ,
                     SHCOMPANY,    
                          'S70001001' AS PIERUNITCODE,
                     SHHANGCHA,    
                         SHVESSEL AS SHHANGCHANM,
                     SHSOSOK  ,    
                         SK.CDDESC1 AS SHSOSOKNM,
                         SHGOKJONG,    
                         GK.CDDESC1 AS SHGOKJONGNM,
                         SHWONSAN ,    
                         WN.CDDESC1 AS SHWONSANNM,
                     SHAGENT  ,    
                         BR.CDDESC1 AS SHAGENTNM,
                         SHSURVEY ,
                         LS.CDDESC1 AS SHSURVEYNM,
                     SHETCD_S ,    
                     SHETCD_E ,
                         CASE WHEN SHETCD_S <> '' AND SHETCD_E <> ''THEN 
                                  SUBSTR(SHETCD_S,5,2)||'.'||SUBSTR(SHETCD_S,7,2)||'~'||SUBSTR(SHETCD_E,5,2)||'.'||SUBSTR(SHETCD_E,7,2)  
                         ELSE '' END AS  SHETCD,
                         CASE WHEN SHETBDATE = '' THEN  SHETAULSAN ELSE SHETBDATE END   SHETAULSAN,
                         CASE WHEN SHETBDATE = '' THEN  SHETAULTIME ELSE SHETBTIME END   SHETAULTIME,
                         SHULSANQTY ,  
                         SHETABUSAN ,  
                         SHETABUTIME,  
                         SHBUSANQTY ,
                         SHETAINCHE ,  
                         SHETAINTIME,  
                         SHINCHEQTY ,  
                         SHTOTALQTY ,  
                         SHMONTHQTY ,  
                         SHANNUALQTY,
                         SHREMARK   ,
                         CASE WHEN HA.IHJUBDAT IS NULL THEN '' ELSE DIGITS(HA.IHJUBDAT) END IHJUBDAT,
                         CASE WHEN HA.IHJUBTIM IS NULL THEN '' ELSE DIGITS(HA.IHJUBTIM) END IHJUBTIM,
                         CASE WHEN HA.IHIANDAT IS NULL THEN '' ELSE DIGITS(HA.IHIANDAT) END IHIANDAT,
                         CASE WHEN HA.IHIANTIM IS NULL THEN '' ELSE DIGITS(HA.IHIANTIM) END IHIANTIM,
                        SUBSTR(CHAR(CURRENT_DATE),1,4)||'-'||SUBSTR(CHAR(CURRENT_DATE),6,2)||'-'||SUBSTR(CHAR(CURRENT_DATE),9,2)  as CURRENTDATE,
                        SUBSTR(CHAR(CURRENT_TIME),1,2)||':'||SUBSTR(CHAR(CURRENT_TIME),4,2)||':'||SUBSTR(CHAR(CURRENT_TIME),7,2)  AS CURRENTTIME,
                       PAR.SDATE AS SDATE
                FROM TYSCMLIB.PSM_ShipSchedule_SILO
                LEFT OUTER JOIN TYSCMLIB.USIIPHAF  HA
                    ON HA.IHHANGCHA = SHHANGCHA
                LEFT OUTER JOIN TYSCMLIB.USICODEF VS
                   ON  VS.CDINDEX = 'VS'
                  AND VS.CDCODE = SHHANGCHA
                LEFT OUTER JOIN TYSCMLIB.USICODEF BR
                   ON BR.CDINDEX = 'BR'
                  AND BR.CDCODE = SHAGENT
                LEFT OUTER JOIN TYSCMLIB.USICODEF WN
                   ON WN.CDINDEX = 'WN'
                  AND WN.CDCODE = SHWONSAN
                LEFT OUTER JOIN TYSCMLIB.USICODEF GK
                   ON GK.CDINDEX = 'GK'
                  AND GK.CDCODE = SHGOKJONG
                LEFT OUTER JOIN TYSCMLIB.USICODEF LS
                   ON LS.CDINDEX = 'LS'
                  AND LS.CDCODE = SHSURVEY
                LEFT OUTER JOIN TYSCMLIB.USICODEF SK
                   ON  SK.CDINDEX = 'SK'
                  AND SK.CDCODE = SHSOSOK
                LEFT OUTER JOIN (SELECT CAST(P_SDATE AS VARCHAR(6)) AS SDATE 
                                           FROM SYSIBM.SYSDUMMY1) AS PAR 
                       ON 1 = 1
                WHERE SHCOMPANY = 'TY'
                  AND ( SUBSTR(SHETAULSAN,1,6) = PAR.SDATE  OR 
                            SUBSTR(SHETBDATE,1,6) = PAR.SDATE  OR
                            CASE WHEN HA.IHIANDAT IS NULL THEN '' ELSE SUBSTR(HA.IHIANDAT,1,6) END = PAR.SDATE
                          )
                ),YearTotal_Table AS (
                SELECT     A.ERYYMM,
                             A.MONTHQTY,
                           VALUE(( SELECT  EDUUSQUAN
                               FROM TYSCMLIB.EDQUANUSMF
                            WHERE EDUYYMM = A.ERYYMM
                                AND EDUCDDP = 'S00000' ),0) AS EISMONTHQTY
                FROM (
                SELECT  SUBSTR(IHJAKENDAT,1,6) AS ERYYMM,  
                        SUM(IHBLQTY) AS MONTHQTY
                 FROM TYSCMLIB.USIIPHAF
                  WHERE SUBSTR(IHJAKENDAT,1,4) = P_YEAR
                     AND SUBSTR(IHJAKENDAT,1,6)  < P_EISDATE
                GROUP BY SUBSTR(IHJAKENDAT,1,6) 
                ) A
                ),
                 TABLE2 AS (
                SELECT ROWNUM,
                   SHDATE   ,    
                     SHSEQ    ,
                     SHCOMPANY,    
                          PIERUNITCODE,
                     SHHANGCHA,    
                         SHHANGCHANM,
                     SHSOSOK  ,    
                         SHSOSOKNM,
                         SHGOKJONG,    
                         SHGOKJONGNM,
                         SHWONSAN ,    
                         SHWONSANNM,
                     SHAGENT  ,    
                         SHAGENTNM,
                         SHSURVEY ,
                         SHSURVEYNM,
                     SHETCD_S ,    
                     SHETCD_E ,
                          SHETCD,
                         SHETAULSAN ,  
                         SHETAULTIME,  
                         SHULSANQTY ,  
                         SHETABUSAN ,  
                         SHETABUTIME,  
                         SHBUSANQTY ,
                         SHETAINCHE ,  
                         SHETAINTIME,  
                         SHINCHEQTY ,  
                         (SHULSANQTY + SHBUSANQTY +  SHINCHEQTY) as SHTOTALQTY ,  
                         ( SELECT VALUE(SUM(SHULSANQTY),0) FROM TABLE1 B WHERE B.ROWNUM <= A.ROWNUM ) AS   SHMONTHQTY ,  
                          ( SELECT  SUM(CASE WHEN  EISMONTHQTY <> 0 THEN EISMONTHQTY ELSE MONTHQTY END)
                             FROM YearTotal_Table  )  +       
                      ( SELECT VALUE(SUM(SHULSANQTY),0) FROM TABLE1 B WHERE B.ROWNUM <= A.ROWNUM ) AS SHANNUALQTY,
                         SHREMARK,
                         CASE WHEN IHJUBDAT = '' THEN SHETAULSAN ELSE IHJUBDAT END AS IHJUBDAT, 
                          IHJUBTIM,         
                          CASE WHEN IHJUBDAT = '' THEN 
                                   SUBSTR(SHETAULSAN,1,4)||'-'||SUBSTR(SHETAULSAN,5,2)||'-'||SUBSTR(SHETAULSAN,7,2)  
                          ELSE  
                                  SUBSTR(IHJUBDAT,1,4)||'-'||SUBSTR(IHJUBDAT,5,2)||'-'||SUBSTR(IHJUBDAT,7,2)  
                          END AS TIMEIHJUBDAT,
                         CASE WHEN 
                         IHJUBTIM <> '' THEN SUBSTR(IHJUBTIM,1,2)||':'||SUBSTR(IHJUBTIM,3,2)||':'||'00' 
                         ELSE '' END   TIMEIHJUBTIM,

                         IHIANDAT,
                         IHIANTIM,
                         CASE WHEN IHIANDAT <> '' THEN  SUBSTR(IHIANDAT,1,4)||'-'||SUBSTR(IHIANDAT,5,2)||'-'||SUBSTR(IHIANDAT,7,2)    
                         ELSE '' END AS TIMEIHIANDAT,
                         CASE WHEN IHIANTIM <> '' THEN SUBSTR(IHIANTIM,1,2)||':'||SUBSTR(IHIANTIM,3,2)||':'||'00' 
                         ELSE '' END   TIMEIHIANTIM,
                          CURRENTDATE,
                          CURRENTTIME,
                      SDATE
                FROM TABLE1 A ) , TABLE3 AS (
                SELECT   
                    ROWNUM, 
                    SHDATE   ,    
                     SHSEQ    ,
                     SHCOMPANY,    
                          PIERUNITCODE,
                     SHHANGCHA,    
                         SHHANGCHANM,
                     SHSOSOK  ,    
                         SHSOSOKNM,
                         SHGOKJONG,    
                         SHGOKJONGNM,
                         SHWONSAN ,    
                         SHWONSANNM,
                     SHAGENT  ,    
                         SHAGENTNM,
                         SHSURVEY ,
                         SHSURVEYNM,
                     SHETCD_S ,    
                     SHETCD_E ,
                          SHETCD,
                         SHETAULSAN ,  
                         SHETAULTIME,  
                         SHULSANQTY ,  
                         SHETABUSAN ,  
                         SHETABUTIME,  
                         SHBUSANQTY ,
                         SHETAINCHE ,  
                         SHETAINTIME,  
                         SHINCHEQTY ,  
                         SHTOTALQTY ,  
                           SHMONTHQTY ,  
                          SHANNUALQTY,
                         SHREMARK,
                          IHJUBDAT,
                          IHJUBTIM,
                         TIMEIHJUBDAT,
                         TIMEIHJUBTIM,   
                         IHIANDAT,
                         IHIANTIM,
                         TIMEIHIANDAT,
                         TIMEIHIANTIM,
                         CASE WHEN IHJUBDAT <> '' AND IHJUBTIM <> '' AND LENGTH(IHJUBTIM) >= 4 AND IHIANDAT <> '' AND IHIANTIM <> ''  AND LENGTH(IHIANTIM) >= 4 THEN
                                            CASE WHEN TIMESTAMP(TIMEIHJUBDAT||' '||TIMEIHJUBTIM) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME) < 0  AND
                                                      TIMESTAMP(TIMEIHIANDAT||' '||TIMEIHIANTIM) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME)  > 0 THEN 'Y' 
                                             ELSE 'N' END
                                  WHEN IHJUBDAT <> '' AND IHJUBTIM <> '' AND LENGTH(IHJUBTIM) >= 4 AND IHIANDAT = '' THEN
                                            CASE WHEN TIMESTAMP(TIMEIHJUBDAT||' '||TIMEIHJUBTIM) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME) < 0  THEN 'Y' 
                                            ELSE 'N' END                  
                          ELSE 'N' END AS SHIPCOME,
                          CASE WHEN IHIANDAT <> '' AND IHIANTIM <> '' AND LENGTH(IHIANTIM) >= 4 THEN
                                 CASE WHEN TIMESTAMP(TIMEIHIANDAT||' '||TIMEIHIANTIM) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME)  > 0 THEN 'N' ELSE 'Y' END
                          ELSE 
                               CASE WHEN TIMEIHIANDAT <> '' THEN
                                       CASE WHEN  DATE(CURRENTDATE) - DATE(TIMEIHIANDAT) > 1 THEN 'Y' ELSE 'N' END
                               ELSE 'N'
                               END 
                           END AS SHIPSAIL
                ,
                           CASE WHEN  IHJUBDAT <> ''  AND  IHJUBTIM = '' THEN 
                                    CASE WHEN DATE(TIMEIHJUBDAT) - DATE(CURRENTDATE) >= 0 THEN 'Y' ELSE 'N' END
                            ELSE 
                                   CASE WHEN TIMESTAMP(TIMEIHJUBDAT||' '||TIMEIHJUBTIM) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME) > 0 THEN 'Y' ELSE 'N' END        
                            END SHIPSCHED,
                        SDATE
                FROM TABLE2 B
                ORDER BY SHDATE, SHSEQ
                ) 
                SELECT  ROWNUM, 
                    SHDATE   ,    
                     SHSEQ    ,
                     SHCOMPANY,    
                          PIERUNITCODE,
                     SHHANGCHA,    
                         SHHANGCHANM,
                     SHSOSOK  ,    
                         SHSOSOKNM,
                         SHGOKJONG,    
                         SHGOKJONGNM,
                         SHWONSAN ,    
                         SHWONSANNM,
                     SHAGENT  ,    
                         SHAGENTNM,
                         SHSURVEY ,
                         SHSURVEYNM,
                     SHETCD_S ,    
                     SHETCD_E ,
                          SHETCD,
                         SHETAULSAN ,  
                         SHETAULTIME,  
                         SHULSANQTY ,  
                         SHETABUSAN ,  
                         SHETABUTIME,  
                         SHBUSANQTY ,
                         SHETAINCHE ,  
                         SHETAINTIME,  
                         SHINCHEQTY ,  
                         SHTOTALQTY ,  
                           SHMONTHQTY ,  
                          SHANNUALQTY,
                         SHREMARK,
                          IHJUBDAT,
                          IHJUBTIM,
                         TIMEIHJUBDAT,
                         TIMEIHJUBTIM,   
                         IHIANDAT,
                         IHIANTIM,
                         TIMEIHIANDAT,
                         TIMEIHIANTIM,
                         SHIPCOME,
                         SHIPSAIL,
                        CASE WHEN SHIPSCHED = 'Y' THEN
                         CASE WHEN ( SELECT COUNT(*)  FROM TABLE3 A 
                                           WHERE A.ROWNUM < C.ROWNUM
                                             AND  A.SHIPSCHED = 'Y' ) <= 0 THEN 'Y' ELSE 'N' END 
                        ELSE 'N' END SHIPSCHED,
                    SDATE
                FROM TABLE3 C
                WHERE  (SHIPSAIL != 'Y' OR  IHJUBDAT >= SDATE||'01' )
                ORDER BY ROWNUM, C.SHDATE, C.SHSEQ;

		
	OPEN REFCURSOR;

END