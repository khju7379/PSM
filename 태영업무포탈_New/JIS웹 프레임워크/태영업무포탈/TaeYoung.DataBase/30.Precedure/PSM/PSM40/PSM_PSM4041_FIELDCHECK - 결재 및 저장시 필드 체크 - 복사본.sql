DROP PROCEDURE PSSCMLIB.PSM_PSM4041_FIELDCHECK;
  
CREATE PROCEDURE PSSCMLIB.PSM_PSM4041_FIELDCHECK ( 
	IN P_KBSABUN1 VARCHAR(6) , 
	IN P_DATE2 VARCHAR(8) , 
	IN P_TEAM2 VARCHAR(6) , 
	IN P_LOGINID VARCHAR(6) , 
	IN P_KBSABUN3 VARCHAR(6) , 
	IN P_KBSABUN4 VARCHAR(6) , 
	IN P_KBSABUN5 VARCHAR(6) , 
	IN P_KBSABUN6 VARCHAR(6) , 
	IN P_KBSABUN7 VARCHAR(6) , 
	IN P_KBSABUN8 VARCHAR(6) , 
	IN P_KBSABUN9 VARCHAR(6) , 
	IN P_KBSABUN10 VARCHAR(6) , 
	IN P_KBSABUN11 VARCHAR(6) , 
	IN P_KBSABUN12 VARCHAR(6) , 
	IN P_KBSABUN13 VARCHAR(6) , 
	IN P_FXCCODE14 VARCHAR(10) , 
	IN P_FXCCODE15 VARCHAR(10) , 
	IN P_FXCCODE16 VARCHAR(10) , 
	IN P_FXCCODE17 VARCHAR(10) , 
	IN P_FXCCODE18 VARCHAR(10) , 
	IN P_L3CODE19 VARCHAR(9) , 
	IN P_L3CODE20 VARCHAR(9) , 
	IN P_L3CODE21 VARCHAR(9) , 
	IN P_L3CODE22 VARCHAR(9) , 
	IN P_L3CODE23 VARCHAR(9) , 
	IN P_KBSABUN24 VARCHAR(6) , 
	IN P_KBSABUN25 VARCHAR(6) , 
	IN P_KBSABUN26 VARCHAR(6) , 
	IN P_KBSABUN27 VARCHAR(6) , 
	IN P_KBSABUN28 VARCHAR(6) ) 
	DYNAMIC RESULT SETS 1 
	LANGUAGE SQL 
	SPECIFIC PSSCMLIB.PSM_PSM4041_FIELDCHECK 
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
	P1 : BEGIN 
  
	MAIN : BEGIN  -- 실행부 
		DECLARE REFCURSOR CURSOR WITH RETURN FOR 
  
			/* 1. 확인자 */ 
			SELECT 
				'1' AS GUBUN , 
				KBHANGL AS DATA 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN1 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 2. 작업부서 */ 
			SELECT 
				'2' AS GUBUN , 
				ORG_NM AS DATA 
			FROM TYSCMLIB . INTORG101 
			WHERE ENTER_CD = 'TY' 
			AND REPLACE ( CHAR ( CAST ( P_DATE2 AS VARCHAR ( 8 ) ) ) , '-' , '' ) BETWEEN SDATE AND CASE WHEN EDATE = '' THEN '99991231' ELSE COALESCE ( EDATE , '99991231' ) END 
			AND ORG_CD = P_TEAM2 
  
			UNION ALL 
  
			/* 3. 연장허가자 */ 
			SELECT 
				'3' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBCOMPANY = '2' 
			AND KBBALCD NOT IN ( '900' , '560' ) 
			AND SUBSTR ( KBBUSEO , 1 , 2 ) = ( SELECT SUBSTR ( KBBUSEO , 1 , 2 ) AS BUSEO FROM TYSCMLIB . INKIBNMF 
						WHERE KBCOMPANY = '2' 
									AND KBBALCD NOT IN ( '900' , '560' ) 
									AND KBSABUN = P_KBSABUN3 ) 
			AND KBJJCD IN ( '090' , '110' , '130' , '150', '180' ) 
			AND KBSABUN NOT IN ( '0040-M' ) 
			AND KBSABUN = P_LOGINID 
  
			UNION ALL 
  
			/* 4. 완료 허가자 */ 
			SELECT 
				'4' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBCOMPANY = '2' 
			AND KBBALCD NOT IN ( '900' , '560' ) 
			AND SUBSTR ( KBBUSEO , 1 , 2 ) = ( SELECT SUBSTR ( KBBUSEO , 1 , 2 ) AS BUSEO FROM TYSCMLIB . INKIBNMF 
						WHERE KBCOMPANY = '2' 
									AND KBBALCD NOT IN ( '900' , '560' ) 
									AND KBSABUN = P_KBSABUN4 ) 
			AND KBJJCD IN ( '090' , '110' , '130' , '150', '180' ) 
			AND KBSABUN NOT IN ( '0040-M' ) 
			AND KBSABUN = P_LOGINID 
  
			UNION ALL 
  
			/* 5. 취소사번 */ 
			SELECT 
				'5' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBCOMPANY = '2' 
			AND KBBALCD NOT IN ( '900' , '560' ) 
			AND SUBSTR ( KBBUSEO , 1 , 2 ) = ( SELECT SUBSTR ( KBBUSEO , 1 , 2 ) AS BUSEO FROM TYSCMLIB . INKIBNMF 
						WHERE KBCOMPANY = '2' 
									AND KBBALCD NOT IN ( '900' , '560' ) 
									AND KBSABUN = P_KBSABUN5 ) 
			AND KBJJCD IN ( '090' , '110' , '130' , '150', '180' ) 
			AND KBSABUN NOT IN ( '0040-M' ) 
			AND KBSABUN = P_LOGINID 
  
			UNION ALL 
  
			/* 6. 점검자1 */ 
			SELECT 
				'6' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBCOMPANY = '2' 
			AND KBBALCD NOT IN ( '900' , '560' ) 
			AND SUBSTR ( KBBUSEO , 1 , 2 ) = ( SELECT SUBSTR ( KBBUSEO , 1 , 2 ) AS BUSEO FROM TYSCMLIB . INKIBNMF 
						WHERE KBCOMPANY = '2' 
									AND KBBALCD NOT IN ( '900' , '560' ) 
									AND KBSABUN = P_KBSABUN6 ) 
			AND KBJJCD IN ( '090' , '110' , '130' , '150', '180' ) 
			AND KBSABUN NOT IN ( '0040-M' ) 
			AND KBSABUN = P_LOGINID 
  
			UNION ALL 
  
			/* 7. 점검자2 */ 
			SELECT 
				'7' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBCOMPANY = '2' 
			AND KBBALCD NOT IN ( '900' , '560' ) 
			AND SUBSTR ( KBBUSEO , 1 , 2 ) = ( SELECT SUBSTR ( KBBUSEO , 1 , 2 ) AS BUSEO FROM TYSCMLIB . INKIBNMF 
						WHERE KBCOMPANY = '2' 
									AND KBBALCD NOT IN ( '900' , '560' ) 
									AND KBSABUN = P_KBSABUN7 ) 
			AND KBJJCD IN ( '090' , '110' , '130' , '150', '180' ) 
			AND KBSABUN NOT IN ( '0040-M' ) 
			AND KBSABUN = P_LOGINID 
  
			UNION ALL 
  
			/* 8. 점검자3 */ 
			SELECT 
				'8' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBCOMPANY = '2' 
			AND KBBALCD NOT IN ( '900' , '560' ) 
			AND SUBSTR ( KBBUSEO , 1 , 2 ) = ( SELECT SUBSTR ( KBBUSEO , 1 , 2 ) AS BUSEO FROM TYSCMLIB . INKIBNMF 
						WHERE KBCOMPANY = '2' 
									AND KBBALCD NOT IN ( '900' , '560' ) 
									AND KBSABUN = P_KBSABUN8 ) 
			AND KBJJCD IN ( '090' , '110' , '130' , '150', '180' ) 
			AND KBSABUN NOT IN ( '0040-M' ) 
			AND KBSABUN = P_LOGINID 
  
			UNION ALL 
  
			/* 9. 점검자4 */ 
			SELECT 
				'9' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBCOMPANY = '2' 
			AND KBBALCD NOT IN ( '900' , '560' ) 
			AND SUBSTR ( KBBUSEO , 1 , 2 ) = ( SELECT SUBSTR ( KBBUSEO , 1 , 2 ) AS BUSEO FROM TYSCMLIB . INKIBNMF 
						WHERE KBCOMPANY = '2' 
									AND KBBALCD NOT IN ( '900' , '560' ) 
									AND KBSABUN = P_KBSABUN9 ) 
			AND KBJJCD IN ( '090' , '110' , '130' , '150', '180' ) 
			AND KBSABUN NOT IN ( '0040-M' ) 
			AND KBSABUN = P_LOGINID 
  
			UNION ALL 
  
			/* 10. 점검자5 */ 
			SELECT 
				'10' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN10 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 11. 점검자6 */ 
			SELECT 
				'11' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN11 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 12. 점검자7 */ 
			SELECT 
				'12' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN12 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 13. 점검자8 */ 
			SELECT 
				'13' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN13 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 14. 설비코드1 */ 
			SELECT 
				'14' AS GUBUN , 
				FXC3DESC AS DATA 
			FROM TYSCMLIB . ACFIXCLASS3 C 
			WHERE FXC3BCODE IN ( '20' , '30' , '40' , '90' ) 
			AND FXC3SAUP || FXC3BCODE || DIGITS ( FXC3MCODE ) || DIGITS ( FXC3SCODE ) = P_FXCCODE14 
  
			UNION ALL 
			 
			/* 15. 설비코드2 */ 
			SELECT 
				'15' AS GUBUN , 
				FXC3DESC AS DATA 
			FROM TYSCMLIB . ACFIXCLASS3 C 
			WHERE FXC3BCODE IN ( '20' , '30' , '40' , '90' ) 
			AND FXC3SAUP || FXC3BCODE || DIGITS ( FXC3MCODE ) || DIGITS ( FXC3SCODE ) = P_FXCCODE15 
  
			UNION ALL 
  
			/* 16. 설비코드3 */ 
			SELECT 
				'16' AS GUBUN , 
				FXC3DESC AS DATA 
			FROM TYSCMLIB . ACFIXCLASS3 C 
			WHERE FXC3BCODE IN ( '20' , '30' , '40' , '90' ) 
			AND FXC3SAUP || FXC3BCODE || DIGITS ( FXC3MCODE ) || DIGITS ( FXC3SCODE ) = P_FXCCODE16 
  
			UNION ALL 
  
			/* 17. 설비코드4 */ 
			SELECT 
				'17' AS GUBUN , 
				FXC3DESC AS DATA 
			FROM TYSCMLIB . ACFIXCLASS3 C 
			WHERE FXC3BCODE IN ( '20' , '30' , '40' , '90' ) 
			AND FXC3SAUP || FXC3BCODE || DIGITS ( FXC3MCODE ) || DIGITS ( FXC3SCODE ) = P_FXCCODE17 
  
			UNION ALL 
  
			/* 18. 설비코드5 */ 
			SELECT 
				'18' AS GUBUN , 
				FXC3DESC AS DATA 
			FROM TYSCMLIB . ACFIXCLASS3 C 
			WHERE FXC3BCODE IN ( '20' , '30' , '40' , '90' ) 
			AND FXC3SAUP || FXC3BCODE || DIGITS ( FXC3MCODE ) || DIGITS ( FXC3SCODE ) = P_FXCCODE18 
  
  
			UNION ALL 
  
			/* 19. 구역코드1 */ 
			SELECT 
				'19' AS GUBUN , 
				L3NAME AS DATA 
			FROM PSSCMLIB . PSM_LOCATION_CLASS3 
			WHERE L3SAUP || L3BCODE || DIGITS ( L3MCODE ) || DIGITS ( L3SCODE ) = P_L3CODE19 
  
			UNION ALL 
  
			/* 20. 구역코드2 */ 
			SELECT 
				'20' AS GUBUN , 
				L3NAME AS DATA 
			FROM PSSCMLIB . PSM_LOCATION_CLASS3 
			WHERE L3SAUP || L3BCODE || DIGITS ( L3MCODE ) || DIGITS ( L3SCODE ) = P_L3CODE20 
  
			UNION ALL 
  
			/* 21. 구역코드3 */ 
			SELECT 
				'21' AS GUBUN , 
				L3NAME AS DATA 
			FROM PSSCMLIB . PSM_LOCATION_CLASS3 
			WHERE L3SAUP || L3BCODE || DIGITS ( L3MCODE ) || DIGITS ( L3SCODE ) = P_L3CODE21 
  
			UNION ALL 
  
			/* 22. 구역코드4 */ 
			SELECT 
				'22' AS GUBUN , 
				L3NAME AS DATA 
			FROM PSSCMLIB . PSM_LOCATION_CLASS3 
			WHERE L3SAUP || L3BCODE || DIGITS ( L3MCODE ) || DIGITS ( L3SCODE ) = P_L3CODE22 
  
			UNION ALL 
  
			/* 23. 구역코드5 */ 
			SELECT 
				'23' AS GUBUN , 
				L3NAME AS DATA 
			FROM PSSCMLIB . PSM_LOCATION_CLASS3 
			WHERE L3SAUP || L3BCODE || DIGITS ( L3MCODE ) || DIGITS ( L3SCODE ) = P_L3CODE23 
  
			UNION ALL 
  
			/* 24. 확인자1 */ 
			SELECT 
				'24' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN24 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 25. 확인자2 */ 
			SELECT 
				'25' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN25 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 26. 확인자3 */ 
			SELECT 
				'26' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN26 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
  
			/* 27. 확인자4 */ 
			SELECT 
				'27' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN27 
			AND KBBALCD NOT IN ( '900' , '560' ) 
  
			UNION ALL 
			 
			/* 28. 확인자5 */ 
			SELECT 
				'28' AS GUBUN , 
				KBHANGL 
			FROM TYSCMLIB . INKIBNMF 
			WHERE KBSABUN = P_KBSABUN28 
			AND KBBALCD NOT IN ( '900' , '560' ) ; 
  
		OPEN REFCURSOR ; 
  
	END MAIN ; 
  
END P1;