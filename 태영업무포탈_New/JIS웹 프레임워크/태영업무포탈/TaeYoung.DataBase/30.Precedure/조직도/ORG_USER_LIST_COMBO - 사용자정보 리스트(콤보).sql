-------------------------------------------------------------------------------------------
-- 프로시저명 : ORG_USER_LIST_COMBO
-- 작성자     : 김희섭
-- 작성일     : 2014-04-03
-- 설명       : 사용자 정보
-- 예문       : CALL ORG_USER_LIST_COMBO ('','ko')
-- DB2 변환 : 
--		프렌지 변환 : PTORGUSR70L3 -> ORG_USER_LIST_COMBO
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.ORG_USER_LIST_COMBO ( IN P_SEARCHCONDITION VARCHAR(4000),
                                        IN P_LANGCODE CHAR(2) )
    RESULT SETS 2
    LANGUAGE SQL
    

P1 : BEGIN -- 시작
    
    DECLARE P_SQLSTRING VARCHAR ( 4000 ) ;
    DECLARE P_SQLTOTALROWCOUNT VARCHAR ( 4000 ) ;
    DECLARE P_TABLE_QUERY           VARCHAR ( 4000 ) ;
    DECLARE P_COUNT_QUERY           VARCHAR ( 4000 ) ;
    
    
    S2 : BEGIN -- 실행부
        C1 : BEGIN -- 리스트
            DECLARE REFCURSOR INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR1 ; -- 커서생성 
            SET P_TABLE_QUERY = '
                WITH ORIGINAL_DATA AS (  
                    SELECT 
                        ROW_NUMBER() OVER(ORDER BY C.USERLNAME, C.USERFNAME) AS ROWNO
                    ,   A.COMPANYCODE
                    ,   B.COMPANY
                    ,   A.EMPID
                    ,   C.USERLNAME || C.USERFNAME AS USERNAME
                    ,   A.MAINDEPTCODE
                    ,   D.DEPTNAME
                    ,   A.RANKCODE
                    ,   E.RANKNAME
                    FROM ORG_USER A
                        JOIN ORG_COMPANYLANG B 
                            ON (A.COMPANYCODE=B.COMPANYCODE AND B.LANGUAGECODE=''' || P_LANGCODE || ''')
                        JOIN ORG_USERLANG C 
                            ON (A.COMPANYCODE=C.COMPANYCODE AND A.EMPID=C.EMPID AND C.LANGCODE=''' || P_LANGCODE || ''')
                        JOIN ORG_DEPTLANG 
                            D ON (A.COMPANYCODE=D.COMPANYCODE AND A.MAINDEPTCODE=D.DEPTCODE AND D.LANGCODE=''' || P_LANGCODE || ''')
                        JOIN ORG_RANK 
                            E ON (A.COMPANYCODE=E.COMPANYCODE AND A.RANKCODE=E.RANKCODE AND E.LANGCODE=''' || P_LANGCODE || ''')
                    WHERE 1=1
                        ' || P_SEARCHCONDITION || '
                ) 
              
                SELECT 
                    * 
                FROM ORIGINAL_DATA
                WHERE 1=1
                ORDER BY ROWNO ASC 
            ' ;
            PREPARE CUR1 FROM P_TABLE_QUERY ;
            OPEN REFCURSOR ;
        END C1 ;
        C2 : BEGIN -- 페이징
            DECLARE REFCURSOR2 INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR2 ; -- 커서생성 
            SET P_COUNT_QUERY = '
                SELECT 
                        COUNT(*) AS TOTALCOUNT  
                    FROM ORG_USER A
                        JOIN ORG_COMPANYLANG B 
                            ON (A.COMPANYCODE=B.COMPANYCODE AND B.LANGUAGECODE=''' || P_LANGCODE || ''')
                        JOIN ORG_USERLANG C 
                            ON (A.COMPANYCODE=C.COMPANYCODE AND A.EMPID=C.EMPID AND C.LANGCODE=''' || P_LANGCODE || ''')
                        JOIN ORG_DEPTLANG 
                            D ON (A.COMPANYCODE=D.COMPANYCODE AND A.MAINDEPTCODE=D.DEPTCODE AND D.LANGCODE=''' || P_LANGCODE || ''')
                        JOIN ORG_RANK 
                            E ON (A.COMPANYCODE=E.COMPANYCODE AND A.RANKCODE=E.RANKCODE AND E.LANGCODE=''' || P_LANGCODE || ''')
                    WHERE 1=1
                        ' || P_SEARCHCONDITION || '
            
            ' ;
            PREPARE CUR2 FROM P_COUNT_QUERY ;
            OPEN REFCURSOR2 ;
        END C2 ;
    END S2 ;
END