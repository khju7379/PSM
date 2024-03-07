-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_SWITCH_ADD 
-- �ۼ���     : ����
-- �ۼ���     : 2016-08-16
-- ����       : �����ڵ� �޺� ��ȸ
-- ����       : CALL TYJINFWLIB.CMN_SWITCH_ADD  ('SEOHAN','CMN0100106', 'IR08', 'KO)
-- DB2 ��ȯ   : 
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_SWITCH_ADD;
CREATE PROCEDURE TYJINFWLIB.CMN_SWITCH_ADD
(
    P_COMPANYCODE CHAR(10),
    P_CVYN        CHAR(1),
    P_REGCO       CHAR(10),
    P_REGID       CHAR(20)
)

    --RESULT SETS 1
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_SWITCH_ADD
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

M1: BEGIN

    IF EXISTS (SELECT * FROM TYJINFWLIB.CMN_SWITCH WHERE COMPANYCODE = P_COMPANYCODE) THEN
        UPDATE TYJINFWLIB.CMN_SWITCH
           SET CVYN   = P_CVYN
             , UPDCO  = P_REGCO
             , UPDID  = P_REGID
             , UPDDAT = CURRENT TIMESTAMP
         WHERE COMPANYCODE = P_COMPANYCODE
         ;
    ELSE
        INSERT INTO TYJINFWLIB.CMN_SWITCH
        ( COMPANYCODE --CHAR(20)
        , CVYN        --CHAR(1)
        , REGCO       --CHAR(10)                       -- �����ڹ���
        , REGID       --CHAR(20)                       -- �����
        , REGDAT      --TIMESTAMP                      -- �����
        , UPDCO       --CHAR(10)                       -- �����ڹ���
        , UPDID       --CHAR(20)                       -- ������
        , UPDDAT      --TIMESTAMP                      -- ������
        ) 
        VALUES 
        ( P_COMPANYCODE --CHAR(20)
        , P_CVYN        --CHAR(1)
        , P_REGCO
        , P_REGID       --CHAR(20)                       -- �����
        , CURRENT TIMESTAMP      --TIMESTAMP                      -- �����
        , P_REGCO       --CHAR(10)                       -- �����ڹ���
        , P_REGID       --CHAR(20)                       -- ������
        , CURRENT TIMESTAMP      --TIMESTAMP                      -- ������
        );
    END IF;

END M1