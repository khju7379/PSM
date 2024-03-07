--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SMS_OrgTree_GROUP;
  
CREATE PROCEDURE TYJINFWLIB.SMS_OrgTree_GROUP (    
	) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SMS_OrgTree_GROUP 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	CLOSQLCSR = *ENDMOD , 
	DECRESULT = (31, 31, 00) , 
	DFTRDBCOL = TYSCMLIB , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 

  
MAIN : BEGIN  -- 실행부 

      LIST : BEGIN  -- 리스트 

		DECLARE REFCURSOR CURSOR WITH RETURN FOR
			
		    WITH TABLE1 AS
                            (
                            SELECT DISTINCT
                                   0 AS LVL,
                                   CAST(0 AS VARCHAR(4)) AS UP_MENU_NO,
                                   CAST('X'||ADMGROUP AS VARCHAR(13)) AS MENU_NO,
                                   ADMGRNAME AS MENU_NAME,
                                   'A' AS TEXT
                                   FROM TYSCMLIB.PSM_SMSManager_ADMASTA
                                   WHERE ADMGROUP NOT IN('0')
                            ),
                            TABLE2 AS(
                            SELECT 
                                   1 AS LVL,
                                   ADDGROUP AS UP_MENU_NO,
                                   CAST(ADDSABUN AS VARCHAR(13)) AS MENU_NO,
                                   ADDNAME AS MENU_NAME,
                                   INK.KBBUSEO AS TEXT
                                   FROM TYSCMLIB.PSM_SMSManager_ADDETAIL SMS
                                   LEFT OUTER JOIN TYSCMLIB.INKIBNMF INK
                                   ON INK.KBSABUN = SMS.ADDSABUN
                            WHERE ADDGROUP NOT IN('0')
                            ) 
                            SELECT 
                                    LVL AS LEVEL, 
                                     MENU_NO AS CNODE, 
                                     MENU_NAME AS TEXT,
                                     UP_MENU_NO As PNODE,  
                                     TEXT AS TEAM, 
                                     '' AS JCCD,
                                     '' AS NAME,                                     
                                     '' AS KBBUSEONM,
                                     '' AS JKCD
                            FROM TABLE1
                            UNION ALL
                            SELECT 
                                     LVL AS LEVEL, 
                                    MENU_NO AS CNODE, 
                                    ( SELECT  EMJCCDNM  FROM TYSCMLIB.EIORGMEMBERF
                                        WHERE EMYYMM =  CAST(   (SELECT MAX(EMYYMM ) FROM TYSCMLIB.EIORGMEMBERF )  AS VARCHAR(6))
                                          AND EMENTER_CD  = 'TY'
                                          AND EMORG_CD <> ''
                                          AND EMSABUN = MENU_NO
                                          AND SUBSTR(EMORG_CD,1,1) = ( SELECT  SUBSTR(KBBUSEO,1,1) FROM TYSCMLIB.INKIBNMF WHERE KBSABUN = MENU_NO )
                                       )||' '||MENU_NAME  AS TEXT,
                                    'X'||UP_MENU_NO AS PNODE, 
                                    TEXT AS TEAM, 
                                      ( SELECT  EMJCCDNM  FROM TYSCMLIB.EIORGMEMBERF
                                        WHERE EMYYMM =  CAST(   (SELECT MAX(EMYYMM ) FROM TYSCMLIB.EIORGMEMBERF )  AS VARCHAR(6))
                                          AND EMENTER_CD  = 'TY'
                                          AND EMORG_CD <> ''
                                          AND EMSABUN = MENU_NO
                                          AND SUBSTR(EMORG_CD,1,1) = ( SELECT  SUBSTR(KBBUSEO,1,1) FROM TYSCMLIB.INKIBNMF WHERE KBSABUN = MENU_NO ) ) AS JCCD,
                                    MENU_NAME AS NAME,
                                    TYSCMLIB.SF_GB_ORGNAME( TEXT, REPLACE(CHAR(CURRENT_DATE),'-','')) AS KBBUSEONM,
                                     ( SELECT  EMJKCD  FROM TYSCMLIB.EIORGMEMBERF
                                        WHERE EMYYMM =  CAST(   (SELECT MAX(EMYYMM ) FROM TYSCMLIB.EIORGMEMBERF )  AS VARCHAR(6))
                                          AND EMENTER_CD  = 'TY'
                                          AND EMORG_CD <> ''
                                          AND EMSABUN = MENU_NO
                                          AND SUBSTR(EMORG_CD,1,1) = ( SELECT  SUBSTR(KBBUSEO,1,1) FROM TYSCMLIB.INKIBNMF WHERE KBSABUN = MENU_NO ) ) AS JKCD
                            FROM TABLE2                         
                            ORDER BY LEVEL , PNODE, JKCD, CNODE;
			
			
		OPEN REFCURSOR ;

	END LIST ; 

END MAIN ; 
END  ;




