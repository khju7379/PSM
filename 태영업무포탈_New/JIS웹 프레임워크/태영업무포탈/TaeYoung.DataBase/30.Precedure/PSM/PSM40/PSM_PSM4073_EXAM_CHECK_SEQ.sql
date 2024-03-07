CREATE PROCEDURE PSSCMLIB.PSM_PSM4073_EXAM_CHECK_SEQ ( 
	IN P_PECTEAM VARCHAR(6) , 
	IN P_PECDATE VARCHAR(8) ) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 

	P1 : BEGIN  -- 시작 
MAIN : BEGIN  -- 실행부 
LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
  
			SELECT VALUE ( MAX ( PECSEQ ) , 0 ) + 1 AS PECSEQ 
			FROM PSSCMLIB . PSM_EXAM_CHECK 
			WHERE PECTEAM = P_PECTEAM 
			AND PECDATE = P_PECDATE 
			; 
  
		OPEN REFCURSOR ; 
  
	END LIST ; 
  
END MAIN ; 
END  ; 
  
GRANT ALTER , EXECUTE   
ON SPECIFIC PROCEDURE PSSCMLIB.PSM_PSM4073_EXAM_CHECK_SEQ 
TO LSHPDM WITH GRANT OPTION ;
