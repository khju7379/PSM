--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.TYCSI_GET_CARNO_LIST;
  
CREATE PROCEDURE TYJINFWLIB.TYCSI_GET_CARNO_LIST  (

    P_CURRENTPAGEINDEX           INTEGER             ,  -- 목록의 현재페이지 번호  
    P_PAGESIZE                   INTEGER             ,  -- 목록의 한 페이지에 표현되는 글 목록수  
    P_SEARCHCONDITION            VARCHAR(1000)          -- 조회조건 내용  

)
    LANGUAGE SQL
    RESULT SETS 2
P1: BEGIN

    DECLARE P_STNUM INTEGER ;
    DECLARE P_FNNUM INTEGER ;
    
    S1 : BEGIN -- 값 설정
        SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
    END S1 ;
    
    MAIN : BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH ORIGINAL_DATA AS (          
			 SELECT      
			 ROW_NUMBER() OVER () AS ROWNO,                                 
			 TRIM(TRNUMNO1)||''||TRIM(TRNUMNO2) AS TRNUMN, 
			 (TRUNSONG||''||SKCODE.CDDESC1)     AS SOSOK,     
			 TRUNNAME                                     
			 FROM TYSCMLIB.UTATRUKF AS TRUK               
			 LEFT OUTER JOIN TYSCMLIB.UTICODEF AS SKCODE  
			 ON              'SK' = SKCODE.CDINDEX        
			 AND    TRUK.TRUNSONG = SKCODE.CDCODE         
			 WHERE TRNUMNO2 LIKE '%'||P_SEARCHCONDITION
        )        
        SELECT (SELECT COUNT(*) FROM ORIGINAL_DATA) + 1 - A.ROWNO AS NO,A.*
          FROM ORIGINAL_DATA AS A
         WHERE (ROWNO BETWEEN P_STNUM AND P_FNNUM)
         ORDER BY A.ROWNO ASC;
    
        OPEN REFCURSOR;
    END MAIN;
    
    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT
          FROM TYSCMLIB.UTATRUKF AS TRUK   
         WHERE 1=1
           AND TRNUMNO2 LIKE '%'||P_SEARCHCONDITION;
    
        OPEN REFCURSOR2;
    END TOTAL;
END P1