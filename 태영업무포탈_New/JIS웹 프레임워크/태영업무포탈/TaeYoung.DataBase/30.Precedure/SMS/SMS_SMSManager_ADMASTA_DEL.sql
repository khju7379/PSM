DROP PROCEDURE TYJINFWLIB.SMS_SMSManager_ADMASTA_DEL;

CREATE PROCEDURE TYJINFWLIB.SMS_SMSManager_ADMASTA_DEL 
(
	  IN P_ADMGROUP       VARCHAR (10) 
)
	LANGUAGE SQL
P1: BEGIN	

		DELETE FROM TYSCMLIB.PSM_SMSManager_ADMASTA
		WHERE ADMGROUP= P_ADMGROUP ;
			

END P1