--DROP PROCEDURE TYJINFWLIB.PTCMMMSG31L2;
-------------------------------------------------------------------------------------------
-- ���ν����� : MSG_CONVUSR_LIST 
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-14
-- ����       : �޽��� ��ȭ����� ��ȸ�Ͽ� ������ �����ϰ� ������ ��ȭ��ϸ���Ʈ�� �����´�.
-- ����       : CALL MSG_CONVUSR_LIST  ('2006909','1000','TS1301')
--		������ ��ȯ : PTCMMMSG31L2 -> MSG_CONVUSR_LIST 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.MSG_CONVUSR_LIST  
(
	P_CONVERSATIONID		INTEGER
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN

	DECLARE REFCURSOR CURSOR WITH RETURN FOR

		SELECT * FROM TYJINFWLIB.MSG_CONVUSR WHERE CONVERSATIONID=P_CONVERSATIONID;

	OPEN REFCURSOR;

END P1