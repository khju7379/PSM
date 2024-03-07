using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;
using System.IO;

namespace TaeYoung.Biz.PSM
{
    public class PSM1111 : BizBase
    {

        public DataSet UP_BOARD_CLASS1_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_BOARD_CLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PBC1LCODE", DbType.String, ht["P_PBC1LCODE"]);
                    dbCon.AddParameters("P_PBC1NTCODE", DbType.String, ht["P_PBC1NTCODE"]);
                    dbCon.AddParameters("P_PBC1NAME", DbType.String, ht["P_PBC1NAME"]);
                    dbCon.AddParameters("P_PBC1BIGO", DbType.String, Convert.ToString(ht["P_PBC1BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                    dbCon.AddParameters("P_PBC1HISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1110_BOARD_CLASS1_ADD");

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

        public DataSet UP_BOARD_CLASS1_SAVECHECK(Hashtable ht)
        {
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //등록여부 체크 
                dbCon.AddParameters("P_PBC1NTCODE", DbType.String, ht["P_PBC1NTCODE"]);
                dbCon.AddParameters("P_PBC1LCODE", DbType.String, ht["P_PBC1LCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1111_LCODE_LIST");
            }

            return ds;
        }

        #region Description : 대분류 저장/삭제 체크
        public string UP_BOARD_CLASS1_Check(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if (ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_PBC1NTCODE", DbType.String, ht["P_PBC1NTCODE"]);
                    dbCon.AddParameters("P_PBC1LCODE", DbType.String, ht["P_PBC1LCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1111_LCODE_LIST");

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
                    dbCon.AddParameters("P_PBC2NTCODE", DbType.String, ht["P_PBC1NTCODE"]);
                    dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC1LCODE"]);
                    dbCon.AddParameters("P_PBC2MCODE", DbType.String, "");

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1112_MCODE_LIST");

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

        public DataSet UP_BOARD_CLASS1_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_BOARD_CLASS1_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {

                    dbCon.AddParameters("P_PBC1NTCODE", DbType.String, ht["P_PBC1NTCODE"]);
                    dbCon.AddParameters("P_PBC1LCODE", DbType.String, ht["P_PBC1LCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1110_BOARD_CLASS1_DEL");

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

        #region Description : 대분류코드 조회
        public DataSet UP_GET_LCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBC1NTCODE", DbType.String, ht["P_PBC1NTCODE"]);
                dbCon.AddParameters("P_PBC1LCODE", DbType.String, ht["P_PBC1LCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1111_LCODE_LIST");

            }
        }
        #endregion


        #region Description : 게시판코드 조회
        public DataSet UP_GET_NTCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["P_GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1111_NTCODE_LIST");

            }
        }
        #endregion
    }
}
