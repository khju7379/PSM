-------------------------------------------------------------------------------------------
-- ���ν�����  : CMN_ATTACH_ADD_POST
-- �ۼ���      : ����
-- �ۼ���      : 2016-09-26
-- ����        : �缭�� ���ޱ�� ����÷�� ����
-- ����        : CALL CMN_ATTACH_ADD_POST ('TEMPLETE01','10')
-- DB2 ��ȯ    : �������ν����� UP_ATTACH_FILE_INSERT_POST
-- ����        : 
-- ������ ��ȯ :
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