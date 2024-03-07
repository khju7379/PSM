--DROP PROCEDURE TYJINFWLIB.TEMPLATE01_LIST;
-------------------------------------------------------------------------------------------
--
-- ���ν����� : TEMPLATE01_LIST
-- �ۼ���     : ������
-- �ۼ���     : 2016-09-02
-- ����       : ���� ����Ʈ
-- ����       : CALL TYJINFWLIB.TEMPLATE01_LIST (1,20,'')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.TEMPLATE01_LIST 
( 
	P_CURRENTPAGEINDEX           INTEGER             ,  -- ����� ���������� ��ȣ  
    P_PAGESIZE                   INTEGER             ,  -- ����� �� �������� ǥ���Ǵ� �� ��ϼ�  
    P_SEARCHCONDITION            VARCHAR(4000)          -- ��ȸ���� ����  
)
    RESULT SETS 2
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE P_STNUM                  INTEGER;   
	DECLARE P_FNNUM                  INTEGER;
	DECLARE P_SQLSTRING              VARCHAR(4000);   
	DECLARE P_SQLTOTALROWCOUNT       VARCHAR(4000);  
	DECLARE P_TABLE_QUERY 			 VARCHAR(4000);
	DECLARE P_COUNT_QUERY 			 VARCHAR(4000);

    PREV : BEGIN -- �� ����
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
	END PREV;
    
    MAIN : BEGIN -- �����
        LIST : BEGIN -- ����Ʈ
            DECLARE REFCURSOR INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR1 ; -- Ŀ������ 
            SET P_TABLE_QUERY = '
                WITH ORIGINAL_DATA AS (  
                    SELECT 
                        ROW_NUMBER() OVER() AS ROWNO
                    ,   IDX
                    ,   COLUMNS1
                    ,   COLUMNS2
                    ,   COLUMNS3
                    ,   COLUMNS4
                    ,   COLUMNS5
                    ,   COLUMNS6
                    ,   COLUMNS7
					,   COLUMNS8
                    ,   COLUMNS9
					,	CRTID
					,	CRTDT
					,	UPDID
					,	UPDDT
                    FROM TYJINFWLIB.TEMPLETE01
                    WHERE 1=1
                        ' || P_SEARCHCONDITION || '
                ) 
              
                SELECT 
					* 
				FROM ORIGINAL_DATA
				WHERE ROWNO BETWEEN ' || CAST(P_STNUM AS VARCHAR(100)) || ' AND ' || CAST(P_FNNUM AS VARCHAR(100)) || '
				ORDER BY ROWNO ASC 
            ' ;
            PREPARE CUR1 FROM P_TABLE_QUERY ;
            OPEN REFCURSOR ;
        END LIST ;

        PAGING : BEGIN -- ����¡
            DECLARE REFCURSOR2 INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR2 ; -- Ŀ������ 
            SET P_COUNT_QUERY = '
                SELECT 
                        COUNT(*) AS TOTALCOUNT  
                    FROM TYJINFWLIB.TEMPLETE01
                    WHERE 1=1
                        ' || P_SEARCHCONDITION || '
            ' ;
            PREPARE CUR2 FROM P_COUNT_QUERY ;
            OPEN REFCURSOR2 ;
        END PAGING ;
    END MAIN ;
END