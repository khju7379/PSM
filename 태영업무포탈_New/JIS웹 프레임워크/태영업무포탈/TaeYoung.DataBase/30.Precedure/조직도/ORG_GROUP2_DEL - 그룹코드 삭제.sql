--DROP PROCEDURE TYJINFWLIB.ORG_GROUP2_DEL;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_GROUP2_DEL 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-21
-- ����       : �׷��ڵ� �Է�
-- ����       : CALL ORG_GROUP2_DEL  ()
--		������ ��ȯ : PTORGUSR40D1 -> ORG_GROUP2_DEL 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP2_DEL 
(
	P_GRPID VARCHAR(50)
)
	LANGUAGE SQL
P1: BEGIN
	
	DELETE
	FROM TYJINFWLIB.ORG_GROUP
	WHERE GRPID = P_GRPID;

END P1