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
    public class PSM1020 : BizBase
    {
        #region Description : 대분류코드 조회(콤보박스)
        public DataSet UP_GET_LCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SAUP", DbType.String, ht["SAUP"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1020_LCODE_LIST");
            }
        }
        #endregion

        #region Description : 중분류코드 조회(콤보박스)
        public DataSet UP_GET_MCODE_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SAUP", DbType.String, ht["SAUP"]);
                dbCon.AddParameters("P_LCODE", DbType.String, ht["LCODE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1020_MCODE_LIST");
            }
        }
        #endregion

        #region Description : 위치코드 조회(콤보박스)
        public DataSet UP_GET_SCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SAUP", DbType.String, ht["SAUP"]);
                dbCon.AddParameters("P_LCODE", DbType.String, ht["LCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["MCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1020_SCODE_LIST");
            }
        }
        #endregion

        #region Description : 위치코드 소분류 조회
        public DataSet UP_GET_LOCATIONCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SAUP", DbType.String, ht["SAUP"]);
                dbCon.AddParameters("P_LCODE", DbType.String, ht["LCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["MCODE"]);
                dbCon.AddParameters("P_SCODE", DbType.String, ht["SCODE"]);
                dbCon.AddParameters("P_SNAME", DbType.String, ht["SNAME"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1020_LOCATIONCODE_LIST");
            }
        }
        #endregion

        #region Description : 위치코드 소분류 확인
        public DataSet UP_LOCATIONCODE_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_L3SAUP", DbType.String, ht["L3SAUP"]);
                dbCon.AddParameters("P_L3BCODE", DbType.String, ht["L3BCODE"]);
                dbCon.AddParameters("P_L3MCODE", DbType.String, ht["L3MCODE"]);
                dbCon.AddParameters("P_L3SCODE", DbType.String, ht["L3SCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1021_LOCATIONCODE_RUN");
            }
        }
        #endregion

        #region Description : 위치코드 소분류 등록
        public DataSet UP_LOCATIONCODE_ADD(Hashtable ht)
        {
            string sL3SCODE = string.Empty;
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();

            if(ht["L3SCODE"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_L3SAUP", DbType.String, ht["L3SAUP"]);
                    dbCon.AddParameters("P_L3BCODE", DbType.String, ht["L3BCODE"]);
                    dbCon.AddParameters("P_L3MCODE", DbType.String, ht["L3MCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1021_LOCATIONCODE_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sL3SCODE = ds.Tables[0].Rows[0]["L3SCODE"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else 
            {
                sL3SCODE = ht["L3SCODE"].ToString();
                sWKGUBUN = "C";
            }
            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_L3SAUP", DbType.String, ht["L3SAUP"]);
                dbCon.AddParameters("P_L3BCODE", DbType.String, ht["L3BCODE"]);
                dbCon.AddParameters("P_L3MCODE", DbType.String, ht["L3MCODE"]);
                dbCon.AddParameters("P_L3SCODE", DbType.String, sL3SCODE);
                dbCon.AddParameters("P_L3NAME", DbType.String, ht["L3NAME"]);
                dbCon.AddParameters("P_L3BIGO", DbType.String, Convert.ToString(ht["L3BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_L3HISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1021_LOCATIONCODE_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_L3SAUP", DbType.String, ht["L3SAUP"]);
                dbCon.AddParameters("P_L3BCODE", DbType.String, ht["L3BCODE"]);
                dbCon.AddParameters("P_L3MCODE", DbType.String, ht["L3MCODE"]);
                dbCon.AddParameters("P_L3SCODE", DbType.String, sL3SCODE);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1021_LOCATIONCODE_RUN");
            }

        }
        #endregion

        #region Description : 위치코드 소분류 삭제
        public DataSet UP_LOCATIONCODE_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_LocationCode_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            { 
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_L3SAUP", DbType.String, ht["L3SAUP"]);
                    dbCon.AddParameters("P_L3BCODE", DbType.String, ht["L3BCODE"]);
                    dbCon.AddParameters("P_L3MCODE", DbType.String, ht["L3MCODE"]);
                    dbCon.AddParameters("P_L3SCODE", DbType.String, ht["L3SCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1021_LOCATIONCODE_DEL");

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

        #region Description : 위치코드 소분류 삭제 체크
        public string UP_LocationCode_Check(Hashtable ht)
        {
            string sMSG = string.Empty;
            DataSet ds = new DataSet();
            // 작업요청, 안전작업허가서에 사용되면 삭제 불가
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //작업요청서 체크 
                dbCon.AddParameters("P_L3SAUP", DbType.String, ht["L3SAUP"]);
                dbCon.AddParameters("P_L3BCODE", DbType.String, ht["L3BCODE"]);
                dbCon.AddParameters("P_L3MCODE", DbType.String, ht["L3MCODE"]);
                dbCon.AddParameters("P_L3SCODE", DbType.String, ht["L3SCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1021_WORKORDER_CHECK");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                    {
                        sMSG = "작업요청서에 사용된 코드입니다. 삭제 할 수 없습니다.";

                        return sMSG;
                    }
                }
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //안전작업허가서 체크 
                dbCon.AddParameters("P_L3SAUP", DbType.String, ht["L3SAUP"]);
                dbCon.AddParameters("P_L3BCODE", DbType.String, ht["L3BCODE"]);
                dbCon.AddParameters("P_L3MCODE", DbType.String, ht["L3MCODE"]);
                dbCon.AddParameters("P_L3SCODE", DbType.String, ht["L3SCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1021_SAFEORDER_CHECK");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                    {
                        sMSG = "안전작업허가에 사용된 코드입니다. 삭제 할 수 없습니다.";

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : 위치코드 중분류 조회
        public DataSet UP_GET_LOCATION_CLASS2_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_L2SAUP", DbType.String, ht["L2SAUP"]);
                dbCon.AddParameters("P_L2BCODE", DbType.String, ht["L2BCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1022_LOCATION_CLASS2_LIST");
            }
        }
        #endregion

        #region Description : 위치코드 중분류 확인
        public DataSet UP_LOCATION_CLASS2_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_L2SAUP", DbType.String, ht["L2SAUP"]);
                dbCon.AddParameters("P_L2BCODE", DbType.String, ht["L2BCODE"]);
                dbCon.AddParameters("P_L2MCODE", DbType.String, ht["L2MCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1022_LOCATION_CLASS2_RUN");
            }
        }
        #endregion

        #region Description : 위치코드 중분류 등록
        public DataSet UP_LOCATION_CLASS2_ADD(Hashtable ht)
        {
            string sL2MCODE = string.Empty;
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();

            if (ht["L2MCODE"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_L2SAUP", DbType.String, ht["L2SAUP"]);
                    dbCon.AddParameters("P_L2BCODE", DbType.String, ht["L2BCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1022_LOCATION_CLASS2_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sL2MCODE = ds.Tables[0].Rows[0]["L2MCODE"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sL2MCODE = ht["L2MCODE"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_L2SAUP", DbType.String, ht["L2SAUP"]);
                dbCon.AddParameters("P_L2BCODE", DbType.String, ht["L2BCODE"]);
                dbCon.AddParameters("P_L2MCODE", DbType.String, sL2MCODE);
                dbCon.AddParameters("P_L2NAME", DbType.String, ht["L2NAME"]);
                dbCon.AddParameters("P_L2BIGO", DbType.String, Convert.ToString(ht["L2BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_L2HISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1022_LOCATION_CLASS2_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_L2SAUP", DbType.String, ht["L2SAUP"]);
                dbCon.AddParameters("P_L2BCODE", DbType.String, ht["L2BCODE"]);
                dbCon.AddParameters("P_L2MCODE", DbType.String, sL2MCODE);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1022_LOCATION_CLASS2_RUN");
            }

        }
        #endregion

        #region Description : 위치코드 중분류 삭제
        public DataSet UP_LOCATION_CLASS2_DEL(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_Location_CLASS2_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_L2SAUP", DbType.String, ht["L2SAUP"]);
                    dbCon.AddParameters("P_L2BCODE", DbType.String, ht["L2BCODE"]);
                    dbCon.AddParameters("P_L2MCODE", DbType.String, ht["L2MCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1022_LOCATION_CLASS2_DEL");

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

        #region Description : 위치코드 중분류 삭제 체크
        public string UP_Location_CLASS2_Check(Hashtable ht)
        {   
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //작업요청서 체크 
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 15);
                dbCon.AddParameters("P_SAUP", DbType.String, ht["L2SAUP"]);
                dbCon.AddParameters("P_LCODE", DbType.String, ht["L2BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["L2MCODE"]);
                dbCon.AddParameters("P_SCODE", DbType.String, "");
                dbCon.AddParameters("P_SNAME", DbType.String, "");

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1020_LOCATIONCODE_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {   
                    sMSG = "소분류코드가 존재합니다. 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : 위치코드 대분류 조회
        public DataSet UP_GET_LOCATION_CLASS1_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1023_LOCATION_CLASS1_LIST");
            }
        }
        #endregion

        #region Description : 위치코드 대분류 확인
        public DataSet UP_LOCATION_CLASS1_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_L1SAUP", DbType.String, ht["L1SAUP"]);
                dbCon.AddParameters("P_L1CODE", DbType.String, ht["L1CODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1023_LOCATION_CLASS1_RUN");
            }
        }
        #endregion

        #region Description : 위치코드 대분류 등록
        public DataSet UP_LOCATION_CLASS1_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_Location_CLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_L1SAUP", DbType.String, ht["L1SAUP"]);
                    dbCon.AddParameters("P_L1CODE", DbType.String, ht["L1CODE"]);
                    dbCon.AddParameters("P_L1NAME", DbType.String, ht["L1NAME"]);
                    dbCon.AddParameters("P_L1BIGO", DbType.String, Convert.ToString(ht["L1BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                    dbCon.AddParameters("P_L1HISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1023_LOCATION_CLASS1_ADD");

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

        #region Description : 위치코드 대분류 삭제
        public DataSet UP_LOCATION_CLASS1_DEL(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_Location_CLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_L1SAUP", DbType.String, ht["L1SAUP"]);
                    dbCon.AddParameters("P_L1CODE", DbType.String, ht["L1CODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1023_LOCATION_CLASS1_DEL");

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

        #region Description : 위치코드 대분류 저장/삭제 체크
        public string UP_Location_CLASS1_Check(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if(ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_L1SAUP", DbType.String, ht["L1SAUP"]);
                    dbCon.AddParameters("P_L1CODE", DbType.String, ht["L1CODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1023_LOCATION_CLASS1_RUN");

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
                    dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, 1);
                    dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 15);
                    dbCon.AddParameters("P_L2SAUP", DbType.String, ht["L1SAUP"]);
                    dbCon.AddParameters("P_L2BCODE", DbType.String, ht["L1CODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1022_LOCATION_CLASS2_LIST");

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