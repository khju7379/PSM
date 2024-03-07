--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SMS_KBSABUN_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SMS_KBSABUN_LIST  (

    P_CURRENTPAGEINDEX           INTEGER             ,  -- ����� ���������� ��ȣ  
    P_PAGESIZE                   INTEGER             ,  -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  
	P_SEARCHCONDITION            VARCHAR(1000)          -- ��ȸ���� ����  
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
				  SELECT  KBSABUN,  KBHANGL
						   FROM TYSCMLIB.INKIBNMF
						   WHERE  KBBALCD NOT IN ('900','560')							 
							 AND  KBHANGL LIKE  '%'||P_SEARCHCONDITION||'%'
						  ORDER BY KBSABUN 
			), ORIGINAL_DATA  AS (
			SELECT  ROW_NUMBER() OVER(ORDER BY KBSABUN) AS ROWNO,           
					KBSABUN,
				    KBHANGL 
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
				 SELECT  KBSABUN,  KBHANGL
						   FROM TYSCMLIB.INKIBNMF
						   WHERE  KBBALCD NOT IN ('900','560')							 
							 AND  KBHANGL LIKE  '%'||P_SEARCHCONDITION||'%'
						  ORDER BY KBSABUN 
			), ORIGINAL_DATA  AS (
			SELECT  ROW_NUMBER() OVER(ORDER BY KBSABUN) AS ROWNO,           
					KBSABUN,
				    KBHANGL 
			FROM  TABLE1
			)
           SELECT COUNT(*) AS TOTALCOUNT
            FROM  ORIGINAL_DATA;
    
        OPEN REFCURSOR2;
    END TOTAL;
END P1