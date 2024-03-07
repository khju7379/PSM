using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;

namespace TaeYoung.Biz.PSM
{
    public class PSMBiz : BizBase
    {
        /// <summary>
        /// 공지사항을 가져온다.
        /// </summary>
        /// <returns></returns>
        public DataSet GetBoard(Hashtable ht)
        {
            string query = "";

            //query += "SELECT  ROWNUM "+Environment.NewLine;
            //query += "        ,   A.BBS_NO"+Environment.NewLine;
            //query += "        ,   A.UP_BBS_NO"+Environment.NewLine;
            //query += "        ,   A.READ_COUNT"+Environment.NewLine;
            //query += "        ,   LENGTH(A.BODY) AS BODY"+Environment.NewLine;
            //query += "        ,   A.WRITE_USER"+Environment.NewLine;
            //query += "        ,   TO_CHAR(TO_DATE(A.WRITE_DTM, 'YYYYMMDDHH24MISS'), 'YYYY-MM-DD')"+Environment.NewLine;
            //query += "                    AS WRITE_DTM"+Environment.NewLine;
            //query += "        ,   DECODE(LEVEL, 1, '', LPAD(' ', (LEVEL -1) * 3, ' ') || '┗') || A.SUBJECT"+Environment.NewLine;
            //query += "                    AS SUBJECT_NM"+Environment.NewLine;
            //query += "        ,   ("+Environment.NewLine;
            //query += "                SELECT"+Environment.NewLine;
            //query += "                            C.DEV_NAME "+Environment.NewLine;
            //query += "                FROM        DEVELOPER C"+Environment.NewLine;
            //query += "                WHERE       A.WRITE_USER = C.DEV_NO"+Environment.NewLine;
            //query += "            )       AS WRITE_USER_NAME"+Environment.NewLine;
            //query += "FROM        BOARD A"+Environment.NewLine;
            //query += "INNER JOIN  BOARD_GROUP B"+Environment.NewLine;
            //query += "    ON      (A.GROUP_NO = B.GROUP_NO)"+Environment.NewLine;
            //query += "WHERE       A.GROUP_NO = 'TY43D2B712'"+Environment.NewLine;
            //query += "    AND     POST_START_DTE < TO_CHAR(SYSDATE + 1, 'YYYYMMDD')"+Environment.NewLine;
            //query += "    AND     POST_END_DTE > TO_CHAR(SYSDATE - 1, 'YYYYMMDD')"+Environment.NewLine;
            //query += "    AND     A.SUBJECT LIKE '%' || :SUBJECT || '%'"+Environment.NewLine;
            //query += "    AND     A.BODY LIKE '%' || :BODY || '%'"+Environment.NewLine;
            //query += "START WITH  A.UP_BBS_NO IS NULL"+Environment.NewLine;
            //query += "CONNECT BY PRIOR  A.BBS_NO = A.UP_BBS_NO"+Environment.NewLine;
            //query += "ORDER SIBLINGS BY DECODE(DEPTH, 0, BBS_NO, 999 - SEQ) DESC" + Environment.NewLine;

            query = "SELECT * FROM T_TAG";

            using (DacConnecter dac = new DacConnecter("ORA"))
            {
                DataSet  ds = dac.ExcuteDataSet(query, true);

                
                // return dac.ExcuteDataSet(query, true);

                if ( ds.Tables[0].Rows.Count > 0 )
                {
                    string ddd = "ddd";
                }

                return ds;
            }

            // 
        }

        /// <summary>
        /// 작업요청서 가져온다.
        /// </summary>
        /// <returns></returns>
        public DataSet getWorkOrder(Hashtable ht)
        {
            string sSabun = Document.UserInfo.EmpID;
            //string sSDATE = "20180101";
            string sSDATE = "20201001";
            string sEDATE = string.Format("{0:yyyyMMdd}", DateTime.Now.AddMonths(12));

            string sTeam = string.Empty;

            //전산, 안전은 전체 조회 가능 나머지는 해당 사업부만 보기
            if (Document.UserInfo.DeptCode != "A10300" && Document.UserInfo.DeptCode != "D10000")
            {
                sTeam = Document.UserInfo.DeptCode.Substring(0, 1);
            }
            else
            {
                sTeam = "";
                sSabun = "";
            }

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                db2.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                db2.AddParameters("P_SDATE", DbType.String, sSDATE);
                db2.AddParameters("P_EDATE", DbType.String, sEDATE);
                db2.AddParameters("P_WKGUBN", DbType.String, "A");
                db2.AddParameters("P_WKSTATUS", DbType.String, "A");
                db2.AddParameters("P_WKTEAM", DbType.String, sTeam);
                db2.AddParameters("P_ORSABUN", DbType.String, sSabun);
                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_LIST");

                return ds;
            }
        }

