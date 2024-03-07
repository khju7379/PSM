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
    public class PSM1050 : BizBase
    {
        #region Description : 위험성평가표 메뉴 조회
        public DataSet UP_GET_RISKCODE_VER_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1050_RISKCODE_VER_LIST");
            }
        }
        #endregion

        #region Description : 위험성평가표 마스타 조회
        public DataSet UP_GET_RISKCODE_MASTER_LIST(Hashtable ht)
        {
            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_RMYEAR", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_RMSEQ", DbType.String, sDatas[1]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1050_RISKCODE_MASTER_LIST");
            }
        }
        #endregion

        #region Description : 위험성평가표 항목 조회
        public DataSet UP_GET_RISKCODE_DETAIL_LIST(Hashtable ht)
        {
            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_RLYEAR", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_RLSEQ", DbType.String, sDatas[1]);
                if(sDatas.Length > 2)
                { 
                    dbCon.AddParameters("P_RLCODE", DbType.String, sDatas[2]);
                }
                else
                {
                    dbCon.AddParameters("P_RLCODE", DbType.String, "");
                }

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1050_RISKCODE_DETAIL_LIST");
            }
        }
        #endregion

        #region Description : 위험성평가표 삭제
        public DataSet UP_RISKCODE_DEL(Hashtable ht)
        {   
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');
            string sMSG = UP_RISKCODE_Check(ht);


            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RSYEAR", DbType.String, sDatas[0]);
                    dbCon.AddParameters("P_RSSEQ", DbType.String, sDatas[1]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1050_RISKCODE_DEL");

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

        #region Description : 위험성평가표 삭제 체크
        public string UP_RISKCODE_Check(Hashtable ht)
        {
            string sMSG = string.Empty;
            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            DataSet ds = new DataSet();
            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_RMRSSTYEAR ", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_RMRSSTSEQ", DbType.String, sDatas[1]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1050_RISK_MASTER_CHECK");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sMSG = "삭제할 수 없는 자료입니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion

        public DataSet UP_RISKCODE_DELCHECK(Hashtable ht)
        {
            DataSet ds = new DataSet();
            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_RMRSSTYEAR ", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_RMRSSTSEQ", DbType.String, sDatas[1]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1050_RISK_MASTER_CHECK");
            }

            return ds;
        }

        #region Description : 위험성평가표 메뉴 등록
        public void UP_RISKCODE_VER_ADD(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_RSYEAR", DbType.String, ht["RSYEAR"]);
                dbCon.AddParameters("P_RSUSDPMK", DbType.String, ht["RSUSDPMK"]);
                dbCon.AddParameters("P_RSUSSDATE", DbType.String, ht["RSUSSDATE"]);
                dbCon.AddParameters("P_RSUSEDATE", DbType.String, ht["RSUSEDATE"]);
                dbCon.AddParameters("P_RSHISAB", DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1051_RISKCODE_VER_ADD");
            }
        }
        #endregion

        #region Description : 위험성평가표 복사
        public void UP_RISKCODE_COPY(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PREYEAR", DbType.String, ht["PREYEAR"]);
                dbCon.AddParameters("P_PRESEQ", DbType.String, ht["PRESEQ"]);
                dbCon.AddParameters("P_RSYEAR", DbType.String, ht["RSYEAR"]);
                dbCon.AddParameters("P_RSUSDPMK", DbType.String, ht["RSUSDPMK"]);
                dbCon.AddParameters("P_RSUSSDATE", DbType.String, ht["RSUSSDATE"]);
                dbCon.AddParameters("P_RSUSEDATE", DbType.String, ht["RSUSEDATE"]);
                dbCon.AddParameters("P_RSHISAB", DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1051_RISKCODE_COPY");
            }
        }
        #endregion

        #region Description : 위험성평가표 마스타 확인
        public DataSet UP_RISKCODE_MASTER_RUN(Hashtable ht)
        {   
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_RMYEAR", DbType.String, ht["RMYEAR"]);
                dbCon.AddParameters("P_RMSEQ", DbType.String, ht["RMSEQ"]);
                dbCon.AddParameters("P_RMCODE", DbType.String, ht["RMCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1052_RISKCODE_MASTER_RUN");
            }
        }
        #endregion

        #region Description : 위험성평가표 마스타 등록
        public DataSet UP_RISKCODE_MASTER_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_RISKCODE_MASTER_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RMYEAR", DbType.String, ht["RMYEAR"]);
                    dbCon.AddParameters("P_RMSEQ", DbType.String, ht["RMSEQ"]);
                    dbCon.AddParameters("P_RMCODE", DbType.String, ht["RMCODE"]);
                    dbCon.AddParameters("P_RMNAME", DbType.String, ht["RMNAME"]);
                    dbCon.AddParameters("P_RMHISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1052_RISKCODE_MASTER_ADD");

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

        #region Description : 위험성평가표 마스타 삭제
        public DataSet UP_RISKCODE_MASTER_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_RISKCODE_MASTER_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RMYEAR", DbType.String, ht["RMYEAR"]);
                    dbCon.AddParameters("P_RMSEQ", DbType.String, ht["RMSEQ"]);
                    dbCon.AddParameters("P_RMCODE", DbType.String, ht["RMCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1052_RISKCODE_MASTER_DEL");

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

        #region Description : 위험성평가표 마스타 저장/삭제 체크
        public string UP_RISKCODE_MASTER_Check(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if (ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_RMYEAR", DbType.String, ht["RMYEAR"]);
                    dbCon.AddParameters("P_RMSEQ", DbType.String, ht["RMSEQ"]);
                    dbCon.AddParameters("P_RMCODE", DbType.String, ht["RMCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1052_RISKCODE_MASTER_RUN");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sMSG = "동일한 코드가 등록되어 있습니다.";

                        return sMSG;
                    }
                }
            }
            else
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RMRSSTYEAR ", DbType.String, ht["RMYEAR"]);
                    dbCon.AddParameters("P_RMRSSTSEQ", DbType.String, ht["RMSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1050_RISK_MASTER_CHECK");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ht["WKGUBUN"].ToString() == "C")
                        {
                            sMSG = "수정할 수 없는 자료입니다.";
                        }
                        else if (ht["WKGUBUN"].ToString() == "D")
                        {
                            sMSG = "삭제할 수 없는 자료입니다.";
                        }   

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : 위험성평가표 마스타 저장/삭제 체크
        public DataSet UP_RISKCODE_MASTER_SAVECHECK(Hashtable ht)
        {
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //등록여부 체크 
                dbCon.AddParameters("P_RMYEAR", DbType.String, ht["RMYEAR"]);
                dbCon.AddParameters("P_RMSEQ", DbType.String, ht["RMSEQ"]);
                dbCon.AddParameters("P_RMCODE", DbType.String, ht["RMCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1052_RISKCODE_MASTER_RUN");
            }

            return ds;
        }
        #endregion

        #region Description : 위험성평가표 항목 확인
        public DataSet UP_RISKCODE_LIST_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_RLYEAR", DbType.String, ht["RLYEAR"]);
                dbCon.AddParameters("P_RLSEQ", DbType.String, ht["RLSEQ"]);
                dbCon.AddParameters("P_RLCODE", DbType.String, ht["RLCODE"]);
                dbCon.AddParameters("P_RLITEMCODE", DbType.String, ht["RLITEMCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_RUN");
            }
        }
        #endregion

        #region Description : 위험성평가표 항목 등록
        public DataSet UP_RISKCODE_LIST_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_RISKCODE_LIST_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RLYEAR", DbType.String, ht["RLYEAR"]);
                    dbCon.AddParameters("P_RLSEQ", DbType.String, ht["RLSEQ"]);
                    dbCon.AddParameters("P_RLCODE", DbType.String, ht["RLCODE"]);
                    dbCon.AddParameters("P_RLITEMCODE", DbType.String, ht["RLITEMCODE"]);
                    dbCon.AddParameters("P_RLNAME", DbType.String, ht["RLNAME"]);
                    dbCon.AddParameters("P_RLITEMNAME", DbType.String, ht["RLITEMNAME"]);
                    dbCon.AddParameters("P_RLRSINDEX0", DbType.String, ht["RLRSINDEX0"]);
                    dbCon.AddParameters("P_RLRSINDEX1", DbType.String, ht["RLRSINDEX1"]);
                    dbCon.AddParameters("P_RLRSINDEX2", DbType.String, ht["RLRSINDEX2"]);
                    dbCon.AddParameters("P_RLRSINDEX3", DbType.String, ht["RLRSINDEX3"]);
                    dbCon.AddParameters("P_RLHISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_ADD");

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

        #region Description : 위험성평가표 항목 삭제
        public DataSet UP_RISKCODE_LIST_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_RISKCODE_LIST_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RLYEAR", DbType.String, ht["RLYEAR"]);
                    dbCon.AddParameters("P_RLSEQ", DbType.String, ht["RLSEQ"]);
                    dbCon.AddParameters("P_RLCODE", DbType.String, ht["RLCODE"]);
                    dbCon.AddParameters("P_RLITEMCODE", DbType.String, ht["RLITEMCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_DEL");

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

        public DataSet UP_RISKCODE_LIST_SAVECHECK(Hashtable ht)
        {
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //등록여부 체크 
                dbCon.AddParameters("P_RLYEAR", DbType.String, ht["RLYEAR"]);
                dbCon.AddParameters("P_RLSEQ", DbType.String, ht["RLSEQ"]);
                dbCon.AddParameters("P_RLCODE", DbType.String, ht["RLCODE"]);
                dbCon.AddParameters("P_RLITEMCODE", DbType.String, ht["RLITEMCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_RUN");
            }

            return ds;
        }

        #region Description : 위험성평가표 항목 저장/삭제 체크
        public string UP_RISKCODE_LIST_Check(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if (ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_RLYEAR", DbType.String, ht["RLYEAR"]);
                    dbCon.AddParameters("P_RLSEQ", DbType.String, ht["RLSEQ"]);
                    dbCon.AddParameters("P_RLCODE", DbType.String, ht["RLCODE"]);
                    dbCon.AddParameters("P_RLITEMCODE", DbType.String, ht["RLITEMCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1053_RISKCODE_LIST_RUN");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sMSG = "동일한 코드가 등록되어 있습니다.";

                        return sMSG;
                    }
                }
            }
            else
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RMRSSTYEAR ", DbType.String, ht["RLYEAR"]);
                    dbCon.AddParameters("P_RMRSSTSEQ", DbType.String, ht["RLSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1050_RISK_MASTER_CHECK");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ht["WKGUBUN"].ToString() == "C")
                        {
                            sMSG = "수정할 수 없는 자료입니다.";
                        }
                        else if (ht["WKGUBUN"].ToString() == "D")
                        {
                            sMSG = "삭제할 수 없는 자료입니다.";
                        }

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion
    }
}