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
    public class PSM1080 : BizBase
    {
        #region Description : 대분류코드 조회(콤보박스)
        public DataSet UP_GET_JSA_BCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1080_JSA_BCODE_LIST");
            }
        }
        #endregion

        #region Description : 중분류코드 조회(콤보박스)
        public DataSet UP_GET_JSA_MCODE_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_BCODE", DbType.String, ht["BCODE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1080_JSA_MCODE_LIST");
            }
        }
        #endregion

        #region Description : 소분류코드 조회(콤보박스)
        public DataSet UP_GET_JSA_SCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_BCODE", DbType.String, ht["BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["MCODE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1080_JSA_SCODE_LIST");
            }
        }
        #endregion

        #region Description : JSA코드 소분류 조회
        public DataSet UP_GET_JSA_CLASS3_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_BCODE", DbType.String, ht["BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["MCODE"]);
                dbCon.AddParameters("P_SCODE", DbType.String, ht["SCODE"]);
                dbCon.AddParameters("P_SNAME", DbType.String, ht["SNAME"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1080_JSA_CLASS3_LIST");
            }
        }
        #endregion

        #region Description : JSA코드 소분류 확인
        public DataSet UP_JSA_CLASS3_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_J3BCODE", DbType.String, ht["J3BCODE"]);
                dbCon.AddParameters("P_J3MCODE", DbType.String, ht["J3MCODE"]);
                dbCon.AddParameters("P_J3SCODE", DbType.String, ht["J3SCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1081_JSA_CLASS3_RUN");
            }
        }
        #endregion

        #region Description : JSA코드 소분류 등록
        public DataSet UP_JSA_CLASS3_ADD(Hashtable ht)
        {
            string sJ3SCODE = string.Empty;
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();

            if (ht["J3SCODE"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    dbCon.AddParameters("P_J3BCODE", DbType.String, ht["J3BCODE"]);
                    dbCon.AddParameters("P_J3MCODE", DbType.String, ht["J3MCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1081_JSA_CLASS3_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJ3SCODE = ds.Tables[0].Rows[0]["J3SCODE"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJ3SCODE = ht["J3SCODE"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_J3BCODE", DbType.String, ht["J3BCODE"]);
                dbCon.AddParameters("P_J3MCODE", DbType.String, ht["J3MCODE"]);
                dbCon.AddParameters("P_J3SCODE", DbType.String, sJ3SCODE);
                dbCon.AddParameters("P_J3NAME", DbType.String, ht["J3NAME"]);
                dbCon.AddParameters("P_J3BIGO", DbType.String, Convert.ToString(ht["J3BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_J3HISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1081_JSA_CLASS3_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_J3BCODE", DbType.String, ht["J3BCODE"]);
                dbCon.AddParameters("P_J3MCODE", DbType.String, ht["J3MCODE"]);
                dbCon.AddParameters("P_J3SCODE", DbType.String, sJ3SCODE);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1081_JSA_CLASS3_RUN");
            }

        }
        #endregion

        #region Description : JSA코드 소분류 삭제
        public DataSet UP_JSA_CLASS3_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSA_CLASS3_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    dbCon.AddParameters("P_J3BCODE", DbType.String, ht["J3BCODE"]);
                    dbCon.AddParameters("P_J3MCODE", DbType.String, ht["J3MCODE"]);
                    dbCon.AddParameters("P_J3SCODE", DbType.String, ht["J3SCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1081_JSA_CLASS3_DEL");

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

        #region Description : JSA코드 소분류 삭제 체크
        public string UP_JSA_CLASS3_Check(Hashtable ht)
        {
            string sMSG = string.Empty;
            DataSet ds = new DataSet();
            // 작업요청, 안전작업허가서에 사용되면 삭제 불가
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //JSA 관리 체크 
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["J3BCODE"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["J3MCODE"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["J3SCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1081_JSA_MASTER_CHECK");

                if (ds.Tables[0].Rows.Count > 0)
                {   
                    sMSG = "JSA관리에 사용된 코드입니다. 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 일일JSA 체크 
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["J3BCODE"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["J3MCODE"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["J3SCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1081_JSACHANGE_MASTER_CHECK");

                if (ds.Tables[0].Rows.Count > 0)
                {   
                    sMSG = "일일JSA에 사용된 코드입니다. 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : JSA코드 중분류 조회
        public DataSet UP_GET_JSA_CLASS2_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_J2BCODE", DbType.String, ht["J2BCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1082_JSA_CLASS2_LIST");
            }
        }
        #endregion

        #region Description : JSA코드 중분류 확인
        public DataSet UP_JSA_CLASS2_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_J2BCODE", DbType.String, ht["J2BCODE"]);
                dbCon.AddParameters("P_J2MCODE", DbType.String, ht["J2MCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1082_JSA_CLASS2_RUN");
            }
        }
        #endregion

        #region Description : JSA코드 중분류 등록
        public DataSet UP_JSA_CLASS2_ADD(Hashtable ht)
        {
            string sJ2MCODE = string.Empty;
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();

            if (ht["J2MCODE"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    dbCon.AddParameters("P_J2BCODE", DbType.String, ht["J2BCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1082_JSA_CLASS2_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJ2MCODE = ds.Tables[0].Rows[0]["J2MCODE"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJ2MCODE = ht["J2MCODE"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_J2BCODE", DbType.String, ht["J2BCODE"]);
                dbCon.AddParameters("P_J2MCODE", DbType.String, sJ2MCODE);
                dbCon.AddParameters("P_J2NAME", DbType.String, ht["J2NAME"]);
                dbCon.AddParameters("P_J2BIGO", DbType.String, Convert.ToString(ht["J2BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_J2HISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1082_JSA_CLASS2_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_J2BCODE", DbType.String, ht["J2BCODE"]);
                dbCon.AddParameters("P_J2MCODE", DbType.String, sJ2MCODE);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1082_JSA_CLASS2_RUN");
            }

        }
        #endregion

        #region Description : JSA코드 중분류 삭제
        public DataSet UP_JSA_CLASS2_DEL(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSA_CLASS2_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    dbCon.AddParameters("P_J2BCODE", DbType.String, ht["J2BCODE"]);
                    dbCon.AddParameters("P_J2MCODE", DbType.String, ht["J2MCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1082_JSA_CLASS2_DEL");

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

        #region Description : JSA코드 중분류 삭제 체크
        public string UP_JSA_CLASS2_Check(Hashtable ht)
        {
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // JSA 소분류코드 체크
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 15);
                dbCon.AddParameters("P_BCODE", DbType.String, ht["J2BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["J2MCODE"]);
                dbCon.AddParameters("P_SCODE", DbType.String, "");
                dbCon.AddParameters("P_SNAME", DbType.String, "");

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1080_JSA_CLASS3_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sMSG = "소분류코드가 존재합니다. 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : JSA코드 대분류 조회
        public DataSet UP_GET_JSA_CLASS1_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1083_JSA_CLASS1_LIST");
            }
        }
        #endregion

        #region Description :JSA코드 대분류 확인
        public DataSet UP_JSA_CLASS1_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_J1CODE", DbType.String, ht["J1CODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1083_JSA_CLASS1_RUN");
            }
        }
        #endregion

        #region Description : JSA코드 대분류 등록
        public DataSet UP_JSA_CLASS1_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSA_CLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    dbCon.AddParameters("P_J1CODE", DbType.String, ht["J1CODE"]);
                    dbCon.AddParameters("P_J1NAME", DbType.String, ht["J1NAME"]);
                    dbCon.AddParameters("P_J1BIGO", DbType.String, Convert.ToString(ht["J1BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                    dbCon.AddParameters("P_J1HISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1083_JSA_CLASS1_ADD");

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

        #region Description : JSA코드 대분류 삭제
        public DataSet UP_JSA_CLASS1_DEL(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSA_CLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    dbCon.AddParameters("P_J1CODE", DbType.String, ht["J1CODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1083_JSA_CLASS1_DEL");

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

        public DataSet UP_JSA_CLASS1_SAVECHECK(Hashtable ht)
        {
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //등록여부 체크 
                dbCon.AddParameters("P_J1CODE", DbType.String, ht["J1CODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1083_JSA_CLASS1_RUN");
            }

            return ds;
        }

        #region Description : JSA코드 대분류 저장/삭제 체크
        public string UP_JSA_CLASS1_Check(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if (ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_J1CODE", DbType.String, ht["J1CODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1083_JSA_CLASS1_RUN");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sMSG = "동일한 코드가 등록되어 있습니다.";

                        return sMSG;
                    }
                }
            }
            else if (ht["WKGUBUN"].ToString() == "D")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //중분류코드 체크 
                    dbCon.AddParameters("P_J2BCODE", DbType.String, ht["J1CODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1082_JSA_CLASS2_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sMSG = "중분류코드가 존재합니다. 삭제 할 수 없습니다.";

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion
    }
}