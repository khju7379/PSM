-------------------------------------------------------------------------------------------
-- ���ν�����  : CMN_MENU_IDCHK_GET
-- �ۼ���      : ������
-- �ۼ���      : 2014-04-15
-- ����        : �޴����̵� �ߺ� üũ
-- ����        : EXEC CMN_MENU_IDCHK_GET 'MD'
-- DB2 ��ȯ    : �������ν����� SP_MENU_MANAGEMENT_MENUID_CHECK
-- ������ ��ȯ : PTCMMBAS40S1 -> CMN_MENU_IDCHK_GET
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_IDCHK_GET
(
    P_MENUID    VARCHAR(20) -- �޴� ���̵�
   ,P_PROGRAMID CHAR(50)    -- ���α׷� ���̵�
   ,P_CHK_DIV   CHAR(1)     -- üũ ���� : M - �޴� üũ , P - ���α׷� üũ
)
    RESULT SETS 1
    LANGUAGE SQL

P1: BEGIN

    IF P_CHK_DIV = 'M' THEN
        S1 : BEGIN
            DECLARE REFCURSOR CURSOR WITH RETURN FOR
            SELECT COUNT(*)  AS CHK_CNT
                 , P_CHK_DIV AS CHK_DIV
              FROM CMN_MENU
             WHERE MENUID = P_MENUID;

            OPEN REFCURSOR;
        END S1;
    ELSEIF P_CHK_DIV = 'P' THEN
        S2 : BEGIN
            DECLARE REFCURSOR2 CURSOR WITH RETURN FOR

            SELECT COUNT(*)  AS CHK_CNT
                 , P_CHK_DIV AS CHK_DIV
              FROM CMN_PROGRAM
             WHERE PROGRAMID = P_PROGRAMID;

            OPEN REFCURSOR2;
        END S2;
    END IF;
END P1

