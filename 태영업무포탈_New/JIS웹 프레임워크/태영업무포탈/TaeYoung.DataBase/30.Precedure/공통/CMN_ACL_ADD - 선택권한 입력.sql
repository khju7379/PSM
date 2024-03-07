-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_ACL_ADD
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-04
-- ����       : ���� �Է�
-- ����       : EXEC CMN_ACL_ADD 'ID', 'GROUP'
--		DB2 ��ȯ : �������ν����� UP_ACL_INSERT
--		������ ��ȯ : PTCMMBAS10I1 -> CMN_ACL_ADD
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_ACL_ADD
CREATE PROCEDURE TYJINFWLIB.CMN_ACL_ADD
(
		P_ACL_ID		VARCHAR(50)
	,	P_ACL_GRP		VARCHAR(50)
)
	LANGUAGE SQL

P1: BEGIN
	INSERT INTO TYJINFWLIB.CMN_ACL
		(
				ACL_TYPE
			,	ACL_ID
			,	ACL_GRP
		)
		VALUES 
		(
				'MENU'
			,	P_ACL_ID
			,	P_ACL_GRP
		);
END P1

