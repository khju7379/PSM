using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;
using System.IO;
using System.Web.Mail;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace TaeYoung.Biz.SMS
{
    public class SMSBiz : BizBase
    {

        #region 사번 조회
        /// <summary>
        /// 사번 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_KBSABUN_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);              
                
                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_KBSABUN_LIST");
            }
        }
        #endregion   

        #region 문자발송이력 조회
        /// <summary>
        /// 문자발송이력 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSManagerLog_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["P_SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["P_EDATE"]);
                dbCon.AddParameters("P_TEAM", DbType.String, ht["P_TEAM"]);
                dbCon.AddParameters("P_SABUN", DbType.String, ht["P_SABUN"]);
                dbCon.AddParameters("P_SMSGUBN", DbType.String, ht["P_SMSGUBN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManagerLog_LIST");
            }
        }
        #endregion

        #region 문자발송이력 상세 조회
        /// <summary>
        /// 문자발송이력 상세 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSManagerLogDetail_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LODDATE", DbType.String, ht["LODDATE"]);
                dbCon.AddParameters("P_LODSEQ", DbType.String, ht["LODSEQ"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManagerLogDetail_LIST");
            }
        }
        #endregion

        #region 그룹주소록 트리 조회
        /// <summary>
        /// 그룹주소록 트리 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_ADMASTA_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_ADMASTA_LIST");
            }
        }
        #endregion

        #region 주소록 상세 조회
        /// <summary>
        /// 주소록 상세 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSManager_ADMASTA_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_ADDGROUP", DbType.String, ht["ADDGROUP"]);
                dbCon.AddParameters("P_ADDSABUN", DbType.String, ht["ADDSABUN"]);
                dbCon.AddParameters("P_ADDNAME", DbType.String, ht["ADDNAME"]);


                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManager_ADMASTA_LIST");
            }
        }
        #endregion

        #region 주소록 그룹 등록 
        /// <summary>
        /// 주소록 그룹 등록
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_ADMASTA_ADD(Hashtable ht, Hashtable[] hts)
        {           

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {

                    for (int i = 0; i < hts.Length; i++)
                    {
                        dbCon.AddParameters("P_ADMGROUP", DbType.String, hts[i]["ADMGROUP"]);
                        dbCon.AddParameters("P_ADMGRNAME", DbType.String, hts[i]["ADMGRNAME"]);
                        dbCon.AddParameters("P_ADMHISAB", DbType.String, Document.UserInfo.EmpID);                        

                        dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_ADMASTA_ADD");
                    }                   
                }           
        }
        #endregion

        #region 주소록 그룹 삭제
        /// <summary>
        /// 주소록 그룹 삭제
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_ADMASTA_DEL(Hashtable ht, Hashtable[] hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_ADMGROUP", DbType.String, hts[i]["ADMGROUP"]);                    

                    dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_ADMASTA_DEL");
                }
            }
        }
        #endregion

        #region 주소록 연락처 등록
        /// <summary>
        /// 주소록 연락처 등록
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_ADDETAIL_ADD(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                    dbCon.AddParameters("P_ADDGROUP", DbType.String, ht["ADDGROUP"]);
                    dbCon.AddParameters("P_ADDSABUN", DbType.String, ht["ADDSABUN"]);
                    dbCon.AddParameters("P_ADDTEL", DbType.String, ht["ADDTEL"]);
                    dbCon.AddParameters("P_ADMHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_ADDETAIL_ADD");

            }
        }
        #endregion

        #region 주소록 연락처 확인
        /// <summary>
        /// 주소록 연락처 확인
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSManager_ADDETAIL_RUN(Hashtable ht)
        {
           
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ADDGROUP", DbType.String, ht["ADDGROUP"]);
                dbCon.AddParameters("P_ADDSABUN", DbType.String, ht["ADDSABUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManager_ADDETAIL_RUN");                
            }
        }
        #endregion

        #region 주소록 연락처 삭제
        /// <summary>
        /// 주소록 연락처 삭제
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_ADDETAIL_DEL(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_ADDGROUP", DbType.String, ht["ADDGROUP"]);
                dbCon.AddParameters("P_ADDSABUN", DbType.String, ht["ADDSABUN"]);

                dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_ADDETAIL_DEL");

            }
        }
        #endregion

        #region 주소록 연락처 그룹 조회
        /// <summary>
        /// 주소록 연락처 그룹 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSManager_ADDETAIL_LIST(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ADDGROUP", DbType.String, ht["ADDGROUP"]);
                
                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManager_ADDETAIL_LIST");
            }
        }
        #endregion

        #region 조직도 트리 조회
        /// <summary>
        /// 조직도 트리 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_OrgTree_LIST(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SAUPBCODE1", DbType.String, ht["SAUPBCODE1"]);
                dbCon.AddParameters("P_SAUPBCODE2", DbType.String, ht["SAUPBCODE2"]);
                dbCon.AddParameters("P_DEPTCODE1", DbType.String, ht["DEPTCODE1"]);
                dbCon.AddParameters("P_DEPTCODE2", DbType.String, ht["DEPTCODE2"]);
                dbCon.AddParameters("P_SAUPBCODE3", DbType.String, ht["SAUPBCODE3"]);
                dbCon.AddParameters("P_SAUPBCODE4", DbType.String, ht["SAUPBCODE4"]);
                dbCon.AddParameters("P_DEPTCODE3", DbType.String, ht["DEPTCODE3"]);
                dbCon.AddParameters("P_DEPTCODE4", DbType.String, ht["DEPTCODE4"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_OrgTree_LIST");
            }
        }
        #endregion

        #region 그룹별 조직도 트리 조회
        /// <summary>
        /// 조직도 트리 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_OrgTree_GROUP(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_OrgTree_GROUP");
            }
        }
        #endregion

        #region 주소록 연락처 등록
        /// <summary>
        /// 주소록 연락처 등록
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_ADDETAIL_ArrayADD(Hashtable ht, Hashtable[] hts)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {                
                for (int i = 0; i < hts.Length; i++)
                {                   
                    dbCon.AddParameters("P_ADDGROUP", DbType.String, hts[i]["ADDGROUP"]);
                    dbCon.AddParameters("P_ADDSABUN", DbType.String, hts[i]["ADDSABUN"]);
                    dbCon.AddParameters("P_ADMHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_ADDETAIL_GRADD");
                }
            }
        }
        #endregion

        #region 주소록 연락처 삭제
        /// <summary>
        /// 주소록 연락처 삭제
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_ADDETAIL_ArrayDEL(Hashtable ht, Hashtable[] hts)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_ADDGROUP", DbType.String, hts[i]["ADDGROUP"]);
                    dbCon.AddParameters("P_ADDSABUN", DbType.String, hts[i]["ADDSABUN"]);

                    dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_ADDETAIL_DEL");
                }

            }
        }
        #endregion

        #region 조직도 트리(비상통보용) 조회
        /// <summary>
        /// 조직도 트리(비상통보용) 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_OrgTreeEmergency_LIST(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SAUPBCODE1", DbType.String, ht["SAUPBCODE1"]);
                dbCon.AddParameters("P_SAUPBCODE2", DbType.String, ht["SAUPBCODE2"]);
                dbCon.AddParameters("P_DEPTCODE1", DbType.String, ht["DEPTCODE1"]);
                dbCon.AddParameters("P_DEPTCODE2", DbType.String, ht["DEPTCODE2"]);
                dbCon.AddParameters("P_SAUPBCODE3", DbType.String, ht["SAUPBCODE3"]);
                dbCon.AddParameters("P_SAUPBCODE4", DbType.String, ht["SAUPBCODE4"]);
                dbCon.AddParameters("P_DEPTCODE3", DbType.String, ht["DEPTCODE3"]);
                dbCon.AddParameters("P_DEPTCODE4", DbType.String, ht["DEPTCODE4"]);
                dbCon.AddParameters("P_ADDGROUP", DbType.String, ht["ADDGROUP"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_OrgTreeEmergency_LIST");
            }
        }
        #endregion


        #region 문자 발송 
        /// <summary>
        /// 문자 발송
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SendMessage(Hashtable ht, Hashtable[] hts)
        {
            string sClient_id = "taeyoungutt";      // 서비스아이디
            string sClient_Pwd = "utt10449";        // 서비스Password
            string sSendMessAge = "";       // 문자내용
            string sSender = string.Empty;          // 회신번호
            string sSendSb = string.Empty;          // 회신사번
            string sSendTeam = string.Empty;        // 회신부서
            string Receiver = string.Empty;         // 수신번호
            string sRtnmsg = string.Empty;          // 리턴 메세지
            string sGUBN = string.Empty;            // 발송위치

            string sLongUrl = string.Empty;         // 수신확인 원본url
            string sShortUrl = string.Empty;        // 수신확인 변환url
            string sSEQ = string.Empty;        // 문자이력 마스타 순번

            int iSmsSendTotal = 0;

            DataSet ds = new DataSet();

            DataTable dt = new DataTable();
            dt.Columns.Add("CODE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));
            dt.TableName = "TableNames";
            DataRow row;

            sSendTeam = "";

            try
            {
                sSender = "0522283300";
                sSendSb = "";

                sGUBN = "1";

                string sNowDATE = String.Format("{0:yyyy-MM-dd}", DateTime.Now);
                string sNowTIME = String.Format("{0:HH:mm:ss}", DateTime.Now);

                //순번 가져오기
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_LOMDATE", DbType.String, sNowDATE);

                    DataSet dsq = dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManager_LOGMASTA_SEQ");
                    sSEQ = dsq.Tables[0].Rows[0]["SEQ"].ToString();
                }                

                ezSMSComponent.SMS oEzSMS = new ezSMSComponent.SMS();

                ezSMSComponent.Receivers objReceivers;

                objReceivers = oEzSMS.CreateReceivers();

                ezSMSComponent.ISendResults objSendResults;

                string sNowTime = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString() + ":" + DateTime.Now.Second.ToString();

                string sSendDate = String.Format("{0:yyyy-MM-dd}", DateTime.Now) + " " + sNowTime;

                oEzSMS.ServiceCode = "020099675886D64240D7A73F1B9521AC18B5"; //  taeyoungutt : utt10449

                oEzSMS.Login("smspia.com", 4545, sClient_id, sClient_Pwd);

                int iCall = oEzSMS.LoginInfo.FreeCall;  // 문자전송가능건수 조회                              

                if (iCall >= hts.Length)                
                {
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        for (int i = 0; i < hts.Length; i++)
                        {
                            if (i == 0)
                            {
                                dbCon.AddParameters("P_LOMDATE", DbType.String, sNowDATE);
                                dbCon.AddParameters("P_LOMSEQ", DbType.String, sSEQ);
                                dbCon.AddParameters("P_LOMLOCAT", DbType.String, sGUBN);
                                dbCon.AddParameters("P_LOMTEAM", DbType.String, "");
                                dbCon.AddParameters("P_LOMSENDTEL", DbType.String, sSender);
                                dbCon.AddParameters("P_LOMSABUN", DbType.String, sSendSb);
                                dbCon.AddParameters("P_LOMTIME", DbType.String, sNowTIME);
                                dbCon.AddParameters("P_LOMCONTENT", DbType.String, hts[i]["LOMCONTENT"]);
                                dbCon.AddParameters("P_LOMSMSGUBN", DbType.String, "2");
                                dbCon.AddParameters("P_LOMHISAB", DbType.String, Document.UserInfo.EmpID);

                                dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_LOGMASTA_ADD");

                                sSendMessAge = hts[i]["LOMCONTENT"].ToString(); //발송문자내용
                            }

                            objReceivers.AddDirect(UP_GET_Mobile_Phone(hts[i]["LODRECSAB"].ToString()), sSendMessAge + "\n수신확인:" + ShortenURL("http://ecs.taeyoung.co.kr/check/check?val=" + System.Web.HttpUtility.UrlEncode(ShortUrl.DesEncrypt(sNowDATE + "_" + sSEQ + "_" + hts[i]["LODRECSAB"].ToString()))), 0, Convert.ToDateTime(sSendDate));

                            iSmsSendTotal += 1;
                        }
                    }

                    objSendResults = oEzSMS.SendSMS(sSender, objReceivers);

                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        for (int i = 0; i < hts.Length; i++)
                        {
                            dbCon.AddParameters("P_LODDATE", DbType.String, sNowDATE);
                            dbCon.AddParameters("P_LODSEQ", DbType.String, sSEQ);
                            dbCon.AddParameters("P_LODRECTEL", DbType.String, UP_GET_Mobile_Phone(hts[i]["LODRECSAB"].ToString()));
                            dbCon.AddParameters("P_LODRECSAB", DbType.String, hts[i]["LODRECSAB"]);
                            dbCon.AddParameters("P_LODRECDAT", DbType.String, "");
                            dbCon.AddParameters("P_LODRECTIM", DbType.String, "");
                            dbCon.AddParameters("P_LODTIME", DbType.String, String.Format("{0:HH:mm:ss}", DateTime.Now));
                            dbCon.AddParameters("P_LODSMSCODE", DbType.String, "");
                            dbCon.AddParameters("P_LODSMSMESSAGE", DbType.String, "");
                            dbCon.AddParameters("P_LODHISAB", DbType.String, Document.UserInfo.EmpID);

                            dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_LOGDETAIL_ADD");
                        }
                    }
                }
                else
                {
                    row = dt.NewRow();
                    row["CODE"] = "ER";
                    row["MSG"] = "문자전송가능 건수가 부족합니다!";
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);                    
                }
            }
            catch(Exception ex)
            {
                row = dt.NewRow();
                row["CODE"] = "ER";
                row["MSG"] = "문자 발송중 오류발생!";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
                
            }
            finally
            {
                row = dt.NewRow();
                row["CODE"] = "OK";
                row["MSG"] = iSmsSendTotal.ToString() + " 건이 전송되었습니다";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region 휴대폰 번호 가져오기
        /// <summary>
        /// 휴대폰 번호 가져오기
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public string UP_GET_Mobile_Phone(string sKBSABUN)
        {
            string sRetrunPhone = string.Empty;

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_ADDGROUP", DbType.String, "1");
                dbCon.AddParameters("P_ADDSABUN", DbType.String, sKBSABUN);

                DataSet ds = dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManager_ADDETAIL_RUN");

                if( ds.Tables[0].Rows.Count > 0)
                {
                    sRetrunPhone = ds.Tables[0].Rows[0]["ADDTEL"].ToString().Replace("-", "");
                }
            }

            return sRetrunPhone;
        }
        #endregion

        #region Description : Url Shortener
        public string ShortenURL(string longurl)
        {
            string rtnUrl = string.Empty;
            string shoturl = string.Empty;

            rtnUrl = Check_Url(longurl);
            if (rtnUrl == "")
            {

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    DataSet ds = dbCon.ExcuteDataSet("TYJINFWLIB.SMS_TSHORTURLF_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string sSEQ = ds.Tables[0].Rows[0]["SEQ"].ToString();

                        shoturl = ShortUrl.Shrink(100000000 + Convert.ToInt32(sSEQ));
                        rtnUrl = "http://utt.kr/" + shoturl;

                        Save_Url(sSEQ, longurl, rtnUrl);
                    }
                }              

            }
            return rtnUrl;
        }
        #endregion

        #region Description : url 존재유무
        private string Check_Url(string URL)
        {
            string rtnValue = string.Empty;           

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_WSEQ",     DbType.String, "");
                dbCon.AddParameters("P_WLONGURL", DbType.String, URL);

                DataSet ds = dbCon.ExcuteDataSet("TYJINFWLIB.SMS_TSHORTURLF_CHECK");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    rtnValue = ds.Tables[0].Rows[0]["WSHORTURL"].ToString();
                }
            }

            return rtnValue;
        }
        #endregion

        #region Description : url 저장
        private void Save_Url(string Seq, string LongUrl, string ShortUrl)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                    dbCon.AddParameters("P_WSEQ", DbType.String, Seq);
                    dbCon.AddParameters("P_WLONGURL", DbType.String, LongUrl);
                    dbCon.AddParameters("P_WSHORTURL", DbType.String, ShortUrl);

                    dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_TSHORTURLF_ADD");
            }
        }
        #endregion

        #region Description : 문자전송가능건수 조회
        public DataSet UP_Get_SMSCount(Hashtable ht)
        {

            DataSet ds = new DataSet();

            DataTable dt = new DataTable();
            dt.Columns.Add("MSG", typeof(System.String));
            dt.TableName = "TableNames";
            DataRow row;

            string sReturnValue = string.Empty;

            ezSMSComponent.SMS oEzSMS = new ezSMSComponent.SMS();

            oEzSMS.ServiceCode = "020099675886D64240D7A73F1B9521AC18B5"; //  taeyoungutt : utt10449

            oEzSMS.Login("smspia.com", 4545, "taeyoungutt", "utt10449");

            int iCall = oEzSMS.LoginInfo.FreeCall;  // 문자전송가능건수 조회

            sReturnValue = iCall.ToString();

            row = dt.NewRow();
            row["MSG"] = sReturnValue;
            dt.Rows.Add(row);

            ds.Tables.Add(dt);

            return ds;
        }
        #endregion


        #region 문자서식 조회
        /// <summary>
        /// 문자서식 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSManager_FORM_LIST(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SMSGUBN", DbType.String, ht["SMSGUBN"]);
                dbCon.AddParameters("P_SMSSEQ", DbType.String, ht["SMSSEQ"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManager_FORM_LIST");
            }
        }
        #endregion


        #region 문자양식코드 조회
        /// <summary>
        /// 문자양식코드 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSMANAGER_FORMCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSMANAGER_FORMCODE_LIST");
            }
        }
        #endregion


        #region 문자서식 확인
        /// <summary>
        /// 문자서식 확인
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_SMSManager_FORM_RUN(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SMSGUBN", DbType.String, ht["SMSGUBN"]);
                dbCon.AddParameters("P_SMSSEQ", DbType.String, ht["SMSSEQ"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_SMSManager_FORM_RUN");
            }
        }
        #endregion

        #region 문자양식  등록
        /// <summary>
        /// 문자양식  등록
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_FORM_ADD(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_SMSGUBN", DbType.String, ht["SMSGUBN"]);
                dbCon.AddParameters("P_SMSSEQ", DbType.String, ht["SMSSEQ"]);
                dbCon.AddParameters("P_SMSCONTENT", DbType.String, Convert.ToString(ht["SMSCONTENT"]).Replace("\r\n", "<br />").Replace("\n", "<br />"));
                dbCon.AddParameters("P_SMSETC", DbType.String, ht["SMSETC"]);
                dbCon.AddParameters("P_SMSHISAB", DbType.String, Document.UserInfo.EmpID);

                

                dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_FORM_ADD");

            }
        }
        #endregion

        #region 문자양식  삭제
        /// <summary>
        /// 문자양식  삭제
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void UP_SMS_SMSManager_FORM_DEL(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_SMSGUBN", DbType.String, ht["SMSGUBN"]);
                dbCon.AddParameters("P_SMSSEQ", DbType.String, ht["SMSSEQ"]);

                dbCon.ExcuteNonQuery("TYJINFWLIB.SMS_SMSManager_FORM_DEL");

            }
        }
        #endregion

       

    }
}
