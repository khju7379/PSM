--DROP PROCEDURE TYJINFWLIB.ORG_GROUP_ADD;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUP_ADD
-- 작성자     : 문광복
-- 작성일     : 2015-09-21
-- 설명       : 그룹코드 입력
-- 예문       : CALL ORG_GROUP_ADD ()
--		프렌지 변환 : PTORGUSR40I1 -> ORG_GROUP_ADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP_ADD
(
	  P_GRPID    	VARCHAR (10) 
	, P_SHRRNG   	CHAR	(1) 
	, P_USEYN    	CHAR	(1) 
	, P_GRPTYPE  	VARCHAR (10) 
	, P_GRPEMAIL 	VARCHAR (80) 
	, P_GRPEXT   	VARCHAR (100) 
	, P_REGID 	VARCHAR (10) 
	--, P_REGDT		DATE
	, P_UPDID 	VARCHAR (10) 
	--, P_UPDDT    	DATE 
)
	LANGUAGE SQL
P1: BEGIN
	
	IF NOT EXISTS(	SELECT GRPID FROM PTORGUSR40 WHERE GRPID=P_GRPID 	) THEN

		INSERT INTO PTORGUSR40
		(
			GRPID    	
		,	SHRRNG   	
		,	USEYN    	
		,	GRPTYPE  	
		,	GRPEMAIL 	
		,	GRPEXT   	
		,	REGID 		
		,	REGDT		
		,	UPDID 		
		,	UPDDT    	
		)
		VALUES
		(
			P_GRPID    	
		,	P_SHRRNG   	
		,	P_USEYN    	
		,	P_GRPTYPE  	
		,	P_GRPEMAIL 	
		,	P_GRPEXT   	
		,	P_REGID 		
		,	CURRENT DATE		
		,	P_UPDID 		
		,	CURRENT DATE    	  
		);

	ELSE

		UPDATE PTORGUSR40
		SET
			SHRRNG   	= P_SHRRNG  
		,	USEYN    	= P_USEYN   
		,	GRPTYPE  	= P_GRPTYPE 
		,	GRPEMAIL 	= P_GRPEMAIL
		,	GRPEXT   	= P_GRPEXT  
		,	REGID 		= P_REGID 	
		--,	REGDT		= P_REGDT	
		,	UPDID 		= P_UPDID 	
		,	UPDDT    	= CURRENT DATE   
		WHERE 
			GRPID=P_GRPID;

	END IF;

END P1