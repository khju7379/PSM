--DROP PROCEDURE TYJINFWLIB.CMN_ATTACH_ATTNOADD;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_ATTACH_ATTNOADD
-- 작성자     : 문광복
-- 작성일     : 2015-09-09
-- 설명       : 첨부파일 리스트를 조회한다.
-- 예문       : CALL TYJINFWLIB.CMN_ATTACH_ATTNOADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_ATTACH_ATTNOADD 
(
	P_ATTACH_TYPE   VARCHAR(50),
    P_ATTACH_UNID   VARCHAR(50),
    P_FILE_NAME     VARGRAPHIC(500) CCSID 1200,
    P_FILE_SIZE     BIGINT,
    P_FILE_MIME     VARCHAR(150),
    P_FILE_EXT      VARCHAR(50),
    P_FILE_PATH     VARCHAR(4000)
)
    RESULT SETS 1
    LANGUAGE SQL
    SET OPTION
    ALWCPYDTA = *OPTIMIZE

M1: BEGIN
    DECLARE TMP_ATTACH_NO INTEGER;

    S1 : BEGIN
        SELECT COALESCE(MAX(CAST(ATTACH_NO AS INTEGER)),'0') + 1
          INTO TMP_ATTACH_NO
          FROM TYJINFWLIB.CMN_ATTACH
         WHERE ATTACH_TYPE = P_ATTACH_TYPE
          ;
    END S1;

    I1 : BEGIN
        INSERT INTO TYJINFWLIB.CMN_ATTACH
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
        VALUES
        (
            P_ATTACH_TYPE
        ,   TMP_ATTACH_NO
        ,   P_ATTACH_UNID
        ,   P_FILE_NAME
        ,   P_FILE_SIZE
        ,   P_FILE_MIME
        ,   P_FILE_EXT
        ,   P_FILE_PATH
        );
    END I1;

    R1 : BEGIN
        DECLARE REFCURSOR CURSOR WITH RETURN FOR
        SELECT TMP_ATTACH_NO AS ATTACH_NO FROM SYSIBM.SYSDUMMY1 ;

        OPEN REFCURSOR ;
    END R1;
END M1