--DROP TABLE TYJINFWLIB.ORG_GROUP;
-- �׷����
-- ���� ���̺� �� : PTORGUSR40
-- TB_Group
CREATE TABLE TYJINFWLIB.ORG_GROUP
(
	  GRPID    	CHAR (10) NOT NULL
	, SHRRNG   	CHAR (1) 
	, USEYN    	CHAR (1) 
	, GRPTYPE  	CHAR (1) 
	, GRPEMAIL 	CHAR (40) 
	, GRPEXT   	CHAR (20) 
	, REGID 	CHAR (12) 
	, REGDT		DATE
	, UPDID 	CHAR (12) 
	, UPDDT    	DATE 
	, PRIMARY 	KEY (GRPID)
);

COMMENT ON TABLE TYJINFWLIB.ORG_GROUP IS '����-�׷�����'; 

COMMENT ON COLUMN TYJINFWLIB.ORG_GROUP
(
	GRPID IS '�׷�ID' , 
	SHRRNG IS '��������' , 
	USEYN IS '��뿩��' , 
	GRPTYPE IS '�׷�Ÿ��' , 
	GRPEMAIL IS '�׷� ��ǥ Email' , 
	GRPEXT IS '�׷�Ȯ��' ,
	REGID IS '�����ID' , 
	REGDT IS '�������' ,
	UPDID IS '������ID' , 
	UPDDT IS '��������' 
); 
