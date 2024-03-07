-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_ACL_DEL
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-03
-- ����       : ��ü ���� ����
-- ����       : EXEC CMN_ACL_DEL 'GRP'
--		DB2 ��ȯ : �������ν����� UP_ACL_DELETE
--		������ ��ȯ : PTCMMBAS10D1 -> CMN_ACL_DEL
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_ACL_DEL
(
	P_ACL_GRP VARCHAR(50)
)
	LANGUAGE SQL

P1: BEGIN

	DELETE FROM TYJINFWLIB.CMN_ACL
	WHERE ACL_TYPE='MENU' AND ACL_GRP = P_ACL_GRP;

END P1

