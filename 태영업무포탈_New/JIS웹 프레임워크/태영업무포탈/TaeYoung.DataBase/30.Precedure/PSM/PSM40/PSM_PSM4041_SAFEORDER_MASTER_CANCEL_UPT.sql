DROP PROCEDURE PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_CANCEL_UPT;

CREATE PROCEDURE PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_CANCEL_UPT
(
	IN P_SMFSSABUN        VARCHAR(6),
	IN P_SMFSDATE         VARCHAR(8),
	IN P_SMFSTIME         VARCHAR(6),
	IN P_SMFSWKCLOSE      VARCHAR(1),
	IN P_SMFSWKTEXT       VARCHAR(200),
	IN P_SMFSWKCANCEL     VARCHAR(1),
	IN P_SMWKTEAM         VARCHAR(6),
	IN P_SMWKDATE         VARCHAR(8),
	IN P_SMWKSEQ          NUMERIC(3,0),
	IN P_SMWKORAPPDATE    VARCHAR(8),
	IN P_SMWKORSEQ        NUMERIC(3,0)
)
	
LANGUAGE SQL

P1: BEGIN

	UPDATE PSSCMLIB.PSM_SAFEORDER_MASTER SET
		SMFSSABUN    = P_SMFSSABUN,
		SMFSDATE     = P_SMFSDATE,
		SMFSTIME     = P_SMFSTIME,
		SMFSWKCLOSE  = P_SMFSWKCLOSE,
		SMFSWKTEXT   = P_SMFSWKTEXT,
		SMFSWKCANCEL = P_SMFSWKCANCEL
	WHERE SMWKTEAM      = P_SMWKTEAM
	AND   SMWKDATE      = P_SMWKDATE
	AND   SMWKSEQ       = P_SMWKSEQ
	AND   SMWKORAPPDATE = P_SMWKORAPPDATE
	AND   SMWKORSEQ     = P_SMWKORSEQ;

END P1;