-------------------------------------------------------------------------------------------
--
-- ���ν�����  : ORG_DEPT5_LIST
-- �ۼ���     : ����
-- �ۼ���     : 2015-09-16
-- ����       : �μ� ��ġ��4
-- ����       : CALL ORG_DEPT5_LIST (1,20,'','ko')
-- DB2 ��ȯ   : �������ν����� UP_DEPT_SEARCHVIEW5
--		������ ��ȯ : PTORGUSR20L5 -> ORG_DEPT5_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE ORG_DEPT5_LIST (
    P_CURRENTPAGEINDEX           INTEGER,       -- ����� ���������� ��ȣ  
    P_PAGESIZE                   INTEGER,       -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  
    P_SEARCHCONDITION            VARCHAR(4000)  ,       -- ��ȸ���� ����
    P_BUKRS                      VARCHAR(5),
    P_LANGCODE                   VARCHAR(2)

)
    LANGUAGE SQL
    RESULT SETS 1
    
P1: BEGIN
    DECLARE P_STNUM INTEGER ;
    DECLARE P_FNNUM INTEGER ;
    
    S1 : BEGIN -- �� ����
        SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
    END S1 ;
    
    MAIN : BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH ORIGINAL_DATA AS (
            SELECT ROW_NUMBER() OVER ( ORDER BY DL.DEPTNAME ASC) AS ROWNO
                  ,D.DEPTCODE
                  ,DL.DEPTNAME
              FROM ORG_DEPT AS D
              LEFT OUTER JOIN ORG_DEPTLANG AS DL
                ON D.COMPANYCODE = DL.COMPANYCODE
               AND D.DEPTCODE    = DL.DEPTCODE
               AND DL.LANGCODE   = P_LANGCODE
             WHERE D.KOSTL IS NOT NULL 
               AND D.COMPANYCODE = P_BUKRS
               AND 
               ( 
                     LENGTH(P_SEARCHCONDITION) > 1
               AND   DL.DEPTNAME LIKE '%' || P_SEARCHCONDITION ||'%'
               )
        )
        SELECT (SELECT COUNT(*) FROM ORIGINAL_DATA) + 1- A.ROWNO AS NO
              , A.*
          FROM ORIGINAL_DATA AS A
         WHERE A.ROWNO BETWEEN P_STNUM AND P_FNNUM
         ORDER BY ROWNO ASC;
           
        OPEN REFCURSOR ;
    END MAIN;
    
    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT   
          FROM ORG_DEPT AS D
          LEFT OUTER JOIN ORG_DEPTLANG AS DL
            ON D.COMPANYCODE = DL.COMPANYCODE
           AND D.DEPTCODE    = DL.DEPTCODE
           AND DL.LANGCODE   = P_LANGCODE
         WHERE D.KOSTL IS NOT NULL 
           AND D.COMPANYCODE = P_BUKRS
           AND 
             ( 
               LENGTH(P_SEARCHCONDITION) > 1
           AND DL.DEPTNAME LIKE '%' || P_SEARCHCONDITION ||'%'
             );
    
        OPEN REFCURSOR2 ;
    END TOTAL;
END P1