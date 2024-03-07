--DROP PROCEDURE PSSCMLIB.PSM_OutSideConstruct_WKCODE_ADD;

CREATE PROCEDURE PSSCMLIB.PSM_OutSideConstruct_WKCODE_ADD
(
	P_OSWKDATE        VARCHAR(8)    , -- �������
	P_OSWKSEQ         NUMERIC(3,0)  ,-- ��ϼ���
	P_OSWKCODE        VARCHAR(2)    , -- �۾��ڵ�
	P_OSWKNAME        VARCHAR(30)   ,    -- �۾���
	P_OSRISKRATE      VARCHAR(1)    ,    -- ���赵
	P_OSCHECKGN       VARCHAR(1)    ,    -- ���ÿ���
	P_OSWKHISAB       VARCHAR(6)    
)
	LANGUAGE SQL
P1: BEGIN
	

	INSERT INTO PSSCMLIB.PSM_OutSideConstruct_WKCODE
	 (
		OSWKDATE    , -- �������
		OSWKSEQ     ,-- ��ϼ���
		OSWKCODE    , -- �۾��ڵ�
		OSWKNAME    ,    -- �۾���
		OSRISKRATE  ,    -- ���赵
		OSCHECKGN   ,    -- ���ÿ���
		OSWKHIGB    ,     -- �۾�����
		OSWKHIDAT   ,		-- �۾�����
		OSWKHITIM   ,		-- �۾��ð�
		OSWKHISAB   		-- �۾����
    ) VALUES (
		P_OSWKDATE    , -- �������
		P_OSWKSEQ     ,-- ��ϼ���
		P_OSWKCODE    , -- �۾��ڵ�
		P_OSWKNAME    ,    -- �۾���
		P_OSRISKRATE  ,    -- ���赵
		P_OSCHECKGN   ,    -- ���ÿ���
		'A', CURRENT_DATE, CURRENT_TIME,
		P_OSWKHISAB   		-- �۾����	 
	);

END P1