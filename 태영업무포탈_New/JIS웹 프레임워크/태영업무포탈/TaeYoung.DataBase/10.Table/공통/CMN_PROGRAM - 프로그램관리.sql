-- 프로그램관리
-- TB_Program
CREATE TABLE TYJINFWLIB.CMN_PROGRAM
(
	  PROGRAMID   CHAR (50) NOT NULL
	, MENUID      CHAR (20) NOT NULL
	, PROGRAMPATH VARCHAR (2000) 
	, DESCRIPTION VARCHAR (2000) 
	, POPUP       CHAR (1)
	, POPUP_SIZE  VARCHAR (11)
	, MENUTYPE	  VARCHAR(10)
	, PRIMARY KEY (PROGRAMID,MENUID)
);

COMMENT ON TABLE TYJINFWLIB.CMN_PROGRAM IS '공통-프로그램관리'; 

COMMENT ON COLUMN TYJINFWLIB.CMN_PROGRAM
(
	PROGRAMID IS '프로그램 ID' , 
	MENUID IS '메뉴 ID' , 
	PROGRAMPATH IS '프로그램 경로' , 
	DESCRIPTION IS '비고' ,
	POPUP IS '팝업여부' ,
	POPUP_SIZE IS '팝업크기',
	MENUTYPE IS '메뉴타입'
); 

