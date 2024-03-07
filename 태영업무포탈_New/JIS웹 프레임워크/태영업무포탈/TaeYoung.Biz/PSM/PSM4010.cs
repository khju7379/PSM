using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;
using System.Web.Mail;

namespace TaeYoung.Biz.PSM
{
    public class PSM4010 : BizBase
    {
        #region Description : 작업요청서 가져오기
        public DataSet UP_GET_WORKORDER_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_WOORDATE",         DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOAPPRESABUN1",    DbType.String, ht["P_WOAPPRESABUN1"]);
                dbCon.AddParameters("P_WOWORKTITLE",      DbType.String, ht["P_WOWORKTITLE"]);
                dbCon.AddParameters("P_WKGUBN",           DbType.String, ht["P_WKGUBN"]);
                dbCon.AddParameters("P_WKSTATUS",         DbType.String, ht["P_WKSTATUS"]);
                dbCon.AddParameters("P_WKTEAM",           DbType.String, ht["P_WKTEAM"]);
                dbCon.AddParameters("P_DEPT",             DbType.String, ht["P_DEPT"]);
                dbCon.AddParameters("P_WOORTEAM",         DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORSABUN",        DbType.String, ht["P_WOORSABUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4010_WORKORDER_LIST");
            }
        }
        #endregion

        #region Description : 작업요청서 확인
        public DataSet UP_WORKORDER_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, ht["P_WOSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");
            }
        }
        #endregion

        #region Description : 작업요청서 순번 가져오기
        public DataSet UP_PSM4011_GET_MAX_WOSEQ(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_GET_MAX_WOSEQ");
            }
        }
        #endregion

        #region Description : 작업요청서 결재 DISPLAY
        public DataSet UP_PSM4011_APPROVAL_DISPLAY(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",    DbType.String, ht["P_WOSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_APP_DSP");
            }
        }
        #endregion

        #region Description : 작업요청서 작업완료 가져오기
        public DataSet UP_GET_WORKORDER_FINISH_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",    DbType.String, ht["P_WOSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_FINISH_RUN");
            }
        }
        #endregion





        #region Description : 작업요청 저장 및 결재
        public DataSet UP_WORKORDER_APPROVAL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM",        DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE",        DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",           DbType.VarNumeric, ht["P_WOSEQ"]);
                dbCon.AddParameters("P_WOORSABUN",       DbType.String,     ht["P_WOORSABUN"]);
                dbCon.AddParameters("P_WOWORKTITLE",     DbType.String,     ht["P_WOWORKTITLE"]);
                dbCon.AddParameters("P_WOLOCATIONCODE1", DbType.String,     ht["P_WOLOCATIONCODE1"]);
                dbCon.AddParameters("P_WOLOCATIONCODE2", DbType.String,     ht["P_WOLOCATIONCODE2"]);
                dbCon.AddParameters("P_WOLOCATIONCODE3", DbType.String,     ht["P_WOLOCATIONCODE3"]);
                dbCon.AddParameters("P_WOLOCATIONCODE4", DbType.String,     ht["P_WOLOCATIONCODE4"]);
                dbCon.AddParameters("P_WOLOCATIONCODE5", DbType.String,     ht["P_WOLOCATIONCODE5"]);
                dbCon.AddParameters("P_WOAREACODE1",     DbType.String,     ht["P_WOAREACODE1"]);
                dbCon.AddParameters("P_WOAREACODE2",     DbType.String,     ht["P_WOAREACODE2"]);
                dbCon.AddParameters("P_WOAREACODE3",     DbType.String,     ht["P_WOAREACODE3"]);
                dbCon.AddParameters("P_WOAREACODE4",     DbType.String,     ht["P_WOAREACODE4"]);
                dbCon.AddParameters("P_WOAREACODE5",     DbType.String,     ht["P_WOAREACODE5"]);
                dbCon.AddParameters("P_WODSDATE1",       DbType.String,     ht["P_WODSDATE1"]);
                dbCon.AddParameters("P_WODSDATE2",       DbType.String,     ht["P_WODSDATE2"]);
                dbCon.AddParameters("P_WOSOTEAM",        DbType.String,     ht["P_WOSOTEAM"]);
                dbCon.AddParameters("P_WORETEAM",        DbType.String,     ht["P_WORETEAM"]);
                dbCon.AddParameters("P_WOSAFESABUN",     DbType.String,     ht["P_WOSAFESABUN"]);
                dbCon.AddParameters("P_WOCHANGEWKJOB",   DbType.String,     ht["P_WOCHANGEWKJOB"]);
                dbCon.AddParameters("P_WOCHANGEWKDIV",   DbType.String,     ht["P_WOCHANGEWKDIV"]);
                dbCon.AddParameters("P_WOAPPSOSABUN1",   DbType.String,     ht["P_WOAPPSOSABUN1"]);
                dbCon.AddParameters("P_WOAPPSONAME1",    DbType.String,     ht["P_WOAPPSONAME1"]); 
                dbCon.AddParameters("P_WOAPPSOJKCD1",    DbType.String,     ht["P_WOAPPSOJKCD1"]);
                dbCon.AddParameters("P_WOAPPSOJKCDNM1",  DbType.String,     ht["P_WOAPPSOJKCDNM1"]);
                dbCon.AddParameters("P_WOAPPSOCOMMENT1", DbType.String,     ht["P_WOAPPSOCOMMENT1"]);
                dbCon.AddParameters("P_WOAPPSOSABUN2",   DbType.String,     ht["P_WOAPPSOSABUN2"]);
                dbCon.AddParameters("P_WOAPPSONAME2",    DbType.String,     ht["P_WOAPPSONAME2"]); 
                dbCon.AddParameters("P_WOAPPSOJKCD2",    DbType.String,     ht["P_WOAPPSOJKCD2"]); 
                dbCon.AddParameters("P_WOAPPSOJKCDNM2",  DbType.String,     ht["P_WOAPPSOJKCDNM2"]);
                dbCon.AddParameters("P_WOAPPSOCOMMENT2", DbType.String,     ht["P_WOAPPSOCOMMENT2"]);
                dbCon.AddParameters("P_WOAPPSOSABUN3",   DbType.String,     ht["P_WOAPPSOSABUN3"]);
                dbCon.AddParameters("P_WOAPPSONAME3",    DbType.String,     ht["P_WOAPPSONAME3"]); 
                dbCon.AddParameters("P_WOAPPSOJKCD3",    DbType.String,     ht["P_WOAPPSOJKCD3"]); 
                dbCon.AddParameters("P_WOAPPSOJKCDNM3",  DbType.String,     ht["P_WOAPPSOJKCDNM3"]);
                dbCon.AddParameters("P_WOAPPSOCOMMENT3", DbType.String,     ht["P_WOAPPSOCOMMENT3"]);
                dbCon.AddParameters("P_WOAPPSOSABUN4",   DbType.String,     ht["P_WOAPPSOSABUN4"]);
                dbCon.AddParameters("P_WOAPPSONAME4",    DbType.String,     ht["P_WOAPPSONAME4"]); 
                dbCon.AddParameters("P_WOAPPSOJKCD4",    DbType.String,     ht["P_WOAPPSOJKCD4"]); 
                dbCon.AddParameters("P_WOAPPSOJKCDNM4",  DbType.String,     ht["P_WOAPPSOJKCDNM4"]);
                dbCon.AddParameters("P_WOAPPSOCOMMENT4", DbType.String,     ht["P_WOAPPSOCOMMENT4"]);
                dbCon.AddParameters("P_WOAPPSOSABUN5",   DbType.String,     ht["P_WOAPPSOSABUN5"]);
                dbCon.AddParameters("P_WOAPPSONAME5",    DbType.String,     ht["P_WOAPPSONAME5"]); 
                dbCon.AddParameters("P_WOAPPSOJKCD5",    DbType.String,     ht["P_WOAPPSOJKCD5"]); 
                dbCon.AddParameters("P_WOAPPSOJKCDNM5",  DbType.String,     ht["P_WOAPPSOJKCDNM5"]);
                dbCon.AddParameters("P_WOAPPSOCOMMENT5", DbType.String,     ht["P_WOAPPSOCOMMENT5"]);
                dbCon.AddParameters("P_WOAPPRESABUN1",   DbType.String,     ht["P_WOAPPRESABUN1"]);
                dbCon.AddParameters("P_WOAPPRENAME1",    DbType.String,     ht["P_WOAPPRENAME1"]); 
                dbCon.AddParameters("P_WOAPPREJKCD1",    DbType.String,     ht["P_WOAPPREJKCD1"]); 
                dbCon.AddParameters("P_WOAPPREJKCDNM1",  DbType.String,     ht["P_WOAPPREJKCDNM1"]);
                dbCon.AddParameters("P_WOAPPRECOMMENT1", DbType.String,     ht["P_WOAPPRECOMMENT1"]);
                dbCon.AddParameters("P_WOAPPRESABUN2",   DbType.String,     ht["P_WOAPPRESABUN2"]);
                dbCon.AddParameters("P_WOAPPRENAME2",    DbType.String,     ht["P_WOAPPRENAME2"]); 
                dbCon.AddParameters("P_WOAPPREJKCD2",    DbType.String,     ht["P_WOAPPREJKCD2"]); 
                dbCon.AddParameters("P_WOAPPREJKCDNM2",  DbType.String,     ht["P_WOAPPREJKCDNM2"]);
                dbCon.AddParameters("P_WOAPPRECOMMENT2", DbType.String,     ht["P_WOAPPRECOMMENT2"]);
                dbCon.AddParameters("P_WOAPPRESABUN3",   DbType.String,     ht["P_WOAPPRESABUN3"]);
                dbCon.AddParameters("P_WOAPPRENAME3",    DbType.String,     ht["P_WOAPPRENAME3"]); 
                dbCon.AddParameters("P_WOAPPREJKCD3",    DbType.String,     ht["P_WOAPPREJKCD3"]); 
                dbCon.AddParameters("P_WOAPPREJKCDNM3",  DbType.String,     ht["P_WOAPPREJKCDNM3"]);
                dbCon.AddParameters("P_WOAPPRECOMMENT3", DbType.String,     ht["P_WOAPPRECOMMENT3"]);
                dbCon.AddParameters("P_WOAPPRESABUN4",   DbType.String,     ht["P_WOAPPRESABUN4"]);
                dbCon.AddParameters("P_WOAPPRENAME4",    DbType.String,     ht["P_WOAPPRENAME4"]); 
                dbCon.AddParameters("P_WOAPPREJKCD4",    DbType.String,     ht["P_WOAPPREJKCD4"]); 
                dbCon.AddParameters("P_WOAPPREJKCDNM4",  DbType.String,     ht["P_WOAPPREJKCDNM4"]);
                dbCon.AddParameters("P_WOAPPRECOMMENT4", DbType.String,     ht["P_WOAPPRECOMMENT4"]);
                dbCon.AddParameters("P_WOAPPRESABUN5",   DbType.String,     ht["P_WOAPPRESABUN5"]);
                dbCon.AddParameters("P_WOAPPRENAME5",    DbType.String,     ht["P_WOAPPRENAME5"]); 
                dbCon.AddParameters("P_WOAPPREJKCD5",    DbType.String,     ht["P_WOAPPREJKCD5"]); 
                dbCon.AddParameters("P_WOAPPREJKCDNM5",  DbType.String,     ht["P_WOAPPREJKCDNM5"]);
                dbCon.AddParameters("P_WOAPPRECOMMENT5", DbType.String,     ht["P_WOAPPRECOMMENT5"]);
                dbCon.AddParameters("P_WOGRDOC1",        DbType.String,     ht["P_WOGRDOC1"]);
                dbCon.AddParameters("P_WOGRURL1",        DbType.String,     ht["P_WOGRURL1"]);
                dbCon.AddParameters("P_WOGRDOC2",        DbType.String,     ht["P_WOGRDOC2"]);
                dbCon.AddParameters("P_WOGRURL2",        DbType.String,     ht["P_WOGRURL2"]);
                dbCon.AddParameters("P_WOSTATUS",        DbType.String,     ht["P_WOSTATUS"]);
                dbCon.AddParameters("P_WOWORKDOC",       DbType.String, Convert.ToString(ht["P_WOWORKDOC"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_WOPONUM1",        DbType.String,     ht["P_WOPONUM1"]);
                dbCon.AddParameters("P_WOPONUM2",        DbType.String,     ht["P_WOPONUM2"]);
                dbCon.AddParameters("P_WOPONUM3",        DbType.String,     ht["P_WOPONUM3"]);
                dbCon.AddParameters("P_WOPONUM4",        DbType.String,     ht["P_WOPONUM4"]);
                dbCon.AddParameters("P_WOPONUM5",        DbType.String,     ht["P_WOPONUM5"]);
                dbCon.AddParameters("P_WOHISAB",         DbType.String,     ht["P_WOHISAB"]);
                dbCon.AddParameters("P_RESABUN",         DbType.String,     ht["P_RESABUN"]);
                dbCon.AddParameters("P_RENAME",          DbType.String,     ht["P_RENAME"]);
                dbCon.AddParameters("P_SOCOUNT",         DbType.VarNumeric, ht["P_SOCOUNT"]);
                dbCon.AddParameters("P_RECOUNT",         DbType.VarNumeric, ht["P_RECOUNT"]);
                dbCon.AddParameters("P_SOAPPROVAL",      DbType.String,     ht["P_SOAPPROVAL"]);
                dbCon.AddParameters("P_REAPPROVAL",      DbType.String,     ht["P_REAPPROVAL"]);

                dbCon.AddParameters("P_GUBUN",           DbType.String,     ht["P_GUBUN"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4011_WORKORDER_APPROVAL");

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : 작업요청 삭제
        public DataSet UP_WORKORDER_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_Chk_Risk_Master(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    // 파일 삭제
                    dbCon.AddParameters("P_ATTACH_TYPE",  DbType.String, ht["P_ATTACH_TYPE"]);
                    dbCon.AddParameters("P_ATTACH_NO",    DbType.String, ht["P_ATTACH_NO"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_ATTACHFILE_DEL");
                }

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_WOORTEAM", DbType.String,     ht["P_WOORTEAM"]);
                    dbCon.AddParameters("P_WOORDATE", DbType.String,     ht["P_WOORDATE"]);
                    dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, ht["P_WOSEQ"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4011_WORKORDER_DEL");

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

        #region Description : 작업요청 반려
        public DataSet UP_WORKORDER_CANCEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_Chk_Risk_Master(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_WOORTEAM", DbType.String,     ht["P_WOORTEAM"]);
                    dbCon.AddParameters("P_WOORDATE", DbType.String,     ht["P_WOORDATE"]);
                    dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, ht["P_WOSEQ"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4011_WORKORDER_CANCEL");

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

        #region Description : 작업요청 반려 의견
        public DataSet UP_WORKORDER_CANCEL_COMMENT(Hashtable ht)
        {
            DataSet   ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_Chk_Risk_Master(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_WOORTEAM",        DbType.String,     ht["P_WOORTEAM"]);
                    dbCon.AddParameters("P_WOORDATE",        DbType.String,     ht["P_WOORDATE"]);
                    dbCon.AddParameters("P_WOSEQ",           DbType.VarNumeric, ht["P_WOSEQ"]);

                    dbCon.AddParameters("P_WOCANCELSABUN",   DbType.String,     ht["P_WOCANCELSABUN"]);
                    dbCon.AddParameters("P_WOCANCELCOMMENT", DbType.String,     ht["P_WOCANCELCOMMENT"]);
                    dbCon.AddParameters("P_GUBUN",           DbType.String,     ht["P_GUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4011_WORKORDER_CANCEL_ADD");

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

        #region Description : 작업요청 철회
        public DataSet UP_WORKORDER_RETRACT(Hashtable ht)
        {
            DataSet   ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            try
            {
                dt.Columns.Add("STATE", typeof(System.String));
                dt.Columns.Add("MSG",   typeof(System.String));

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_RTDOCID",   DbType.String, ht["P_RTDOCID"]);
                    dbCon.AddParameters("P_RTDOCNUM",  DbType.String, ht["P_RTDOCNUM"]);
                    dbCon.AddParameters("P_RTCOMMENT", DbType.String, ht["P_RTCOMMENT"]);
                    dbCon.AddParameters("P_RTHISAB",   DbType.String, ht["P_RTHISAB"]);

                    // 작업요청 철회 DB 저장
                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_MAILRETRACT_INSERT");

                    // 결재철회 메일 발송
                    UP_RETRACT_Mail_Send(ht);

                    // 작업요청서 취소
                    ds = UP_WORKORDER_CANCEL(ht);

                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"] = "";
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);
                }
            }
            catch (Exception ex)
            {
                row = dt.NewRow();
                row["STATE"] = "ERR";
                row["MSG"]   = "ERR";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion







        #region Description : BIN 상태 업데이트
        public void UP_BIN_STATUSMF_UPDATE(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOLOCATIONCODE1", DbType.String, ht["P_WOLOCATIONCODE1"]);
                dbCon.AddParameters("P_WOLOCATIONCODE2", DbType.String, ht["P_WOLOCATIONCODE2"]);
                dbCon.AddParameters("P_WOLOCATIONCODE3", DbType.String, ht["P_WOLOCATIONCODE3"]);
                dbCon.AddParameters("P_WOLOCATIONCODE4", DbType.String, ht["P_WOLOCATIONCODE4"]);
                dbCon.AddParameters("P_WOLOCATIONCODE5", DbType.String, ht["P_WOLOCATIONCODE5"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4011_BIN_STATUSMF_UPDATE");
            }
        }
        #endregion

        #region Description : 결재 완료 업데이트
        public DataSet UP_WORKORDER_APPSTATUS_UPT(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOAPPSTATUS", DbType.String,     "F");
                dbCon.AddParameters("P_WOORTEAM",    DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE",    DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",       DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4011_WORKORDER_APPSTATUS_UPT");

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"]   = "";
                dt.Rows.Add(row);
                retds.Tables.Add(dt);
            }

            return retds;
        }
        #endregion

        #region Description : 작업요청 작업완료 업데이트
        public DataSet UP_WORKORDER_FINISH_UPT(Hashtable ht)
        {
            DataSet ds    = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt  = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOAPPSTATUS", DbType.String,     "F");
                dbCon.AddParameters("P_WOORTEAM",    DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE",    DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",       DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4011_WORKORDER_APPSTATUS_UPT");
            }
            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOFINISHDATE",  DbType.String,     ht["P_WOFINISHDATE"]);
                dbCon.AddParameters("P_WOFINISHSABUN", DbType.String,     ht["P_WOFINISHSABUN"]);
                dbCon.AddParameters("P_WOFINISHTEXT",  DbType.String,     ht["P_WOFINISHTEXT"]);
                dbCon.AddParameters("P_WOORTEAM",      DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE",      DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",         DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_WORKORDER_FINISH_UPT");
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, ht["P_WOSEQ"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_FINISH_VERIFY");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"]   = "";
                    dt.Rows.Add(row);
                    retds.Tables.Add(dt);

                    // 작업요청 요청자 메일 발송
                    UP_Mail_WK_Send(ds.Tables[0].Rows[0]["APNUM"].ToString(),
                                    ds.Tables[0].Rows[0]["WOORTEAM"].ToString(),
                                    ds.Tables[0].Rows[0]["WOORDATE"].ToString(),
                                    ds.Tables[0].Rows[0]["WOSEQ"].ToString(),
                                    ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString(),
                                    ds.Tables[0].Rows[0]["WOFINISHTEXT"].ToString(),
                                    ds.Tables[0].Rows[0]["WOIMMEDTEXT"].ToString(),
                                    ds.Tables[0].Rows[0]["WOIMMEDDATE"].ToString(),
                                    ds.Tables[0].Rows[0]["WOWORKDOC"].ToString(),
                                    ds.Tables[0].Rows[0]["WOCHANGEWKDIV"].ToString(),
                                    "FINISH");

                    // 참조자 메일 발송
                    UP_Mail_Reference_Send(ds.Tables[0].Rows[0]["APNUM"].ToString(),
                                            ds.Tables[0].Rows[0]["WOORTEAM"].ToString(),
                                            ds.Tables[0].Rows[0]["WOORDATE"].ToString(),
                                            ds.Tables[0].Rows[0]["WOSEQ"].ToString(),
                                            ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString(),
                                            ds.Tables[0].Rows[0]["WOFINISHTEXT"].ToString(),
                                            ds.Tables[0].Rows[0]["WOIMMEDTEXT"].ToString(),
                                            ds.Tables[0].Rows[0]["WOIMMEDDATE"].ToString(),
                                            ds.Tables[0].Rows[0]["WOWORKDOC"].ToString(),
                                            Document.UserInfo.EmpID,
                                            "FINISH"
                                            );
                }
            }

            return retds;
        }
        #endregion

        #region Description : 작업요청 조치완료 업데이트
        public DataSet UP_WORKORDER_IMMED_UPT(Hashtable ht)
        {
            DataSet ds    = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt  = new DataTable();
            DataRow row;

            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOIMMEDDATE",  DbType.String,     ht["P_WOIMMEDDATE"]);
                dbCon.AddParameters("P_WOIMMEDSABUN", DbType.String,     ht["P_WOIMMEDSABUN"]);
                dbCon.AddParameters("P_WOIMMEDTEXT",  DbType.String,     ht["P_WOIMMEDTEXT"]);
                dbCon.AddParameters("P_WOORTEAM",     DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE",     DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",        DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_WORKORDER_IMMED_UPT");
            }

            if (ht["P_WOSEQ"].ToString() == "CONFIRM")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                    dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                    dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, ht["P_WOSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_IMMED_VERIFY");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        row = dt.NewRow();
                        row["STATE"] = "OK";
                        row["MSG"] = "";
                        dt.Rows.Add(row);
                        retds.Tables.Add(dt);

                        // 작업요청 요청자 메일 발송
                        UP_Mail_WK_Send(ds.Tables[0].Rows[0]["APNUM"].ToString(),
                                        ds.Tables[0].Rows[0]["WOORTEAM"].ToString(),
                                        ds.Tables[0].Rows[0]["WOORDATE"].ToString(),
                                        ds.Tables[0].Rows[0]["WOSEQ"].ToString(),
                                        ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString(),
                                        ds.Tables[0].Rows[0]["WOFINISHTEXT"].ToString(),
                                        ds.Tables[0].Rows[0]["WOIMMEDTEXT"].ToString(),
                                        ds.Tables[0].Rows[0]["WOIMMEDDATE"].ToString(),
                                        ds.Tables[0].Rows[0]["WOWORKDOC"].ToString(),
                                        ds.Tables[0].Rows[0]["WOCHANGEWKDIV"].ToString(),
                                        "CONFIRM");

                        // 참조자 메일 발송
                        UP_Mail_Reference_Send(ds.Tables[0].Rows[0]["APNUM"].ToString(),
                                               ds.Tables[0].Rows[0]["WOORTEAM"].ToString(),
                                               ds.Tables[0].Rows[0]["WOORDATE"].ToString(),
                                               ds.Tables[0].Rows[0]["WOSEQ"].ToString(),
                                               ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString(),
                                               ds.Tables[0].Rows[0]["WOFINISHTEXT"].ToString(),
                                               ds.Tables[0].Rows[0]["WOIMMEDTEXT"].ToString(),
                                               ds.Tables[0].Rows[0]["WOIMMEDDATE"].ToString(),
                                               ds.Tables[0].Rows[0]["WOWORKDOC"].ToString(),
                                               Document.UserInfo.EmpID,
                                               "CONFIRM"
                                               );
                    }
                }
            }

            return retds;
        }
        #endregion







        #region Description : 작업요청 요청자 완료메일 발송
        private void UP_Mail_WK_Send(string sAPNUM,         string sWOORTEAM,    string sWOORDATE,
                                     string sWOSEQ,         string sWOWORKTITLE, string sWOFINISHTEXT,
                                     string sWOIMMEDTEXT,   string sWOIMMEDDATE, string sWOWORKDOC,
                                     string sWOCHANGEWKDIV, string sGUBUN)
        {
            string sTitle    = string.Empty;

            string sMailFrom = string.Empty;
            string sMailTo   = string.Empty;

            int i = 0;

            string sKBSABUN  = string.Empty;

            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 작업요청서 - 요청 및 수신결재사번
                dbCon.AddParameters("P_WOORTEAM", DbType.String,     sWOORTEAM.ToString());
                dbCon.AddParameters("P_WOORDATE", DbType.String,     sWOORDATE.ToString());
                dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, sWOSEQ.ToString());

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            sKBSABUN = ds.Tables[0].Rows[i]["SABUN"].ToString();
                        }
                        else
                        {
                            sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["SABUN"].ToString();
                        }
                    }

                    // 요청결재자 메일 주소 가져오기
                    dbCon.AddParameters("P_KBSABUN",  DbType.String, sKBSABUN.ToString());

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            }
                            else
                            {
                                sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            }
                        }

                        string sLine = "";

                        MailMessage mess = new MailMessage();

                        // 결재자 메일 주소 가져오기
                        mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";
                        mess.To = sMailTo.ToString();

                        if (sGUBUN.ToString() == "FINISH")
                        {
                            sTitle = sWOWORKTITLE.ToString() + " - 작업요청 공사완료";
                        }
                        else
                        {
                            sTitle = sWOWORKTITLE.ToString() + " - 작업요청 확인 완료";
                        }

                        mess.Subject = "[" + sTitle + "]";

                        try
                        {


                            sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
                            sLine += "<HTML>";
                            sLine += "<HEAD>";
                            sLine += "<TITLE> New Document </TITLE>";
                            sLine += "<style type='text/css'>";
                            sLine += "<!-- /* Global Css */ ";
                            sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
                            sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
                            sLine += "img{border:none} --> </style> ";
                            sLine += "<script language='javascript'>";
                            sLine += " function AppPageLink() { ";
                            sLine += "    document.frm.submit(); ";
                            sLine += "  }";
                            sLine += "</script>";
                            sLine += "</HEAD>";
                            sLine += "<BODY>";
                            sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
                            sLine += "    <tbody> ";
                            sLine += "        <tr> ";
                            sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 작업요청서 </th> ";
                            sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                            sLine += "                    <a href=''&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                            //sLine += "                  <a onclick = window.open('','문서보기','width=920,height=1000')> ";
                            sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                            sLine += "            </td> ";
                            sLine += "        </tr> ";

                            if (sGUBUN.ToString() == "FINISH")
                            {
                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKTITLE.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 의견 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOFINISHTEXT.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치내용 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOIMMEDTEXT.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";
                            }
                            else
                            {
                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKTITLE.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치일자 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOIMMEDDATE.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치내용 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOIMMEDTEXT.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";
                            }
                            sLine += "        <tr> ";
                            sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
                            sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
                            sLine += "            </th> ";
                            sLine += "        </tr> ";
                            sLine += "    </tbody> ";
                            sLine += "</table> ";
                            sLine += "</form>";
                            sLine += "</BODY>";
                            sLine += "</HTML> ";

                            mess.Body = sLine;
                            mess.BodyFormat = MailFormat.Html;

                            SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                            // 메일 발송
                            SmtpMail.Send(mess);
                        }
                        catch
                        {
                            return;
                        }
                    }
                }
            }
        }
        #endregion

        #region Description : 작업요청 참조자 메일 발송
        private void UP_Mail_Reference_Send(string sAPNUM,       string sWOORTEAM,    string sWOORDATE,
                                            string sWOSEQ,       string sWOWORKTITLE, string sWOFINISHTEXT,
                                            string sWOIMMEDTEXT, string sWOIMMEDDATE, string sWOWORKDOC,
                                            string sMail_Send,   string sGUBUN)
        {

            string sTitle    = string.Empty;

            string sMailFrom = string.Empty;
            string sMailTo   = string.Empty;
            string sParamUrl = string.Empty;

            string sCKMAPPSABUN = string.Empty;

            string sUrl = string.Empty;

            int i = 0;

            int iRE_Count = 0;

            string sREDOCID  = string.Empty;
            string sREDOCNUM = string.Empty;
            string sRESABUN  = string.Empty;

            sREDOCID = "01";
            sREDOCNUM = sWOORTEAM.ToString() + sWOORDATE.ToString() + Set_Fill3(sWOSEQ.ToString());

            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 작업요청서 - 참조자
                dbCon.AddParameters("P_REDOCID",  DbType.String, sREDOCID);
                dbCon.AddParameters("P_REDOCNUM", DbType.String, sREDOCNUM);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_REFERENCE_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        sRESABUN = ds.Tables[0].Rows[i]["RESABUN"].ToString();
                    }

                    // 참조자 메일 주소 가져오기
                    dbCon.AddParameters("P_KBSABUN", DbType.String, sRESABUN.ToString());

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";

                            //    if (i == 0)
                            //    {
                            //        sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //    }
                            //    else
                            //    {
                            //        sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //    }
                            //}

                            sParamUrl = "/Portal/PSM/PSM40/PSM4011.aspx?";
                            sParamUrl = sParamUrl + "param=UPT&param1=";
                            sParamUrl = sParamUrl + sAPNUM;

                            string sLine = "";

                            sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&ID=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&LINKURL=" + sParamUrl;

                            MailMessage mess = new MailMessage();

                            // 발신자
                            mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";
                            mess.To = sMailTo.ToString();

                            if (sGUBUN.ToString() == "FINISH")
                            {
                                sTitle = sWOWORKTITLE.ToString() + " - 작업요청 공사완료";
                            }
                            else if (sGUBUN.ToString() == "CONFIRM")
                            {
                                sTitle = sWOWORKTITLE.ToString() + " - 작업요청 확인 완료";
                            }

                            else
                            {
                                sTitle = sWOWORKTITLE.ToString() + " - 작업요청서 완료";
                            }

                            mess.Subject = "[" + sTitle + "]";

                            try
                            {
                                if (sGUBUN.ToString() == "FINISH" || sGUBUN.ToString() == "CONFIRM")
                                {
                                    sLine = "";
                                    sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
                                    sLine += "<HTML>";
                                    sLine += "<HEAD>";
                                    sLine += "<TITLE> New Document </TITLE>";
                                    sLine += "<style type='text/css'>";
                                    sLine += "<!-- /* Global Css */ ";
                                    sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
                                    sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
                                    sLine += "img{border:none} --> </style> ";
                                    sLine += "<script language='javascript'>";
                                    sLine += " function AppPageLink() { ";
                                    sLine += "    document.frm.submit(); ";
                                    sLine += "  }";
                                    sLine += "</script>";
                                    sLine += "</HEAD>";
                                    sLine += "<BODY>";
                                    sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
                                    sLine += "    <tbody> ";
                                    sLine += "        <tr> ";
                                    sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 작업요청서 </th> ";
                                    sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                                    sLine += "                    <a href=''&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                                    //sLine += "                <a onclick = window.open('','문서보기','width=920,height=1000')> ";
                                    sLine += "                <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                                    sLine += "            </td> ";
                                    sLine += "        </tr> ";

                                    if (sGUBUN.ToString() == "CONFIRM")
                                    {
                                        sLine += "        <tr> ";
                                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                        sLine += "        <tr> ";
                                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작 업 명 </th> ";
                                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKTITLE.ToString() + " </td> ";
                                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                        sLine += "        <tr> ";
                                        sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치일자 </th> ";
                                        sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOIMMEDDATE.ToString() + "</td> ";
                                        sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                        sLine += "        <tr> ";
                                        sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치내용 </th> ";
                                        sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOIMMEDTEXT.ToString() + "</td> ";
                                        sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                    }
                                    else
                                    {
                                        sLine += "        <tr> ";
                                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                        sLine += "        <tr> ";
                                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작 업 명 </th> ";
                                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKTITLE.ToString() + " </td> ";
                                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                        sLine += "        <tr> ";
                                        sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 의견 </th> ";
                                        sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOFINISHTEXT.ToString() + "</td> ";
                                        sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                        sLine += "        <tr> ";
                                        sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치내용 </th> ";
                                        sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOIMMEDTEXT.ToString() + "</td> ";
                                        sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                    }
                                    sLine += "        <tr> ";
                                    sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
                                    sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
                                    sLine += "            </th> ";
                                    sLine += "        </tr> ";
                                    sLine += "    </tbody> ";
                                    sLine += "</table> ";
                                    sLine += "</form>";
                                    sLine += "</BODY>";
                                    sLine += "</HTML> ";
                                }
                                else
                                {
                                    sLine = "";
                                    sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
                                    sLine += "<HTML>";
                                    sLine += "<HEAD>";
                                    sLine += "<TITLE> New Document </TITLE>";
                                    sLine += "<style type='text/css'>";
                                    sLine += "<!-- /* Global Css */ ";
                                    sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
                                    sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
                                    sLine += "img{border:none} --> </style> ";
                                    sLine += "<script language='javascript'>";
                                    sLine += " function AppPageLink() { ";
                                    sLine += "    document.frm.submit(); ";
                                    sLine += "  }";
                                    sLine += "</script>";
                                    sLine += "</HEAD>";
                                    sLine += "<BODY>";
                                    sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
                                    sLine += "    <tbody> ";
                                    sLine += "        <tr> ";
                                    sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 작업요청서 </th> ";
                                    sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                                    sLine += "                    <a href='" + sUrl + "'&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                                    //sLine += "                <a onclick = window.open('" + sUrl + "','문서보기','width=920,height=1000')> ";
                                    sLine += "                <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                                    sLine += "            </td> ";
                                    sLine += "        </tr> ";
                                    sLine += "        <tr> ";
                                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                    sLine += "        </tr> ";
                                    sLine += "        <tr> ";
                                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작 업 명 </th> ";
                                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKTITLE.ToString() + " </td> ";
                                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                    sLine += "        </tr> ";
                                    if (sWOWORKDOC != "")
                                    {
                                        sLine += "        <tr> ";
                                        sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
                                        sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKDOC.ToString().Replace("\n", "<br>") + "</td> ";
                                        sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                    }
                                    sLine += "        <tr> ";
                                    sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
                                    sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
                                    sLine += "            </th> ";
                                    sLine += "        </tr> ";
                                    sLine += "    </tbody> ";
                                    sLine += "</table> ";
                                    sLine += "</form>";
                                    sLine += "</BODY>";
                                    sLine += "</HTML> ";
                                }

                                mess.Body = sLine;
                                mess.BodyFormat = MailFormat.Html;

                                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                                // 메일 발송
                                SmtpMail.Send(mess);
                            }
                            catch
                            {
                                return;
                            }
                        }
                    }
                }
            }
        }
        #endregion

        #region Description : 작업요청 요청자 메일 발송
        public DataSet UP_Get_Mail_List(Hashtable ht)
        {
            string sMailFrom        = string.Empty;
            string sMailTo          = string.Empty;

            string sAPNUM           = string.Empty;
            string sSENDER          = string.Empty;
            string sRECEIVER        = string.Empty;
            string sPGURL           = string.Empty;
            string sTITLE           = string.Empty;
            string sWOWORKTITLE     = string.Empty;
            string sWOWORKDOC       = string.Empty;
            string sWOIMMEDTEXT     = string.Empty;
            string sWOCANCELCOMMENT = string.Empty;
            string sGUBUN           = string.Empty;
            string sFINISH          = string.Empty;
            string sREAPPROVAL      = string.Empty;
            string sRECOUNT         = string.Empty;
            string sWOCHANGEWKDIV   = string.Empty;

            string sLine = string.Empty;
            string sUrl  = string.Empty;

            string sREDOCID = string.Empty;
            string sREDOCNUM = string.Empty;
            string sRESABUN = string.Empty;

            DataSet ds    = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt  = new DataTable();
            DataRow row;

            sAPNUM           = ht["P_APNUM"].ToString();
            sSENDER          = ht["P_SENDER"].ToString();
            sRECEIVER        = ht["P_RECEIVER"].ToString();
            sPGURL           = ht["P_PGURL"].ToString();
            sTITLE           = ht["P_TITLE"].ToString();
            sWOWORKTITLE     = ht["P_WOWORKTITLE"].ToString();
            sWOWORKDOC       = ht["P_WOWORKDOC"].ToString();
            sWOIMMEDTEXT     = ht["P_WOIMMEDTEXT"].ToString();
            sWOCANCELCOMMENT = ht["P_WOCANCELCOMMENT"].ToString();
            sGUBUN           = ht["P_GUBUN"].ToString();

            sFINISH          = ht["P_FINISH"].ToString();
            sREAPPROVAL      = ht["P_REAPPROVAL"].ToString();
            sRECOUNT         = ht["P_RECOUNT"].ToString();
            sWOCHANGEWKDIV   = ht["P_WOCHANGEWKDIV"].ToString();

            int i = 0;

            try
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    // 수신자 메일 계정 가져오기
                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_RECEIVER"].ToString());

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";

                            //    if (i == 0)
                            //    {
                            //        sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //    }
                            //    else
                            //    {
                            //        sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //    }
                            //}

                            sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&ID=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&LINKURL=" + sPGURL;

                            MailMessage mess = new MailMessage();

                            // 결재자 메일 주소 가져오기
                            mess.From = sSENDER.ToString() + "@taeyoung.co.kr";
                            mess.To = sMailTo.ToString();

                            mess.Subject = "[" + sTITLE + "]";

                            try
                            {
                                sLine = "";
                                sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
                                sLine += "<HTML>";
                                sLine += "<HEAD>";
                                sLine += "<TITLE> New Document </TITLE>";
                                sLine += "<style type='text/css'>";
                                sLine += "<!-- /* Global Css */ ";
                                sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
                                sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
                                sLine += "img{border:none} --> </style> ";
                                sLine += "<script language='javascript'>";
                                sLine += " function AppPageLink() { ";
                                sLine += "    document.frm.submit(); ";
                                sLine += "  }";
                                sLine += "</script>";
                                sLine += "</HEAD>";
                                sLine += "<BODY>";
                                sLine += "<FORM name='frm' method='post'  action='http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx'> ";
                                sLine += "<input  type='hidden'  NAME='ACTION'  TYPE='text' VALUE='APPPAGE'>";
                                sLine += "<input  type='hidden'  NAME='SABUN' type='text' value='" + sRECEIVER.ToString() + "'>";
                                sLine += "<input  type='hidden'  NAME='ID'   type='text' value='" + sRECEIVER.ToString() + "'>";
                                sLine += "<input  type='hidden'  NAME='LINKURL' type='text' value= " + sPGURL.ToString() + ">";
                                sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
                                sLine += "    <tbody> ";
                                sLine += "        <tr> ";
                                sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 작업요청서 </th> ";
                                sLine += "                <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                                sLine += "                    <a href='" + sUrl + "'&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                                //sLine += "                    <a onclick = window.open('" + sUrl + "','문서보기','width=1200,height=1000')> ";
                                sLine += "                    <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                                sLine += "                </td> ";
                                sLine += "            </tr> ";
                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";
                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업명 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKTITLE.ToString() + " </td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";
                                if (int.Parse(Get_Numeric(sREAPPROVAL.ToString())) == int.Parse(Get_Numeric(sRECOUNT.ToString())))
                                {
                                    if (sFINISH != "FINISH")
                                    {
                                        sLine += "        <tr> ";
                                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 다음작업 </th> ";
                                        if (sWOCHANGEWKDIV == "1")
                                        {
                                            sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> 작업허가서 작업을 진행하시기 바랍니다. </td> ";
                                        }
                                        else
                                        {
                                            sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> 변경요구서 작업을 진행하시기 바랍니다. </td> ";
                                        }
                                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                        sLine += "        </tr> ";
                                    }
                                }

                                if (sWOWORKDOC != "")
                                {
                                    sLine += "        <tr> ";
                                    sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
                                    sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKDOC.Replace("\n", "<br>") + " </td> ";
                                    sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                    sLine += "        </tr> ";
                                }

                                if (sFINISH == "FINISH")
                                {
                                    sLine += "        <tr> ";
                                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치내용 </th> ";
                                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOIMMEDTEXT.ToString() + " </td> ";
                                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                    sLine += "        </tr> ";
                                }

                                if (sFINISH == "CANCEL")
                                {
                                    sLine += "        <tr> ";
                                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 취소사유 </th> ";
                                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOCANCELCOMMENT.ToString() + " </td> ";
                                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                    sLine += "        </tr> ";
                                }
                                sLine += "        <tr> ";
                                sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
                                sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
                                sLine += "            </th> ";
                                sLine += "        </tr> ";
                                sLine += "    </tbody> ";
                                sLine += "</table> ";
                                sLine += "</form>";
                                sLine += "</BODY>";
                                sLine += "</HTML> ";

                                mess.Body = sLine;
                                mess.BodyFormat = MailFormat.Html;

                                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                                // 메일 발송
                                SmtpMail.Send(mess);
                            }
                            catch
                            {
                                row = dt.NewRow();
                                row["STATE"] = "ERR";
                                row["MSG"] = "메일 송신 오류 발생";
                                dt.Rows.Add(row);
                                ds.Tables.Add(dt);

                                return ds;
                            }
                        }
                    }
                    else
                    {
                        row = dt.NewRow();
                        row["STATE"] = "ERR";
                        row["MSG"] = "메일 송신 오류 발생";
                        dt.Rows.Add(row);
                        ds.Tables.Add(dt);
                    }
                }

                if (int.Parse(Set_Fill3(ht["P_SOCOUNT"].ToString())) == int.Parse(Set_Fill3(ht["P_SOAPPROVAL"].ToString())))
                {
                    if (int.Parse(Set_Fill3(ht["P_REAPPROVAL"].ToString())) == 0)
                    {
                        // 참조자 메일 발송
                        UP_Mail_Reference_Send(ht["P_APNUM"].ToString(),
                                               ht["P_WOORTEAM"].ToString(),
                                               Get_Date(ht["P_WOORDATE"].ToString()),
                                               Set_Fill3(ht["P_WOSEQ"].ToString()),
                                               ht["P_WOWORKTITLE"].ToString(),
                                               "",
                                               "",
                                               "",
                                               ht["P_WOWORKDOC"].ToString(),
                                               Document.UserInfo.EmpID,
                                               ""
                                               );
                            
                    }
                }
            }
            catch(Exception ex)
            {
                string sMsg = string.Empty;

                sMsg = ex.ToString();

                sMsg = ex.ToString();
            }

            return ds;
        }
        #endregion

        #region Description : 작업요청 결재철회 메일 발송
        private DataSet UP_RETRACT_Mail_Send(Hashtable ht)
        {
            string sMailFrom        = string.Empty;
            string sMailTo          = string.Empty;

            string sAPNUM           = string.Empty;
            string sSENDER          = string.Empty;
            string sTITLE           = string.Empty;
            string sWOWORKTITLE     = string.Empty;
            string sRETRACTCOMMENT  = string.Empty;

            string sWOORTEAM = string.Empty;
            string sWOORDATE = string.Empty;
            string sWOSEQ    = string.Empty;




            string sLine  = string.Empty;

            DataSet ds    = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt  = new DataTable();
            DataRow row;


            sWOORTEAM       = ht["P_WOORTEAM"].ToString();
            sWOORDATE       = ht["P_WOORDATE"].ToString();
            sWOSEQ          = ht["P_WOSEQ"].ToString();

            sAPNUM          = ht["P_APNUM"].ToString();
            sWOWORKTITLE    = ht["P_WOWORKTITLE"].ToString();
            sSENDER         = ht["P_SENDER"].ToString();
            sRETRACTCOMMENT = ht["P_RTCOMMENT"].ToString();

            int i = 0;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 수신자 메일 계정 가져오기
                dbCon.AddParameters("P_WOORTEAM", DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, ht["P_WOSEQ"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_GET_SOSABUN");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"] = "";
                    dt.Rows.Add(row);
                    retds.Tables.Add(dt);

                    for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                        }
                        else
                        {
                            sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                        }
                    }

                    MailMessage mess = new MailMessage();

                    // 발신자 메일 주소 가져오기
                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SENDER"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sSENDER = ds.Tables[0].Rows[0]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                    }

                    mess.From = sSENDER.ToString();
                    mess.To = sMailTo.ToString();

                    sTITLE = "결재철회/작업요청서 - " + sWOWORKTITLE.ToString();

                    mess.Subject = "[" + sTITLE + "]";

                    try
                    {

                        sLine = "";
                        sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
                        sLine += "<HTML>";
                        sLine += "<HEAD>";
                        sLine += "<TITLE> New Document </TITLE>";
                        sLine += "<style type='text/css'>";
                        sLine += "<!-- /* Global Css */ ";
                        sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
                        sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
                        sLine += "img{border:none} --> </style> ";
                        sLine += "<script language='javascript'>";
                        sLine += " function AppPageLink() { ";
                        sLine += "    document.frm.submit(); ";
                        sLine += "  }";
                        sLine += "</script>";
                        sLine += "</HEAD>";
                        sLine += "<BODY>";
                        sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
                        sLine += "    <tbody> ";
                        sLine += "        <tr> ";
                        sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 작업요청서 </th> ";
                        sLine += "                <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                        sLine += "                    <a href=''&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                        //sLine += "                    <a onclick = window.open('','문서보기','width=920,height=1000')> ";
                        sLine += "                    <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                        sLine += "                </td> ";
                        sLine += "            </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                        sLine += "        </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작 업 명 </th> ";
                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sWOWORKTITLE.ToString() + " </td> ";
                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                        sLine += "        </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 철회의견 </th> ";
                        sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sRETRACTCOMMENT.ToString() + "</td> ";
                        sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                        sLine += "        </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
                        sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
                        sLine += "            </th> ";
                        sLine += "        </tr> ";
                        sLine += "    </tbody> ";
                        sLine += "</table> ";
                        sLine += "</form>";
                        sLine += "</BODY>";
                        sLine += "</HTML> ";

                        mess.Body = sLine;
                        mess.BodyFormat = MailFormat.Html;

                        SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                        // 메일 발송
                        SmtpMail.Send(mess);
                    }
                    catch
                    {
                        return retds;
                    }
                }
                else
                {
                    row = dt.NewRow();
                    row["STATE"] = "ERR";
                    row["MSG"] = "메일 송신 오류 발생";
                    dt.Rows.Add(row);
                    retds.Tables.Add(dt);
                }
            }

            return retds;
        }
        #endregion






        #region Description : 작업요청서 결재 및 저장시 필드 체크
        public DataSet UP_FIELDCHECK(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORSABUN", DbType.String, ht["P_WOORSABUN"]);
                dbCon.AddParameters("P_DATE",      DbType.String, ht["P_DATE"]);
                dbCon.AddParameters("P_WOSOTEAM",  DbType.String, ht["P_WOSOTEAM"]);
                dbCon.AddParameters("P_WORETEAM",  DbType.String, ht["P_WORETEAM"]);
                dbCon.AddParameters("P_WOPONUM1",  DbType.String, ht["P_WOPONUM1"]);
                dbCon.AddParameters("P_WOPONUM2",  DbType.String, ht["P_WOPONUM2"]);
                dbCon.AddParameters("P_WOPONUM3",  DbType.String, ht["P_WOPONUM3"]);
                dbCon.AddParameters("P_WOPONUM4",  DbType.String, ht["P_WOPONUM4"]);
                dbCon.AddParameters("P_WOPONUM5",  DbType.String, ht["P_WOPONUM5"]);
                dbCon.AddParameters("P_FXCCODE1",  DbType.String, ht["P_FXCCODE1"]);
                dbCon.AddParameters("P_FXCCODE2",  DbType.String, ht["P_FXCCODE2"]);
                dbCon.AddParameters("P_FXCCODE3",  DbType.String, ht["P_FXCCODE3"]);
                dbCon.AddParameters("P_FXCCODE4",  DbType.String, ht["P_FXCCODE4"]);
                dbCon.AddParameters("P_FXCCODE5",  DbType.String, ht["P_FXCCODE5"]);
                dbCon.AddParameters("P_L3CODE1",   DbType.String, ht["P_L3CODE1"]);
                dbCon.AddParameters("P_L3CODE2",   DbType.String, ht["P_L3CODE2"]);
                dbCon.AddParameters("P_L3CODE3",   DbType.String, ht["P_L3CODE3"]);
                dbCon.AddParameters("P_L3CODE4",   DbType.String, ht["P_L3CODE4"]);
                dbCon.AddParameters("P_L3CODE5",   DbType.String, ht["P_L3CODE5"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_FIELDCHECK");
            }
        }
        #endregion

        #region Description : 위험성 평가 및 안잔작업허가서 존재 체크
        public string UP_Chk_Risk_Master(Hashtable ht)
        {
            string sMSG = string.Empty;
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_TEAM", DbType.String, ht["P_WOORTEAM"].ToString());
                dbCon.AddParameters("P_DATE", DbType.String, ht["P_WOORDATE"].ToString());
                dbCon.AddParameters("P_SEQ",  DbType.String, ht["P_WOSEQ"].ToString());

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_AFTER_CHECK");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (ds.Tables[0].Rows[i]["GUBUN"].ToString() == "1")
                        {
                            sMSG = "위험성평가 자료가 존재하므로 삭제가 불가합니다.";
                            break;
                        }
                        else
                        {
                            sMSG = "안전 작업허가서 자료가 존재하므로 삭제가 불가합니다.";
                            break;
                        }
                    }
                }
            }

            return sMSG;
        }
        #endregion



        #region Description : 작업요청서 출력
        public DataSet UP_WORKORDER_PRT(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, ht["P_WOSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_PRT");
            }
        }
        #endregion



        #region Description : 공통
        public DataSet UP_Get_Ds_Common(Hashtable ht)
        {
            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                DataSet retDs = new DataSet();
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                DataRow row;

                if (ht["P_GUBUN"].ToString() == "INDEX")
                {
                    dt.Columns.Add("LOGINBUSEO", typeof(System.String));
                    dt.Columns.Add("NOWSOBUSEO", typeof(System.String));
                    dt.Columns.Add("NOWREBUSEO", typeof(System.String));

                    dt.Columns.Add("RESABUN", typeof(System.String));
                    dt.Columns.Add("RENAME", typeof(System.String));
                    dt.Columns.Add("RISKCHK", typeof(System.String));

                    row = dt.NewRow();

                    // 로그인 사번
                    if (ht["P_LoginSABUN"].ToString() != "")
                    {
                        db2.AddParameters("P_DATE", DbType.String, ht["P_DATE"]);
                        db2.AddParameters("P_KBSABUN", DbType.String, ht["P_LoginSABUN"]);

                        ds = db2.ExcuteDataSet("PSSCMLIB.PSM_SABUN_GET_BUSEO");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            row["LOGINBUSEO"] = ds.Tables[0].Rows[0]["KBBUSEO"].ToString();
                        }
                    }

                    if (ht["P_GUBN"].ToString() == "WK")
                    {
                        // 현재 요청 결재할 사람의 부서코드
                        if (ht["P_NOWSOSABUN"].ToString() != "")
                        {
                            db2.AddParameters("P_DATE", DbType.String, ht["P_DATE"]);
                            db2.AddParameters("P_KBSABUN", DbType.String, ht["P_NOWSOSABUN"]);

                            ds = db2.ExcuteDataSet("PSSCMLIB.PSM_SABUN_GET_BUSEO");

                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                row["NOWSOBUSEO"] = ds.Tables[0].Rows[0]["KBBUSEO"].ToString();
                            }
                        }

                        // 현재 수신 결재할 사람의 부서코드
                        if (ht["P_NOWRESABUN"].ToString() != "")
                        {
                            db2.AddParameters("P_DATE", DbType.String, ht["P_DATE"]);
                            db2.AddParameters("P_KBSABUN", DbType.String, ht["P_NOWRESABUN"]);

                            ds = db2.ExcuteDataSet("PSSCMLIB.PSM_SABUN_GET_BUSEO");

                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                row["NOWREBUSEO"] = ds.Tables[0].Rows[0]["KBBUSEO"].ToString();
                            }
                        }
                    }

                    // 참조자
                    if (ht["P_REDOCID"].ToString() != "")
                    {
                        db2.AddParameters("P_REDOCID", DbType.String, ht["P_REDOCID"]);
                        db2.AddParameters("P_REDOCNUM", DbType.String, ht["P_REDOCNUM"]);

                        ds = db2.ExcuteDataSet("PSSCMLIB.PSM_REFERENCE_LIST");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            row["RESABUN"] = ds.Tables[0].Rows[0]["RESABUN"].ToString();
                            row["RENAME"]  = ds.Tables[0].Rows[0]["RENAME"].ToString();
                        }
                    }

                    dt.Rows.Add(row);
                    retDs.Tables.Add(dt);
                }

                return retDs;
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

        protected string Get_Date(string sStr)
        {
            if (sStr == "") return "";
            else return sStr.Replace("-", "");
        }

            protected string Get_Numeric(string sStr)
            {
                if (sStr == "") return "0";
                else return sStr.Replace(",", "");
            }
        }
}