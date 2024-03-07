--DROP PROCEDURE PSSCMLIB.PSM_OutSideConstruct_WKCODE_ADD;

CREATE PROCEDURE PSSCMLIB.PSM_OutSideConstruct_WKCODE_ADD
(
	P_OSWKDATE        VARCHAR(8)    , -- 등록일자
	P_OSWKSEQ         NUMERIC(3,0)  ,-- 등록순번
	P_OSWKCODE        VARCHAR(2)    , -- 작업코드
	P_OSWKNAME        VARCHAR(30)   ,    -- 작업명
	P_OSRISKRATE      VARCHAR(1)    ,    -- 위험도
	P_OSCHECKGN       VARCHAR(1)    ,    -- 선택여부
	P_OSWKHISAB       VARCHAR(6)    
)
	LANGUAGE SQL
P1: BEGIN
	

	INSERT INTO PSSCMLIB.PSM_OutSideConstruct_WKCODE
	 (
		OSWKDATE    , -- 등록일자
		OSWKSEQ     ,-- 등록순번
		OSWKCODE    , -- 작업코드
		OSWKNAME    ,    -- 작업명
		OSRISKRATE  ,    -- 위험도
		OSCHECKGN   ,    -- 선택여부
		OSWKHIGB    ,     -- 작업구분
		OSWKHIDAT   ,		-- 작업일자
		OSWKHITIM   ,		-- 작업시간
		OSWKHISAB   		-- 작업사번
    ) VALUES (
		P_OSWKDATE    , -- 등록일자
		P_OSWKSEQ     ,-- 등록순번
		P_OSWKCODE    , -- 작업코드
		P_OSWKNAME    ,    -- 작업명
		P_OSRISKRATE  ,    -- 위험도
		P_OSCHECKGN   ,    -- 선택여부
		'A', CURRENT_DATE, CURRENT_TIME,
		P_OSWKHISAB   		-- 작업사번	 
	);

END P1