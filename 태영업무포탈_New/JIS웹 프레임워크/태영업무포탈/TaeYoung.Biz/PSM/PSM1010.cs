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
    public class PSM1010 : BizBase
    {

        public DataSet UP_CODEINDEX_LIST(Hashtable ht)
        {
            
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND CDINDEX  = '" + ht["SearchCondition"] + "'";
            }           

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1010_CODEINDEX_LIST");
            }
        }

        public DataSet UP_CODE_ADD(Hashtable ht, Hashtable[] hts)
        {
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_CODE_Check(hts);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    for (int i = 0; i < hts.Length; i++)
                    {
                        dbCon.AddParameters("P_CDINDEX", DbType.String, hts[i]["CDINDEX"]);
                        dbCon.AddParameters("P_CDCODE", DbType.String, hts[i]["CDCODE"]);
                        dbCon.AddParameters("P_CDDESC1", DbType.String, hts[i]["CDDESC1"]);
                        dbCon.AddParameters("P_CDDESC2", DbType.String, hts[i]["CDDESC2"]);
                        dbCon.AddParameters("P_CDBIGO", DbType.String, hts[i]["CDBIGO"]);
                        dbCon.AddParameters("P_CDHISAB", DbType.String, Document.UserInfo.EmpID);


                        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1010_CODEMF_ADD");
                    }
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

        public string UP_CODE_Check(Hashtable[] hts)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            for (int i = 0; i < hts.Length; i++)
            {
                if (hts[i]["CDSTATE"].ToString() == "A")
                {
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        //등록여부 체크 
                        dbCon.AddParameters("IN_CDINDEX", DbType.String, hts[i]["CDINDEX"]);
                        dbCon.AddParameters("IN_CDCODE", DbType.String, hts[i]["CDCODE"]);

                        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1010_CODEMF_RUN");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            sMSG = "동일한 코드가 등록되어 있습니다.";

                            return sMSG;
                        }
                    }
                }
            }

            return sMSG;
        }

        public void UP_CODE_DEL(Hashtable ht, Hashtable[] hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_CDINDEX", DbType.String, hts[i]["CDINDEX"]);
                    dbCon.AddParameters("P_CDCODE", DbType.String, hts[i]["CDCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1010_CODEMF_DEL");
                }
            }
        }

        public DataSet UP_CODE_CHECK(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CDINDEX", DbType.String, ht["CDCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1010_CODEMF_CHECK");
            }
        }
    }
}
