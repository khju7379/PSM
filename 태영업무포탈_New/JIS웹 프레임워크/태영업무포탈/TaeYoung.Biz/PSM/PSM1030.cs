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
    public class PSM1030 : BizBase
    {
        #region Description : 대분류코드 조회(콤보박스)
        public DataSet UP_GET_BCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SAUP", DbType.String, ht["SAUP"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1030_BCODE_LIST");
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
                dbCon.AddParameters("P_BCODE", DbType.String, ht["BCODE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1030_MCODE_LIST");
            }
        }
        #endregion

        #region Description : 소분류코드 조회(콤보박스)
        public DataSet UP_GET_SCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SAUP", DbType.String, ht["SAUP"]);
                dbCon.AddParameters("P_BCODE", DbType.String, ht["BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["MCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1030_SCODE_LIST");
            }
        }
        #endregion

        #region Description : 설비코드 소분류 조회
        public DataSet UP_GET_ACFIXCLASS3_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SAUP", DbType.String, ht["SAUP"]);
                dbCon.AddParameters("P_BCODE", DbType.String, ht["BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["MCODE"]);
                dbCon.AddParameters("P_SCODE", DbType.String, ht["SCODE"]);
                dbCon.AddParameters("P_SNAME", DbType.String, ht["SNAME"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1030_ACFIXCLASS3_LIST");
            }
        }
        #endregion

        #region Description : 설비코드 소분류 확인
        public DataSet UP_ACFIXCLASS3_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3SAUP"]);
                dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3BCODE"]);
                dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3MCODE"]);
                dbCon.AddParameters("P_C3SCODE", DbType.String, ht["C3SCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1031_ACFIXCLASS3_RUN");
            }
        }
        #endregion

        #region Description : 설비코드 소분류 등록
        public DataSet UP_ACFIXCLASS3_ADD(Hashtable ht)
        {
            string sC3SCODE = string.Empty;
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_ACFIXCLASS3_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                // 순번가져오기
                if (ht["C3SCODE"].ToString() == "0")
                {
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3SAUP"]);
                        dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3BCODE"]);
                        dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3MCODE"]);

                        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1031_ACFIXCLASS3_SEQ");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            sC3SCODE = ds.Tables[0].Rows[0]["C3SCODE"].ToString();
                        }
                    }
                }
                else
                {
                    sC3SCODE = ht["C3SCODE"].ToString();
                }

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3SAUP"]);
                    dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3BCODE"]);
                    dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3MCODE"]);
                    dbCon.AddParameters("P_C3SCODE", DbType.String, sC3SCODE);
                    dbCon.AddParameters("P_C3NAME", DbType.String, ht["C3NAME"]);
                    dbCon.AddParameters("P_C3LINKCODE1", DbType.String, ht["C3LINKCODE1"]);
                    dbCon.AddParameters("P_C3LINKCODE2", DbType.String, ht["C3LINKCODE2"]);
                    dbCon.AddParameters("P_C3BIGO", DbType.String, Convert.ToString(ht["C3BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                    dbCon.AddParameters("P_C3HISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1031_ACFIXCLASS3_ADD");

                    ds = new DataSet();

                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"] = sC3SCODE;
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

        #region Description : 설비코드 소분류 삭제
        public DataSet UP_ACFIXCLASS3_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_ACFIXCLASS3_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3SAUP"]);
                    dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3BCODE"]);
                    dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3MCODE"]);
                    dbCon.AddParameters("P_C3SCODE", DbType.String, ht["C3SCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1031_ACFIXCLASS3_DEL");

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

        #region Description : 설비코드 소분류 등록/삭제 체크
        public string UP_ACFIXCLASS3_Check(Hashtable ht)
        {
            string sMSG = string.Empty;
            DataSet ds = new DataSet();
            // 저장 체크
            if (ht["WKGUBUN"].ToString() == "A" || ht["WKGUBUN"].ToString() == "C")
            {
                // 연관설비1 유효성체크
                if (ht["C3LINKCODE1"].ToString() != "" && ht["C3LINKCODE1"].ToString().Length == 10)
                { 
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {                        
                        dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3LINKCODE1"].ToString().Substring(0, 1));
                        dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3LINKCODE1"].ToString().Substring(1, 2));
                        dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3LINKCODE1"].ToString().Substring(3, 4));
                        dbCon.AddParameters("P_C3SCODE", DbType.String, ht["C3LINKCODE1"].ToString().Substring(7, 3));

                        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1031_ACFIXCLASS3_RUN");

                        if (ds.Tables[0].Rows.Count == 0)
                        {   
                            sMSG = "연관설비코드1을 확인하세요.";

                            return sMSG;
                        }
                    }
                }
                // 연관설비2 유효성체크
                if (ht["C3LINKCODE2"].ToString() != "" && ht["C3LINKCODE2"].ToString().Length == 10)
                {
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {   
                        dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3LINKCODE2"].ToString().Substring(0, 1));
                        dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3LINKCODE2"].ToString().Substring(1, 2));
                        dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3LINKCODE2"].ToString().Substring(3, 4));
                        dbCon.AddParameters("P_C3SCODE", DbType.String, ht["C3LINKCODE2"].ToString().Substring(7, 3));

                        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1031_ACFIXCLASS3_RUN");

                        if (ds.Tables[0].Rows.Count == 0)
                        {   
                            sMSG = "연관설비코드2를 확인하세요.";

                            return sMSG;
                        }
                    }
                }
            }
            else if (ht["WKGUBUN"].ToString() == "D")   // 삭제 체크
            {
                // 작업요청, 안전작업허가서에 사용되면 삭제 불가
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //작업요청서 체크 
                    dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3SAUP"]);
                    dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3BCODE"]);
                    dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3MCODE"]);
                    dbCon.AddParameters("P_C3SCODE", DbType.String, ht["C3SCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1031_WORKORDER_CHECK");

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
                    dbCon.AddParameters("P_C3SAUP", DbType.String, ht["C3SAUP"]);
                    dbCon.AddParameters("P_C3BCODE", DbType.String, ht["C3BCODE"]);
                    dbCon.AddParameters("P_C3MCODE", DbType.String, ht["C3MCODE"]);
                    dbCon.AddParameters("P_C3SCODE", DbType.String, ht["C3SCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1031_SAFEORDER_CHECK");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                        {
                            sMSG = "안전작업허가에 사용된 코드입니다. 삭제 할 수 없습니다.";

                            return sMSG;
                        }
                    }
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : 설비코드 중분류 조회
        public DataSet UP_GET_ACFIXCLASS2_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_C2SAUP", DbType.String, ht["C2SAUP"]);
                dbCon.AddParameters("P_C2BCODE", DbType.String, ht["C2BCODE"]);
                dbCon.AddParameters("P_C2NAME", DbType.String, ht["C2NAME"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1032_ACFIXCLASS2_LIST");
            }
        }
        #endregion

        #region Description : 설비코드 중분류 확인
        public DataSet UP_ACFIXCLASS2_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_C2SAUP", DbType.String, ht["C2SAUP"]);
                dbCon.AddParameters("P_C2BCODE", DbType.String, ht["C2BCODE"]);
                dbCon.AddParameters("P_C2MCODE", DbType.String, ht["C2MCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1032_ACFIXCLASS2_RUN");
            }
        }
        #endregion

        #region Description : 설비코드 중분류 등록
        public DataSet UP_ACFIXCLASS2_ADD(Hashtable ht)
        {
            string sC2MCODE = string.Empty;
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();

            if (ht["C2MCODE"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_C2SAUP", DbType.String, ht["C2SAUP"]);
                    dbCon.AddParameters("P_C2BCODE", DbType.String, ht["C2BCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1032_ACFIXCLASS2_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sC2MCODE = ds.Tables[0].Rows[0]["C2MCODE"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sC2MCODE = ht["C2MCODE"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_C2SAUP", DbType.String, ht["C2SAUP"]);
                dbCon.AddParameters("P_C2BCODE", DbType.String, ht["C2BCODE"]);
                dbCon.AddParameters("P_C2MCODE", DbType.String, sC2MCODE);
                dbCon.AddParameters("P_C2NAME", DbType.String, ht["C2NAME"]);
                dbCon.AddParameters("P_C2BIGO", DbType.String, Convert.ToString(ht["C2BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_C2HISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1032_ACFIXCLASS2_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_C2SAUP", DbType.String, ht["C2SAUP"]);
                dbCon.AddParameters("P_C2BCODE", DbType.String, ht["C2BCODE"]);
                dbCon.AddParameters("P_C2MCODE", DbType.String, sC2MCODE);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1032_ACFIXCLASS2_RUN");
            }

        }
        #endregion

        #region Description : 설비코드 중분류 삭제
        public DataSet UP_ACFIXCLASS2_DEL(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_ACFIXCLASS2_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_C2SAUP", DbType.String, ht["C2SAUP"]);
                    dbCon.AddParameters("P_C2BCODE", DbType.String, ht["C2BCODE"]);
                    dbCon.AddParameters("P_C2MCODE", DbType.String, ht["C2MCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1032_ACFIXCLASS2_DEL");

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

        #region Description : 설비코드 중분류 삭제 체크
        public string UP_ACFIXCLASS2_Check(Hashtable ht)
        {
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //작업요청서 체크 
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 15);
                dbCon.AddParameters("P_SAUP", DbType.String, ht["C2SAUP"]);
                dbCon.AddParameters("P_BCODE", DbType.String, ht["C2BCODE"]);
                dbCon.AddParameters("P_MCODE", DbType.String, ht["C2MCODE"]);
                dbCon.AddParameters("P_SCODE", DbType.String, "");
                dbCon.AddParameters("P_SNAME", DbType.String, "");

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1030_ACFIXCLASS3_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sMSG = "소분류코드가 존재합니다. 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : 설비코드 대분류 조회
        public DataSet UP_GET_ACFIXCLASS1_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1033_ACFIXCLASS1_LIST");
            }
        }
        #endregion

        #region Description : 설비코드 대분류 확인
        public DataSet UP_ACFIXCLASS1_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_C1SAUP", DbType.String, ht["C1SAUP"]);
                dbCon.AddParameters("P_C1CODE", DbType.String, ht["C1CODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1033_ACFIXCLASS1_RUN");
            }
        }
        #endregion

        #region Description : 설비코드 대분류 등록
        public DataSet UP_ACFIXCLASS1_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_ACFIXCLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_C1SAUP", DbType.String, ht["C1SAUP"]);
                    dbCon.AddParameters("P_C1CODE", DbType.String, ht["C1CODE"]);
                    dbCon.AddParameters("P_C1NAME", DbType.String, ht["C1NAME"]);
                    dbCon.AddParameters("P_C1BIGO", DbType.String, Convert.ToString(ht["C1BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                    dbCon.AddParameters("P_C1HISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1033_ACFIXCLASS1_ADD");

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

        #region Description : 설비코드 대분류 삭제
        public DataSet UP_ACFIXCLASS1_DEL(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_ACFIXCLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_C1SAUP", DbType.String, ht["C1SAUP"]);
                    dbCon.AddParameters("P_C1CODE", DbType.String, ht["C1CODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1033_ACFIXCLASS1_DEL");

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

        #region Description : 설비코드 대분류 저장/삭제 체크
        public string UP_ACFIXCLASS1_Check(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if (ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_C1SAUP", DbType.String, ht["C1SAUP"]);
                    dbCon.AddParameters("P_C1CODE", DbType.String, ht["C1CODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1033_ACFIXCLASS1_RUN");

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
                    dbCon.AddParameters("P_C2SAUP", DbType.String, ht["C1SAUP"]);
                    dbCon.AddParameters("P_C2BCODE", DbType.String, ht["C1CODE"]);
                    dbCon.AddParameters("P_C2NAME", DbType.String, "");

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1032_ACFIXCLASS2_LIST");

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