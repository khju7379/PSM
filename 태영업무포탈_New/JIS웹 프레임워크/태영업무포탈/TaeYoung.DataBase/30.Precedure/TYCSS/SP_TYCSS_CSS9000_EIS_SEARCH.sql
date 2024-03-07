DROP PROCEDURE TYJINFWLIB.SP_TYCSS_CSS9000_EIS_SEARCH;

--  Generate SQL 
--  Version:                   	V7R4M0 190621 
--  Generated on:              	21-05-11 15:58:37 
--  Relational Database:       	S78E0180 
--  Standards Option:          	Db2 for i 
SET PATH "QSYS","QSYS2","SYSPROC","SYSIBMADM","KSGPDM";

CREATE PROCEDURE TYJINFWLIB.SP_TYCSS_CSS9000_EIS_SEARCH
(
	IN P_JUNYYMM  VARCHAR(6))
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SP_TYCSS_CSS9000_EIS_SEARCH 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD ,
	ALWCPYDTA = *OPTIMIZE ,
	COMMIT = *NONE ,
	DECRESULT = (31,31,00) ,
	DYNDFTCOL = *NO ,
	DYNUSRPRF = *USER ,
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 
	
	DECLARE P_STNUM INTEGER;
	DECLARE P_FNNUM INTEGER;
	DECLARE P_SQLSTRING VARCHAR(4000);
	DECLARE P_SQLTOTALROWCOUNT VARCHAR(4000);
	DECLARE P_TABLE_QUERY VARCHAR(5000);
	DECLARE P_COUNT_QUERY VARCHAR(5000);

	MAIN : BEGIN  -- 실행부
		DECLARE REFCURSOR CURSOR WITH RETURN FOR
				
			WITH DUMMY AS 
			(             
				SELECT    
				CAST(P_JUNYYMM AS CHAR(6)) AS YYMM 
				FROM SYSIBM.SYSDUMMY1                      
			),             
			EISPL_TABLE AS 
			(              
				SELECT  VALUE(SUM(EDQPLQUAN),0) EDQPLQUAN 
				FROM TYSCMLIB.EDQUANPLMF                  
				LEFT OUTER JOIN DUMMY                     
				ON  1 = 1                      
				WHERE EDQCDDP = 'S00000'       
				AND EDQYEAR = SUBSTR(YYMM,1,4) 
			),         
			TABLE1 AS  
			(          
			   SELECT  
			   SUBSTR(IHJAKENDAT,1,6) AS ERYYMM, 
			   SUM(IHBLQTY) AS MONTHQTY          
			   FROM TYSCMLIB.USIIPHAF           
			   LEFT OUTER JOIN DUMMY             
			   ON 1 = 1                          
			   WHERE SUBSTR(IHJAKENDAT,1,4)  = SUBSTR(YYMM,1,4) 
			   AND   SUBSTR(IHJAKENDAT,1,6) <= YYMM             
			   GROUP BY SUBSTR(IHJAKENDAT,1,6)                  
			),                           
			TABLE2 AS                    
			(                            
				SELECT  ERYYMM,          
				VALUE((SELECT  EDQPLQUAN 
				FROM TYSCMLIB.EDQUANPLMF 
				WHERE EDQCDDP = 'S00000' 
				AND EDQYEAR||EDQMONTH = ERYYMM),0) AS PLMONQTY, 
				MONTHQTY,                 
				VALUE(( SELECT  EDUUSQUAN 
				FROM TYSCMLIB.EDQUANUSMF  
				WHERE EDUYYMM = ERYYMM    
				AND EDUCDDP = 'S00000' ),0) AS EISMONTHQTY 
				FROM TABLE1               
			),                            
			MAIN_TABLE AS                 
			(                             
			    SELECT                    
			    '1' AS GUBN,              
			    PLMONQTY,                 
			    CASE WHEN EISMONTHQTY <> 0 THEN EISMONTHQTY ELSE MONTHQTY END MONTHQTY 
			    FROM TABLE2               
			    LEFT OUTER JOIN  DUMMY    
			    ON 1 = 1                  
			    WHERE ERYYMM = YYMM       
			    UNION ALL                 
			    SELECT                    
			    '2' AS GUBN,              
			    SUM(PLMONQTY) PLMONQTY,   
			    SUM(CASE WHEN EISMONTHQTY <> 0 THEN EISMONTHQTY ELSE MONTHQTY END) MONTHQTY 
			    FROM TABLE2               
			    LEFT OUTER JOIN DUMMY     
			    ON 1 = 1                  
			    WHERE ERYYMM <= YYMM      
			    UNION ALL                 
			    SELECT                    
			    '3' AS GUBN,              
			    VALUE(MAX(EDQPLQUAN),0) PLMONQTY, 
			    SUM(CASE WHEN EISMONTHQTY <> 0 THEN EISMONTHQTY ELSE MONTHQTY END) MONTHQTY 
			    FROM TABLE2                 
			    LEFT OUTER JOIN EISPL_TABLE 
			    ON 1 = 1                    
			    LEFT OUTER JOIN  DUMMY      
			    ON 1 = 1                    
			    WHERE ERYYMM <= YYMM        
			)                               
			SELECT                          
			GUBN AS AMGUBN,                 
			PLMONQTY AS AMPLANQTY,          
			MONTHQTY AS AMRESULTQTY,        
			DOUBLE(TYSCMLIB.GET_PERSENT(MONTHQTY, PLMONQTY , 1))  AS AMACHRATE 
			FROM MAIN_TABLE;

		OPEN REFCURSOR;

	END MAIN;
END P1;

GRANT ALTER ,EXECUTE
ON SPECIFIC PROCEDURE TYJINFWLIB.SP_TYCSS_CSS9000_EIS_SEARCH
TO KSGPDM WITH GRANT OPTION;


CALL TYJINFWLIB.SP_TYCSS_CSS9000_EIS_SEARCH('202105')