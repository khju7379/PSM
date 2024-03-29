--DROP PROCEDURE PSSCMLIB.PSM_PSM4031_CHANGEREV_DOC_APP_DSP;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4031_CHANGEREV_DOC_APP_DSP ( 
	IN P_CRREVTEAM VARCHAR(6) , 
	IN P_CRREVDATE VARCHAR(8) , 
	IN P_CRREVSEQ NUMERIC(3, 0) ) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM4031_CHANGEREV_DOC_APP_DSP 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	DECRESULT = (31, 31, 00) , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 
	MAIN : BEGIN  -- 실행부 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
  
			SELECT 
					CRREVCONTENT , 
					CRREVDATA , 
					CRREVSUMMARY , 
					CRREVAPPROVAL , 
					CRREVREASION , 
					CRREVDATE1 , 
					CRREVTIME1 , 
					CRREVDATE2 , 
					CRREVTIME2 , 
					CRREVDATE3 , 
					CRREVTIME3 , 
					CRREVDATE4 , 
					CRREVTIME4 , 
					CRREVDATE5 , 
					CRREVTIME5 , 
					CRREVDATE6 , 
					CRREVTIME6 , 
					CRREVSABUN1 , 
					CRREVSABUN2 , 
					CRREVSABUN3 , 
					CRREVSABUN4 , 
					CRREVSABUN5 , 
					CRREVSABUN6 , 					
					/* 사인 */ 
					(SELECT
						FILE_NAME
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN1
					) AS IMGNAME1, 
					(SELECT
						FILE_SIZE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN1
					) AS IMGSIZE1, 
					(SELECT
						ATTACH_BYTE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN1
					) AS IMGSIGN1,

					(SELECT
						FILE_NAME
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN2
					) AS IMGNAME2, 
					(SELECT
						FILE_SIZE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN2
					) AS IMGSIZE2, 
					(SELECT
						ATTACH_BYTE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN2
					) AS IMGSIGN2, 

					(SELECT
						FILE_NAME
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN3
					) AS IMGNAME3, 
					(SELECT
						FILE_SIZE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN3
					) AS IMGSIZE3, 
					(SELECT
						ATTACH_BYTE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN3
					) AS IMGSIGN3,

					(SELECT
						FILE_NAME
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN4
					) AS IMGNAME4, 
					(SELECT
						FILE_SIZE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN4
					) AS IMGSIZE4,
					(SELECT
						ATTACH_BYTE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN4
					) AS IMGSIGN4,


					(SELECT
						FILE_NAME
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN5
					) AS IMGNAME5, 
					(SELECT
						FILE_SIZE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN5
					) AS IMGSIZE5,
					(SELECT
						ATTACH_BYTE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN5
					) AS IMGSIGN5,


					(SELECT
						FILE_NAME
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN6
					) AS IMGNAME6, 
					(SELECT
						FILE_SIZE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN6
					) AS IMGSIZE6,
					(SELECT
						ATTACH_BYTE
					 FROM PSSCMLIB.PSM_CMN_ATTACH
					 WHERE ATTACH_TYPE = 'SG'
					 AND   ATTACH_NO = CRREVSABUN6
					) AS IMGSIGN6
				FROM PSSCMLIB . PSM_CHANGEREV_DOC
				WHERE CRREVTEAM = P_CRREVTEAM 
				AND CRREVDATE = P_CRREVDATE 
				AND CRREVSEQ = P_CRREVSEQ ; 
  
		OPEN REFCURSOR ; 
  
	END MAIN ; 
  
END;