--DROP PROCEDURE PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN;
  
CREATE PROCEDURE PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN ( 
	IN P_WOORTEAM VARCHAR(6) , 
	IN P_WOORDATE VARCHAR(8) , 
	IN P_WOSEQ NUMERIC(3, 0) ) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	DECRESULT = (31, 31, 00) , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   

P1 : BEGIN

	MAIN : BEGIN  -- �����
		
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
			
			SELECT
			WOAPPSOSABUN1 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPSOSABUN1 <> ''

			UNION ALL

			SELECT
			WOAPPSOSABUN2 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPSOSABUN2 <> ''

			UNION ALL

			SELECT
			WOAPPSOSABUN3 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPSOSABUN3 <> ''

			UNION ALL

			SELECT
			WOAPPSOSABUN4 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPSOSABUN4 <> ''

			UNION ALL

			SELECT
			WOAPPSOSABUN5 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPSOSABUN5 <> ''

			UNION ALL

			SELECT
			WOAPPRESABUN1 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPRESABUN1 <> ''

			UNION ALL

			SELECT
			WOAPPRESABUN2 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPRESABUN2 <> ''

			UNION ALL

			SELECT
			WOAPPRESABUN3 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPRESABUN3 <> ''

			UNION ALL

			SELECT
			WOAPPRESABUN4 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPRESABUN4 <> ''

			UNION ALL

			SELECT
			WOAPPRESABUN5 AS SABUN
			FROM PSSCMLIB.PSM_WORKORDER
			WHERE  WOORTEAM = P_WOORTEAM
			AND    WOORDATE = P_WOORDATE
			AND    WOSEQ    = P_WOSEQ
			AND    WOAPPRESABUN5 <> '';
  
		OPEN REFCURSOR;
	END MAIN;

END P1;


CALL PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN('A20000','20230320', 1);