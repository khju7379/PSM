-------------------------------------------------------------------------------------------
--
-- ���ν�����  : ORG_DEPT_LIST 
-- �ۼ���     : ����
-- �ۼ���     : 2015-09-16
-- ����       : �μ� ��ġ��
-- ����       : CALL ORG_DEPT_LIST  (1,20,'')
-- DB2 ��ȯ   : �������ν����� UP_DEPT_SEARCHVIEW
--		������ ��ȯ : PTORGUSR20L1 -> ORG_DEPT_LIST 
-------------------------------------------------------------------------------------------
CREATE PROCEDURE ORG_DEPT_LIST  (

    P_CURRENTPAGEINDEX           INTEGER             ,  -- ����� ���������� ��ȣ  
    P_PAGESIZE                   INTEGER             ,  -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  
    P_SEARCHCONDITION            VARCHAR(4000)          -- ��ȸ���� ����  

)
    LANGUAGE SQL
    RESULT SETS 2
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
            SELECT ROW_NUMBER() OVER (ORDER BY DEPTCODE ASC) AS ROWNO
                  ,COMPANYCODE
                  ,DEPTCODE
                  ,DEPTORDER
                  ,PARENTDEPTCODE
                  ,DISPLAYNAME
              FROM ORG_DEPT
             WHERE 1=1
               AND COMPANYCODE     = '1000'
               AND PARENTDEPTCODE != ''
               AND (DEPTCODE    LIKE '%'|| P_SEARCHCONDITION || '%'
                OR  DISPLAYNAME LIKE '%'|| P_SEARCHCONDITION || '%'
                )
        )
        
        SELECT (SELECT COUNT(*) FROM ORIGINAL_DATA) + 1 - A.ROWNO AS NO
             ,A.*
          FROM ORIGINAL_DATA AS A
         WHERE (ROWNO BETWEEN P_STNUM AND P_FNNUM)
           AND COMPANYCODE    =  '1000'
           AND PARENTDEPTCODE != ''
         ORDER BY A.ROWNO ASC;
    
        OPEN REFCURSOR;
    END MAIN;
    
    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) AS TOTALCOUNT
          FROM ORG_DEPT
         WHERE 1=1
           AND COMPANYCODE     = '1000'
           AND PARENTDEPTCODE != ''
           AND (DEPTCODE    LIKE '%'|| P_SEARCHCONDITION || '%'
            OR  DISPLAYNAME LIKE '%'|| P_SEARCHCONDITION || '%'
            );
    
        OPEN REFCURSOR2;
    END TOTAL;
END P1