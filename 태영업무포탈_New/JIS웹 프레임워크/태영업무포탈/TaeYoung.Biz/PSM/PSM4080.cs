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
    public class PSM4080 : BizBase
    {
        #region Description : 가동전 점검표 리스트 조회
        public DataSet UP_GET_XEAM_CHECK_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                //dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);
                dbCon.AddParameters("P_STDATE", DbType.String, ht["P_STDATE"]);
                dbCon.AddParameters("P_EDDATE", DbType.String, ht["P_EDDATE"]);
                dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                dbCon.AddParameters("P_PECTITLE", DbType.VarNumeric, ht["P_PECTITLE"]);
                dbCon.AddParameters("P_PECSGUBUN", DbType.String, ht["P_PECSGUBUN"]);
                dbCon.AddParameters("P_WKSAUP", DbType.String, ht["P_WKSAUP"]);
                dbCon.AddParameters("P_DEPT", DbType.String, ht["P_DEPT"]);
                dbCon.AddParameters("P_STATUS", DbType.String, ht["P_STATUS"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4080_EXAM_CHECK_LIST");
            }
        }
        #endregion

        #region Description : 가동전 안전점검 보고서 확인
        public DataSet UP_EXAM_REPORT_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_PERTCTEAM", DbType.String, ht["P_PERTCTEAM"]);
                dbCon.AddParameters("P_PERTCDATE", DbType.String, ht["P_PERTCDATE"]);
                dbCon.AddParameters("P_PERTCSEQ", DbType.VarNumeric, ht["P_PERTCSEQ"]);
                dbCon.AddParameters("P_PERDATE", DbType.String, ht["P_PERDATE"]);
                dbCon.AddParameters("P_PERSEQ", DbType.VarNumeric, ht["P_PERSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4081_EXAM_REPORT_RUN");
            }
        }
        #endregion

        #region Description : 가동전 안전점검 보고서 등록
        public DataSet UP_EXAM_REPORT_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            try { 
                if (ht["P_PERSEQ"].ToString() == "")
                {
                    // 순번 가져오기
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        dbCon.AddParameters("P_PERTCTEAM", DbType.String, ht["P_PERTCTEAM"]);
                        dbCon.AddParameters("P_PERTCDATE", DbType.String, ht["P_PERTCDATE"]);
                        dbCon.AddParameters("P_PERTCSEQ", DbType.VarNumeric, ht["P_PERTCSEQ"]);
                        dbCon.AddParameters("P_PERDATE", DbType.String, ht["P_PERDATE"]);

                        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4081_EXAM_REPORT_SEQ");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            ht["P_PERSEQ"] = ds.Tables[0].Rows[0]["PERSEQ"].ToString();
                        }
                    }
                }

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    dbCon.AddParameters("P_PERTCTEAM", DbType.String, ht["P_PERTCTEAM"]);
                    dbCon.AddParameters("P_PERTCDATE", DbType.String, ht["P_PERTCDATE"]);
                    dbCon.AddParameters("P_PERTCSEQ", DbType.VarNumeric, ht["P_PERTCSEQ"]);
                    dbCon.AddParameters("P_PERDATE", DbType.String, ht["P_PERDATE"]);
                    dbCon.AddParameters("P_PERSEQ", DbType.VarNumeric, ht["P_PERSEQ"]);
                    dbCon.AddParameters("P_PERNUM", DbType.VarNumeric, ht["P_PERNUM"]);
                    dbCon.AddParameters("P_PERSUBJECTS", DbType.String, ht["P_PERSUBJECTS"]);
                    dbCon.AddParameters("P_PERRESULTS", DbType.String, ht["P_PERRESULTS"]);
                    dbCon.AddParameters("P_PERSABUN", DbType.String, ht["P_PERSABUN"]);
                    dbCon.AddParameters("P_PERCONTENTS", DbType.String, ht["P_PERCONTENTS"]);
                    dbCon.AddParameters("P_PERBIGO", DbType.String, ht["P_PERBIGO"]);
                    dbCon.AddParameters("P_PERHISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["P_GUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4081_EXAM_REPORT_ADD");

                    ds = new DataSet();

                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"] = ht["P_PERSEQ"];
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);
                }
            }
            catch
            {
                row = dt.NewRow();
                row["STATE"] = "ERR";
                row["MSG"] = "ERR";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : 가동전 안전점검 보고서 삭제
        public void UP_EXAM_REPORT_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_PERTCTEAM", DbType.String, ht["P_PERTCTEAM"]);
                dbCon.AddParameters("P_PERTCDATE", DbType.String, ht["P_PERTCDATE"]);
                dbCon.AddParameters("P_PERTCSEQ", DbType.VarNumeric, ht["P_PERTCSEQ"]);
                dbCon.AddParameters("P_PERDATE", DbType.String, ht["P_PERDATE"]);
                dbCon.AddParameters("P_PERSEQ", DbType.VarNumeric, ht["P_PERSEQ"]);
                dbCon.AddParameters("P_PERNUM", DbType.VarNumeric, ht["P_PERNUM"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4081_EXAM_REPORT_DEL");
            }
        }
        #endregion
    }
}
