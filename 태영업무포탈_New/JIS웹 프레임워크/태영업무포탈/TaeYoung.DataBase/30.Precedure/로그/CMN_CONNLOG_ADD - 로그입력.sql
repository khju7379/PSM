-------------------------------------------------------------------------------------------
-- 프로시저명 : CMN_CONNLOG_ADD
-- 작성자     : 문광복
-- 작성일     : 2014-04-03
-- 설명       : 로그정보를 입력한다.
-- 예문       : CALL TYJINFWLIB.CMN_CONNLOG_ADD ('DOM','TEST','2017-07-24 22:42:16', '6A38E622C1CA0198C5835530004FD78A-/Approval/Form/Template.aspx?unid=8264563bec154535a8fff6804701af25&mode=r', '', '' ,'ADMIN-PC')
--		DB2 변환 : 이전프로시져명 UP_CONNECTION_LOG_INSERT
-------------------------------------------------------------------------------------------
--DROP PROCEDURE TYJINFWLIB.CMN_CONNLOG_ADD
CREATE PROCEDURE TYJINFWLIB.CMN_CONNLOG_ADD
(
		P_LOG_TYPE				VARCHAR(5)
	,	P_BIZ_TYPE				VARCHAR(100)
	,	P_OCCUR_TIME			VARCHAR(100)
	,	P_FORM_ID				VARCHAR(500)
	,	P_USER_IP				VARCHAR(15)
	,	P_USER_ID				VARCHAR(100)
	,	P_MACHINE_NAME			VARCHAR(30)
)
	--RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	
	DECLARE P_TABLE_NAME	VARCHAR(100);
	DECLARE P_YYYY VARCHAR(4);
	DECLARE P_MM VARCHAR(2);
	DECLARE P_TABLE_QUERY VARCHAR(4000);
	DECLARE P_QUERY VARCHAR(4000);
	
	S1 : BEGIN 
		SELECT YEAR(CURRENT DATE) INTO P_YYYY FROM SYSIBM.SYSDUMMY1;
		SELECT CASE LENGTH(CAST(MONTH(CURRENT DATE) AS VARCHAR(2))) WHEN 1 
						THEN CAST('0' || MONTH(CURRENT DATE) AS VARCHAR(2))
						ELSE CAST(MONTH(CURRENT DATE) AS VARCHAR(2))
					END INTO P_MM
		FROM SYSIBM.SYSDUMMY1;
		--SET P_YYYY = 
		
		SET P_TABLE_NAME = 'LOG_' || P_YYYY || P_MM;
	END S1;
	
	S2 : BEGIN
		IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.Tables WHERE TABLE_SCHEMA = 'TYJINFWLIB' AND TABLE_NAME = P_TABLE_NAME)
		THEN
			SET P_TABLE_QUERY = '
				CREATE TABLE TYJINFWLIB.'|| P_TABLE_NAME|| '
				(
					IDX            INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ),
					LOG_TYPE       VARCHAR (5),
					BIZ_TYPE	   VARCHAR (100),
					OCCUR_TIME     TIMESTAMP,
					FORM_ID        VARCHAR (500),
					USER_IP        VARCHAR (15),
					USER_ID        VARCHAR (100),
					MACHINE_NAME   VARCHAR (30),
					PRIMARY KEY (IDX)
				)
			';
			
			-- 생성
			EXECUTE IMMEDIATE P_TABLE_QUERY;
		END IF;
	END S2;
	
	S3 : BEGIN
		SET P_QUERY = '
			INSERT INTO TYJINFWLIB.' || P_TABLE_NAME || ' 
			(
				LOG_TYPE, BIZ_TYPE, OCCUR_TIME, FORM_ID, USER_IP, USER_ID, MACHINE_NAME
			)
			VALUES
			(
					''' ||  P_LOG_TYPE || '''
				,	''' ||  P_BIZ_TYPE || '''
				,	''' ||  P_OCCUR_TIME ||  '''
				,	''' ||  P_FORM_ID || '''
				,	''' ||  P_USER_IP || '''
				,	''' ||  P_USER_ID || '''
				,	''' ||  P_MACHINE_NAME || '''
			)
		';
		-- ,	''' ||  VARCHAR_FORMAT(P_OCCUR_TIME,'yyyy-MM-dd hh:mm:ss') ||  '''
		-- 생성
			EXECUTE IMMEDIATE P_QUERY;
	END S3;

END P1