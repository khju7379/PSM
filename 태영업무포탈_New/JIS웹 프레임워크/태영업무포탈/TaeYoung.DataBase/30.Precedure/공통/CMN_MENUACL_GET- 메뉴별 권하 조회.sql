--DROP PROCEDURE TYJINFWLIB.CMN_MENUACL_GET;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_MENUACL_GET
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-03
-- ����       : �޴�Ʈ��(�����޴�) ��ȸ
-- ����       : EXEC CMN_MENUACL_GET 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENUACL_GET
(
	P_ACL_GRP				VARCHAR(50)
)
	
	RESULT SETS 1
	LANGUAGE SQL

P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT * FROM TYJINFWLIB.CMN_ACL A 
			LEFT JOIN TYJINFWLIB.CMN_LANG B ON A.ACL_ID=B.CODE AND B.PROGRAMID='MENU'
		WHERE A.ACL_GRP = P_ACL_GRP;

	OPEN REFCURSOR;

END P1

