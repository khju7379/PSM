DROP PROCEDURE PSSCMLIB.PSM_OUTSIDECONSTRUCT_SEQ;

CREATE PROCEDURE PSSCMLIB.PSM_OUTSIDECONSTRUCT_SEQ
( 
	P_OSDATE    VARCHAR(8)
    
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR						
		
              SELECT value(max(OSSEQ),0) + 1 AS OSSEQ
				FROM PSSCMLIB.PSM_OutSideConstruct
		        WHERE OSDATE = P_OSDATE;
                  

	OPEN REFCURSOR;

END