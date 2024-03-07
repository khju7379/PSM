CREATE FUNCTION TYJINFWLIB.UF_GET_CODENAME
(
     P_COMPANYCODE VARCHAR(10)
   , P_LANGCODE    VARCHAR(2)
   , P_DCODE       VARCHAR(12)
   , P_PCODE       VARCHAR(12)
   , P_CODE        VARCHAR(12)
)
    RETURNS VARGRAPHIC(200) CCSID 1200
    LANGUAGE SQL
    SPECIFIC TYJINFWLIB.UF_GET_CMN_CODENAME
    NOT DETERMINISTIC 
    READS SQL DATA 
    CALLED ON NULL INPUT 
    NO EXTERNAL ACTION 
    SET OPTION  ALWBLK = *ALLREAD , 
    ALWCPYDTA = *OPTIMIZE , 
    COMMIT = *NONE , 
    DECRESULT = (31, 31, 00) , 
    DFTRDBCOL = *NONE , 
    DYNDFTCOL = *NO , 
    DYNUSRPRF = *USER , 
    SRTSEQ = *HEX   
BEGIN
    DECLARE P_CONDTXT VARGRAPHIC(200) CCSID 1200 ;

    SELECT CASE ucase(P_LANGCODE) WHEN 'KO' THEN CODTXT_KR
                                  WHEN 'EN' THEN CODTXT_EN
                                  WHEN 'ZH' THEN CODTXT_ZH
                                  WHEN 'RU' THEN CODTXT_RU
                                  ELSE CODTXT_KR END AS CONDTXT
      INTO P_CONDTXT
      FROM TYJINFWLIB.CMN_CODE
     WHERE COMPANYCODE = P_COMPANYCODE
       AND DCODE       = CASE WHEN TRIM(P_DCODE) = '' THEN DCODE ELSE P_DCODE END
       AND PCODE       = CASE WHEN TRIM(P_PCODE) = '' THEN PCODE ELSE P_PCODE END
       AND CODE        = P_CODE
       FETCH FIRST 1 ROWS ONLY ;
    
    RETURN P_CONDTXT;
END;