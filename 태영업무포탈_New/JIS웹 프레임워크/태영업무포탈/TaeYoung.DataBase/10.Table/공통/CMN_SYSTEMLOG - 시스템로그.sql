-- �ý��۷α�
-- TB_System_Log
CREATE TABLE TYJINFWLIB.CMN_SYSTEMLOG
(
	  IDX            INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE )
	, LOG_TYPE       CHAR (10) 
	, BIZ_TYPE       CHAR (20) 
	, OCCUR_TIME     TIMESTAMP 
	, FORM_ID        VARCHAR (1000) 
	, MESSAGE        VARCHAR (4000) 
	, MESSAGE_DETAIL VARCHAR (4000) 
	, USER_IP        CHAR (15) 
	, USER_ID        CHAR (12) 
	, EXECUTION_TIME TIMESTAMP 
	, MACHINE_NAME   CHAR (30) 
	, PRIMARY KEY (IDX)
);

 COMMENT ON TABLE TYJINFWLIB.CMN_SYSTEMLOG IS '����-�ý��۷α�'; 
 
 COMMENT ON COLUMN TYJINFWLIB.CMN_SYSTEMLOG
 (
	IDX IS '�α׹�ȣ' , 
	LOG_TYPE IS '�α�Ÿ��' , 
	BIZ_TYPE IS '�����Ͻ�Ÿ��(����/ǰ��/����...)' , 
	OCCUR_TIME IS '������ ȣ��ð�' , 
	FORM_ID IS '������ȣ���' , 
	MESSAGE IS '�����޽���' , 
	MESSAGE_DETAIL IS '�����޽���(��)' , 
	USER_IP IS '����IP' , 
	USER_ID IS '����ID' , 
	EXECUTION_TIME IS '�����߻��ð�' , 
	MACHINE_NAME IS '�����߻� �ӽŸ�' 
);

COMMIT;
 
	