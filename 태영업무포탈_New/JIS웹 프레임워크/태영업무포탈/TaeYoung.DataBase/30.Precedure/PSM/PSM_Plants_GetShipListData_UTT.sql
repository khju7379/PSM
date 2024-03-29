DROP PROCEDURE PSSCMLIB.PSM_Plants_GetShipListData_UTT;

CREATE PROCEDURE PSSCMLIB.PSM_Plants_GetShipListData_UTT
( 
	P_SHHWDATE    VARCHAR(6),
	P_KIJUNDATE   VARCHAR(6)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR							
		   
		   WITH TABLE1 AS (

                        SELECT  
                         SHDATE    ,  
                         SHSEQ     ,  
                         SHDATEETB ,  
                         CASE WHEN SHETBTIME = '' THEN '0000' 
                              WHEN SUBSTR(SHETBTIME,1,2) = '24' THEN '00'||SUBSTR(SHETBTIME,3,2)  
                         ELSE SHETBTIME END SHETBTIME ,   
 
                         SUBSTR(SHDATEETB,1,4)||'-'||SUBSTR(SHDATEETB,5,2)||'-'||SUBSTR(SHDATEETB,7,2) AS TIMESHDATEETB,

 
                         SUBSTR(CASE WHEN SHETBTIME = '' THEN '0000' ELSE SHETBTIME END,1,2)||':'||SUBSTR(CASE WHEN SHETBTIME = '' THEN '0000' ELSE SHETBTIME END,3,2)||':'||'00' AS TIMESHETBTIME,

                         CASE WHEN  SHDATEETD = '' THEN SHDATEETB ELSE SHDATEETD END SHDATEETD,  

                         CASE WHEN SHETDTIME = '' THEN 
                                     '0000' 
                                WHEN SUBSTR(SHETDTIME,1,2) = '24' THEN 
                                      '00'||SUBSTR(SHETDTIME,3,2)  
                                WHEN SUBSTR(SHETDTIME,1,4) = '0000' THEN 
                                      '0001'
                         ELSE SHETDTIME END SHETDTIME ,     

                         CASE WHEN SHDATEETD <> '' THEN
                               CASE WHEN  SUBSTR(SHETDTIME,1,2) = '24'  OR SUBSTR(SHETDTIME,1,2) = '00' THEN
                                       CHAR(DATE(SUBSTR(SHDATEETD,1,4)||'-'||SUBSTR(SHDATEETD,5,2)||'-'||SUBSTR(SHDATEETD,7,2)) + 1 DAYS)
                               ELSE   SUBSTR(SHDATEETD,1,4)||'-'||SUBSTR(SHDATEETD,5,2)||'-'||SUBSTR(SHDATEETD,7,2) END
                         ELSE 
                               SUBSTR(SHDATEETB,1,4)||'-'||SUBSTR(SHDATEETB,5,2)||'-'||SUBSTR(SHDATEETB,7,2)
                         END   AS TIMESHDATEETD,

                         CASE WHEN SHETDTIME = '' THEN 
                                 '00:00:00' 
                          ELSE  
                               CASE WHEN (SUBSTR(SHETDTIME,1,2) = '24'  OR SUBSTR(SHETDTIME,1,2) = '00') AND SUBSTR(SHETDTIME,3,2) = '00' THEN
                                       SUBSTR(SHETDTIME,1,2)||':'||'01'||':'||'00'
                               ELSE  SUBSTR(SHETDTIME,1,2)||':'||SUBSTR(SHETDTIME,3,2)||':'||'00'  END
                          END AS TIMESHETDTIME,

                         SHPIER    ,  
                          CASE WHEN SHPIER = '1' THEN 'T70001001'
                                            WHEN SHPIER = '2' THEN 'T70001003'  
                                            WHEN SHPIER = '3' THEN 'T70001002' 
                          ELSE 'T70001004' END PIERUNITCODE,
                         CDDESC1 AS SHPIERNM,
                         SHREMARK,
                         SHSHIPNAME,  
                         SHHWAJU   ,  
                         SHHWAMUL  ,  
                         SHTANKNO  ,  
                         SHAGENT   ,
                          ( SELECT  VALUE(SUM(DOUBLE(SHQTON)),0) FROM TYSCMLIB.PSM_ShipSchedule_UTT  
                            WHERE   SUBSTR(SHDATEETB,1,6) <> PAR.KIJUNDATE 
                                AND  SUBSTR(SHDATEETD,1,6) <> PAR.KIJUNDATE
                                AND  SHHWDATE = PAR.KIJUNDATE
                                AND  SHICGUBN NOT IN('3', '4')
	                        AND  SHHIGB <> 'D') AS SHJUWOLQTY,
                         SHQTON,
                          (CASE WHEN SHICGUBN IN('3', '4') THEN 0                             
                               WHEN SHHWDATE <> P_SHHWDATE THEN 0 
                               ELSE SHQTON END) AS SHTTON,                                
                         sUBSTR(CHAR(CURRENT_DATE),1,4)||'-'||SUBSTR(CHAR(CURRENT_DATE),6,2)||'-'||SUBSTR(CHAR(CURRENT_DATE),9,2)  as CURRENTDATE,
                         SUBSTR(CHAR(CURRENT_TIME),1,2)||':'||SUBSTR(CHAR(CURRENT_TIME),4,2)||':'||SUBSTR(CHAR(CURRENT_TIME),7,2)  AS CURRENTTIME
                          --'2014-10-04' AS CURRENTDATE,
                          --'12:00:00' AS CURRENTTIME
                        FROM TYSCMLIB.PSM_ShipSchedule_UTT  
                        LEFT OUTER JOIN TYSCMLIB.UTICODEF JB
                              ON JB.CDINDEX = 'JB'
                            AND JB.CDCODE = SHPIER
                        LEFT OUTER JOIN (SELECT CAST(P_KIJUNDATE AS VARCHAR(6)) AS KIJUNDATE 
                                                     FROM SYSIBM.SYSDUMMY1) AS PAR 
                            ON  1 = 1
                        WHERE  (SUBSTR(SHDATEETB,1,6) = PAR.KIJUNDATE OR SUBSTR(SHDATEETD,1,6) = PAR.KIJUNDATE )
                           AND  SHPIER in ('1','2','3','4')
                           AND  SHHIGB <> 'D'
                           AND  SHHIGB = '99'     

                        ), TABLE2 AS ( 
                        SELECT   
                         SHDATE    ,  
                         SHSEQ     ,  
                         CASE WHEN SHDATEETB <> '' THEN SUBSTR(SHDATEETB,5,2)||'.'||SUBSTR(SHDATEETB,7,2) ELSE '' END AS IPDATE,
                         SHDATEETB ,  
                         SHETBTIME ,   
                         SHDATEETD ,  
                         SHETDTIME ,  
                         SHPIER    ,  
                         PIERUNITCODE,
                         SHPIERNM,
                         SHSHIPNAME,  
                         SHHWAJU   ,  
                         SHHWAMUL  ,  
                         SHTANKNO  ,  
                         SHREMARK,
                         SHAGENT   ,
                         SHJUWOLQTY,
                         SHQTON,
                         SHTTON,
                         CURRENTDATE,
                         CURRENTTIME,  
                          CASE WHEN SHETBTIME <> '0000' AND LENGTH(SHETBTIME) >= 4 AND SHETDTIME <> '0000' AND  LENGTH(SHETDTIME) >= 4 THEN
                                     CASE WHEN TIMESTAMP(TIMESHDATEETB||' '||TIMESHETBTIME) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME) < 0  AND
                                                   TIMESTAMP(TIMESHDATEETD||' '||TIMESHETDTIME) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME)  > 0   THEN 'Y' ELSE 'N' END
                                  WHEN SHETBTIME <> '0000' AND LENGTH(SHETBTIME) >= 4 AND SHETDTIME = '0000'  AND TIMESHDATEETD <> '' THEN           
                                         CASE WHEN  DATE(CURRENTDATE) - DATE(TIMESHDATEETD) >= 0 THEN 'Y' ELSE 'N' END
                          ELSE 
                                  'N'
                          END AS SHIPCOME,  
                          CASE WHEN SHETDTIME <> '0000' AND LENGTH(SHETDTIME) >= 4 THEN
                              CASE WHEN TIMESTAMP(TIMESHDATEETD||' '||TIMESHETDTIME) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME)  > 0 THEN 'N' ELSE 'Y' END
                          ELSE 
                               CASE WHEN TIMESHDATEETD <> '' THEN
                                      CASE WHEN  DATE(CURRENTDATE) - DATE(TIMESHDATEETD) > 1 THEN 'Y' ELSE 'N' END
                               ELSE 'N' END
                          END AS SHIPSAIL,
                          CASE WHEN  SHDATEETB <> ''  AND  SHETBTIME = '0000' THEN 
                                   CASE WHEN DATE(TIMESHDATEETB) - DATE(CURRENTDATE) >= 0 THEN 'Y' ELSE 'N' END
                          ELSE 
                                CASE WHEN SHDATEETB <> ''  AND  SHETBTIME <> '0000'  AND SHDATEETD <> '' AND SHETDTIME <> '0000' THEN
                                     CASE WHEN TIMESTAMP(TIMESHDATEETB||' '||TIMESHETBTIME) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME) > 0  AND
                                                   TIMESTAMP(TIMESHDATEETD||' '||TIMESHETDTIME) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME)  > 0   THEN 'Y' ELSE 'N' END
                                ELSE 
                                    CASE WHEN SHDATEETB <> ''  AND  SHETBTIME <> '0000'  AND (SHDATEETD = '' OR SHETDTIME = '0000') THEN
                                                CASE WHEN TIMESTAMP(TIMESHDATEETB||' '||TIMESHETBTIME) - TIMESTAMP(CURRENTDATE||' '||CURRENTTIME) < 0  THEN 'Y' ELSE 'N' END
                                             WHEN SHDATEETB  = ''  AND  SHETBTIME = '0000'   THEN 'N' 
                                    ELSE 'N' END
                                END  
                          END SHIPSCHED
                        FROM TABLE1 ), TABLE3 as (

                        SELECT  
                        ROWNUMBER() OVER (ORDER BY SHDATEETB, SHETBTIME, SHPIER, SHSHIPNAME, SHHWAJU, SHHWAMUL) AS NUM,
                        SHDATE    ,  
                         SHSEQ     ,  
                        IPDATE,
                         SHDATEETB ,    
                         SHETBTIME ,   
                         SHDATEETD ,  
                         SHETDTIME ,  
                         SHPIER    ,  
                         PIERUNITCODE,
                         SHPIERNM,
                         SHSHIPNAME,  
                         SHHWAJU   ,  
                         SHHWAMUL  ,  
                         SHTANKNO  ,  
                         SHREMARK,
                         SHAGENT   ,
                         SHJUWOLQTY, 
                         SHQTON,
                         SHTTON,
                         CURRENTDATE,
                         CURRENTTIME,  
                          SHIPCOME,  
                           SHIPSAIL,
                         SHIPSCHED
                        FROM TABLE2

                        ), Main_Table as (
                        SELECT  NUM, SHDATE    ,  
                                  SHSEQ     ,  
                        IPDATE,
                         SHDATEETB ,  
                         SHETBTIME ,   
                         SHDATEETD ,  
                         SHETDTIME ,  
                         SHPIER    ,  
                         PIERUNITCODE,
                         SHPIERNM,
                         SHSHIPNAME,
                         SHHWAJU   ,  
                         SHHWAMUL  ,  
                         SHTANKNO  ,  
                         SHREMARK,
                         SHAGENT   ,
                         SHJUWOLQTY, 
                         SHQTON,
                         SHTTON,
                         CURRENTDATE,
                         CURRENTTIME,  
                          CASE WHEN SHIPCOME = 'Y' THEN
                                 CASE WHEN ( SELECT  VALUE(COUNT(*),0)  FROM TABLE3 K
                                                    WHERE A.NUM > K.NUM
                                                                                 AND K.SHIPCOME = 'Y'
                                                     AND K.SHPIER = A.SHPIER ) = 0 THEN 'Y' ELSE 'N' END 
                           ELSE 'N' END SHIPCOME,
                           SHIPSAIL, 
                        CASE WHEN SHIPSCHED = 'Y' THEN
                        CASE WHEN ( SELECT COUNT(*) 
                            FROM TABLE3 D
                            WHERE D.NUM < A.NUM
                             AND D.SHPIER = A.SHPIER
                                  AND D.SHIPSCHED = 'Y' ) = 0 THEN 'Y' ELSE 'N' END 
                             ELSE  'N' END SHIPSCHED,
                         ( SELECT COUNT(*)  FROM TABLE3 K
                                     WHERE K.NUM < A.NUM
                                       AND K.SHPIER = A.SHPIER
                                       AND K.SHSHIPNAME = A.SHSHIPNAME
                                       AND K.SHDATEETB = A.SHDATEETB
                                       AND K.SHDATEETD = A.SHDATEETD
                                       AND K.SHAGENT = A.SHAGENT  ) as rowcnt
                        FROM TABLE3 A
                        ORDER BY SHDATEETB, SHETBTIME, SHPIER, SHSHIPNAME, SHHWAJU, SHHWAMUL
                        )
                        SELECT   NUM, 
                                 CASE WHEN rowcnt = 0 THEN SHDATE   ELSE '' END SHDATE ,  
                                  SHSEQ     ,  
                         IPDATE,
                        CASE WHEN rowcnt = 0 THEN SHDATEETB   ELSE '' END SHDATEETB ,     
                        CASE WHEN rowcnt = 0 THEN SHETBTIME   ELSE '' END SHETBTIME ,     
                        CASE WHEN rowcnt = 0 THEN SHDATEETD   ELSE '' END SHDATEETD ,     
                        CASE WHEN rowcnt = 0 THEN SHETDTIME   ELSE '' END SHETDTIME ,     
                        SHPIER ,     
                         PIERUNITCODE,
                        CASE WHEN rowcnt = 0 THEN SHPIERNM   ELSE '' END SHPIERNM ,     
                         SHSHIPNAME,
                        CASE WHEN rowcnt = 0 THEN SHSHIPNAME   ELSE '' END SHSHIPNAMEVESSL,     
                         SHHWAJU   ,  
                         SHHWAMUL  ,  
                         SHTANKNO  ,  
                         SHREMARK,
                         CASE WHEN rowcnt = 0 THEN SHAGENT   ELSE '' END SHAGENT,
                         INT(SHQTON) AS SHQTON,
                         ( FLOOR(SHJUWOLQTY) +  ( SELECT VALUE((SUM(DOUBLE(SUB.SHTTON))),0) FROM Main_Table SUB
                            WHERE SUB.NUM <= B.NUM )) AS SHTTON,
                         CURRENTDATE,
                         CURRENTTIME,  
                         SHIPCOME,
                         SHIPSAIL, 
                         SHIPSCHED,
                         rowcnt
                        FROM Main_Table B
                        where  SHIPCOME= 'Y';
        
		
	OPEN REFCURSOR;

END