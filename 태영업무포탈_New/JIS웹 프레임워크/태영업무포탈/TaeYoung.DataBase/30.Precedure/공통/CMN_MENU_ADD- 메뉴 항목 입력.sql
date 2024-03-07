-------------------------------------------------------------------------------------------
--
-- 프로시저명 : CMN_MENU_ADD
-- 작성자     : 문광복
-- 작성일     : 2014-04-04
-- 설명       : 메뉴관리 트리에 새로운 노드 추가
-- 예문       : EXEC CMN_MENU_ADD '메뉴아이디','프로그램아이디','부모코드 아이디','디스플레이여부'
--		DB2 변환 : 이전프로시져명 SP_MENU_MANAGEMENT_MENU_INSERT
--		프렌지 변환 : PTCMMBAS40I1 -> CMN_MENU_ADD
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_MENU_ADD
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_ADD
(
		P_MENUID			VARCHAR(50)			  -- 메뉴아이디
	,	P_PROGRAMID			VARCHAR(50) 		-- 프로그램아이디
	,	P_HIGHRANKID		VARCHAR(50) 		-- 상위메뉴아이디
	,	P_DISPLAYYN			VARCHAR(1)
	,	P_IPYN				VARCHAR(1)	
	,	P_KO				VARGRAPHIC(2000) CCSID 1200			-- 한국어
	,	P_EN				VARGRAPHIC(2000) CCSID 1200			-- 영어
	,	P_ZH				VARGRAPHIC(2000) CCSID 1200			-- 중국어
	,	P_RU				VARGRAPHIC(2000) CCSID 1200			-- 체코어
	,	P_SORTNO			INTEGER
	,	P_MENUTYPE			VARCHAR(10)
)
	LANGUAGE SQL

P1: BEGIN

    IF NOT EXISTS(SELECT * FROM TYJINFWLIB.CMN_MENU WHERE MENUID = P_MENUID)
        THEN
	        INSERT INTO TYJINFWLIB.CMN_MENU
	        (
			        MENUID
		        ,	PROGRAMID
		        ,	PRTMENU
		        ,	DISPLAYYN
				,	IPYN
				,	SORTNO
				,	MENUTYPE
	        ) 
			VALUES 
			(
			        P_MENUID
		        ,	P_PROGRAMID
		        ,	P_HIGHRANKID
		        ,	P_DISPLAYYN
				,	P_IPYN
				,	P_SORTNO
				,	P_MENUTYPE
	        );

	        INSERT INTO TYJINFWLIB.CMN_LANG
	        (
			        PROGRAMID,
			        CODE,
			        KO,
			        EN,
			        ZH,
			        RU
	        ) 
			VALUES 
			(
			        'MENU'
		        ,	P_MENUID
		        ,	P_KO
		        ,	P_EN
		        ,	P_ZH
		        ,	P_RU
	        );

			-- 메뉴 타입이 GP일경우 전사, VND일 경우 협력업체 권한 추가
			IF P_MENUTYPE = 'GP' THEN
				INSERT INTO TYJINFWLIB.CMN_ACL
				(
					ACL_TYPE, ACL_ID, ACL_GRP, GRP_TYPE
				)
				VALUES
				(
					'MENU', P_MENUID, 'SEOHAN_ALL', 'G'
				);
			ELSEIF P_MENUTYPE = 'VND' THEN
				INSERT INTO TYJINFWLIB.CMN_ACL
				(
					ACL_TYPE, ACL_ID, ACL_GRP, GRP_TYPE
				)
				VALUES
				(
					'MENU', P_MENUID, 'SEOHAN_VND', 'G'
				);
			END IF;
    ELSE
	        UPDATE TYJINFWLIB.CMN_MENU 
	        SET
			        PROGRAMID	= P_PROGRAMID
		        ,	PRTMENU		= P_HIGHRANKID
		        ,	DISPLAYYN	= P_DISPLAYYN
				,	IPYN		= P_IPYN
				,	SORTNO		= P_SORTNO
				,	MENUTYPE	= P_MENUTYPE
	        WHERE MENUID = P_MENUID;

	        UPDATE TYJINFWLIB.CMN_LANG
	        SET
			        KO			= P_KO
		        ,	EN			= P_EN
		        ,	ZH			= P_ZH
		        ,	RU			= P_RU
	        WHERE CODE = P_MENUID;
    END IF;


    -- 관리자 권한 자동 추가
    -- 2016-11-21 장윤호
	IF NOT EXISTS (SELECT * FROM TYJINFWLIB.CMN_ACL WHERE ACL_TYPE='MENU' AND ACL_ID=P_MENUID AND ACL_GRP='9999') THEN
    
		INSERT INTO TYJINFWLIB.CMN_ACL
		(
			ACL_TYPE, ACL_ID, ACL_GRP, GRP_TYPE
		)
		VALUES
		(
			'MENU', P_MENUID, '9999', 'G'
		);
	END IF;
	
    -- 전체 권한 자동 추가
    -- 2017-05-27 장윤호
	--IF NOT EXISTS (SELECT * FROM TYJINFWLIB.CMN_ACL WHERE ACL_TYPE='MENU' AND ACL_ID=P_MENUID AND ACL_GRP='9998') THEN
    
	--	INSERT INTO TYJINFWLIB.CMN_ACL
	--	(
	--		ACL_TYPE, ACL_ID, ACL_GRP
	--	)
	--	VALUES
	--	(
	--		'MENU', P_MENUID, '9998'
	--	);
	--END IF;
    
END P1

