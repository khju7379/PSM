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
    public class PSM1112 : BizBase
    {

        #region Description : 중분류 저장
        public DataSet UP_BOARD_CLASS2_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_BOARD_CLASS2_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PBC2NTCODE", DbType.String, ht["P_PBC2NTCODE"]);
                    dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);
                    dbCon.AddParameters("P_PBC2MCODE", DbType.String, ht["P_PBC2MCODE"]);
                    dbCon.AddParameters("P_PBC2NAME", DbType.String, ht["P_PBC2NAME"]);
                    dbCon.AddParameters("P_PBC2BIGO", DbType.String, Convert.ToString(ht["P_PBC2BIGO"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                    dbCon.AddParameters("P_PBC2HISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1110_BOARD_CLASS2_ADD");

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

        #region Description : 중분류 삭제
        public DataSet UP_BOARD_CLASS2_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_BOARD_CLASS2_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PBC2NTCODE", DbType.String, ht["P_PBC2NTCODE"]);
                    dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);
                    dbCon.AddParameters("P_PBC2MCODE", DbType.String, ht["P_PBC2MCODE"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1110_BOARD_CLASS2_DEL");

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

        public DataSet UP_BOARD_CLASS2_SAVECHECK(Hashtable ht)
        {
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //등록여부 체크 
                dbCon.AddParameters("P_PBC2NTCODE", DbType.String, ht["P_PBC2NTCODE"]);
                dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);
                dbCon.AddParameters("P_PBC2MCODE", DbType.String, ht["P_PBC2MCODE"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1112_MCODE_LIST");
            }

            return ds;
        }

        #region Description : 중분류 삭제 체크
        public string UP_BOARD_CLASS2_Check(Hashtable ht)
        {
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            if (ht["WKGUBUN"].ToString() == "A")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //등록여부 체크 
                    dbCon.AddParameters("P_PBC2NTCODE", DbType.String, ht["P_PBC2NTCODE"]);
                    dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);
                    dbCon.AddParameters("P_PBC2MCODE", DbType.String, ht["P_PBC2MCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1112_MCODE_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sMSG = "동일한 코드가 등록되어 있습니다.";

                        return sMSG;
                    }
                }
            }
            else if (ht["WKGUBUN"].ToString() == "D") { 

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    // 소분류코드 체크
                    dbCon.AddParameters("P_PBC3NTCODE", DbType.String, ht["P_PBC2NTCODE"]);
                    dbCon.AddParameters("P_PBC3LCODE", DbType.String, ht["P_PBC2LCODE"]);
                    dbCon.AddParameters("P_PBC3MCODE", DbType.String, ht["P_PBC2MCODE"]);
                    dbCon.AddParameters("P_PBC3SCODE", DbType.String, "");

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1113_SCODE_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sMSG = "소분류코드가 존재합니다. 삭제 할 수 없습니다.";

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : 중분류코드 조회
        public DataSet UP_GET_MCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_PBC2NTCODE", DbType.String, ht["P_PBC2NTCODE"]);
                dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);
                dbCon.AddParameters("P_PBC2MCODE", DbType.String, ht["P_PBC2MCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1112_MCODE_LIST");

            }
        }
        #endregion

        #region Description : 대분류코드 조회(콤보박스)
        public DataSet UP_GET_LCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBC1NTCODE", DbType.String, ht["P_PBC1NTCODE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["P_GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1112_LCODE_LIST");

            }
        }
        #endregion

        #region Description : 000 채우기
        private string Set_Fill3(string sFirst)
        {
            if (sFirst.ToString().Length == 1)
            {
                sFirst = "00" + sFirst.ToString();
            }
            else if (sFirst.ToString().Length == 2)
            {
                sFirst = "0" + sFirst.ToString();
            }
            else if (sFirst.ToString().Length == 3)
            {
                sFirst = sFirst.ToString();
            }
            else
            {
                sFirst = "000";
            }

            return sFirst;
        }
        #endregion

        #region Description : 0000 채우기
        private string Set_Fill4(string sFirst)
        {
            if (sFirst.ToString().Length == 1)
            {
                sFirst = "000" + sFirst.ToString();
            }
            else if (sFirst.ToString().Length == 2)
            {
                sFirst = "00" + sFirst.ToString();
            }
            else if (sFirst.ToString().Length == 3)
            {
                sFirst = "01" + sFirst.ToString();
            }
            else if (sFirst.ToString().Length == 4)
            {
                sFirst = sFirst.ToString();
            }
            else
            {
                sFirst = "0000";
            }

            return sFirst;
        }
        #endregion
    }
}

