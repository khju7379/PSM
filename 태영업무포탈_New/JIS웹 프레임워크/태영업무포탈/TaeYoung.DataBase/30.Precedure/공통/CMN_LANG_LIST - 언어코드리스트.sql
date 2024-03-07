-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_LANG_LIST
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : ����ڵ帮��Ʈ�� ��ȸ�Ѵ�.
-- ����       : CALL CMN_LANG_LIST ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� UP_LANG_CODE_LIST
--		������ ��ȯ : PTCMMBAS30L1 -> CMN_LANG_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_LANG_LIST 
(
	P_PROGRAMID VARCHAR(50),
	P_CODE VARCHAR(4000),
	P_LANGCODE CHAR(2)
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE P_QUERY VARCHAR(4000);
	
	--DECLARE REFCURSOR CURSOR WITH RETURN FOR P_QUERY;
	DECLARE REFCURSOR  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S1 ;  -- Ŀ������ 

	SET P_QUERY = '
			SELECT CODE,
				CASE LENGTH(COALESCE(' || P_LANGCODE || ', '''')) 
					WHEN 0 
		   				THEN KO 
		   			ELSE 
		   				' || P_LANGCODE || ' END AS LANG_TEXT 
			FROM TYJINFWLIB.CMN_LANG
			WHERE PROGRAMID = ''' || P_PROGRAMID || ''' AND CODE IN (' || P_CODE || ')
		';
	
	PREPARE S1 FROM P_QUERY;
	
	OPEN REFCURSOR;
END P1