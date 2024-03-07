--DROP PROCEDURE TYJINFWLIB.PTORGUSR42I1;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUPUSR_ADD 
-- 작성자     : 문광복
-- 작성일     : 2015-09-21
-- 설명       : 그룹맴버 입력
-- 예문       : CALL ORG_GROUPUSR_ADD  ()
--		프렌지 변환 : PTORGUSR42I1 -> ORG_GROUPUSR_ADD  
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUPUSR_ADD 
(
	  P_GRPID       VARCHAR (10) 
	, P_USRID       VARCHAR (10) 
	, P_COMPANYCODE VARCHAR (50) 
	, P_USRTYPE     CHAR	(1)
)
	LANGUAGE SQL
P1: BEGIN
	
	IF NOT EXISTS(	SELECT COMPANYCODE FROM ORG_GROUPUSR WHERE GRPID=P_GRPID AND USRID=P_USRID AND COMPANYCODE=P_COMPANYCODE 	) THEN

		INSERT INTO ORG_GROUPUSR
		(
			GRPID       
		,	USRID       
		,	COMPANYCODE 
		,	USRTYPE     
		)
		VALUES
		(
			P_GRPID       
		,	P_USRID       
		,	P_COMPANYCODE 
		,	P_USRTYPE     
		);

	ELSE

		UPDATE ORG_GROUPUSR
		SET
			USRTYPE = P_USRTYPE
		WHERE 
			GRPID=P_GRPID AND USRID=P_USRID AND COMPANYCODE=P_COMPANYCODE;

	END IF;

END P1