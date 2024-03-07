--DROP PROCEDURE PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_DEL;

CREATE PROCEDURE PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_DEL
(
	IN P_SMWKTEAM      VARCHAR(6) , 
	IN P_SMWKDATE      VARCHAR(8) , 
	IN P_SMWKSEQ       NUMERIC(3, 0),
	IN P_SMWKORAPPDATE VARCHAR(8) , 
	IN P_SMWKORSEQ     NUMERIC(3, 0)
)
LANGUAGE SQL

P1: BEGIN

	DELETE FROM PSSCMLIB.PSM_SAFEORDER_MASTER
	WHERE SMWKTEAM      = P_SMWKTEAM
	AND   SMWKDATE      = P_SMWKDATE
	AND   SMWKSEQ       = P_SMWKSEQ
	AND   SMWKORAPPDATE = P_SMWKORAPPDATE
	AND   SMWKORSEQ     = P_SMWKORSEQ;

END P1;