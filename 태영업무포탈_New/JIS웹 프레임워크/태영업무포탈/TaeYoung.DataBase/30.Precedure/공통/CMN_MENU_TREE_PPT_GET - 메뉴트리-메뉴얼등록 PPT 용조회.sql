--DROP PROCEDURE TYJINFWLIB.CMN_MENU_TREE_PPT_GET;
-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_MENU_TREE_PPT_GET
-- 작성자     :
-- 작성일     : 2015-09-01
-- 설명       : 메뉴관리 트리 목록
-- 예문       :
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_TREE_PPT_GET(
    IN P_PROGRAMID CHAR(50)
)
  RESULT SETS 1
  LANGUAGE SQL

P1: BEGIN

  DECLARE REFCURSOR CURSOR WITH RETURN FOR

    WITH TREE ( MENUID, PROGRAMID, PRTMENU , KO, SORT1 , SORT2 , SORT3, SORT4)  AS
    (
      SELECT M.MENUID, M.PROGRAMID , M.PRTMENU , L.KO , CASE WHEN M.PRTMENU = '' THEN M.MENUID ELSE M.PRTMENU END AS SORT1 , M.SORTNO AS SORT2 , 1 AS SORT3, M.SORTNO AS SORT4
        FROM TYJINFWLIB.CMN_MENU M
       INNER JOIN TYJINFWLIB.CMN_LANG L
          ON M.MENUID = L.CODE
       WHERE COALESCE(PRTMENU,'') = ''
         AND M.MENUTYPE  IN ('GP' , 'VND')
         AND M.DISPLAYYN = 'Y'

      UNION ALL

      SELECT  M.MENUID, M.PROGRAMID , TRIM(M.PRTMENU) AS PRTMENU, L.KO ,TRIM(T.SORT1) || TRIM(M.MENUID) AS SORT1,  T.SORT2 AS SORT2 , (SORT3  +  1) AS SORT3 ,M.SORTNO AS SORT4
        FROM TYJINFWLIB.CMN_MENU M
       INNER JOIN TREE T
          ON T.MENUID = M.PRTMENU
        INNER JOIN TYJINFWLIB.CMN_LANG L
          ON M.MENUID = L.CODE
       WHERE M.DISPLAYYN = 'Y'
    )
    SELECT A.MENUID , A.PROGRAMID, A.PRTMENU , A.KO AS PROGRMNAME , A.SORT3 AS LEV, COALESCE(B.ATTACH_CNT,0) AS ATTACH_CNT
      FROM TREE AS A
      LEFT OUTER JOIN ( SELECT ATTACH_NO , COUNT(*) AS ATTACH_CNT FROM TYJINFWLIB.CMN_ATTACH WHERE ATTACH_TYPE = 'MENUAL_PPT' GROUP BY ATTACH_NO) AS B
        ON A.PROGRAMID = B.ATTACH_NO
     WHERE PROGRAMID = CASE WHEN P_PROGRAMID = '' THEN PROGRAMID ELSE P_PROGRAMID END
     ORDER BY COALESCE(SORT2, 9999), SORT1, SORT3 ,COALESCE(SORT4, 9999);

  OPEN REFCURSOR;

END P1

