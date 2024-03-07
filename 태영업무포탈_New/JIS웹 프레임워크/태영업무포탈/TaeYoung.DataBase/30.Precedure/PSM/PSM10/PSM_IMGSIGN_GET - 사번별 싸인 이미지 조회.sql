--DROP PROCEDURE TYSCMLIB.PSM_IMGSIGN_GET ;
-------------------------------------------------------------------------------------------
-- 프로시저명 : PSM_IMGSIGN_GET
-- 작성자     : 문광복
-- 작성일     : 2019-02-21
-- 설명       : 사번으로 싸인이미지를 가져온다.
-- 예문       : CALL TYSCMLIB.PSM_IMGSIGN_GET ('0311-M')
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYSCMLIB.PSM_IMGSIGN_GET 
(
	P_IMGSABUN			VARCHAR(100)
)
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE REFCURSOR CURSOR WITH RETURN FOR
		SELECT	*
		FROM	TYSCMLIB.PSM_IMGSIGN
		WHERE	IMGSABUN = P_IMGSABUN;
	OPEN REFCURSOR;
	
END P1