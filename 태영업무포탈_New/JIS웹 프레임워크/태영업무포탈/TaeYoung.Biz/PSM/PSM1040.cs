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
    public class PSM1040 : BizBase
    {
        #region Description : TANK 저장물질 요소 조회
        public DataSet UP_GET_TKCHANGE_FACTOR_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1040_TKCHANGE_FACTOR_LIST");
            }
        }
        #endregion

        #region Description : TANK 저장물질 요소 확인
        public DataSet UP_TKCHANGE_FACTOR_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_TCNUM", DbType.String, ht["TCNUM"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1040_TKCHANGE_FACTOR_RUN");
            }
        }
        #endregion

        #region Description : TANK 저장물질 요소 등록
        public DataSet UP_TKCHANGE_FACTOR_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_TKCHANGE_FACTOR_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_TCNUM", DbType.String, ht["TCNUM"]);
                    dbCon.AddParameters("P_TCCHFANAME", DbType.String, ht["TCCHFANAME"]);
                    dbCon.AddParameters("P_TCATTACH", DbType.String, ht["TCATTACH"]);
                    dbCon.AddParameters("P_TCTHISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1040_TKCHANGE_FACTOR_ADD");

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

        #region Description : TANK 저장물질 요소 삭제
        public void UP_TKCHANGE_FACTOR_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_TCNUM", DbType.String, ht["TCNUM"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1040_TKCHANGE_FACTOR_DEL");
            }
        }
        #endregion

        #region Description : TANK 저장물질 요소 저장 체크
        public string UP_TKCHANGE_FACTOR_Check(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if (ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_TCNUM", DbType.String, ht["TCNUM"]);
                    
                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1040_TKCHANGE_FACTOR_RUN");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sMSG = "동일한 번호가 등록되어 있습니다.";

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion

        public DataSet UP_TKCHANGE_FACTOR_SAVECHECK(Hashtable ht)
        {
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //등록여부 체크 
                dbCon.AddParameters("P_TCNUM", DbType.String, ht["TCNUM"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1040_TKCHANGE_FACTOR_RUN");
            }

            return ds;
        }
    }
}