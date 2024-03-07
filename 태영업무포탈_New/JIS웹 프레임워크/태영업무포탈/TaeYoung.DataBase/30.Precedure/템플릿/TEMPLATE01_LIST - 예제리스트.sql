--DROP PROCEDURE TYJINFWLIB.TEMPLATE01_LIST;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : TEMPLATE01_LIST
-- 작성자     : 문광복
-- 작성일     : 2016-09-02
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.TEMPLATE01_LIST (1,20,'')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.TEMPLATE01_LIST 
( 
	P_CURRENTPAGEINDEX           INTEGER             ,  -- 목록의 현재페이지 번호  
    P_PAGESIZE                   INTEGER             ,  -- 목록의 한 페이지에 표현되는 글 목록수  
    P_SEARCHCONDITION            VARCHAR(4000)          -- 조회조건 내용  
)
    RESULT SETS 2
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	DECLARE P_STNUM                  INTEGER;   
	DECLARE P_FNNUM                  INTEGER;
	DECLARE P_SQLSTRING              VARCHAR(4000);   
	DECLARE P_SQLTOTALROWCOUNT       VARCHAR(4000);  
	DECLARE P_TABLE_QUERY 			 VARCHAR(4000);
	DECLARE P_COUNT_QUERY 			 VARCHAR(4000);

    PREV : BEGIN -- 값 설정
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ;
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ;
	END PREV;
    
    MAIN : BEGIN -- 실행부
        LIST : BEGIN -- 리스트
            DECLARE REFCURSOR INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR1 ; -- 커서생성 
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

        PAGING : BEGIN -- 페이징
            DECLARE REFCURSOR2 INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR2 ; -- 커서생성 
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