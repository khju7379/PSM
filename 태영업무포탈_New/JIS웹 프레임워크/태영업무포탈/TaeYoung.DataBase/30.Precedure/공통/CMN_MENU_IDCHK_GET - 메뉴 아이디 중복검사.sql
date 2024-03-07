-------------------------------------------------------------------------------------------
-- 프로시저명  : CMN_MENU_IDCHK_GET
-- 작성자      : 문광복
-- 작성일      : 2014-04-15
-- 설명        : 메뉴아이디 중복 체크
-- 예문        : EXEC CMN_MENU_IDCHK_GET 'MD'
-- DB2 변환    : 이전프로시져명 SP_MENU_MANAGEMENT_MENUID_CHECK
-- 프렌지 변환 : PTCMMBAS40S1 -> CMN_MENU_IDCHK_GET
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_IDCHK_GET
(
    P_MENUID    VARCHAR(20) -- 메뉴 아이디
   ,P_PROGRAMID CHAR(50)    -- 프로그램 아이디
   ,P_CHK_DIV   CHAR(1)     -- 체크 구분 : M - 메뉴 체크 , P - 프로그램 체크
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

