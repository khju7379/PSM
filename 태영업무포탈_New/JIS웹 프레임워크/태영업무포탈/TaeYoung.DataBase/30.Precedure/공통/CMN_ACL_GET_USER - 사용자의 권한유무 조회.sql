-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_ACL_GET_USER
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 사용자의 권한유무를 조회한다.
-- 예문       : CALL CMN_ACL_GET_USER ('2006909','1000','TS1301')
--      DB2 변환 : 이전프로시져명 UP_USER_SELECT_ACL
--		프렌지 변환 : PTCMMBAS10S1 -> CMN_ACL_GET_USER
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_ACL_GET_USER
(
    P_EMPID         VARCHAR(20),
    P_COMPANYCODE   VARCHAR(10),
    P_MENUID        VARCHAR(50) -- 메뉴아이디
)
    RESULT SETS 3
    LANGUAGE SQL
M1: BEGIN
    DECLARE REFCURSOR CURSOR WITH RETURN FOR
        WITH GRP_T AS (
            SELECT  *
            FROM TYJINFWLIB.ORG_GROUPUSR  AS G
            WHERE USRID = P_EMPID
            AND COMPANYCODE = P_COMPANYCODE
            AND G.UsrType = '1'
        )

        SELECT GRPID
          FROM GRP_T
         UNION
        SELECT GRPID
          FROM TYJINFWLIB.ORG_GROUPUSR
         WHERE UsrType = '2'
           AND USRID IN ( SELECT GRPID FROM GRP_T);

        --SELECT    GRPID
        --FROM
        --      TYJINFWLIB.PTORGUSR42  AS G
        --WHERE
        --  (USRID = P_EMPID AND COMPANYCODE = P_COMPANYCODE AND G.UsrType = '1');
            --OR EXISTS(SELECT * FROM OrgChartNVH.dbo.tb_DeptMember AS D WHERE D.UserCompanyCode = P_COMPANYCODE AND D.EmpID = P_EMPID AND D.CompanyCode = G.Companycode AND D.DeptCode = G.UsrID AND G.UsrType = '2')

    DECLARE REFCURSOR2 CURSOR WITH RETURN FOR
        SELECT COUNT(*) FROM TYJINFWLIB.CMN_ALC WHERE ACL_TYPE='MENU' AND ACL_ID = P_MENUID AND ACL_GRP IN (
                SELECT  GRPID
                FROM
                        TYJINFWLIB.ORG_GROUPUSR  AS G
                WHERE
                        (USRID = P_EMPID AND COMPANYCODE = P_COMPANYCODE AND G.UsrType = '1')
                --OR        EXISTS(SELECT * FROM OrgChartNVH.dbo.tb_DeptMember AS D WHERE D.UserCompanyCode = P_COMPANYCODE AND D.EmpID = P_EMPID AND D.CompanyCode = G.Companycode AND D.DeptCode = G.UsrID AND G.UsrType = '2')
        );

    --DECLARE REFCURSOR3 CURSOR WITH RETURN FOR
    --SELECT SUM(CASE WHEN DIV_WORK = 'QMS' AND DIV_AUTH = 'Y'
    --                  THEN 1
    --                  ELSE 0 END) AS QMS
    --    ,  SUM(CASE WHEN DIV_WORK = 'NCR' AND DIV_AUTH = 'Y'
    --                  THEN 1
    --                  ELSE 0 END) AS NCR
    --  FROM TYJINFWLIB.QMCCMMGT01
    -- WHERE COMPANYCODE = P_COMPANYCODE

     --;


    OPEN REFCURSOR;
    OPEN REFCURSOR2;
    --OPEN REFCURSOR3;

END M1;