--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.TYCSI_GET_CODE_LIST;
  
CREATE PROCEDURE TYJINFWLIB.TYCSI_GET_CODE_LIST  (

    P_CURRENTPAGEINDEX           INTEGER             ,  -- ����� ���������� ��ȣ  
    P_PAGESIZE                   INTEGER             ,  -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  
    P_SEARCHCONDITION            VARCHAR(1000)       ,   -- ��ȸ���� ����  
	P_INDEX                      VARCHAR(2)          

)
    LANGUAGE SQL
    RESULT SETS 2
P1: BEGIN

    DECLARE P_STNUM INTEGER ;
    DECLARE P_FNNUM INTEGER ;
    
    S1 : BEGIN -- �� ����
        SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
    END S1 ;
    
    MAIN : BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH ORIGINAL_DATA AS (          
		
			  SELECT  ROW_NUMBER() OVER(ORDER BY CDCODE) AS ROWNO,               
			          CDCODE, 
                       CDDESC1 
                FROM TYSCMLIB.UTICODEF                  
               WHERE  CDINDEX = P_INDEX 
                 AND  CDDESC1  LIKE  '%'||P_SEARCHCONDITION||'%'                    
              ORDER BY CDCODE 
        )        
        SELECT A.*
          FROM ORIGINAL_DATA AS A
         WHERE (ROWNO BETWEEN P_STNUM AND P_FNNUM)
         ORDER BY A.ROWNO ASC;
    
        OPEN REFCURSOR;
    END MAIN;
    
    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT
          FROM TYSCMLIB.UTICODEF  
         WHERE CDINDEX = P_INDEX
           AND CDDESC1  LIKE '%'||P_SEARCHCONDITION||'%';                    
    
        OPEN REFCURSOR2;
    END TOTAL;
END P1