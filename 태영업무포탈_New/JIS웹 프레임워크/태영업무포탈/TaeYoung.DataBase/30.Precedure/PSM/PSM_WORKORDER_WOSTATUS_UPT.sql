--DROP PROCEDURE PSSCMLIB.PSM_WORKORDER_WOSTATUS_UPT;
  
CREATE PROCEDURE PSSCMLIB.PSM_WORKORDER_WOSTATUS_UPT ( 
	IN P_WOSTATUS VARCHAR(1),
	IN P_WOORTEAM VARCHAR(6),
	IN P_WOORDATE VARCHAR(8),
	IN P_WOSEQ    NUMERIC(3,0))

LANGUAGE SQL

P1 : BEGIN

	UPDATE PSSCMLIB.PSM_WorkOrder SET
		WOSTATUS = P_WOSTATUS
	WHERE WOORTEAM = P_WOORTEAM
	AND   WOORDATE = P_WOORDATE
	AND   WOSEQ    = P_WOSEQ;

END P1;