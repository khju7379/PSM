--DROP PROCEDURE TYJINFWLIB.ORG_GROUP2_ADD;
-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_GROUP2_ADD
-- 작성자     : 문광복
-- 작성일     : 2015-09-21
-- 설명       : 그룹코드 입력
-- 예문       : CALL ORG_GROUP_ADD ()
--		프렌지 변환 : PTORGUSR40I1 -> ORG_GROUP2_ADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP2_ADD
(
	P_GRPID		VARCHAR(50),
	P_USEYN		CHAR(1),
	P_GRPTYPE	VARCHAR(10),
	P_GrpExt	NVARCHAR(100)
)
	LANGUAGE SQL
P1: BEGIN
	
	IF NOT EXISTS(	SELECT GRPID FROM TYJINFWLIB.ORG_GROUP WHERE GRPID=P_GRPID 	) THEN

		INSERT INTO TYJINFWLIB.ORG_GROUP
		(
			GRPID    	
		,	SHRRNG   	
		,	USEYN    	
		,	GRPTYPE  	
		,	GRPEXT   	
		,	REGDT 		
		,	GRPEMAIL		
		)
		VALUES
		(
			P_GRPID    	
		,	'1'   	
		,	P_USEYN    	
		,	P_GRPTYPE  	
		,	P_GRPEXT   	
		,	CURRENT DATE 		
		,	''		
		);

	ELSE

		UPDATE TYJINFWLIB.ORG_GROUP
		SET
			USEYN    	= P_USEYN   
		,	GRPTYPE  	= P_GRPTYPE 
		,	GRPEXT   	= P_GRPEXT  
		,	UPDDT    	= CURRENT DATE   
		WHERE 
			GRPID=P_GRPID;

	END IF;

END P1