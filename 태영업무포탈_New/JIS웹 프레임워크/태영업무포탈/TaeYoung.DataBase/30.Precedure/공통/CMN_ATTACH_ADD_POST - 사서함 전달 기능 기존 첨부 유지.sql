-------------------------------------------------------------------------------------------
-- 프로시저명  : CMN_ATTACH_ADD_POST
-- 작성자      : 김희섭
-- 작성일      : 2016-09-26
-- 설명        : 사서함 전달기능 기존첨부 유지
-- 예문        : CALL CMN_ATTACH_ADD_POST ('TEMPLETE01','10')
-- DB2 변환    : 이전프로시져명 UP_ATTACH_FILE_INSERT_POST
-- 수정        : 
-- 프렌지 변환 :
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_ATTACH_ADD_POST 
(
     P_SEQ  INTEGER
    ,P_REF  INTEGER
)
    --RESULT SETS 1
    LANGUAGE SQL

M1: BEGIN
    IF EXISTS(SELECT * FROM CMN_ATTACH WHERE ATTACH_TYPE = 'POST' AND ATTACH_NO = P_REF )
    THEN
        INSERT INTO CMN_ATTACH
        (
            ATTACH_TYPE
        ,   ATTACH_NO
        ,   ATTACH_UNID
        ,   FILE_NAME
        ,   FILE_SIZE
        ,   FILE_MIME
        ,   FILE_EXT
        ,   FILE_PATH
        )
        SELECT ATTACH_TYPE
           ,   P_SEQ AS ATTACH_NO
           ,   ATTACH_UNID
           ,   FILE_NAME
           ,   FILE_SIZE
           ,   FILE_MIME
           ,   FILE_EXT
           ,   FILE_PATH
          FROM CMN_ATTACH
         WHERE ATTACH_TYPE = 'POST'
           AND ATTACH_NO   = P_REF;
    END IF;

END M1;