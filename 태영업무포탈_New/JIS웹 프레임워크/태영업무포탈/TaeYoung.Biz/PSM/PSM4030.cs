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
    public class PSM4030 : BizBase
    {
        RemotePrint.SafeOrderService svc;

        #region Description : 변경 요구서 조회
        public DataSet UP_GET_CHANGEASK_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_STDATE",       DbType.String, ht["P_STDATE"]);
                dbCon.AddParameters("P_EDDATE",       DbType.String, ht["P_EDDATE"]);
                dbCon.AddParameters("P_WKSAUP",       DbType.String, ht["P_WKSAUP"]);
                dbCon.AddParameters("P_WKTEAM",       DbType.String, ht["P_WKTEAM"]);
                dbCon.AddParameters("P_DEPT",         DbType.String, ht["P_DEPT"]);
                dbCon.AddParameters("P_CAASKSABUN",   DbType.String, ht["P_CAASKSABUN"]);
                dbCon.AddParameters("P_CAASKCONTENT", DbType.String, ht["P_CAASKCONTENT"]);                

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4030_CHANGEASK_LIST");
            }
        }
        #endregion

        #region Description : 변경 검토서 조회
        public DataSet UP_GET_CHANGEREV_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRASKTEAM", DbType.String,     ht["P_CRASKTEAM"]);
                dbCon.AddParameters("P_CRASKDATE", DbType.String,     Get_Date(ht["P_CRASKDATE"].ToString()));
                dbCon.AddParameters("P_CRASKSEQ",  DbType.VarNumeric, Set_Fill3(ht["P_CRASKSEQ"].ToString()));

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4030_CHANGEREV_LIST");
            }
        }
        #endregion





        #region Description : 작업요청서 체크
        public DataSet UP_WORKORDER_CHECK(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOORTEAM", DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String,     Get_Date(ht["P_WOORDATE"].ToString()));
                dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, Set_Fill3(ht["P_WOSEQ"].ToString()));

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4020_WORKORDER_CHECK");
            }
        }
        #endregion

        #region Description : 작업요청서 진행상태 업데이트
        public DataSet UP_WORKORDER_WOSTATUS_UPT(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WOSTATUS", DbType.String,     ht["P_WOSTATUS"]);
                dbCon.AddParameters("P_WOORTEAM", DbType.String,     ht["P_WOORTEAM"]);
                dbCon.AddParameters("P_WOORDATE", DbType.String,     ht["P_WOORDATE"]);
                dbCon.AddParameters("P_WOSEQ",    DbType.VarNumeric, ht["P_WOSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_WORKORDER_WOSTATUS_UPT");

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = "";
                dt.Rows.Add(row);
                retds.Tables.Add(dt);
            }

            return retds;
        }
        #endregion





        #region Description : 변경검토서 확인
        public DataSet UP_CHANGEREV_RUN(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRREVTEAM", DbType.String,     ht["P_CRREVTEAM"]);
                dbCon.AddParameters("P_CRREVDATE", DbType.String,     Get_Date(ht["P_CRREVDATE"].ToString()));
                dbCon.AddParameters("P_CRREVSEQ",  DbType.VarNumeric, Set_Fill3(ht["P_CRREVSEQ"].ToString()));

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4031_CHANGEREV_RUN");
            }
        }
        #endregion


        #region Description : 변경검토서 결재 DISPLAY
        public DataSet UP_PSM4031_APPROVAL_DISPLAY(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRREVTEAM", DbType.String,     ht["P_CRREVTEAM"]);
                dbCon.AddParameters("P_CRREVDATE", DbType.String,     Get_Date(ht["P_CRREVDATE"].ToString()));
                dbCon.AddParameters("P_CRREVSEQ",  DbType.VarNumeric, Set_Fill3(ht["P_CRREVSEQ"].ToString()));

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4031_CHANGEREV_DOC_APP_DSP");
            }
        }
        #endregion

        #region Description : 변경검토서 순번 가져오기
        public DataSet UP_PSM4031_GET_MAX_SEQ(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRREVTEAM", DbType.String, ht["P_CRREVTEAM"]);
                dbCon.AddParameters("P_CRREVDATE", DbType.String, Get_Date(ht["P_CRREVDATE"].ToString()));

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4031_GET_MAX_SEQ");
            }
        }
        #endregion


        #region Description : 변경검토서 저장 및 결재
        public DataSet UP_CHANGEREV_DOC_APPROVAL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRREVTEAM",       DbType.String, ht["P_CRREVTEAM"]);
                dbCon.AddParameters("P_CRREVDATE",       DbType.String, Get_Date(ht["P_CRREVDATE"].ToString()));
                dbCon.AddParameters("P_CRREVSEQ",        DbType.VarNumeric, Set_Fill3(ht["P_CRREVSEQ"].ToString()));
                dbCon.AddParameters("P_CRASKTEAM",       DbType.String, ht["P_CRASKTEAM"]);
                dbCon.AddParameters("P_CRASKDATE",       DbType.String, Get_Date(ht["P_CRASKDATE"].ToString()));
                dbCon.AddParameters("P_CRASKSEQ",        DbType.VarNumeric, Set_Fill3(ht["P_CRASKSEQ"].ToString()));
                dbCon.AddParameters("P_CRWOTEAM",        DbType.String, ht["P_CRWOTEAM"]);
                dbCon.AddParameters("P_CRWODATE",        DbType.String, Get_Date(ht["P_CRWODATE"].ToString()));
                dbCon.AddParameters("P_CRWOSEQ",         DbType.VarNumeric, Set_Fill3(ht["P_CRWOSEQ"].ToString()));
                dbCon.AddParameters("P_CRREVCONTENT",    DbType.String, Convert.ToString(ht["P_CRREVCONTENT"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_CRREVDATA",       DbType.String, ht["P_CRREVDATA"]);
                dbCon.AddParameters("P_CRREVSUMMARY",    DbType.String, Convert.ToString(ht["P_CRREVSUMMARY"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_CRREVAPPROVAL",   DbType.String, ht["P_CRREVAPPROVAL"]);
                dbCon.AddParameters("P_CRREVREASION",    DbType.String, Convert.ToString(ht["P_CRREVREASION"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_CRREVSABUN1",     DbType.String, ht["P_CRREVSABUN1"]);
                dbCon.AddParameters("P_CRREVNAME1",      DbType.String, ht["P_CRREVNAME1"]);
                dbCon.AddParameters("P_CRREVJKCD1",      DbType.String, ht["P_CRREVJKCD1"]);
                dbCon.AddParameters("P_CRREVJKCDNM1",    DbType.String, ht["P_CRREVJKCDNM1"]);
                dbCon.AddParameters("P_CRREVCOMMENT1",   DbType.String, ht["P_CRREVCOMMENT1"]);
                dbCon.AddParameters("P_CRREVSABUN2",     DbType.String, ht["P_CRREVSABUN2"]);
                dbCon.AddParameters("P_CRREVNAME2",      DbType.String, ht["P_CRREVNAME2"]);
                dbCon.AddParameters("P_CRREVJKCD2",      DbType.String, ht["P_CRREVJKCD2"]);
                dbCon.AddParameters("P_CRREVJKCDNM2",    DbType.String, ht["P_CRREVJKCDNM2"]);
                dbCon.AddParameters("P_CRREVCOMMENT2",   DbType.String, ht["P_CRREVCOMMENT2"]);
                dbCon.AddParameters("P_CRREVSABUN3",     DbType.String, ht["P_CRREVSABUN3"]);
                dbCon.AddParameters("P_CRREVNAME3",      DbType.String, ht["P_CRREVNAME3"]);
                dbCon.AddParameters("P_CRREVJKCD3",      DbType.String, ht["P_CRREVJKCD3"]);
                dbCon.AddParameters("P_CRREVJKCDNM3",    DbType.String, ht["P_CRREVJKCDNM3"]);
                dbCon.AddParameters("P_CRREVCOMMENT3",   DbType.String, ht["P_CRREVCOMMENT3"]);
                dbCon.AddParameters("P_CRREVSABUN4",     DbType.String, ht["P_CRREVSABUN4"]);
                dbCon.AddParameters("P_CRREVNAME4",      DbType.String, ht["P_CRREVNAME4"]);
                dbCon.AddParameters("P_CRREVJKCD4",      DbType.String, ht["P_CRREVJKCD4"]);
                dbCon.AddParameters("P_CRREVJKCDNM4",    DbType.String, ht["P_CRREVJKCDNM4"]);
                dbCon.AddParameters("P_CRREVCOMMENT4",   DbType.String, ht["P_CRREVCOMMENT4"]);
                dbCon.AddParameters("P_CRREVSABUN5",     DbType.String, ht["P_CRREVSABUN5"]);
                dbCon.AddParameters("P_CRREVNAME5",      DbType.String, ht["P_CRREVNAME5"]);
                dbCon.AddParameters("P_CRREVJKCD5",      DbType.String, ht["P_CRREVJKCD5"]);
                dbCon.AddParameters("P_CRREVJKCDNM5",    DbType.String, ht["P_CRREVJKCDNM5"]);
                dbCon.AddParameters("P_CRREVCOMMENT5",   DbType.String, ht["P_CRREVCOMMENT5"]);
                dbCon.AddParameters("P_CRREVSABUN6",     DbType.String, ht["P_CRREVSABUN6"]);
                dbCon.AddParameters("P_CRREVNAME6",      DbType.String, ht["P_CRREVNAME6"]);
                dbCon.AddParameters("P_CRREVJKCD6",      DbType.String, ht["P_CRREVJKCD6"]);
                dbCon.AddParameters("P_CRREVJKCDNM6",    DbType.String, ht["P_CRREVJKCDNM6"]);
                dbCon.AddParameters("P_CRREVCOMMENT6",   DbType.String, ht["P_CRREVCOMMENT6"]);
                dbCon.AddParameters("P_CRREVHISAB",      DbType.String, ht["P_CRREVHISAB"]);
                dbCon.AddParameters("P_RESABUN",         DbType.String, ht["P_RESABUN"]);
                dbCon.AddParameters("P_RENAME",          DbType.String, ht["P_RENAME"]);
                dbCon.AddParameters("P_COUNT",           DbType.VarNumeric, ht["P_COUNT"]);
                dbCon.AddParameters("P_APPROVAL",        DbType.String, ht["P_APPROVAL"]);
                dbCon.AddParameters("P_GUBUN",           DbType.String, ht["P_GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4031_CHANGEREV_DOC_APPROVAL");
            }
        }
        #endregion

        #region Description : 변경검토서 삭제
        public DataSet UP_CHANGEREV_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 파일 삭제
                dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ht["P_ATTACH_TYPE"]);
                dbCon.AddParameters("P_ATTACH_NO",   DbType.String, ht["P_ATTACH_NO"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_ATTACHFILE_DEL");
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRREVTEAM", DbType.String,     ht["P_CRREVTEAM"]);
                dbCon.AddParameters("P_CRREVDATE", DbType.String,     Get_Date(ht["P_CRREVDATE"].ToString()));
                dbCon.AddParameters("P_CRREVSEQ",  DbType.VarNumeric, Set_Fill3(ht["P_CRREVSEQ"].ToString()));

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4031_CHANGEREV_DEL");

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion


        #region Description : 변경검토서 반려
        public DataSet UP_CHANGEREV_CANCEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG",   typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRREVTEAM", DbType.String,     ht["P_CRREVTEAM"]);
                dbCon.AddParameters("P_CRREVDATE", DbType.String,     Get_Date(ht["P_CRREVDATE"].ToString()));
                dbCon.AddParameters("P_CRREVSEQ",  DbType.VarNumeric, Set_Fill3(ht["P_CRREVSEQ"].ToString()));

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4031_CHANGEREV_CANCEL");

                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"]   = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : 변경검토서 철회
        public DataSet UP_CHANGEREV_RETRACT(Hashtable ht)
        {
            DataSet ds   = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            try
            {
                dt.Columns.Add("STATE", typeof(System.String));
                dt.Columns.Add("MSG",   typeof(System.String));
                
                // 결재철회 메일 발송
                UP_RETRACT_Mail_Send(ht);

                // 변경검토서 취소
                ds = UP_CHANGEREV_CANCEL(ht);

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


        //#region Description : 변경검토서 접수일자 업데이트
        //public DataSet UP_CHANGEREV_RECEIPT_UPT(Hashtable ht)
        //{
        //    DataSet ds = new DataSet();
        //    DataSet retds = new DataSet();
        //    DataTable dt = new DataTable();
        //    DataRow row;

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_CRREVTEAM", DbType.String,     ht["P_CRREVTEAM"]);
        //        dbCon.AddParameters("P_CRREVDATE", DbType.String,     Get_Date(ht["P_CRREVDATE"].ToString()));
        //        dbCon.AddParameters("P_CRREVSEQ",  DbType.VarNumeric, Set_Fill3(ht["P_CRREVSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4021_CHANGEREV_RECEIPT_UPT");
        //    }
        //}
        //#endregion

        #region Description : 메일 발송
        public DataSet UP_Get_Mail_List(Hashtable ht)
        {
            string sMailFrom   = string.Empty;
            string sMailTo     = string.Empty;

            string sAPNUM      = string.Empty;
            string sSENDER     = string.Empty;
            string sRECEIVER   = string.Empty;
            string sPGURL      = string.Empty;
            string sTITLE      = string.Empty;
            string sGUBUN      = string.Empty;
            string sFINISH     = string.Empty;
            string sCRREVCLASS = string.Empty;

            string sKBSABUN    = string.Empty;

            string sLine       = string.Empty;
            string sUrl        = string.Empty;

            string sGRPID      = string.Empty;

            string sCRREVCONTENT = string.Empty;
            string sCRREVSUMMARY = string.Empty;
            string sCRREVREASION = string.Empty;

            string sMail_To = string.Empty;


            DataSet ds    = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt  = new DataTable();
            DataRow row;

            sAPNUM        = ht["P_CRREVTEAM"].ToString() + "-" + Get_Date(ht["P_CRREVDATE"].ToString()) + "-" + Set_Fill3(ht["P_CRREVSEQ"].ToString());

            sSENDER       = ht["P_SENDER"].ToString();
            sRECEIVER     = ht["P_RECEIVER"].ToString();
            sPGURL        = ht["P_PGURL"].ToString();
            sTITLE        = ht["P_TITLE"].ToString();
            sCRREVCONTENT = ht["P_CRREVCONTENT"].ToString(); // 검토항목
            sCRREVSUMMARY = ht["P_CRREVSUMMARY"].ToString(); // 검토내용
            sCRREVREASION = ht["P_CRREVREASION"].ToString(); // 검토사유
            sGUBUN        = ht["P_GUBUN"].ToString();

            int i = 0;

            //sUrl = "http://localhost:8110/Portal/SitePostUrl.aspx?url=http://localhost:8110/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + sRECEIVER + "&ID=" + sRECEIVER + "&LINKURL=" + sPGURL;


            try
            {
                // 변경검토서 요청자 결재 전결 시 작업요청서 수신처 첫 결재자에게 메일 발송
                // (정상 = 3, 비상 = 4, 임시 = 5) 또는 화물(청소 포함 = 2)이면 작업위험평가를 작성하라고 메일 보냄
                // 화물(청소 미포함 = 1) 가동전 점검을 하라고 메일 보냄
                // 화물(청소포함 및 미포함)일 경우에는 운영팀에 메일 보냄

                if (ht["P_FINISH"].ToString() == "FINISH")
                {
                    if (ht["P_CAASKSTEPGN"].ToString() == "1" || ht["P_CAASKSTEPGN"].ToString() == "2")
                    {
                        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                        {
                            // 운영팀 허가자에게 메일발송(관리 전체)
                            sGRPID = "T_OPERA_MA";

                            dbCon.AddParameters("P_GRPID", DbType.String, sGRPID);

                            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_GRPID_LIST");

                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                                {
                                    if (i == 0)
                                    {
                                        if (sMailTo == "")
                                        {
                                            sMailTo = ds.Tables[0].Rows[i]["KBSABUN"].ToString();
                                        }
                                        else
                                        {
                                            sMailTo += "," + ds.Tables[0].Rows[i]["KBSABUN"].ToString();
                                        }
                                    }
                                    else
                                    {
                                        sMailTo += "," + ds.Tables[0].Rows[i]["KBSABUN"].ToString();
                                    }

                                    //if (i == 0)
                                    //{
                                    //    if (sMailTo == "")
                                    //    {
                                    //        sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                                    //    }
                                    //    else
                                    //    {
                                    //        sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                                    //    }
                                    //}
                                    //else
                                    //{
                                    //    sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                                    //}
                                }
                            }
                        }
                    }

                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        // 작업요청서의 수신처 첫 결재자 사번 가져오기
                        dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
                        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_WOORDATE"].ToString().Replace("-", "")));
                        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WOSEQ"].ToString()));

                        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4021_WORKORDER_RESABUN_RUN");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                if (i == 0)
                                {
                                    if (sMailTo == "")
                                    {
                                        sMailTo = ds.Tables[0].Rows[i]["KBSABUN"].ToString();
                                    }
                                    else
                                    {
                                        sMailTo += "," + ds.Tables[0].Rows[i]["KBSABUN"].ToString();
                                    }
                                }
                                else
                                {
                                    sMailTo += "," + ds.Tables[0].Rows[i]["KBSABUN"].ToString();
                                }

                                //if (i == 0)
                                //{
                                //    if (sMailTo == "")
                                //    {
                                //        sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                                //    }
                                //    else
                                //    {
                                //        sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                                //    }
                                //}
                                //else
                                //{
                                //    sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                                //}
                            }
                        }
                    }
                }

                if (sMailTo == "")
                {
                    sMailTo = ht["P_RECEIVER"].ToString();
                }
                else
                {
                    sMailTo += "," + ht["P_RECEIVER"].ToString();
                }

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    // 수신자 메일 계정 가져오기
                    dbCon.AddParameters("P_KBSABUN", DbType.String, sMailTo.ToString());

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            sMail_To = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";

                            //if (i == 0)
                            //{
                            //    if (sMailTo == "")
                            //    {
                            //        sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //    }
                            //    else
                            //    {
                            //        sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //    }
                            //}
                            //else
                            //{
                            //    sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
                            //}

                            sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&ID=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&LINKURL=" + sPGURL;

                            MailMessage mess = new MailMessage();

                            // 결재자 메일 주소 가져오기
                            mess.From = sSENDER.ToString() + "@taeyoung.co.kr";
                            mess.To = sMail_To.ToString();

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
                                sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 변경검토서 </th> ";
                                sLine += "                <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                                sLine += "                    <a href='" + sUrl + "'&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                                sLine += "                    <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                                sLine += "                </td> ";
                                sLine += "            </tr> ";
                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 변경검토번호 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";
                                sLine += "        <tr> ";
                                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 검토항목 </th> ";
                                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_CRREVCONTENT"].ToString().Replace("\n", "<br>") + " </td> ";
                                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                sLine += "        </tr> ";

                                // 검토내용
                                if (ht["P_CRREVSUMMARY"].ToString() != "")
                                {
                                    sLine += "        <tr> ";
                                    sLine += "            <th height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 검토내용 </th> ";
                                    sLine += "            <td height=300 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_CRREVSUMMARY"].ToString().Replace("\n", "<br>") + " </td> ";
                                    sLine += "            <td height=300 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                    sLine += "        </tr> ";
                                }

                                // 검토사유
                                if (ht["P_CRREVREASION"].ToString() != "")
                                {
                                    sLine += "        <tr> ";
                                    sLine += "            <th height=30 style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 검토사유 </th> ";
                                    sLine += "            <td height=30 style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_CRREVREASION"].ToString().Replace("\n", "<br>") + " </td> ";
                                    sLine += "            <td height=30 style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                                    sLine += "        </tr> ";
                                }

                                if (ht["P_FINISH"].ToString() == "FINISH")
                                {
                                    // (정상 = 3, 비상 = 4, 임시 = 5) 또는 화물(청소 포함 = 2)이면 작업위험평가를 작성하라고 메일 보냄
                                    // 화물(청소 미포함 = 1) 가동전 점검을 하라고 메일 보냄

                                    sLine += "        <tr> ";
                                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 다음작업 </th> ";
                                    if (ht["P_CAASKSTEPGN"].ToString() == "1")
                                    {
                                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> 가동전 점검을 작성하세요. </td> ";
                                    }
                                    else
                                    {
                                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> 작업 위험성 평가를 작성하세요. </td> ";
                                    }

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


        #region Description : 변경검토서 결재철회 메일 발송
        private DataSet UP_RETRACT_Mail_Send(Hashtable ht)
        {
            string sMailFrom = string.Empty;
            string sMailTo = string.Empty;

            string sAPNUM        = string.Empty;
            string sSENDER       = string.Empty;
            string sTITLE        = string.Empty;
            string sCRREVCONTENT = string.Empty;
            string sCRREVSUMMARY = string.Empty;

            string sCRREVTEAM    = string.Empty;
            string sCRREVDATE    = string.Empty;
            string sCRREVSEQ     = string.Empty;




            string sLine  = string.Empty;

            DataSet ds    = new DataSet();
            DataSet retds = new DataSet();
            DataTable dt  = new DataTable();
            DataRow row;

            sCRREVTEAM    = ht["P_CRREVTEAM"].ToString();
            sCRREVDATE    = Get_Date(ht["P_CRREVDATE"].ToString());
            sCRREVSEQ     = Set_Fill3(ht["P_CRREVSEQ"].ToString());

            sAPNUM        = ht["P_CRREVTEAM"].ToString() + "-" + Get_Date(ht["P_CRREVDATE"].ToString()) + "-" + Set_Fill3(ht["P_CRREVSEQ"].ToString());

            sCRREVCONTENT = ht["P_CRREVCONTENT"].ToString();
            sSENDER       = ht["P_SENDER"].ToString();

            int i = 0;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 수신자 메일 계정 가져오기
                dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_RECEIVER"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

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

                    sTITLE = "결재철회/변경검토서 - " + sCRREVCONTENT.ToString();

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
                        sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 변경검토서 </th> ";
                        sLine += "                <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
                        sLine += "                    <a href=''&WIDTH=1200&HEIGHT=1000 target=_blank> ";
                        //sLine += "                    <a onclick = window.open('','문서보기','width=920,height=1000')> ";
                        sLine += "                    <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
                        sLine += "                </td> ";
                        sLine += "            </tr> ";

                        sLine += "        <tr> ";
                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 변경검토번호 </th> ";
                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'>" + sAPNUM.ToString() + "</td> ";
                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
                        sLine += "        </tr> ";
                        sLine += "        <tr> ";
                        sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 검토항목 </th> ";
                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_CRREVCONTENT"].ToString().Replace("\n", "<br>") + " </td> ";
                        sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
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

        #region Description : 변경검토서 출력
        public DataSet UP_CHANGEREV_DOC_PRT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CRREVTEAM", DbType.String, ht["P_CRREVTEAM"]);
                dbCon.AddParameters("P_CRREVDATE", DbType.String, ht["P_CRREVDATE"]);
                dbCon.AddParameters("P_CRREVSEQ", DbType.VarNumeric, ht["P_CRREVSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4031_CHANGEREV_DOC_PRT");
            }
        }
        #endregion











































        //#region Description : 안전작업허가서 조회
        //public DataSet UP_GET_SAFEORDER_LIST(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_SAFEORDER_LIST");
        //    }
        //}
        //#endregion

        //#region Description : JSA 조회
        //public DataSet UP_GET_JSA_LIST(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_JSLWKGUBN", DbType.String, ht["P_JSLWKGUBN"]);
        //        dbCon.AddParameters("P_JSLWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_JSLWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_JSLWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_JSA_LIST");
        //    }
        //}
        //#endregion


        //#region Description : 안전작업허가서 복사
        //public DataSet UP_SAFEORDER_COPY(Hashtable ht)
        //{
        //    string sREDOCID = string.Empty;
        //    string sREDOCNUM = string.Empty;

        //    string sNEW_REDOCNUM = string.Empty;
        //    string sNEW_SMWKORSEQ = string.Empty;

        //    string sSMORNAME = string.Empty;
        //    string sSMORJKCD = string.Empty;
        //    string sSMORJKCDNM = string.Empty;

        //    string sSTATE = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        if (ht["P_GUBUN"].ToString() != "YES")
        //        {
        //            dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_WKGUBN"]);
        //            dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_WKTEAM"]);
        //            dbCon.AddParameters("P_JSMPODATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //            dbCon.AddParameters("P_JSMPOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //            dbCon.AddParameters("P_JSMDATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_JSACHANGE_LIST");

        //            if (ds.Tables[0].Rows.Count <= 0)
        //            {
        //                row = dt.NewRow();
        //                row["STATE"] = "ERR";
        //                row["MSG"] = "일일 JSA자료가 존재하지 않으므로 복사 할수 없습니다!";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);

        //                sSTATE = "ERR";

        //            }
        //        }

        //        if (sSTATE == "")
        //        {
        //            ds.Clear();
        //            sNEW_SMWKORSEQ = "1";

        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_WKTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_GET_MAX_SMWKORSEQ");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                sNEW_SMWKORSEQ = ds.Tables[0].Rows[0]["SMWKORSEQ"].ToString();
        //            }

        //            // 사번-부서명 가져오기
        //            ds.Clear();
        //            dbCon.AddParameters("P_DATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));
        //            dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_EMPNO"]);

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_SABUN_GET_BUSEO");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                sSMORNAME = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                sSMORJKCD = ds.Tables[0].Rows[0]["KBJKCD"].ToString();
        //                sSMORJKCDNM = ds.Tables[0].Rows[0]["CDDESC1"].ToString();
        //            }

        //            // 결재선 정보 가져오기
        //            ds.Clear();
        //            dbCon.AddParameters("P_BUSEO1", DbType.String, "ALL");
        //            dbCon.AddParameters("P_BUSEO2", DbType.String, "ALL");
        //            dbCon.AddParameters("P_BUSEO3", DbType.String, "ALL");
        //            dbCon.AddParameters("P_BUSEO4", DbType.String, "ALL");
        //            dbCon.AddParameters("P_BUSEO5", DbType.String, "ALL");
        //            dbCon.AddParameters("P_BUSEO6", DbType.String, "ALL");
        //            dbCon.AddParameters("P_BUSEO7", DbType.String, "ALL");
        //            dbCon.AddParameters("P_BUSEO8", DbType.String, "ALL");
        //            dbCon.AddParameters("P_SABUN", DbType.String, ht["P_EMPNO"]);

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_ORG_GETDATA");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                sSMORJKCD = ds.Tables[0].Rows[0]["JCCD"].ToString();
        //                sSMORJKCDNM = ds.Tables[0].Rows[0]["JKDESC"].ToString();
        //            }

        //            if (ht["P_GUBUN"].ToString() == "YES")
        //            {
        //                ds.Clear();

        //                //dbCon.AddParameters("P_JSLWKGUBN", DbType.String,"D");
        //                //dbCon.AddParameters("P_JSLWKTEAM", DbType.String,     ht["P_WKTEAM"]);
        //                //dbCon.AddParameters("P_JSLWKDATE", DbType.String,     ht["P_WKDATE"]);
        //                //dbCon.AddParameters("P_JSLWKSEQ",  DbType.VarNumeric, ht["P_WKSEQ"]);
        //                //dbCon.AddParameters("P_JSLDATE",   DbType.String,     ht["P_COPYDATE"]);

        //                //ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_JSALOG_MASTER_LIST");

        //                //if (ds.Tables[0].Rows.Count <= 0)
        //                //{
        //                // PSM_JSALOG 복사
        //                dbCon.AddParameters("P_COPYDATE", DbType.String, ht["P_COPYDATE"]);
        //                dbCon.AddParameters("P_COPYSEQ", DbType.VarNumeric, sNEW_SMWKORSEQ);
        //                dbCon.AddParameters("P_SABUN", DbType.String, ht["P_EMPNO"]);
        //                dbCon.AddParameters("P_WKGUBN", DbType.String, "D");
        //                dbCon.AddParameters("P_WKTEAM", DbType.String, ht["P_WKTEAM"]);
        //                dbCon.AddParameters("P_WKDATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //                dbCon.AddParameters("P_WKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //                dbCon.AddParameters("P_DATE", DbType.String, Get_Date(ht["P_DATE"].ToString()));
        //                dbCon.AddParameters("P_SEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKORSEQ"].ToString()));

        //                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4040_JSALOG_COPY");
        //                //}
        //            }

        //            // 안전작업허가서 복사
        //            dbCon.AddParameters("P_COPYDATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));
        //            dbCon.AddParameters("P_NEW_SMWKORSEQ", DbType.String, Set_Fill3(sNEW_SMWKORSEQ.ToString()));
        //            dbCon.AddParameters("P_SABUN", DbType.String, ht["P_EMPNO"]);
        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_WKTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_DATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4040_SAFEORDER_COPY");


        //            sREDOCID = "05";
        //            sREDOCNUM = ht["P_WKTEAM"].ToString() + Get_Date(ht["P_WKDATE"].ToString()) + Set_Fill3(ht["P_WKSEQ"].ToString()) + Get_Date(ht["P_DATE"].ToString()) + Set_Fill3(ht["P_WKORSEQ"].ToString());

        //            sNEW_REDOCNUM = ht["P_WKTEAM"].ToString() + Get_Date(ht["P_WKDATE"].ToString()) + Set_Fill3(ht["P_WKSEQ"].ToString()) + Get_Date(ht["P_COPYDATE"].ToString()) + Set_Fill3(sNEW_SMWKORSEQ);

        //            // 참조인 복사
        //            dbCon.AddParameters("P_NEW_REDOCNUM", DbType.String, sNEW_REDOCNUM);
        //            dbCon.AddParameters("P_HISAB", DbType.String, ht["P_EMPNO"]);
        //            dbCon.AddParameters("P_REDOCID", DbType.String, sREDOCID);
        //            dbCon.AddParameters("P_REDOCNUM", DbType.String, sREDOCNUM);

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4040_REFERENCE_COPY");

        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);
        //        }
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 일일JSA 복사
        //public DataSet UP_JSA_COPY(Hashtable ht)
        //{
        //    string sREDOCID = string.Empty;
        //    string sREDOCNUM = string.Empty;

        //    string sNEW_REDOCNUM = string.Empty;
        //    string sNEW_SMWKORSEQ = string.Empty;

        //    string sSMORNAME = string.Empty;
        //    string sSMORJKCD = string.Empty;
        //    string sSMORJKCDNM = string.Empty;

        //    string sSTATE = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_WKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_SAFEORDER_CHK");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            row = dt.NewRow();
        //            row["STATE"] = "ERR";
        //            row["MSG"] = "안전작업허가서가 발행된 날짜는 복사 할수 없습니다!";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);

        //            sSTATE = "ERR";
        //        }

        //        if (sSTATE == "")
        //        {
        //            ds.Clear();
        //            dbCon.AddParameters("P_JSLWKGUBN", DbType.String, "D");
        //            dbCon.AddParameters("P_JSLWKTEAM", DbType.String, ht["P_WKTEAM"]);
        //            dbCon.AddParameters("P_JSLWKDATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //            dbCon.AddParameters("P_JSLWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //            dbCon.AddParameters("P_JSLDATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_JSALOG_MASTER_LIST");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                row = dt.NewRow();
        //                row["STATE"] = "ERR";
        //                row["MSG"] = "복사일자에 자료가 존재합니다. 복사를 할 수 없습니다!";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);

        //                sSTATE = "ERR";
        //            }
        //        }

        //        if (sSTATE == "")
        //        {
        //            sNEW_SMWKORSEQ = "1";

        //            // PSM_JSALOG 복사
        //            dbCon.AddParameters("P_COPYDATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));
        //            dbCon.AddParameters("P_COPYSEQ", DbType.VarNumeric, Set_Fill3(sNEW_SMWKORSEQ.ToString()));
        //            dbCon.AddParameters("P_SABUN", DbType.String, ht["P_EMPNO"]);
        //            dbCon.AddParameters("P_WKGUBN", DbType.String, "D");
        //            dbCon.AddParameters("P_WKTEAM", DbType.String, ht["P_WKTEAM"]);
        //            dbCon.AddParameters("P_WKDATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //            dbCon.AddParameters("P_WKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //            dbCon.AddParameters("P_DATE", DbType.String, Get_Date(ht["P_DATE"].ToString()));
        //            dbCon.AddParameters("P_SEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4040_JSALOG_COPY");

        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);
        //        }
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 안전작업허가서 권한 가져오기
        //public DataSet UP_SAFEORDER_GET_AUTH(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {

        //        dbCon.AddParameters("P_USRID", DbType.String, ht["P_USRID"]);

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_AUTH");
        //    }
        //}
        //#endregion

        //#region Description : 안전작업허가서 출력
        //public DataSet UP_SAFEORDER_PRT(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.String, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.VarNumeric, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_PRT");
        //    }
        //}
        //#endregion

        //#region Description : 안전작업허가서 출력 조치요구사항 조회
        //public DataSet UP_SAFEORDER_SACODE_LIST(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SSWKTEAM", DbType.String, ht["P_SSWKTEAM"]);
        //        dbCon.AddParameters("P_SSWKDATE", DbType.String, Get_Date(ht["P_SSWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SSWKSEQ", DbType.String, Set_Fill3(ht["P_SSWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SSORAPPDATE", DbType.VarNumeric, Get_Date(ht["P_SSORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SSORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SSORSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_SACODE_LIST");
        //    }
        //}
        //#endregion

        //#region Description : 안전작업허가서 출력 프린터 이름 조회
        //public DataSet UP_PSM_PRINT_RUN(Hashtable ht)
        //{
        //    string sPRINTNAME = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet ds2 = new DataSet();
        //    DataTable dt = new DataTable();
        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_PRSITE", DbType.String, ht["P_PRSITE"]);

        //        ds2 = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4043_PSM_PRINT_RUN");

        //        if (ds2.Tables[0].Rows.Count > 0)
        //        {
        //            sPRINTNAME = ds2.Tables[0].Rows[0]["PRNAME"].ToString();

        //            svc = new RemotePrint.SafeOrderService();
        //            svc.Set_SafeOrder_Prt(ht["P_DOCNAME"].ToString(),
        //                                    ht["P_CMWKTEAM"].ToString(),
        //                                    ht["P_CMWKDATE"].ToString(),
        //                                    ht["P_CMWKSEQ"].ToString(),
        //                                    ht["P_SMWKORAPPDATE"].ToString(),
        //                                    ht["P_SMWKORSEQ"].ToString(),
        //                                    ht["P_JSA"].ToString(),
        //                                    sPRINTNAME,
        //                                    ht["P_COPIES"].ToString(),
        //                                    ht["P_SESSIONID"].ToString());

        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //ds.Tables.Add(dt);
        //        }
        //        else
        //        {
        //            row = dt.NewRow();
        //            row["STATE"] = "ERR";
        //            row["MSG"] = "프린터를 찾을 수 없습니다.";
        //            dt.Rows.Add(row);
        //            //ds.Tables.Add(dt);
        //        }
        //    }

        //    ds.Tables.Add(dt);

        //    return ds;
        //}
        //#endregion

        //#region Description : 안전작업허가서 출력 프린터 이름 조회
        //public DataSet UP_JSACHANGE_MASTER_LIST(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_JSMWKGUBN"]);
        //        dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_JSMPOTEAM"]);
        //        dbCon.AddParameters("P_JSMPODATE", DbType.String, ht["P_JSMPODATE"]);
        //        dbCon.AddParameters("P_JSMPOSEQ", DbType.String, ht["P_JSMPOSEQ"]);
        //        dbCon.AddParameters("P_JSMDATE", DbType.String, ht["P_JSMDATE"]);

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4043_JSACHANGE_MASTER_LIST");
        //    }
        //}
        //#endregion


        //#region Description : 작업요청서 확인
        //public DataSet UP_WORKORDER_RUN(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_WOORDATE"].ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WOSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_WORKORDER_RUN");
        //    }
        //}
        //#endregion



        //#region Description : 안전작업허가서 결재 확인
        //public DataSet UP_SAFEORDER_APPROVAL_RUN(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_APPROVAL_RUN");
        //    }
        //}
        //#endregion


        //#region Description : 안전작업허가서 확인
        //public DataSet UP_SAFEORDER_MASTER_RUN(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_RUN");
        //    }
        //}
        //#endregion


        //#region Description : 안전작업허가서 확인
        //public DataSet UP_JSACHANGE_MASTER_EXISTS(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_JSMWKGUBN", DbType.String, ht["P_WKGUBN"]);
        //        dbCon.AddParameters("P_JSMPOTEAM", DbType.String, ht["P_WKTEAM"]);
        //        dbCon.AddParameters("P_JSMPODATE", DbType.String, Get_Date(ht["P_WKDATE"].ToString()));
        //        dbCon.AddParameters("P_JSMPOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WKSEQ"].ToString()));
        //        dbCon.AddParameters("P_JSMDATE", DbType.String, Get_Date(ht["P_COPYDATE"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4040_JSACHANGE_LIST");
        //    }
        //}
        //#endregion



        //#region Description : 안전작업허가서 저장
        //public DataSet UP_SAFEORDER_MASTER_SAVE(Hashtable ht)
        //{
        //    string sMSG = "";
        //    string sSMWKORSEQ = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();
        //    DataRow row;

        //    sSMWKORSEQ = ht["P_SMWKORSEQ"].ToString();

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));
        //    dt.Columns.Add("DATA", typeof(System.String));

        //    if (ht["P_WKGUBUN"].ToString() == "NEW")
        //    {
        //        using (DB2Connecter dbMax = new DB2Connecter("DB2"))
        //        {
        //            dbMax.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //            dbMax.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //            dbMax.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //            dbMax.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));

        //            ds = dbMax.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_GET_MAX_SMWKORSEQ");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                row = dt.NewRow();
        //                row["STATE"] = "OK";
        //                row["MSG"] = "SEQ";

        //                sSMWKORSEQ = ds.Tables[0].Rows[0]["SMWKORSEQ"].ToString();
        //                row["DATA"] = ds.Tables[0].Rows[0]["SMWKORSEQ"].ToString();
        //                dt.Rows.Add(row);
        //            }
        //        }
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(sSMWKORSEQ));
        //        dbCon.AddParameters("P_SMREVTEAM", DbType.String, ht["P_SMREVTEAM"]);
        //        dbCon.AddParameters("P_SMWKMETHOD", DbType.String, ht["P_SMWKMETHOD"]);
        //        dbCon.AddParameters("P_SMSUBVEND", DbType.String, ht["P_SMSUBVEND"]);
        //        dbCon.AddParameters("P_SMSUBPERSON", DbType.String, ht["P_SMSUBPERSON"]);
        //        dbCon.AddParameters("P_SMSUBTEL", DbType.String, ht["P_SMSUBTEL"]);
        //        dbCon.AddParameters("P_SMRESSABUN", DbType.String, ht["P_SMRESSABUN"]);
        //        dbCon.AddParameters("P_SMWKMAN", DbType.String, ht["P_SMWKMAN"]);
        //        dbCon.AddParameters("P_SMTADATE1", DbType.String, ht["P_SMTADATE1"]);
        //        dbCon.AddParameters("P_SMTATIME1", DbType.String, ht["P_SMTATIME1"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMTADATE2", DbType.String, ht["P_SMTADATE2"]);
        //        dbCon.AddParameters("P_SMTATIME2", DbType.String, ht["P_SMTATIME2"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMOTDATE1", DbType.String, ht["P_SMOTDATE1"]);
        //        dbCon.AddParameters("P_SMOTTIME1", DbType.String, ht["P_SMOTTIME1"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMOTDATE2", DbType.String, ht["P_SMOTDATE2"]);
        //        dbCon.AddParameters("P_SMOTTIME2", DbType.String, ht["P_SMOTTIME2"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMOTAPPSABUN", DbType.String, ht["P_SMOTAPPSABUN"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE1", DbType.String, ht["P_SMSYSTEMCODE1"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE2", DbType.String, ht["P_SMSYSTEMCODE2"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE3", DbType.String, ht["P_SMSYSTEMCODE3"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE4", DbType.String, ht["P_SMSYSTEMCODE4"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE5", DbType.String, ht["P_SMSYSTEMCODE5"]);
        //        dbCon.AddParameters("P_SMCONNCODE11", DbType.String, ht["P_SMCONNCODE11"]);
        //        dbCon.AddParameters("P_SMCONNCODE12", DbType.String, ht["P_SMCONNCODE12"]);
        //        dbCon.AddParameters("P_SMCONNCODE21", DbType.String, ht["P_SMCONNCODE21"]);
        //        dbCon.AddParameters("P_SMCONNCODE22", DbType.String, ht["P_SMCONNCODE22"]);
        //        dbCon.AddParameters("P_SMCONNCODE31", DbType.String, ht["P_SMCONNCODE31"]);
        //        dbCon.AddParameters("P_SMCONNCODE32", DbType.String, ht["P_SMCONNCODE32"]);
        //        dbCon.AddParameters("P_SMCONNCODE41", DbType.String, ht["P_SMCONNCODE41"]);
        //        dbCon.AddParameters("P_SMCONNCODE42", DbType.String, ht["P_SMCONNCODE42"]);
        //        dbCon.AddParameters("P_SMCONNCODE51", DbType.String, ht["P_SMCONNCODE51"]);
        //        dbCon.AddParameters("P_SMCONNCODE52", DbType.String, ht["P_SMCONNCODE52"]);
        //        dbCon.AddParameters("P_SMAREACODE1", DbType.String, ht["P_SMAREACODE1"]);
        //        dbCon.AddParameters("P_SMAREACODE2", DbType.String, ht["P_SMAREACODE2"]);
        //        dbCon.AddParameters("P_SMAREACODE3", DbType.String, ht["P_SMAREACODE3"]);
        //        dbCon.AddParameters("P_SMAREACODE4", DbType.String, ht["P_SMAREACODE4"]);
        //        dbCon.AddParameters("P_SMAREACODE5", DbType.String, ht["P_SMAREACODE5"]);
        //        dbCon.AddParameters("P_SMAREATEXT1", DbType.String, ht["P_SMAREATEXT1"]);
        //        dbCon.AddParameters("P_SMAREATEXT2", DbType.String, ht["P_SMAREATEXT2"]);
        //        dbCon.AddParameters("P_SMAREATEXT3", DbType.String, ht["P_SMAREATEXT3"]);
        //        dbCon.AddParameters("P_SMAREATEXT4", DbType.String, ht["P_SMAREATEXT4"]);
        //        dbCon.AddParameters("P_SMAREATEXT5", DbType.String, ht["P_SMAREATEXT5"]);
        //        dbCon.AddParameters("P_SMMATERTEXT1", DbType.String, ht["P_SMMATERTEXT1"]);
        //        dbCon.AddParameters("P_SMMATERTEXT2", DbType.String, ht["P_SMMATERTEXT2"]);
        //        dbCon.AddParameters("P_SMNOTE_BURN", DbType.String, ht["P_SMNOTE_BURN"]);
        //        dbCon.AddParameters("P_SMNOTE_SUFF", DbType.String, ht["P_SMNOTE_SUFF"]);
        //        dbCon.AddParameters("P_SMNOTE_ELE", DbType.String, ht["P_SMNOTE_ELE"]);
        //        dbCon.AddParameters("P_SMNOTE_FIR", DbType.String, ht["P_SMNOTE_FIR"]);
        //        dbCon.AddParameters("P_SMNOTE_EXP", DbType.String, ht["P_SMNOTE_EXP"]);
        //        dbCon.AddParameters("P_SMNOTE_DROP", DbType.String, ht["P_SMNOTE_DROP"]);
        //        dbCon.AddParameters("P_SMNOTE_LEAK", DbType.String, ht["P_SMNOTE_LEAK"]);
        //        dbCon.AddParameters("P_SMNOTE_NARR", DbType.String, ht["P_SMNOTE_NARR"]);
        //        dbCon.AddParameters("P_SMNOTE_COLL", DbType.String, ht["P_SMNOTE_COLL"]);
        //        dbCon.AddParameters("P_SMCHKSABUN1", DbType.String, ht["P_SMCHKSABUN1"]);
        //        dbCon.AddParameters("P_SMCHKTIME1", DbType.String, ht["P_SMCHKTIME1"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN1", DbType.String, ht["P_SMCHKOXYGEN1"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT1", DbType.String, ht["P_SMCHKOXYGENUNIT1"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM1", DbType.VarNumeric, ht["P_SMCHKTOXNUM1"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT1", DbType.String, ht["P_SMCHKTOXUNIT1"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM1DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM1DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT1DS", DbType.String, ht["P_SMCHKTOXUNIT1DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM1CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM1CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT1CO2", DbType.String, ht["P_SMCHKTOXUNIT1CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM1CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM1CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT1CO", DbType.String, ht["P_SMCHKTOXUNIT1CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM1H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM1H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT1H2S", DbType.String, ht["P_SMCHKTOXUNIT1H2S"]);
        //        dbCon.AddParameters("P_SMCHKSABUN2", DbType.String, ht["P_SMCHKSABUN2"]);
        //        dbCon.AddParameters("P_SMCHKTIME2", DbType.String, ht["P_SMCHKTIME2"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN2", DbType.String, ht["P_SMCHKOXYGEN2"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT2", DbType.String, ht["P_SMCHKOXYGENUNIT2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM2", DbType.VarNumeric, ht["P_SMCHKTOXNUM2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT2", DbType.String, ht["P_SMCHKTOXUNIT2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM2DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM2DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT2DS", DbType.String, ht["P_SMCHKTOXUNIT2DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM2CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM2CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT2CO2", DbType.String, ht["P_SMCHKTOXUNIT2CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM2CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM2CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT2CO", DbType.String, ht["P_SMCHKTOXUNIT2CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM2H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM2H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT2H2S", DbType.String, ht["P_SMCHKTOXUNIT2H2S"]);
        //        dbCon.AddParameters("P_SMCHKSABUN3", DbType.String, ht["P_SMCHKSABUN3"]);
        //        dbCon.AddParameters("P_SMCHKTIME3", DbType.String, ht["P_SMCHKTIME3"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN3", DbType.String, ht["P_SMCHKOXYGEN3"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT3", DbType.String, ht["P_SMCHKOXYGENUNIT3"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM3", DbType.VarNumeric, ht["P_SMCHKTOXNUM3"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT3", DbType.String, ht["P_SMCHKTOXUNIT3"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM3DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM3DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT3DS", DbType.String, ht["P_SMCHKTOXUNIT3DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM3CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM3CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT3CO2", DbType.String, ht["P_SMCHKTOXUNIT3CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM3CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM3CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT3CO", DbType.String, ht["P_SMCHKTOXUNIT3CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM3H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM3H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT3H2S", DbType.String, ht["P_SMCHKTOXUNIT3H2S"]);
        //        dbCon.AddParameters("P_SMCHKSABUN4", DbType.String, ht["P_SMCHKSABUN4"]);
        //        dbCon.AddParameters("P_SMCHKTIME4", DbType.String, ht["P_SMCHKTIME4"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN4", DbType.String, ht["P_SMCHKOXYGEN4"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT4", DbType.String, ht["P_SMCHKOXYGENUNIT4"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM4", DbType.VarNumeric, ht["P_SMCHKTOXNUM4"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT4", DbType.String, ht["P_SMCHKTOXUNIT4"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM4DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM4DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT4DS", DbType.String, ht["P_SMCHKTOXUNIT4DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM4CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM4CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT4CO2", DbType.String, ht["P_SMCHKTOXUNIT4CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM4CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM4CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT4CO", DbType.String, ht["P_SMCHKTOXUNIT4CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM4H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM4H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT4H2S", DbType.String, ht["P_SMCHKTOXUNIT4H2S"]);
        //        dbCon.AddParameters("P_SMCHKSABUN5", DbType.String, ht["P_SMCHKSABUN5"]);
        //        dbCon.AddParameters("P_SMCHKTIME5", DbType.String, ht["P_SMCHKTIME5"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN5", DbType.String, ht["P_SMCHKOXYGEN5"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT5", DbType.String, ht["P_SMCHKOXYGENUNIT5"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM5", DbType.VarNumeric, ht["P_SMCHKTOXNUM5"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT5", DbType.String, ht["P_SMCHKTOXUNIT5"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM5DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM5DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT5DS", DbType.String, ht["P_SMCHKTOXUNIT5DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM5CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM5CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT5CO2", DbType.String, ht["P_SMCHKTOXUNIT5CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM5CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM5CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT5CO", DbType.String, ht["P_SMCHKTOXUNIT5CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM5H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM5H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT5H2S", DbType.String, ht["P_SMCHKTOXUNIT5H2S"]);
        //        dbCon.AddParameters("P_SMCHKSABUN6", DbType.String, ht["P_SMCHKSABUN6"]);
        //        dbCon.AddParameters("P_SMCHKTIME6", DbType.String, ht["P_SMCHKTIME6"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN6", DbType.String, ht["P_SMCHKOXYGEN6"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT6", DbType.String, ht["P_SMCHKOXYGENUNIT6"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM6", DbType.VarNumeric, ht["P_SMCHKTOXNUM6"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT6", DbType.String, ht["P_SMCHKTOXUNIT6"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM6DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM6DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT6DS", DbType.String, ht["P_SMCHKTOXUNIT6DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM6CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM6CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT6CO2", DbType.String, ht["P_SMCHKTOXUNIT6CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM6CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM6CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT6CO", DbType.String, ht["P_SMCHKTOXUNIT6CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM6H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM6H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT6H2S", DbType.String, ht["P_SMCHKTOXUNIT6H2S"]);
        //        dbCon.AddParameters("P_SMCHKSABUN7", DbType.String, ht["P_SMCHKSABUN7"]);
        //        dbCon.AddParameters("P_SMCHKTIME7", DbType.String, ht["P_SMCHKTIME7"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN7", DbType.String, ht["P_SMCHKOXYGEN7"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT7", DbType.String, ht["P_SMCHKOXYGENUNIT7"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM7", DbType.VarNumeric, ht["P_SMCHKTOXNUM7"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT7", DbType.String, ht["P_SMCHKTOXUNIT7"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM7DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM7DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT7DS", DbType.String, ht["P_SMCHKTOXUNIT7DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM7CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM7CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT7CO2", DbType.String, ht["P_SMCHKTOXUNIT7CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM7CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM7CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT7CO", DbType.String, ht["P_SMCHKTOXUNIT7CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM7H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM7H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT7H2S", DbType.String, ht["P_SMCHKTOXUNIT7H2S"]);
        //        dbCon.AddParameters("P_SMCHKSABUN8", DbType.String, ht["P_SMCHKSABUN8"]);
        //        dbCon.AddParameters("P_SMCHKTIME8", DbType.String, ht["P_SMCHKTIME8"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMCHKOXYGEN8", DbType.String, ht["P_SMCHKOXYGEN8"]);
        //        dbCon.AddParameters("P_SMCHKOXYGENUNIT8", DbType.String, ht["P_SMCHKOXYGENUNIT8"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM8", DbType.VarNumeric, ht["P_SMCHKTOXNUM8"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT8", DbType.String, ht["P_SMCHKTOXUNIT8"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM8DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM8DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT8DS", DbType.String, ht["P_SMCHKTOXUNIT8DS"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM8CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM8CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT8CO2", DbType.String, ht["P_SMCHKTOXUNIT8CO2"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM8CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM8CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT8CO", DbType.String, ht["P_SMCHKTOXUNIT8CO"]);
        //        dbCon.AddParameters("P_SMCHKTOXNUM8H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM8H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXUNIT8H2S", DbType.String, ht["P_SMCHKTOXUNIT8H2S"]);
        //        dbCon.AddParameters("P_SMCHKTOXGUBN1", DbType.String, ht["P_SMCHKTOXGUBN1"]);
        //        dbCon.AddParameters("P_SMCHKTOXGUBN2", DbType.String, ht["P_SMCHKTOXGUBN2"]);
        //        dbCon.AddParameters("P_SMCHKTOXGUBN3", DbType.String, ht["P_SMCHKTOXGUBN3"]);
        //        dbCon.AddParameters("P_SMCHKTOXGUBN4", DbType.String, ht["P_SMCHKTOXGUBN4"]);
        //        dbCon.AddParameters("P_SMCHKTOXGUBN5", DbType.String, ht["P_SMCHKTOXGUBN5"]);
        //        dbCon.AddParameters("P_SMCHKTOXGUBN6", DbType.String, ht["P_SMCHKTOXGUBN6"]);
        //        dbCon.AddParameters("P_SMORDERTEXT1 ", DbType.String, ht["P_SMORDERTEXT1 "]);
        //        dbCon.AddParameters("P_SMORDERTEXT2", DbType.String, ht["P_SMORDERTEXT2"]);
        //        dbCon.AddParameters("P_SMORSABUN", DbType.String, ht["P_SMORSABUN"]);
        //        dbCon.AddParameters("P_SMORNAME", DbType.String, ht["P_SMORNAME"]);
        //        dbCon.AddParameters("P_SMORJKCD", DbType.String, ht["P_SMORJKCD"]);
        //        dbCon.AddParameters("P_SMORJKCDNM", DbType.String, ht["P_SMORJKCDNM"]);
        //        dbCon.AddParameters("P_SMGRSABUN", DbType.String, ht["P_SMGRSABUN"]);
        //        dbCon.AddParameters("P_SMGRNAME", DbType.String, ht["P_SMGRNAME"]);
        //        dbCon.AddParameters("P_SMGRJKCD", DbType.String, ht["P_SMGRJKCD"]);
        //        dbCon.AddParameters("P_SMGRJKCDNM", DbType.String, ht["P_SMGRJKCDNM"]);
        //        dbCon.AddParameters("P_SMCOSABUN", DbType.String, ht["P_SMCOSABUN"]);
        //        dbCon.AddParameters("P_SMCONAME", DbType.String, ht["P_SMCONAME"]);
        //        dbCon.AddParameters("P_SMCOJKCD", DbType.String, ht["P_SMCOJKCD"]);
        //        dbCon.AddParameters("P_SMCOJKCDNM", DbType.String, ht["P_SMCOJKCDNM"]);
        //        dbCon.AddParameters("P_SMSMSABUN", DbType.String, ht["P_SMSMSABUN"]);
        //        dbCon.AddParameters("P_SMSMCOMMENT", DbType.String, ht["P_SMSMCOMMENT"]);
        //        dbCon.AddParameters("P_SMWORKTITLE", DbType.String, ht["P_SMWORKTITLE"]);
        //        dbCon.AddParameters("P_SMOPSABUN", DbType.String, ht["P_SMOPSABUN"]);
        //        dbCon.AddParameters("P_SMOPCOMMENT", DbType.String, ht["P_SMOPCOMMENT"]);
        //        dbCon.AddParameters("P_RESABUN", DbType.String, ht["P_RESABUN"]);
        //        dbCon.AddParameters("P_RENAME", DbType.String, ht["P_RENAME"]);
        //        dbCon.AddParameters("P_SMHISAB", DbType.String, ht["P_SMHISAB"]);
        //        dbCon.AddParameters("P_WKGUBUN", DbType.String, ht["P_WKGUBUN"]);
        //        dbCon.AddParameters("P_GUBUN", DbType.String, ht["P_GUBUN"]);

        //        dbCon.AddParameters("P_SWWKCODE1", DbType.String, ht["P_SWWKCODE1"]);
        //        dbCon.AddParameters("P_SWWKCODE2", DbType.String, ht["P_SWWKCODE2"]);
        //        dbCon.AddParameters("P_SWWKCODE3", DbType.String, ht["P_SWWKCODE3"]);
        //        dbCon.AddParameters("P_SWWKCODE4", DbType.String, ht["P_SWWKCODE4"]);
        //        dbCon.AddParameters("P_SWWKCODE5", DbType.String, ht["P_SWWKCODE5"]);
        //        dbCon.AddParameters("P_SWWKCODE6", DbType.String, ht["P_SWWKCODE6"]);
        //        dbCon.AddParameters("P_SWWKCODE7", DbType.String, ht["P_SWWKCODE7"]);
        //        dbCon.AddParameters("P_SWWKCODE8", DbType.String, ht["P_SWWKCODE8"]);
        //        dbCon.AddParameters("P_SWWKCODE9", DbType.String, ht["P_SWWKCODE9"]);
        //        dbCon.AddParameters("P_SWWKCODE10", DbType.String, ht["P_SWWKCODE10"]);

        //        dbCon.AddParameters("P_SITE", DbType.String, ht["P_SITE"]);


        //        dbCon.AddParameters("P_801_DRCODE", DbType.String, ht["801_DRCODE"]);
        //        dbCon.AddParameters("P_801_DRCODENAME", DbType.String, ht["801_DRCODENAME"]);
        //        dbCon.AddParameters("P_801_DRYESSEL", DbType.String, ht["801_DRYESSEL"]);
        //        dbCon.AddParameters("P_801_DRNOSEL", DbType.String, ht["801_DRNOSEL"]);
        //        dbCon.AddParameters("P_801_DRNASEL", DbType.String, ht["801_DRNASEL"]);
        //        dbCon.AddParameters("P_801_DRSORT", DbType.String, ht["801_DRSORT"]);
        //        dbCon.AddParameters("P_801_DRSTAND", DbType.String, ht["801_DRSTAND"]);
        //        dbCon.AddParameters("P_801_DRDEPTH", DbType.String, ht["801_DRDEPTH"]);
        //        dbCon.AddParameters("P_801_DRSABUN", DbType.String, ht["801_DRSABUN"]);

        //        dbCon.AddParameters("P_802_DRCODE", DbType.String, ht["802_DRCODE"]);
        //        dbCon.AddParameters("P_802_DRCODENAME", DbType.String, ht["802_DRCODENAME"]);
        //        dbCon.AddParameters("P_802_DRYESSEL", DbType.String, ht["802_DRYESSEL"]);
        //        dbCon.AddParameters("P_802_DRNOSEL", DbType.String, ht["802_DRNOSEL"]);
        //        dbCon.AddParameters("P_802_DRNASEL", DbType.String, ht["802_DRNASEL"]);
        //        dbCon.AddParameters("P_802_DRSORT", DbType.String, ht["802_DRSORT"]);
        //        dbCon.AddParameters("P_802_DRSTAND", DbType.String, ht["802_DRSTAND"]);
        //        dbCon.AddParameters("P_802_DRDEPTH", DbType.String, ht["802_DRDEPTH"]);
        //        dbCon.AddParameters("P_802_DRSABUN", DbType.String, ht["802_DRSABUN"]);

        //        dbCon.AddParameters("P_803_DRCODE", DbType.String, ht["803_DRCODE"]);
        //        dbCon.AddParameters("P_803_DRCODENAME", DbType.String, ht["803_DRCODENAME"]);
        //        dbCon.AddParameters("P_803_DRYESSEL", DbType.String, ht["803_DRYESSEL"]);
        //        dbCon.AddParameters("P_803_DRNOSEL", DbType.String, ht["803_DRNOSEL"]);
        //        dbCon.AddParameters("P_803_DRNASEL", DbType.String, ht["803_DRNASEL"]);
        //        dbCon.AddParameters("P_803_DRSORT", DbType.String, ht["803_DRSORT"]);
        //        dbCon.AddParameters("P_803_DRSTAND", DbType.String, ht["803_DRSTAND"]);
        //        dbCon.AddParameters("P_803_DRDEPTH", DbType.String, ht["803_DRDEPTH"]);
        //        dbCon.AddParameters("P_803_DRSABUN", DbType.String, ht["803_DRSABUN"]);

        //        dbCon.AddParameters("P_804_DRCODE", DbType.String, ht["804_DRCODE"]);
        //        dbCon.AddParameters("P_804_DRCODENAME", DbType.String, ht["804_DRCODENAME"]);
        //        dbCon.AddParameters("P_804_DRYESSEL", DbType.String, ht["804_DRYESSEL"]);
        //        dbCon.AddParameters("P_804_DRNOSEL", DbType.String, ht["804_DRNOSEL"]);
        //        dbCon.AddParameters("P_804_DRNASEL", DbType.String, ht["804_DRNASEL"]);
        //        dbCon.AddParameters("P_804_DRSORT", DbType.String, ht["804_DRSORT"]);
        //        dbCon.AddParameters("P_804_DRSTAND", DbType.String, ht["804_DRSTAND"]);
        //        dbCon.AddParameters("P_804_DRDEPTH", DbType.String, ht["804_DRDEPTH"]);
        //        dbCon.AddParameters("P_804_DRSABUN", DbType.String, ht["804_DRSABUN"]);

        //        dbCon.AddParameters("P_805_DRCODE", DbType.String, ht["805_DRCODE"]);
        //        dbCon.AddParameters("P_805_DRCODENAME", DbType.String, ht["805_DRCODENAME"]);
        //        dbCon.AddParameters("P_805_DRYESSEL", DbType.String, ht["805_DRYESSEL"]);
        //        dbCon.AddParameters("P_805_DRNOSEL", DbType.String, ht["805_DRNOSEL"]);
        //        dbCon.AddParameters("P_805_DRNASEL", DbType.String, ht["805_DRNASEL"]);
        //        dbCon.AddParameters("P_805_DRSORT", DbType.String, ht["805_DRSORT"]);
        //        dbCon.AddParameters("P_805_DRSTAND", DbType.String, ht["805_DRSTAND"]);
        //        dbCon.AddParameters("P_805_DRDEPTH", DbType.String, ht["805_DRDEPTH"]);
        //        dbCon.AddParameters("P_805_DRSABUN", DbType.String, ht["805_DRSABUN"]);

        //        dbCon.AddParameters("P_101_SACODE", DbType.String, ht["101_SACODE"]);
        //        dbCon.AddParameters("P_102_SACODE", DbType.String, ht["102_SACODE"]);
        //        dbCon.AddParameters("P_103_SACODE", DbType.String, ht["103_SACODE"]);
        //        dbCon.AddParameters("P_104_SACODE", DbType.String, ht["104_SACODE"]);
        //        dbCon.AddParameters("P_105_SACODE", DbType.String, ht["105_SACODE"]);
        //        dbCon.AddParameters("P_106_SACODE", DbType.String, ht["106_SACODE"]);
        //        dbCon.AddParameters("P_107_SACODE", DbType.String, ht["107_SACODE"]);
        //        dbCon.AddParameters("P_108_SACODE", DbType.String, ht["108_SACODE"]);
        //        dbCon.AddParameters("P_109_SACODE", DbType.String, ht["109_SACODE"]);
        //        dbCon.AddParameters("P_110_SACODE", DbType.String, ht["110_SACODE"]);
        //        dbCon.AddParameters("P_111_SACODE", DbType.String, ht["111_SACODE"]);
        //        dbCon.AddParameters("P_112_SACODE", DbType.String, ht["112_SACODE"]);
        //        dbCon.AddParameters("P_113_SACODE", DbType.String, ht["113_SACODE"]);
        //        dbCon.AddParameters("P_114_SACODE", DbType.String, ht["114_SACODE"]);
        //        dbCon.AddParameters("P_115_SACODE", DbType.String, ht["115_SACODE"]);
        //        dbCon.AddParameters("P_116_SACODE", DbType.String, ht["116_SACODE"]);
        //        dbCon.AddParameters("P_201_SACODE", DbType.String, ht["201_SACODE"]);
        //        dbCon.AddParameters("P_202_SACODE", DbType.String, ht["202_SACODE"]);
        //        dbCon.AddParameters("P_203_SACODE", DbType.String, ht["203_SACODE"]);
        //        dbCon.AddParameters("P_204_SACODE", DbType.String, ht["204_SACODE"]);
        //        dbCon.AddParameters("P_205_SACODE", DbType.String, ht["205_SACODE"]);
        //        dbCon.AddParameters("P_206_SACODE", DbType.String, ht["206_SACODE"]);
        //        dbCon.AddParameters("P_207_SACODE", DbType.String, ht["207_SACODE"]);
        //        dbCon.AddParameters("P_208_SACODE", DbType.String, ht["208_SACODE"]);
        //        dbCon.AddParameters("P_209_SACODE", DbType.String, ht["209_SACODE"]);
        //        dbCon.AddParameters("P_210_SACODE", DbType.String, ht["210_SACODE"]);
        //        dbCon.AddParameters("P_211_SACODE", DbType.String, ht["211_SACODE"]);
        //        dbCon.AddParameters("P_212_SACODE", DbType.String, ht["212_SACODE"]);
        //        dbCon.AddParameters("P_213_SACODE", DbType.String, ht["213_SACODE"]);
        //        dbCon.AddParameters("P_214_SACODE", DbType.String, ht["214_SACODE"]);
        //        dbCon.AddParameters("P_215_SACODE", DbType.String, ht["215_SACODE"]);
        //        dbCon.AddParameters("P_216_SACODE", DbType.String, ht["216_SACODE"]);
        //        dbCon.AddParameters("P_217_SACODE", DbType.String, ht["217_SACODE"]);
        //        dbCon.AddParameters("P_218_SACODE", DbType.String, ht["218_SACODE"]);
        //        dbCon.AddParameters("P_301_SACODE", DbType.String, ht["301_SACODE"]);
        //        dbCon.AddParameters("P_302_SACODE", DbType.String, ht["302_SACODE"]);
        //        dbCon.AddParameters("P_303_SACODE", DbType.String, ht["303_SACODE"]);
        //        dbCon.AddParameters("P_304_SACODE", DbType.String, ht["304_SACODE"]);
        //        dbCon.AddParameters("P_305_SACODE", DbType.String, ht["305_SACODE"]);
        //        dbCon.AddParameters("P_306_SACODE", DbType.String, ht["306_SACODE"]);
        //        dbCon.AddParameters("P_307_SACODE", DbType.String, ht["307_SACODE"]);
        //        dbCon.AddParameters("P_308_SACODE", DbType.String, ht["308_SACODE"]);
        //        dbCon.AddParameters("P_309_SACODE", DbType.String, ht["309_SACODE"]);
        //        dbCon.AddParameters("P_310_SACODE", DbType.String, ht["310_SACODE"]);
        //        dbCon.AddParameters("P_311_SACODE", DbType.String, ht["311_SACODE"]);
        //        dbCon.AddParameters("P_312_SACODE", DbType.String, ht["312_SACODE"]);
        //        dbCon.AddParameters("P_313_SACODE", DbType.String, ht["313_SACODE"]);
        //        dbCon.AddParameters("P_314_SACODE", DbType.String, ht["314_SACODE"]);
        //        dbCon.AddParameters("P_401_SACODE", DbType.String, ht["401_SACODE"]);
        //        dbCon.AddParameters("P_402_SACODE", DbType.String, ht["402_SACODE"]);
        //        dbCon.AddParameters("P_403_SACODE", DbType.String, ht["403_SACODE"]);
        //        dbCon.AddParameters("P_404_SACODE", DbType.String, ht["404_SACODE"]);
        //        dbCon.AddParameters("P_405_SACODE", DbType.String, ht["405_SACODE"]);
        //        dbCon.AddParameters("P_406_SACODE", DbType.String, ht["406_SACODE"]);
        //        dbCon.AddParameters("P_407_SACODE", DbType.String, ht["407_SACODE"]);
        //        dbCon.AddParameters("P_408_SACODE", DbType.String, ht["408_SACODE"]);
        //        dbCon.AddParameters("P_409_SACODE", DbType.String, ht["409_SACODE"]);
        //        dbCon.AddParameters("P_501_SACODE", DbType.String, ht["501_SACODE"]);
        //        dbCon.AddParameters("P_502_SACODE", DbType.String, ht["502_SACODE"]);
        //        dbCon.AddParameters("P_503_SACODE", DbType.String, ht["503_SACODE"]);
        //        dbCon.AddParameters("P_504_SACODE", DbType.String, ht["504_SACODE"]);
        //        dbCon.AddParameters("P_601_SACODE", DbType.String, ht["601_SACODE"]);
        //        dbCon.AddParameters("P_602_SACODE", DbType.String, ht["602_SACODE"]);
        //        dbCon.AddParameters("P_603_SACODE", DbType.String, ht["603_SACODE"]);
        //        dbCon.AddParameters("P_701_SACODE", DbType.String, ht["701_SACODE"]);
        //        dbCon.AddParameters("P_702_SACODE", DbType.String, ht["702_SACODE"]);
        //        dbCon.AddParameters("P_703_SACODE", DbType.String, ht["703_SACODE"]);
        //        dbCon.AddParameters("P_704_SACODE", DbType.String, ht["704_SACODE"]);
        //        dbCon.AddParameters("P_705_SACODE", DbType.String, ht["705_SACODE"]);
        //        dbCon.AddParameters("P_706_SACODE", DbType.String, ht["706_SACODE"]);
        //        dbCon.AddParameters("P_707_SACODE", DbType.String, ht["707_SACODE"]);
        //        dbCon.AddParameters("P_708_SACODE", DbType.String, ht["708_SACODE"]);
        //        dbCon.AddParameters("P_901_SACODE", DbType.String, ht["901_SACODE"]);
        //        dbCon.AddParameters("P_902_SACODE", DbType.String, ht["902_SACODE"]);
        //        dbCon.AddParameters("P_903_SACODE", DbType.String, ht["903_SACODE"]);
        //        dbCon.AddParameters("P_904_SACODE", DbType.String, ht["904_SACODE"]);
        //        dbCon.AddParameters("P_905_SACODE", DbType.String, ht["905_SACODE"]);
        //        dbCon.AddParameters("P_906_SACODE", DbType.String, ht["906_SACODE"]);
        //        dbCon.AddParameters("P_907_SACODE", DbType.String, ht["907_SACODE"]);
        //        dbCon.AddParameters("P_908_SACODE", DbType.String, ht["908_SACODE"]);
        //        dbCon.AddParameters("P_909_SACODE", DbType.String, ht["909_SACODE"]);
        //        dbCon.AddParameters("P_910_SACODE", DbType.String, ht["910_SACODE"]);
        //        dbCon.AddParameters("P_911_SACODE", DbType.String, ht["911_SACODE"]);
        //        dbCon.AddParameters("P_912_SACODE", DbType.String, ht["912_SACODE"]);
        //        dbCon.AddParameters("P_913_SACODE", DbType.String, ht["913_SACODE"]);
        //        dbCon.AddParameters("P_914_SACODE", DbType.String, ht["914_SACODE"]);
        //        dbCon.AddParameters("P_915_SACODE", DbType.String, ht["915_SACODE"]);
        //        dbCon.AddParameters("P_916_SACODE", DbType.String, ht["916_SACODE"]);


        //        dbCon.AddParameters("P_101_SACODENM", DbType.String, ht["101_SACODENM"]);
        //        dbCon.AddParameters("P_102_SACODENM", DbType.String, ht["102_SACODENM"]);
        //        dbCon.AddParameters("P_103_SACODENM", DbType.String, ht["103_SACODENM"]);
        //        dbCon.AddParameters("P_104_SACODENM", DbType.String, ht["104_SACODENM"]);
        //        dbCon.AddParameters("P_105_SACODENM", DbType.String, ht["105_SACODENM"]);
        //        dbCon.AddParameters("P_106_SACODENM", DbType.String, ht["106_SACODENM"]);
        //        dbCon.AddParameters("P_107_SACODENM", DbType.String, ht["107_SACODENM"]);
        //        dbCon.AddParameters("P_108_SACODENM", DbType.String, ht["108_SACODENM"]);
        //        dbCon.AddParameters("P_109_SACODENM", DbType.String, ht["109_SACODENM"]);
        //        dbCon.AddParameters("P_110_SACODENM", DbType.String, ht["110_SACODENM"]);
        //        dbCon.AddParameters("P_111_SACODENM", DbType.String, ht["111_SACODENM"]);
        //        dbCon.AddParameters("P_112_SACODENM", DbType.String, ht["112_SACODENM"]);
        //        dbCon.AddParameters("P_113_SACODENM", DbType.String, ht["113_SACODENM"]);
        //        dbCon.AddParameters("P_114_SACODENM", DbType.String, ht["114_SACODENM"]);
        //        dbCon.AddParameters("P_115_SACODENM", DbType.String, ht["115_SACODENM"]);
        //        dbCon.AddParameters("P_116_SACODENM", DbType.String, ht["116_SACODENM"]);
        //        dbCon.AddParameters("P_201_SACODENM", DbType.String, ht["201_SACODENM"]);
        //        dbCon.AddParameters("P_202_SACODENM", DbType.String, ht["202_SACODENM"]);
        //        dbCon.AddParameters("P_203_SACODENM", DbType.String, ht["203_SACODENM"]);
        //        dbCon.AddParameters("P_204_SACODENM", DbType.String, ht["204_SACODENM"]);
        //        dbCon.AddParameters("P_205_SACODENM", DbType.String, ht["205_SACODENM"]);
        //        dbCon.AddParameters("P_206_SACODENM", DbType.String, ht["206_SACODENM"]);
        //        dbCon.AddParameters("P_207_SACODENM", DbType.String, ht["207_SACODENM"]);
        //        dbCon.AddParameters("P_208_SACODENM", DbType.String, ht["208_SACODENM"]);
        //        dbCon.AddParameters("P_209_SACODENM", DbType.String, ht["209_SACODENM"]);
        //        dbCon.AddParameters("P_210_SACODENM", DbType.String, ht["210_SACODENM"]);
        //        dbCon.AddParameters("P_211_SACODENM", DbType.String, ht["211_SACODENM"]);
        //        dbCon.AddParameters("P_212_SACODENM", DbType.String, ht["212_SACODENM"]);
        //        dbCon.AddParameters("P_213_SACODENM", DbType.String, ht["213_SACODENM"]);
        //        dbCon.AddParameters("P_214_SACODENM", DbType.String, ht["214_SACODENM"]);
        //        dbCon.AddParameters("P_215_SACODENM", DbType.String, ht["215_SACODENM"]);
        //        dbCon.AddParameters("P_216_SACODENM", DbType.String, ht["216_SACODENM"]);
        //        dbCon.AddParameters("P_217_SACODENM", DbType.String, ht["217_SACODENM"]);
        //        dbCon.AddParameters("P_218_SACODENM", DbType.String, ht["218_SACODENM"]);
        //        dbCon.AddParameters("P_301_SACODENM", DbType.String, ht["301_SACODENM"]);
        //        dbCon.AddParameters("P_302_SACODENM", DbType.String, ht["302_SACODENM"]);
        //        dbCon.AddParameters("P_303_SACODENM", DbType.String, ht["303_SACODENM"]);
        //        dbCon.AddParameters("P_304_SACODENM", DbType.String, ht["304_SACODENM"]);
        //        dbCon.AddParameters("P_305_SACODENM", DbType.String, ht["305_SACODENM"]);
        //        dbCon.AddParameters("P_306_SACODENM", DbType.String, ht["306_SACODENM"]);
        //        dbCon.AddParameters("P_307_SACODENM", DbType.String, ht["307_SACODENM"]);
        //        dbCon.AddParameters("P_308_SACODENM", DbType.String, ht["308_SACODENM"]);
        //        dbCon.AddParameters("P_309_SACODENM", DbType.String, ht["309_SACODENM"]);
        //        dbCon.AddParameters("P_310_SACODENM", DbType.String, ht["310_SACODENM"]);
        //        dbCon.AddParameters("P_311_SACODENM", DbType.String, ht["311_SACODENM"]);
        //        dbCon.AddParameters("P_312_SACODENM", DbType.String, ht["312_SACODENM"]);
        //        dbCon.AddParameters("P_313_SACODENM", DbType.String, ht["313_SACODENM"]);
        //        dbCon.AddParameters("P_314_SACODENM", DbType.String, ht["314_SACODENM"]);
        //        dbCon.AddParameters("P_401_SACODENM", DbType.String, ht["401_SACODENM"]);
        //        dbCon.AddParameters("P_402_SACODENM", DbType.String, ht["402_SACODENM"]);
        //        dbCon.AddParameters("P_403_SACODENM", DbType.String, ht["403_SACODENM"]);
        //        dbCon.AddParameters("P_404_SACODENM", DbType.String, ht["404_SACODENM"]);
        //        dbCon.AddParameters("P_405_SACODENM", DbType.String, ht["405_SACODENM"]);
        //        dbCon.AddParameters("P_406_SACODENM", DbType.String, ht["406_SACODENM"]);
        //        dbCon.AddParameters("P_407_SACODENM", DbType.String, ht["407_SACODENM"]);
        //        dbCon.AddParameters("P_408_SACODENM", DbType.String, ht["408_SACODENM"]);
        //        dbCon.AddParameters("P_409_SACODENM", DbType.String, ht["409_SACODENM"]);
        //        dbCon.AddParameters("P_501_SACODENM", DbType.String, ht["501_SACODENM"]);
        //        dbCon.AddParameters("P_502_SACODENM", DbType.String, ht["502_SACODENM"]);
        //        dbCon.AddParameters("P_503_SACODENM", DbType.String, ht["503_SACODENM"]);
        //        dbCon.AddParameters("P_504_SACODENM", DbType.String, ht["504_SACODENM"]);
        //        dbCon.AddParameters("P_601_SACODENM", DbType.String, ht["601_SACODENM"]);
        //        dbCon.AddParameters("P_602_SACODENM", DbType.String, ht["602_SACODENM"]);
        //        dbCon.AddParameters("P_603_SACODENM", DbType.String, ht["603_SACODENM"]);
        //        dbCon.AddParameters("P_701_SACODENM", DbType.String, ht["701_SACODENM"]);
        //        dbCon.AddParameters("P_702_SACODENM", DbType.String, ht["702_SACODENM"]);
        //        dbCon.AddParameters("P_703_SACODENM", DbType.String, ht["703_SACODENM"]);
        //        dbCon.AddParameters("P_704_SACODENM", DbType.String, ht["704_SACODENM"]);
        //        dbCon.AddParameters("P_705_SACODENM", DbType.String, ht["705_SACODENM"]);
        //        dbCon.AddParameters("P_706_SACODENM", DbType.String, ht["706_SACODENM"]);
        //        dbCon.AddParameters("P_707_SACODENM", DbType.String, ht["707_SACODENM"]);
        //        dbCon.AddParameters("P_708_SACODENM", DbType.String, ht["708_SACODENM"]);
        //        dbCon.AddParameters("P_901_SACODENM", DbType.String, ht["901_SACODENM"]);
        //        dbCon.AddParameters("P_902_SACODENM", DbType.String, ht["902_SACODENM"]);
        //        dbCon.AddParameters("P_903_SACODENM", DbType.String, ht["903_SACODENM"]);
        //        dbCon.AddParameters("P_904_SACODENM", DbType.String, ht["904_SACODENM"]);
        //        dbCon.AddParameters("P_905_SACODENM", DbType.String, ht["905_SACODENM"]);
        //        dbCon.AddParameters("P_906_SACODENM", DbType.String, ht["906_SACODENM"]);
        //        dbCon.AddParameters("P_907_SACODENM", DbType.String, ht["907_SACODENM"]);
        //        dbCon.AddParameters("P_908_SACODENM", DbType.String, ht["908_SACODENM"]);
        //        dbCon.AddParameters("P_909_SACODENM", DbType.String, ht["909_SACODENM"]);
        //        dbCon.AddParameters("P_910_SACODENM", DbType.String, ht["910_SACODENM"]);
        //        dbCon.AddParameters("P_911_SACODENM", DbType.String, ht["911_SACODENM"]);
        //        dbCon.AddParameters("P_912_SACODENM", DbType.String, ht["912_SACODENM"]);
        //        dbCon.AddParameters("P_913_SACODENM", DbType.String, ht["913_SACODENM"]);
        //        dbCon.AddParameters("P_914_SACODENM", DbType.String, ht["914_SACODENM"]);
        //        dbCon.AddParameters("P_915_SACODENM", DbType.String, ht["915_SACODENM"]);
        //        dbCon.AddParameters("P_916_SACODENM", DbType.String, ht["916_SACODENM"]);

        //        dbCon.AddParameters("P_101_SSPUBSEL", DbType.String, ht["101_SSPUBSEL"]);
        //        dbCon.AddParameters("P_102_SSPUBSEL", DbType.String, ht["102_SSPUBSEL"]);
        //        dbCon.AddParameters("P_103_SSPUBSEL", DbType.String, ht["103_SSPUBSEL"]);
        //        dbCon.AddParameters("P_104_SSPUBSEL", DbType.String, ht["104_SSPUBSEL"]);
        //        dbCon.AddParameters("P_105_SSPUBSEL", DbType.String, ht["105_SSPUBSEL"]);
        //        dbCon.AddParameters("P_106_SSPUBSEL", DbType.String, ht["106_SSPUBSEL"]);
        //        dbCon.AddParameters("P_107_SSPUBSEL", DbType.String, ht["107_SSPUBSEL"]);
        //        dbCon.AddParameters("P_108_SSPUBSEL", DbType.String, ht["108_SSPUBSEL"]);
        //        dbCon.AddParameters("P_109_SSPUBSEL", DbType.String, ht["109_SSPUBSEL"]);
        //        dbCon.AddParameters("P_110_SSPUBSEL", DbType.String, ht["110_SSPUBSEL"]);
        //        dbCon.AddParameters("P_111_SSPUBSEL", DbType.String, ht["111_SSPUBSEL"]);
        //        dbCon.AddParameters("P_112_SSPUBSEL", DbType.String, ht["112_SSPUBSEL"]);
        //        dbCon.AddParameters("P_113_SSPUBSEL", DbType.String, ht["113_SSPUBSEL"]);
        //        dbCon.AddParameters("P_114_SSPUBSEL", DbType.String, ht["114_SSPUBSEL"]);
        //        dbCon.AddParameters("P_115_SSPUBSEL", DbType.String, ht["115_SSPUBSEL"]);
        //        dbCon.AddParameters("P_116_SSPUBSEL", DbType.String, ht["116_SSPUBSEL"]);
        //        dbCon.AddParameters("P_101_SSREVSEL", DbType.String, ht["101_SSREVSEL"]);
        //        dbCon.AddParameters("P_102_SSREVSEL", DbType.String, ht["102_SSREVSEL"]);
        //        dbCon.AddParameters("P_103_SSREVSEL", DbType.String, ht["103_SSREVSEL"]);
        //        dbCon.AddParameters("P_104_SSREVSEL", DbType.String, ht["104_SSREVSEL"]);
        //        dbCon.AddParameters("P_105_SSREVSEL", DbType.String, ht["105_SSREVSEL"]);
        //        dbCon.AddParameters("P_106_SSREVSEL", DbType.String, ht["106_SSREVSEL"]);
        //        dbCon.AddParameters("P_107_SSREVSEL", DbType.String, ht["107_SSREVSEL"]);
        //        dbCon.AddParameters("P_108_SSREVSEL", DbType.String, ht["108_SSREVSEL"]);
        //        dbCon.AddParameters("P_109_SSREVSEL", DbType.String, ht["109_SSREVSEL"]);
        //        dbCon.AddParameters("P_110_SSREVSEL", DbType.String, ht["110_SSREVSEL"]);
        //        dbCon.AddParameters("P_111_SSREVSEL", DbType.String, ht["111_SSREVSEL"]);
        //        dbCon.AddParameters("P_112_SSREVSEL", DbType.String, ht["112_SSREVSEL"]);
        //        dbCon.AddParameters("P_113_SSREVSEL", DbType.String, ht["113_SSREVSEL"]);
        //        dbCon.AddParameters("P_114_SSREVSEL", DbType.String, ht["114_SSREVSEL"]);
        //        dbCon.AddParameters("P_115_SSREVSEL", DbType.String, ht["115_SSREVSEL"]);
        //        dbCon.AddParameters("P_116_SSREVSEL", DbType.String, ht["116_SSREVSEL"]);
        //        dbCon.AddParameters("P_101_SSFIXSEL", DbType.String, ht["101_SSFIXSEL"]);
        //        dbCon.AddParameters("P_102_SSFIXSEL", DbType.String, ht["102_SSFIXSEL"]);
        //        dbCon.AddParameters("P_103_SSFIXSEL", DbType.String, ht["103_SSFIXSEL"]);
        //        dbCon.AddParameters("P_104_SSFIXSEL", DbType.String, ht["104_SSFIXSEL"]);
        //        dbCon.AddParameters("P_105_SSFIXSEL", DbType.String, ht["105_SSFIXSEL"]);
        //        dbCon.AddParameters("P_106_SSFIXSEL", DbType.String, ht["106_SSFIXSEL"]);
        //        dbCon.AddParameters("P_107_SSFIXSEL", DbType.String, ht["107_SSFIXSEL"]);
        //        dbCon.AddParameters("P_108_SSFIXSEL", DbType.String, ht["108_SSFIXSEL"]);
        //        dbCon.AddParameters("P_109_SSFIXSEL", DbType.String, ht["109_SSFIXSEL"]);
        //        dbCon.AddParameters("P_110_SSFIXSEL", DbType.String, ht["110_SSFIXSEL"]);
        //        dbCon.AddParameters("P_111_SSFIXSEL", DbType.String, ht["111_SSFIXSEL"]);
        //        dbCon.AddParameters("P_112_SSFIXSEL", DbType.String, ht["112_SSFIXSEL"]);
        //        dbCon.AddParameters("P_113_SSFIXSEL", DbType.String, ht["113_SSFIXSEL"]);
        //        dbCon.AddParameters("P_114_SSFIXSEL", DbType.String, ht["114_SSFIXSEL"]);
        //        dbCon.AddParameters("P_115_SSFIXSEL", DbType.String, ht["115_SSFIXSEL"]);
        //        dbCon.AddParameters("P_116_SSFIXSEL", DbType.String, ht["116_SSFIXSEL"]);
        //        dbCon.AddParameters("P_201_SSPUBSEL", DbType.String, ht["201_SSPUBSEL"]);
        //        dbCon.AddParameters("P_202_SSPUBSEL", DbType.String, ht["202_SSPUBSEL"]);
        //        dbCon.AddParameters("P_203_SSPUBSEL", DbType.String, ht["203_SSPUBSEL"]);
        //        dbCon.AddParameters("P_204_SSPUBSEL", DbType.String, ht["204_SSPUBSEL"]);
        //        dbCon.AddParameters("P_205_SSPUBSEL", DbType.String, ht["205_SSPUBSEL"]);
        //        dbCon.AddParameters("P_206_SSPUBSEL", DbType.String, ht["206_SSPUBSEL"]);
        //        dbCon.AddParameters("P_207_SSPUBSEL", DbType.String, ht["207_SSPUBSEL"]);
        //        dbCon.AddParameters("P_208_SSPUBSEL", DbType.String, ht["208_SSPUBSEL"]);
        //        dbCon.AddParameters("P_209_SSPUBSEL", DbType.String, ht["209_SSPUBSEL"]);
        //        dbCon.AddParameters("P_210_SSPUBSEL", DbType.String, ht["210_SSPUBSEL"]);
        //        dbCon.AddParameters("P_211_SSPUBSEL", DbType.String, ht["211_SSPUBSEL"]);
        //        dbCon.AddParameters("P_212_SSPUBSEL", DbType.String, ht["212_SSPUBSEL"]);
        //        dbCon.AddParameters("P_213_SSPUBSEL", DbType.String, ht["213_SSPUBSEL"]);
        //        dbCon.AddParameters("P_214_SSPUBSEL", DbType.String, ht["214_SSPUBSEL"]);
        //        dbCon.AddParameters("P_215_SSPUBSEL", DbType.String, ht["215_SSPUBSEL"]);
        //        dbCon.AddParameters("P_216_SSPUBSEL", DbType.String, ht["216_SSPUBSEL"]);
        //        dbCon.AddParameters("P_217_SSPUBSEL", DbType.String, ht["217_SSPUBSEL"]);
        //        dbCon.AddParameters("P_218_SSPUBSEL", DbType.String, ht["218_SSPUBSEL"]);
        //        dbCon.AddParameters("P_201_SSREVSEL", DbType.String, ht["201_SSREVSEL"]);
        //        dbCon.AddParameters("P_202_SSREVSEL", DbType.String, ht["202_SSREVSEL"]);
        //        dbCon.AddParameters("P_203_SSREVSEL", DbType.String, ht["203_SSREVSEL"]);
        //        dbCon.AddParameters("P_204_SSREVSEL", DbType.String, ht["204_SSREVSEL"]);
        //        dbCon.AddParameters("P_205_SSREVSEL", DbType.String, ht["205_SSREVSEL"]);
        //        dbCon.AddParameters("P_206_SSREVSEL", DbType.String, ht["206_SSREVSEL"]);
        //        dbCon.AddParameters("P_207_SSREVSEL", DbType.String, ht["207_SSREVSEL"]);
        //        dbCon.AddParameters("P_208_SSREVSEL", DbType.String, ht["208_SSREVSEL"]);
        //        dbCon.AddParameters("P_209_SSREVSEL", DbType.String, ht["209_SSREVSEL"]);
        //        dbCon.AddParameters("P_210_SSREVSEL", DbType.String, ht["210_SSREVSEL"]);
        //        dbCon.AddParameters("P_211_SSREVSEL", DbType.String, ht["211_SSREVSEL"]);
        //        dbCon.AddParameters("P_212_SSREVSEL", DbType.String, ht["212_SSREVSEL"]);
        //        dbCon.AddParameters("P_213_SSREVSEL", DbType.String, ht["213_SSREVSEL"]);
        //        dbCon.AddParameters("P_214_SSREVSEL", DbType.String, ht["214_SSREVSEL"]);
        //        dbCon.AddParameters("P_215_SSREVSEL", DbType.String, ht["215_SSREVSEL"]);
        //        dbCon.AddParameters("P_216_SSREVSEL", DbType.String, ht["216_SSREVSEL"]);
        //        dbCon.AddParameters("P_217_SSREVSEL", DbType.String, ht["217_SSREVSEL"]);
        //        dbCon.AddParameters("P_218_SSREVSEL", DbType.String, ht["218_SSREVSEL"]);
        //        dbCon.AddParameters("P_201_SSFIXSEL", DbType.String, ht["201_SSFIXSEL"]);
        //        dbCon.AddParameters("P_202_SSFIXSEL", DbType.String, ht["202_SSFIXSEL"]);
        //        dbCon.AddParameters("P_203_SSFIXSEL", DbType.String, ht["203_SSFIXSEL"]);
        //        dbCon.AddParameters("P_204_SSFIXSEL", DbType.String, ht["204_SSFIXSEL"]);
        //        dbCon.AddParameters("P_205_SSFIXSEL", DbType.String, ht["205_SSFIXSEL"]);
        //        dbCon.AddParameters("P_206_SSFIXSEL", DbType.String, ht["206_SSFIXSEL"]);
        //        dbCon.AddParameters("P_207_SSFIXSEL", DbType.String, ht["207_SSFIXSEL"]);
        //        dbCon.AddParameters("P_208_SSFIXSEL", DbType.String, ht["208_SSFIXSEL"]);
        //        dbCon.AddParameters("P_209_SSFIXSEL", DbType.String, ht["209_SSFIXSEL"]);
        //        dbCon.AddParameters("P_210_SSFIXSEL", DbType.String, ht["210_SSFIXSEL"]);
        //        dbCon.AddParameters("P_211_SSFIXSEL", DbType.String, ht["211_SSFIXSEL"]);
        //        dbCon.AddParameters("P_212_SSFIXSEL", DbType.String, ht["212_SSFIXSEL"]);
        //        dbCon.AddParameters("P_213_SSFIXSEL", DbType.String, ht["213_SSFIXSEL"]);
        //        dbCon.AddParameters("P_214_SSFIXSEL", DbType.String, ht["214_SSFIXSEL"]);
        //        dbCon.AddParameters("P_215_SSFIXSEL", DbType.String, ht["215_SSFIXSEL"]);
        //        dbCon.AddParameters("P_216_SSFIXSEL", DbType.String, ht["216_SSFIXSEL"]);
        //        dbCon.AddParameters("P_217_SSFIXSEL", DbType.String, ht["217_SSFIXSEL"]);
        //        dbCon.AddParameters("P_218_SSFIXSEL", DbType.String, ht["218_SSFIXSEL"]);
        //        dbCon.AddParameters("P_301_SSPUBSEL", DbType.String, ht["301_SSPUBSEL"]);
        //        dbCon.AddParameters("P_302_SSPUBSEL", DbType.String, ht["302_SSPUBSEL"]);
        //        dbCon.AddParameters("P_303_SSPUBSEL", DbType.String, ht["303_SSPUBSEL"]);
        //        dbCon.AddParameters("P_304_SSPUBSEL", DbType.String, ht["304_SSPUBSEL"]);
        //        dbCon.AddParameters("P_305_SSPUBSEL", DbType.String, ht["305_SSPUBSEL"]);
        //        dbCon.AddParameters("P_306_SSPUBSEL", DbType.String, ht["306_SSPUBSEL"]);
        //        dbCon.AddParameters("P_307_SSPUBSEL", DbType.String, ht["307_SSPUBSEL"]);
        //        dbCon.AddParameters("P_308_SSPUBSEL", DbType.String, ht["308_SSPUBSEL"]);
        //        dbCon.AddParameters("P_309_SSPUBSEL", DbType.String, ht["309_SSPUBSEL"]);
        //        dbCon.AddParameters("P_310_SSPUBSEL", DbType.String, ht["310_SSPUBSEL"]);
        //        dbCon.AddParameters("P_311_SSPUBSEL", DbType.String, ht["311_SSPUBSEL"]);
        //        dbCon.AddParameters("P_312_SSPUBSEL", DbType.String, ht["312_SSPUBSEL"]);
        //        dbCon.AddParameters("P_313_SSPUBSEL", DbType.String, ht["313_SSPUBSEL"]);
        //        dbCon.AddParameters("P_314_SSPUBSEL", DbType.String, ht["314_SSPUBSEL"]);
        //        dbCon.AddParameters("P_301_SSREVSEL", DbType.String, ht["301_SSREVSEL"]);
        //        dbCon.AddParameters("P_302_SSREVSEL", DbType.String, ht["302_SSREVSEL"]);
        //        dbCon.AddParameters("P_303_SSREVSEL", DbType.String, ht["303_SSREVSEL"]);
        //        dbCon.AddParameters("P_304_SSREVSEL", DbType.String, ht["304_SSREVSEL"]);
        //        dbCon.AddParameters("P_305_SSREVSEL", DbType.String, ht["305_SSREVSEL"]);
        //        dbCon.AddParameters("P_306_SSREVSEL", DbType.String, ht["306_SSREVSEL"]);
        //        dbCon.AddParameters("P_307_SSREVSEL", DbType.String, ht["307_SSREVSEL"]);
        //        dbCon.AddParameters("P_308_SSREVSEL", DbType.String, ht["308_SSREVSEL"]);
        //        dbCon.AddParameters("P_309_SSREVSEL", DbType.String, ht["309_SSREVSEL"]);
        //        dbCon.AddParameters("P_310_SSREVSEL", DbType.String, ht["310_SSREVSEL"]);
        //        dbCon.AddParameters("P_311_SSREVSEL", DbType.String, ht["311_SSREVSEL"]);
        //        dbCon.AddParameters("P_312_SSREVSEL", DbType.String, ht["312_SSREVSEL"]);
        //        dbCon.AddParameters("P_313_SSREVSEL", DbType.String, ht["313_SSREVSEL"]);
        //        dbCon.AddParameters("P_314_SSREVSEL", DbType.String, ht["314_SSREVSEL"]);
        //        dbCon.AddParameters("P_301_SSFIXSEL", DbType.String, ht["301_SSFIXSEL"]);
        //        dbCon.AddParameters("P_302_SSFIXSEL", DbType.String, ht["302_SSFIXSEL"]);
        //        dbCon.AddParameters("P_303_SSFIXSEL", DbType.String, ht["303_SSFIXSEL"]);
        //        dbCon.AddParameters("P_304_SSFIXSEL", DbType.String, ht["304_SSFIXSEL"]);
        //        dbCon.AddParameters("P_305_SSFIXSEL", DbType.String, ht["305_SSFIXSEL"]);
        //        dbCon.AddParameters("P_306_SSFIXSEL", DbType.String, ht["306_SSFIXSEL"]);
        //        dbCon.AddParameters("P_307_SSFIXSEL", DbType.String, ht["307_SSFIXSEL"]);
        //        dbCon.AddParameters("P_308_SSFIXSEL", DbType.String, ht["308_SSFIXSEL"]);
        //        dbCon.AddParameters("P_309_SSFIXSEL", DbType.String, ht["309_SSFIXSEL"]);
        //        dbCon.AddParameters("P_310_SSFIXSEL", DbType.String, ht["310_SSFIXSEL"]);
        //        dbCon.AddParameters("P_311_SSFIXSEL", DbType.String, ht["311_SSFIXSEL"]);
        //        dbCon.AddParameters("P_312_SSFIXSEL", DbType.String, ht["312_SSFIXSEL"]);
        //        dbCon.AddParameters("P_313_SSFIXSEL", DbType.String, ht["313_SSFIXSEL"]);
        //        dbCon.AddParameters("P_314_SSFIXSEL", DbType.String, ht["314_SSFIXSEL"]);
        //        dbCon.AddParameters("P_401_SSPUBSEL", DbType.String, ht["401_SSPUBSEL"]);
        //        dbCon.AddParameters("P_402_SSPUBSEL", DbType.String, ht["402_SSPUBSEL"]);
        //        dbCon.AddParameters("P_403_SSPUBSEL", DbType.String, ht["403_SSPUBSEL"]);
        //        dbCon.AddParameters("P_404_SSPUBSEL", DbType.String, ht["404_SSPUBSEL"]);
        //        dbCon.AddParameters("P_405_SSPUBSEL", DbType.String, ht["405_SSPUBSEL"]);
        //        dbCon.AddParameters("P_406_SSPUBSEL", DbType.String, ht["406_SSPUBSEL"]);
        //        dbCon.AddParameters("P_407_SSPUBSEL", DbType.String, ht["407_SSPUBSEL"]);
        //        dbCon.AddParameters("P_408_SSPUBSEL", DbType.String, ht["408_SSPUBSEL"]);
        //        dbCon.AddParameters("P_409_SSPUBSEL", DbType.String, ht["409_SSPUBSEL"]);
        //        dbCon.AddParameters("P_401_SSREVSEL", DbType.String, ht["401_SSREVSEL"]);
        //        dbCon.AddParameters("P_402_SSREVSEL", DbType.String, ht["402_SSREVSEL"]);
        //        dbCon.AddParameters("P_403_SSREVSEL", DbType.String, ht["403_SSREVSEL"]);
        //        dbCon.AddParameters("P_404_SSREVSEL", DbType.String, ht["404_SSREVSEL"]);
        //        dbCon.AddParameters("P_405_SSREVSEL", DbType.String, ht["405_SSREVSEL"]);
        //        dbCon.AddParameters("P_406_SSREVSEL", DbType.String, ht["406_SSREVSEL"]);
        //        dbCon.AddParameters("P_407_SSREVSEL", DbType.String, ht["407_SSREVSEL"]);
        //        dbCon.AddParameters("P_408_SSREVSEL", DbType.String, ht["408_SSREVSEL"]);
        //        dbCon.AddParameters("P_409_SSREVSEL", DbType.String, ht["409_SSREVSEL"]);
        //        dbCon.AddParameters("P_401_SSFIXSEL", DbType.String, ht["401_SSFIXSEL"]);
        //        dbCon.AddParameters("P_402_SSFIXSEL", DbType.String, ht["402_SSFIXSEL"]);
        //        dbCon.AddParameters("P_403_SSFIXSEL", DbType.String, ht["403_SSFIXSEL"]);
        //        dbCon.AddParameters("P_404_SSFIXSEL", DbType.String, ht["404_SSFIXSEL"]);
        //        dbCon.AddParameters("P_405_SSFIXSEL", DbType.String, ht["405_SSFIXSEL"]);
        //        dbCon.AddParameters("P_406_SSFIXSEL", DbType.String, ht["406_SSFIXSEL"]);
        //        dbCon.AddParameters("P_407_SSFIXSEL", DbType.String, ht["407_SSFIXSEL"]);
        //        dbCon.AddParameters("P_408_SSFIXSEL", DbType.String, ht["408_SSFIXSEL"]);
        //        dbCon.AddParameters("P_409_SSFIXSEL", DbType.String, ht["409_SSFIXSEL"]);
        //        dbCon.AddParameters("P_501_SSPUBSEL", DbType.String, ht["501_SSPUBSEL"]);
        //        dbCon.AddParameters("P_502_SSPUBSEL", DbType.String, ht["502_SSPUBSEL"]);
        //        dbCon.AddParameters("P_503_SSPUBSEL", DbType.String, ht["503_SSPUBSEL"]);
        //        dbCon.AddParameters("P_504_SSPUBSEL", DbType.String, ht["504_SSPUBSEL"]);
        //        dbCon.AddParameters("P_501_SSREVSEL", DbType.String, ht["501_SSREVSEL"]);
        //        dbCon.AddParameters("P_502_SSREVSEL", DbType.String, ht["502_SSREVSEL"]);
        //        dbCon.AddParameters("P_503_SSREVSEL", DbType.String, ht["503_SSREVSEL"]);
        //        dbCon.AddParameters("P_504_SSREVSEL", DbType.String, ht["504_SSREVSEL"]);
        //        dbCon.AddParameters("P_501_SSFIXSEL", DbType.String, ht["501_SSFIXSEL"]);
        //        dbCon.AddParameters("P_502_SSFIXSEL", DbType.String, ht["502_SSFIXSEL"]);
        //        dbCon.AddParameters("P_503_SSFIXSEL", DbType.String, ht["503_SSFIXSEL"]);
        //        dbCon.AddParameters("P_504_SSFIXSEL", DbType.String, ht["504_SSFIXSEL"]);
        //        dbCon.AddParameters("P_601_SSPUBSEL", DbType.String, ht["601_SSPUBSEL"]);
        //        dbCon.AddParameters("P_602_SSPUBSEL", DbType.String, ht["602_SSPUBSEL"]);
        //        dbCon.AddParameters("P_603_SSPUBSEL", DbType.String, ht["603_SSPUBSEL"]);
        //        dbCon.AddParameters("P_601_SSREVSEL", DbType.String, ht["601_SSREVSEL"]);
        //        dbCon.AddParameters("P_602_SSREVSEL", DbType.String, ht["602_SSREVSEL"]);
        //        dbCon.AddParameters("P_603_SSREVSEL", DbType.String, ht["603_SSREVSEL"]);
        //        dbCon.AddParameters("P_601_SSFIXSEL", DbType.String, ht["601_SSFIXSEL"]);
        //        dbCon.AddParameters("P_602_SSFIXSEL", DbType.String, ht["602_SSFIXSEL"]);
        //        dbCon.AddParameters("P_603_SSFIXSEL", DbType.String, ht["603_SSFIXSEL"]);
        //        dbCon.AddParameters("P_701_SSPUBSEL", DbType.String, ht["701_SSPUBSEL"]);
        //        dbCon.AddParameters("P_702_SSPUBSEL", DbType.String, ht["702_SSPUBSEL"]);
        //        dbCon.AddParameters("P_703_SSPUBSEL", DbType.String, ht["703_SSPUBSEL"]);
        //        dbCon.AddParameters("P_704_SSPUBSEL", DbType.String, ht["704_SSPUBSEL"]);
        //        dbCon.AddParameters("P_705_SSPUBSEL", DbType.String, ht["705_SSPUBSEL"]);
        //        dbCon.AddParameters("P_706_SSPUBSEL", DbType.String, ht["706_SSPUBSEL"]);
        //        dbCon.AddParameters("P_707_SSPUBSEL", DbType.String, ht["707_SSPUBSEL"]);
        //        dbCon.AddParameters("P_708_SSPUBSEL", DbType.String, ht["708_SSPUBSEL"]);
        //        dbCon.AddParameters("P_701_SSREVSEL", DbType.String, ht["701_SSREVSEL"]);
        //        dbCon.AddParameters("P_702_SSREVSEL", DbType.String, ht["702_SSREVSEL"]);
        //        dbCon.AddParameters("P_703_SSREVSEL", DbType.String, ht["703_SSREVSEL"]);
        //        dbCon.AddParameters("P_704_SSREVSEL", DbType.String, ht["704_SSREVSEL"]);
        //        dbCon.AddParameters("P_705_SSREVSEL", DbType.String, ht["705_SSREVSEL"]);
        //        dbCon.AddParameters("P_706_SSREVSEL", DbType.String, ht["706_SSREVSEL"]);
        //        dbCon.AddParameters("P_707_SSREVSEL", DbType.String, ht["707_SSREVSEL"]);
        //        dbCon.AddParameters("P_708_SSREVSEL", DbType.String, ht["708_SSREVSEL"]);
        //        dbCon.AddParameters("P_701_SSFIXSEL", DbType.String, ht["701_SSFIXSEL"]);
        //        dbCon.AddParameters("P_702_SSFIXSEL", DbType.String, ht["702_SSFIXSEL"]);
        //        dbCon.AddParameters("P_703_SSFIXSEL", DbType.String, ht["703_SSFIXSEL"]);
        //        dbCon.AddParameters("P_704_SSFIXSEL", DbType.String, ht["704_SSFIXSEL"]);
        //        dbCon.AddParameters("P_705_SSFIXSEL", DbType.String, ht["705_SSFIXSEL"]);
        //        dbCon.AddParameters("P_706_SSFIXSEL", DbType.String, ht["706_SSFIXSEL"]);
        //        dbCon.AddParameters("P_707_SSFIXSEL", DbType.String, ht["707_SSFIXSEL"]);
        //        dbCon.AddParameters("P_708_SSFIXSEL", DbType.String, ht["708_SSFIXSEL"]);
        //        dbCon.AddParameters("P_901_SSPUBSEL", DbType.String, ht["901_SSPUBSEL"]);
        //        dbCon.AddParameters("P_902_SSPUBSEL", DbType.String, ht["902_SSPUBSEL"]);
        //        dbCon.AddParameters("P_903_SSPUBSEL", DbType.String, ht["903_SSPUBSEL"]);
        //        dbCon.AddParameters("P_904_SSPUBSEL", DbType.String, ht["904_SSPUBSEL"]);
        //        dbCon.AddParameters("P_905_SSPUBSEL", DbType.String, ht["905_SSPUBSEL"]);
        //        dbCon.AddParameters("P_906_SSPUBSEL", DbType.String, ht["906_SSPUBSEL"]);
        //        dbCon.AddParameters("P_907_SSPUBSEL", DbType.String, ht["907_SSPUBSEL"]);
        //        dbCon.AddParameters("P_908_SSPUBSEL", DbType.String, ht["908_SSPUBSEL"]);
        //        dbCon.AddParameters("P_909_SSPUBSEL", DbType.String, ht["909_SSPUBSEL"]);
        //        dbCon.AddParameters("P_910_SSPUBSEL", DbType.String, ht["910_SSPUBSEL"]);
        //        dbCon.AddParameters("P_911_SSPUBSEL", DbType.String, ht["911_SSPUBSEL"]);
        //        dbCon.AddParameters("P_912_SSPUBSEL", DbType.String, ht["912_SSPUBSEL"]);
        //        dbCon.AddParameters("P_913_SSPUBSEL", DbType.String, ht["913_SSPUBSEL"]);
        //        dbCon.AddParameters("P_914_SSPUBSEL", DbType.String, ht["914_SSPUBSEL"]);
        //        dbCon.AddParameters("P_915_SSPUBSEL", DbType.String, ht["915_SSPUBSEL"]);
        //        dbCon.AddParameters("P_916_SSPUBSEL", DbType.String, ht["916_SSPUBSEL"]);
        //        dbCon.AddParameters("P_901_SSREVSEL", DbType.String, ht["901_SSREVSEL"]);
        //        dbCon.AddParameters("P_902_SSREVSEL", DbType.String, ht["902_SSREVSEL"]);
        //        dbCon.AddParameters("P_903_SSREVSEL", DbType.String, ht["903_SSREVSEL"]);
        //        dbCon.AddParameters("P_904_SSREVSEL", DbType.String, ht["904_SSREVSEL"]);
        //        dbCon.AddParameters("P_905_SSREVSEL", DbType.String, ht["905_SSREVSEL"]);
        //        dbCon.AddParameters("P_906_SSREVSEL", DbType.String, ht["906_SSREVSEL"]);
        //        dbCon.AddParameters("P_907_SSREVSEL", DbType.String, ht["907_SSREVSEL"]);
        //        dbCon.AddParameters("P_908_SSREVSEL", DbType.String, ht["908_SSREVSEL"]);
        //        dbCon.AddParameters("P_909_SSREVSEL", DbType.String, ht["909_SSREVSEL"]);
        //        dbCon.AddParameters("P_910_SSREVSEL", DbType.String, ht["910_SSREVSEL"]);
        //        dbCon.AddParameters("P_911_SSREVSEL", DbType.String, ht["911_SSREVSEL"]);
        //        dbCon.AddParameters("P_912_SSREVSEL", DbType.String, ht["912_SSREVSEL"]);
        //        dbCon.AddParameters("P_913_SSREVSEL", DbType.String, ht["913_SSREVSEL"]);
        //        dbCon.AddParameters("P_914_SSREVSEL", DbType.String, ht["914_SSREVSEL"]);
        //        dbCon.AddParameters("P_915_SSREVSEL", DbType.String, ht["915_SSREVSEL"]);
        //        dbCon.AddParameters("P_916_SSREVSEL", DbType.String, ht["916_SSREVSEL"]);
        //        dbCon.AddParameters("P_901_SSFIXSEL", DbType.String, ht["901_SSFIXSEL"]);
        //        dbCon.AddParameters("P_902_SSFIXSEL", DbType.String, ht["902_SSFIXSEL"]);
        //        dbCon.AddParameters("P_903_SSFIXSEL", DbType.String, ht["903_SSFIXSEL"]);
        //        dbCon.AddParameters("P_904_SSFIXSEL", DbType.String, ht["904_SSFIXSEL"]);
        //        dbCon.AddParameters("P_905_SSFIXSEL", DbType.String, ht["905_SSFIXSEL"]);
        //        dbCon.AddParameters("P_906_SSFIXSEL", DbType.String, ht["906_SSFIXSEL"]);
        //        dbCon.AddParameters("P_907_SSFIXSEL", DbType.String, ht["907_SSFIXSEL"]);
        //        dbCon.AddParameters("P_908_SSFIXSEL", DbType.String, ht["908_SSFIXSEL"]);
        //        dbCon.AddParameters("P_909_SSFIXSEL", DbType.String, ht["909_SSFIXSEL"]);
        //        dbCon.AddParameters("P_910_SSFIXSEL", DbType.String, ht["910_SSFIXSEL"]);
        //        dbCon.AddParameters("P_911_SSFIXSEL", DbType.String, ht["911_SSFIXSEL"]);
        //        dbCon.AddParameters("P_912_SSFIXSEL", DbType.String, ht["912_SSFIXSEL"]);
        //        dbCon.AddParameters("P_913_SSFIXSEL", DbType.String, ht["913_SSFIXSEL"]);
        //        dbCon.AddParameters("P_914_SSFIXSEL", DbType.String, ht["914_SSFIXSEL"]);
        //        dbCon.AddParameters("P_915_SSFIXSEL", DbType.String, ht["915_SSFIXSEL"]);
        //        dbCon.AddParameters("P_916_SSFIXSEL", DbType.String, ht["916_SSFIXSEL"]);




















        //        //dbCon.AddParameters("P_SMWKTEAM", DbType.VarNumeric, ht["P_SMWKTEAM"]);
        //        //dbCon.AddParameters("P_SMWKDATE", DbType.VarNumeric, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        //dbCon.AddParameters("P_SMWKSEQ", DbType.String, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        //dbCon.AddParameters("P_SMWKORAPPDATE", DbType.VarNumeric, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        //dbCon.AddParameters("P_SMWKORSEQ", DbType.String, Set_Fill3(sSMWKORSEQ));
        //        //dbCon.AddParameters("P_SMREVTEAM", DbType.VarNumeric, ht["P_SMREVTEAM"]);
        //        //dbCon.AddParameters("P_SMWKMETHOD", DbType.VarNumeric, ht["P_SMWKMETHOD"]);
        //        //dbCon.AddParameters("P_SMSUBVEND", DbType.VarNumeric, ht["P_SMSUBVEND"]);
        //        //dbCon.AddParameters("P_SMSUBPERSON", DbType.VarNumeric, ht["P_SMSUBPERSON"]);
        //        //dbCon.AddParameters("P_SMSUBTEL", DbType.VarNumeric, ht["P_SMSUBTEL"]);
        //        //dbCon.AddParameters("P_SMRESSABUN", DbType.VarNumeric, ht["P_SMRESSABUN"]);
        //        //dbCon.AddParameters("P_SMWKMAN", DbType.VarNumeric, ht["P_SMWKMAN"]);
        //        //dbCon.AddParameters("P_SMTADATE1", DbType.VarNumeric, ht["P_SMTADATE1"]);
        //        //dbCon.AddParameters("P_SMTATIME1", DbType.VarNumeric, ht["P_SMTATIME1"]);
        //        //dbCon.AddParameters("P_SMTADATE2", DbType.VarNumeric, ht["P_SMTADATE2"]);
        //        //dbCon.AddParameters("P_SMTATIME2", DbType.VarNumeric, ht["P_SMTATIME2"]);
        //        //dbCon.AddParameters("P_SMOTDATE1", DbType.VarNumeric, ht["P_SMOTDATE1"]);
        //        //dbCon.AddParameters("P_SMOTTIME1", DbType.VarNumeric, ht["P_SMOTTIME1"]);
        //        //dbCon.AddParameters("P_SMOTDATE2", DbType.VarNumeric, ht["P_SMOTDATE2"]);
        //        //dbCon.AddParameters("P_SMOTTIME2", DbType.VarNumeric, ht["P_SMOTTIME2"]);
        //        //dbCon.AddParameters("P_SMOTAPPSABUN", DbType.VarNumeric, ht["P_SMOTAPPSABUN"]);
        //        //dbCon.AddParameters("P_SMSYSTEMCODE1", DbType.VarNumeric, ht["P_SMSYSTEMCODE1"]);
        //        //dbCon.AddParameters("P_SMSYSTEMCODE2", DbType.VarNumeric, ht["P_SMSYSTEMCODE2"]);
        //        //dbCon.AddParameters("P_SMSYSTEMCODE3", DbType.VarNumeric, ht["P_SMSYSTEMCODE3"]);
        //        //dbCon.AddParameters("P_SMSYSTEMCODE4", DbType.VarNumeric, ht["P_SMSYSTEMCODE4"]);
        //        //dbCon.AddParameters("P_SMSYSTEMCODE5", DbType.VarNumeric, ht["P_SMSYSTEMCODE5"]);
        //        //dbCon.AddParameters("P_SMCONNCODE11", DbType.VarNumeric, ht["P_SMCONNCODE11"]);
        //        //dbCon.AddParameters("P_SMCONNCODE12", DbType.VarNumeric, ht["P_SMCONNCODE12"]);
        //        //dbCon.AddParameters("P_SMCONNCODE21", DbType.VarNumeric, ht["P_SMCONNCODE21"]);
        //        //dbCon.AddParameters("P_SMCONNCODE22", DbType.VarNumeric, ht["P_SMCONNCODE22"]);
        //        //dbCon.AddParameters("P_SMCONNCODE31", DbType.VarNumeric, ht["P_SMCONNCODE31"]);
        //        //dbCon.AddParameters("P_SMCONNCODE32", DbType.VarNumeric, ht["P_SMCONNCODE32"]);
        //        //dbCon.AddParameters("P_SMCONNCODE41", DbType.VarNumeric, ht["P_SMCONNCODE41"]);
        //        //dbCon.AddParameters("P_SMCONNCODE42", DbType.VarNumeric, ht["P_SMCONNCODE42"]);
        //        //dbCon.AddParameters("P_SMCONNCODE51", DbType.VarNumeric, ht["P_SMCONNCODE51"]);
        //        //dbCon.AddParameters("P_SMCONNCODE52", DbType.VarNumeric, ht["P_SMCONNCODE52"]);
        //        //dbCon.AddParameters("P_SMAREACODE1", DbType.VarNumeric, ht["P_SMAREACODE1"]);
        //        //dbCon.AddParameters("P_SMAREACODE2", DbType.VarNumeric, ht["P_SMAREACODE2"]);
        //        //dbCon.AddParameters("P_SMAREACODE3", DbType.VarNumeric, ht["P_SMAREACODE3"]);
        //        //dbCon.AddParameters("P_SMAREACODE4", DbType.VarNumeric, ht["P_SMAREACODE4"]);
        //        //dbCon.AddParameters("P_SMAREACODE5", DbType.VarNumeric, ht["P_SMAREACODE5"]);
        //        //dbCon.AddParameters("P_SMAREATEXT1", DbType.VarNumeric, ht["P_SMAREATEXT1"]);
        //        //dbCon.AddParameters("P_SMAREATEXT2", DbType.VarNumeric, ht["P_SMAREATEXT2"]);
        //        //dbCon.AddParameters("P_SMAREATEXT3", DbType.VarNumeric, ht["P_SMAREATEXT3"]);
        //        //dbCon.AddParameters("P_SMAREATEXT4", DbType.VarNumeric, ht["P_SMAREATEXT4"]);
        //        //dbCon.AddParameters("P_SMAREATEXT5", DbType.VarNumeric, ht["P_SMAREATEXT5"]);
        //        //dbCon.AddParameters("P_SMMATERTEXT1", DbType.VarNumeric, ht["P_SMMATERTEXT1"]);
        //        //dbCon.AddParameters("P_SMMATERTEXT2", DbType.VarNumeric, ht["P_SMMATERTEXT2"]);
        //        //dbCon.AddParameters("P_SMNOTE_BURN", DbType.VarNumeric, ht["P_SMNOTE_BURN"]);
        //        //dbCon.AddParameters("P_SMNOTE_SUFF", DbType.VarNumeric, ht["P_SMNOTE_SUFF"]);
        //        //dbCon.AddParameters("P_SMNOTE_ELE", DbType.VarNumeric, ht["P_SMNOTE_ELE"]);
        //        //dbCon.AddParameters("P_SMNOTE_FIR", DbType.VarNumeric, ht["P_SMNOTE_FIR"]);
        //        //dbCon.AddParameters("P_SMNOTE_EXP", DbType.VarNumeric, ht["P_SMNOTE_EXP"]);
        //        //dbCon.AddParameters("P_SMNOTE_DROP", DbType.VarNumeric, ht["P_SMNOTE_DROP"]);
        //        //dbCon.AddParameters("P_SMNOTE_LEAK", DbType.VarNumeric, ht["P_SMNOTE_LEAK"]);
        //        //dbCon.AddParameters("P_SMNOTE_NARR", DbType.VarNumeric, ht["P_SMNOTE_NARR"]);
        //        //dbCon.AddParameters("P_SMNOTE_COLL", DbType.VarNumeric, ht["P_SMNOTE_COLL"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN1", DbType.VarNumeric, ht["P_SMCHKSABUN1"]);
        //        //dbCon.AddParameters("P_SMCHKTIME1", DbType.VarNumeric, ht["P_SMCHKTIME1"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN1", DbType.VarNumeric, ht["P_SMCHKOXYGEN1"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT1", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT1"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM1", DbType.String, ht["P_SMCHKTOXNUM1"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT1", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM1DS", DbType.String, ht["P_SMCHKTOXNUM1DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT1DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM1CO2", DbType.String, ht["P_SMCHKTOXNUM1CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT1CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM1CO", DbType.String, ht["P_SMCHKTOXNUM1CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT1CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM1H2S", DbType.String, ht["P_SMCHKTOXNUM1H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT1H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1H2S"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN2", DbType.VarNumeric, ht["P_SMCHKSABUN2"]);
        //        //dbCon.AddParameters("P_SMCHKTIME2", DbType.VarNumeric, ht["P_SMCHKTIME2"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN2", DbType.VarNumeric, ht["P_SMCHKOXYGEN2"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT2", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM2", DbType.String, ht["P_SMCHKTOXNUM2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM2DS", DbType.String, ht["P_SMCHKTOXNUM2DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT2DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM2CO2", DbType.String, ht["P_SMCHKTOXNUM2CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT2CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM2CO", DbType.String, ht["P_SMCHKTOXNUM2CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT2CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM2H2S", DbType.String, ht["P_SMCHKTOXNUM2H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT2H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2H2S"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN3", DbType.VarNumeric, ht["P_SMCHKSABUN3"]);
        //        //dbCon.AddParameters("P_SMCHKTIME3", DbType.VarNumeric, ht["P_SMCHKTIME3"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN3", DbType.VarNumeric, ht["P_SMCHKOXYGEN3"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT3", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT3"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM3", DbType.String, ht["P_SMCHKTOXNUM3"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT3", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM3DS", DbType.String, ht["P_SMCHKTOXNUM3DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT3DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM3CO2", DbType.String, ht["P_SMCHKTOXNUM3CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT3CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM3CO", DbType.String, ht["P_SMCHKTOXNUM3CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT3CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM3H2S", DbType.String, ht["P_SMCHKTOXNUM3H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT3H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3H2S"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN4", DbType.VarNumeric, ht["P_SMCHKSABUN4"]);
        //        //dbCon.AddParameters("P_SMCHKTIME4", DbType.VarNumeric, ht["P_SMCHKTIME4"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN4", DbType.VarNumeric, ht["P_SMCHKOXYGEN4"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT4", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT4"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM4", DbType.String, ht["P_SMCHKTOXNUM4"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT4", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM4DS", DbType.String, ht["P_SMCHKTOXNUM4DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT4DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM4CO2", DbType.String, ht["P_SMCHKTOXNUM4CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT4CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM4CO", DbType.String, ht["P_SMCHKTOXNUM4CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT4CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM4H2S", DbType.String, ht["P_SMCHKTOXNUM4H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT4H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4H2S"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN5", DbType.VarNumeric, ht["P_SMCHKSABUN5"]);
        //        //dbCon.AddParameters("P_SMCHKTIME5", DbType.VarNumeric, ht["P_SMCHKTIME5"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN5", DbType.VarNumeric, ht["P_SMCHKOXYGEN5"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT5", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT5"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM5", DbType.String, ht["P_SMCHKTOXNUM5"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT5", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM5DS", DbType.String, ht["P_SMCHKTOXNUM5DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT5DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM5CO2", DbType.String, ht["P_SMCHKTOXNUM5CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT5CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM5CO", DbType.String, ht["P_SMCHKTOXNUM5CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT5CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM5H2S", DbType.String, ht["P_SMCHKTOXNUM5H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT5H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5H2S"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN6", DbType.VarNumeric, ht["P_SMCHKSABUN6"]);
        //        //dbCon.AddParameters("P_SMCHKTIME6", DbType.VarNumeric, ht["P_SMCHKTIME6"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN6", DbType.VarNumeric, ht["P_SMCHKOXYGEN6"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT6", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT6"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM6", DbType.String, ht["P_SMCHKTOXNUM6"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT6", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM6DS", DbType.String, ht["P_SMCHKTOXNUM6DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT6DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM6CO2", DbType.String, ht["P_SMCHKTOXNUM6CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT6CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM6CO", DbType.String, ht["P_SMCHKTOXNUM6CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT6CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM6H2S", DbType.String, ht["P_SMCHKTOXNUM6H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT6H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6H2S"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN7", DbType.VarNumeric, ht["P_SMCHKSABUN7"]);
        //        //dbCon.AddParameters("P_SMCHKTIME7", DbType.VarNumeric, ht["P_SMCHKTIME7"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN7", DbType.VarNumeric, ht["P_SMCHKOXYGEN7"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT7", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT7"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM7", DbType.String, ht["P_SMCHKTOXNUM7"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT7", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM7DS", DbType.String, ht["P_SMCHKTOXNUM7DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT7DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM7CO2", DbType.String, ht["P_SMCHKTOXNUM7CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT7CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM7CO", DbType.String, ht["P_SMCHKTOXNUM7CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT7CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM7H2S", DbType.String, ht["P_SMCHKTOXNUM7H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT7H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7H2S"]);
        //        //dbCon.AddParameters("P_SMCHKSABUN8", DbType.VarNumeric, ht["P_SMCHKSABUN8"]);
        //        //dbCon.AddParameters("P_SMCHKTIME8", DbType.VarNumeric, ht["P_SMCHKTIME8"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGEN8", DbType.VarNumeric, ht["P_SMCHKOXYGEN8"]);
        //        //dbCon.AddParameters("P_SMCHKOXYGENUNIT8", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT8"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM8", DbType.String, ht["P_SMCHKTOXNUM8"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT8", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM8DS", DbType.String, ht["P_SMCHKTOXNUM8DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT8DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8DS"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM8CO2", DbType.String, ht["P_SMCHKTOXNUM8CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT8CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8CO2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM8CO", DbType.String, ht["P_SMCHKTOXNUM8CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT8CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8CO"]);
        //        //dbCon.AddParameters("P_SMCHKTOXNUM8H2S", DbType.String, ht["P_SMCHKTOXNUM8H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXUNIT8H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8H2S"]);
        //        //dbCon.AddParameters("P_SMCHKTOXGUBN1", DbType.VarNumeric, ht["P_SMCHKTOXGUBN1"]);
        //        //dbCon.AddParameters("P_SMCHKTOXGUBN2", DbType.VarNumeric, ht["P_SMCHKTOXGUBN2"]);
        //        //dbCon.AddParameters("P_SMCHKTOXGUBN3", DbType.VarNumeric, ht["P_SMCHKTOXGUBN3"]);
        //        //dbCon.AddParameters("P_SMCHKTOXGUBN4", DbType.VarNumeric, ht["P_SMCHKTOXGUBN4"]);
        //        //dbCon.AddParameters("P_SMCHKTOXGUBN5", DbType.VarNumeric, ht["P_SMCHKTOXGUBN5"]);
        //        //dbCon.AddParameters("P_SMCHKTOXGUBN6", DbType.VarNumeric, ht["P_SMCHKTOXGUBN6"]);
        //        //dbCon.AddParameters("P_SMORDERTEXT1 ", DbType.VarNumeric, ht["P_SMORDERTEXT1 "]);
        //        //dbCon.AddParameters("P_SMORDERTEXT2", DbType.VarNumeric, ht["P_SMORDERTEXT2"]);
        //        //dbCon.AddParameters("P_SMORSABUN", DbType.VarNumeric, ht["P_SMORSABUN"]);
        //        //dbCon.AddParameters("P_SMORNAME", DbType.VarNumeric, ht["P_SMORNAME"]);
        //        //dbCon.AddParameters("P_SMORJKCD", DbType.VarNumeric, ht["P_SMORJKCD"]);
        //        //dbCon.AddParameters("P_SMORJKCDNM", DbType.VarNumeric, ht["P_SMORJKCDNM"]);
        //        //dbCon.AddParameters("P_SMGRSABUN", DbType.VarNumeric, ht["P_SMGRSABUN"]);
        //        //dbCon.AddParameters("P_SMGRNAME", DbType.VarNumeric, ht["P_SMGRNAME"]);
        //        //dbCon.AddParameters("P_SMGRJKCD", DbType.VarNumeric, ht["P_SMGRJKCD"]);
        //        //dbCon.AddParameters("P_SMGRJKCDNM", DbType.VarNumeric, ht["P_SMGRJKCDNM"]);
        //        //dbCon.AddParameters("P_SMCOSABUN", DbType.VarNumeric, ht["P_SMCOSABUN"]);
        //        //dbCon.AddParameters("P_SMCONAME", DbType.VarNumeric, ht["P_SMCONAME"]);
        //        //dbCon.AddParameters("P_SMCOJKCD", DbType.VarNumeric, ht["P_SMCOJKCD"]);
        //        //dbCon.AddParameters("P_SMCOJKCDNM", DbType.VarNumeric, ht["P_SMCOJKCDNM"]);
        //        //dbCon.AddParameters("P_SMSMSABUN", DbType.VarNumeric, ht["P_SMSMSABUN"]);
        //        //dbCon.AddParameters("P_SMSMCOMMENT", DbType.VarNumeric, ht["P_SMSMCOMMENT"]);
        //        //dbCon.AddParameters("P_SMWORKTITLE", DbType.VarNumeric, ht["P_SMWORKTITLE"]);
        //        //dbCon.AddParameters("P_SMOPSABUN", DbType.VarNumeric, ht["P_SMOPSABUN"]);
        //        //dbCon.AddParameters("P_SMOPCOMMENT", DbType.VarNumeric, ht["P_SMOPCOMMENT"]);
        //        //dbCon.AddParameters("P_RESABUN", DbType.VarNumeric, ht["P_RESABUN"]);
        //        //dbCon.AddParameters("P_RENAME", DbType.VarNumeric, ht["P_RENAME"]);
        //        //dbCon.AddParameters("P_SMHISAB", DbType.VarNumeric, ht["P_SMHISAB"]);
        //        //dbCon.AddParameters("P_WKGUBUN", DbType.VarNumeric, ht["P_WKGUBUN"]);
        //        //dbCon.AddParameters("P_GUBUN", DbType.VarNumeric, ht["P_GUBUN"]);

        //        //dbCon.AddParameters("P_SWWKCODE1", DbType.VarNumeric, ht["P_SWWKCODE1"]);
        //        //dbCon.AddParameters("P_SWWKCODE2", DbType.VarNumeric, ht["P_SWWKCODE2"]);
        //        //dbCon.AddParameters("P_SWWKCODE3", DbType.VarNumeric, ht["P_SWWKCODE3"]);
        //        //dbCon.AddParameters("P_SWWKCODE4", DbType.VarNumeric, ht["P_SWWKCODE4"]);
        //        //dbCon.AddParameters("P_SWWKCODE5", DbType.VarNumeric, ht["P_SWWKCODE5"]);
        //        //dbCon.AddParameters("P_SWWKCODE6", DbType.VarNumeric, ht["P_SWWKCODE6"]);
        //        //dbCon.AddParameters("P_SWWKCODE7", DbType.VarNumeric, ht["P_SWWKCODE7"]);
        //        //dbCon.AddParameters("P_SWWKCODE8", DbType.VarNumeric, ht["P_SWWKCODE8"]);
        //        //dbCon.AddParameters("P_SWWKCODE9", DbType.VarNumeric, ht["P_SWWKCODE9"]);
        //        //dbCon.AddParameters("P_SWWKCODE10", DbType.VarNumeric, ht["P_SWWKCODE10"]);

        //        //dbCon.AddParameters("P_SITE", DbType.VarNumeric, ht["P_SITE"]);


        //        //dbCon.AddParameters("P_801_DRCODE", DbType.VarNumeric, ht["801_DRCODE"]);
        //        //dbCon.AddParameters("P_801_DRCODENAME", DbType.VarNumeric, ht["801_DRCODENAME"]);
        //        //dbCon.AddParameters("P_801_DRYESSEL", DbType.VarNumeric, ht["801_DRYESSEL"]);
        //        //dbCon.AddParameters("P_801_DRNOSEL", DbType.VarNumeric, ht["801_DRNOSEL"]);
        //        //dbCon.AddParameters("P_801_DRNASEL", DbType.VarNumeric, ht["801_DRNASEL"]);
        //        //dbCon.AddParameters("P_801_DRSORT", DbType.VarNumeric, ht["801_DRSORT"]);
        //        //dbCon.AddParameters("P_801_DRSTAND", DbType.VarNumeric, ht["801_DRSTAND"]);
        //        //dbCon.AddParameters("P_801_DRDEPTH", DbType.VarNumeric, ht["801_DRDEPTH"]);
        //        //dbCon.AddParameters("P_801_DRSABUN", DbType.VarNumeric, ht["801_DRSABUN"]);

        //        //dbCon.AddParameters("P_802_DRCODE", DbType.VarNumeric, ht["802_DRCODE"]);
        //        //dbCon.AddParameters("P_802_DRCODENAME", DbType.VarNumeric, ht["802_DRCODENAME"]);
        //        //dbCon.AddParameters("P_802_DRYESSEL", DbType.VarNumeric, ht["802_DRYESSEL"]);
        //        //dbCon.AddParameters("P_802_DRNOSEL", DbType.VarNumeric, ht["802_DRNOSEL"]);
        //        //dbCon.AddParameters("P_802_DRNASEL", DbType.VarNumeric, ht["802_DRNASEL"]);
        //        //dbCon.AddParameters("P_802_DRSORT", DbType.VarNumeric, ht["802_DRSORT"]);
        //        //dbCon.AddParameters("P_802_DRSTAND", DbType.VarNumeric, ht["802_DRSTAND"]);
        //        //dbCon.AddParameters("P_802_DRDEPTH", DbType.VarNumeric, ht["802_DRDEPTH"]);
        //        //dbCon.AddParameters("P_802_DRSABUN", DbType.VarNumeric, ht["802_DRSABUN"]);

        //        //dbCon.AddParameters("P_803_DRCODE", DbType.VarNumeric, ht["803_DRCODE"]);
        //        //dbCon.AddParameters("P_803_DRCODENAME", DbType.VarNumeric, ht["803_DRCODENAME"]);
        //        //dbCon.AddParameters("P_803_DRYESSEL", DbType.VarNumeric, ht["803_DRYESSEL"]);
        //        //dbCon.AddParameters("P_803_DRNOSEL", DbType.VarNumeric, ht["803_DRNOSEL"]);
        //        //dbCon.AddParameters("P_803_DRNASEL", DbType.VarNumeric, ht["803_DRNASEL"]);
        //        //dbCon.AddParameters("P_803_DRSORT", DbType.VarNumeric, ht["803_DRSORT"]);
        //        //dbCon.AddParameters("P_803_DRSTAND", DbType.VarNumeric, ht["803_DRSTAND"]);
        //        //dbCon.AddParameters("P_803_DRDEPTH", DbType.VarNumeric, ht["803_DRDEPTH"]);
        //        //dbCon.AddParameters("P_803_DRSABUN", DbType.VarNumeric, ht["803_DRSABUN"]);

        //        //dbCon.AddParameters("P_804_DRCODE", DbType.VarNumeric, ht["804_DRCODE"]);
        //        //dbCon.AddParameters("P_804_DRCODENAME", DbType.VarNumeric, ht["804_DRCODENAME"]);
        //        //dbCon.AddParameters("P_804_DRYESSEL", DbType.VarNumeric, ht["804_DRYESSEL"]);
        //        //dbCon.AddParameters("P_804_DRNOSEL", DbType.VarNumeric, ht["804_DRNOSEL"]);
        //        //dbCon.AddParameters("P_804_DRNASEL", DbType.VarNumeric, ht["804_DRNASEL"]);
        //        //dbCon.AddParameters("P_804_DRSORT", DbType.VarNumeric, ht["804_DRSORT"]);
        //        //dbCon.AddParameters("P_804_DRSTAND", DbType.VarNumeric, ht["804_DRSTAND"]);
        //        //dbCon.AddParameters("P_804_DRDEPTH", DbType.VarNumeric, ht["804_DRDEPTH"]);
        //        //dbCon.AddParameters("P_804_DRSABUN", DbType.VarNumeric, ht["804_DRSABUN"]);

        //        //dbCon.AddParameters("P_805_DRCODE", DbType.VarNumeric, ht["805_DRCODE"]);
        //        //dbCon.AddParameters("P_805_DRCODENAME", DbType.VarNumeric, ht["805_DRCODENAME"]);
        //        //dbCon.AddParameters("P_805_DRYESSEL", DbType.VarNumeric, ht["805_DRYESSEL"]);
        //        //dbCon.AddParameters("P_805_DRNOSEL", DbType.VarNumeric, ht["805_DRNOSEL"]);
        //        //dbCon.AddParameters("P_805_DRNASEL", DbType.VarNumeric, ht["805_DRNASEL"]);
        //        //dbCon.AddParameters("P_805_DRSORT", DbType.VarNumeric, ht["805_DRSORT"]);
        //        //dbCon.AddParameters("P_805_DRSTAND", DbType.VarNumeric, ht["805_DRSTAND"]);
        //        //dbCon.AddParameters("P_805_DRDEPTH", DbType.VarNumeric, ht["805_DRDEPTH"]);
        //        //dbCon.AddParameters("P_805_DRSABUN", DbType.VarNumeric, ht["805_DRSABUN"]);

        //        //dbCon.AddParameters("P_101_SACODE", DbType.VarNumeric, ht["101_SACODE"]);
        //        //dbCon.AddParameters("P_102_SACODE", DbType.VarNumeric, ht["102_SACODE"]);
        //        //dbCon.AddParameters("P_103_SACODE", DbType.VarNumeric, ht["103_SACODE"]);
        //        //dbCon.AddParameters("P_104_SACODE", DbType.VarNumeric, ht["104_SACODE"]);
        //        //dbCon.AddParameters("P_105_SACODE", DbType.VarNumeric, ht["105_SACODE"]);
        //        //dbCon.AddParameters("P_106_SACODE", DbType.VarNumeric, ht["106_SACODE"]);
        //        //dbCon.AddParameters("P_107_SACODE", DbType.VarNumeric, ht["107_SACODE"]);
        //        //dbCon.AddParameters("P_108_SACODE", DbType.VarNumeric, ht["108_SACODE"]);
        //        //dbCon.AddParameters("P_109_SACODE", DbType.VarNumeric, ht["109_SACODE"]);
        //        //dbCon.AddParameters("P_110_SACODE", DbType.VarNumeric, ht["110_SACODE"]);
        //        //dbCon.AddParameters("P_111_SACODE", DbType.VarNumeric, ht["111_SACODE"]);
        //        //dbCon.AddParameters("P_112_SACODE", DbType.VarNumeric, ht["112_SACODE"]);
        //        //dbCon.AddParameters("P_113_SACODE", DbType.VarNumeric, ht["113_SACODE"]);
        //        //dbCon.AddParameters("P_114_SACODE", DbType.VarNumeric, ht["114_SACODE"]);
        //        //dbCon.AddParameters("P_115_SACODE", DbType.VarNumeric, ht["115_SACODE"]);
        //        //dbCon.AddParameters("P_116_SACODE", DbType.VarNumeric, ht["116_SACODE"]);
        //        //dbCon.AddParameters("P_201_SACODE", DbType.VarNumeric, ht["201_SACODE"]);
        //        //dbCon.AddParameters("P_202_SACODE", DbType.VarNumeric, ht["202_SACODE"]);
        //        //dbCon.AddParameters("P_203_SACODE", DbType.VarNumeric, ht["203_SACODE"]);
        //        //dbCon.AddParameters("P_204_SACODE", DbType.VarNumeric, ht["204_SACODE"]);
        //        //dbCon.AddParameters("P_205_SACODE", DbType.VarNumeric, ht["205_SACODE"]);
        //        //dbCon.AddParameters("P_206_SACODE", DbType.VarNumeric, ht["206_SACODE"]);
        //        //dbCon.AddParameters("P_207_SACODE", DbType.VarNumeric, ht["207_SACODE"]);
        //        //dbCon.AddParameters("P_208_SACODE", DbType.VarNumeric, ht["208_SACODE"]);
        //        //dbCon.AddParameters("P_209_SACODE", DbType.VarNumeric, ht["209_SACODE"]);
        //        //dbCon.AddParameters("P_210_SACODE", DbType.VarNumeric, ht["210_SACODE"]);
        //        //dbCon.AddParameters("P_211_SACODE", DbType.VarNumeric, ht["211_SACODE"]);
        //        //dbCon.AddParameters("P_212_SACODE", DbType.VarNumeric, ht["212_SACODE"]);
        //        //dbCon.AddParameters("P_213_SACODE", DbType.VarNumeric, ht["213_SACODE"]);
        //        //dbCon.AddParameters("P_214_SACODE", DbType.VarNumeric, ht["214_SACODE"]);
        //        //dbCon.AddParameters("P_215_SACODE", DbType.VarNumeric, ht["215_SACODE"]);
        //        //dbCon.AddParameters("P_216_SACODE", DbType.VarNumeric, ht["216_SACODE"]);
        //        //dbCon.AddParameters("P_217_SACODE", DbType.VarNumeric, ht["217_SACODE"]);
        //        //dbCon.AddParameters("P_218_SACODE", DbType.VarNumeric, ht["218_SACODE"]);
        //        //dbCon.AddParameters("P_301_SACODE", DbType.VarNumeric, ht["301_SACODE"]);
        //        //dbCon.AddParameters("P_302_SACODE", DbType.VarNumeric, ht["302_SACODE"]);
        //        //dbCon.AddParameters("P_303_SACODE", DbType.VarNumeric, ht["303_SACODE"]);
        //        //dbCon.AddParameters("P_304_SACODE", DbType.VarNumeric, ht["304_SACODE"]);
        //        //dbCon.AddParameters("P_305_SACODE", DbType.VarNumeric, ht["305_SACODE"]);
        //        //dbCon.AddParameters("P_306_SACODE", DbType.VarNumeric, ht["306_SACODE"]);
        //        //dbCon.AddParameters("P_307_SACODE", DbType.VarNumeric, ht["307_SACODE"]);
        //        //dbCon.AddParameters("P_308_SACODE", DbType.VarNumeric, ht["308_SACODE"]);
        //        //dbCon.AddParameters("P_309_SACODE", DbType.VarNumeric, ht["309_SACODE"]);
        //        //dbCon.AddParameters("P_310_SACODE", DbType.VarNumeric, ht["310_SACODE"]);
        //        //dbCon.AddParameters("P_311_SACODE", DbType.VarNumeric, ht["311_SACODE"]);
        //        //dbCon.AddParameters("P_312_SACODE", DbType.VarNumeric, ht["312_SACODE"]);
        //        //dbCon.AddParameters("P_313_SACODE", DbType.VarNumeric, ht["313_SACODE"]);
        //        //dbCon.AddParameters("P_314_SACODE", DbType.VarNumeric, ht["314_SACODE"]);
        //        //dbCon.AddParameters("P_401_SACODE", DbType.VarNumeric, ht["401_SACODE"]);
        //        //dbCon.AddParameters("P_402_SACODE", DbType.VarNumeric, ht["402_SACODE"]);
        //        //dbCon.AddParameters("P_403_SACODE", DbType.VarNumeric, ht["403_SACODE"]);
        //        //dbCon.AddParameters("P_404_SACODE", DbType.VarNumeric, ht["404_SACODE"]);
        //        //dbCon.AddParameters("P_405_SACODE", DbType.VarNumeric, ht["405_SACODE"]);
        //        //dbCon.AddParameters("P_406_SACODE", DbType.VarNumeric, ht["406_SACODE"]);
        //        //dbCon.AddParameters("P_407_SACODE", DbType.VarNumeric, ht["407_SACODE"]);
        //        //dbCon.AddParameters("P_408_SACODE", DbType.VarNumeric, ht["408_SACODE"]);
        //        //dbCon.AddParameters("P_409_SACODE", DbType.VarNumeric, ht["409_SACODE"]);
        //        //dbCon.AddParameters("P_501_SACODE", DbType.VarNumeric, ht["501_SACODE"]);
        //        //dbCon.AddParameters("P_502_SACODE", DbType.VarNumeric, ht["502_SACODE"]);
        //        //dbCon.AddParameters("P_503_SACODE", DbType.VarNumeric, ht["503_SACODE"]);
        //        //dbCon.AddParameters("P_504_SACODE", DbType.VarNumeric, ht["504_SACODE"]);
        //        //dbCon.AddParameters("P_601_SACODE", DbType.VarNumeric, ht["601_SACODE"]);
        //        //dbCon.AddParameters("P_602_SACODE", DbType.VarNumeric, ht["602_SACODE"]);
        //        //dbCon.AddParameters("P_603_SACODE", DbType.VarNumeric, ht["603_SACODE"]);
        //        //dbCon.AddParameters("P_701_SACODE", DbType.VarNumeric, ht["701_SACODE"]);
        //        //dbCon.AddParameters("P_702_SACODE", DbType.VarNumeric, ht["702_SACODE"]);
        //        //dbCon.AddParameters("P_703_SACODE", DbType.VarNumeric, ht["703_SACODE"]);
        //        //dbCon.AddParameters("P_704_SACODE", DbType.VarNumeric, ht["704_SACODE"]);
        //        //dbCon.AddParameters("P_705_SACODE", DbType.VarNumeric, ht["705_SACODE"]);
        //        //dbCon.AddParameters("P_706_SACODE", DbType.VarNumeric, ht["706_SACODE"]);
        //        //dbCon.AddParameters("P_707_SACODE", DbType.VarNumeric, ht["707_SACODE"]);
        //        //dbCon.AddParameters("P_708_SACODE", DbType.VarNumeric, ht["708_SACODE"]);
        //        //dbCon.AddParameters("P_901_SACODE", DbType.VarNumeric, ht["901_SACODE"]);
        //        //dbCon.AddParameters("P_902_SACODE", DbType.VarNumeric, ht["902_SACODE"]);
        //        //dbCon.AddParameters("P_903_SACODE", DbType.VarNumeric, ht["903_SACODE"]);
        //        //dbCon.AddParameters("P_904_SACODE", DbType.VarNumeric, ht["904_SACODE"]);
        //        //dbCon.AddParameters("P_905_SACODE", DbType.VarNumeric, ht["905_SACODE"]);
        //        //dbCon.AddParameters("P_906_SACODE", DbType.VarNumeric, ht["906_SACODE"]);
        //        //dbCon.AddParameters("P_907_SACODE", DbType.VarNumeric, ht["907_SACODE"]);
        //        //dbCon.AddParameters("P_908_SACODE", DbType.VarNumeric, ht["908_SACODE"]);
        //        //dbCon.AddParameters("P_909_SACODE", DbType.VarNumeric, ht["909_SACODE"]);
        //        //dbCon.AddParameters("P_910_SACODE", DbType.VarNumeric, ht["910_SACODE"]);
        //        //dbCon.AddParameters("P_911_SACODE", DbType.VarNumeric, ht["911_SACODE"]);
        //        //dbCon.AddParameters("P_912_SACODE", DbType.VarNumeric, ht["912_SACODE"]);
        //        //dbCon.AddParameters("P_913_SACODE", DbType.VarNumeric, ht["913_SACODE"]);
        //        //dbCon.AddParameters("P_914_SACODE", DbType.VarNumeric, ht["914_SACODE"]);
        //        //dbCon.AddParameters("P_915_SACODE", DbType.VarNumeric, ht["915_SACODE"]);
        //        //dbCon.AddParameters("P_916_SACODE", DbType.VarNumeric, ht["916_SACODE"]);


        //        //dbCon.AddParameters("P_101_SACODENM", DbType.VarNumeric, ht["101_SACODENM"]);
        //        //dbCon.AddParameters("P_102_SACODENM", DbType.VarNumeric, ht["102_SACODENM"]);
        //        //dbCon.AddParameters("P_103_SACODENM", DbType.VarNumeric, ht["103_SACODENM"]);
        //        //dbCon.AddParameters("P_104_SACODENM", DbType.VarNumeric, ht["104_SACODENM"]);
        //        //dbCon.AddParameters("P_105_SACODENM", DbType.VarNumeric, ht["105_SACODENM"]);
        //        //dbCon.AddParameters("P_106_SACODENM", DbType.VarNumeric, ht["106_SACODENM"]);
        //        //dbCon.AddParameters("P_107_SACODENM", DbType.VarNumeric, ht["107_SACODENM"]);
        //        //dbCon.AddParameters("P_108_SACODENM", DbType.VarNumeric, ht["108_SACODENM"]);
        //        //dbCon.AddParameters("P_109_SACODENM", DbType.VarNumeric, ht["109_SACODENM"]);
        //        //dbCon.AddParameters("P_110_SACODENM", DbType.VarNumeric, ht["110_SACODENM"]);
        //        //dbCon.AddParameters("P_111_SACODENM", DbType.VarNumeric, ht["111_SACODENM"]);
        //        //dbCon.AddParameters("P_112_SACODENM", DbType.VarNumeric, ht["112_SACODENM"]);
        //        //dbCon.AddParameters("P_113_SACODENM", DbType.VarNumeric, ht["113_SACODENM"]);
        //        //dbCon.AddParameters("P_114_SACODENM", DbType.VarNumeric, ht["114_SACODENM"]);
        //        //dbCon.AddParameters("P_115_SACODENM", DbType.VarNumeric, ht["115_SACODENM"]);
        //        //dbCon.AddParameters("P_116_SACODENM", DbType.VarNumeric, ht["116_SACODENM"]);
        //        //dbCon.AddParameters("P_201_SACODENM", DbType.VarNumeric, ht["201_SACODENM"]);
        //        //dbCon.AddParameters("P_202_SACODENM", DbType.VarNumeric, ht["202_SACODENM"]);
        //        //dbCon.AddParameters("P_203_SACODENM", DbType.VarNumeric, ht["203_SACODENM"]);
        //        //dbCon.AddParameters("P_204_SACODENM", DbType.VarNumeric, ht["204_SACODENM"]);
        //        //dbCon.AddParameters("P_205_SACODENM", DbType.VarNumeric, ht["205_SACODENM"]);
        //        //dbCon.AddParameters("P_206_SACODENM", DbType.VarNumeric, ht["206_SACODENM"]);
        //        //dbCon.AddParameters("P_207_SACODENM", DbType.VarNumeric, ht["207_SACODENM"]);
        //        //dbCon.AddParameters("P_208_SACODENM", DbType.VarNumeric, ht["208_SACODENM"]);
        //        //dbCon.AddParameters("P_209_SACODENM", DbType.VarNumeric, ht["209_SACODENM"]);
        //        //dbCon.AddParameters("P_210_SACODENM", DbType.VarNumeric, ht["210_SACODENM"]);
        //        //dbCon.AddParameters("P_211_SACODENM", DbType.VarNumeric, ht["211_SACODENM"]);
        //        //dbCon.AddParameters("P_212_SACODENM", DbType.VarNumeric, ht["212_SACODENM"]);
        //        //dbCon.AddParameters("P_213_SACODENM", DbType.VarNumeric, ht["213_SACODENM"]);
        //        //dbCon.AddParameters("P_214_SACODENM", DbType.VarNumeric, ht["214_SACODENM"]);
        //        //dbCon.AddParameters("P_215_SACODENM", DbType.VarNumeric, ht["215_SACODENM"]);
        //        //dbCon.AddParameters("P_216_SACODENM", DbType.VarNumeric, ht["216_SACODENM"]);
        //        //dbCon.AddParameters("P_217_SACODENM", DbType.VarNumeric, ht["217_SACODENM"]);
        //        //dbCon.AddParameters("P_218_SACODENM", DbType.VarNumeric, ht["218_SACODENM"]);
        //        //dbCon.AddParameters("P_301_SACODENM", DbType.VarNumeric, ht["301_SACODENM"]);
        //        //dbCon.AddParameters("P_302_SACODENM", DbType.VarNumeric, ht["302_SACODENM"]);
        //        //dbCon.AddParameters("P_303_SACODENM", DbType.VarNumeric, ht["303_SACODENM"]);
        //        //dbCon.AddParameters("P_304_SACODENM", DbType.VarNumeric, ht["304_SACODENM"]);
        //        //dbCon.AddParameters("P_305_SACODENM", DbType.VarNumeric, ht["305_SACODENM"]);
        //        //dbCon.AddParameters("P_306_SACODENM", DbType.VarNumeric, ht["306_SACODENM"]);
        //        //dbCon.AddParameters("P_307_SACODENM", DbType.VarNumeric, ht["307_SACODENM"]);
        //        //dbCon.AddParameters("P_308_SACODENM", DbType.VarNumeric, ht["308_SACODENM"]);
        //        //dbCon.AddParameters("P_309_SACODENM", DbType.VarNumeric, ht["309_SACODENM"]);
        //        //dbCon.AddParameters("P_310_SACODENM", DbType.VarNumeric, ht["310_SACODENM"]);
        //        //dbCon.AddParameters("P_311_SACODENM", DbType.VarNumeric, ht["311_SACODENM"]);
        //        //dbCon.AddParameters("P_312_SACODENM", DbType.VarNumeric, ht["312_SACODENM"]);
        //        //dbCon.AddParameters("P_313_SACODENM", DbType.VarNumeric, ht["313_SACODENM"]);
        //        //dbCon.AddParameters("P_314_SACODENM", DbType.VarNumeric, ht["314_SACODENM"]);
        //        //dbCon.AddParameters("P_401_SACODENM", DbType.VarNumeric, ht["401_SACODENM"]);
        //        //dbCon.AddParameters("P_402_SACODENM", DbType.VarNumeric, ht["402_SACODENM"]);
        //        //dbCon.AddParameters("P_403_SACODENM", DbType.VarNumeric, ht["403_SACODENM"]);
        //        //dbCon.AddParameters("P_404_SACODENM", DbType.VarNumeric, ht["404_SACODENM"]);
        //        //dbCon.AddParameters("P_405_SACODENM", DbType.VarNumeric, ht["405_SACODENM"]);
        //        //dbCon.AddParameters("P_406_SACODENM", DbType.VarNumeric, ht["406_SACODENM"]);
        //        //dbCon.AddParameters("P_407_SACODENM", DbType.VarNumeric, ht["407_SACODENM"]);
        //        //dbCon.AddParameters("P_408_SACODENM", DbType.VarNumeric, ht["408_SACODENM"]);
        //        //dbCon.AddParameters("P_409_SACODENM", DbType.VarNumeric, ht["409_SACODENM"]);
        //        //dbCon.AddParameters("P_501_SACODENM", DbType.VarNumeric, ht["501_SACODENM"]);
        //        //dbCon.AddParameters("P_502_SACODENM", DbType.VarNumeric, ht["502_SACODENM"]);
        //        //dbCon.AddParameters("P_503_SACODENM", DbType.VarNumeric, ht["503_SACODENM"]);
        //        //dbCon.AddParameters("P_504_SACODENM", DbType.VarNumeric, ht["504_SACODENM"]);
        //        //dbCon.AddParameters("P_601_SACODENM", DbType.VarNumeric, ht["601_SACODENM"]);
        //        //dbCon.AddParameters("P_602_SACODENM", DbType.VarNumeric, ht["602_SACODENM"]);
        //        //dbCon.AddParameters("P_603_SACODENM", DbType.VarNumeric, ht["603_SACODENM"]);
        //        //dbCon.AddParameters("P_701_SACODENM", DbType.VarNumeric, ht["701_SACODENM"]);
        //        //dbCon.AddParameters("P_702_SACODENM", DbType.VarNumeric, ht["702_SACODENM"]);
        //        //dbCon.AddParameters("P_703_SACODENM", DbType.VarNumeric, ht["703_SACODENM"]);
        //        //dbCon.AddParameters("P_704_SACODENM", DbType.VarNumeric, ht["704_SACODENM"]);
        //        //dbCon.AddParameters("P_705_SACODENM", DbType.VarNumeric, ht["705_SACODENM"]);
        //        //dbCon.AddParameters("P_706_SACODENM", DbType.VarNumeric, ht["706_SACODENM"]);
        //        //dbCon.AddParameters("P_707_SACODENM", DbType.VarNumeric, ht["707_SACODENM"]);
        //        //dbCon.AddParameters("P_708_SACODENM", DbType.VarNumeric, ht["708_SACODENM"]);
        //        //dbCon.AddParameters("P_901_SACODENM", DbType.VarNumeric, ht["901_SACODENM"]);
        //        //dbCon.AddParameters("P_902_SACODENM", DbType.VarNumeric, ht["902_SACODENM"]);
        //        //dbCon.AddParameters("P_903_SACODENM", DbType.VarNumeric, ht["903_SACODENM"]);
        //        //dbCon.AddParameters("P_904_SACODENM", DbType.VarNumeric, ht["904_SACODENM"]);
        //        //dbCon.AddParameters("P_905_SACODENM", DbType.VarNumeric, ht["905_SACODENM"]);
        //        //dbCon.AddParameters("P_906_SACODENM", DbType.VarNumeric, ht["906_SACODENM"]);
        //        //dbCon.AddParameters("P_907_SACODENM", DbType.VarNumeric, ht["907_SACODENM"]);
        //        //dbCon.AddParameters("P_908_SACODENM", DbType.VarNumeric, ht["908_SACODENM"]);
        //        //dbCon.AddParameters("P_909_SACODENM", DbType.VarNumeric, ht["909_SACODENM"]);
        //        //dbCon.AddParameters("P_910_SACODENM", DbType.VarNumeric, ht["910_SACODENM"]);
        //        //dbCon.AddParameters("P_911_SACODENM", DbType.VarNumeric, ht["911_SACODENM"]);
        //        //dbCon.AddParameters("P_912_SACODENM", DbType.VarNumeric, ht["912_SACODENM"]);
        //        //dbCon.AddParameters("P_913_SACODENM", DbType.VarNumeric, ht["913_SACODENM"]);
        //        //dbCon.AddParameters("P_914_SACODENM", DbType.VarNumeric, ht["914_SACODENM"]);
        //        //dbCon.AddParameters("P_915_SACODENM", DbType.VarNumeric, ht["915_SACODENM"]);
        //        //dbCon.AddParameters("P_916_SACODENM", DbType.VarNumeric, ht["916_SACODENM"]);

        //        //dbCon.AddParameters("P_101_SSPUBSEL", DbType.VarNumeric, ht["101_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_102_SSPUBSEL", DbType.VarNumeric, ht["102_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_103_SSPUBSEL", DbType.VarNumeric, ht["103_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_104_SSPUBSEL", DbType.VarNumeric, ht["104_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_105_SSPUBSEL", DbType.VarNumeric, ht["105_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_106_SSPUBSEL", DbType.VarNumeric, ht["106_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_107_SSPUBSEL", DbType.VarNumeric, ht["107_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_108_SSPUBSEL", DbType.VarNumeric, ht["108_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_109_SSPUBSEL", DbType.VarNumeric, ht["109_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_110_SSPUBSEL", DbType.VarNumeric, ht["110_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_111_SSPUBSEL", DbType.VarNumeric, ht["111_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_112_SSPUBSEL", DbType.VarNumeric, ht["112_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_113_SSPUBSEL", DbType.VarNumeric, ht["113_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_114_SSPUBSEL", DbType.VarNumeric, ht["114_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_115_SSPUBSEL", DbType.VarNumeric, ht["115_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_116_SSPUBSEL", DbType.VarNumeric, ht["116_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_101_SSREVSEL", DbType.VarNumeric, ht["101_SSREVSEL"]);
        //        //dbCon.AddParameters("P_102_SSREVSEL", DbType.VarNumeric, ht["102_SSREVSEL"]);
        //        //dbCon.AddParameters("P_103_SSREVSEL", DbType.VarNumeric, ht["103_SSREVSEL"]);
        //        //dbCon.AddParameters("P_104_SSREVSEL", DbType.VarNumeric, ht["104_SSREVSEL"]);
        //        //dbCon.AddParameters("P_105_SSREVSEL", DbType.VarNumeric, ht["105_SSREVSEL"]);
        //        //dbCon.AddParameters("P_106_SSREVSEL", DbType.VarNumeric, ht["106_SSREVSEL"]);
        //        //dbCon.AddParameters("P_107_SSREVSEL", DbType.VarNumeric, ht["107_SSREVSEL"]);
        //        //dbCon.AddParameters("P_108_SSREVSEL", DbType.VarNumeric, ht["108_SSREVSEL"]);
        //        //dbCon.AddParameters("P_109_SSREVSEL", DbType.VarNumeric, ht["109_SSREVSEL"]);
        //        //dbCon.AddParameters("P_110_SSREVSEL", DbType.VarNumeric, ht["110_SSREVSEL"]);
        //        //dbCon.AddParameters("P_111_SSREVSEL", DbType.VarNumeric, ht["111_SSREVSEL"]);
        //        //dbCon.AddParameters("P_112_SSREVSEL", DbType.VarNumeric, ht["112_SSREVSEL"]);
        //        //dbCon.AddParameters("P_113_SSREVSEL", DbType.VarNumeric, ht["113_SSREVSEL"]);
        //        //dbCon.AddParameters("P_114_SSREVSEL", DbType.VarNumeric, ht["114_SSREVSEL"]);
        //        //dbCon.AddParameters("P_115_SSREVSEL", DbType.VarNumeric, ht["115_SSREVSEL"]);
        //        //dbCon.AddParameters("P_116_SSREVSEL", DbType.VarNumeric, ht["116_SSREVSEL"]);
        //        //dbCon.AddParameters("P_101_SSFIXSEL", DbType.VarNumeric, ht["101_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_102_SSFIXSEL", DbType.VarNumeric, ht["102_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_103_SSFIXSEL", DbType.VarNumeric, ht["103_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_104_SSFIXSEL", DbType.VarNumeric, ht["104_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_105_SSFIXSEL", DbType.VarNumeric, ht["105_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_106_SSFIXSEL", DbType.VarNumeric, ht["106_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_107_SSFIXSEL", DbType.VarNumeric, ht["107_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_108_SSFIXSEL", DbType.VarNumeric, ht["108_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_109_SSFIXSEL", DbType.VarNumeric, ht["109_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_110_SSFIXSEL", DbType.VarNumeric, ht["110_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_111_SSFIXSEL", DbType.VarNumeric, ht["111_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_112_SSFIXSEL", DbType.VarNumeric, ht["112_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_113_SSFIXSEL", DbType.VarNumeric, ht["113_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_114_SSFIXSEL", DbType.VarNumeric, ht["114_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_115_SSFIXSEL", DbType.VarNumeric, ht["115_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_116_SSFIXSEL", DbType.VarNumeric, ht["116_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_201_SSPUBSEL", DbType.VarNumeric, ht["201_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_202_SSPUBSEL", DbType.VarNumeric, ht["202_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_203_SSPUBSEL", DbType.VarNumeric, ht["203_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_204_SSPUBSEL", DbType.VarNumeric, ht["204_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_205_SSPUBSEL", DbType.VarNumeric, ht["205_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_206_SSPUBSEL", DbType.VarNumeric, ht["206_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_207_SSPUBSEL", DbType.VarNumeric, ht["207_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_208_SSPUBSEL", DbType.VarNumeric, ht["208_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_209_SSPUBSEL", DbType.VarNumeric, ht["209_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_210_SSPUBSEL", DbType.VarNumeric, ht["210_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_211_SSPUBSEL", DbType.VarNumeric, ht["211_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_212_SSPUBSEL", DbType.VarNumeric, ht["212_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_213_SSPUBSEL", DbType.VarNumeric, ht["213_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_214_SSPUBSEL", DbType.VarNumeric, ht["214_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_215_SSPUBSEL", DbType.VarNumeric, ht["215_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_216_SSPUBSEL", DbType.VarNumeric, ht["216_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_217_SSPUBSEL", DbType.VarNumeric, ht["217_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_218_SSPUBSEL", DbType.VarNumeric, ht["218_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_201_SSREVSEL", DbType.VarNumeric, ht["201_SSREVSEL"]);
        //        //dbCon.AddParameters("P_202_SSREVSEL", DbType.VarNumeric, ht["202_SSREVSEL"]);
        //        //dbCon.AddParameters("P_203_SSREVSEL", DbType.VarNumeric, ht["203_SSREVSEL"]);
        //        //dbCon.AddParameters("P_204_SSREVSEL", DbType.VarNumeric, ht["204_SSREVSEL"]);
        //        //dbCon.AddParameters("P_205_SSREVSEL", DbType.VarNumeric, ht["205_SSREVSEL"]);
        //        //dbCon.AddParameters("P_206_SSREVSEL", DbType.VarNumeric, ht["206_SSREVSEL"]);
        //        //dbCon.AddParameters("P_207_SSREVSEL", DbType.VarNumeric, ht["207_SSREVSEL"]);
        //        //dbCon.AddParameters("P_208_SSREVSEL", DbType.VarNumeric, ht["208_SSREVSEL"]);
        //        //dbCon.AddParameters("P_209_SSREVSEL", DbType.VarNumeric, ht["209_SSREVSEL"]);
        //        //dbCon.AddParameters("P_210_SSREVSEL", DbType.VarNumeric, ht["210_SSREVSEL"]);
        //        //dbCon.AddParameters("P_211_SSREVSEL", DbType.VarNumeric, ht["211_SSREVSEL"]);
        //        //dbCon.AddParameters("P_212_SSREVSEL", DbType.VarNumeric, ht["212_SSREVSEL"]);
        //        //dbCon.AddParameters("P_213_SSREVSEL", DbType.VarNumeric, ht["213_SSREVSEL"]);
        //        //dbCon.AddParameters("P_214_SSREVSEL", DbType.VarNumeric, ht["214_SSREVSEL"]);
        //        //dbCon.AddParameters("P_215_SSREVSEL", DbType.VarNumeric, ht["215_SSREVSEL"]);
        //        //dbCon.AddParameters("P_216_SSREVSEL", DbType.VarNumeric, ht["216_SSREVSEL"]);
        //        //dbCon.AddParameters("P_217_SSREVSEL", DbType.VarNumeric, ht["217_SSREVSEL"]);
        //        //dbCon.AddParameters("P_218_SSREVSEL", DbType.VarNumeric, ht["218_SSREVSEL"]);
        //        //dbCon.AddParameters("P_201_SSFIXSEL", DbType.VarNumeric, ht["201_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_202_SSFIXSEL", DbType.VarNumeric, ht["202_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_203_SSFIXSEL", DbType.VarNumeric, ht["203_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_204_SSFIXSEL", DbType.VarNumeric, ht["204_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_205_SSFIXSEL", DbType.VarNumeric, ht["205_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_206_SSFIXSEL", DbType.VarNumeric, ht["206_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_207_SSFIXSEL", DbType.VarNumeric, ht["207_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_208_SSFIXSEL", DbType.VarNumeric, ht["208_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_209_SSFIXSEL", DbType.VarNumeric, ht["209_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_210_SSFIXSEL", DbType.VarNumeric, ht["210_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_211_SSFIXSEL", DbType.VarNumeric, ht["211_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_212_SSFIXSEL", DbType.VarNumeric, ht["212_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_213_SSFIXSEL", DbType.VarNumeric, ht["213_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_214_SSFIXSEL", DbType.VarNumeric, ht["214_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_215_SSFIXSEL", DbType.VarNumeric, ht["215_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_216_SSFIXSEL", DbType.VarNumeric, ht["216_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_217_SSFIXSEL", DbType.VarNumeric, ht["217_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_218_SSFIXSEL", DbType.VarNumeric, ht["218_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_301_SSPUBSEL", DbType.VarNumeric, ht["301_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_302_SSPUBSEL", DbType.VarNumeric, ht["302_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_303_SSPUBSEL", DbType.VarNumeric, ht["303_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_304_SSPUBSEL", DbType.VarNumeric, ht["304_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_305_SSPUBSEL", DbType.VarNumeric, ht["305_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_306_SSPUBSEL", DbType.VarNumeric, ht["306_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_307_SSPUBSEL", DbType.VarNumeric, ht["307_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_308_SSPUBSEL", DbType.VarNumeric, ht["308_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_309_SSPUBSEL", DbType.VarNumeric, ht["309_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_310_SSPUBSEL", DbType.VarNumeric, ht["310_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_311_SSPUBSEL", DbType.VarNumeric, ht["311_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_312_SSPUBSEL", DbType.VarNumeric, ht["312_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_313_SSPUBSEL", DbType.VarNumeric, ht["313_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_314_SSPUBSEL", DbType.VarNumeric, ht["314_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_301_SSREVSEL", DbType.VarNumeric, ht["301_SSREVSEL"]);
        //        //dbCon.AddParameters("P_302_SSREVSEL", DbType.VarNumeric, ht["302_SSREVSEL"]);
        //        //dbCon.AddParameters("P_303_SSREVSEL", DbType.VarNumeric, ht["303_SSREVSEL"]);
        //        //dbCon.AddParameters("P_304_SSREVSEL", DbType.VarNumeric, ht["304_SSREVSEL"]);
        //        //dbCon.AddParameters("P_305_SSREVSEL", DbType.VarNumeric, ht["305_SSREVSEL"]);
        //        //dbCon.AddParameters("P_306_SSREVSEL", DbType.VarNumeric, ht["306_SSREVSEL"]);
        //        //dbCon.AddParameters("P_307_SSREVSEL", DbType.VarNumeric, ht["307_SSREVSEL"]);
        //        //dbCon.AddParameters("P_308_SSREVSEL", DbType.VarNumeric, ht["308_SSREVSEL"]);
        //        //dbCon.AddParameters("P_309_SSREVSEL", DbType.VarNumeric, ht["309_SSREVSEL"]);
        //        //dbCon.AddParameters("P_310_SSREVSEL", DbType.VarNumeric, ht["310_SSREVSEL"]);
        //        //dbCon.AddParameters("P_311_SSREVSEL", DbType.VarNumeric, ht["311_SSREVSEL"]);
        //        //dbCon.AddParameters("P_312_SSREVSEL", DbType.VarNumeric, ht["312_SSREVSEL"]);
        //        //dbCon.AddParameters("P_313_SSREVSEL", DbType.VarNumeric, ht["313_SSREVSEL"]);
        //        //dbCon.AddParameters("P_314_SSREVSEL", DbType.VarNumeric, ht["314_SSREVSEL"]);
        //        //dbCon.AddParameters("P_301_SSFIXSEL", DbType.VarNumeric, ht["301_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_302_SSFIXSEL", DbType.VarNumeric, ht["302_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_303_SSFIXSEL", DbType.VarNumeric, ht["303_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_304_SSFIXSEL", DbType.VarNumeric, ht["304_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_305_SSFIXSEL", DbType.VarNumeric, ht["305_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_306_SSFIXSEL", DbType.VarNumeric, ht["306_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_307_SSFIXSEL", DbType.VarNumeric, ht["307_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_308_SSFIXSEL", DbType.VarNumeric, ht["308_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_309_SSFIXSEL", DbType.VarNumeric, ht["309_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_310_SSFIXSEL", DbType.VarNumeric, ht["310_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_311_SSFIXSEL", DbType.VarNumeric, ht["311_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_312_SSFIXSEL", DbType.VarNumeric, ht["312_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_313_SSFIXSEL", DbType.VarNumeric, ht["313_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_314_SSFIXSEL", DbType.VarNumeric, ht["314_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_401_SSPUBSEL", DbType.VarNumeric, ht["401_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_402_SSPUBSEL", DbType.VarNumeric, ht["402_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_403_SSPUBSEL", DbType.VarNumeric, ht["403_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_404_SSPUBSEL", DbType.VarNumeric, ht["404_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_405_SSPUBSEL", DbType.VarNumeric, ht["405_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_406_SSPUBSEL", DbType.VarNumeric, ht["406_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_407_SSPUBSEL", DbType.VarNumeric, ht["407_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_408_SSPUBSEL", DbType.VarNumeric, ht["408_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_409_SSPUBSEL", DbType.VarNumeric, ht["409_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_401_SSREVSEL", DbType.VarNumeric, ht["401_SSREVSEL"]);
        //        //dbCon.AddParameters("P_402_SSREVSEL", DbType.VarNumeric, ht["402_SSREVSEL"]);
        //        //dbCon.AddParameters("P_403_SSREVSEL", DbType.VarNumeric, ht["403_SSREVSEL"]);
        //        //dbCon.AddParameters("P_404_SSREVSEL", DbType.VarNumeric, ht["404_SSREVSEL"]);
        //        //dbCon.AddParameters("P_405_SSREVSEL", DbType.VarNumeric, ht["405_SSREVSEL"]);
        //        //dbCon.AddParameters("P_406_SSREVSEL", DbType.VarNumeric, ht["406_SSREVSEL"]);
        //        //dbCon.AddParameters("P_407_SSREVSEL", DbType.VarNumeric, ht["407_SSREVSEL"]);
        //        //dbCon.AddParameters("P_408_SSREVSEL", DbType.VarNumeric, ht["408_SSREVSEL"]);
        //        //dbCon.AddParameters("P_409_SSREVSEL", DbType.VarNumeric, ht["409_SSREVSEL"]);
        //        //dbCon.AddParameters("P_401_SSFIXSEL", DbType.VarNumeric, ht["401_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_402_SSFIXSEL", DbType.VarNumeric, ht["402_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_403_SSFIXSEL", DbType.VarNumeric, ht["403_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_404_SSFIXSEL", DbType.VarNumeric, ht["404_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_405_SSFIXSEL", DbType.VarNumeric, ht["405_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_406_SSFIXSEL", DbType.VarNumeric, ht["406_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_407_SSFIXSEL", DbType.VarNumeric, ht["407_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_408_SSFIXSEL", DbType.VarNumeric, ht["408_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_409_SSFIXSEL", DbType.VarNumeric, ht["409_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_501_SSPUBSEL", DbType.VarNumeric, ht["501_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_502_SSPUBSEL", DbType.VarNumeric, ht["502_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_503_SSPUBSEL", DbType.VarNumeric, ht["503_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_504_SSPUBSEL", DbType.VarNumeric, ht["504_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_501_SSREVSEL", DbType.VarNumeric, ht["501_SSREVSEL"]);
        //        //dbCon.AddParameters("P_502_SSREVSEL", DbType.VarNumeric, ht["502_SSREVSEL"]);
        //        //dbCon.AddParameters("P_503_SSREVSEL", DbType.VarNumeric, ht["503_SSREVSEL"]);
        //        //dbCon.AddParameters("P_504_SSREVSEL", DbType.VarNumeric, ht["504_SSREVSEL"]);
        //        //dbCon.AddParameters("P_501_SSFIXSEL", DbType.VarNumeric, ht["501_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_502_SSFIXSEL", DbType.VarNumeric, ht["502_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_503_SSFIXSEL", DbType.VarNumeric, ht["503_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_504_SSFIXSEL", DbType.VarNumeric, ht["504_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_601_SSPUBSEL", DbType.VarNumeric, ht["601_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_602_SSPUBSEL", DbType.VarNumeric, ht["602_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_603_SSPUBSEL", DbType.VarNumeric, ht["603_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_601_SSREVSEL", DbType.VarNumeric, ht["601_SSREVSEL"]);
        //        //dbCon.AddParameters("P_602_SSREVSEL", DbType.VarNumeric, ht["602_SSREVSEL"]);
        //        //dbCon.AddParameters("P_603_SSREVSEL", DbType.VarNumeric, ht["603_SSREVSEL"]);
        //        //dbCon.AddParameters("P_601_SSFIXSEL", DbType.VarNumeric, ht["601_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_602_SSFIXSEL", DbType.VarNumeric, ht["602_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_603_SSFIXSEL", DbType.VarNumeric, ht["603_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_701_SSPUBSEL", DbType.VarNumeric, ht["701_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_702_SSPUBSEL", DbType.VarNumeric, ht["702_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_703_SSPUBSEL", DbType.VarNumeric, ht["703_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_704_SSPUBSEL", DbType.VarNumeric, ht["704_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_705_SSPUBSEL", DbType.VarNumeric, ht["705_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_706_SSPUBSEL", DbType.VarNumeric, ht["706_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_707_SSPUBSEL", DbType.VarNumeric, ht["707_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_708_SSPUBSEL", DbType.VarNumeric, ht["708_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_701_SSREVSEL", DbType.VarNumeric, ht["701_SSREVSEL"]);
        //        //dbCon.AddParameters("P_702_SSREVSEL", DbType.VarNumeric, ht["702_SSREVSEL"]);
        //        //dbCon.AddParameters("P_703_SSREVSEL", DbType.VarNumeric, ht["703_SSREVSEL"]);
        //        //dbCon.AddParameters("P_704_SSREVSEL", DbType.VarNumeric, ht["704_SSREVSEL"]);
        //        //dbCon.AddParameters("P_705_SSREVSEL", DbType.VarNumeric, ht["705_SSREVSEL"]);
        //        //dbCon.AddParameters("P_706_SSREVSEL", DbType.VarNumeric, ht["706_SSREVSEL"]);
        //        //dbCon.AddParameters("P_707_SSREVSEL", DbType.VarNumeric, ht["707_SSREVSEL"]);
        //        //dbCon.AddParameters("P_708_SSREVSEL", DbType.VarNumeric, ht["708_SSREVSEL"]);
        //        //dbCon.AddParameters("P_701_SSFIXSEL", DbType.VarNumeric, ht["701_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_702_SSFIXSEL", DbType.VarNumeric, ht["702_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_703_SSFIXSEL", DbType.VarNumeric, ht["703_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_704_SSFIXSEL", DbType.VarNumeric, ht["704_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_705_SSFIXSEL", DbType.VarNumeric, ht["705_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_706_SSFIXSEL", DbType.VarNumeric, ht["706_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_707_SSFIXSEL", DbType.VarNumeric, ht["707_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_708_SSFIXSEL", DbType.VarNumeric, ht["708_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_901_SSPUBSEL", DbType.VarNumeric, ht["901_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_902_SSPUBSEL", DbType.VarNumeric, ht["902_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_903_SSPUBSEL", DbType.VarNumeric, ht["903_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_904_SSPUBSEL", DbType.VarNumeric, ht["904_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_905_SSPUBSEL", DbType.VarNumeric, ht["905_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_906_SSPUBSEL", DbType.VarNumeric, ht["906_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_907_SSPUBSEL", DbType.VarNumeric, ht["907_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_908_SSPUBSEL", DbType.VarNumeric, ht["908_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_909_SSPUBSEL", DbType.VarNumeric, ht["909_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_910_SSPUBSEL", DbType.VarNumeric, ht["910_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_911_SSPUBSEL", DbType.VarNumeric, ht["911_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_912_SSPUBSEL", DbType.VarNumeric, ht["912_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_913_SSPUBSEL", DbType.VarNumeric, ht["913_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_914_SSPUBSEL", DbType.VarNumeric, ht["914_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_915_SSPUBSEL", DbType.VarNumeric, ht["915_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_916_SSPUBSEL", DbType.VarNumeric, ht["916_SSPUBSEL"]);
        //        //dbCon.AddParameters("P_901_SSREVSEL", DbType.VarNumeric, ht["901_SSREVSEL"]);
        //        //dbCon.AddParameters("P_902_SSREVSEL", DbType.VarNumeric, ht["902_SSREVSEL"]);
        //        //dbCon.AddParameters("P_903_SSREVSEL", DbType.VarNumeric, ht["903_SSREVSEL"]);
        //        //dbCon.AddParameters("P_904_SSREVSEL", DbType.VarNumeric, ht["904_SSREVSEL"]);
        //        //dbCon.AddParameters("P_905_SSREVSEL", DbType.VarNumeric, ht["905_SSREVSEL"]);
        //        //dbCon.AddParameters("P_906_SSREVSEL", DbType.VarNumeric, ht["906_SSREVSEL"]);
        //        //dbCon.AddParameters("P_907_SSREVSEL", DbType.VarNumeric, ht["907_SSREVSEL"]);
        //        //dbCon.AddParameters("P_908_SSREVSEL", DbType.VarNumeric, ht["908_SSREVSEL"]);
        //        //dbCon.AddParameters("P_909_SSREVSEL", DbType.VarNumeric, ht["909_SSREVSEL"]);
        //        //dbCon.AddParameters("P_910_SSREVSEL", DbType.VarNumeric, ht["910_SSREVSEL"]);
        //        //dbCon.AddParameters("P_911_SSREVSEL", DbType.VarNumeric, ht["911_SSREVSEL"]);
        //        //dbCon.AddParameters("P_912_SSREVSEL", DbType.VarNumeric, ht["912_SSREVSEL"]);
        //        //dbCon.AddParameters("P_913_SSREVSEL", DbType.VarNumeric, ht["913_SSREVSEL"]);
        //        //dbCon.AddParameters("P_914_SSREVSEL", DbType.VarNumeric, ht["914_SSREVSEL"]);
        //        //dbCon.AddParameters("P_915_SSREVSEL", DbType.VarNumeric, ht["915_SSREVSEL"]);
        //        //dbCon.AddParameters("P_916_SSREVSEL", DbType.VarNumeric, ht["916_SSREVSEL"]);
        //        //dbCon.AddParameters("P_901_SSFIXSEL", DbType.VarNumeric, ht["901_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_902_SSFIXSEL", DbType.VarNumeric, ht["902_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_903_SSFIXSEL", DbType.VarNumeric, ht["903_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_904_SSFIXSEL", DbType.VarNumeric, ht["904_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_905_SSFIXSEL", DbType.VarNumeric, ht["905_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_906_SSFIXSEL", DbType.VarNumeric, ht["906_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_907_SSFIXSEL", DbType.VarNumeric, ht["907_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_908_SSFIXSEL", DbType.VarNumeric, ht["908_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_909_SSFIXSEL", DbType.VarNumeric, ht["909_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_910_SSFIXSEL", DbType.VarNumeric, ht["910_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_911_SSFIXSEL", DbType.VarNumeric, ht["911_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_912_SSFIXSEL", DbType.VarNumeric, ht["912_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_913_SSFIXSEL", DbType.VarNumeric, ht["913_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_914_SSFIXSEL", DbType.VarNumeric, ht["914_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_915_SSFIXSEL", DbType.VarNumeric, ht["915_SSFIXSEL"]);
        //        //dbCon.AddParameters("P_916_SSFIXSEL", DbType.VarNumeric, ht["916_SSFIXSEL"]);

        //        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_ADD");

        //        row = dt.NewRow();
        //        row["STATE"] = "OK";
        //        row["MSG"] = "";
        //        row["DATA"] = "";
        //        dt.Rows.Add(row);
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion


        //#region Description : 안전작업허가서 결재 업데이트
        //public DataSet UP_SAFEORDER_APPROVAL_UPT(Hashtable ht)
        //{
        //    string sMSG = "";

        //    DataSet ds = new DataSet();
        //    DataTable dt = new DataTable();
        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));


        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));
        //        dbCon.AddParameters("P_APPROVALSITE", DbType.String, ht["P_APPROVALSITE"]);

        //        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_APPROVAL_UPT");

        //        row = dt.NewRow();
        //        row["STATE"] = "OK";
        //        row["MSG"] = "";

        //        dt.Rows.Add(row);
        //        ds.Tables.Add(dt);
        //    }

        //    return ds;

        //}
        //#endregion

        //#region Description : 안전작업허가서 삭제
        //public DataSet UP_SAFEORDER_MASTER_ALL_DEL(Hashtable ht)
        //{
        //    string sMSG = "";

        //    DataSet ds = new DataSet();
        //    DataTable dt = new DataTable();
        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    if (sMSG == "")
        //    {
        //        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //        {
        //            // 파일 삭제
        //            dbCon.AddParameters("P_ATTACH_TYPE", DbType.String, ht["P_ATTACH_TYPE"]);
        //            dbCon.AddParameters("P_ATTACH_NO", DbType.String, ht["P_ATTACH_NO"]);

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_ATTACHFILE_DEL");
        //        }

        //        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //        {
        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMORAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_ALL_DEL");

        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            ds.Tables.Add(dt);
        //        }
        //    }

        //    return ds;
        //}
        //#endregion

        //#region Description : 연장허가자 업데이트
        //public DataSet UP_EXTENSION_CONFIRM(Hashtable ht)
        //{
        //    string sSTATE = string.Empty;
        //    string sBUSEO = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("SEQ", typeof(System.String));
        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));
        //    dt.Columns.Add("KBHANGL", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        if (sSTATE == "")
        //        {
        //            if (ht["P_SMOTAPPSABUN"].ToString() != "")
        //            {
        //                dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMOTAPPSABUN"]);

        //                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                if (ds.Tables[0].Rows.Count > 0)
        //                {
        //                    sBUSEO = ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString();

        //                    if (ht["P_HDNBUSEO"].ToString().Substring(0, 2) != sBUSEO.ToString().Substring(0, 2))
        //                    {
        //                        sSTATE = "ERR";
        //                    }

        //                    if (sSTATE == "")
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "1";
        //                        row["STATE"] = "";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //dsMsg.Tables.Add(dt);
        //                    }
        //                    else
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "1";
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //dsMsg.Tables.Add(dt);
        //                    }
        //                }
        //            }
        //        }

        //        if (sSTATE == "")
        //        {
        //            dbCon.AddParameters("P_SMOTDATE1", DbType.String, Get_Date(ht["P_SMOTDATE1"].ToString()));
        //            dbCon.AddParameters("P_SMOTTIME1", DbType.String, ht["P_SMOTTIME1"].ToString().Replace(":", ""));
        //            dbCon.AddParameters("P_SMOTDATE2", DbType.String, Get_Date(ht["P_SMOTDATE2"].ToString()));
        //            dbCon.AddParameters("P_SMOTTIME2", DbType.String, ht["P_SMOTTIME2"].ToString().Replace(":", ""));
        //            dbCon.AddParameters("P_SMOTAPPSABUN", DbType.String, ht["P_SMOTAPPSABUN"]);
        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_EXTENSION_UPT");

        //            row = dt.NewRow();
        //            row["SEQ"] = "2";
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);
        //        }
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 안전작업허가서 안전 확인
        //public DataSet UP_SAFEORDER_SAFETY_UPT(Hashtable ht)
        //{
        //    string sSTATE = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        if (sSTATE == "")
        //        {
        //            dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMSMSABUN"]);

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //            if (ds.Tables[0].Rows.Count < 0)
        //            {
        //                sSTATE = "ERR";

        //                row = dt.NewRow();
        //                row["STATE"] = "ERR";
        //                row["MSG"] = "확인자를 확인하세요";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);
        //            }

        //        }

        //        if (sSTATE == "")
        //        {
        //            dbCon.AddParameters("P_SMSMSABUN", DbType.String, ht["P_SMSMSABUN"]);
        //            dbCon.AddParameters("P_SMSMAPPDATE", DbType.String, Get_Date(ht["P_SMSMAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMSMAPPTIME", DbType.String, ht["P_SMSMAPPTIME"].ToString().Replace(":", ""));
        //            dbCon.AddParameters("P_SMSMCOMMENT", DbType.String, ht["P_SMSMCOMMENT"]);
        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_SAFETY_UPT");

        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);
        //        }
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 운영팀 담담자 확인
        //public DataSet UP_SAFEORDER_OPERA_UPT(Hashtable ht)
        //{
        //    string sSTATE = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        if (sSTATE == "")
        //        {
        //            dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMOPSABUN"]);

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                if (ht["P_SMWKTEAM"].ToString().Substring(0, 1) == "S")
        //                {
        //                    if (ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString().Substring(0, 2) != "S1")
        //                    {
        //                        sSTATE = "ERR";

        //                        row = dt.NewRow();
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "확인자를 확인하세요";
        //                        dt.Rows.Add(row);
        //                        //dsMsg.Tables.Add(dt);
        //                    }
        //                }
        //                else if (ht["P_SMWKTEAM"].ToString().Substring(0, 1) == "T")
        //                {
        //                    if (ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString().Substring(0, 2) != "T1")
        //                    {
        //                        sSTATE = "ERR";

        //                        row = dt.NewRow();
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "확인자를 확인하세요";
        //                        dt.Rows.Add(row);
        //                        //dsMsg.Tables.Add(dt);
        //                    }
        //                }
        //                else
        //                {
        //                    if (ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString().Substring(0, 2) != "S1" && ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString().Substring(0, 2) != "T1")
        //                    {
        //                        sSTATE = "ERR";

        //                        row = dt.NewRow();
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "확인자를 확인하세요";
        //                        dt.Rows.Add(row);
        //                        //dsMsg.Tables.Add(dt);
        //                    }
        //                }
        //            }
        //            else
        //            {
        //                sSTATE = "ERR";

        //                row = dt.NewRow();
        //                row["STATE"] = "ERR";
        //                row["MSG"] = "확인자를 확인하세요";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);
        //            }

        //        }

        //        if (sSTATE == "")
        //        {
        //            dbCon.AddParameters("P_SMOPSABUN", DbType.String, ht["P_SMOPSABUN"]);
        //            dbCon.AddParameters("P_SMOPAPPDATE", DbType.String, Get_Date(ht["P_SMOPAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMOPAPPTIME", DbType.String, ht["P_SMOPAPPTIME"].ToString().Replace(":", ""));
        //            dbCon.AddParameters("P_SMOPCOMMENT", DbType.String, ht["P_SMOPCOMMENT"]);
        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_OPERA_UPT");

        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);
        //        }
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : BIN 상태 업데이트
        //public DataSet UP_BIN_STATUSMF_CHECK(Hashtable ht)
        //{
        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMSYSTEMCODE1", DbType.String, ht["P_SMSYSTEMCODE1"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE2", DbType.String, ht["P_SMSYSTEMCODE2"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE3", DbType.String, ht["P_SMSYSTEMCODE3"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE4", DbType.String, ht["P_SMSYSTEMCODE4"]);
        //        dbCon.AddParameters("P_SMSYSTEMCODE5", DbType.String, ht["P_SMSYSTEMCODE5"]);
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SYULBI_CHECK");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            if (ds.Tables[0].Rows[0]["CLWKTEAM"].ToString() != "")
        //            {
        //                row = dt.NewRow();
        //                row["STATE"] = "ERR";
        //                row["MSG"] = "SILO BIN CLEANING이 진행중이므로 작업 완료가 불가합니다.";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);
        //            }
        //            else
        //            {
        //                row = dt.NewRow();
        //                row["STATE"] = "OK";
        //                row["MSG"] = "";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);
        //            }
        //        }
        //        else
        //        {
        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);
        //        }
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 공사완료 업데이트
        //public DataSet UP_SAFEORDER_FINISH_UPT(Hashtable ht)
        //{
        //    string sSTATE = string.Empty;
        //    string sBUSEO = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMFSSABUN"]);

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sBUSEO = ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString();

        //            if (ht["P_HDNBUSEO"].ToString().Substring(0, 2) != sBUSEO.ToString().Substring(0, 2))
        //            {
        //                sSTATE = "ERR";
        //            }

        //            if (sSTATE != "")
        //            {
        //                row = dt.NewRow();
        //                row["STATE"] = "ERR";
        //                row["MSG"] = "요청자의 부서코드와 완료 허가자의 부서가 다릅니다. 완료허가자를 확인하세요.";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);
        //            }
        //        }
        //    }

        //    if (sSTATE == "")
        //    {
        //        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //        {
        //            dbCon.AddParameters("P_SMFSSABUN", DbType.String, ht["P_SMFSSABUN"]);
        //            dbCon.AddParameters("P_SMFSDATE", DbType.String, Get_Date(ht["P_SMFSDATE"].ToString()));
        //            dbCon.AddParameters("P_SMFSTIME", DbType.String, ht["P_SMFSTIME"].ToString().Replace(":", ""));
        //            dbCon.AddParameters("P_SMFSWKCLOSE", DbType.String, ht["P_SMFSWKCLOSE"]);
        //            dbCon.AddParameters("P_SMFSWKTEXT", DbType.String, ht["P_SMFSWKTEXT"]);
        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_FINISH_UPT");
        //        }
        //    }

        //    if (sSTATE == "")
        //    {
        //        if (ht["P_SMFSWKCLOSE"].ToString() == "Y")
        //        {
        //            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //            {
        //                dbCon.AddParameters("P_SMFSDATE", DbType.String, Get_Date(ht["P_SMFSDATE"].ToString()));
        //                dbCon.AddParameters("P_SMFSSABUN", DbType.String, ht["P_SMFSSABUN"]);
        //                dbCon.AddParameters("P_SMFSWKTEXT", DbType.String, ht["P_SMFSWKTEXT"]);
        //                dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //                dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //                dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_WORKORDER_FINISH_UPT");
        //            }

        //            // 공사 완료시 HISTORY 테이블 생성
        //            if (ht["P_SMSYSTEMCODE1"].ToString() != "")
        //            {
        //                UP_CREATE_HISTORY(ht["P_SMWKTEAM"].ToString(),
        //                                  Get_Date(ht["P_SMWKDATE"].ToString()),
        //                                  Set_Fill3(ht["P_SMWKSEQ"].ToString()),
        //                                  ht["P_SMSYSTEMCODE1"].ToString(),
        //                                  Get_Date(ht["P_SMFSDATE"].ToString()),
        //                                  ht["P_SMSUBVEND"].ToString()
        //                                  );
        //            }

        //            if (ht["P_SMSYSTEMCODE2"].ToString() != "")
        //            {
        //                UP_CREATE_HISTORY(ht["P_SMWKTEAM"].ToString(),
        //                                  Get_Date(ht["P_SMWKDATE"].ToString()),
        //                                  Set_Fill3(ht["P_SMWKSEQ"].ToString()),
        //                                  ht["P_SMSYSTEMCODE2"].ToString(),
        //                                  Get_Date(ht["P_SMFSDATE"].ToString()),
        //                                  ht["P_SMSUBVEND"].ToString()
        //                                  );
        //            }

        //            if (ht["P_SMSYSTEMCODE3"].ToString() != "")
        //            {
        //                UP_CREATE_HISTORY(ht["P_SMWKTEAM"].ToString(),
        //                                  Get_Date(ht["P_SMWKDATE"].ToString()),
        //                                  Set_Fill3(ht["P_SMWKSEQ"].ToString()),
        //                                  ht["P_SMSYSTEMCODE3"].ToString(),
        //                                  Get_Date(ht["P_SMFSDATE"].ToString()),
        //                                  ht["P_SMSUBVEND"].ToString()
        //                                  );
        //            }

        //            if (ht["P_SMSYSTEMCODE4"].ToString() != "")
        //            {
        //                UP_CREATE_HISTORY(ht["P_SMWKTEAM"].ToString(),
        //                                  Get_Date(ht["P_SMWKDATE"].ToString()),
        //                                  Set_Fill3(ht["P_SMWKSEQ"].ToString()),
        //                                  ht["P_SMSYSTEMCODE4"].ToString(),
        //                                  Get_Date(ht["P_SMFSDATE"].ToString()),
        //                                  ht["P_SMSUBVEND"].ToString()
        //                                  );
        //            }

        //            if (ht["P_SMSYSTEMCODE5"].ToString() != "")
        //            {
        //                UP_CREATE_HISTORY(ht["P_SMWKTEAM"].ToString(),
        //                                  Get_Date(ht["P_SMWKDATE"].ToString()),
        //                                  Set_Fill3(ht["P_SMWKSEQ"].ToString()),
        //                                  ht["P_SMSYSTEMCODE5"].ToString(),
        //                                  Get_Date(ht["P_SMFSDATE"].ToString()),
        //                                  ht["P_SMSUBVEND"].ToString()
        //                                  );
        //            }


        //            // 작업요청서 요청자,수신자 메일 발송
        //            UP_Mail_WK_Send(ht["P_SMWKTEAM"].ToString(), Get_Date(ht["P_SMWKDATE"].ToString()), Set_Fill3(ht["P_SMWKSEQ"].ToString()),
        //                            ht["P_SMWORKTITLE"].ToString(), ht["P_SMAREATEXT1"].ToString(), ht["P_SMFSWKTEXT"].ToString());
        //        }

        //        row = dt.NewRow();
        //        row["STATE"] = "OK";
        //        row["MSG"] = "";
        //        dt.Rows.Add(row);
        //        //dsMsg.Tables.Add(dt);
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 공사완료 취소 업데이트
        //public DataSet UP_SAFEORDER_CANCEL_UPT(Hashtable ht)
        //{
        //    string sSTATE = string.Empty;
        //    string sBUSEO = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));


        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMFSSABUN", DbType.String, ht["P_SMFSSABUN"]);
        //        dbCon.AddParameters("P_SMFSDATE", DbType.String, Get_Date(ht["P_SMFSDATE"].ToString()));
        //        dbCon.AddParameters("P_SMFSTIME", DbType.String, ht["P_SMFSTIME"].ToString().Replace(":", ""));
        //        dbCon.AddParameters("P_SMFSWKCLOSE", DbType.String, ht["P_SMFSWKCLOSE"]);
        //        dbCon.AddParameters("P_SMFSWKTEXT", DbType.String, ht["P_SMFSWKTEXT"]);
        //        dbCon.AddParameters("P_SMFSWKCANCEL", DbType.String, ht["P_SMFSWKCANCEL"]);
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_CANCEL_UPT");
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMFSDATE", DbType.String, Get_Date(ht["P_SMFSDATE"].ToString()));
        //        dbCon.AddParameters("P_SMFSSABUN", DbType.String, ht["P_SMFSSABUN"]);
        //        dbCon.AddParameters("P_SMFSWKTEXT", DbType.String, ht["P_SMFSWKTEXT"]);
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_WORKORDER_FINISH_UPT");

        //        row = dt.NewRow();
        //        row["STATE"] = "OK";
        //        row["MSG"] = "";
        //        dt.Rows.Add(row);
        //        dsMsg.Tables.Add(dt);
        //    }

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 작업 취소 업데이트
        //public DataSet UP_SAFEORDER_WORK_CANCEL(Hashtable ht)
        //{
        //    string sSTATE = string.Empty;
        //    string sBUSEO = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));


        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCNSABUN"]);

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sBUSEO = ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString();

        //            if (ht["P_HDNBUSEO"].ToString().Substring(0, 2) != sBUSEO.ToString().Substring(0, 2))
        //            {
        //                sSTATE = "ERR";

        //                row = dt.NewRow();

        //                row["STATE"] = "ERR";
        //                row["MSG"] = "요청자의 부서코드와 취소자의 부서가 다릅니다. 취소자를 확인하세요.";
        //                dt.Rows.Add(row);
        //                //dsMsg.Tables.Add(dt);
        //            }
        //        }
        //    }

        //    if (sSTATE == "")
        //    {
        //        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //        {
        //            dbCon.AddParameters("P_SMCNSABUN", DbType.String, ht["P_SMCNSABUN"]);
        //            dbCon.AddParameters("P_SMCNDATE", DbType.String, Get_Date(ht["P_SMCNDATE"].ToString()));
        //            dbCon.AddParameters("P_SMCNTIME", DbType.String, ht["P_SMCNTIME"].ToString().Replace(":", ""));
        //            dbCon.AddParameters("P_SMCNREASON", DbType.String, ht["P_SMCNREASON"]);
        //            dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //            dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //            dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //            dbCon.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));

        //            dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_WORK_CANCEL");

        //            row = dt.NewRow();
        //            row["STATE"] = "OK";
        //            row["MSG"] = "";
        //            dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);

        //            UP_Mail_CANCEL_Send(ht["P_SMWKTEAM"].ToString(),
        //                                Get_Date(ht["P_SMWKDATE"].ToString()),
        //                                Set_Fill3(ht["P_SMWKSEQ"].ToString()),
        //                                Get_Date(ht["P_SMWKORAPPDATE"].ToString()),
        //                                Set_Fill3(ht["P_SMWKORSEQ"].ToString()),
        //                                ht["P_SWWKCODE2"].ToString(),
        //                                ht["P_SWWKCODE3"].ToString(),
        //                                ht["P_SWWKCODE4"].ToString(),
        //                                ht["P_SWWKCODE5"].ToString(),
        //                                ht["P_SWWKCODE7"].ToString(),
        //                                ht["P_SWWKCODE8"].ToString(),
        //                                ht["P_SWWKCODE9"].ToString(),
        //                                ht["P_SWWKCODE10"].ToString(),
        //                                ht["P_SMORSABUN"].ToString(),
        //                                ht["P_SMGRSABUN"].ToString(),
        //                                ht["P_SMCOSABUN"].ToString(),
        //                                ht["P_SMCNSABUNNM"].ToString(),
        //                                ht["P_SMCNREASON"].ToString());
        //        }
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion

        //#region Description : 이력카드 생성
        //private void UP_CREATE_HISTORY(string sSMWKTEAM, string sSMWKDATE, string sSMWKSEQ, string sSMSYSTEMCODE, string sSMFSDATE, string sSMSUBVEND)
        //{
        //    string sHISAUP = string.Empty;
        //    string sHIBCODE = string.Empty;
        //    string sHIMCODE = string.Empty;
        //    string sHISCODE = string.Empty;
        //    string sHISEQ = string.Empty;

        //    string sWOPONUM1 = string.Empty;
        //    string sWOPONUM2 = string.Empty;
        //    string sWOPONUM3 = string.Empty;
        //    string sWOPONUM4 = string.Empty;
        //    string sWOPONUM5 = string.Empty;

        //    string sWOLOCATIONCODE1 = string.Empty;
        //    string sWOLOCATIONCODE2 = string.Empty;
        //    string sWOLOCATIONCODE3 = string.Empty;
        //    string sWOLOCATIONCODE4 = string.Empty;
        //    string sWOLOCATIONCODE5 = string.Empty;

        //    string sHIPONUM = string.Empty;
        //    string sHIMDDATE = string.Empty;
        //    string sHIASSETNM = string.Empty;
        //    string sHIWKNUM = string.Empty;
        //    string sHIWKSTDATE = string.Empty;
        //    string sHIWKEDDATE = string.Empty;

        //    sHIWKNUM = sSMWKTEAM.ToString() + sSMWKDATE.ToString() + Set_Fill3(sSMWKSEQ.ToString());

        //    sHISAUP = sSMSYSTEMCODE.ToString().Substring(0, 1);
        //    sHIBCODE = sSMSYSTEMCODE.ToString().Substring(1, 2);
        //    sHIMCODE = sSMSYSTEMCODE.ToString().Substring(3, 4);
        //    sHISCODE = sSMSYSTEMCODE.ToString().Substring(7, 3);

        //    DataSet ds = new DataSet();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_HISAUP", DbType.String, sHISAUP.ToString());
        //        dbCon.AddParameters("P_HIBCODE", DbType.String, sHIBCODE.ToString());
        //        dbCon.AddParameters("P_HIMCODE", DbType.VarNumeric, sHIMCODE.ToString());
        //        dbCon.AddParameters("P_HISCODE", DbType.VarNumeric, sHISCODE.ToString());

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SYSTEM_HISTORY_GET_MAX");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sHISEQ = ds.Tables[0].Rows[0]["SEQ"].ToString();
        //        }
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, sSMWKTEAM.ToString());
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(sSMWKDATE.ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(sSMWKSEQ.ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_WORKORDER_GET_PONUM");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sWOPONUM1 = ds.Tables[0].Rows[0]["WOPONUM1"].ToString();
        //            sWOPONUM2 = ds.Tables[0].Rows[0]["WOPONUM2"].ToString();
        //            sWOPONUM3 = ds.Tables[0].Rows[0]["WOPONUM3"].ToString();
        //            sWOPONUM4 = ds.Tables[0].Rows[0]["WOPONUM4"].ToString();
        //            sWOPONUM5 = ds.Tables[0].Rows[0]["WOPONUM5"].ToString();

        //            sWOLOCATIONCODE1 = ds.Tables[0].Rows[0]["WOLOCATIONCODE1"].ToString();
        //            sWOLOCATIONCODE2 = ds.Tables[0].Rows[0]["WOLOCATIONCODE2"].ToString();
        //            sWOLOCATIONCODE3 = ds.Tables[0].Rows[0]["WOLOCATIONCODE3"].ToString();
        //            sWOLOCATIONCODE4 = ds.Tables[0].Rows[0]["WOLOCATIONCODE4"].ToString();
        //            sWOLOCATIONCODE5 = ds.Tables[0].Rows[0]["WOLOCATIONCODE5"].ToString();

        //            sHIASSETNM = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
        //        }
        //    }

        //    if (sSMSYSTEMCODE.ToString() == sWOLOCATIONCODE1.ToString())
        //    {
        //        sHIPONUM = sWOPONUM1;
        //    }
        //    else if (sSMSYSTEMCODE.ToString() == sWOLOCATIONCODE2.ToString())
        //    {
        //        sHIPONUM = sWOPONUM2;
        //    }
        //    else if (sSMSYSTEMCODE.ToString() == sWOLOCATIONCODE3.ToString())
        //    {
        //        sHIPONUM = sWOPONUM3;
        //    }
        //    else if (sSMSYSTEMCODE.ToString() == sWOLOCATIONCODE4.ToString())
        //    {
        //        sHIPONUM = sWOPONUM4;
        //    }
        //    else if (sSMSYSTEMCODE.ToString() == sWOLOCATIONCODE5.ToString())
        //    {
        //        sHIPONUM = sWOPONUM5;
        //    }

        //    // 공사완료일
        //    sHIMDDATE = sSMFSDATE.ToString();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, sSMWKTEAM.ToString());
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(sSMWKDATE.ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(sSMWKSEQ.ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_GET_APPDATE");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sHIWKSTDATE = ds.Tables[0].Rows[0]["STDATE"].ToString();
        //            sHIWKEDDATE = ds.Tables[0].Rows[0]["EDDATE"].ToString();
        //        }
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_HISAUP", DbType.String, sHISAUP);
        //        dbCon.AddParameters("P_HIBCODE", DbType.String, sHIBCODE);
        //        dbCon.AddParameters("P_HIMCODE", DbType.VarNumeric, sHIMCODE);
        //        dbCon.AddParameters("P_HISCODE", DbType.VarNumeric, sHISCODE);
        //        dbCon.AddParameters("P_HISEQ", DbType.VarNumeric, sHISEQ);
        //        dbCon.AddParameters("P_HIPONUM", DbType.String, sHIPONUM);
        //        dbCon.AddParameters("P_HIMDDATE", DbType.String, sHIMDDATE);
        //        dbCon.AddParameters("P_HIASSETNM", DbType.String, sHIASSETNM);
        //        dbCon.AddParameters("P_HIITEM", DbType.String, "");
        //        dbCon.AddParameters("P_HIQUALITY", DbType.VarNumeric, "0");
        //        dbCon.AddParameters("P_HIAMT", DbType.VarNumeric, "0");
        //        dbCon.AddParameters("P_HICOMPANY", DbType.String, sSMSUBVEND);
        //        dbCon.AddParameters("P_HIWKSTDATE", DbType.String, sHIWKSTDATE);
        //        dbCon.AddParameters("P_HIWKEDDATE", DbType.String, sHIWKEDDATE);
        //        dbCon.AddParameters("P_HIWKNUM", DbType.String, sHIWKNUM);
        //        dbCon.AddParameters("P_HIBIGO", DbType.String, "");
        //        dbCon.AddParameters("P_HIHISAB", DbType.String, Document.UserInfo.EmpID);

        //        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SYSTEM_HISTORY_INS");
        //    }
        //}
        //#endregion

        //#region Description : 가스 점검 업데이트
        //public DataSet UP_INSPECT_UPT(Hashtable ht)
        //{
        //    string sSTATE = string.Empty;
        //    string sBUSEO = string.Empty;

        //    DataSet ds = new DataSet();
        //    DataSet retds = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("SEQ", typeof(System.String));
        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));
        //    dt.Columns.Add("KBHANGL", typeof(System.String));


        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        if (ht["P_GUBUN"].ToString() == "1")
        //        {
        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN1"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN1"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        sBUSEO = ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString();

        //                        if (ht["P_HDNBUSEO"].ToString().Substring(0, 2) != sBUSEO.ToString().Substring(0, 2))
        //                        {
        //                            sSTATE = "ERR";
        //                        }

        //                        if (sSTATE == "")
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "1";
        //                            row["STATE"] = "";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                        else
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "1";
        //                            row["STATE"] = "ERR";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                    }
        //                }
        //            }

        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN2"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN2"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        sBUSEO = ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString();

        //                        if (ht["P_HDNBUSEO"].ToString().Substring(0, 2) != sBUSEO.ToString().Substring(0, 2))
        //                        {
        //                            sSTATE = "ERR";
        //                        }

        //                        if (sSTATE == "")
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "2";
        //                            row["STATE"] = "";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                        else
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "2";
        //                            row["STATE"] = "ERR";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                    }
        //                }
        //            }

        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN3"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN3"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        sBUSEO = ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString();

        //                        if (ht["P_HDNBUSEO"].ToString().Substring(0, 2) != sBUSEO.ToString().Substring(0, 2))
        //                        {
        //                            sSTATE = "ERR";
        //                        }

        //                        if (sSTATE == "")
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "3";
        //                            row["STATE"] = "";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                        else
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "3";
        //                            row["STATE"] = "ERR";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                    }
        //                }
        //            }

        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN4"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN4"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        sBUSEO = ds.Tables[0].Rows[0]["KBBUSEOCODE"].ToString();

        //                        if (ht["P_HDNBUSEO"].ToString().Substring(0, 2) != sBUSEO.ToString().Substring(0, 2))
        //                        {
        //                            sSTATE = "ERR";
        //                        }

        //                        if (sSTATE == "")
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "4";
        //                            row["STATE"] = "";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                        else
        //                        {
        //                            row = dt.NewRow();
        //                            row["SEQ"] = "4";
        //                            row["STATE"] = "ERR";
        //                            row["MSG"] = "";
        //                            row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                            dt.Rows.Add(row);
        //                            //retds.Tables.Add(dt);
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //        else
        //        {
        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN5"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN5"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "5";
        //                        row["STATE"] = "";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                    else
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "5";
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                }
        //            }

        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN6"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN6"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "6";
        //                        row["STATE"] = "";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                    else
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "6";
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                }
        //            }

        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN7"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN7"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "7";
        //                        row["STATE"] = "";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                    else
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "7";
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                }
        //            }

        //            if (sSTATE == "")
        //            {
        //                if (ht["P_SMCHKSABUN8"].ToString() != "")
        //                {
        //                    dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMCHKSABUN8"]);

        //                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_KBSABUN_RUN");

        //                    if (ds.Tables[0].Rows.Count > 0)
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "8";
        //                        row["STATE"] = "";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                    else
        //                    {
        //                        row = dt.NewRow();
        //                        row["SEQ"] = "8";
        //                        row["STATE"] = "ERR";
        //                        row["MSG"] = "";
        //                        row["KBHANGL"] = ds.Tables[0].Rows[0]["KBHANGL"].ToString();
        //                        dt.Rows.Add(row);
        //                        //retds.Tables.Add(dt);
        //                    }
        //                }
        //            }
        //        }
        //    }

        //    if (sSTATE == "")
        //    {
        //        try
        //        {
        //            using (DB2Connecter dbCon1 = new DB2Connecter("DB2"))
        //            {
        //                dbCon1.AddParameters("P_SMCHKSABUN1", DbType.String, ht["P_SMCHKSABUN1"]);
        //                dbCon1.AddParameters("P_SMCHKTIME1", DbType.String, ht["P_SMCHKTIME1"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN1", DbType.String, ht["P_SMCHKOXYGEN1"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT1", DbType.String, ht["P_SMCHKOXYGENUNIT1"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM1", DbType.VarNumeric, ht["P_SMCHKTOXNUM1"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT1", DbType.String, ht["P_SMCHKTOXUNIT1"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM1DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM1DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT1DS", DbType.String, ht["P_SMCHKTOXUNIT1DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM1CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM1CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT1CO2", DbType.String, ht["P_SMCHKTOXUNIT1CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM1CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM1CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT1CO", DbType.String, ht["P_SMCHKTOXUNIT1CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM1H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM1H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT1H2S", DbType.String, ht["P_SMCHKTOXUNIT1H2S"]);
        //                dbCon1.AddParameters("P_SMCHKSABUN2", DbType.String, ht["P_SMCHKSABUN2"]);
        //                dbCon1.AddParameters("P_SMCHKTIME2", DbType.String, ht["P_SMCHKTIME2"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN2", DbType.String, ht["P_SMCHKOXYGEN2"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT2", DbType.String, ht["P_SMCHKOXYGENUNIT2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM2", DbType.VarNumeric, ht["P_SMCHKTOXNUM2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT2", DbType.String, ht["P_SMCHKTOXUNIT2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM2DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM2DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT2DS", DbType.String, ht["P_SMCHKTOXUNIT2DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM2CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM2CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT2CO2", DbType.String, ht["P_SMCHKTOXUNIT2CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM2CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM2CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT2CO", DbType.String, ht["P_SMCHKTOXUNIT2CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM2H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM2H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT2H2S", DbType.String, ht["P_SMCHKTOXUNIT2H2S"]);
        //                dbCon1.AddParameters("P_SMCHKSABUN3", DbType.String, ht["P_SMCHKSABUN3"]);
        //                dbCon1.AddParameters("P_SMCHKTIME3", DbType.String, ht["P_SMCHKTIME3"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN3", DbType.String, ht["P_SMCHKOXYGEN3"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT3", DbType.String, ht["P_SMCHKOXYGENUNIT3"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM3", DbType.VarNumeric, ht["P_SMCHKTOXNUM3"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT3", DbType.String, ht["P_SMCHKTOXUNIT3"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM3DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM3DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT3DS", DbType.String, ht["P_SMCHKTOXUNIT3DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM3CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM3CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT3CO2", DbType.String, ht["P_SMCHKTOXUNIT3CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM3CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM3CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT3CO", DbType.String, ht["P_SMCHKTOXUNIT3CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM3H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM3H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT3H2S", DbType.String, ht["P_SMCHKTOXUNIT3H2S"]);
        //                dbCon1.AddParameters("P_SMCHKSABUN4", DbType.String, ht["P_SMCHKSABUN4"]);
        //                dbCon1.AddParameters("P_SMCHKTIME4", DbType.String, ht["P_SMCHKTIME4"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN4", DbType.String, ht["P_SMCHKOXYGEN4"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT4", DbType.String, ht["P_SMCHKOXYGENUNIT4"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM4", DbType.VarNumeric, ht["P_SMCHKTOXNUM4"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT4", DbType.String, ht["P_SMCHKTOXUNIT4"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM4DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM4DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT4DS", DbType.String, ht["P_SMCHKTOXUNIT4DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM4CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM4CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT4CO2", DbType.String, ht["P_SMCHKTOXUNIT4CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM4CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM4CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT4CO", DbType.String, ht["P_SMCHKTOXUNIT4CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM4H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM4H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT4H2S", DbType.String, ht["P_SMCHKTOXUNIT4H2S"]);
        //                dbCon1.AddParameters("P_SMCHKSABUN5", DbType.String, ht["P_SMCHKSABUN5"]);
        //                dbCon1.AddParameters("P_SMCHKTIME5", DbType.String, ht["P_SMCHKTIME5"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN5", DbType.String, ht["P_SMCHKOXYGEN5"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT5", DbType.String, ht["P_SMCHKOXYGENUNIT5"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM5", DbType.VarNumeric, ht["P_SMCHKTOXNUM5"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT5", DbType.String, ht["P_SMCHKTOXUNIT5"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM5DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM5DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT5DS", DbType.String, ht["P_SMCHKTOXUNIT5DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM5CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM5CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT5CO2", DbType.String, ht["P_SMCHKTOXUNIT5CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM5CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM5CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT5CO", DbType.String, ht["P_SMCHKTOXUNIT5CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM5H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM5H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT5H2S", DbType.String, ht["P_SMCHKTOXUNIT5H2S"]);
        //                dbCon1.AddParameters("P_SMCHKSABUN6", DbType.String, ht["P_SMCHKSABUN6"]);
        //                dbCon1.AddParameters("P_SMCHKTIME6", DbType.String, ht["P_SMCHKTIME6"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN6", DbType.String, ht["P_SMCHKOXYGEN6"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT6", DbType.String, ht["P_SMCHKOXYGENUNIT6"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM6", DbType.VarNumeric, ht["P_SMCHKTOXNUM6"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT6", DbType.String, ht["P_SMCHKTOXUNIT6"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM6DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM6DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT6DS", DbType.String, ht["P_SMCHKTOXUNIT6DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM6CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM6CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT6CO2", DbType.String, ht["P_SMCHKTOXUNIT6CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM6CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM6CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT6CO", DbType.String, ht["P_SMCHKTOXUNIT6CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM6H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM6H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT6H2S", DbType.String, ht["P_SMCHKTOXUNIT6H2S"]);
        //                dbCon1.AddParameters("P_SMCHKSABUN7", DbType.String, ht["P_SMCHKSABUN7"]);
        //                dbCon1.AddParameters("P_SMCHKTIME7", DbType.String, ht["P_SMCHKTIME7"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN7", DbType.String, ht["P_SMCHKOXYGEN7"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT7", DbType.String, ht["P_SMCHKOXYGENUNIT7"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM7", DbType.VarNumeric, ht["P_SMCHKTOXNUM7"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT7", DbType.String, ht["P_SMCHKTOXUNIT7"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM7DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM7DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT7DS", DbType.String, ht["P_SMCHKTOXUNIT7DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM7CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM7CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT7CO2", DbType.String, ht["P_SMCHKTOXUNIT7CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM7CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM7CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT7CO", DbType.String, ht["P_SMCHKTOXUNIT7CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM7H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM7H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT7H2S", DbType.String, ht["P_SMCHKTOXUNIT7H2S"]);
        //                dbCon1.AddParameters("P_SMCHKSABUN8", DbType.String, ht["P_SMCHKSABUN8"]);
        //                dbCon1.AddParameters("P_SMCHKTIME8", DbType.String, ht["P_SMCHKTIME8"].ToString().Replace(":", ""));
        //                dbCon1.AddParameters("P_SMCHKOXYGEN8", DbType.String, ht["P_SMCHKOXYGEN8"]);
        //                dbCon1.AddParameters("P_SMCHKOXYGENUNIT8", DbType.String, ht["P_SMCHKOXYGENUNIT8"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM8", DbType.VarNumeric, ht["P_SMCHKTOXNUM8"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT8", DbType.String, ht["P_SMCHKTOXUNIT8"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM8DS", DbType.VarNumeric, ht["P_SMCHKTOXNUM8DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT8DS", DbType.String, ht["P_SMCHKTOXUNIT8DS"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM8CO2", DbType.VarNumeric, ht["P_SMCHKTOXNUM8CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT8CO2", DbType.String, ht["P_SMCHKTOXUNIT8CO2"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM8CO", DbType.VarNumeric, ht["P_SMCHKTOXNUM8CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT8CO", DbType.String, ht["P_SMCHKTOXUNIT8CO"]);
        //                dbCon1.AddParameters("P_SMCHKTOXNUM8H2S", DbType.VarNumeric, ht["P_SMCHKTOXNUM8H2S"]);
        //                dbCon1.AddParameters("P_SMCHKTOXUNIT8H2S", DbType.String, ht["P_SMCHKTOXUNIT8H2S"]);
        //                dbCon1.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //                dbCon1.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //                dbCon1.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //                dbCon1.AddParameters("P_SMWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //                dbCon1.AddParameters("P_SMWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));
        //                dbCon1.AddParameters("P_GUBUN", DbType.String, ht["P_GUBUN"]);


        //                //dbCon1.AddParameters("P_SMCHKSABUN1", DbType.VarNumeric, ht["P_SMCHKSABUN1"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME1", DbType.VarNumeric, ht["P_SMCHKTIME1"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN1", DbType.VarNumeric, ht["P_SMCHKOXYGEN1"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT1", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT1"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM1", DbType.String, ht["P_SMCHKTOXNUM1"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT1", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM1DS", DbType.String, ht["P_SMCHKTOXNUM1DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT1DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM1CO2", DbType.String, ht["P_SMCHKTOXNUM1CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT1CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM1CO", DbType.String, ht["P_SMCHKTOXNUM1CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT1CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM1H2S", DbType.String, ht["P_SMCHKTOXNUM1H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT1H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT1H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKSABUN2", DbType.VarNumeric, ht["P_SMCHKSABUN2"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME2", DbType.VarNumeric, ht["P_SMCHKTIME2"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN2", DbType.VarNumeric, ht["P_SMCHKOXYGEN2"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT2", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM2", DbType.String, ht["P_SMCHKTOXNUM2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM2DS", DbType.String, ht["P_SMCHKTOXNUM2DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT2DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM2CO2", DbType.String, ht["P_SMCHKTOXNUM2CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT2CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM2CO", DbType.String, ht["P_SMCHKTOXNUM2CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT2CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM2H2S", DbType.String, ht["P_SMCHKTOXNUM2H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT2H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT2H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKSABUN3", DbType.VarNumeric, ht["P_SMCHKSABUN3"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME3", DbType.VarNumeric, ht["P_SMCHKTIME3"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN3", DbType.VarNumeric, ht["P_SMCHKOXYGEN3"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT3", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT3"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM3", DbType.String, ht["P_SMCHKTOXNUM3"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT3", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM3DS", DbType.String, ht["P_SMCHKTOXNUM3DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT3DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM3CO2", DbType.String, ht["P_SMCHKTOXNUM3CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT3CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM3CO", DbType.String, ht["P_SMCHKTOXNUM3CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT3CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM3H2S", DbType.String, ht["P_SMCHKTOXNUM3H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT3H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT3H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKSABUN4", DbType.VarNumeric, ht["P_SMCHKSABUN4"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME4", DbType.VarNumeric, ht["P_SMCHKTIME4"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN4", DbType.VarNumeric, ht["P_SMCHKOXYGEN4"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT4", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT4"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM4", DbType.String, ht["P_SMCHKTOXNUM4"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT4", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM4DS", DbType.String, ht["P_SMCHKTOXNUM4DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT4DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM4CO2", DbType.String, ht["P_SMCHKTOXNUM4CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT4CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM4CO", DbType.String, ht["P_SMCHKTOXNUM4CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT4CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM4H2S", DbType.String, ht["P_SMCHKTOXNUM4H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT4H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT4H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKSABUN5", DbType.VarNumeric, ht["P_SMCHKSABUN5"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME5", DbType.VarNumeric, ht["P_SMCHKTIME5"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN5", DbType.VarNumeric, ht["P_SMCHKOXYGEN5"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT5", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT5"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM5", DbType.String, ht["P_SMCHKTOXNUM5"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT5", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM5DS", DbType.String, ht["P_SMCHKTOXNUM5DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT5DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM5CO2", DbType.String, ht["P_SMCHKTOXNUM5CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT5CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM5CO", DbType.String, ht["P_SMCHKTOXNUM5CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT5CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM5H2S", DbType.String, ht["P_SMCHKTOXNUM5H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT5H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT5H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKSABUN6", DbType.VarNumeric, ht["P_SMCHKSABUN6"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME6", DbType.VarNumeric, ht["P_SMCHKTIME6"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN6", DbType.VarNumeric, ht["P_SMCHKOXYGEN6"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT6", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT6"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM6", DbType.String, ht["P_SMCHKTOXNUM6"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT6", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM6DS", DbType.String, ht["P_SMCHKTOXNUM6DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT6DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM6CO2", DbType.String, ht["P_SMCHKTOXNUM6CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT6CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM6CO", DbType.String, ht["P_SMCHKTOXNUM6CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT6CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM6H2S", DbType.String, ht["P_SMCHKTOXNUM6H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT6H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT6H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKSABUN7", DbType.VarNumeric, ht["P_SMCHKSABUN7"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME7", DbType.VarNumeric, ht["P_SMCHKTIME7"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN7", DbType.VarNumeric, ht["P_SMCHKOXYGEN7"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT7", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT7"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM7", DbType.String, ht["P_SMCHKTOXNUM7"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT7", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM7DS", DbType.String, ht["P_SMCHKTOXNUM7DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT7DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM7CO2", DbType.String, ht["P_SMCHKTOXNUM7CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT7CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM7CO", DbType.String, ht["P_SMCHKTOXNUM7CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT7CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM7H2S", DbType.String, ht["P_SMCHKTOXNUM7H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT7H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT7H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKSABUN8", DbType.VarNumeric, ht["P_SMCHKSABUN8"]);
        //                //dbCon1.AddParameters("P_SMCHKTIME8", DbType.VarNumeric, ht["P_SMCHKTIME8"].ToString().Replace(":", ""));
        //                //dbCon1.AddParameters("P_SMCHKOXYGEN8", DbType.VarNumeric, ht["P_SMCHKOXYGEN8"]);
        //                //dbCon1.AddParameters("P_SMCHKOXYGENUNIT8", DbType.VarNumeric, ht["P_SMCHKOXYGENUNIT8"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM8", DbType.String, ht["P_SMCHKTOXNUM8"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT8", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM8DS", DbType.String, ht["P_SMCHKTOXNUM8DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT8DS", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8DS"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM8CO2", DbType.String, ht["P_SMCHKTOXNUM8CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT8CO2", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8CO2"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM8CO", DbType.String, ht["P_SMCHKTOXNUM8CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT8CO", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8CO"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXNUM8H2S", DbType.String, ht["P_SMCHKTOXNUM8H2S"]);
        //                //dbCon1.AddParameters("P_SMCHKTOXUNIT8H2S", DbType.VarNumeric, ht["P_SMCHKTOXUNIT8H2S"]);
        //                //dbCon1.AddParameters("P_SMWKTEAM", DbType.VarNumeric, ht["P_SMWKTEAM"]);
        //                //dbCon1.AddParameters("P_SMWKDATE", DbType.VarNumeric, Get_Date(ht["P_SMWKDATE"].ToString()));
        //                //dbCon1.AddParameters("P_SMWKSEQ", DbType.String, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //                //dbCon1.AddParameters("P_SMWKORAPPDATE", DbType.VarNumeric, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //                //dbCon1.AddParameters("P_SMWKORSEQ", DbType.String, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));
        //                //dbCon1.AddParameters("P_GUBUN", DbType.VarNumeric, ht["P_GUBUN"]);


        //                dbCon1.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_SAFEORDER_MASTER_INSPECT_UPT");

        //                row = dt.NewRow();
        //                row["SEQ"] = "10";
        //                row["STATE"] = "OK";
        //                row["MSG"] = "";
        //                row["KBHANGL"] = "";
        //                dt.Rows.Add(row);
        //            }
        //        }
        //        catch (Exception e)
        //        {
        //            string message = string.Empty;

        //            message = e.ToString();
        //        }
        //    }

        //    retds.Tables.Add(dt);

        //    return retds;
        //}
        //#endregion



        //#region Description : 운영팀 동일부서 조회
        //public DataSet UP_OPERA_BUSEO_CHECK(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_KBSABUN"]);
        //        dbCon.AddParameters("P_LOGINID", DbType.String, ht["P_LOGINID"]);

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_BUSEO_EQUAL_CHECK");
        //    }
        //}
        //#endregion

        //#region Description : 안전작업허가서 마지막 데이터 조회
        //public DataSet UP_SAFEORDER_LAST_CHECK(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_SMWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SMWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_LAST_CHECK");
        //    }
        //}
        //#endregion

        //#region Description : 메일 발송
        //public DataSet UP_MAIL(Hashtable ht)
        //{
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));

        //    try
        //    {
        //        // 안전작업허가서 메일 발송
        //        UP_MAIL_SEND(ht);

        //        if (ht["chkSWWKCODE2"].ToString() == "Y" || ht["chkSWWKCODE3"].ToString() == "Y" || ht["chkSWWKCODE4"].ToString() == "Y" ||
        //            ht["chkSWWKCODE5"].ToString() == "Y" || ht["chkSWWKCODE7"].ToString() == "Y" ||
        //            ht["chkSWWKCODE8"].ToString() == "Y" || ht["chkSWWKCODE9"].ToString() == "Y" || ht["chkSWWKCODE10"].ToString() == "Y")
        //        {
        //            if (ht["P_hdnApprovalSite"].ToString() == "1" || ht["P_hdnApprovalSite"].ToString() == "3")
        //            {
        //                // 안전환경팀 메일 발송
        //                UP_Safe_Mail_Send(ht);
        //            }
        //        }

        //        if (ht["P_SMOPSABUN"].ToString() != "")
        //        {
        //            if (ht["P_hdnApprovalSite"].ToString() == "2" || ht["P_hdnApprovalSite"].ToString() == "3")
        //            {
        //                // 운영팀 메일 발송
        //                UP_Operater_Mail_Send(ht);
        //            }
        //        }

        //        // 안전 감독자 결재 후 참조자 메일 발송
        //        if (ht["P_hdnApprovalSite"].ToString() == "3")
        //        {
        //            UP_Mail_Reference_Send(ht);
        //        }

        //        string sSILOBIN = string.Empty;

        //        if (ht["P_hdnApprovalSite"].ToString() == "3")
        //        {
        //            DataSet ds = new DataSet();

        //            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //            {
        //                // BIN번호도 가져오고 SILO BIN 상태관리 업데이트도 같이 함
        //                dbCon.AddParameters("P_SMSYSTEMCODE1", DbType.String, ht["P_SMSYSTEMCODE1"]);
        //                dbCon.AddParameters("P_SMSYSTEMCODE2", DbType.String, ht["P_SMSYSTEMCODE2"]);
        //                dbCon.AddParameters("P_SMSYSTEMCODE3", DbType.String, ht["P_SMSYSTEMCODE2"]);
        //                dbCon.AddParameters("P_SMSYSTEMCODE4", DbType.String, ht["P_SMSYSTEMCODE4"]);
        //                dbCon.AddParameters("P_SMSYSTEMCODE5", DbType.String, ht["P_SMSYSTEMCODE5"]);
        //                dbCon.AddParameters("P_SWWKCODE5", DbType.String, ht["chkSWWKCODE5"]);


        //                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SYULBI_LIST");

        //                if (ds.Tables[0].Rows.Count > 0)
        //                {
        //                    sSILOBIN = ds.Tables[0].Rows[0]["SILOBIN"].ToString();
        //                }
        //            }

        //            if (ht["chkSWWKCODE5"].ToString() == "Y")
        //            {
        //                string sSTIME = string.Empty;
        //                string sETIME = string.Empty;

        //                sSTIME = ht["P_SHH"].ToString() + ht["P_SMM"].ToString();
        //                sETIME = ht["P_EHH"].ToString() + ht["P_EMM"].ToString();

        //                // SILO BIN 코드 존재시 BIN 장치현황 등록
        //                if (sSILOBIN.ToString() != "")
        //                {
        //                    // SILO BIN CLEANING 등록
        //                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //                    {
        //                        dbCon.AddParameters("P_CLWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //                        dbCon.AddParameters("P_CLWKDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //                        dbCon.AddParameters("P_CLWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));
        //                        dbCon.AddParameters("P_CLWKORAPPDATE", DbType.String, Get_Date(ht["P_SMWKORAPPDATE"].ToString()));
        //                        dbCon.AddParameters("P_CLWKORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKORSEQ"].ToString()));
        //                        dbCon.AddParameters("P_CLBINNO", DbType.String, sSILOBIN.ToString());
        //                        dbCon.AddParameters("P_CLWORKTEXT", DbType.String, ht["P_SMWORKTITLE"].ToString());
        //                        dbCon.AddParameters("P_CLCOSABUN", DbType.String, ht["P_SMCOSABUN"].ToString());
        //                        dbCon.AddParameters("P_CLSTATIME", DbType.String, sSTIME.ToString());
        //                        dbCon.AddParameters("P_CLETATIME", DbType.String, sETIME.ToString());
        //                        dbCon.AddParameters("P_CLHISAB", DbType.String, ht["P_SMCOSABUN"].ToString());

        //                        dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM4041_BIN_CLEANING_INS");
        //                    }

        //                    string sWKTEXT = Get_Date(ht["P_SMWKORAPPDATE"].ToString()) + " " + ht["P_SHH"].ToString() + ":" + ht["P_SMM"].ToString() + "~"
        //                                     + ht["P_EHH"].ToString() + ":" + ht["P_EMM"].ToString();

        //                    // HMI_SILOBIN_JEGOF 클리닝 업데이트
        //                    using (DacConnecter dac = new DacConnecter("ORA"))
        //                    {
        //                        dac.AddParameters("IN_WK1BINNO", DbType.String, sSILOBIN.ToString());
        //                        dac.AddParameters("IN_STBIN", DbType.String, "1");
        //                        dac.AddParameters("IN_WKTEXT", DbType.String, sWKTEXT);

        //                        dac.ExcuteNonQuery("TTML.SP_HMI_SILOBIN_JEGOF_UPT");

        //                        row = dt.NewRow();
        //                        row["STATE"] = "OK";
        //                        row["MSG"] = "OK";
        //                        dt.Rows.Add(row);
        //                    }
        //                }
        //            }
        //        }

        //        row = dt.NewRow();
        //        row["STATE"] = "OK";
        //        row["MSG"] = "OK";
        //        dt.Rows.Add(row);
        //        //dsMsg.Tables.Add(dt);
        //    }
        //    catch
        //    {
        //        row = dt.NewRow();
        //        row["STATE"] = "ERR";
        //        row["MSG"] = "ERR";
        //        dt.Rows.Add(row);
        //        //dsMsg.Tables.Add(dt);
        //    }

        //    dsMsg.Tables.Add(dt);

        //    return dsMsg;
        //}
        //#endregion


        //public DataSet up_oracle_test(Hashtable ht)
        //{
        //    DataSet ds = new DataSet();
        //    DataSet dsMsg = new DataSet();
        //    DataTable dt = new DataTable();

        //    DataRow row;

        //    dt.Columns.Add("STATE", typeof(System.String));
        //    dt.Columns.Add("MSG", typeof(System.String));


        //    try
        //    {
        //        // HMI_SILOBIN_JEGOF 클리닝 업데이트
        //        using (DacConnecter dac = new DacConnecter("ORA"))
        //        {
        //            dac.AddParameters("IN_WK1BINNO", DbType.String, ht["P_BINNO"]);
        //            dac.AddParameters("IN_STBIN", DbType.String, ht["P_STBIN"]);
        //            dac.AddParameters("IN_WKTEXT", DbType.String, ht["P_WKTEXT"]);

        //            // 되는 소스 
        //            //dac.ExcuteNonQuery("TTML.SP_HMI_SILOBIN_JEGOF_UPT_TEST");

        //            //row = dt.NewRow();
        //            //row["STATE"] = "OK";
        //            //row["MSG"]   = "OK";
        //            //dt.Rows.Add(row);
        //            //dsMsg.Tables.Add(dt);
        //            // 되는 소스 


        //            ds = dac.ExcuteDataSet("TTML.SP_HMI_SILOBIN_JEGOF_UPT_TEST1");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                string msg = string.Empty;

        //                msg = ds.Tables[0].Rows[0][0].ToString();

        //                row = dt.NewRow();
        //                row["STATE"] = "OK";
        //                row["MSG"] = ds.Tables[0].Rows[0][0].ToString();
        //                dt.Rows.Add(row);
        //                dsMsg.Tables.Add(dt);
        //            }
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        string message = string.Empty;

        //        message = e.ToString();

        //        row = dt.NewRow();
        //        row["STATE"] = "ERR";
        //        row["MSG"] = "ERR";
        //        dt.Rows.Add(row);
        //        dsMsg.Tables.Add(dt);
        //    }

        //    return dsMsg;
        //}




        //#region Description : 안전작업허가서 메일 발송
        //private void UP_MAIL_SEND(Hashtable ht)
        //{
        //    string sTitle = string.Empty;

        //    string sMailFrom = string.Empty;
        //    string sMailTo = string.Empty;
        //    string sParamUrl = string.Empty;

        //    string sUrl = string.Empty;

        //    string sWOWORKTITLE = string.Empty;

        //    string sKBSABUN = string.Empty;
        //    string sGUBUN = string.Empty;

        //    int i = 0;
        //    int iSite = 0;


        //    // 요청자
        //    sKBSABUN = ht["P_KBSABUN"].ToString();

        //    if (ht["P_SMSMSABUN"].ToString() != "")
        //    {
        //        sKBSABUN = sKBSABUN + "," + ht["P_KBSABUN"].ToString();
        //    }


        //    /************************************************************************************************
        //     * 1. 주요작업일 경우 요청자 결재시 안전환경팀 전원에게 메일 발송 함.                           *
        //     * 3. 안전감독자 결재후 작업요청서의 요청결재라인, 수신결재라인,                                *
        //     *    안전작업허가서 요청자, 승인자, 안전환경팀 전원에게 메일 발송 함(중복사번은 한건으로 처리) *
        //     ************************************************************************************************/

        //    DataSet ds = new DataSet();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sWOWORKTITLE = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
        //        }
        //    }

        //    if (ht["P_hdnApprovalSite"].ToString() == "3")
        //    {
        //        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //        {
        //            // 작업요청서 - 요청 및 수신결재사번
        //            dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //            dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //            dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //                {
        //                    sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["SABUN"].ToString();
        //                }
        //            }
        //        }
        //    }

        //    /************************************************************************************************
        //     * - 주요작업일 경우 요청자 결재시 안전환경팀 메일 발송은 제외                                  *
        //     * - 별도의 메일 로직 추가되었음                                                                *
        //     ************************************************************************************************/

        //    sGUBUN = "";

        //    if (ht["chkSWWKCODE2"].ToString() == "Y" || ht["chkSWWKCODE3"].ToString() == "Y" || ht["chkSWWKCODE4"].ToString() == "Y" ||
        //        ht["chkSWWKCODE5"].ToString() == "Y" || ht["chkSWWKCODE7"].ToString() == "Y" ||
        //        ht["chkSWWKCODE8"].ToString() == "Y" || ht["chkSWWKCODE9"].ToString() == "Y" || ht["chkSWWKCODE10"].ToString() == "Y")
        //    {
        //        if (ht["P_hdnApprovalSite"].ToString() == "1" || ht["P_hdnApprovalSite"].ToString() == "3")
        //        {
        //            sGUBUN = "D";
        //        }
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        // 요청번호
        //        string sAPNUM = string.Empty;
        //        sAPNUM = ht["P_SMWKTEAM"].ToString() + "-" + Get_Date(ht["P_SMWKDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKSEQ"].ToString());

        //        // 허가번호
        //        string sRONUM = string.Empty;
        //        sRONUM = Get_Date(ht["P_SMWKORAPPDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKORSEQ"].ToString());

        //        sParamUrl = "/Portal/PSM/PSM40/PSM4041.aspx?";
        //        sParamUrl = sParamUrl + "GUBUN=UPT";
        //        sParamUrl = sParamUrl + "^APP_NUM=";
        //        sParamUrl = sParamUrl + sAPNUM;
        //        sParamUrl = sParamUrl + "^OR_NUM=";
        //        sParamUrl = sParamUrl + sRONUM;
        //        sParamUrl = sParamUrl + "^GUBUN=G";

        //        int iCOUNT = 0;

        //        if (ht["P_SMCOSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 3;
        //        }
        //        else if (ht["P_SMGRSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 2;
        //        }
        //        else if (ht["P_SMORSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 1;
        //        }

        //        if (int.Parse(Set_Fill3(ht["P_hdnApprovalSite"].ToString())) == iCOUNT)
        //        {
        //            sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 완료";
        //        }
        //        else
        //        {
        //            sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 제출";
        //        }


        //        // 메일 주소 가져오기
        //        dbCon.AddParameters("P_KBSABUN", DbType.String, sKBSABUN.ToString());
        //        dbCon.AddParameters("P_GUBUN", DbType.String, sGUBUN.ToString());

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_MAIL_LIST");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                if (i == 0)
        //                {
        //                    sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                }
        //                else
        //                {
        //                    sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                }
        //            }

        //            string sLine = "";

        //            MailMessage mess = new MailMessage();

        //            // 결재자 메일 주소 가져오기
        //            mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";

        //            sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + sKBSABUN + "&ID=" + sKBSABUN + "&LINKURL=" + sParamUrl;

        //            mess.To = sMailTo.ToString();

        //            mess.Subject = "[" + sTitle + "]";

        //            try
        //            {
        //                sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
        //                sLine += "<HTML>";
        //                sLine += "<HEAD>";
        //                sLine += "<TITLE> New Document </TITLE>";
        //                sLine += "<style type='text/css'>";
        //                sLine += "<!-- /* Global Css */ ";
        //                sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
        //                sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
        //                sLine += "img{border:none} --> </style> ";
        //                sLine += "<script language='javascript'>";
        //                sLine += " function AppPageLink() { ";
        //                sLine += "    document.frm.submit(); ";
        //                sLine += "  }";
        //                sLine += "</script>";
        //                sLine += "</HEAD>";
        //                sLine += "<BODY>";
        //                sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
        //                sLine += "    <tbody> ";
        //                sLine += "        <tr> ";
        //                sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 안전작업허가서 </th> ";
        //                sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
        //                sLine += "                  <a onclick = window.open('" + sUrl + "','문서보기','width=920,height=1000')> ";
        //                sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
        //                sLine += "            </td> ";
        //                sLine += "        </tr> ";

        //                sLine += "        <tr> ";
        //                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
        //                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
        //                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                sLine += "        </tr> ";
        //                sLine += "        <tr> ";
        //                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 허가번호 </th> ";
        //                sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sRONUM.ToString() + "</td> ";
        //                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                sLine += "        </tr> ";

        //                sLine += "        <tr> ";
        //                sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
        //                if (ht["P_SMAREATEXT1"].ToString() == "")
        //                {
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMWORKTITLE"].ToString() + "</td> ";
        //                }
        //                else
        //                {
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMAREATEXT1"].ToString() + "</td> ";
        //                }
        //                sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                sLine += "        </tr> ";

        //                sLine += "        <tr> ";
        //                sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
        //                sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
        //                sLine += "            </th> ";
        //                sLine += "        </tr> ";
        //                sLine += "    </tbody> ";
        //                sLine += "</table> ";
        //                sLine += "</form>";
        //                sLine += "</BODY>";
        //                sLine += "</HTML> ";

        //                mess.Body = sLine;
        //                mess.BodyFormat = MailFormat.Html;

        //                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

        //                // 메일 발송
        //                SmtpMail.Send(mess);
        //            }
        //            catch
        //            {
        //                return;
        //            }
        //        }
        //    }
        //}
        //#endregion

        //#region Description : 안전환경팀 메일 발송
        //private void UP_Safe_Mail_Send(Hashtable ht)
        //{
        //    /************************************************************************************************
        //     * 1. 주요작업일 경우 요청자 결재시 안전환경팀 전원에게 메일 발송 함.                           *
        //     * 3. 안전감독자 결재후 작업요청서의 요청결재라인, 수신결재라인,                                *
        //     *    안전작업허가서 요청자, 승인자, 안전환경팀 전원에게 메일 발송 함(중복사번은 한건으로 처리) *
        //     ************************************************************************************************/

        //    string sTitle = string.Empty;

        //    string sMailFrom = string.Empty;
        //    string sMailTo = string.Empty;
        //    string sParamUrl = string.Empty;

        //    string sUrl = string.Empty;

        //    string sWOWORKTITLE = string.Empty;

        //    string sKBSABUN = string.Empty;
        //    string sGUBUN = string.Empty;

        //    int i = 0;
        //    int iSite = 0;


        //    /************************************************************************************************
        //     * 1. 주요작업일 경우 요청자 결재시 안전환경팀 전원에게 메일 발송 함.                           *
        //     * 3. 안전감독자 결재후 작업요청서의 요청결재라인, 수신결재라인,                                *
        //     *    안전작업허가서 요청자, 승인자, 안전환경팀 전원에게 메일 발송 함(중복사번은 한건으로 처리) *
        //     ************************************************************************************************/

        //    DataSet ds = new DataSet();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sWOWORKTITLE = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
        //        }
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        // 안전환경팀 가져오기
        //        dbCon.AddParameters("P_GRPID", DbType.String, "SAFE_MAG");

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_GRPID_LIST");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                if (i == 0)
        //                {
        //                    sKBSABUN = ds.Tables[0].Rows[i]["KBSABUN"].ToString();
        //                }
        //                else
        //                {
        //                    sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["KBSABUN"].ToString();
        //                }
        //            }
        //        }
        //    }

        //    /************************************************************************************************
        //     * - 주요작업일 경우 요청자 결재시 안전환경팀 메일 발송은 제외                                  *
        //     * - 별도의 메일 로직 추가되었음                                                                *
        //     ************************************************************************************************/

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        // 요청번호
        //        string sAPNUM = string.Empty;
        //        sAPNUM = ht["P_SMWKTEAM"].ToString() + "-" + Get_Date(ht["P_SMWKDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKSEQ"].ToString());

        //        // 허가번호
        //        string sRONUM = string.Empty;
        //        sRONUM = Get_Date(ht["P_SMWKORAPPDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKORSEQ"].ToString());

        //        sParamUrl = "/Portal/PSM/PSM40/PSM4041.aspx?";
        //        sParamUrl = sParamUrl + "GUBUN=UPT";
        //        sParamUrl = sParamUrl + "^APP_NUM=";
        //        sParamUrl = sParamUrl + sAPNUM;
        //        sParamUrl = sParamUrl + "^OR_NUM=";
        //        sParamUrl = sParamUrl + sRONUM;
        //        sParamUrl = sParamUrl + "^GUBUN=G";

        //        int iCOUNT = 0;

        //        if (ht["P_SMCOSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 3;
        //        }
        //        else if (ht["P_SMGRSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 2;
        //        }
        //        else if (ht["P_SMORSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 1;
        //        }

        //        if (int.Parse(Set_Fill3(ht["P_hdnApprovalSite"].ToString())) == iCOUNT)
        //        {
        //            sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 완료";
        //        }
        //        else
        //        {
        //            sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 제출";
        //        }


        //        // 메일 주소 가져오기
        //        dbCon.AddParameters("P_KBSABUN", DbType.String, sKBSABUN.ToString());

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                if (i == 0)
        //                {
        //                    sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                }
        //                else
        //                {
        //                    sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                }

        //                string sLine = "";

        //                MailMessage mess = new MailMessage();

        //                // 결재자 메일 주소 가져오기
        //                mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";

        //                sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&ID=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&LINKURL=" + sParamUrl;

        //                mess.To = sMailTo.ToString();

        //                mess.Subject = "[" + sTitle + "]";

        //                try
        //                {
        //                    sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
        //                    sLine += "<HTML>";
        //                    sLine += "<HEAD>";
        //                    sLine += "<TITLE> New Document </TITLE>";
        //                    sLine += "<style type='text/css'>";
        //                    sLine += "<!-- /* Global Css */ ";
        //                    sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
        //                    sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
        //                    sLine += "img{border:none} --> </style> ";
        //                    sLine += "<script language='javascript'>";
        //                    sLine += " function AppPageLink() { ";
        //                    sLine += "    document.frm.submit(); ";
        //                    sLine += "  }";
        //                    sLine += "</script>";
        //                    sLine += "</HEAD>";
        //                    sLine += "<BODY>";
        //                    sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
        //                    sLine += "    <tbody> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 안전작업허가서 </th> ";
        //                    sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
        //                    sLine += "                  <a onclick = window.open('" + sUrl + "','문서보기','width=920,height=1000')> ";
        //                    sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
        //                    sLine += "            </td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 허가번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sRONUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
        //                    if (ht["P_SMAREATEXT1"].ToString() == "")
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMWORKTITLE"].ToString() + "</td> ";
        //                    }
        //                    else
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMAREATEXT1"].ToString() + "</td> ";
        //                    }
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
        //                    sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
        //                    sLine += "            </th> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "    </tbody> ";
        //                    sLine += "</table> ";
        //                    sLine += "</form>";
        //                    sLine += "</BODY>";
        //                    sLine += "</HTML> ";

        //                    mess.Body = sLine;
        //                    mess.BodyFormat = MailFormat.Html;

        //                    SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

        //                    // 메일 발송
        //                    SmtpMail.Send(mess);
        //                }
        //                catch
        //                {
        //                    return;
        //                }
        //            }
        //        }
        //    }
        //}
        //#endregion

        //#region Description : 운영팀 메일 발송
        //private void UP_Operater_Mail_Send(Hashtable ht)
        //{
        //    /************************************************************************************************
        //     * 1. 주요작업일 경우 요청자 결재시 안전환경팀 전원에게 메일 발송 함.                           *
        //     * 3. 안전감독자 결재후 작업요청서의 요청결재라인, 수신결재라인,                                *
        //     *    안전작업허가서 요청자, 승인자, 안전환경팀 전원에게 메일 발송 함(중복사번은 한건으로 처리) *
        //     ************************************************************************************************/

        //    string sTitle = string.Empty;

        //    string sMailFrom = string.Empty;
        //    string sMailTo = string.Empty;
        //    string sParamUrl = string.Empty;

        //    string sUrl = string.Empty;

        //    string sWOWORKTITLE = string.Empty;

        //    string sKBSABUN = string.Empty;
        //    string sGUBUN = string.Empty;

        //    int i = 0;
        //    int iSite = 0;


        //    /************************************************************************************************
        //     * 1. 주요작업일 경우 요청자 결재시 안전환경팀 전원에게 메일 발송 함.                           *
        //     * 3. 안전감독자 결재후 작업요청서의 요청결재라인, 수신결재라인,                                *
        //     *    안전작업허가서 요청자, 승인자, 안전환경팀 전원에게 메일 발송 함(중복사번은 한건으로 처리) *
        //     ************************************************************************************************/

        //    DataSet ds = new DataSet();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sWOWORKTITLE = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
        //        }
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        // 요청번호
        //        string sAPNUM = string.Empty;
        //        sAPNUM = ht["P_SMWKTEAM"].ToString() + "-" + Get_Date(ht["P_SMWKDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKSEQ"].ToString());

        //        // 허가번호
        //        string sRONUM = string.Empty;
        //        sRONUM = Get_Date(ht["P_SMWKORAPPDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKORSEQ"].ToString());

        //        sParamUrl = "/Portal/PSM/PSM40/PSM4041.aspx?";
        //        sParamUrl = sParamUrl + "GUBUN=UPT";
        //        sParamUrl = sParamUrl + "^APP_NUM=";
        //        sParamUrl = sParamUrl + sAPNUM;
        //        sParamUrl = sParamUrl + "^OR_NUM=";
        //        sParamUrl = sParamUrl + sRONUM;
        //        sParamUrl = sParamUrl + "^GUBUN=G";

        //        int iCOUNT = 0;

        //        if (ht["P_SMCOSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 3;
        //        }
        //        else if (ht["P_SMGRSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 2;
        //        }
        //        else if (ht["P_SMORSABUN"].ToString() != "")
        //        {
        //            iCOUNT = 1;
        //        }

        //        if (int.Parse(Set_Fill3(ht["P_hdnApprovalSite"].ToString())) == iCOUNT)
        //        {
        //            sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 완료";
        //        }
        //        else
        //        {
        //            sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 제출";
        //        }


        //        // 메일 주소 가져오기
        //        dbCon.AddParameters("P_KBSABUN", DbType.String, ht["P_SMOPSABUN"].ToString());
        //        dbCon.AddParameters("P_LOGINID", DbType.String, "");

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_BUSEO_EQUAL_CHECK");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                string sLine = "";

        //                MailMessage mess = new MailMessage();

        //                // 결재자 메일 주소 가져오기
        //                mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";

        //                sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&ID=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&LINKURL=" + sParamUrl;

        //                sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";

        //                mess.To = sMailTo.ToString();

        //                mess.Subject = "[" + sTitle + "]";

        //                try
        //                {
        //                    sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
        //                    sLine += "<HTML>";
        //                    sLine += "<HEAD>";
        //                    sLine += "<TITLE> New Document </TITLE>";
        //                    sLine += "<style type='text/css'>";
        //                    sLine += "<!-- /* Global Css */ ";
        //                    sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
        //                    sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
        //                    sLine += "img{border:none} --> </style> ";
        //                    sLine += "<script language='javascript'>";
        //                    sLine += " function AppPageLink() { ";
        //                    sLine += "    document.frm.submit(); ";
        //                    sLine += "  }";
        //                    sLine += "</script>";
        //                    sLine += "</HEAD>";
        //                    sLine += "<BODY>";
        //                    sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
        //                    sLine += "    <tbody> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 안전작업허가서 </th> ";
        //                    sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
        //                    sLine += "                  <a onclick = window.open('" + sUrl + "','문서보기','width=920,height=1000')> ";
        //                    sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
        //                    sLine += "            </td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 허가번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sRONUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
        //                    if (ht["P_SMAREATEXT1"].ToString() == "")
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMWORKTITLE"].ToString() + "</td> ";
        //                    }
        //                    else
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMAREATEXT1"].ToString() + "</td> ";
        //                    }
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
        //                    sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
        //                    sLine += "            </th> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "    </tbody> ";
        //                    sLine += "</table> ";
        //                    sLine += "</form>";
        //                    sLine += "</BODY>";
        //                    sLine += "</HTML> ";

        //                    mess.Body = sLine;
        //                    mess.BodyFormat = MailFormat.Html;

        //                    SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

        //                    // 메일 발송
        //                    SmtpMail.Send(mess);
        //                }
        //                catch
        //                {
        //                    return;
        //                }
        //            }
        //        }
        //    }
        //}
        //#endregion

        //#region Description : 참조자 메일 발송
        //private void UP_Mail_Reference_Send(Hashtable ht)
        //{
        //    /************************************************************************************************
        //     * 1. 주요작업일 경우 요청자 결재시 안전환경팀 전원에게 메일 발송 함.                           *
        //     * 3. 안전감독자 결재후 작업요청서의 요청결재라인, 수신결재라인,                                *
        //     *    안전작업허가서 요청자, 승인자, 안전환경팀 전원에게 메일 발송 함(중복사번은 한건으로 처리) *
        //     ************************************************************************************************/

        //    string sTitle = string.Empty;

        //    string sMailFrom = string.Empty;
        //    string sMailTo = string.Empty;
        //    string sParamUrl = string.Empty;

        //    string sUrl = string.Empty;

        //    string sWOWORKTITLE = string.Empty;

        //    string sKBSABUN = string.Empty;
        //    string sGUBUN = string.Empty;

        //    string sREDOCID = string.Empty;
        //    string sREDOCNUM = string.Empty;

        //    int i = 0;


        //    sREDOCID = "05";
        //    sREDOCNUM = ht["P_SMWKTEAM"].ToString() + Get_Date(ht["P_SMWKDATE"].ToString()) + Set_Fill3(ht["P_SMWKSEQ"].ToString()) + Get_Date(ht["P_SMWKORAPPDATE"].ToString()) + Set_Fill3(ht["P_SMWKORSEQ"].ToString());


        //    /************************************************************************************************
        //     * 1. 주요작업일 경우 요청자 결재시 안전환경팀 전원에게 메일 발송 함.                           *
        //     * 3. 안전감독자 결재후 작업요청서의 요청결재라인, 수신결재라인,                                *
        //     *    안전작업허가서 요청자, 승인자, 안전환경팀 전원에게 메일 발송 함(중복사번은 한건으로 처리) *
        //     ************************************************************************************************/

        //    DataSet ds = new DataSet();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_SMWKTEAM"]);
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_SMWKDATE"].ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SMWKSEQ"].ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sWOWORKTITLE = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
        //        }
        //    }

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        // 요청번호
        //        string sAPNUM = string.Empty;
        //        sAPNUM = ht["P_SMWKTEAM"].ToString() + "-" + Get_Date(ht["P_SMWKDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKSEQ"].ToString());

        //        // 허가번호
        //        string sRONUM = string.Empty;
        //        sRONUM = Get_Date(ht["P_SMWKORAPPDATE"].ToString()) + "-" + Set_Fill3(ht["P_SMWKORSEQ"].ToString());

        //        sParamUrl = "/Portal/PSM/PSM40/PSM4041.aspx?";
        //        sParamUrl = sParamUrl + "GUBUN=UPT";
        //        sParamUrl = sParamUrl + "^APP_NUM=";
        //        sParamUrl = sParamUrl + sAPNUM;
        //        sParamUrl = sParamUrl + "^OR_NUM=";
        //        sParamUrl = sParamUrl + sRONUM;
        //        sParamUrl = sParamUrl + "^GUBUN=G";

        //        // 참조자
        //        dbCon.AddParameters("P_REDOCID", DbType.String, sREDOCID);
        //        dbCon.AddParameters("P_REDOCNUM", DbType.String, sREDOCNUM);

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_REFERENCE_LIST");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                sKBSABUN = ds.Tables[0].Rows[i]["RESABUN"].ToString();
        //            }
        //        }

        //        // 참조자 메일 주소 가져오기
        //        dbCon.AddParameters("P_KBSABUN", DbType.String, sKBSABUN.ToString());

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");


        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                string sLine = "";

        //                MailMessage mess = new MailMessage();

        //                // 결재자 메일 주소 가져오기
        //                mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";

        //                sUrl = "http://psm.taeyoung.co.kr/Portal/SitePostUrl.aspx?url=http://psm.taeyoung.co.kr/Portal/PortalLogin.aspx&ACTION=APPPAGE&SABUN=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&ID=" + ds.Tables[0].Rows[i]["KBSABUN"].ToString() + "&LINKURL=" + sParamUrl;

        //                sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";

        //                mess.To = sMailTo.ToString();

        //                sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 완료";
        //                mess.Subject = "[" + sTitle + "]";

        //                try
        //                {
        //                    sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
        //                    sLine += "<HTML>";
        //                    sLine += "<HEAD>";
        //                    sLine += "<TITLE> New Document </TITLE>";
        //                    sLine += "<style type='text/css'>";
        //                    sLine += "<!-- /* Global Css */ ";
        //                    sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
        //                    sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
        //                    sLine += "img{border:none} --> </style> ";
        //                    sLine += "<script language='javascript'>";
        //                    sLine += " function AppPageLink() { ";
        //                    sLine += "    document.frm.submit(); ";
        //                    sLine += "  }";
        //                    sLine += "</script>";
        //                    sLine += "</HEAD>";
        //                    sLine += "<BODY>";
        //                    sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
        //                    sLine += "    <tbody> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 안전작업허가서 </th> ";
        //                    sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
        //                    sLine += "                  <a onclick = window.open('" + sUrl + "','문서보기','width=920,height=1000')> ";
        //                    sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
        //                    sLine += "            </td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 허가번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sRONUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
        //                    if (ht["P_SMAREATEXT1"].ToString() == "")
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMWORKTITLE"].ToString() + "</td> ";
        //                    }
        //                    else
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + ht["P_SMAREATEXT1"].ToString() + "</td> ";
        //                    }
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
        //                    sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
        //                    sLine += "            </th> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "    </tbody> ";
        //                    sLine += "</table> ";
        //                    sLine += "</form>";
        //                    sLine += "</BODY>";
        //                    sLine += "</HTML> ";

        //                    mess.Body = sLine;
        //                    mess.BodyFormat = MailFormat.Html;

        //                    SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

        //                    // 메일 발송
        //                    SmtpMail.Send(mess);
        //                }
        //                catch
        //                {
        //                    return;
        //                }
        //            }
        //        }
        //    }
        //}
        //#endregion




        //#region Description : 작업요청 요청자 및 참조자포함 완료메일 발송
        //private void UP_Mail_WK_Send(string sWOORTEAM, string sWOORDATE, string sWOSEQ,
        //                             string sSMWORKTITLE, string sSMAREATEXT1, string sSMFSWKTEXT)
        //{
        //    string sTitle = string.Empty;

        //    string sMailTo = string.Empty;

        //    string sKBSABUN = string.Empty;

        //    string sWOWORKTITLE = string.Empty;

        //    string sREDOCID = string.Empty;
        //    string sREDOCNUM = string.Empty;

        //    int i = 0;



        //    sREDOCID = "01";
        //    sREDOCNUM = sWOORTEAM.ToString() + Get_Date(sWOORDATE.ToString()) + Set_Fill3(sWOSEQ.ToString());
        //    DataSet ds = new DataSet();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        // 작업요청서 - 요청 및 수신결재사번
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, sWOORTEAM.ToString());
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(sWOORDATE.ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(sWOSEQ.ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sWOWORKTITLE = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
        //        }

        //        // 작업요청서 - 요청 및 수신결재사번
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, sWOORTEAM.ToString());
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(sWOORDATE.ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(sWOSEQ.ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                if (i == 0)
        //                {
        //                    sKBSABUN = ds.Tables[0].Rows[i]["SABUN"].ToString();
        //                }
        //                else
        //                {
        //                    sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["SABUN"].ToString();
        //                }
        //            }

        //            // 작업요청서 - 참조자
        //            dbCon.AddParameters("P_REDOCID", DbType.String, sREDOCID);
        //            dbCon.AddParameters("P_REDOCNUM", DbType.String, sREDOCNUM);

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_REFERENCE_LIST");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //                {
        //                    if (sKBSABUN.ToString() != "")
        //                    {
        //                        sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["RESABUN"].ToString();
        //                    }
        //                }
        //            }

        //            // 요청번호
        //            string sAPNUM = string.Empty;
        //            sAPNUM = sWOORTEAM.ToString() + "-" + Get_Date(sWOORDATE.ToString()) + "-" + Set_Fill3(sWOSEQ.ToString());

        //            // 요청결재자 메일 주소 가져오기
        //            dbCon.AddParameters("P_KBSABUN", DbType.String, sKBSABUN.ToString());

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //                {
        //                    if (i == 0)
        //                    {
        //                        sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                    }
        //                    else
        //                    {
        //                        sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                    }
        //                }

        //                string sLine = "";

        //                MailMessage mess = new MailMessage();

        //                // 결재자 메일 주소 가져오기
        //                mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";
        //                mess.To = sMailTo.ToString();

        //                sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 공사완료";

        //                mess.Subject = "[" + sTitle + "]";

        //                try
        //                {


        //                    sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
        //                    sLine += "<HTML>";
        //                    sLine += "<HEAD>";
        //                    sLine += "<TITLE> New Document </TITLE>";
        //                    sLine += "<style type='text/css'>";
        //                    sLine += "<!-- /* Global Css */ ";
        //                    sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
        //                    sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
        //                    sLine += "img{border:none} --> </style> ";
        //                    sLine += "<script language='javascript'>";
        //                    sLine += " function AppPageLink() { ";
        //                    sLine += "    document.frm.submit(); ";
        //                    sLine += "  }";
        //                    sLine += "</script>";
        //                    sLine += "</HEAD>";
        //                    sLine += "<BODY>";
        //                    sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
        //                    sLine += "    <tbody> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 안전작업허가서 </th> ";
        //                    sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
        //                    sLine += "                  <a onclick = window.open('','문서보기','width=920,height=1000')> ";
        //                    sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
        //                    sLine += "            </td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 작업내용 </th> ";
        //                    if (sSMAREATEXT1.ToString() == "")
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sSMWORKTITLE.ToString() + "</td> ";
        //                    }
        //                    else
        //                    {
        //                        sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sSMAREATEXT1.ToString() + "</td> ";
        //                    }
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 완료의견 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sSMFSWKTEXT.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 3 style = 'font-family:맑은 고딕,Verdana,sans-serif;background:#e6e6dc;padding:10px; text-align:center;'> TAEYOUNG GROUPWARE ";
        //                    sLine += "                <a target = _blank herf = 'gw.taeyoung.co.kr' style = 'font-family:맑은 고딕,Verdana,sans-serif;font-size:12px;color:#005dc8;'> gw.taeyoung.co.kr </a> ";
        //                    sLine += "            </th> ";
        //                    sLine += "        </tr> ";
        //                    sLine += "    </tbody> ";
        //                    sLine += "</table> ";
        //                    sLine += "</form>";
        //                    sLine += "</BODY>";
        //                    sLine += "</HTML> ";

        //                    mess.Body = sLine;
        //                    mess.BodyFormat = MailFormat.Html;

        //                    SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

        //                    // 메일 발송
        //                    SmtpMail.Send(mess);
        //                }
        //                catch
        //                {
        //                    return;
        //                }
        //            }
        //        }
        //    }
        //}
        //#endregion

        //#region Description : 작업요청 요청자 및 참조자포함 완료메일 발송
        //private void UP_Mail_CANCEL_Send(string sSMWKTEAM, string sSMWKDATE, string sSMWKSEQ,
        //                                 string sSMWKORAPPDATE, string sSMWKORSEQ, string sSWWKCODE2,
        //                                 string sSWWKCODE3, string sSWWKCODE4, string sSWWKCODE5,
        //                                 string sSWWKCODE7, string sSWWKCODE8, string sSWWKCODE9,
        //                                 string sSWWKCODE10, string sSMORSABUN, string sSMGRSABUN,
        //                                 string sSMCOSABUN, string sSMCNSABUNNM, string sSMCNREASON)
        //{
        //    string sTitle = string.Empty;

        //    string sMailTo = string.Empty;

        //    string sKBSABUN = string.Empty;

        //    string sWOWORKTITLE = string.Empty;


        //    int i = 0;



        //    DataSet ds = new DataSet();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        // 작업요청서 - 요청 및 수신결재사번
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, sSMWKTEAM.ToString());
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(sSMWKDATE.ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(sSMWKSEQ.ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4011_WORKORDER_RUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            sWOWORKTITLE = ds.Tables[0].Rows[0]["WOWORKTITLE"].ToString();
        //        }

        //        // 요청자
        //        sKBSABUN = sSMORSABUN.ToString();

        //        // 허가자
        //        sKBSABUN = sKBSABUN + "," + sSMGRSABUN.ToString();

        //        // 안전감독자
        //        sKBSABUN = sKBSABUN + "," + sSMCOSABUN.ToString();

        //        // 작업요청서 - 요청 및 수신결재사번
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, sSMWKTEAM.ToString());
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(sSMWKDATE.ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(sSMWKSEQ.ToString()));

        //        ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_WORKORDER_GET_APPROVAL_SABUN");

        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //            {
        //                sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["SABUN"].ToString();
        //            }

        //            // 위험작업일 경우 안전 환경팀 메일 발송
        //            if (sSWWKCODE2.ToString() == "Y" || sSWWKCODE3.ToString() == "Y" || sSWWKCODE4.ToString() == "Y" ||
        //                sSWWKCODE5.ToString() == "Y" || sSWWKCODE7.ToString() == "Y" ||
        //                sSWWKCODE8.ToString() == "Y" || sSWWKCODE9.ToString() == "Y" || sSWWKCODE10.ToString() == "Y")
        //            {
        //                // 안전환경팀 가져오기
        //                dbCon.AddParameters("P_GRPID", DbType.String, "SAFE_MAG");

        //                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_GRPID_LIST");

        //                if (ds.Tables[0].Rows.Count > 0)
        //                {
        //                    for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //                    {
        //                        sKBSABUN = sKBSABUN + "," + ds.Tables[0].Rows[i]["KBSABUN"].ToString();
        //                    }
        //                }
        //            }

        //            // 요청번호
        //            string sAPNUM = string.Empty;
        //            sAPNUM = sSMWKTEAM.ToString() + "-" + Get_Date(sSMWKDATE.ToString()) + "-" + Set_Fill3(sSMWKSEQ.ToString());

        //            // 허가번호
        //            string sRONUM = string.Empty;
        //            sRONUM = Get_Date(sSMWKORAPPDATE.ToString()) + "-" + Set_Fill3(sSMWKORSEQ.ToString());

        //            // 요청결재자 메일 주소 가져오기
        //            dbCon.AddParameters("P_KBSABUN", DbType.String, sKBSABUN.ToString());

        //            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_GET_MAILID_LIST");

        //            if (ds.Tables[0].Rows.Count > 0)
        //            {
        //                for (i = 0; i < ds.Tables[0].Rows.Count; i++)
        //                {
        //                    if (i == 0)
        //                    {
        //                        sMailTo = ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                    }
        //                    else
        //                    {
        //                        sMailTo += "," + ds.Tables[0].Rows[i]["KBMAILID"].ToString() + "@taeyoung.co.kr";
        //                    }
        //                }

        //                string sLine = "";

        //                MailMessage mess = new MailMessage();

        //                // 결재자 메일 주소 가져오기
        //                mess.From = Document.UserInfo.LoginID + "@taeyoung.co.kr";
        //                mess.To = sMailTo.ToString();

        //                sTitle = sWOWORKTITLE.ToString() + " - 안전작업허가서 취소건";

        //                mess.Subject = "[" + sTitle + "]";

        //                try
        //                {


        //                    sLine += "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' > ";
        //                    sLine += "<HTML>";
        //                    sLine += "<HEAD>";
        //                    sLine += "<TITLE> New Document </TITLE>";
        //                    sLine += "<style type='text/css'>";
        //                    sLine += "<!-- /* Global Css */ ";
        //                    sLine += "body {background-color:#ffffff;margin:0 10px 0 10px;}";
        //                    sLine += "body,td,input,textarea,select{color:#333333;font-family:굴림,Gulim,sans-serif;font-size:12px}";
        //                    sLine += "img{border:none} --> </style> ";
        //                    sLine += "<script language='javascript'>";
        //                    sLine += " function AppPageLink() { ";
        //                    sLine += "    document.frm.submit(); ";
        //                    sLine += "  }";
        //                    sLine += "</script>";
        //                    sLine += "</HEAD>";
        //                    sLine += "<BODY>";
        //                    sLine += "<table border = 0 cellspacing = 0 cellpadding = 0 style = 'width:800px;border:5px solid #C8C8C8;font-family:inherit; font-size:15px;'> ";
        //                    sLine += "    <tbody> ";
        //                    sLine += "        <tr> ";
        //                    sLine += "            <th colspan = 2 style = 'font-family:맑은 고딕,Verdana,sans-serif;height:50px;font-weight:bold;background:#ab2457; font-size:18px;color:#FFFFFF;text-align:center; vertical-align:middle;'> 안전작업허가서 </th> ";
        //                    sLine += "            <td style = 'width:100px;border-bottom:1px solid #EAEAEA;background:#ab2457;'> ";
        //                    sLine += "                  <a onclick = window.open('','문서보기','width=920,height=1000')> ";
        //                    sLine += "                  <img src = 'http://psm.taeyoung.co.kr/Resources/Framework/doc_display.png' alt = '문서보기' )=></a> ";
        //                    sLine += "            </td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 요청번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sAPNUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 허가번호 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sRONUM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 취 소 자 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sSMCNSABUNNM.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";

        //                    sLine += "        <tr> ";
        //                    sLine += "            <th style = 'font-family:맑은 고딕,Verdana,sans-serif;width:120px;padding:10px 10px 10px 30px;;border-bottom:1px solid #EAEAEA;text-align:left; background:#DEDEEF;'> 취소사유 </th> ";
        //                    sLine += "            <td style = 'font-family:맑은 고딕,Verdana,sans-serif;padding:10px;border-bottom:1px solid #EAEAEA;'> " + sSMCNREASON.ToString() + "</td> ";
        //                    sLine += "            <td style = 'width:80px;border-bottom:1px solid #EAEAEA;'> &nbsp;</td> ";
        //                    sLine += "        </tr> ";


        //                    sLine += "    </tbody> ";
        //                    sLine += "</table> ";
        //                    sLine += "</form>";
        //                    sLine += "</BODY>";
        //                    sLine += "</HTML> ";

        //                    mess.Body = sLine;
        //                    mess.BodyFormat = MailFormat.Html;

        //                    SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

        //                    // 메일 발송
        //                    SmtpMail.Send(mess);
        //                }
        //                catch
        //                {
        //                    return;
        //                }
        //            }
        //        }
        //    }
        //}
        //#endregion





        //#region Description : 작업내용 가져오기
        //public DataSet UP_GET_WKCODE(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SWWKTEAM", DbType.String, ht["P_SWWKTEAM"]);
        //        dbCon.AddParameters("P_SWWKDATE", DbType.String, Get_Date(ht["P_SWWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SWWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SWWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SWORAPPDATE", DbType.String, Get_Date(ht["P_SWORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SWORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SWORSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_WKCODE_LIST");
        //    }
        //}
        //#endregion

        //#region Description : 조치요구사항 가져오기
        //public DataSet UP_GET_SACODE(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_SSWKTEAM", DbType.String, ht["P_SSWKTEAM"]);
        //        dbCon.AddParameters("P_SSWKDATE", DbType.String, Get_Date(ht["P_SSWKDATE"].ToString()));
        //        dbCon.AddParameters("P_SSWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SSWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_SSORAPPDATE", DbType.String, Get_Date(ht["P_SSORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_SSORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_SSORSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_SACODE_LIST1");
        //    }
        //}
        //#endregion




        //#region Description : 굴착 조치요구사항 가져오기
        //public DataSet UP_GET_DRCODE(Hashtable ht)
        //{
        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_DRWKTEAM", DbType.String, ht["P_DRWKTEAM"]);
        //        dbCon.AddParameters("P_DRWKDATE", DbType.String, Get_Date(ht["P_DRWKDATE"].ToString()));
        //        dbCon.AddParameters("P_DRWKSEQ", DbType.VarNumeric, Set_Fill3(ht["P_DRWKSEQ"].ToString()));
        //        dbCon.AddParameters("P_DRORAPPDATE", DbType.String, Get_Date(ht["P_DRORAPPDATE"].ToString()));
        //        dbCon.AddParameters("P_DRORSEQ", DbType.VarNumeric, Set_Fill3(ht["P_DRORSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_SAFEORDER_DRCODE_LIST");
        //    }
        //}
        //#endregion

        //#region Description : 가스 점검 체크
        //public DataSet UP_GAS_CHECK(Hashtable ht)
        //{
        //    //System.Diagnostics.Debugger.Break();

        //    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
        //    {
        //        dbCon.AddParameters("P_WOORTEAM", DbType.String, ht["P_WOORTEAM"]);
        //        dbCon.AddParameters("P_WOORDATE", DbType.String, Get_Date(ht["P_WOORDATE"].ToString()));
        //        dbCon.AddParameters("P_WOSEQ", DbType.VarNumeric, Set_Fill3(ht["P_WOSEQ"].ToString()));

        //        return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4041_WORKORDER_RUN");
        //    }
        //}
        //#endregion




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

        protected string Get_Date(string sStr)
        {
            if (sStr == "") return "";
            else return sStr.Replace("-", "");
        }
    }
}