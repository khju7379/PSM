--  Generate SQL 
--  Version:                   	V6R1M0 080215 
--  Generated on:              	18/10/16 08:29:28 
--  Relational Database:       	S65685C2 
--  Standards Option:          	DB2 i5/OS 

DROP PROCEDURE PSSCMLIB.PSM_PSM1110_BOARD_CLASS3_LIST;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM1110_BOARD_CLASS3_LIST ( 
	IN P_CURRENTPAGEINDEX INTEGER , 
	IN P_PAGESIZE INTEGER , 
	IN P_PBC3NAME VARCHAR(100)
	) 
	DYNAMIC RESULT SETS 2 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM1110_BOARD_CLASS3_LIST 
	NOT DETERMINISTIC 
	MODIFIES SQL DATA 
	CALLED ON NULL INPUT 
	SET OPTION  ALWBLK = *ALLREAD , 
	ALWCPYDTA = *OPTIMIZE , 
	COMMIT = *NONE , 
	CLOSQLCSR = *ENDMOD , 
	DECRESULT = (31, 31, 00) , 
	DFTRDBCOL = *NONE , 
	DYNDFTCOL = *NO , 
	DYNUSRPRF = *USER , 
	SRTSEQ = *HEX   
	P1 : BEGIN  -- 시작 
	DECLARE P_STNUM INTEGER ; 
	DECLARE P_FNNUM INTEGER ; 
	DECLARE P_SQLSTRING VARCHAR ( 4000 ) ; 
	DECLARE P_SQLTOTALROWCOUNT VARCHAR ( 4000 ) ; 
	DECLARE P_TABLE_QUERY			VARCHAR ( 4000 ) ; 
	DECLARE P_COUNT_QUERY			VARCHAR ( 4000 ) ; 
  
PREV : BEGIN  -- 값 설정 
		SET P_STNUM = ( P_PAGESIZE * ( P_CURRENTPAGEINDEX - 1 ) ) + 1 ; 
        SET P_FNNUM = P_PAGESIZE * P_CURRENTPAGEINDEX ; 
	END PREV ; 
  
MAIN : BEGIN  -- 실행부 
      LIST : BEGIN  -- 리스트 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR  -- 커서생성 
			WITH ORIGINAL_DATA AS (			
			SELECT  ROW_NUMBER() OVER(ORDER BY PBC3LCODE, PBC3MCODE, PBC3SCODE) AS ROWNO,
			            PBC3LCODE ,
						PBC1NAME AS PBC3LCODENM,
						PBC3MCODE ,
						PBC2NAME AS PBC3MCODENM,
						PBC3SCODE ,
						PBC3NAME  ,
						PBC3BIGO  
					FROM PSSCMLIB.PSM_BOARD_CLASS3 
					LEFT OUTER JOIN PSSCMLIB.PSM_BOARD_CLASS1
					   ON PBC1LCODE = PBC3LCODE
					LEFT OUTER JOIN PSSCMLIB.PSM_BOARD_CLASS2
					   ON PBC2LCODE = PBC3MCODE
					WHERE PBC3NAME LIKE '%'||P_PBC3NAME||'%'
			)
			SELECT
			*
			FROM ORIGINAL_DATA
			WHERE ROWNO BETWEEN P_STNUM AND P_FNNUM
			ORDER BY ROWNO ASC ;

		OPEN REFCURSOR ;

	END LIST ;  

	PAGING : BEGIN  -- 페이징 
			DECLARE REFCURSOR2 CURSOR WITH RETURN FOR  -- 커서생성 
				SELECT   COUNT(*) AS TOTALCOUNT
				FROM PSSCMLIB.PSM_BOARD_CLASS3 
					LEFT OUTER JOIN PSSCMLIB.PSM_BOARD_CLASS1
					   ON PBC1LCODE = PBC3LCODE
					LEFT OUTER JOIN PSSCMLIB.PSM_BOARD_CLASS2
					   ON PBC2LCODE = PBC3MCODE
					WHERE PBC3NAME LIKE '%'||P_PBC3NAME||'%';
			OPEN REFCURSOR2 ; 
	END PAGING ; 
END MAIN ; 
END  ;
