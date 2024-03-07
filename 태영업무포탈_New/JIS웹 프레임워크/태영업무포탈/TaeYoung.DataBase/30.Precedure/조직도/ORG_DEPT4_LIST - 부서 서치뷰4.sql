-------------------------------------------------------------------------------------------
--
-- ���ν�����  : ORG_DEPT4_LIST
-- �ۼ���     : ����
-- �ۼ���     : 2015-09-16
-- ����       : �μ� ��ġ��4
-- ����       : CALL ORG_DEPT4_LIST (1,20,'','ko')
-- DB2 ��ȯ   : �������ν����� UP_DEPT_SEARCHVIEW4
--		������ ��ȯ : PTORGUSR20L4 -> ORG_DEPT4_LIST
-------------------------------------------------------------------------------------------
CREATE PROCEDURE ORG_DEPT4_LIST (
    P_CURRENTPAGEINDEX           INTEGER,       -- ����� ���������� ��ȣ
    P_PAGESIZE                   INTEGER,       -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�
    P_SEARCHCONDITION            VARCHAR(4000)  ,       -- ��ȸ���� ����
    P_LANGCODE                   VARCHAR(2)
)
    LANGUAGE SQL
    RESULT SETS 2

P1: BEGIN
    DECLARE P_STNUM INTEGER ;
    DECLARE P_FNNUM INTEGER ;

    DECLARE GLOBAL TEMPORARY TABLE SESSION . T (
                DEPTCODE        VARCHAR (50)                 --�μ��ڵ�
            ,   DEPTNAME        VARGRAPHIC(100)  CCSID 1200  -- �μ���
    ) WITH REPLACE ;

    S1 : BEGIN -- �� ����
        SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
    END S1 ;

    INSERT INTO SESSION.T
        SELECT DEPTCODE
                     ,DEPTNAME
                 FROM(SELECT A.DEPTCODE
                            ,COALESCE(B.DEPTNAME, A.DISPLAYNAME) AS DEPTNAME
                        FROM ORG_DEPT AS A
                        LEFT OUTER JOIN ORG_DEPTLANG AS B
                          ON A.COMPANYCODE = B.COMPANYCODE
                         AND A.DEPTCODE    = B.DEPTCODE
                         AND B.LANGCODE    = P_LANGCODE
                       UNION ALL
                      SELECT A.EMPID AS DEPTCODE
                            ,B.USERLNAME || B.USERFNAME AS DEPTNAME
                        FROM ORG_USER AS A
                        LEFT OUTER JOIN ORG_USERLANG AS B
                          ON A.COMPANYCODE = B.COMPANYCODE
                         AND A.EMPID       = B.EMPID
                         AND B.LANGCODE    = P_LANGCODE
                 ) AS A
                WHERE A.DEPTCODE LIKE P_SEARCHCONDITION || '%'
                   OR A.DEPTNAME LIKE P_SEARCHCONDITION || '%'
                   ;

    M1 : BEGIN

        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        SELECT DEPTCODE
              ,DEPTNAME
          FROM(SELECT DEPTCODE
                     ,DEPTNAME
                     ,ROW_NUMBER ( ) OVER ( ORDER BY DEPTCODE ) AS ROWNO
                 FROM SESSION.T
          ) AS A
         WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM;


        OPEN REFCURSOR ;
    END M1;

    TOTAL : BEGIN
        DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
          SELECT COUNT ( * ) AS TOTALCOUNT FROM SESSION . T ;


        OPEN REFCURSOR2;

    END TOTAL;
END P1