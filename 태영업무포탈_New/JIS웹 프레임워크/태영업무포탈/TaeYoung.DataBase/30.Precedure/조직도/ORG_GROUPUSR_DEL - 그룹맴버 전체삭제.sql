--DROP PROCEDURE TYJINFWLIB.ORG_GROUPUSR_DEL;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_GROUPUSR_DEL 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-21
-- ����       : �׷�ɹ� �Է�
-- ����       : CALL ORG_GROUPUSR_ADD  ()
--		������ ��ȯ : PTORGUSR42I1 -> ORG_GROUPUSR_DEL  
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUPUSR_DEL
(
	  P_GRPID       VARCHAR (10) 
)
	LANGUAGE SQL
P1: BEGIN
	
	DELETE FROM TYJINFWLIB.ORG_GROUPUSR
	WHERE GRPID = P_GRPID;

END P1