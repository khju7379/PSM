-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_ACL_GRP_DEL 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-03
-- ����       : ���� ����
-- ����       : EXEC CMN_ACL_GRP_DEL  'GRP'
--		DB2 ��ȯ : �������ν����� UP_ACL_GRP_DELETE
--		������ ��ȯ : PTCMMBAS10D2 -> CMN_ACL_GRP_DEL 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_ACL_GRP_DEL
CREATE PROCEDURE TYJINFWLIB.CMN_ACL_GRP_DEL
(
	P_ACL_ID		VARCHAR(50)
)
	LANGUAGE SQL

P1: BEGIN

	DELETE FROM TYJINFWLIB.CMN_ACL 
	WHERE
			ACL_TYPE	= 'MENU'
	AND		ACL_ID		= P_ACL_ID
	;
END P1

