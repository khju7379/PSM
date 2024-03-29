--DROP TABLE TYJINFWLIB.CMN_LANG;
-- 언어코드정보
-- TB_Lang_Code
CREATE TABLE TYJINFWLIB.CMN_LANG 
( 
	  PROGRAMID		CHAR			(50) NOT NULL  
	, CODE			CHAR			(50) NOT NULL  
	, KO			VARGRAPHIC      (2000) CCSID 1200
	, EN			VARGRAPHIC      (2000) CCSID 1200
	, ZH			VARGRAPHIC      (2000) CCSID 1200
	, RU			VARGRAPHIC      (2000) CCSID 1200
	, PRIMARY KEY( PROGRAMID,CODE) 
);

COMMENT ON TABLE TYJINFWLIB.CMN_LANG IS '공통-다국어마스터'; 

COMMENT ON COLUMN TYJINFWLIB.CMN_LANG
(
	PROGRAMID IS '프로그램ID' , 
	CODE IS '언어코드' , 
	KO IS '한국어' , 
	EN IS '영어' , 
	ZH IS '중국어 간체' , 
	RU IS '러시아어' 	
); 




	