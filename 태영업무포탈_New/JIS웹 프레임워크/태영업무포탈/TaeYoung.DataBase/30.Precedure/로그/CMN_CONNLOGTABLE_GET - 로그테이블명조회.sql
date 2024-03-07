-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_CONNLOGTABLE_GET
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : �����ϴ� �α����̺��� ��ȸ�Ѵ�. 
-- ����       : CALL CMN_CONNLOGTABLE_GET ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� UP_LOGGING_TABLE_SELECT
-------------------------------------------------------------------------------------------
CREATE PROCEDURE CMN_CONNLOGTABLE_GET ()
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		
		SELECT * FROM INFORMATION_SCHEMA.Tables WHERE TABLE_SCHEMA = 'TYJINFWLIB' AND TABLE_NAME LIKE 'LOG_%';
	
	OPEN REFCURSOR;
    
END P1