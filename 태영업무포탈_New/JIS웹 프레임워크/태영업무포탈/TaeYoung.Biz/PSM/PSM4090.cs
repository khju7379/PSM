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
    public class PSM4090 : BizBase
    {
        #region Description : 작업요청관리(변경) 조회
        public DataSet UP_GET_WORKORDER_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_STDATE", DbType.String, ht["P_STDATE"]);
                dbCon.AddParameters("P_EDDATE", DbType.String, ht["P_EDDATE"]);
                dbCon.AddParameters("P_WKSAUP", DbType.String, ht["P_WKSAUP"]);
                dbCon.AddParameters("P_WKTEAM", DbType.String, ht["P_WKTEAM"]);
                dbCon.AddParameters("P_DEPT", DbType.String, ht["P_DEPT"]);
                dbCon.AddParameters("P_ORSABUN", DbType.String, ht["P_ORSABUN"]);
                dbCon.AddParameters("P_TITLE", DbType.String, ht["P_TITLE"]);
                dbCon.AddParameters("P_STATUS", DbType.String, ht["P_STATUS"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4090_WORKORDER_LIST");
            }
        }
        #endregion

        #region Description : 가동전 점검 리스트 조회
        public DataSet UP_GET_EXAM_CHECK_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PECWOTEAM", DbType.String, ht["P_PECWOTEAM"]);
                dbCon.AddParameters("P_PECWODATE", DbType.String, ht["P_PECWODATE"]);
                dbCon.AddParameters("P_PECWOSEQ", DbType.VarNumeric, ht["P_PECWOSEQ"]);
                dbCon.AddParameters("P_PECSGUBUN", DbType.String, ht["P_PECSGUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4070_EXAM_CHECK_LIST");
            }
        }
        #endregion

        

        #region Description : 감동전 점검표 내역 조회
        public DataSet UP_GET_EXAM_CHECK_DETAIL_LIST(Hashtable ht)
        {

            DataSet ds = new DataSet();

            if (ht["P_WKGUBUN"].ToString() == "NEW")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PECCGUBUN", DbType.String, ht["P_PECCGUBUN"]);
                    dbCon.AddParameters("P_PECCDATE", DbType.String, ht["P_PECCDATE"]);
                    dbCon.AddParameters("P_PECCSEQ", DbType.VarNumeric, ht["P_PECCSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_CONTENTS_LIST");
                }
            }
            else
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PECDTCTEAM", DbType.String, ht["P_PECDTCTEAM"]);
                    dbCon.AddParameters("P_PECDTCDATE", DbType.String, ht["P_PECDTCDATE"]);
                    dbCon.AddParameters("P_PECDTCSEQ", DbType.VarNumeric, ht["P_PECDTCSEQ"]);
                    dbCon.AddParameters("P_PECDGUBUN", DbType.String, ht["P_PECDGUBUN"]);
                    dbCon.AddParameters("P_PECDDATE", DbType.String, ht["P_PECDDATE"]);
                    dbCon.AddParameters("P_PECDSEQ", DbType.VarNumeric, ht["P_PECDSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_DETAIL_LIST");
                }
            }

            return ds;
        }
        #endregion

        #region Description : 가동전 점검표 출력
        public DataSet UP_EXAM_CHECK_PRT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);
                dbCon.AddParameters("P_PECSEQ", DbType.VarNumeric, ht["P_PECSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4091_EXAM_CHECK_PRT");
            }
        }
        #endregion

        #region Description : 가동전 점검표 확인
        public DataSet UP_EXAM_CHECK_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);
                dbCon.AddParameters("P_PECSEQ", DbType.VarNumeric, ht["P_PECSEQ"]);
                //dbCon.AddParameters("P_PECWOTEAM", DbType.String, ht["P_PECWOTEAM"]);
                //dbCon.AddParameters("P_PECWODATE", DbType.String, ht["P_PECWODATE"]);
                //dbCon.AddParameters("P_PECWOSEQ", DbType.VarNumeric, ht["P_PECWOSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_RUN");
            }
        }
        #endregion

        #region Description : 가동전 점검표 마스타 등록
        public DataSet UP_EXAM_CHECK_ADD(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (ht["P_PECSEQ"].ToString() == "")
            {
                // 순번 가져오기
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                    dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ht["P_PECSEQ"] = ds.Tables[0].Rows[0]["PECSEQ"].ToString();
                    }
                }
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);
                dbCon.AddParameters("P_PECSEQ", DbType.String, ht["P_PECSEQ"]);

                dbCon.AddParameters("P_PECWOTEAM", DbType.String, ht["P_PECWOTEAM"]);
                dbCon.AddParameters("P_PECWODATE", DbType.String, ht["P_PECWODATE"]);
                dbCon.AddParameters("P_PECWOSEQ", DbType.String, ht["P_PECWOSEQ"]);

                dbCon.AddParameters("P_PECTITLE", DbType.String, ht["P_PECTITLE"]);
                dbCon.AddParameters("P_PECINSDATE", DbType.String, ht["P_PECINSDATE"]);

                dbCon.AddParameters("P_PECSGUBUN", DbType.String, ht["P_PECSGUBUN"]);
                dbCon.AddParameters("P_PECSDATE", DbType.String, ht["P_PECSDATE"]);
                dbCon.AddParameters("P_PECSSEQ", DbType.String, ht["P_PECSSEQ"]);

                dbCon.AddParameters("P_PECTANKNO", DbType.String, ht["P_PECTANKNO"]);
                dbCon.AddParameters("P_PECFAULTNM", DbType.String, ht["P_PECFAULTNM"]);
                dbCon.AddParameters("P_PECIMPROVE", DbType.String, ht["P_PECIMPROVE"]);

                dbCon.AddParameters("P_PECJKCD1", DbType.String, ht["P_PECJKCD1"]);
                dbCon.AddParameters("P_PECJKCDNM1", DbType.String, ht["P_PECJKCDNM1"]);
                dbCon.AddParameters("P_PECNAME1", DbType.String, ht["P_PECNAME1"]);
                dbCon.AddParameters("P_PECSABUN1", DbType.String, ht["P_PECSABUN1"]);
                dbCon.AddParameters("P_PECCOMMENT1", DbType.String, ht["P_PECCOMMENT1"]);

                dbCon.AddParameters("P_PECJKCD2", DbType.String, ht["P_PECJKCD2"]);
                dbCon.AddParameters("P_PECJKCDNM2", DbType.String, ht["P_PECJKCDNM2"]);
                dbCon.AddParameters("P_PECNAME2", DbType.String, ht["P_PECNAME2"]);
                dbCon.AddParameters("P_PECSABUN2", DbType.String, ht["P_PECSABUN2"]);
                dbCon.AddParameters("P_PECCOMMENT2", DbType.String, ht["P_PECCOMMENT2"]);

                dbCon.AddParameters("P_PECJKCD3", DbType.String, ht["P_PECJKCD3"]);
                dbCon.AddParameters("P_PECJKCDNM3", DbType.String, ht["P_PECJKCDNM3"]);
                dbCon.AddParameters("P_PECNAME3", DbType.String, ht["P_PECNAME3"]);
                dbCon.AddParameters("P_PECSABUN3", DbType.String, ht["P_PECSABUN3"]);
                dbCon.AddParameters("P_PECCOMMENT3", DbType.String, ht["P_PECCOMMENT3"]);

                dbCon.AddParameters("P_PECJKCD4", DbType.String, ht["P_PECJKCD4"]);
                dbCon.AddParameters("P_PECJKCDNM4", DbType.String, ht["P_PECJKCDNM4"]);
                dbCon.AddParameters("P_PECNAME4", DbType.String, ht["P_PECNAME4"]);
                dbCon.AddParameters("P_PECSABUN4", DbType.String, ht["P_PECSABUN4"]);
                dbCon.AddParameters("P_PECCOMMENT4", DbType.String, ht["P_PECCOMMENT4"]);

                dbCon.AddParameters("P_PECJKCD5", DbType.String, ht["P_PECJKCD5"]);
                dbCon.AddParameters("P_PECJKCDNM5", DbType.String, ht["P_PECJKCDNM5"]);
                dbCon.AddParameters("P_PECNAME5", DbType.String, ht["P_PECNAME5"]);
                dbCon.AddParameters("P_PECSABUN5", DbType.String, ht["P_PECSABUN5"]);
                dbCon.AddParameters("P_PECCOMMENT5", DbType.String, ht["P_PECCOMMENT5"]);

                dbCon.AddParameters("P_PECJKCD6", DbType.String, ht["P_PECJKCD6"]);
                dbCon.AddParameters("P_PECJKCDNM6", DbType.String, ht["P_PECJKCDNM6"]);
                dbCon.AddParameters("P_PECNAME6", DbType.String, ht["P_PECNAME6"]);
                dbCon.AddParameters("P_PECSABUN6", DbType.String, ht["P_PECSABUN6"]);
                dbCon.AddParameters("P_PECCOMMENT6", DbType.String, ht["P_PECCOMMENT6"]);

                dbCon.AddParameters("P_PECHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_COUNT", DbType.String, ht["P_COUNT"]);
                dbCon.AddParameters("P_APPROVAL", DbType.String, ht["P_APPROVAL"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["P_GUBUN"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_APPROVAL");

                if (ht["P_GUBUN"].ToString() == "APPROVAL")
                {
                    UP_WORKORDER_WOSTATUS_UPT(ht);
                }

                ds = new DataSet();

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = ht["P_PECSEQ"];
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : 가동전 점검표 내역 등록
        public DataSet UP_EXAM_CHECK_DETAIL_ADD(Hashtable ht, Hashtable[] hts)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (hts.Length > 0)
            {
                // 점검표 번호가 변경될 수 있으므로 이전 점검표 내역 삭제 후 재 등록
                if (hts[0]["P_GUBUN"].ToString() == "A")
                {
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        dbCon.AddParameters("P_PECDTCTEAM", DbType.String, hts[0]["P_PECDTCTEAM"]);
                        dbCon.AddParameters("P_PECDTCDATE", DbType.String, hts[0]["P_PECDTCDATE"]);
                        dbCon.AddParameters("P_PECDTCSEQ", DbType.VarNumeric, hts[0]["P_PECDTCSEQ"]);
                        dbCon.AddParameters("P_PECDGUBUN", DbType.String, hts[0]["P_PECDGUBUN"]);
                        dbCon.AddParameters("P_PECDDATE", DbType.String, hts[0]["P_PECDDATE"]);
                        dbCon.AddParameters("P_PECDSEQ", DbType.VarNumeric, hts[0]["P_PECDSEQ"]);

                        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_DETAIL_DEL");
                    }
                }
            }

            // 등록
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_PECDTCTEAM", DbType.String, hts[i]["P_PECDTCTEAM"]);
                    dbCon.AddParameters("P_PECDTCDATE", DbType.String, hts[i]["P_PECDTCDATE"]);
                    dbCon.AddParameters("P_PECDTCSEQ", DbType.VarNumeric, hts[i]["P_PECDTCSEQ"]);
                    dbCon.AddParameters("P_PECDGUBUN", DbType.String, hts[i]["P_PECDGUBUN"]);
                    dbCon.AddParameters("P_PECDDATE", DbType.String, hts[i]["P_PECDDATE"]);
                    dbCon.AddParameters("P_PECDSEQ", DbType.VarNumeric, hts[i]["P_PECDSEQ"]);
                    dbCon.AddParameters("P_PECDNUM", DbType.VarNumeric, hts[i]["P_PECDNUM"]);
                    dbCon.AddParameters("P_PECDDESC", DbType.String, hts[i]["P_PECDDESC"]);
                    dbCon.AddParameters("P_PECDCHECK", DbType.String, hts[i]["P_PECDCHECK"]);
                    dbCon.AddParameters("P_PECDHISAB", DbType.String, Document.UserInfo.EmpID);
                    dbCon.AddParameters("P_GUBUN", DbType.String, hts[i]["P_GUBUN"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_DETAIL_ADD");
                }

                ds = new DataSet();

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : 가동전 점검표 삭제
        public void UP_EXAM_CHECK_DEL(Hashtable ht)
        {
            // 삭제
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);
                dbCon.AddParameters("P_PECSEQ", DbType.VarNumeric, ht["P_PECSEQ"]);
                dbCon.AddParameters("P_PECDGUBUN", DbType.String, ht["P_PECDGUBUN"]);
                dbCon.AddParameters("P_PECDDATE", DbType.String, ht["P_PECDDATE"]);
                dbCon.AddParameters("P_PECDSEQ", DbType.VarNumeric, ht["P_PECDSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_DEL");
            }
        }
        #endregion

        #region Description : 가동전 점검 반려
        public DataSet UP_EXAM_CHECK_CANCEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            try
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                    dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);
                    dbCon.AddParameters("P_PECSEQ", DbType.VarNumeric, ht["P_PECSEQ"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4073_EXAM_CHECK_CANCEL");

                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"] = "";
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

        #region Description : 가동전 점검 철회
        public DataSet UP_EXAM_CHECK_RETRACT(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            try
            {
                dt.Columns.Add("STATE", typeof(System.String));
                dt.Columns.Add("MSG", typeof(System.String));

                // 결재철회 메일 발송
                UP_RETRACT_Mail_Send(ht);

                // 가동전점검 취소
                ds = UP_EXAM_CHECK_CANCEL(ht);

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);

            }
            catch (Exception ex)
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

        #region Description : 작업요청 작업완료 업데이트
        public DataSet UP_WORKORDER_FINISH_UPT(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOFINISHDATE", DbType.String, ht["P_WOFINISHDATE"]);
                dbCon.AddParameters("P_WOFINISHSABUN", DbType.String, ht["P_WOFINISHSABUN"]);
                dbCon.AddParameters("P_WOFINISHTEXT", DbType.String, ht["P_WOFINISHTEXT"]);
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_WORKORDER_FINISH_UPT");

                UP_WORKORDER_WOSTATUS_UPT(ht);
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOFINISHDATE", DbType.String, ht["P_WOFINISHDATE"]);
                dbCon.AddParameters("P_WOFINISHTIME", DbType.String, ht["P_WOFINISHTIME"]);
                dbCon.AddParameters("P_WOFINISHSABUN", DbType.String, ht["P_WOFINISHSABUN"]);
                dbCon.AddParameters("P_WOFINISHTEXT", DbType.String, ht["P_WOFINISHTEXT"]);
                dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String, ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_SAFEORDER_FINISH_UPT");
            }

            row = dt.NewRow();
            row["STATE"] = "OK";
            row["MSG"] = "";
            dt.Rows.Add(row);
            retds.Tables.Add(dt);

            // 작업요청서 요청자,수신자 메일 발송
            UP_Mail_WK_Send(ht["P_WOORTEAM"].ToString(), Get_Date(ht["P_WOORDATE"].ToString()), Set_Fill3(ht["P_WOSEQ"].ToString()),
                            ht["P_PECTEAM"].ToString(), ht["P_PECDATE"].ToString(), ht["P_PECSEQ"].ToString(), ht["P_PECTITLE"].ToString());



            return retds;
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

        #region Description : 점검요청 요청자 메일 발송
        public DataSet UP_Get_Mail_List(Hashtable ht)
        {
            string sMailFrom = string.Empty;
            string sMailTo = string.Empty;

            string sAPNUM = string.Empty;
            string sPECNUM = string.Empty;
            string sSENDER = string.Empty;
            string sRECEIVER = string.Empty;
            string sPGURL = string.Empty;
            string sTITLE = string.Empty;
            string sPECTITLE = string.Empty;
            string sPECCANCELCOMMENT = string.Empty;
            string sGUBUN = string.Empty;
            string sFINISH = string.Empty;

            string sLine = string.Empty;
            string sUrl = string.Empty;

            DataSet ds = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            sAPNUM = ht["P_APNUM"].ToString();
            sPECNUM = ht["P_PECNUM"].ToString();
            sSENDER = ht["P_SENDER"].ToString();
            sRECEIVER = ht["P_RECEIVER"].ToString();
            sPGURL = ht["P_PGURL"].ToString();
            sTITLE = ht["P_TITLE"].ToString();
            sPECTITLE = ht["P_PECTITLE"].ToString();
            sPECCANCELCOMMENT = ht["P_PECCANCELCOMMENT"].ToString();
            sGUBUN = ht["P_GUBUN"].ToString();
            sFINISH = ht["P_FINISH"].ToString();

            int i = 0;

            sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + sRECEIVER + "&ID=" + sRECEIVER + "&LINKURL=" + sPGURL;

            try
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    // 수신자 메일 계정 가져오기
                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_RECEIVER"]);

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
                            sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'>탱크 저장물질 변경 가동전 점검 </th> ";
                            sLine += "                <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                            //sLine += "                    <a onclick = window.open('" + sUrl + "','문서보기','width=920,height=1000')> ";
                            sLine += "                    <a href='" + sUrl + "'&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                            sLine += "                    <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                            sLine += "                </td> ";
                            sLine += "            </tr> ";
                            sLine += "        <tr> ";
                            sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                            sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                            sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                            sLine += "        </tr> ";
                            sLine += "        <tr> ";
                            sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 점검번호 </th> ";
                            sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sPECNUM.ToString() + "</td> ";
                            sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                            sLine += "        </tr> ";
                            sLine += "        <tr> ";
                            sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 변경저장 물질 </th> ";
                            sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sPECTITLE.ToString() + " </td> ";
                            sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                            sLine += "        </tr> ";

                            if (sFINISH == "FINISH")
                            {
                                //sLine += "        <tr> ";
                                //sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 조치내용 </th> ";
                                //sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sPECTITLE.ToString() + " </td> ";
                                //sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                //sLine += "        </tr> ";
                            }

                            if (sFINISH == "CANCEL")
                            {
                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 취소사유 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sPECCANCELCOMMENT.ToString() + " </td> ";
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
                    else
                    {
                        row = dt.NewRow();
                        row["STATE"] = "ERR";
                        row["MSG"] = "메일 송신 오류 발생";
                        dt.Rows.Add(row);
                        ds.Tables.Add(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                string sMsg = string.Empty;

                sMsg = ex.ToString();

                sMsg = ex.ToString();
            }

            return ds;
        }
        #endregion

        #region Description : 가동전 점검 결재철회 메일 발송
        private DataSet UP_RETRACT_Mail_Send(Hashtable ht)
        {
            string sMailFrom = string.Empty;
            string sMailTo = string.Empty;

            string sAPNUM = string.Empty;
            string sPECNUM = string.Empty;
            string sSENDER = string.Empty;
            string sTITLE = string.Empty;
            string sPECTITLE = string.Empty;
            string sRETRACTCOMMENT = string.Empty;

            string sLine = string.Empty;

            DataSet ds = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            sAPNUM = ht["P_APNUM"].ToString();
            sPECNUM = ht["P_PECNUM"].ToString();
            sPECTITLE = ht["P_PECTITLE"].ToString();
            sSENDER = ht["P_SENDER"].ToString();
            sRETRACTCOMMENT = ht["P_RTCOMMENT"].ToString();

            int i = 0;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 수신자 메일 계정 가져오기
                dbCon.AddParameters("P_PECTEAM", DbType.String, ht["P_PECTEAM"]);
                dbCon.AddParameters("P_PECDATE", DbType.String, ht["P_PECDATE"]);
                dbCon.AddParameters("P_PECSEQ", DbType.VarNumeric, ht["P_PECSEQ"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4073_GET_SABUN");

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

                    sTITLE = "[결재철회/탱크 저장물질 변경 가동전 점검] - " + sPECTITLE.ToString();

                    mess.Subject = sTITLE;

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
                        sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'>탱크 저장물질 변경 가동전 점검 </th> ";
                        sLine += "                <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                        //sLine += "                    <a onclick = window.open('','문서보기','width=920,height=1000')> ";
                        //sLine += "                    <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                        sLine += "                </td> ";
                        sLine += "            </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                        sLine += "        </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 점검번호 </th> ";
                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sPECNUM.ToString() + "</td> ";
                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                        sLine += "        </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 변경저장 물질 </th> ";
                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sPECTITLE.ToString() + " </td> ";
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

        #region Description : 작업요청 요청자 및 참조자포함 완료메일 발송
        private void UP_Mail_WK_Send(string sWOORTEAM, string sWOORDATE, string sWOSEQ,
                                     string sPECTEAM, string sPECDATE, string sPECSEQ, string sPECTITLE)
        {
            string sTitle = string.Empty;

            string sMailTo = string.Empty;
            string sKBSABUN = string.Empty;
            string sRESABUN = string.Empty;

            string sUrl = string.Empty;

            string sWOWORKTITLE = string.Empty;

            string sREDOCID = string.Empty;
            string sREDOCNUM = string.Empty;

            int i = 0;

            sREDOCID = "01";
            sREDOCNUM = sWOORTEAM.ToString() + Get_Date(sWOORDATE.ToString()) + Set_Fill3(sWOSEQ.ToString());
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 작업요청서 - 요청 및 수신결재사번
                dbCon.AddParameters("P_WOORTEAM", DbType.String, sWOORTEAM.ToString());
                dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(sWOORDATE.ToString()));
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(sWOSEQ.ToString()));

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sWOWORKTITLE = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
                }

                // 작업요청서 - 요청 및 수신결재사번
                dbCon.AddParameters("P_WOORTEAM", DbType.String, sWOORTEAM.ToString());
                dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(sWOORDATE.ToString()));
                dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(sWOSEQ.ToString()));

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            sKBSABUN = ds.Tables[0].Rows[i]["SABUN"].ToString();

                            //sRESABUN = ds.Tables[0].Rows[i]["SABUN"].ToString();
                        }
                        else
                        {
                            sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["SABUN"].ToString();
                        }
                    }

                    // 작업요청서 - 참조자
                    dbCon.AddParameters("P_REDOCID", DbType.String, sREDOCID);
                    dbCon.AddParameters("P_REDOCNUM", DbType.String, sREDOCNUM);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_REFERENCE_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            if (sKBSABUN.ToString() != "")
                            {
                                sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["RESABUN"].ToString();
                            }
                        }
                    }

                    // 요청번호
                    string sAPNUM = string.Empty;
                    sAPNUM = sWOORTEAM.ToString() + "-" + Get_Date(sWOORDATE.ToString()) + "-" + Set_Fill3(sWOSEQ.ToString());

                    // 점검번호
                    string sPECNUM = string.Empty;
                    sPECNUM = sPECTEAM.ToString() + "-" + Get_Date(sPECDATE.ToString()) + "-" + Set_Fill3(sPECSEQ.ToString());

                    string sPGURL = string.Empty;

                    sPGURL = "/Portal/PSM/PSM40/PSM4091.aspx?";
                    sPGURL = sPGURL + "param=UPT&param1=";
                    sPGURL = sPGURL + sAPNUM + "^" + sPECNUM;

                    // 요청결재자 메일 주소 가져오기
                    dbCon.AddParameters("P_KBSABUN", DbType.String, sKBSABUN.ToString());

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            //if (i == 0)
                            //{
                            sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            sRESABUN = ds.Tables[0].Rows[i]["KBSABUN"].ToString();
                            //}
                            //else
                            //{
                            //    sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //}


                            string sLine = "";

                            MailMessage mess = new MailMessage();

                            sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + sRESABUN + "&ID=" + sRESABUN + "&LINKURL=" + sPGURL;

                            // 결재자 메일 주소 가져오기
                            mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";
                            mess.To = sMailTo.ToString();

                            sTitle = sWOWORKTITLE.ToString() + " - 탱크 저장물질 변경 가동전 점검 완료";

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
                                sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'>탱크 저장물질 변경 가동전 점검 </th> ";
                                sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                                //sLine += "                  <a onclick = window.open('','문서보기','width=920,height=1000')> ";
                                sLine += "                    <a href='" + sUrl + "'&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                                sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                                sLine += "            </td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 점검번호 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sPECNUM.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";
                                sLine += "        <tr> ";

                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 변경저장 물질 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sPECTITLE.ToString() + " </td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

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
                    dt.Columns.Add("NOWBUSEO", typeof(System.String));

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
                        if (ht["P_NOWSABUN"].ToString() != "")
                        {
                            db2.AddParameters("P_DATE", DbType.String, ht["P_DATE"]);
                            db2.AddParameters("P_KBSABUN", DbType.String, ht["P_NOWSABUN"]);

                            ds = db2.ExcuteDataSet("PSSCMLIB.PSM_SABUN_GET_BUSEO");

                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                row["NOWBUSEO"] = ds.Tables[0].Rows[0]["KBBUSEO"].ToString();
                            }
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

        #region Description : 날짜형식변환
        protected string Get_Date(string sStr)
        {
            if (sStr == "") return "";
            else return sStr.Replace("-", "");
        }
        #endregion
    }
}
