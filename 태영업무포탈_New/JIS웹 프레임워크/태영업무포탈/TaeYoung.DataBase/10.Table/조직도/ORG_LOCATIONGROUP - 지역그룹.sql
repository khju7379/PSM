--DROP TABLE TYJINFWLIB.ORG_LOCATIONGROUP;
-- 지역그룹
-- 이전 테이블 명 : PTORGUSR51
-- TB_LocationGroup
CREATE TABLE TYJINFWLIB.ORG_LOCATIONGROUP
(
	  LOCATIONGROUP     CHAR (4) NOT NULL
	, LANGCODE          CHAR (2) NOT NULL
	, LOCATIONGROUPNAME VARGRAPHIC (40) ALLOCATE(20) CCSID 1200
	, PRIMARY KEY (LOCATIONGROUP,LANGCODE)
);

COMMENT ON TABLE TYJINFWLIB.ORG_LOCATIONGROUP IS '공통-지역정보그룹'; 

COMMENT ON COLUMN TYJINFWLIB.ORG_LOCATIONGROUP
(
	LOCATIONGROUP IS '지역그룹코드' , 
	LANGCODE IS '언어코드' , 
	LOCATIONGROUPNAME IS '지역그룹코드명' 
); 