        /// <summary>
        /// 결재문서 가져온다.
        /// </summary>
        /// <returns></returns>
        public DataSet getDocWorkOrder(Hashtable ht)
        {

            DataSet ds3 = GetBoard(ht);


            string sSabun = Document.UserInfo.EmpID;
            string sSDATE = "20210101";
            string sEDATE = string.Format("{0:yyyyMMdd}", DateTime.Now.AddMonths(12));
            
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                db2.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                db2.AddParameters("P_SDATE", DbType.String, sSDATE);
                db2.AddParameters("P_EDATE", DbType.String, sEDATE);
                db2.AddParameters("P_SABUN", DbType.String, sSabun);
                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_DOC");

                return ds;
            }
        }

        public DataSet UP_KBSABUN_RUN(Hashtable ht)
        {
            if (ht["P_KBSABUN"] == null)
            {
                ht["P_KBSABUN"] = "";
            }         

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_KBSABUN", DbType.String, ht["P_KBSABUN"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

                return ds;
            }
        }

        #region SILO BIN 설비정보 가져온다
        /// <summary>
        /// SILO BIN 설비정보 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetBINSYSTEMCLASS(Hashtable ht)
        {
            DataSet ds = new DataSet();

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {

                    dbCon.AddParameters("IN_LOADGUBN", DbType.String, ht["IN_LOADGUBN"]);
                    dbCon.AddParameters("IN_SDATE", DbType.String, ht["IN_SDATE"]);
                    dbCon.AddParameters("IN_C2SAUP", DbType.String, ht["IN_C2SAUP"]);

                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.BIN_SYSTEM_CLASS");

                    return ds;
                }
           
        }
        #endregion


        #region 설비정보 가져온다
        /// <summary>
        /// SILO BIN 설비정보 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetUnitData(Hashtable ht)
        {
           

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_C2SAUP", DbType.String, ht["P_SAUP"]);
                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_Plants_GetUnitData");              

                return ds;
            }
        }
        #endregion

        #region 주변지역 설비정보 가져오기
        /// <summary>
        /// 주변지역 설비정보 가져오기
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet AreaGetUnitData(Hashtable ht)
        {

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_C2SAUP", DbType.String, ht["P_SAUP"]);
                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_Area_GetUnitData");

                return ds;
            }
        }
        #endregion


        #region SILO 선박현황 가져온다
        /// <summary>
        /// SILO 선박현황 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetShipListData(Hashtable ht)
        {            

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_SDATE", DbType.String, ht["P_SDATE"]);
                db2.AddParameters("P_YEAR", DbType.String, ht["P_YEAR"]);
                db2.AddParameters("P_EISDATE", DbType.String, ht["P_EISDATE"]);
                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_Plants_GetShipListData");

                return ds;
            }
        }
        #endregion

        /// <summary>
        /// 작업요청서 설비코드에 해당하는 작업내용 가져오기
        /// </summary>
        /// <returns></returns>
        public DataSet GetWorkOrder_Run(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_SAUP", DbType.String, ht["P_SAUP"]);
                db2.AddParameters("P_CODE", DbType.String, ht["P_CODE"]);
                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_Plants_GetWorkingData_Run");

                return ds;
            }
        }

        /// <summary>
        /// 현재 작업요청서 작업내용 가져오기
        /// </summary>
        /// <returns></returns>
        public DataSet GetWorkOrder_List(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_C2SAUP", DbType.String, ht["P_SAUP"]);
                
                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_Plants_GetWorkingData");

                return ds;
            }
        }

        #region UTT 선박현황 가져온다
        /// <summary>
        /// UTT  선박현황 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetShipListData_UTT(Hashtable ht)
        {

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_SHHWDATE", DbType.String, ht["P_SHHWDATE"]);                
                db2.AddParameters("P_KIJUNDATE", DbType.String, ht["P_KIJUNDATE"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_Plants_GetShipListData_UTT");

                return ds;
            }
        }
        #endregion

        #region Description : 조직도 가져오기
        public DataSet UP_ORG_GETDATA(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_BUSEO1", DbType.String, ht["P_BUSEO1"]);
                db2.AddParameters("P_BUSEO2", DbType.String, ht["P_BUSEO2"]);
                db2.AddParameters("P_BUSEO3", DbType.String, ht["P_BUSEO3"]);
                db2.AddParameters("P_BUSEO4", DbType.String, ht["P_BUSEO4"]);
                db2.AddParameters("P_BUSEO5", DbType.String, ht["P_BUSEO5"]);
                db2.AddParameters("P_BUSEO6", DbType.String, ht["P_BUSEO6"]);
                db2.AddParameters("P_BUSEO7", DbType.String, ht["P_BUSEO7"]);
                db2.AddParameters("P_BUSEO8", DbType.String, ht["P_BUSEO8"]);
                db2.AddParameters("P_SABUN",  DbType.String, ht["P_SABUN"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_ORG_GETDATA");

                return ds;
            }
        }
        #endregion

        #region Description : 구매발주 조회
        public DataSet UP_GET_MRPPOMF_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_STDATE",           DbType.String, ht["P_STDATE"]);
                dbCon.AddParameters("P_EDDATE",           DbType.String, ht["P_EDDATE"]);
                dbCon.AddParameters("P_POM1180",          DbType.String, ht["P_POM1180"]);
                dbCon.AddParameters("P_SAUP",             DbType.String, ht["P_SAUP"]);
                dbCon.AddParameters("P_POMGUBN",          DbType.String, ht["P_POMGUBN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_POPUP_MRPPOMF_LIST");
            }
        }
        #endregion

        #region Description : 서치뷰 - 안전작업허가서 사번 가져오기
        public DataSet UP_SAFE_KBSABUN_LIST(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND ( (KBSABUN LIKE '%" + ht["SearchCondition"] + "%') OR ( KBHANGL LIKE '%" + ht["SearchCondition"] + "%') )";
            }

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                db2.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                db2.AddParameters("P_GRPID",            DbType.String, ht["GRPID"]);
                db2.AddParameters("P_SEARCHCONDITION",  DbType.String, ht["SearchCondition"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_SAFE_KBSABUN_LIST");

                return ds;
            }
        }
        #endregion

        #region Description : 서치뷰 - 권한자 사번 가져오기
        public DataSet UP_SAFE_MAG_LIST(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_GRPID", DbType.Int32, ht["P_GRPID"]);
                db2.AddParameters("P_USRID", DbType.Int32, ht["P_USRID"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_SAFE_MAG_LIST");

                return ds;
            }
        }
        #endregion

        #region Description : 서치뷰 - 동일부서 사번 가져오기
        public DataSet UP_BUSEO_EMPOYEE_LIST(Hashtable ht)
        {
            string sBUSEO = string.Empty;

            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND ( (TEMP.KBSABUN LIKE '%" + ht["SearchCondition"] + "%') OR ( TEMP.KBHANGL LIKE '%" + ht["SearchCondition"] + "%') )";
            }

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                DataSet ds = new DataSet();

                if (Document.UserInfo.DeptCode.ToString() == "E10000" || Document.UserInfo.DeptCode.ToString() == "E10100")
                {
                    db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                    db2.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                    db2.AddParameters("P_KBBUSEO",          DbType.String, "E10000");
                    db2.AddParameters("P_KBBUSEO",          DbType.String, "E10100");
                    db2.AddParameters("P_SEARCHCONDITION",  DbType.String, ht["SearchCondition"]);

                    ds = db2.ExcuteDataSet("PSSCMLIB.PSM_BUSEO_EMPOYEE1_LIST");
                }
                else
                {
                    db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                    db2.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                    db2.AddParameters("P_KBBUSEO",          DbType.String, Document.UserInfo.DeptCode.ToString());
                    db2.AddParameters("P_SEARCHCONDITION",  DbType.String, ht["SearchCondition"]);

                    ds = db2.ExcuteDataSet("PSSCMLIB.PSM_BUSEO_EMPOYEE_LIST");
                }
                

                return ds;
            }
        }
        #endregion

        #region Description : 서치뷰 - 안전작업허가서 사번 가져오기
        public DataSet UP_OPERA_KBSABUN_LIST(Hashtable ht)
        {
            string sBUSEO = string.Empty;

            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND ( (KBSABUN LIKE '%" + ht["SearchCondition"] + "%') OR ( KBHANGL LIKE '%" + ht["SearchCondition"] + "%') )";
            }

            if (Document.UserInfo.DeptCode.ToString().Substring(0, 1) == "A" ||
                Document.UserInfo.DeptCode.ToString().Substring(0, 1) == "D" ||
                Document.UserInfo.DeptCode.ToString().Substring(0, 1) == "E")
            {
                sBUSEO = "S1,T1";
            }
            else if (Document.UserInfo.DeptCode.ToString().Substring(0, 1) == "S")
            {
                sBUSEO = "S1";
            }
            else if (Document.UserInfo.DeptCode.ToString().Substring(0, 1) == "T")
            {
                sBUSEO = "T1";
            }

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                db2.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                db2.AddParameters("P_KBBUSEO",          DbType.String, sBUSEO.ToString());
                db2.AddParameters("P_SEARCHCONDITION",  DbType.String, ht["SearchCondition"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_OPERA_KBSABUN_LIST");

                return ds;
            }
        }
        #endregion

        #region Description : 서치뷰 - 부서 가져오기
        public DataSet UP_BUSEO_GETDATA(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND ( (ORG_CD LIKE '%" + ht["SearchCondition"] + "%') OR ( ORG_NM LIKE '%" + ht["SearchCondition"] + "%') )";
            }

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                db2.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                db2.AddParameters("P_DATE",             DbType.String, ht["P_DATE"]);
                db2.AddParameters("P_ORG_NM",           DbType.String, ht["SearchCondition"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_BUSEO_GETDATA");

                return ds;
            }
        }
        #endregion

        #region Description : 서치뷰 - 사번 가져오기
        public DataSet UP_KBSABUN_LIST(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND ( (KBSABUN LIKE '%" + ht["SearchCondition"] + "%') OR ( KBHANGL LIKE '%" + ht["SearchCondition"] + "%') )";
            }

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                db2.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                db2.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_LIST");

                return ds;
            }
        }
        #endregion

        #region Description : 사번별 부서가져오기
        public DataSet UP_SABUN_GET_BUSEO(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_DATE",    DbType.String, ht["P_DATE"]);
                db2.AddParameters("P_KBSABUN", DbType.String, ht["P_KBSABUN"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_SABUN_GET_BUSEO");

                return ds;
            }
        }
        #endregion

        #region Description : 서치뷰 - 탱크번호 가져오기
        public DataSet UP_TANKNO_LIST(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                db2.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                db2.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_TANKNO_LIST");

                return ds;
            }
        }
        #endregion

        #region Description : 참조자 가져오기
        public DataSet UP_REFERENCE_LIST(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_REDOCID",  DbType.String, ht["P_REDOCID"]);
                db2.AddParameters("P_REDOCNUM", DbType.String, ht["P_REDOCNUM"]);

                DataSet ds = db2.ExcuteDataSet("PSSCMLIB.PSM_REFERENCE_LIST");

                return ds;
            }
        }
        #endregion

        #region Description : 참조자 업데이트
        public void UP_REFREENCE_UPDATE(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_GUBUN",    DbType.String, ht["P_GUBUN"]);
                dbCon.AddParameters("P_REDOCID",  DbType.String, ht["P_REDOCID"]);
                dbCon.AddParameters("P_REDOCNUM", DbType.String, ht["P_REDOCNUM"]);
                dbCon.AddParameters("P_RESABUN",  DbType.String, ht["P_RESABUN"]);
                dbCon.AddParameters("P_RENAME",   DbType.String, ht["P_RENAME"]);
                dbCon.AddParameters("P_REHISAB",  DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_REFERENCE_UPDATE");
            }
        }
        #endregion

        #region Description : 서치뷰 - 공통코드 조회
        public DataSet UP_GET_CODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_INDEX", DbType.String, ht["INDEX"]);


                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_CODE_LIST");
            }
        }
        #endregion

        #region Description : 첨부파일 삭제
        public void UP_ATTACHFILE_DELETE(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ATTACH_TYPE",  DbType.String, ht["P_ATTACH_TYPE"]);
                dbCon.AddParameters("P_ATTACH_NO",    DbType.String, ht["P_ATTACH_NO"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_ATTACHFILE_DEL");
            }
        }
        #endregion
    }
}
