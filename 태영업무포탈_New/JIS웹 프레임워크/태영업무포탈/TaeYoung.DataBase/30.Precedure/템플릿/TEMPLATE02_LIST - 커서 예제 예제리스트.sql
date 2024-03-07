-------------------------------------------------------------------------------------------
--
-- 프로시저명 : EIS_SEOHAN_PRD_RATIO_MAIN_LINE_LIST2
-- 작성자     : 백승훈
-- 작성일     : 2017-02-14
-- 설명       : 가동률 라인별 비가동 상세 현황 (월별 라인 소속별 조회)
-- 예문       : CALL JISLIB.EIS_SEOHAN_PRD_RATIO_MAIN_LINE_LIST2('2017', '201702','20170201','20170228', 'CAB', ' AND A.OPGB = ''Y'' ')
-- DB2 변환   : 이전프로시져명 
--
-------------------------------------------------------------------------------------------
--DROP PROCEDURE JISLIB.TEMPLATE02_LIST;
CREATE PROCEDURE JISLIB.TEMPLATE02_LIST (   

       P_FIRST_YYMMDD      VARCHAR(8)
   ,   P_END_YYMMDD        VARCHAR(8)
   ,   P_WRKCT             VARCHAR(8)
   ,   P_SEARCHCONDITION   VARCHAR(200)
   
)
   LANGUAGE SQL
   SPECIFIC JISLIB.TEMPLATE02_LIST
   RESULT SETS 2
   
M1 : BEGIN   
   DECLARE BTIM     VARCHAR(20);
   DECLARE SQLSTMT  VARCHAR(4000);
   DECLARE SQLSTMT2  VARCHAR(4000);

   
   DECLARE TMP_VALUE VARCHAR(1000);
    
   BTIM : BEGIN
      DECLARE TMP_CUR CURSOR CUR1 ;
      SET   SQLSTMT = 'SELECT A.LINE, SUM(A.BTIM * COALESCE(B.SAN,1))  BTIM 
                     FROM SMLIB.BGDMSPF A 
                  LEFT OUTER JOIN SBLIB.RUTMSPF B 
                  ON A.LINE =B.WRKCT AND A.RUT = B.RUT 
                  WHERE BDATE between '''|| P_FIRST_YYMMDD ||''' and '''|| P_END_YYMMDD ||''' AND LINE ='''|| P_WRKCT ||'''  ' || P_SEARCHCONDITION  || ' 
                  GROUP BY A.LINE FETCH FIRST 1 ROWS ONLY';
    PREPARE CUR1 FROM SQLSTMT;

    OPEN CUR1;
    FETCH CURS1 INTO TMP_VALUE;
    CLOSE CURS1;

   S1 : BEGIN
      DECLARE REFCURSOR INSENSITIVE SCROLL CURSOR WITH RETURN FOR CUR1 ;
      SET   SQLSTMT2 = 'SELECT A.LINE,A.RUT,COALESCE(B.RUTH,''공통공정'') RUTH, COALESCE(SUM(A.BTIM * COALESCE(B.SAN,1)),0) BTIM, 
                             DOUBLE(SUM(A.BTIM * COALESCE(B.SAN,1))) /  ' || TMP_VALUE ||' * 100 
                        FROM SMLIB.BGDMSPF A 
                  LEFT OUTER JOIN SBLIB.RUTMSPF B ON A.LINE =B.WRKCT AND A.RUT = B.RUT 
                  WHERE BDATE between '''|| P_FIRST_YYMMDD ||''' and '''|| P_END_YYMMDD ||''' AND LINE ='''|| P_WRKCT ||'''  ' || P_SEARCHCONDITION  || '
                  GROUP BY A.RUT, B.RUTH ORDER BY BTIM ';
      PREPARE CUR1 FROM SQLSTMT;
      OPEN REFCURSOR;
   END S1;
END M1;