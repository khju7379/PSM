--DROP PROCEDURE TYJINFWLIB.PTORGUSR40D1;
-------------------------------------------------------------------------------------------
-- ���ν����� : ORG_GROUP_DEL 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-21
-- ����       : �׷��ڵ� �Է�
-- ����       : CALL ORG_GROUP_DEL  ()
--		������ ��ȯ : PTORGUSR40D1 -> ORG_GROUP_DEL 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_GROUP_DEL 
	LANGUAGE SQL
P1: BEGIN
	
	DELETE
	FROM ORG_GROUP;

END P1