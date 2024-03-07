--DROP PROCEDURE TYJINFWLIB.ORG_GROUP2_ADD;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_GROUP2_ADD
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-21
-- ����       : �׷��ڵ� �Է�
-- ����       : CALL ORG_GROUP_ADD ()
--		������ ��ȯ : PTORGUSR40I1 -> ORG_GROUP2_ADD
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