DROP PROCEDURE PSSCMLIB.PSM_PSM4041_WORKORDER_GET_PONUM;

CREATE PROCEDURE PSSCMLIB.PSM_PSM4041_WORKORDER_GET_PONUM ( 
	IN P_WOORTEAM VARCHAR(6),
	IN P_WOORDATE VARCHAR(8),
	IN P_WOSEQ    NUMERIC(3,0)) 

DYNAMIC RESULT SETS 1 

P1 : BEGIN  -- ���� 

	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT
			WOPONUM1,
			WOLOCATIONCODE1,
			WOPONUM2,
			WOLOCATIONCODE2,
			WOPONUM3,
			WOLOCATIONCODE3,
			WOPONUM4,
			WOLOCATIONCODE4,
			WOPONUM5,
			WOLOCATIONCODE5,
			WOWORKTITLE
		FROM PSSCMLIB.PSM_WORKORDER
		WHERE WOORTEAM = P_WOORTEAM
		AND   WOORDATE = P_WOORDATE
		AND   WOSEQ    = P_WOSEQ;
		 
	OPEN REFCURSOR;
  
END;