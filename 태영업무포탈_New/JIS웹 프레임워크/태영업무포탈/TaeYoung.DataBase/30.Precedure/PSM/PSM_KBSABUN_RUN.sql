DROP PROCEDURE PSSCMLIB.PSM_KBSABUN_RUN;

CREATE PROCEDURE PSSCMLIB.PSM_KBSABUN_RUN
( 
	P_KBSABUN     VARCHAR(10)
)
    RESULT SETS 1
    LANGUAGE SQL
    
P1 : BEGIN -- ����
    
	DECLARE REFCURSOR CURSOR WITH RETURN FOR	
		
			
					SELECT
						KBSABUN,
						KBHANGL,
						KBJKCD||'-'||DTCODE.CDDESC1 AS KBJKCD,
						TYSCMLIB.SF_GB_NEWORGID(KBSABUN, 'CODE', SUBSTR(CHAR(CURRENT_DATE),1,4)||SUBSTRING(CHAR(CURRENT_DATE),6,2)||SUBSTRING(CHAR(CURRENT_DATE),9,2))||'-'||TYSCMLIB.SF_GB_NEWORGID(KBSABUN , 'NAME', SUBSTR(CHAR(CURRENT_DATE),1,4)||SUBSTRING(CHAR(CURRENT_DATE),6,2)||SUBSTRING(CHAR(CURRENT_DATE),9,2)) AS KBBUSEO,
						KBJKCD AS KBJKCDCODE,
						DTCODE.CDDESC1 AS KBJKCDNM,
						TYSCMLIB.SF_GB_NEWORGID(KBSABUN, 'CODE', SUBSTR(CHAR(CURRENT_DATE),1,4)||SUBSTRING(CHAR(CURRENT_DATE),6,2)||SUBSTRING(CHAR(CURRENT_DATE),9,2)) AS KBBUSEOCODE,
						TYSCMLIB.SF_GB_NEWORGID(KBSABUN, 'NAME', SUBSTR(CHAR(CURRENT_DATE),1,4)||SUBSTRING(CHAR(CURRENT_DATE),6,2)||SUBSTRING(CHAR(CURRENT_DATE),9,2)) AS KBBUSEONM,
						FILE_NAME, 
						FILE_SIZE,
						ATTACH_BYTE
						FROM TYSCMLIB.INKIBNMF
						LEFT OUTER JOIN TYSCMLIB.INCODEMF AS DTCODE
						ON      'JK' = DTCODE.CDINDEX
						AND     KBJKCD = DTCODE.CDCODE
						LEFT JOIN PSSCMLIB.PSM_CMN_ATTACH
						ON    ATTACH_TYPE = 'SG' 		
						AND  ATTACH_NO = KBSABUN
						WHERE KBBALCD  NOT IN ('900','560')
						AND    KBCOMPANY = '2'
						AND    KBSABUN = P_KBSABUN;
		
	OPEN REFCURSOR;

END