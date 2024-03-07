-------------------------------------------------------------------------------------------
--
-- ���ν����� : CMN_MENU_ADD
-- �ۼ���     : ������
-- �ۼ���     : 2014-04-04
-- ����       : �޴����� Ʈ���� ���ο� ��� �߰�
-- ����       : EXEC CMN_MENU_ADD '�޴����̵�','���α׷����̵�','�θ��ڵ� ���̵�','���÷��̿���'
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_MENU_INSERT
--		������ ��ȯ : PTCMMBAS40I1 -> CMN_MENU_ADD
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_MENU_ADD
CREATE PROCEDURE TYJINFWLIB.CMN_MENU_ADD
(
		P_MENUID			VARCHAR(50)			  -- �޴����̵�
	,	P_PROGRAMID			VARCHAR(50) 		-- ���α׷����̵�
	,	P_HIGHRANKID		VARCHAR(50) 		-- �����޴����̵�
	,	P_DISPLAYYN			VARCHAR(1)
	,	P_IPYN				VARCHAR(1)	
	,	P_KO				VARGRAPHIC(2000) CCSID 1200			-- �ѱ���
	,	P_EN				VARGRAPHIC(2000) CCSID 1200			-- ����
	,	P_ZH				VARGRAPHIC(2000) CCSID 1200			-- �߱���
	,	P_RU				VARGRAPHIC(2000) CCSID 1200			-- ü�ھ�
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

			-- �޴� Ÿ���� GP�ϰ�� ����, VND�� ��� ���¾�ü ���� �߰�
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


    -- ������ ���� �ڵ� �߰�
    -- 2016-11-21 ����ȣ
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
	
    -- ��ü ���� �ڵ� �߰�
    -- 2017-05-27 ����ȣ
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

