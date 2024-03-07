using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;
//using System.Web.SessionState;

namespace TaeYoung.Biz.PSM
{
    public class PSM1090 : BizBase
    {
        #region Description : JSA 메뉴 조회
        public DataSet UP_GET_JSA_MENU_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1090_JSA_MENU_LIST");
            }
        }
        #endregion

        #region Description : 보호구, 안전장비 코드 조회
        public DataSet UP_GET_SACODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_CDINDEX", DbType.String, ht["CDINDEX"]);
                dbCon.AddParameters("P_CDCODE", DbType.String, ht["CDCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSP1091_SACODE_LIST");
            }
        }
        #endregion

        #region Description : JSA 마스타 확인
        public DataSet UP_JSA_MASTER_RUN(Hashtable ht)
        {
            //string s = HttpSessionStateSession.;

            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSMBLASS", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, sDatas[1]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, sDatas[2]);
                dbCon.AddParameters("P_JSMSEQ", DbType.String, sDatas[3]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1090_JSA_MASTER_RUN");
            }
        }
        #endregion

        #region Description : JSA 조회 임시파일 생성
        public void UP_JSA_PRT_CREATE(Hashtable ht)
        {
            //string s = HttpSessionStateSession.;

            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SESSION", DbType.String, ht["SESSIONID"]);
                dbCon.AddParameters("P_BLASS", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_MLASS", DbType.String, sDatas[1]);
                dbCon.AddParameters("P_SLASS", DbType.String, sDatas[2]);
                dbCon.AddParameters("P_SEQ", DbType.String, sDatas[3]);
                dbCon.AddParameters("P_SABUN", DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1090_JSA_PRT_CREATE");
            }
        }
        #endregion

        #region Description : JSA 임시파일 조회
        public DataSet UP_JSA_PRT_LIST(Hashtable ht)
        {
            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SESSION", DbType.String, ht["SESSIONID"]);
                dbCon.AddParameters("P_BLASS", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_MLASS", DbType.String, sDatas[1]);
                dbCon.AddParameters("P_SLASS", DbType.String, sDatas[2]);
                dbCon.AddParameters("P_SEQ", DbType.String, sDatas[3]);
                dbCon.AddParameters("P_SABUN", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1090_JSA_PRT_LIST");
            }
        }
        #endregion

        #region Description : JSA 복사
        public void UP_JSA_COPY(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["JSMSLASS"]);
                dbCon.AddParameters("P_JSMSEQ", DbType.String, ht["JSMSEQ"]);
                dbCon.AddParameters("P_BCODE", DbType.String, ht["BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["MCODE"]);
                dbCon.AddParameters("P_SCODE", DbType.String, ht["SCODE"]);
                dbCon.AddParameters("P_JSMWKNAME", DbType.String, ht["JSMWKNAME"]);
                dbCon.AddParameters("P_JSMHISAB", DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1091_JSA_COPY");
            }
        }
        #endregion

        #region Description : JSA 마스터 등록
        public DataSet UP_JSA_MASTER_ADD(Hashtable ht)
        {
            string sJSMSEQ = string.Empty;
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();

            // 순번 가져오기
            if (ht["JSMSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["JSMBLASS"]);
                    dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["JSMMLASS"]);
                    dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["JSMSLASS"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1090_JSA_MASTER_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJSMSEQ = ds.Tables[0].Rows[0]["JSMSEQ"].ToString();
                        ht["JSMSEQ"] = sJSMSEQ;
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                //sJSMSEQ = ht["JSMSEQ"].ToString();
                sWKGUBUN = "C";
            }

            // JSA 마스타 등록
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["JSMSLASS"]);
                dbCon.AddParameters("P_JSMSEQ", DbType.String, ht["JSMSEQ"]);
                dbCon.AddParameters("P_JSMWKNAME", DbType.String, ht["JSMWKNAME"]);
                dbCon.AddParameters("P_JSMSYSTEM", DbType.String, ht["JSMSYSTEM"]);
                dbCon.AddParameters("P_JSMWKDATE", DbType.String, ht["JSMWKDATE"]);
                dbCon.AddParameters("P_JSMADDATE", DbType.String, ht["JSMADDATE"]);
                dbCon.AddParameters("P_JSMADCHASU", DbType.String, ht["JSMADCHASU"]);
                dbCon.AddParameters("P_JSMWKSABUN", DbType.String, ht["JSMWKSABUN"]);
                dbCon.AddParameters("P_JSMSANAME", DbType.String, ht["JSMSANAME"]);
                dbCon.AddParameters("P_JSMSECTIONNUM", DbType.String, ht["JSMSECTIONNUM"]);
                dbCon.AddParameters("P_JSMMSDSCODE", DbType.String, ht["JSMMSDSCODE"]);
                dbCon.AddParameters("P_JSMMSDSSEQ", DbType.String, ht["JSMMSDSSEQ"]);
                dbCon.AddParameters("P_JSMWKSUMMARY", DbType.String, ht["JSMWKSUMMARY"]);
                dbCon.AddParameters("P_JSMNEEDDATA", DbType.String, ht["JSMNEEDDATA"]);
                dbCon.AddParameters("P_JSMRISKCASE", DbType.String, ht["JSMRISKCASE"]);
                dbCon.AddParameters("P_JSMSELFNAME1", DbType.String, ht["JSMSELFNAME1"]);
                dbCon.AddParameters("P_JSMSELFTEXT1", DbType.String, ht["JSMSELFTEXT1"]);
                dbCon.AddParameters("P_JSMSELFNAME2", DbType.String, ht["JSMSELFNAME2"]);
                dbCon.AddParameters("P_JSMSELFTEXT2", DbType.String, ht["JSMSELFTEXT2"]);
                dbCon.AddParameters("P_JSMSELFNAME3", DbType.String, ht["JSMSELFNAME3"]);
                dbCon.AddParameters("P_JSMSELFTEXT3", DbType.String, ht["JSMSELFTEXT3"]);
                dbCon.AddParameters("P_JSMSELFNAME4", DbType.String, ht["JSMSELFNAME4"]);
                dbCon.AddParameters("P_JSMSELFTEXT4", DbType.String, ht["JSMSELFTEXT4"]);
                dbCon.AddParameters("P_JSMSELFNAME5", DbType.String, ht["JSMSELFNAME5"]);
                dbCon.AddParameters("P_JSMSELFTEXT5", DbType.String, ht["JSMSELFTEXT5"]);
                dbCon.AddParameters("P_JSMSCOMNAME1", DbType.String, ht["JSMSCOMNAME1"]);
                dbCon.AddParameters("P_JSMSCOMTEXT1", DbType.String, ht["JSMSCOMTEXT1"]);
                dbCon.AddParameters("P_JSMSCOMNAME2", DbType.String, ht["JSMSCOMNAME2"]);
                dbCon.AddParameters("P_JSMSCOMTEXT2", DbType.String, ht["JSMSCOMTEXT2"]);
                dbCon.AddParameters("P_JSMHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1090_JSA_MASTER_ADD");
            }
            // 안전보호구, 안전장비 등록
            UP_JSA_MSAFETOOL_ADD(ht);
            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["JSMSLASS"]);
                dbCon.AddParameters("P_JSMSEQ", DbType.String, ht["JSMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1090_JSA_MASTER_RUN");
            }

        }
        #endregion

        #region Description : JSA 마스터 삭제
        public void UP_JSA_MASTER_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["JSMSLASS"]);
                dbCon.AddParameters("P_JSMSEQ", DbType.String, ht["JSMSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1090_JSA_MASTER_DEL");
            }
        }
        #endregion

        #region Description : JSA 안전보호구 및 안전장비 등록
        public void UP_JSA_MSAFETOOL_ADD(Hashtable ht)
        {

            string[] sSACODE = ht["SACODE"].ToString().Split(',');
            string[] sSANAME = ht["SANAME"].ToString().Replace(", ", ",").Split(',');
            string[] sTOCODE = ht["TOCODE"].ToString().Split(',');
            string[] sTONAME = ht["TONAME"].ToString().Replace(", ", ",").Split(',');

            // JSA 안전보호구 및 안전장비 삭제
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSTBLASS", DbType.String, ht["JSMBLASS"]);
                dbCon.AddParameters("P_JSTMLASS", DbType.String, ht["JSMMLASS"]);
                dbCon.AddParameters("P_JSTSLASS", DbType.String, ht["JSMSLASS"]);
                dbCon.AddParameters("P_JSTSEQ", DbType.String, ht["JSMSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1090_JSA_MSAFETOOL_DEL");
            }


            // JSA 안전보호구 및 안전장비 등록
            for (int i = 0; i < sSACODE.Length; i++)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSTBLASS", DbType.String, ht["JSMBLASS"]);
                    dbCon.AddParameters("P_JSTMLASS", DbType.String, ht["JSMMLASS"]);
                    dbCon.AddParameters("P_JSTSLASS", DbType.String, ht["JSMSLASS"]);
                    dbCon.AddParameters("P_JSTSEQ", DbType.String, ht["JSMSEQ"]);
                    dbCon.AddParameters("P_JSTINDX", DbType.String, (i + 1));
                    dbCon.AddParameters("P_JSTCODEGUBN", DbType.String, "1");
                    dbCon.AddParameters("P_JSTSAFECODE", DbType.String, sSACODE[0]);
                    dbCon.AddParameters("P_JSTSAFENAME", DbType.String, sSANAME[0]);
                    dbCon.AddParameters("P_SWHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1090_JSA_MSAFETOOL_ADD");
                }
            }
            for (int i = 0; i < sTOCODE.Length; i++)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSTBLASS", DbType.String, ht["JSMBLASS"]);
                    dbCon.AddParameters("P_JSTMLASS", DbType.String, ht["JSMMLASS"]);
                    dbCon.AddParameters("P_JSTSLASS", DbType.String, ht["JSMSLASS"]);
                    dbCon.AddParameters("P_JSTSEQ", DbType.String, ht["JSMSEQ"]);
                    dbCon.AddParameters("P_JSTINDX", DbType.String, (i + 1 + sSACODE.Length));
                    dbCon.AddParameters("P_JSTCODEGUBN", DbType.String, "2");
                    dbCon.AddParameters("P_JSTSAFECODE", DbType.String, sTOCODE[0]);
                    dbCon.AddParameters("P_JSTSAFENAME", DbType.String, sTONAME[0]);
                    dbCon.AddParameters("P_SWHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1090_JSA_MSAFETOOL_ADD");
                }
            }
        }
        #endregion



        #region Description : JSA DETAIL 조회
        public DataSet UP_JSA_DETAIL_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1092_JSA_DETAIL_LIST");
            }
        }
        #endregion

        #region Description : JSA DETAIL 확인
        public DataSet UP_JSA_DETAIL_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSDITEMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1092_JSA_DETAIL_RUN");
            }
        }
        #endregion

        #region Description : JSA DETAIL 등록
        public DataSet UP_JSA_DETAIL_ADD(Hashtable ht)
        {
            string sJSDITEMSEQ = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["JSDITEMSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                    dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                    dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                    dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1092_JSA_DETAIL_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJSDITEMSEQ = ds.Tables[0].Rows[0]["JSDITEMSEQ"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJSDITEMSEQ = ht["JSDITEMSEQ"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, sJSDITEMSEQ);
                dbCon.AddParameters("P_JSDITEMTEXT", DbType.String, ht["JSDITEMTEXT"]);
                dbCon.AddParameters("P_JSDTOOLTEXT", DbType.String, ht["JSDTOOLTEXT"]);
                dbCon.AddParameters("P_JSDHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1092_JSA_DETAIL_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, sJSDITEMSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1092_JSA_DETAIL_RUN");
            }
        }
        #endregion

        #region Description : JSA DETAIL 삭제
        public DataSet UP_JSA_DETAIL_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSA_DETAIL_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                    dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                    dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                    dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                    dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSDITEMSEQ"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1092_JSA_DETAIL_DEL");

                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"] = "";
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);
                }
            }
            else
            {
                row = dt.NewRow();
                row["STATE"] = "ERR";
                row["MSG"] = sMSG;
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : JSA DEATIL 삭제 체크
        public string UP_JSA_DETAIL_Check(Hashtable ht)
        {
            string sMSG = string.Empty;

            DataSet ds = new DataSet();

            // 위험성 체크
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSDITEMSEQ"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_RISK_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {  
                    sMSG = "위험성 자료가 존재하여 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }
            // 개선대책 체크
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSDITEMSEQ"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_REFORM_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {   
                    sMSG = "개선대책 자료가 존재하여 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion



        #region Description : JSA 위험성 조회
        public DataSet UP_JSA_RISK_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSDITEMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_RISK_LIST");
            }
        }
        #endregion

        #region Description : JSA 위험성 확인
        public DataSet UP_JSA_RISK_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSRBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSRMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSRSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSRSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, ht["JSRSUBSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_RISK_RUN");
            }
        }
        #endregion

        #region Description : JSA 위험성 등록
        public DataSet UP_JSA_RISK_ADD(Hashtable ht)
        {
            string sJSRSUBSEQ = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["JSRSUBSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["JSRBLASS"]);
                    dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["JSRMLASS"]);
                    dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["JSRSLASS"]);
                    dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["JSRSEQ"]);
                    dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["JSRITEMSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_RISK_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJSRSUBSEQ = ds.Tables[0].Rows[0]["JSRSUBSEQ"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJSRSUBSEQ = ht["JSRSUBSEQ"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["JSRBLASS"]);
                dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["JSRMLASS"]);
                dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["JSRSLASS"]);
                dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["JSRSEQ"]);
                dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, sJSRSUBSEQ);
                dbCon.AddParameters("P_JSRRISKTEXT", DbType.String, ht["JSRRISKTEXT"]);
                dbCon.AddParameters("P_JSRRISKCNT", DbType.String, ht["JSRRISKCNT"]);
                dbCon.AddParameters("P_JSRRISKSOLID", DbType.String, ht["JSRRISKSOLID"]);
                dbCon.AddParameters("P_JSRRISKDEGREE", DbType.String, ht["JSRRISKDEGREE"]);
                dbCon.AddParameters("P_JSRHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1093_JSA_RISK_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSRBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSRMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSRSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSRSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, sJSRSUBSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_RISK_RUN");
            }
        }
        #endregion

        #region Description : JSA 위험성 삭제
        public void UP_JSA_RISK_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["JSRBLASS"]);
                dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["JSRMLASS"]);
                dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["JSRSLASS"]);
                dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["JSRSEQ"]);
                dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, ht["JSRSUBSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1093_JSA_RISK_DEL");
            }
        }
        #endregion



        #region Description : JSA 개선대책 조회
        public DataSet UP_JSA_REFORM_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["JSDITEMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_REFORM_LIST");
            }
        }
        #endregion

        #region Description : JSA 개선대책 확인
        public DataSet UP_JSA_REFORM_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, ht["JSESUBSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_REFORM_RUN");
            }
        }
        #endregion

        #region Description : JSA 개선대책 등록
        public DataSet UP_JSA_REFORM_ADD(Hashtable ht)
        {
            string sJSESUBSEQ = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["JSESUBSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["JSEBLASS"]);
                    dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["JSEMLASS"]);
                    dbCon.AddParameters("P_JSESLASS", DbType.String, ht["JSESLASS"]);
                    dbCon.AddParameters("P_JSESEQ", DbType.String, ht["JSESEQ"]);
                    dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["JSEITEMSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_REFORM_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJSESUBSEQ = ds.Tables[0].Rows[0]["JSESUBSEQ"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJSESUBSEQ = ht["JSESUBSEQ"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, sJSESUBSEQ);
                dbCon.AddParameters("P_JSEREFORMTEXT", DbType.String, ht["JSEREFORMTEXT"]);
                dbCon.AddParameters("P_JSEREFORMCNT", DbType.String, ht["JSEREFORMCNT"]);
                dbCon.AddParameters("P_JSEREFORMSOLID", DbType.String, ht["JSEREFORMSOLID"]);
                dbCon.AddParameters("P_JSEREFORMDEGREE", DbType.String, ht["JSEREFORMDEGREE"]);
                dbCon.AddParameters("P_JSEHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1093_JSA_REFORM_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, sJSESUBSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1093_JSA_REFORM_RUN");
            }
        }
        #endregion

        #region Description : JSA 개선대책 삭제
        public void UP_JSA_REFORM_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, ht["JSESUBSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1093_JSA_REFORM_DEL");
            }
        }
        #endregion

        #region Description : JSA 출력 첨부파일 조회
        public DataSet PSM_PSM1090_JSA_ATTACH_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ATTACH_NO", DbType.String, ht["ATTACH_NO"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1090_JSA_ATTACH_LIST");
            }
        }
        #endregion
    }
}