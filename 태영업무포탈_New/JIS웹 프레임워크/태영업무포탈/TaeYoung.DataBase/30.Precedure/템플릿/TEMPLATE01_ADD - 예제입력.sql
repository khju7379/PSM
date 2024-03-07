--DROP PROCEDURE TYJINFWLIB.TEMPLATE01_ADD;
-------------------------------------------------------------------------------------------
--
-- 프로시저명 : TEMPLATE01_ADD
-- 작성자     : 문광복
-- 작성일     : 2016-09-02
-- 설명       : 예제 리스트
-- 예문       : CALL TYJINFWLIB.TEMPLATE01_ADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.TEMPLATE01_ADD 
( 
	P_IDX	INT
	, P_COLUMNS1  VARCHAR(50)
	, P_COLUMNS2  VARCHAR(50)
	, P_COLUMNS3  VARCHAR(50)
	, P_COLUMNS4  VARCHAR(50)
	, P_COLUMNS5  VARCHAR(50)
	, P_COLUMNS6  VARCHAR(50)
	, P_COLUMNS7  VARCHAR(50)
	, P_COLUMNS8  VARCHAR(50)
	, P_COLUMNS9  VARCHAR(50)
)
    LANGUAGE SQL
    
P1 : BEGIN -- 시작
    
	IF P_IDX = 0 THEN 

	INSERT INTO TYJINFWLIB.TEMPLETE01
		(
		IDX
		, COLUMNS1
		, COLUMNS2
		, COLUMNS3
		, COLUMNS4
		, COLUMNS5
		, COLUMNS6
		, COLUMNS7
		, COLUMNS8
		, COLUMNS9
		)
	VALUES
		(
		(SELECT MAX(IDX) + 1 FROM TYJINFWLIB.TEMPLETE01)
		, P_COLUMNS1
		, P_COLUMNS2
		, P_COLUMNS3
		, P_COLUMNS4
		, P_COLUMNS5
		, P_COLUMNS6
		, P_COLUMNS7
		, P_COLUMNS8
		, P_COLUMNS9
		);

	ELSE
		
		UPDATE TYJINFWLIB.TEMPLETE01
		SET
		 COLUMNS1 = P_columns1
		, COLUMNS2 = P_columns2
		, COLUMNS3 = P_columns3
		, COLUMNS4 = P_columns4
		, COLUMNS5 = P_columns5
		, COLUMNS6 = P_columns6
		, COLUMNS7 = P_columns7
		, COLUMNS8 = P_columns8
		, COLUMNS9 = P_columns9
		WHERE IDX = P_IDX;

	END IF;
	
END