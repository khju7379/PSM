-- ��������
-- TB_ACL
CREATE TABLE TYJINFWLIB.CMN_SWITCH 
(
      COMPANYCODE CHAR(20)
    , CVYN        CHAR(1)
    , REGCO       CHAR(10)                       -- �����ڹ���
    , REGID       CHAR(20)                       -- �����
    , REGDAT      TIMESTAMP                      -- �����
    , UPDCO       CHAR(10)                       -- �����ڹ���
    , UPDID       CHAR(20)                       -- ������
    , UPDDAT      TIMESTAMP                      -- ������
    , PRIMARY KEY (COMPANYCODE)
);

COMMENT ON TABLE TYJINFWLIB.CMN_SWITCH IS '����-��� ��ư ����'; 

COMMENT ON COLUMN TYJINFWLIB.CMN_SWITCH
(
    COMPANYCODE IS '����',
    CVYN        IS '��� ����'
); 

