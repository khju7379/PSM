--DROP PROCEDURE CMN_LOG_LIST2;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_LOG_LIST2
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : ȸ�纰 �α׸���Ʈ�� ��ȸ�Ѵ�.
-- ����       : CALL CMN_LOG_LIST2 ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� UP_CONNECTION_LOG_LIST_COMP
-------------------------------------------------------------------------------------------
CREATE PROCEDURE CMN_LOG_LIST2
(
		P_CURRENTPAGEINDEX       INTEGER             -- ����� ���������� ��ȣ  
	,   P_PAGESIZE               INTEGER             -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  
	,   P_SEARCHCONDITION        VARCHAR(4000) 	 	 -- ��ȸ���� ����  
	,	P_DATE					 VARCHAR(10)		 -- ���̺��(��ȸ���̺��)
)
	RESULT SETS 2
	LANGUAGE SQL
P1: BEGIN -- ����
	
	DECLARE P_STNUM                  INTEGER;   
	DECLARE P_FNNUM                  INTEGER;
	DECLARE P_SQLSTRING              VARCHAR(4000);   
	DECLARE P_SQLTOTALROWCOUNT       VARCHAR(4000);  
	DECLARE P_TABLE_QUERY 			 VARCHAR(4000);
	DECLARE P_COUNT_QUERY 			 VARCHAR(4000);
	   
	S1: BEGIN -- �� ����
		SET P_STNUM = (P_PAGESIZE * (P_CURRENTPAGEINDEX - 1))  ||  1;   
		SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX;   
	END S1; 
	
	S2: BEGIN -- �����
		C1 : BEGIN -- ����Ʈ
			DECLARE REFCURSOR  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S1 ;  -- Ŀ������ 
			SET P_TABLE_QUERY = '
				WITH ORIGINAL_DATA AS (  
					SELECT 
						ROW_NUMBER() OVER() AS ROWNO
						, A.*
					FROM (
							SELECT COUNT(*) AS CNT, B.EMPID AS MAINDEPTCODE, B.DISPLAYNAME, D.COMPANY AS COMPANYNAME FROM TYJINFWLIB.' || P_DATE || ' A 
								JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID=B.EMPID
								JOIN TYJINFWLIB. ORG_COMPANYLANG D ON B.COMPANYCODE=D.COMPANYCODE AND D.LANGUAGECODE=''ko''
							WHERE LOG_TYPE = ''LOGIN''
							AND MACHINE_NAME=''EPWAS''
							AND B.MAINDEPTCODE = ''VENDOR''
							' || P_SEARCHCONDITION || '
							GROUP BY B.EMPID, B.DISPLAYNAME, D.COMPANY
						) A 
				) 
			  
				SELECT 
					* 
				FROM ORIGINAL_DATA
				WHERE ROWNO BETWEEN ' || CAST(P_STNUM AS VARCHAR(100)) || ' AND ' || CAST(P_FNNUM AS VARCHAR(100)) || '
				ORDER BY ROWNO ASC 
			';
			PREPARE S1 FROM P_TABLE_QUERY;
			OPEN REFCURSOR;
		END C1;
		C2: BEGIN -- ����¡
			DECLARE REFCURSOR2  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S2 ;  -- Ŀ������ 
			SET P_COUNT_QUERY = '
				SELECT 
					COUNT(*) AS TOTALCOUNT  
				FROM (
						SELECT COUNT(*) AS CNT, B.EMPID AS MAINDEPTCODE, B.DISPLAYNAME FROM TYJINFWLIB.' || P_DATE || ' A 
							JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID=B.EMPID
						WHERE LOG_TYPE = ''LOGIN''
						AND MACHINE_NAME=''EPWAS''
						AND B.MAINDEPTCODE = ''VENDOR''
						' || P_SEARCHCONDITION || '
						GROUP BY B.EMPID, B.DISPLAYNAME
				) A
			
			';
			PREPARE S2 FROM P_COUNT_QUERY;
			OPEN REFCURSOR2;
		END C2;
	END S2;
END P1