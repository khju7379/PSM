--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.TYCSI_GET_HWAMUL_LIST;
  
CREATE PROCEDURE TYJINFWLIB.TYCSI_GET_HWAMUL_LIST  (

    P_CURRENTPAGEINDEX           INTEGER             ,  -- ����� ���������� ��ȣ  
    P_PAGESIZE                   INTEGER             ,  -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  
    P_SEARCHCONDITION            VARCHAR(1000)       ,   -- ��ȸ���� ����  
	P_INDEX                      VARCHAR(2)          ,
	P_HWAJU                    	 VARCHAR(50)
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
            WITH TABLE1 AS (
				  SELECT  DISTINCT 
								  CDCODE,  
								  CDDESC1  
						   FROM TYSCMLIB.UTICODEF AS HMCODE 
						   LEFT OUTER JOIN TYSCMLIB.UTIIPGOF AS IPGO 
							  ON   P_INDEX  = HMCODE.CDINDEX       
							 AND   IPGO.IPHWAMUL = HMCODE.CDCODE 
						   WHERE  CDINDEX = P_INDEX 
							 AND  IPHWAJU IN ( SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
							 AND  CDDESC1  LIKE  '%'||P_SEARCHCONDITION||'%'
						  ORDER BY CDDESC1 
			), ORIGINAL_DATA  AS (
			SELECT  ROW_NUMBER() OVER(ORDER BY CDCODE) AS ROWNO,           
					CDCODE,
				    CDDESC1 
			FROM  TABLE1
			)
			SELECT A.*
			 FROM ORIGINAL_DATA AS A
			 WHERE A.ROWNO BETWEEN P_STNUM AND P_FNNUM
			ORDER BY A.ROWNO ASC;
    
        OPEN REFCURSOR;
    END MAIN;
    
    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
		  WITH TABLE1 AS (
				  SELECT  DISTINCT 
								  CDCODE,  
								  CDDESC1  
						   FROM TYSCMLIB.UTICODEF AS HMCODE 
						   LEFT OUTER JOIN TYSCMLIB.UTIIPGOF AS IPGO 
							  ON   P_INDEX  = HMCODE.CDINDEX       
							 AND   IPGO.IPHWAMUL = HMCODE.CDCODE 
						   WHERE  CDINDEX = P_INDEX 
							 AND  IPHWAJU IN ( SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST(''|| P_HWAJU ||'' AS VARCHAR(100)), ',')) AS InTable )
							 AND  CDDESC1  LIKE  '%'||P_SEARCHCONDITION||'%'
						  ORDER BY CDDESC1 
			), ORIGINAL_DATA  AS (
			SELECT  ROW_NUMBER() OVER(ORDER BY CDCODE) AS ROWNO,           
					CDCODE,
				CDDESC1 
			FROM  TABLE1
			)
           SELECT COUNT(*) AS TOTALCOUNT
            FROM  ORIGINAL_DATA;
    
        OPEN REFCURSOR2;
    END TOTAL;
END P1