--DROP PROCEDURE TYJINFWLIB.PTORGUSR41I1;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_GROUPLANG_ADD 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-21
-- ����       : �׷�� �Է�
-- ����       : CALL ORG_GROUPLANG_ADD  ()
--		������ ��ȯ : PTORGUSR41I1 -> ORG_GROUPLANG_ADD    
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUPLANG_ADD 
(
	  P_GRPID    VARCHAR	(10) 
	, P_LANGCODE CHAR		(2) 
	, P_GRPNAME  VARGRAPHIC	(50) CCSID 1200
)
	LANGUAGE SQL
P1: BEGIN
	
	IF NOT EXISTS(	SELECT GRPID FROM ORG_GROUPLANG WHERE GRPID=P_GRPID AND LANGCODE=P_LANGCODE 	) THEN

		INSERT INTO ORG_GROUPLANG	
		(
			GRPID    
		,	LANGCODE 
		,	GRPNAME  
		)
		VALUES
		(
			P_GRPID    
		,	P_LANGCODE 
		,	P_GRPNAME 
		);

	ELSE

		UPDATE ORG_GROUPLANG
		SET
			GRPNAME = P_GRPNAME
		WHERE 
			GRPID=P_GRPID AND LANGCODE=P_LANGCODE;

	END IF;

END P1