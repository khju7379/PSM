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
    public class PSM4045 : BizBase
    {
        #region Description : JSA(변경관리) 마스타 확인
        public DataSet UP_JSACHANGE_MASTER_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                dbCon.AddParameters("P_JSMPODATE", DbType.String, ht["P_JSMPODATE"]);
                dbCon.AddParameters("P_JSMPOSEQ", DbType.VarNumeric, ht["P_JSMPOSEQ"]);
                dbCon.AddParameters("P_JSMDATE", DbType.String, ht["P_JSMDATE"]);
                dbCon.AddParameters("P_JSMMSEQ", DbType.VarNumeric, ht["P_JSMMSEQ"]);
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["P_JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["P_JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["P_JSMSLASS"]);
                dbCon.AddParameters("P_JSMSEQ", DbType.VarNumeric, ht["P_JSMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4045_JSACHANGE_MASTER_RUN");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 임시파일 조회
        public DataSet UP_JSACHANGE_PRT_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SESSION", DbType.String, ht["P_SESSIONID"]);
                dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                dbCon.AddParameters("P_JSMPODATE", DbType.String, ht["P_JSMPODATE"]);
                dbCon.AddParameters("P_JSMPOSEQ", DbType.VarNumeric, ht["P_JSMPOSEQ"]);
                dbCon.AddParameters("P_JSMDATE", DbType.String, ht["P_JSMDATE"]);
                dbCon.AddParameters("P_JSMMSEQ", DbType.VarNumeric, ht["P_JSMMSEQ"]);
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["P_JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["P_JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["P_JSMSLASS"]);
                dbCon.AddParameters("P_JSMSEQ", DbType.VarNumeric, ht["P_JSMSEQ"]);
                //dbCon.AddParameters("P_SABUN", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_SABUN", DbType.String, "000000");
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["P_GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4045_JSACHANGE_PRT_LIST");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 마스터 등록
        public DataSet UP_JSACHANGE_MASTER_ADD(Hashtable ht)
        {
            string sJSMSEQ = string.Empty;
            
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSACHANGE_MASTER_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));
            dt.Columns.Add("JSMWKGUBN", typeof(System.String));
            dt.Columns.Add("JSMPOTEAM", typeof(System.String));
            dt.Columns.Add("JSMPODATE", typeof(System.String));
            dt.Columns.Add("JSMPOSEQ", typeof(System.String));
            dt.Columns.Add("JSMDATE", typeof(System.String));
            dt.Columns.Add("JSMMSEQ", typeof(System.String));
            dt.Columns.Add("JSMBLASS", typeof(System.String));
            dt.Columns.Add("JSMMLASS", typeof(System.String));
            dt.Columns.Add("JSMSLASS", typeof(System.String));
            dt.Columns.Add("JSMSEQ", typeof(System.String));

            if (sMSG == "")
            {
                // 순번 가져오기
                if (ht["P_JSMSEQ"].ToString() == "0")
                {
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                        dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                        dbCon.AddParameters("P_JSMPODATE", DbType.String, ht["P_JSMPODATE"]);
                        dbCon.AddParameters("P_JSMPOSEQ", DbType.String, ht["P_JSMPOSEQ"]);
                        dbCon.AddParameters("P_JSMDATE", DbType.String, ht["P_JSMDATE"]);
                        dbCon.AddParameters("P_JSMMSEQ", DbType.String, ht["P_JSMMSEQ"]);
                        dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["P_JSMBLASS"]);
                        dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["P_JSMMLASS"]);
                        dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["P_JSMSLASS"]);

                        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4045_JSACHANGE_MASTER_SEQ");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            sJSMSEQ = ds.Tables[0].Rows[0]["JSMSEQ"].ToString();
                            ht["P_JSMSEQ"] = sJSMSEQ;
                        }
                    }
                }

                // JSA 마스타 등록
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                    dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                    dbCon.AddParameters("P_JSMPODATE", DbType.String, ht["P_JSMPODATE"]);
                    dbCon.AddParameters("P_JSMPOSEQ", DbType.String, ht["P_JSMPOSEQ"]);
                    dbCon.AddParameters("P_JSMDATE", DbType.String, ht["P_JSMDATE"]);
                    dbCon.AddParameters("P_JSMMSEQ", DbType.String, ht["P_JSMMSEQ"]);
                    dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["P_JSMBLASS"]);
                    dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["P_JSMMLASS"]);
                    dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["P_JSMSLASS"]);
                    dbCon.AddParameters("P_JSMSEQ", DbType.String, ht["P_JSMSEQ"]);
                    dbCon.AddParameters("P_JSMWKNAME", DbType.String, ht["P_JSMWKNAME"]);
                    dbCon.AddParameters("P_JSMSYSTEM", DbType.String, ht["P_JSMSYSTEM"]);
                    dbCon.AddParameters("P_JSMWKDATE", DbType.String, ht["P_JSMWKDATE"]);
                    dbCon.AddParameters("P_JSMADDATE", DbType.String, ht["P_JSMADDATE"]);
                    dbCon.AddParameters("P_JSMADCHASU", DbType.String, ht["P_JSMADCHASU"]);
                    dbCon.AddParameters("P_JSMWKSABUN", DbType.String, ht["P_JSMWKSABUN"]);
                    dbCon.AddParameters("P_JSMSANAME", DbType.String, ht["P_JSMSANAME"]);
                    dbCon.AddParameters("P_JSMSECTIONNUM", DbType.String, ht["P_JSMSECTIONNUM"]);
                    dbCon.AddParameters("P_JSMMSDSCODE", DbType.String, ht["P_JSMMSDSCODE"]);
                    dbCon.AddParameters("P_JSMMSDSSEQ", DbType.String, ht["P_JSMMSDSSEQ"]);
                    dbCon.AddParameters("P_JSMWKSUMMARY", DbType.String, ht["P_JSMWKSUMMARY"]);
                    dbCon.AddParameters("P_JSMNEEDDATA", DbType.String, ht["P_JSMNEEDDATA"]);
                    dbCon.AddParameters("P_JSMRISKCASE", DbType.String, ht["P_JSMRISKCASE"]);
                    dbCon.AddParameters("P_JSMSELFNAME1", DbType.String, ht["P_JSMSELFNAME1"]);
                    dbCon.AddParameters("P_JSMSELFTEXT1", DbType.String, ht["P_JSMSELFTEXT1"]);
                    dbCon.AddParameters("P_JSMSELFNAME2", DbType.String, ht["P_JSMSELFNAME2"]);
                    dbCon.AddParameters("P_JSMSELFTEXT2", DbType.String, ht["P_JSMSELFTEXT2"]);
                    dbCon.AddParameters("P_JSMSELFNAME3", DbType.String, ht["P_JSMSELFNAME3"]);
                    dbCon.AddParameters("P_JSMSELFTEXT3", DbType.String, ht["P_JSMSELFTEXT3"]);
                    dbCon.AddParameters("P_JSMSELFNAME4", DbType.String, ht["P_JSMSELFNAME4"]);
                    dbCon.AddParameters("P_JSMSELFTEXT4", DbType.String, ht["P_JSMSELFTEXT4"]);
                    dbCon.AddParameters("P_JSMSELFNAME5", DbType.String, ht["P_JSMSELFNAME5"]);
                    dbCon.AddParameters("P_JSMSELFTEXT5", DbType.String, ht["P_JSMSELFTEXT5"]);
                    dbCon.AddParameters("P_JSMSCOMNAME1", DbType.String, ht["P_JSMSCOMNAME1"]);
                    dbCon.AddParameters("P_JSMSCOMTEXT1", DbType.String, ht["P_JSMSCOMTEXT1"]);
                    dbCon.AddParameters("P_JSMSCOMNAME2", DbType.String, ht["P_JSMSCOMNAME2"]);
                    dbCon.AddParameters("P_JSMSCOMTEXT2", DbType.String, ht["P_JSMSCOMTEXT2"]);
                    dbCon.AddParameters("P_JSMHISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, ht["P_WKGUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4045_JSACHANGE_MASTER_ADD");
                }
                // 안전보호구, 안전장비 등록
                UP_JSACHANGE_MSAFETOOL_ADD(ht);

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = "";
                row["JSMWKGUBN"] = ht["P_JSMWKGUBN"];
                row["JSMPOTEAM"] = ht["P_JSMPOTEAM"];
                row["JSMPODATE"] = ht["P_JSMPODATE"];
                row["JSMPOSEQ"] = ht["P_JSMPOSEQ"];
                row["JSMDATE"] = ht["P_JSMDATE"];
                row["JSMMSEQ"] = ht["P_JSMMSEQ"];
                row["JSMBLASS"] = ht["P_JSMBLASS"];
                row["JSMMLASS"] = ht["P_JSMMLASS"];
                row["JSMSLASS"] = ht["P_JSMSLASS"];
                row["JSMSEQ"] = ht["P_JSMSEQ"];

                dt.Rows.Add(row);
                ds2.Tables.Add(dt);
            }
            else
            {
                row = dt.NewRow();
                row["STATE"] = "ERR";
                row["MSG"] = sMSG;
                dt.Rows.Add(row);
                ds2.Tables.Add(dt);
            }

            return ds2;
        }
        #endregion

        #region Description : JSA 안전보호구 및 안전장비 등록
        public void UP_JSACHANGE_MSAFETOOL_ADD(Hashtable ht)
        {

            string[] sSACODE = ht["P_SACODE"].ToString().Split(',');
            string[] sSANAME = ht["P_SANAME"].ToString().Replace(", ", ",").Split(',');
            string[] sTOCODE = ht["P_TOCODE"].ToString().Split(',');
            string[] sTONAME = ht["P_TONAME"].ToString().Replace(", ", ",").Split(',');

            // JSA 안전보호구 및 안전장비 삭제
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSTWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                dbCon.AddParameters("P_JSTPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                dbCon.AddParameters("P_JSTPODATE", DbType.String, ht["P_JSMPODATE"]);
                dbCon.AddParameters("P_JSTPOSEQ", DbType.VarNumeric, ht["P_JSMPOSEQ"]);
                dbCon.AddParameters("P_JSTDATE", DbType.VarNumeric, ht["P_JSMDATE"]);
                dbCon.AddParameters("P_JSTMSEQ", DbType.VarNumeric, ht["P_JSMMSEQ"]);
                dbCon.AddParameters("P_JSTBLASS", DbType.String, ht["P_JSMBLASS"]);
                dbCon.AddParameters("P_JSTMLASS", DbType.String, ht["P_JSMMLASS"]);
                dbCon.AddParameters("P_JSTSLASS", DbType.String, ht["P_JSMSLASS"]);
                dbCon.AddParameters("P_JSTSEQ", DbType.String, ht["P_JSMSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4045_JSACHANGE_MSAFETOOL_DEL");
            }


            // JSA 안전보호구 및 안전장비 등록
            for (int i = 0; i < sSACODE.Length; i++)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSTWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                    dbCon.AddParameters("P_JSTPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                    dbCon.AddParameters("P_JSTPODATE", DbType.String, ht["P_JSMPODATE"]);
                    dbCon.AddParameters("P_JSTPOSEQ", DbType.VarNumeric, ht["P_JSMPOSEQ"]);
                    dbCon.AddParameters("P_JSTDATE", DbType.VarNumeric, ht["P_JSMDATE"]);
                    dbCon.AddParameters("P_JSTMSEQ", DbType.VarNumeric, ht["P_JSMMSEQ"]);
                    dbCon.AddParameters("P_JSTBLASS", DbType.String, ht["P_JSMBLASS"]);
                    dbCon.AddParameters("P_JSTMLASS", DbType.String, ht["P_JSMMLASS"]);
                    dbCon.AddParameters("P_JSTSLASS", DbType.String, ht["P_JSMSLASS"]);
                    dbCon.AddParameters("P_JSTSEQ", DbType.String, ht["P_JSMSEQ"]);
                    dbCon.AddParameters("P_JSTINDX", DbType.String, (i + 1));
                    dbCon.AddParameters("P_JSTCODEGUBN", DbType.String, "1");
                    dbCon.AddParameters("P_JSTSAFECODE", DbType.String, sSACODE[0]);
                    dbCon.AddParameters("P_JSTSAFENAME", DbType.String, sSANAME[0]);
                    dbCon.AddParameters("P_SWHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4045_JSACHANGE_MSAFETOOL_ADD");
                }
            }
            for (int i = 0; i < sTOCODE.Length; i++)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSTWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                    dbCon.AddParameters("P_JSTPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                    dbCon.AddParameters("P_JSTPODATE", DbType.String, ht["P_JSMPODATE"]);
                    dbCon.AddParameters("P_JSTPOSEQ", DbType.VarNumeric, ht["P_JSMPOSEQ"]);
                    dbCon.AddParameters("P_JSTDATE", DbType.VarNumeric, ht["P_JSMDATE"]);
                    dbCon.AddParameters("P_JSTMSEQ", DbType.VarNumeric, ht["P_JSMMSEQ"]);
                    dbCon.AddParameters("P_JSTBLASS", DbType.String, ht["P_JSMBLASS"]);
                    dbCon.AddParameters("P_JSTMLASS", DbType.String, ht["P_JSMMLASS"]);
                    dbCon.AddParameters("P_JSTSLASS", DbType.String, ht["P_JSMSLASS"]);
                    dbCon.AddParameters("P_JSTSEQ", DbType.String, ht["P_JSMSEQ"]);
                    dbCon.AddParameters("P_JSTINDX", DbType.String, (i + 1 + sSACODE.Length));
                    dbCon.AddParameters("P_JSTCODEGUBN", DbType.String, "2");
                    dbCon.AddParameters("P_JSTSAFECODE", DbType.String, sTOCODE[0]);
                    dbCon.AddParameters("P_JSTSAFENAME", DbType.String, sTONAME[0]);
                    dbCon.AddParameters("P_SWHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4045_JSACHANGE_MSAFETOOL_ADD");
                }
            }
        }
        #endregion

        #region Description : JSA(변경관리) 마스터 삭제
        public DataSet UP_JSACHANGE_MASTER_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSACHANGE_MASTER_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                // JSA 마스타 삭제
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                    dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                    dbCon.AddParameters("P_JSMPODATE", DbType.String, ht["P_JSMPODATE"]);
                    dbCon.AddParameters("P_JSMPOSEQ", DbType.String, ht["P_JSMPOSEQ"]);
                    dbCon.AddParameters("P_JSMDATE", DbType.String, ht["P_JSMDATE"]);
                    dbCon.AddParameters("P_JSMMSEQ", DbType.String, ht["P_JSMMSEQ"]);
                    dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["P_JSMBLASS"]);
                    dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["P_JSMMLASS"]);
                    dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["P_JSMSLASS"]);
                    dbCon.AddParameters("P_JSMSEQ", DbType.String, ht["P_JSMSEQ"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4045_JSACHANGE_MASTER_DEL");
                }

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
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

        #region Description : JSA(변경관리) 마스터 저장/삭제 체크
        public string UP_JSACHANGE_MASTER_Check(Hashtable ht)
        {   
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_JSMPODATE"]);
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, ht["P_JSMPOSEQ"]);
                dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, ht["P_JSMDATE"]);
                dbCon.AddParameters("P_WKGUBUN", DbType.String, ht["P_WKGUBUN"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4045_JSACHANGE_CHECK");

                // 작업요청 공사완료여부 체크
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sMSG = "공사완료된 작업요청건입니다.";

                    return sMSG;
                }
                if (ds.Tables[1].Rows.Count > 0)
                {
                    // 작성일의 안전작업허가서 존재여부 체크
                    if (ht["P_JSMWKGUBN"].ToString() == "D")
                    {
                        sMSG = "안전작업허가서 자료가 존재합니다.";

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : JSA(변경관리) 출력 첨부파일 조회
        public DataSet PSM_PSM4045_JSACHANGE_ATTACH_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
                dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
                dbCon.AddParameters("P_JSMPODATE", DbType.String, ht["P_JSMPODATE"]);
                dbCon.AddParameters("P_JSMPOSEQ", DbType.String, ht["P_JSMPOSEQ"]);
                dbCon.AddParameters("P_JSMDATE", DbType.String, ht["P_JSMDATE"]);
                dbCon.AddParameters("P_JSMMSEQ", DbType.String, ht["P_JSMMSEQ"]);
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["P_JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["P_JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["P_JSMSLASS"]);
                dbCon.AddParameters("P_JSMSEQ", DbType.String, ht["P_JSMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4045_JSACHANGE_ATTACH_LIST");
            }
        }
        #endregion



        #region Description : JSA(변경관리) DETAIL 조회
        public DataSet UP_JSACHANGE_DETAIL_LIST(Hashtable ht)
        {   
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4046_JSACHANGE_DETAIL_LIST");
            }
        }
        #endregion

        #region Description : JSA(변경관리) DETAIL 확인
        public DataSet UP_JSACHANGE_DETAIL_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["P_JSDITEMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4046_JSACHANGE_DETAIL_RUN");
            }
        }
        #endregion

        #region Description : JSA(변경관리) DETAIL 등록
        public DataSet UP_JSACHANGE_DETAIL_ADD(Hashtable ht)
        {
            string sJSDITEMSEQ = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["P_JSDITEMSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                    dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                    dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                    dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                    dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                    dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                    dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                    dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                    dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                    dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4046_JSACHANGE_DETAIL_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJSDITEMSEQ = ds.Tables[0].Rows[0]["JSDITEMSEQ"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJSDITEMSEQ = ht["P_JSDITEMSEQ"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, sJSDITEMSEQ);
                dbCon.AddParameters("P_JSDITEMTEXT", DbType.String, ht["P_JSDITEMTEXT"]);
                dbCon.AddParameters("P_JSDTOOLTEXT", DbType.String, ht["P_JSDTOOLTEXT"]);
                dbCon.AddParameters("P_JSDHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4046_JSACHANGE_DETAIL_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, sJSDITEMSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4046_JSACHANGE_DETAIL_RUN");
            }
        }
        #endregion

        #region Description : JSA(변경관리) DETAIL 삭제
        public DataSet UP_JSACHANGE_DETAIL_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_JSACHANGE_DETAIL_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                    dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                    dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                    dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                    dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                    dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                    dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                    dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                    dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                    dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                    dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["P_JSDITEMSEQ"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4046_JSACHANGE_DETAIL_DEL");

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

        #region Description : JSA(변경관리) DEATIL 삭제 체크
        public string UP_JSACHANGE_DETAIL_Check(Hashtable ht)
        {
            string sMSG = string.Empty;

            DataSet ds = new DataSet();

            // 위험성 체크
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["P_JSDITEMSEQ"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_RISK_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sMSG = "위험성 자료가 존재하여 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }
            // 개선대책 체크
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["P_JSDITEMSEQ"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sMSG = "개선대책 자료가 존재하여 삭제 할 수 없습니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion



        #region Description : JSA(변경관리) 위험성 조회
        public DataSet UP_JSACHANGE_RISK_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["P_JSDITEMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_RISK_LIST");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 위험성 확인
        public DataSet UP_JSACHANGE_RISK_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSRWKGUBN", DbType.String, ht["P_JSRWKGUBN"]);
                dbCon.AddParameters("P_JSRPOTEAM", DbType.String, ht["P_JSRPOTEAM"]);
                dbCon.AddParameters("P_JSRPODATE", DbType.String, ht["P_JSRPODATE"]);
                dbCon.AddParameters("P_JSRPOSEQ", DbType.String, ht["P_JSRPOSEQ"]);
                dbCon.AddParameters("P_JSRDATE", DbType.String, ht["P_JSRDATE"]);
                dbCon.AddParameters("P_JSRMSEQ", DbType.String, ht["P_JSRMSEQ"]);
                dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["P_JSRBLASS"]);
                dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["P_JSRMLASS"]);
                dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["P_JSRSLASS"]);
                dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["P_JSRSEQ"]);
                dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["P_JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, ht["P_JSRSUBSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_RISK_RUN");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 위험성 등록
        public DataSet UP_JSACHANGE_RISK_ADD(Hashtable ht)
        {
            string sJSRSUBSEQ = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["P_JSRSUBSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSRWKGUBN", DbType.String, ht["P_JSRWKGUBN"]);
                    dbCon.AddParameters("P_JSRPOTEAM", DbType.String, ht["P_JSRPOTEAM"]);
                    dbCon.AddParameters("P_JSRPODATE", DbType.String, ht["P_JSRPODATE"]);
                    dbCon.AddParameters("P_JSRPOSEQ", DbType.String, ht["P_JSRPOSEQ"]);
                    dbCon.AddParameters("P_JSRDATE", DbType.String, ht["P_JSRDATE"]);
                    dbCon.AddParameters("P_JSRMSEQ", DbType.String, ht["P_JSRMSEQ"]);
                    dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["P_JSRBLASS"]);
                    dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["P_JSRMLASS"]);
                    dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["P_JSRSLASS"]);
                    dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["P_JSRSEQ"]);
                    dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["P_JSRITEMSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_RISK_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJSRSUBSEQ = ds.Tables[0].Rows[0]["JSRSUBSEQ"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJSRSUBSEQ = ht["P_JSRSUBSEQ"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSRWKGUBN", DbType.String, ht["P_JSRWKGUBN"]);
                dbCon.AddParameters("P_JSRPOTEAM", DbType.String, ht["P_JSRPOTEAM"]);
                dbCon.AddParameters("P_JSRPODATE", DbType.String, ht["P_JSRPODATE"]);
                dbCon.AddParameters("P_JSRPOSEQ", DbType.String, ht["P_JSRPOSEQ"]);
                dbCon.AddParameters("P_JSRDATE", DbType.String, ht["P_JSRDATE"]);
                dbCon.AddParameters("P_JSRMSEQ", DbType.String, ht["P_JSRMSEQ"]);
                dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["P_JSRBLASS"]);
                dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["P_JSRMLASS"]);
                dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["P_JSRSLASS"]);
                dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["P_JSRSEQ"]);
                dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["P_JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, sJSRSUBSEQ);
                dbCon.AddParameters("P_JSRRISKTEXT", DbType.String, ht["P_JSRRISKTEXT"]);
                dbCon.AddParameters("P_JSRRISKCNT", DbType.String, ht["P_JSRRISKCNT"]);
                dbCon.AddParameters("P_JSRRISKSOLID", DbType.String, ht["P_JSRRISKSOLID"]);
                dbCon.AddParameters("P_JSRRISKDEGREE", DbType.String, ht["P_JSRRISKDEGREE"]);
                dbCon.AddParameters("P_JSRHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4047_JSACHANGE_RISK_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSRWKGUBN", DbType.String, ht["P_JSRWKGUBN"]);
                dbCon.AddParameters("P_JSRPOTEAM", DbType.String, ht["P_JSRPOTEAM"]);
                dbCon.AddParameters("P_JSRPODATE", DbType.String, ht["P_JSRPODATE"]);
                dbCon.AddParameters("P_JSRPOSEQ", DbType.String, ht["P_JSRPOSEQ"]);
                dbCon.AddParameters("P_JSRDATE", DbType.String, ht["P_JSRDATE"]);
                dbCon.AddParameters("P_JSRMSEQ", DbType.String, ht["P_JSRMSEQ"]);
                dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["P_JSRBLASS"]);
                dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["P_JSRMLASS"]);
                dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["P_JSRSLASS"]);
                dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["P_JSRSEQ"]);
                dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["P_JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, sJSRSUBSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_RISK_RUN");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 위험성 삭제
        public void UP_JSACHANGE_RISK_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSRWKGUBN", DbType.String, ht["P_JSRWKGUBN"]);
                dbCon.AddParameters("P_JSRPOTEAM", DbType.String, ht["P_JSRPOTEAM"]);
                dbCon.AddParameters("P_JSRPODATE", DbType.String, ht["P_JSRPODATE"]);
                dbCon.AddParameters("P_JSRPOSEQ", DbType.String, ht["P_JSRPOSEQ"]);
                dbCon.AddParameters("P_JSRDATE", DbType.String, ht["P_JSRDATE"]);
                dbCon.AddParameters("P_JSRMSEQ", DbType.String, ht["P_JSRMSEQ"]);
                dbCon.AddParameters("P_JSRBLASS", DbType.String, ht["P_JSRBLASS"]);
                dbCon.AddParameters("P_JSRMLASS", DbType.String, ht["P_JSRMLASS"]);
                dbCon.AddParameters("P_JSRSLASS", DbType.String, ht["P_JSRSLASS"]);
                dbCon.AddParameters("P_JSRSEQ", DbType.String, ht["P_JSRSEQ"]);
                dbCon.AddParameters("P_JSRITEMSEQ", DbType.String, ht["P_JSRITEMSEQ"]);
                dbCon.AddParameters("P_JSRSUBSEQ", DbType.String, ht["P_JSRSUBSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4047_JSACHANGE_RISK_DEL");
            }
        }
        #endregion



        #region Description : JSA(변경관리) 개선대책 조회
        public DataSet UP_JSACHANGE_REFORM_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSDWKGUBN", DbType.String, ht["P_JSDWKGUBN"]);
                dbCon.AddParameters("P_JSDPOTEAM", DbType.String, ht["P_JSDPOTEAM"]);
                dbCon.AddParameters("P_JSDPODATE", DbType.String, ht["P_JSDPODATE"]);
                dbCon.AddParameters("P_JSDPOSEQ", DbType.String, ht["P_JSDPOSEQ"]);
                dbCon.AddParameters("P_JSDDATE", DbType.String, ht["P_JSDDATE"]);
                dbCon.AddParameters("P_JSDMSEQ", DbType.String, ht["P_JSDMSEQ"]);
                dbCon.AddParameters("P_JSDBLASS", DbType.String, ht["P_JSDBLASS"]);
                dbCon.AddParameters("P_JSDMLASS", DbType.String, ht["P_JSDMLASS"]);
                dbCon.AddParameters("P_JSDSLASS", DbType.String, ht["P_JSDSLASS"]);
                dbCon.AddParameters("P_JSDSEQ", DbType.String, ht["P_JSDSEQ"]);
                dbCon.AddParameters("P_JSDITEMSEQ", DbType.String, ht["P_JSDITEMSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_LIST");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 개선대책 확인
        public DataSet UP_JSACHANGE_REFORM_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEWKGUBN", DbType.String, ht["P_JSEWKGUBN"]);
                dbCon.AddParameters("P_JSEPOTEAM", DbType.String, ht["P_JSEPOTEAM"]);
                dbCon.AddParameters("P_JSEPODATE", DbType.String, ht["P_JSEPODATE"]);
                dbCon.AddParameters("P_JSEPOSEQ", DbType.String, ht["P_JSEPOSEQ"]);
                dbCon.AddParameters("P_JSEDATE", DbType.String, ht["P_JSEDATE"]);
                dbCon.AddParameters("P_JSEMSEQ", DbType.String, ht["P_JSEMSEQ"]);
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["P_JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["P_JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["P_JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["P_JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["P_JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, ht["P_JSESUBSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_RUN");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 개선대책 등록
        public DataSet UP_JSACHANGE_REFORM_ADD(Hashtable ht)
        {
            string sJSESUBSEQ = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["P_JSESUBSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JSEWKGUBN", DbType.String, ht["P_JSEWKGUBN"]);
                    dbCon.AddParameters("P_JSEPOTEAM", DbType.String, ht["P_JSEPOTEAM"]);
                    dbCon.AddParameters("P_JSEPODATE", DbType.String, ht["P_JSEPODATE"]);
                    dbCon.AddParameters("P_JSEPOSEQ", DbType.String, ht["P_JSEPOSEQ"]);
                    dbCon.AddParameters("P_JSEDATE", DbType.String, ht["P_JSEDATE"]);
                    dbCon.AddParameters("P_JSEMSEQ", DbType.String, ht["P_JSEMSEQ"]);
                    dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["P_JSEBLASS"]);
                    dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["P_JSEMLASS"]);
                    dbCon.AddParameters("P_JSESLASS", DbType.String, ht["P_JSESLASS"]);
                    dbCon.AddParameters("P_JSESEQ", DbType.String, ht["P_JSESEQ"]);
                    dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["P_JSEITEMSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sJSESUBSEQ = ds.Tables[0].Rows[0]["JSESUBSEQ"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sJSESUBSEQ = ht["P_JSESUBSEQ"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEWKGUBN", DbType.String, ht["P_JSEWKGUBN"]);
                dbCon.AddParameters("P_JSEPOTEAM", DbType.String, ht["P_JSEPOTEAM"]);
                dbCon.AddParameters("P_JSEPODATE", DbType.String, ht["P_JSEPODATE"]);
                dbCon.AddParameters("P_JSEPOSEQ", DbType.String, ht["P_JSEPOSEQ"]);
                dbCon.AddParameters("P_JSEDATE", DbType.String, ht["P_JSEDATE"]);
                dbCon.AddParameters("P_JSEMSEQ", DbType.String, ht["P_JSEMSEQ"]);
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["P_JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["P_JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["P_JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["P_JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["P_JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, sJSESUBSEQ);
                dbCon.AddParameters("P_JSEREFORMTEXT", DbType.String, ht["P_JSEREFORMTEXT"]);
                dbCon.AddParameters("P_JSEREFORMCNT", DbType.String, ht["P_JSEREFORMCNT"]);
                dbCon.AddParameters("P_JSEREFORMSOLID", DbType.String, ht["P_JSEREFORMSOLID"]);
                dbCon.AddParameters("P_JSEREFORMDEGREE", DbType.String, ht["P_JSEREFORMDEGREE"]);
                dbCon.AddParameters("P_JSEHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEWKGUBN", DbType.String, ht["P_JSEWKGUBN"]);
                dbCon.AddParameters("P_JSEPOTEAM", DbType.String, ht["P_JSEPOTEAM"]);
                dbCon.AddParameters("P_JSEPODATE", DbType.String, ht["P_JSEPODATE"]);
                dbCon.AddParameters("P_JSEPOSEQ", DbType.String, ht["P_JSEPOSEQ"]);
                dbCon.AddParameters("P_JSEDATE", DbType.String, ht["P_JSEDATE"]);
                dbCon.AddParameters("P_JSEMSEQ", DbType.String, ht["P_JSEMSEQ"]);
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["P_JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["P_JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["P_JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["P_JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["P_JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, sJSESUBSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_RUN");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 개선대책 삭제
        public void UP_JSACHANGE_REFORM_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JSEWKGUBN", DbType.String, ht["P_JSEWKGUBN"]);
                dbCon.AddParameters("P_JSEPOTEAM", DbType.String, ht["P_JSEPOTEAM"]);
                dbCon.AddParameters("P_JSEPODATE", DbType.String, ht["P_JSEPODATE"]);
                dbCon.AddParameters("P_JSEPOSEQ", DbType.String, ht["P_JSEPOSEQ"]);
                dbCon.AddParameters("P_JSEDATE", DbType.String, ht["P_JSEDATE"]);
                dbCon.AddParameters("P_JSEMSEQ", DbType.String, ht["P_JSEMSEQ"]);
                dbCon.AddParameters("P_JSEBLASS", DbType.String, ht["P_JSEBLASS"]);
                dbCon.AddParameters("P_JSEMLASS", DbType.String, ht["P_JSEMLASS"]);
                dbCon.AddParameters("P_JSESLASS", DbType.String, ht["P_JSESLASS"]);
                dbCon.AddParameters("P_JSESEQ", DbType.String, ht["P_JSESEQ"]);
                dbCon.AddParameters("P_JSEITEMSEQ", DbType.String, ht["P_JSEITEMSEQ"]);
                dbCon.AddParameters("P_JSESUBSEQ", DbType.String, ht["P_JSESUBSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4047_JSACHANGE_REFORM_DEL");
            }
        }
        #endregion


        #region Description : JSA(마스터) 조회
        public DataSet UP_JSA_MASTER_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_JSMBLASS", DbType.String, ht["P_JSMBLASS"]);
                dbCon.AddParameters("P_JSMMLASS", DbType.String, ht["P_JSMMLASS"]);
                dbCon.AddParameters("P_JSMSLASS", DbType.String, ht["P_JSMSLASS"]);
                dbCon.AddParameters("P_JSMWKNAME", DbType.String, ht["P_JSMWKNAME"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4048_JSA_MASTER_LIST");
            }
        }
        #endregion

        #region Description : 일일JSA 생성 체크
        public DataSet UP_WORKORDER_FINISH_CHECK(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, ht["P_WOSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_FINISH_VERIFY");
            }
        }

        public DataSet UP_SAFEORDER_CHECK(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_SMWKDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, ht["P_WOSEQ"]);
                dbCon.AddParameters("P_SMWKORAPPDATE", DbType.VarNumeric, ht["P_COPYDATE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_SAFEORDER_CHK");
            }
        }
        #endregion

        #region Description : JSA(변경관리) 생성
        public void UP_JSACHANGE_CREATE(Hashtable ht, Hashtable[] hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_JSLWKGUBN", DbType.String, hts[i]["P_JSLWKGUBN"]);
                    dbCon.AddParameters("P_JSLWKTEAM", DbType.String, hts[i]["P_JSLWKTEAM"]);
                    dbCon.AddParameters("P_JSLWKDATE", DbType.String, hts[i]["P_JSLWKDATE"]);
                    dbCon.AddParameters("P_JSLWKSEQ", DbType.VarNumeric, hts[i]["P_JSLWKSEQ"]);
                    dbCon.AddParameters("P_JSLDATE", DbType.String, hts[i]["P_JSLDATE"]);
                    dbCon.AddParameters("P_JSMBLASS", DbType.String, hts[i]["P_JSMBLASS"]);
                    dbCon.AddParameters("P_JSMMLASS", DbType.String, hts[i]["P_JSMMLASS"]);
                    dbCon.AddParameters("P_JSMSLASS", DbType.String, hts[i]["P_JSMSLASS"]);
                    dbCon.AddParameters("P_JSMSEQ", DbType.VarNumeric, hts[i]["P_JSMSEQ"]);
                    dbCon.AddParameters("P_JSLHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4048_JSACHANGE_CREATE");
                }

                UP_WORKORDER_WOSTATUS_UPT(ht);
            }
        }
        #endregion

        #region Description : 작업요청 작업구분 업데이트
        public void UP_WORKORDER_WOSTATUS_UPT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOSTATUS", DbType.String, ht["P_WOSTATUS"]);
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_WORKORDER_WOSTATUS_UPT");
            }
        }
        #endregion
    }
}
