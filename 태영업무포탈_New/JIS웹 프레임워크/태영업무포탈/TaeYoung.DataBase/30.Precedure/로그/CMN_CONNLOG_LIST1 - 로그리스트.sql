--DROP PROCEDURE CMN_LOG_LIST1;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_LOG_LIST1
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-03
-- ����       : �α׸���Ʈ�� ��ȸ�Ѵ�.
-- ����       : CALL CMN_LOG_LIST1 ('2006909','1000','TS1301')
--		DB2 ��ȯ : �������ν����� UP_CONNECTION_LOG_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE CMN_LOG_LIST1 
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
		SET P_STNUM = (P_PAGESIZE * (P_CURRENTPAGEINDEX - 1)) + 1;   
		SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX;   
	END S1; 
	
	S2: BEGIN -- �����
		C1 : BEGIN -- ����Ʈ
			DECLARE REFCURSOR  INSENSITIVE SCROLL CURSOR WITH RETURN FOR S1 ;  -- Ŀ������ 
			SET P_TABLE_QUERY = '
				WITH ORIGINAL_DATA AS (  
					SELECT 
						ROW_NUMBER() OVER() AS ROWNO, 
						A.IDX
						, CASE WHEN A.BIZ_TYPE = ''PASSCHG'' THEN ''��й�ȣ����'' ELSE CASE WHEN A.BIZ_TYPE = ''SUPERPW'' THEN ''����������'' ELSE ''���۷α���'' END END AS BIZ_TYPE  
						, A.OCCUR_TIME
						, A.USER_IP
						, A.USER_ID
						,B.DISPLAYNAME 
						,C.DISPLAYNAME AS DEPTNAME
						,D.COMPANY AS COMPANYNAME
					FROM TYJINFWLIB.' || P_DATE || ' A 
						LEFT JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID = B.EMPID
						LEFT JOIN TYJINFWLIB.ORG_DEPT C ON B.MAINDEPTCODE = C.DEPTCODE
						LEFT JOIN TYJINFWLIB.ORG_COMPANYGLO D ON B.COMPANYCODE=D.COMPANYCODE AND D.LANGUAGECODE=''ko''
					WHERE A.LOG_TYPE = ''LOGIN''
						--AND A.MACHINE_NAME=''EPWAS'' 
						' || P_SEARCHCONDITION || '
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
					FROM TYJINFWLIB.' || P_DATE || ' A LEFT JOIN TYJINFWLIB.ORG_USER B ON A.USER_ID = B.EMPID
					WHERE LOG_TYPE = ''LOGIN''
						--AND A.MACHINE_NAME=''EPWAS''
						' || P_SEARCHCONDITION || '
			
			';
			PREPARE S2 FROM P_COUNT_QUERY;
			OPEN REFCURSOR2;
		END C2;
	END S2;
END P1