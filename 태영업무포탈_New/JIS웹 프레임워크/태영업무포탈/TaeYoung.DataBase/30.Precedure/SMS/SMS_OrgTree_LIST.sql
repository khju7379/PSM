--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE TYJINFWLIB.SMS_OrgTree_LIST;
  
CREATE PROCEDURE TYJINFWLIB.SMS_OrgTree_LIST ( 
    IN P_SAUPBCODE1  VARCHAR(3),
	IN P_SAUPBCODE2  VARCHAR(3),
	IN P_DEPTCODE1	 VARCHAR(3),
	IN P_DEPTCODE2	 VARCHAR(3),
	IN P_SAUPBCODE3 VARCHAR(3),
	IN P_SAUPBCODE4 VARCHAR(3),
	IN P_DEPTCODE3	 VARCHAR(3),
	IN P_DEPTCODE4  VARCHAR(3)	
	) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC TYJINFWLIB.SMS_OrgTree_LIST 
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
			
			WITH n ( level, ORG_CD, SDATE,  PRIOR_ORG_CD,  SEQ, T_LEVEL, ROWNUM) AS 
                        ( SELECT   1 AS level, 
                                   ORG_CD,
                                   SDATE,
                                   CASE WHEN PRIOR_ORG_CD IN ('A50000') THEN '0' ELSE PRIOR_ORG_CD END PRIOR_ORG_CD,
                                   CASE WHEN ORG_CD = 'C00000' THEN 0 ELSE  SEQ END SEQ
                        , 100 AS T_LEVEL,
                        ROWNUM
                        FROM TYSCMLIB.INTORG105 A
                        WHERE   ENTER_CD = 'TY'
                           AND  ORG_CHART_NM = '조직도'
                           AND  SDATE =  ( SELECT SDATE FROM TYSCMLIB.INTORG103 B WHERE  B.ENTER_CD = A.ENTER_CD AND (EDATE = '' OR EDATE IS NULL) )
                           AND  ( PRIOR_ORG_CD = '0'
                           AND ORG_CD NOT IN ( 'C10000', 'A80000','A90000')
                         )
                        AND SUBSTRING(ORG_CD, 1, 2) = CASE WHEN CAST(P_SAUPBCODE1 AS VARCHAR(10)) = 'ALL' THEN SUBSTRING(ORG_CD, 1, 2)
                        ELSE SUBSTRING( CAST(P_SAUPBCODE2 AS VARCHAR(10)), 1, 2) END
                            UNION ALL
                            SELECT n.level+1,
                                nplus1.ORG_CD,
                                nplus1.SDATE,
                                    CASE WHEN nplus1.PRIOR_ORG_CD IN ('A50000') THEN '' ELSE nplus1.PRIOR_ORG_CD END PRIOR_ORG_CD,
                                nplus1.SEQ
                        , 100 AS T_LEVEL,
                        nplus1.ROWNUM
                            FROM TYSCMLIB.INTORG105 AS nplus1,  n
                            WHERE n.ORG_CD = nplus1.PRIOR_ORG_CD
                            AND  nplus1.ENTER_CD = 'TY'
                            AND  nplus1.ORG_CHART_NM = '조직도'
                                AND nplus1.SDATE =  ( SELECT SDATE FROM TYSCMLIB.INTORG103 C WHERE C.ENTER_CD =  nplus1.ENTER_CD 
                                                                                    AND  (EDATE = '' OR EDATE IS NULL) )      
                        AND nplus1.ORG_CD = CASE WHEN CAST(P_DEPTCODE1 AS VARCHAR(10)) = 'ALL' THEN nplus1.ORG_CD
                        ELSE CAST(P_DEPTCODE2 AS VARCHAR(10)) END
                            AND nplus1.ORG_CD NOT IN ('C00000', 'C10000', 'A80000', 'A90000')

                         UNION ALL

                         SELECT
                         2 AS LEVEL,
                         'Z10000' AS ORG_CD,
                         '' AS SDATE,
                         '' AS PRIOR_ORG_CD,
                         1 AS SEQ,
                         100 T_LEVEL,
                         0 AS ROWNUM
                         FROM SYSIBM.SYSDUMMY1

                        )
                        SELECT
                         (CASE WHEN (LEVEL = '4' AND PNODE = 'S30000') THEN LEVEL-1
                                    WHEN SABUN IN ('0002-M','0123-M', '0383-M', '0280-M') THEN LEVEL
                              ELSE LEVEL-1 END) AS LEVEL,
                          CASE WHEN CNODE = 'C00000' THEN 'Z10000' ELSE CNODE END AS CNODE,
                          CASE WHEN CNODE = 'Z10000' THEN '임원실' 
                                   ELSE 
				                  CASE WHEN JKDESC != '' THEN  JKDESC||' '||TEXT  ELSE TEXT END  END AS TEXT,
                         SDATE,
                         (CASE WHEN SABUN IN ('0002-M','0123-M', '0383-M','0280-M','0034-M') THEN 'Z10000'
                                 WHEN LEVEL = '2' THEN ''
                                 ELSE  PNODE END) AS PNODE,
                           (CASE WHEN (LEVEL = '1' AND CNODE = 'A50300') THEN 1
                                    WHEN CNODE IN('A10100','A10200','A10300','A10400') THEN SEQ + ROWNUM
                                    ELSE SEQ END) AS SEQ,
                            SABUN,
                            NAME,
                            JCCD,
                            JKDESC,
                             T_LEVEL,
                             ROWNUM,
							 TYSCMLIB.SF_GB_ORGNAME( PNODE,SDATE) AS PNODENM
                            FROM
                            (
                            SELECT D1.*
                            FROM (
						SELECT
						level,
						ORG_CD AS CNODE,
						TYSCMLIB.SF_GB_ORGNAME( ORG_CD,SDATE) AS TEXT,
						SDATE,  
						CASE WHEN PRIOR_ORG_CD = '0' THEN  '' WHEN LEVEL=1 THEN '' ELSE  PRIOR_ORG_CD END AS PNODE,
						SEQ,
						'' AS SABUN,
						'' AS NAME,
						'' AS JCCD,
						'' AS JKDESC,
						T_LEVEL,
						    ROWNUM
						FROM n
						UNION ALL

						SELECT  ( SELECT  LEVEL +1
							  FROM n
							  WHERE  ORG_CD =  CASE WHEN EMSABUN IN ( '0002-M', '0123-M') THEN 'A00000' ELSE
															   TYSCMLIB.GET_TREE_POSITION(EMENTER_CD,  EMPRIOR_ORG_CD, EMORG_CD, EMSABUN) END
											       ) AS LEVEL,
							EMSABUN CNODE  , 
							KBHANGL AS TEXT ,
							EMYYMM AS SDATE,  
						    CASE WHEN EMSABUN IN ( '0002-M', '0123-M') THEN 'A00000' ELSE 
							     CASE WHEN TYSCMLIB.GET_TREE_POSITION(EMENTER_CD,  EMPRIOR_ORG_CD, EMORG_CD, EMSABUN) IN ('S30200') THEN SUBSTRING( TYSCMLIB.GET_TREE_POSITION(EMENTER_CD,  EMPRIOR_ORG_CD, EMORG_CD, EMSABUN), 1, 2) || '0000' ELSE TYSCMLIB.GET_TREE_POSITION(EMENTER_CD,  EMPRIOR_ORG_CD, EMORG_CD, EMSABUN)  END  
							END PNODE,    
							EMROWNUM AS SEQ,  
							EMSABUN AS SABUN, 
							KBHANGL AS NAME,
							EMJCCD AS JCCD,
							EMJCCDNM AS JKDESC,            
							/* 
							KBJKCD AS JCCD,            
							(CASE WHEN KBJKCD = '01' THEN JYCODE.CDDESC1 ELSE JKCODE.CDDESC1 END) AS JKDESC,*/
							0 T_LEVEL,
								    EMROWNUM AS ROWNUM
					    FROM TYSCMLIB.EIORGMEMBERF 
					     JOIN TYSCMLIB.INKIBNMF
						   ON KBSABUN = EMSABUN
					    LEFT OUTER JOIN TYSCMLIB.INCODEMF AS JKCODE
					    ON           'JK' = JKCODE.CDINDEX
					    AND        KBJKCD = JKCODE.CDCODE
					    LEFT OUTER JOIN TYSCMLIB.INCODEMF AS JYCODE
					    ON           'JY' = JYCODE.CDINDEX
					    AND        KBJJCD = JYCODE.CDCODE
					    WHERE EMYYMM =  CAST(   (SELECT MAX(EMYYMM ) FROM TYSCMLIB.EIORGMEMBERF )  AS VARCHAR(6))
						AND EMENTER_CD  = 'TY'
						AND EMORG_CD <> ''
						AND ( SUBSTRING(KBSOSOK, 1, 2) = CASE WHEN CAST(P_SAUPBCODE3 AS VARCHAR(10)) = 'ALL' THEN SUBSTRING(KBSOSOK, 1, 2) ELSE SUBSTRING( CAST(P_SAUPBCODE4 AS VARCHAR(10)), 1, 2) END
							 OR  KBBUSEO = CASE WHEN CAST(P_DEPTCODE3 AS VARCHAR(10)) = 'ALL' THEN KBBUSEO ELSE CAST(P_DEPTCODE4 AS VARCHAR(10)) END )
                            ) D1
                            WHERE LEVEL > 1
                            ) AS TEMP
                            WHERE  CNODE  NOT IN ('C10000','A80000','A50000', 'A90000','B80100')						 
                            ORDER BY LEVEL ASC,SEQ ASC, JCCD ASC, CNODE;
			
			
		OPEN REFCURSOR ;

	END LIST ; 

END MAIN ; 
END  ;




