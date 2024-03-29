--DROP PROCEDURE PSSCMLIB.PSM_PSM4021_CHANGEASK_DEL;

CREATE PROCEDURE PSSCMLIB.PSM_PSM4021_CHANGEASK_DEL
(
	IN P_CAASKTEAM VARCHAR(6),
	IN P_CAASKDATE VARCHAR(8),
	IN P_CAASKSEQ  NUMERIC(3,0)
)

LANGUAGE SQL

P1: BEGIN
	
	DELETE FROM PSSCMLIB.PSM_CHANGEASK_DOC
	WHERE CAASKTEAM = P_CAASKTEAM
	AND   CAASKDATE = P_CAASKDATE
	AND   CAASKSEQ  = P_CAASKSEQ;

END P1;