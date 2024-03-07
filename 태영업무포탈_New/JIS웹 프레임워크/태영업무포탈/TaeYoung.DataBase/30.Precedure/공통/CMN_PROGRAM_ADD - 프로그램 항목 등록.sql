--DROP PROCEDURE TYJINFWLIB.CMN_PROGRAM_ADD;
-------------------------------------------------------------------------------------------
-- ���ν����� : CMN_PROGRAM_ADD
-- �ۼ���     : ������
-- �ۼ���     : 2015-09-01
-- ����       : ���α׷����� Ʈ���� ���ο� ��� �߰�
-- ����       : EXEC CMN_PROGRAM_ADD '���α׷����̵�','�޴����̵�', '���'
--		DB2 ��ȯ : �������ν����� SP_MENU_MANAGEMENT_PROGRAM_INSERT
--		������ ��ȯ : PTCMMBAS50I1 -> CMN_PROGRAM_ADD
-------------------------------------------------------------------------------------------
CREATE PROCEDURE TYJINFWLIB.CMN_PROGRAM_ADD
(
	P_PROGRAMID		VARCHAR(50),		-- ���α׷����̵�
	P_MENUID			VARCHAR(50),		-- �޴����̵�
	P_PROGRAMPATH	VARCHAR(200),		-- ���α׷����
	P_DESCRIPTION	VARCHAR(2000),		-- ����
	P_POPUP			CHAR(1),
	P_POPUP_SIZE		VARCHAR(11),
	P_MENUTYPE			VARCHAR(10)
)
	LANGUAGE SQL

P1: BEGIN

	IF NOT EXISTS(SELECT * FROM TYJINFWLIB.CMN_PROGRAM WHERE PROGRAMID= P_PROGRAMID AND MENUID = P_MENUID) THEN
		INSERT INTO TYJINFWLIB.CMN_PROGRAM
		(
				PROGRAMID
			,	MENUID
			,	PROGRAMPATH
			,	DESCRIPTION
			,	POPUP
			,	POPUP_SIZE
			,	MENUTYPE
		) 
		VALUES 
		(
				P_PROGRAMID
			,	P_MENUID
			,	P_PROGRAMPATH
			,	P_DESCRIPTION
			,	P_POPUP
			,	P_POPUP_SIZE
			,	P_MENUTYPE
		);
	ELSE
		UPDATE TYJINFWLIB.CMN_PROGRAM 
		SET
				PROGRAMID	= P_PROGRAMID
			,	MENUID		= P_MENUID
			,	PROGRAMPATH	= P_PROGRAMPATH
			,	DESCRIPTION = P_DESCRIPTION
			,	POPUP		= P_POPUP
			,	POPUP_SIZE	= P_POPUP_SIZE
			,	MENUTYPE	= P_MENUTYPE
		WHERE PROGRAMID = P_PROGRAMID AND MENUID = P_MENUID;
	END IF;

END P1

