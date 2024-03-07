-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_CODE_DEL
-- �ۼ���     : ����
-- �ۼ���     : 2016-08-16
-- ����       : �����ڵ� ����
-- ����       : EXEC CMN_CODE_DEL
-- DB2 ��ȯ   :
--		������ ��ȯ : PTCMMBAS70D1 -> CMN_CODE_DEL
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CODE_DEL
CREATE PROCEDURE TYJINFWLIB.CMN_CODE_DEL
(
    P_COMPANYCODE CHAR(10)
   ,P_CODE        CHAR(12)
   ,P_REGID       CHAR(20)
)
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.CMN_CODE_DEL
    SET OPTION ALWCPYDTA = *OPTIMIZE ,
    DFTRDBCOL = TYJINFWLIB

P1: BEGIN
    --UPDATE TYJINFWLIB.CMN_CODE
    --   SET USEYN = P_USEYN
    --     , UPDID = P_REGID
    --     , UPDDT = CURRENT DATE
    -- WHERE COMPANYCODE = P_COMPANYCODE
    --   AND CODE        = P_CODE;

    DELETE FROM TYJINFWLIB.CMN_CODE WHERE COMPANYCODE = P_COMPANYCODE AND CODE = P_CODE;
END P1

