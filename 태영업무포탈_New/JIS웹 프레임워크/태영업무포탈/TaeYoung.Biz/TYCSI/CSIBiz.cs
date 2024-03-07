using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;
using System.Web.Mail;

namespace TaeYoung.Biz.CSI
{
    public class CSIBiz : BizBase
    {
        // 출고지시 변수
        private string fsJIYYMM;
        private string fsJISEQ;
        private string fsJIIPHANG;
        private string fsJIBONSUN;
        private string fsJIHWAJU;
        private string fsJIHWAMUL;
        private string fsJIBLNO;
        private string fsJIMSNSEQ;
        private string fsJIHSNSEQ;
        private string fsJICUSTIL;
        private string fsJIJANGB;
        private string fsJICHASU;
        private string fsJICHHJ;
        private string fsJITANKNO;
        private string fsJIIPTANK;
        private string fsJIIPQTY;
        private string fsJIJEQTY;
        private string fsJIJANQTY;
        private string fsJICARNO1;
        private string fsJICARNO2;
        private string fsJICHJANG;
        private string fsJIORDNAME;
        private string fsJIHISAB;
        private string fsJICHTYPE;
        private string fsJIUNIT;
        private string fsJINAME;
        private string fsJIPHONE;
        private string fsSMSchk;
        private string fsJIJGHWAJU;
        private string fsJIYSHWAJU;
        private string fsJIHWAMULNM;
        private string fsJICHHJNM;
        private string fsCJJEQTY;
        private string fsJIYDHWAJU;
        private string fsJIYSDATE;
        private string fsJIYDSEQ;
        private string fsJIYSSEQ;
        private string fsJISTMTQTY;
        private string fsJIEDMTQTY;
        private string fsJISTLTQTY;
        private string fsJIEDLTQTY;
        private string fsJICONTNUM;
        private string fsJITMGUBN;
        private string fsJIWKTYPE;
        private string fsJITIMEHH;
        private string fsJITIMEMM;
        private string fsJIDNST;
        private string fsJISEND;
        private string fsJIJGHWAJUNM;
        private string fsJIACTHJ;
        private string fsJITMGUBNNM;
        private string fsCSBANGB;
        private string fsCJJGHWAJU;
        private string fsCARCNT;
        private string fsJISEQLIST;

        // 입고지시 변수
        private string fsIOIPDATE;
        private string fsIOTKNO;
        private string fsIOHWAJU;
        private string fsIOHWAJUNM;
        private string fsIOHWAMUL;
        private string fsIOHWAMULNM;
        private string fsIOTANKNO;
        private string fsIOIPQTY;
        private string fsIOWKTYPE;
        private string fsIOCARNO;
        private string fsIOCONTAIN;
        private string fsIOSEALNUM;
        private string fsIOTMGUBN;
        private string fsIOTMGUBNNM;
        private string fsIOIPTIME1;
        private string fsIOIPTIME2;
        private string fsIODESC;
        private string fsIOHISAB;
        private string fsIOCARCNT;
        private string fsIOTKNOLIST;

        // 공통
        private string fsJob;
        private string fsVNCODE;
        private string fsSTATE;
        private string fsMSG;

        public DataSet UP_GET_CSB0001_JEGO_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                //dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]); 
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 100000);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_HWAMUL", DbType.String, ht["HWAMUL"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0001_JEGO_LIST");
            }
        }

        public DataSet UP_GET_CSB0002_CHTANK_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                //dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 100000);
                dbCon.AddParameters("P_IPHANG", DbType.String, ht["IPHANG"]);
                dbCon.AddParameters("P_BONSUN", DbType.String, ht["BONSUN"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_HWAMUL", DbType.String, ht["HWAMUL"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0002_CHTANK_LIST");
            }
        }

        public DataSet UP_GET_CSB0003_IPTANK_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                //dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 100000);
                dbCon.AddParameters("P_IPHANG", DbType.String, ht["IPHANG"]);
                dbCon.AddParameters("P_BONSUN", DbType.String, ht["BONSUN"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_HWAMUL", DbType.String, ht["HWAMUL"]);
                dbCon.AddParameters("P_JITANKNO", DbType.String, ht["JITANKNO"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0003_IPTANK_LIST");
            }
        }

        #region Description : 입고지시 입고탱크 조회
        public DataSet UP_GET_CSB0004_CUTANKNO_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0004_CUTANKNO_LIST");
            }
        }
        #endregion

        #region Description : 신규 도착지 등록
        public DataSet UP_CSB0005_SAVE(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds1 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            int iResult = 0;

            string sCDCODE = string.Empty;
            string sCHECK = string.Empty;
            string sMSG = string.Empty;

            dt.Columns.Add("CDCODE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0005_UTICODEF");
            }

            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    for (int j = 0; j <= 9; j++)
                    {
                        for (int k = 0; k <= 9; k++)
                        {
                            sCDCODE = "";

                            sCDCODE = ds.Tables[0].Rows[i]["CDCODE"].ToString() + Convert.ToString(j) + Convert.ToString(k);

                            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                            {
                                dbCon.AddParameters("P_CDCODE", DbType.String, sCDCODE);

                                ds1 = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0005_UTICODEF_CONF");
                            }

                            if (ds1.Tables[0].Rows.Count <= 0)
                            {
                                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                                {
                                    dbCon.AddParameters("P_CDCODE", DbType.String, sCDCODE);
                                    dbCon.AddParameters("P_CDDESC1", DbType.String, ht["CDDESC1"]);
                                    dbCon.AddParameters("RET_MSG", DbType.String, "");

                                    iResult = dbCon.ExcuteNonQuery("TYJINFWLIB.SP_TYCSI_CSB0005_UTICODEF_UPDATE");


                                    if (iResult == -1)
                                    {
                                        UP_DCMail_SEND(ht["HWAJUNM"].ToString(),
                                                       ht["VNCODE"].ToString(),
                                                       sCDCODE,
                                                       ht["CDDESC1"].ToString());
                                        sMSG = "등록 되었습니다.";
                                    }
                                    else
                                    {
                                        sMSG = "등록 중 오류가 발생하였습니다.";
                                    }
                                    ds = new DataSet();
                                    row = dt.NewRow();
                                    row["CDCODE"] = sCDCODE;
                                    row["MSG"] = sMSG;
                                    dt.Rows.Add(row);
                                    ds.Tables.Add(dt);
                                }
                                return ds;
                            }
                        }
                    }
                }
            }

            return ds;
        }
        #endregion

        #region Description : 도착지등록 메일 발송
        private void UP_DCMail_SEND(string sHWAJUNM, string sVNCODE, string sCDCODE, string sCDDESC1)
        {

            try
            {
                string sFirst = string.Empty;
                string sLine = string.Empty;
                string sMailAddress = string.Empty;

                MailMessage mail = new MailMessage();

                sMailAddress = "";

                sMailAddress = "dkpark@taeyoung.co.kr, jskim@taeyoung.co.kr, shpark@taeyoung.co.kr, dhkim@taeyoung.co.kr";

                mail.From = "khim@taeyoung.co.kr";

                mail.To = sMailAddress;

                mail.Subject = sHWAJUNM + "로부터 신규 도착지 등록 확인메일이 도착하였습니다.";

                sFirst = "-//W3C//DTD XHTML 1.0 Transitional//EN ";

                string sHWAJU = string.Empty;
                string sCARNO = string.Empty;
                string sTRUNSONG = string.Empty;
                string sTRHYUNGT = string.Empty;
                string sTRUNNAME = string.Empty;
                string sTRGITEL = string.Empty;
                string sTRJUNGRY = string.Empty;

                sHWAJU = sVNCODE + " - " + sHWAJUNM;

                sLine = "";
                sLine = sLine + " <!DOCTYPE HTML PUBLIC '" + sFirst + "'>    ";
                sLine = sLine + " <html>                                     ";
                sLine = sLine + "    <head>                                  ";
                sLine = sLine + "       <title> 출고 요청 화면 </title>      ";
                sLine = sLine + "    </head>                                 ";
                sLine = sLine + "    <body>                                  ";
                sLine = sLine + "      <table width = 500px height = 150px border = 1 cellpadding = 0 cellspacing = 0 > ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td align = 'Left'>구   분      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>내   용      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>도착지코드   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sCDCODE + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>도 착 지 명  ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sCDDESC1 + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";

                sLine = sLine + "      </table>                              ";
                sLine = sLine + "    </body>                                 ";
                sLine = sLine + " </html>                                    ";


                mail.Body = sLine;

                mail.BodyFormat = MailFormat.Html;

                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                SmtpMail.Send(mail);
            }
            catch (Exception ex)
            {
                string a = string.Empty;

                a = ex.Message;
            }


        }
        #endregion

        #region Description : 신규 차량 등록
        public DataSet UP_CSB0006_SAVE(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataSet ds1 = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            int iResult = 0;

            string sMSG = string.Empty;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            // 데이터 존재여부 체크
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_TRNUMNO1", DbType.String, ht["TRNUMNO1"]);
                dbCon.AddParameters("P_TRNUMNO2", DbType.String, ht["TRNUMNO2"]);

                ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0006_UTATRUKF_SELECT");
            }

            if (ds.Tables[0].Rows.Count > 0)
            {   
                ds = new DataSet();
                row = dt.NewRow();
                row["STATE"] = "CHECK";
                row["MSG"] = "이미 등록된 차량번호입니다.";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }
            else
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_TRNUMNO1", DbType.String, ht["TRNUMNO1"]);
                    dbCon.AddParameters("P_TRNUMNO2", DbType.String, ht["TRNUMNO2"]);
                    dbCon.AddParameters("P_TRUNSONG", DbType.String, ht["TRUNSONG"]);
                    dbCon.AddParameters("P_TRHYUNGT", DbType.String, ht["TRHYUNGT"]);
                    dbCon.AddParameters("P_TRUNNAME", DbType.String, ht["TRUNNAME"]);
                    dbCon.AddParameters("P_TRGITEL", DbType.String, ht["TRGITEL"]);
                    dbCon.AddParameters("P_TRJUNGRY", DbType.String, ht["TRJUNGRY"]);
                    dbCon.AddParameters("RET_MSG", DbType.String, "");

                    iResult = dbCon.ExcuteNonQuery("TYJINFWLIB.SP_TYCSI_CSB0006_UTATRUKF_INSERT");

                    if (iResult == -1)
                    {
                        UP_TRMail_SEND(ht["HWAJUNM"].ToString(),
                                       ht["VNCODE"].ToString(), 
                                       ht["TRNUMNO1"].ToString(),
                                       ht["TRNUMNO2"].ToString(),
                                       ht["TRUNSONG"].ToString(),
                                       ht["TRUNSONGNM"].ToString(),
                                       ht["TRHYUNGT"].ToString(),
                                       ht["TRHYUNGTNM"].ToString(),
                                       ht["TRUNNAME"].ToString(),
                                       ht["TRGITEL"].ToString(),
                                       ht["TRJUNGRY"].ToString());
                        
                        ds = new DataSet();
                        row = dt.NewRow();
                        row["STATE"] = "OK";
                        row["MSG"] = "등록 되었습니다.";
                        dt.Rows.Add(row);
                        ds.Tables.Add(dt);
                    }
                    else
                    {   
                        ds = new DataSet();
                        row = dt.NewRow();
                        row["STATE"] = "";
                        row["MSG"] = "등록 중 오류가 발생하였습니다.";
                        dt.Rows.Add(row);
                        ds.Tables.Add(dt);
                    }
                    
                }
            }

            return ds;
        }
        #endregion

        #region Description : 차량등록 메일 발송
        private void UP_TRMail_SEND(string sHWAJUNM, string sVNCODE, string sTRMUMNO1, string sTRMUMNO2,
                                    string sTRUNSONG, string sTRUNSONGNM, string sTRHYUNGT, string sTRHYUNGTNM,
                                    string sTRUNNAME, string sTRGITEL, string sTRJUNGRY)
        {

            try
            {
                string sFirst = string.Empty;
                string sLine = string.Empty;
                string sMailAddress = string.Empty;

                MailMessage mail = new MailMessage();

                sMailAddress = "";

                sMailAddress = "dkpark@taeyoung.co.kr, jskim@taeyoung.co.kr, shpark@taeyoung.co.kr, dhkim@taeyoung.co.kr";

                mail.From = "khim@taeyoung.co.kr";

                mail.To = sMailAddress;

                mail.Subject = sHWAJUNM + "로부터 신규차량등록 확인메일이 도착하였습니다.";

                sFirst = "-//W3C//DTD XHTML 1.0 Transitional//EN ";

                sLine = "";
                sLine = sLine + " <!DOCTYPE HTML PUBLIC '" + sFirst + "'>    ";
                sLine = sLine + " <html>                                     ";
                sLine = sLine + "    <head>                                  ";
                sLine = sLine + "       <title> 출고 요청 화면 </title>      ";
                sLine = sLine + "    </head>                                 ";
                sLine = sLine + "    <body>                                  ";
                sLine = sLine + "      <table width = 500px height = 150px border = 1 cellpadding = 0 cellspacing = 0 > ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td align = 'Left'>구   분      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>내   용      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>차량등록일자 ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + System.DateTime.Now.ToString("yyyy-MM-dd") + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>화   주   명 ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sVNCODE + " - " + sHWAJUNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>차량 번호    ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sTRMUMNO1 + sTRMUMNO2 + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>차량 소속    ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sTRUNSONG + " - " + sTRUNSONGNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>차량 구분    ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sTRHYUNGT + " - " + sTRHYUNGTNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>기사 성명    ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sTRUNNAME + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>기사전화번호 ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + sTRGITEL + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>적재중량(MT)     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Right'>" + sTRJUNGRY + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";

                sLine = sLine + "      </table>                              ";
                sLine = sLine + "    </body>                                 ";
                sLine = sLine + " </html>                                    ";


                mail.Body = sLine;

                mail.BodyFormat = MailFormat.Html;

                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                SmtpMail.Send(mail);
            }
            catch (Exception ex)
            {
                string a = string.Empty;

                a = ex.Message;
            }


        }
        #endregion

        #region Description : 입고화물별 입고조회
        public DataSet UP_CSI1010_LIST(Hashtable ht)
        {
            ht["SearchCondition"] = " AND   IPGO.IPIPHANG BETWEEN " + ht["SDATE"] + " AND " + ht["EDATE"] + " ";
            ht["SearchCondition"] = ht["SearchCondition"] + " AND IPGO.IPHWAJU  IN(SELECT * FROM TABLE(TYSCMLIB.SF_GB_RevColRow(CAST('" + ht["IPHWAJU"] + "' AS VARCHAR(100)), ',')) AS InTable ) ";

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1010_LIST");
            }
        }
        #endregion

        #region Description : 입고화물별 출고조회
        public DataSet UP_CSI1020_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1020_LIST");
            }
        }
        
        public DataSet UP_CSI1020_LIST2(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, "");
                dbCon.AddParameters("P_LOGINID", DbType.String, "");

                return dbCon.ExcuteDataSet("TYJINFWLIB.TYCSI_CHULF_LIST_2");
            }
        }
        #endregion

        #region Description : 입고화물별 재고조회
        public DataSet UP_CSI1030_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_DATE", DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1030_LIST ");
            }
        }
        #endregion

        #region Description : 통관화물별 통관조회
        public DataSet UP_CSI1040_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1040_LIST");
            }
        }
        #endregion

        #region Description : 통관화물별 출고조회
        public DataSet UP_CSI1050_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1050_LIST");
            }
        }
        #endregion

        #region Description : 통관화물별 재고조회
        public DataSet UP_CSI1060_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_DATE", DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1060_LIST ");
            }
        }
        #endregion

        #region Description : 통관화물별 DRUM 출고조회
        public DataSet UP_CSI1070_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1070_LIST ");
            }
        }
        #endregion

        #region Description : 통관화물별 DRUM 재고조회
        public DataSet UP_CSI1080_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1080_LIST ");
            }
        }
        #endregion

        #region Description : 모선 B/L별 통관 재고 조회
        public DataSet UP_CSI1090_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_HWAMUL", DbType.String, ht["IPHWAMUL"]);
                dbCon.AddParameters("P_JGCHECK", DbType.String, ht["JGCHECK"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1090_LIST ");
            }
        }
        #endregion

        #region Description : 양수도 조회
        public DataSet UP_CSI1100_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1100_LIST ");
            }
        }
        #endregion

        #region Description : 출고지시 조회
        public DataSet UP_CSI1110_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_HWAMUL", DbType.String, ht["HWAMUL"]);
                dbCon.AddParameters("P_CHHJ", DbType.String, ht["CHHJ"]);
                dbCon.AddParameters("P_CARNO", DbType.String, ht["CARNO"]);
                dbCon.AddParameters("P_TANKNO", DbType.String, ht["TANKNO"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1110_LIST ");
            }
        }
        #endregion

        #region Description : ISO/FLEXI 출고 조회
        public DataSet UP_CSI1120_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_HWAMUL", DbType.String, ht["HWAMUL"]);
                dbCon.AddParameters("P_WKTYPE", DbType.String, ht["WKTYPE"]);
                dbCon.AddParameters("P_CHHJ", DbType.String, ht["CHHJ"]);
                dbCon.AddParameters("P_CHDNST", DbType.String, ht["CHDNST"]);
                dbCon.AddParameters("P_JIGSPINO", DbType.String, ht["JIGSPINO"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI1120_LIST ");
            }
        }
        #endregion

        #region Description : 접안료 매출 조회
        public DataSet UP_CSI2010_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_MCDATE", DbType.String, ht["MCDATE"]);
                dbCon.AddParameters("P_MCHWAJU", DbType.String, ht["MCHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI2010_LIST ");
            }
        }
        #endregion

        #region Description : 하역료 매출 조회
        public DataSet UP_CSI2020_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_MDATE", DbType.String, ht["MDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI2020_LIST ");
            }
        }
        #endregion

        #region Description : 보관취급료 매출 조회
        public DataSet UP_CSI2030_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_MDATE", DbType.String, ht["MDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI2030_LIST ");
            }
        }
        
        public DataSet UP_CSI2031_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_MCDATE", DbType.String, ht["MCDATE"]);
                dbCon.AddParameters("P_MCHWAJU", DbType.String, ht["MCHWAJU"]);
                dbCon.AddParameters("P_MCHWAMUL", DbType.String, ht["MCHWAMUL"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI2031_LIST ");
            }
        }
        #endregion

        #region Description : 출고지시 조회
        public DataSet UP_CSI3010_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_HWAMUL",           DbType.String, ht["HWAMUL"]);
                dbCon.AddParameters("P_CHHJ",             DbType.String, ht["CHHJ"]);
                dbCon.AddParameters("P_CARNO",            DbType.String, ht["CARNO"]);
                dbCon.AddParameters("P_TANKNO",           DbType.String, ht["TANKNO"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3010_LIST ");
            }
        }
        #endregion

        public DataSet UP_CSI3020_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["IPHWAJU"]);
                dbCon.AddParameters("P_HWAMUL",           DbType.String, ht["HWAMUL"]);
                dbCon.AddParameters("P_CARNO",            DbType.String, ht["CARNO"]);
                dbCon.AddParameters("P_TANKNO",           DbType.String, ht["TANKNO"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3020_LIST ");
            }
        }

        public DataSet UP_GET_CARNO_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);


                return dbCon.ExcuteDataSet("TYJINFWLIB.TYCSI_GET_CARNO_LIST");
            }
        }

        public DataSet UP_GET_CODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_INDEX", DbType.String, ht["INDEX"]);


                return dbCon.ExcuteDataSet("TYJINFWLIB.TYCSI_GET_CODE_LIST");
            }
        }

        public DataSet UP_GET_HWAJUCODE(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_USERID", DbType.String, ht["USERID"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_GET_HWAJUCODE");
            }
        }

        public DataSet UP_GET_HWAMUL_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_INDEX", DbType.String, ht["INDEX"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);


                return dbCon.ExcuteDataSet("TYJINFWLIB.TYCSI_GET_HWAMUL_LIST");
            }
        }

        public DataSet UP_GET_CSB0001_HWAMUL_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["IPHWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSB0001_HWAMUL_LIST");
            }
        }

        public DataSet UP_GET_CSI3011_LASTSAB(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_GET_LASTSAB");
            }
        }

        public DataSet UP_GET_CSI3011_UTIORDERF_SELECT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JIYYMM", DbType.Double, ht["JIYYMM"]);
                dbCon.AddParameters("P_JISEQ", DbType.Double, ht["JISEQ"]);
                dbCon.AddParameters("P_JIJGHWAJU", DbType.String, ht["JIJGHWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_UTIORDERF_SELECT");
            }
        }

        public DataSet UP_GET_CSI3021_UTIIPORF_SELECT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_IOIPDATE", DbType.Double, ht["IOIPDATE"]);
                dbCon.AddParameters("P_IOTKNO", DbType.Double, ht["IOTKNO"]);
                dbCon.AddParameters("P_IOHWAJU", DbType.String, ht["IOHWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3021_UTIIPORF_SELECT");
            }
        }

        #region Description : 출고지시등록
        public DataSet UP_CSI3011_SAVE(Hashtable ht)
        {
            DataSet dsWeek = new DataSet();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sWEEKGB = string.Empty;
            double dNOWTIME = 0;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));
            dt.Columns.Add("JISEQ", typeof(System.String));

            fsJob = ht["Job"].ToString();
            fsJIYYMM = ht["JIYYMM"].ToString();
            fsJISEQ = ht["JISEQ"].ToString();
            fsJIIPHANG = ht["JIIPHANG"].ToString();
            fsJIBONSUN = ht["JIBONSUN"].ToString();
            fsJIHWAJU = ht["JIHWAJU"].ToString();
            fsJIHWAMUL = ht["JIHWAMUL"].ToString();
            fsJIBLNO = ht["JIBLNO"].ToString();
            fsJIMSNSEQ = ht["JIMSNSEQ"].ToString();
            fsJIHSNSEQ = ht["JIHSNSEQ"].ToString(); //10
            fsJICUSTIL = ht["JICUSTIL"].ToString();
            fsJIJANGB = ht["JIJANGB"].ToString();
            fsJICHASU = ht["JICHASU"].ToString();
            fsJICHHJ = ht["JICHHJ"].ToString();
            fsJITANKNO = ht["JITANKNO"].ToString();
            if (fsJITANKNO.Length < 4)
            {
                fsJITANKNO = " " + fsJITANKNO;
            }
            fsJIIPTANK = ht["JIIPTANK"].ToString();
            if (fsJIIPTANK.Length < 4)
            {
                fsJIIPTANK = " " + fsJIIPTANK;
            }
            fsJIIPQTY = ht["JIIPQTY"].ToString();
            fsJIJEQTY = ht["JIJEQTY"].ToString();
            fsJIJANQTY = ht["JIJANQTY"].ToString();
            fsJICARNO1 = ht["JICARNO1"].ToString(); //20
            fsJICARNO2 = ht["JICARNO2"].ToString();
            fsJICHJANG = ht["JICHJANG"].ToString();
            fsJIORDNAME = ht["JIORDNAME"].ToString();
            fsJIHISAB = ht["JIHISAB"].ToString();
            fsJICHTYPE = ht["JICHTYPE"].ToString();
            fsJIUNIT = ht["JIUNIT"].ToString();
            fsJINAME = ht["JINAME"].ToString();
            fsJIPHONE = ht["JIPHONE"].ToString();
            fsJISEND = ht["SMSchk"].ToString();
            fsJIJGHWAJU = ht["JIJGHWAJU"].ToString();   //30
            fsJIYSHWAJU = ht["JIYSHWAJU"].ToString();
            fsJIHWAMULNM = ht["JIHWAMULNM"].ToString();
            fsJICHHJNM = ht["JICHHJNM"].ToString();
            fsCJJEQTY = ht["CJJEQTY"].ToString();
            fsJIYDHWAJU = ht["JIYDHWAJU"].ToString();
            fsJIYSDATE = ht["JIYSDATE"].ToString();
            fsJIYDSEQ = ht["JIYDSEQ"].ToString();
            fsJIYSSEQ = ht["JIYSSEQ"].ToString();
            fsJISTMTQTY = ht["JISTMTQTY"].ToString();
            fsJIEDMTQTY = ht["JIEDMTQTY"].ToString();   //40
            fsJISTLTQTY = ht["JISTLTQTY"].ToString();
            fsJIEDLTQTY = ht["JIEDLTQTY"].ToString();
            fsJICONTNUM = ht["JICONTNUM"].ToString();
            fsJITMGUBN = ht["JITMGUBN"].ToString();
            fsJIWKTYPE = ht["JIWKTYPE"].ToString();
            fsJITIMEHH = ht["JITIMEHH"].ToString();
            fsJITIMEMM = ht["JITIMEMM"].ToString();
            fsJIDNST = ht["JIDNST"].ToString();
            fsJIACTHJ = ht["JIACTHJ"].ToString();
            fsJITMGUBNNM = ht["JITMGUBNNM"].ToString(); //50
            fsVNCODE = ht["VNCODE"].ToString();
            fsCARCNT = ht["CARCNT"].ToString();
            fsJIJGHWAJUNM = ht["JIJGHWAJUNM"].ToString();
            fsJISEQLIST = string.Empty;

            for(int i = 1 ; i <= Convert.ToInt32(fsCARCNT) ; i++)
            {
                // 저장 체크
                if (UP_CSI3011_CHECK(i) == true)
                {
                    // 고객사 오더 등록
                    if (UP_UTIORDERF_UPDATE() == true)
                    {
                        if (fsJob == "A")
                        {
                            // 여기부터 테스트
                            // 근태월력 , 현재시간 조회 
                            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                            {
                                dsWeek = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_GET_GTMRREF");

                                if (dsWeek.Tables[0].Rows.Count > 0)
                                {
                                    sWEEKGB = dsWeek.Tables[0].Rows[0]["WEEK"].ToString();
                                    dNOWTIME = Convert.ToDouble(dsWeek.Tables[0].Rows[0]["NOWTIME"]);
                                }
                            }

                            if (sWEEKGB == "2" && (dNOWTIME >= 830 && dNOWTIME < 1730))
                            {
                                // 김종술 차장 요청 일과시간에도 자동등록
                                if (fsJIHISAB == "0310-M")
                                {
                                    if (UP_UTIJISIF_UPDATE() == true)
                                    {
                                        if (i == Convert.ToInt32(fsCARCNT))
                                        {
                                            UP_Mail_SEND();

                                            fsMSG = "저장 되었습니다.";
                                            row = dt.NewRow();
                                            row["STATE"] = "OK";
                                            row["MSG"] = fsMSG;
                                            row["JISEQ"] = fsJISEQ;
                                            dt.Rows.Add(row);
                                            ds.Tables.Add(dt);

                                            return ds;
                                        }
                                    }
                                    else
                                    {
                                        row = dt.NewRow();
                                        row["STATE"] = "";
                                        row["MSG"] = fsMSG;
                                        row["JISEQ"] = "";
                                        dt.Rows.Add(row);
                                        ds.Tables.Add(dt);

                                        return ds;
                                    }
                                }
                                else
                                {
                                    // 평일 08:30 ~ 17:30
                                    // 메일 발송
                                    if (i == Convert.ToInt32(fsCARCNT))
                                    {
                                        UP_Mail_SEND();

                                        fsMSG = "저장 되었습니다.";
                                        row = dt.NewRow();
                                        row["STATE"] = "OK";
                                        row["MSG"] = fsMSG;
                                        row["JISEQ"] = fsJISEQ;
                                        dt.Rows.Add(row);
                                        ds.Tables.Add(dt);

                                        return ds;
                                    }
                                }
                            }
                            else
                            {
                                // 공휴일, 평일 08:30 이전 17:30 이후 
                                // 지시 자동등록
                                // 메일, 문자 발송
                                if (UP_UTIJISIF_UPDATE() == true)
                                {
                                    if (i == Convert.ToInt32(fsCARCNT))
                                    {
                                        if (sWEEKGB == "1")
                                        {
                                            UP_SMS_SEND("WEEKE");
                                        }
                                        else
                                        {
                                            UP_SMS_SEND("");
                                        }
                                        UP_Mail_SEND();

                                        fsMSG = "저장 되었습니다.";
                                        row = dt.NewRow();
                                        row["STATE"] = "OK";
                                        row["MSG"] = fsMSG;
                                        row["JISEQ"] = fsJISEQ;
                                        dt.Rows.Add(row);
                                        ds.Tables.Add(dt);

                                        return ds;
                                    }
                                }
                                else
                                {
                                    row = dt.NewRow();
                                    row["STATE"] = "";
                                    row["MSG"] = fsMSG;
                                    row["JISEQ"] = "";
                                    dt.Rows.Add(row);
                                    ds.Tables.Add(dt);

                                    return ds;
                                }
                            }
                        }
                        else
                        {
                            fsMSG = "저장 되었습니다.";
                            row = dt.NewRow();
                            row["STATE"] = "OK";
                            row["MSG"] = fsMSG;
                            row["JISEQ"] = fsJISEQ;
                            dt.Rows.Add(row);
                            ds.Tables.Add(dt);

                            return ds;
                        }
                    }
                    else
                    {
                        row = dt.NewRow();
                        row["STATE"] = "";
                        row["MSG"] = fsMSG;
                        row["JISEQ"] = "";
                        dt.Rows.Add(row);
                        ds.Tables.Add(dt);

                        return ds;
                    }
                }
                else
                {
                    row = dt.NewRow();
                    row["STATE"] = "";
                    row["MSG"] = fsMSG;
                    row["JISEQ"] = "";
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);

                    return ds;
                }
            }

            return ds;

        }
        #endregion

        #region Description : 출고지시삭제
        public DataSet UP_CSI3011_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));
            dt.Columns.Add("JISEQ", typeof(System.String));

            fsJob = ht["Job"].ToString();
            fsJIYYMM = ht["JIYYMM"].ToString();
            fsJISEQ = ht["JISEQ"].ToString();

            fsJIIPQTY = "0";
            fsJIJEQTY = "0";
            fsJIJANQTY = "0";
            fsJISTMTQTY = "0";
            fsJIEDMTQTY = "0";
            fsJISTLTQTY = "0";
            fsJIEDLTQTY = "0";
            
            // 고객사 오더 삭제
            if (UP_UTIORDERF_UPDATE() == true)
            {
                fsMSG = "삭제 되었습니다.";
                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = fsMSG;
                row["JISEQ"] = fsJISEQ;
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }
            else
            {
                row = dt.NewRow();
                row["STATE"] = "";
                row["MSG"] = fsMSG;
                row["JISEQ"] = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : 유효성 검사
        public bool UP_CSI3011_CHECK(int iCnt)
        {
            string sNowTime = string.Empty;
            string sState = string.Empty;
            string sSql = string.Empty;
            string sGUBUN1 = string.Empty;

            DataSet ds = new DataSet();

            if (fsJob == "A")
            {
                // 지시량 유효성 검사
                double dJIJIQTYSUM = 0;
                double dIPJEQTY = 0;
                double dJIJIQTY = 0;

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JIYYMM", DbType.Double, fsJIYYMM);
                    dbCon.AddParameters("P_JIIPHANG", DbType.Double, fsJIIPHANG);
                    dbCon.AddParameters("P_JIBONSUN", DbType.String, fsJIBONSUN);
                    dbCon.AddParameters("P_JIHWAJU", DbType.String, fsJIHWAJU);
                    dbCon.AddParameters("P_JIHWAMUL", DbType.String, fsJIHWAMUL);
                    dbCon.AddParameters("P_JIBLNO", DbType.String, fsJIBLNO);
                    dbCon.AddParameters("P_JIMSNSEQ", DbType.Double, fsJIMSNSEQ);
                    dbCon.AddParameters("P_JIHSNSEQ", DbType.Double, fsJIHSNSEQ);
                    dbCon.AddParameters("P_JICUSTIL", DbType.Double, fsJICUSTIL);
                    dbCon.AddParameters("P_JICHASU", DbType.String, fsJICHASU);
                    dbCon.AddParameters("P_JIACTHJ", DbType.String, fsJIACTHJ);
                    dbCon.AddParameters("P_JIJGHWAJU", DbType.String, fsJIJGHWAJU);
                    dbCon.AddParameters("P_JIYSHWAJU", DbType.String, fsJIYSHWAJU);
                    dbCon.AddParameters("P_JIYDHWAJU", DbType.String, fsJIYDHWAJU);
                    dbCon.AddParameters("P_JIYSDATE", DbType.Double, fsJIYSDATE);
                    dbCon.AddParameters("P_JIYDSEQ", DbType.Double, fsJIYDSEQ);
                    dbCon.AddParameters("P_JIYSSEQ", DbType.Double, fsJIYSSEQ);

                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_INSERT_CHECK");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        dJIJIQTYSUM = Convert.ToDouble(ds.Tables[0].Rows[0]["JISTMTQTY"]);
                    }
                }

                dIPJEQTY = Convert.ToDouble(Get_Numeric(fsCJJEQTY.Trim()));
                dJIJIQTY = Convert.ToDouble(Get_Numeric(fsJISTMTQTY.Trim()));

                if (iCnt == 1)
                {
                    if (dIPJEQTY - (dJIJIQTY * Convert.ToInt32(fsCARCNT)) - dJIJIQTYSUM < 0)
                    {
                        fsMSG = "재고량이 부족합니다.";
                        return false;
                    }
                }

                if (dIPJEQTY - dJIJIQTY - dJIJIQTYSUM < 0)
                {
                    fsMSG = "재고량이 부족합니다.";
                    return false;
                }

                //JISI에서 통관화주,화물,(입고,출고)탱크번호,도착지,차량번호가 일치하는게 있는지 체크 
                // 동일 차량 등록가능하게 변경됨

                //for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                //{
                //    if (fsJIIPHANG.Trim() == ds.Tables[1].Rows[i]["JIIPHANG"].ToString().ToUpper() &&
                //        fsJIBONSUN.Trim().ToUpper() == ds.Tables[1].Rows[i]["JIBONSUN"].ToString().ToUpper() &&
                //        fsJIHWAJU.Trim().ToUpper() == ds.Tables[1].Rows[i]["JIHWAJU"].ToString().ToUpper() &&
                //        fsJIHWAMUL.Trim().ToUpper() == ds.Tables[1].Rows[i]["JIHWAMUL"].ToString().ToUpper() &&
                //        fsJIBLNO.Trim() == ds.Tables[1].Rows[i]["JIBLNO"].ToString().ToUpper() &&
                //        fsJIMSNSEQ.Trim() == ds.Tables[1].Rows[i]["JIMSNSEQ"].ToString().ToUpper() &&
                //        fsJIHSNSEQ.Trim() == ds.Tables[1].Rows[i]["JIHSNSEQ"].ToString().ToUpper() &&
                //        fsJICUSTIL.Trim() == ds.Tables[1].Rows[i]["JICUSTIL"].ToString().ToUpper() &&
                //        fsJICHASU.Trim() == ds.Tables[1].Rows[i]["JICHASU"].ToString().ToUpper() &&
                //        fsJIJGHWAJU.Trim() == ds.Tables[1].Rows[i]["JIJGHWAJU"].ToString().ToUpper() &&  //없음
                //        fsJIYSHWAJU.Trim() == ds.Tables[1].Rows[i]["JIYSHWAJU"].ToString().ToUpper() &&  //없음
                //        fsJIYDHWAJU.Trim() == ds.Tables[1].Rows[i]["JIYDHWAJU"].ToString().ToUpper() &&  //없음
                //        fsJIYSDATE.Trim() == ds.Tables[1].Rows[i]["JIYSDATE"].ToString().ToUpper() &&  //없음
                //        fsJIYDSEQ.Trim() == ds.Tables[1].Rows[i]["JIYDSEQ"].ToString().ToUpper() &&  //없음
                //        fsJIYSSEQ.Trim() == ds.Tables[1].Rows[i]["JIYSSEQ"].ToString().ToUpper() &&  //없음
                //        fsJIIPTANK.Trim().ToUpper() == ds.Tables[1].Rows[i]["JIIPTANK"].ToString().ToUpper() &&
                //        fsJITANKNO.Trim().ToUpper() == ds.Tables[1].Rows[i]["JITANKNO"].ToString().ToUpper() &&
                //        fsJICHHJ.Trim().ToUpper() == ds.Tables[1].Rows[i]["JICHHJ"].ToString().ToUpper() &&
                //        fsJICARNO2.Trim().ToUpper() == ds.Tables[1].Rows[i]["JICARNO2"].ToString().ToUpper())
                //    {
                //        fsMSG = "동일한 통관재고, 차량에 지시 두번이 불가합니다.";
                //        return false;
                //    }
                //}
            }
            else if (fsJob == "C")
            {
                double dJUNJIJIQTY = 0;
                // 지시량 유효성 검사
                double dJIJIQTYSUM = 0;
                double dIPJEQTY = 0;
                double dJIJIQTY = 0;

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JIYYMM", DbType.Double, fsJIYYMM);
                    dbCon.AddParameters("P_JISEQ", DbType.Double, fsJISEQ);
                    dbCon.AddParameters("P_JIIPHANG", DbType.Double, fsJIIPHANG);
                    dbCon.AddParameters("P_JIBONSUN", DbType.String, fsJIBONSUN);
                    dbCon.AddParameters("P_JIHWAJU", DbType.String, fsJIHWAJU);
                    dbCon.AddParameters("P_JIHWAMUL", DbType.String, fsJIHWAMUL);
                    dbCon.AddParameters("P_JIBLNO", DbType.String, fsJIBLNO);
                    dbCon.AddParameters("P_JIMSNSEQ", DbType.Double, fsJIMSNSEQ);
                    dbCon.AddParameters("P_JIHSNSEQ", DbType.Double, fsJIHSNSEQ);
                    dbCon.AddParameters("P_JICUSTIL", DbType.Double, fsJICUSTIL);
                    dbCon.AddParameters("P_JICHASU", DbType.String, fsJICHASU);
                    dbCon.AddParameters("P_JIACTHJ", DbType.String, fsJIACTHJ);
                    dbCon.AddParameters("P_JIJGHWAJU", DbType.String, fsJIJGHWAJU);
                    dbCon.AddParameters("P_JIYSHWAJU", DbType.String, fsJIYSHWAJU);
                    dbCon.AddParameters("P_JIYDHWAJU", DbType.String, fsJIYDHWAJU);
                    dbCon.AddParameters("P_JIYSDATE", DbType.Double, fsJIYSDATE);
                    dbCon.AddParameters("P_JIYDSEQ", DbType.Double, fsJIYDSEQ);
                    dbCon.AddParameters("P_JIYSSEQ", DbType.Double, fsJIYSSEQ);

                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_UPDATE_CHECK");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        dJUNJIJIQTY = Convert.ToDouble(ds.Tables[0].Rows[0]["JIJANQTY"]);
                    }
                }

                if (ds.Tables[1].Rows.Count > 0)
                {
                    dJIJIQTYSUM = Convert.ToDouble(ds.Tables[1].Rows[0]["JISTMTQTY"]);
                }

                dIPJEQTY = Convert.ToDouble(Get_Numeric(fsCJJEQTY.Trim()));
                dJIJIQTY = Convert.ToDouble(Get_Numeric(fsJISTMTQTY.Trim()));

                if (dIPJEQTY - dJIJIQTY - (dJIJIQTYSUM - dJUNJIJIQTY) < 0)
                {
                    fsMSG = "재고량이 부족합니다.";
                    return false;
                }

                if (ds.Tables[2].Rows.Count > 0)
                {
                    if (fsJIIPHANG.Trim() != ds.Tables[2].Rows[0]["JIIPHANG"].ToString() ||
                        fsJIBONSUN.Trim() != ds.Tables[2].Rows[0]["JIBONSUN"].ToString() ||
                        fsJIHWAJU.Trim() != ds.Tables[2].Rows[0]["JIHWAJU"].ToString() ||
                        fsJIHWAMUL.Trim() != ds.Tables[2].Rows[0]["JIHWAMUL"].ToString() ||
                        fsJIBLNO.Trim() != ds.Tables[2].Rows[0]["JIBLNO"].ToString() ||
                        fsJIMSNSEQ.Trim() != ds.Tables[2].Rows[0]["JIMSNSEQ"].ToString() ||
                        fsJIHSNSEQ.Trim() != ds.Tables[2].Rows[0]["JIHSNSEQ"].ToString() ||
                        fsJICUSTIL.Trim() != ds.Tables[2].Rows[0]["JICUSTIL"].ToString() ||
                        fsJICHASU.Trim() != ds.Tables[2].Rows[0]["JICHASU"].ToString() ||
                        fsJIACTHJ.Trim() != ds.Tables[2].Rows[0]["JIACTHJ"].ToString() ||
                        fsJIYSHWAJU.Trim() != ds.Tables[2].Rows[0]["JIYSHWAJU"].ToString() ||
                        fsJIYDHWAJU.Trim() != ds.Tables[2].Rows[0]["JIYDHWAJU"].ToString() ||
                        fsJIYSDATE.Trim() != ds.Tables[2].Rows[0]["JIYSDATE"].ToString() ||
                        fsJIYDSEQ.Trim() != ds.Tables[2].Rows[0]["JIYDSEQ"].ToString() ||
                        fsJIYSSEQ.Trim() != ds.Tables[2].Rows[0]["JIYSSEQ"].ToString())
                    {
                        fsMSG = "삭제 후 등록을 하십시요.";
                        return false;
                    }
                }
            }
            if (fsJob != "D")
            {
                string sIPPAQTY = string.Empty;
                string sIPCHQTY = string.Empty;
                string sJUNIPMTQTY = string.Empty;

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JIIPHANG", DbType.Double, fsJIIPHANG);
	                dbCon.AddParameters("P_JIBONSUN", DbType.String, fsJIBONSUN);
	                dbCon.AddParameters("P_JIHWAJU", DbType.String, fsJIHWAJU);
                    dbCon.AddParameters("P_JIHWAMUL", DbType.String, fsJIHWAMUL);
	                dbCon.AddParameters("P_JIBLNO", DbType.String, fsJIBLNO);
                    dbCon.AddParameters("P_JIMSNSEQ", DbType.Double, fsJIMSNSEQ);
                    dbCon.AddParameters("P_JIHSNSEQ", DbType.Double, fsJIHSNSEQ);
	                dbCon.AddParameters("P_JICUSTIL", DbType.Double, fsJICUSTIL);
                    dbCon.AddParameters("P_JICHASU", DbType.String, fsJICHASU);
                    dbCon.AddParameters("P_JIACTHJ", DbType.String, fsJIACTHJ);   
	                dbCon.AddParameters("P_JIJGHWAJU", DbType.String, fsJIJGHWAJU);
                    dbCon.AddParameters("P_JIYSHWAJU", DbType.String, fsJIYSHWAJU);
                    dbCon.AddParameters("P_JIYDHWAJU", DbType.String, fsJIYDHWAJU);
                    dbCon.AddParameters("P_JIYSDATE", DbType.Double, fsJIYSDATE);
                    dbCon.AddParameters("P_JIYDSEQ", DbType.Double, fsJIYDSEQ);
                    dbCon.AddParameters("P_JIYSSEQ", DbType.Double, fsJIYSSEQ);
                    dbCon.AddParameters("P_JITANKNO", DbType.String, fsJITANKNO);
                    dbCon.AddParameters("P_JIIPTANK", DbType.String, fsJIIPTANK);
	                dbCon.AddParameters("P_JICARNO2", DbType.String, fsJICARNO2);    

                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_JEGO_CHECK");
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    // 입고수량
                    fsJIIPQTY = String.Format("{0,9:N3}", double.Parse(ds.Tables[0].Rows[0]["IPMTQTY"].ToString())).Trim();
                    // 통관누계
                    sIPPAQTY = String.Format("{0,9:N3}", double.Parse(ds.Tables[0].Rows[0]["IPPAQTY"].ToString())).Trim();
                    // 출고누계
                    sIPCHQTY = String.Format("{0,9:N3}", double.Parse(ds.Tables[0].Rows[0]["IPCHQTY"].ToString())).Trim();
                    // 통관재고
                    fsJIJEQTY = String.Format("{0,9:N3}", double.Parse(ds.Tables[0].Rows[0]["IPJEQTY"].ToString())).Trim();
                    // 미통관재고
                    fsJIJANQTY = String.Format("{0,9:N3}", double.Parse(ds.Tables[0].Rows[0]["IPJANQTY"].ToString())).Trim();
                }

                if (ds.Tables[1].Rows.Count > 0)
                {
                    // B/L분할수량
                    sJUNIPMTQTY = String.Format("{0,9:N3}", double.Parse(ds.Tables[1].Rows[0]["IPMTQTY"].ToString())).Trim();
                }

                // 미통관잔량 = MT입고량 - 통관량 - BL분할 수량	
                fsJIJANQTY = String.Format("{0,9:N3}", double.Parse(fsJIIPQTY) - double.Parse(sIPPAQTY.ToString()) - double.Parse(sJUNIPMTQTY.ToString()));

                if (ds.Tables[2].Rows.Count > 0)
                {
                    if (fsJITANKNO.Trim() != fsJIIPTANK.Trim())
                    {
                        fsMSG = "출고탱크 번호와 입고탱크 번호를 확인하세요.";
                        return false;
                    }
                }

                if (fsJICARNO2.Trim() != "")
                {
                    if (ds.Tables[3].Rows.Count <= 0)
                    {
                        fsMSG = "차량번호를 확인하세요.";
                        return false;
                    }
                }

                // 입고화물 체크
                if (ds.Tables[4].Rows.Count <= 0)
                {
                    fsMSG = "입고 화물이 없습니다.";
                    return false;
                }

                // 입고 체크
                if (ds.Tables[5].Rows.Count <= 0)
                {
                    fsMSG = "입고가 없습니다!";
                    return false;
                }

                // SURVEY파일 체크


                if (ds.Tables[6].Rows.Count <= 0)
                {
                    fsMSG = "SURVEY 화일이 없습니다!";
                    return false;
                }
                else
                {
                    if (double.Parse(Get_Numeric(fsJISTMTQTY.Trim())) > double.Parse(ds.Tables[6].Rows[0]["JEGO"].ToString()))
                    {
                        fsMSG = "출고탱크 재고를 확인하세요!";
                        return false;
                    }
                }

                // 매출입고 할증 체크
                if (ds.Tables[7].Rows.Count <= 0)
                {
                    fsMSG = "매출 입고 할증이 없습니다!";
                    return false;
                }
                else
                {
                    if (double.Parse(Get_Numeric(fsJISTMTQTY.Trim())) > double.Parse(ds.Tables[7].Rows[0]["JEGO"].ToString()))
                    {
                        fsMSG = "입고탱크 재고를 확인하세요!";
                        return false;
                    }
                }

                // 통관화일 체크			
                if (ds.Tables[8].Rows.Count <= 0)
                {
                    fsMSG = "통관화일이 없습니다!";
                    return false;
                }
                else
                {
                    fsCSBANGB = ds.Tables[8].Rows[0]["CSBANGB"].ToString().Trim();
                }

                if (fsCSBANGB == "70" || fsCSBANGB == "71")
                {
                    fsMSG = "반송화물 입니다!";
                    return false;
                }

                // 통관화주 체크
                if (ds.Tables[9].Rows.Count <= 0)
                {
                    fsMSG = "통관화주가 없습니다!";
                    return false;
                }
                else
                {
                    fsCJJGHWAJU = ds.Tables[9].Rows[0]["CJJGHWAJU"].ToString().Trim();
                    // 재고수량
                    fsCJJEQTY = ds.Tables[9].Rows[0]["CJJEQTY"].ToString().Trim();
                }

                if (fsJIJGHWAJU.Trim() != fsCJJGHWAJU)
                {
                    fsMSG = "재고 화주가 틀립니다!";
                    return false;
                }

                if (fsJIYSHWAJU.Trim() != "" && fsJIYDHWAJU.Trim() != "" && fsJIYSDATE.Trim() != "")
                {
                    if (ds.Tables[10].Rows.Count <= 0)
                    {
                        fsMSG = "양수도 파일을 확인하세요!";
                        return false;
                    }
                }
            }
            return true;
        }
        #endregion

        #region Description : 출고지시번호 생성
        private string UP_UTIORCNF_UPDATE()
        {
            string sJISEQ = string.Empty;
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JCYYMM", DbType.Double, fsJIYYMM);

                ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_GET_JISEQ");
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                sJISEQ = ds.Tables[0].Rows[0]["JISEQ"].ToString();
            }

            return sJISEQ;
        }
        #endregion

        #region Description : UTIORDERF UPDATE
        private bool UP_UTIORDERF_UPDATE()
        {
            string[] sOUTMSG = new string[2];
            int iResult = 0;
            bool result = false;

            try
            {
                if (fsJob.ToString() == "A")
                {
                    // 출고 지시 번호 순차 부여
                    fsJISEQ = UP_UTIORCNF_UPDATE();

                    if (fsJISEQ == "")
                    {
                        fsMSG = "지시번호 생성중 오류가 발생하였습니다.";
                        return false;
                    }
                    else
                    {
                        if (fsJISEQLIST == "")
                        {
                            fsJISEQLIST = fsJISEQ;
                        }
                        else
                        {
                            fsJISEQLIST += "," + fsJISEQ;
                        }
                    }
                }

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_GUBN", DbType.String, fsJob);
                    dbCon.AddParameters("P_JIYYMM", DbType.Double, fsJIYYMM);
                    dbCon.AddParameters("P_JISEQ", DbType.Double, fsJISEQ);
                    dbCon.AddParameters("P_JIIPHANG", DbType.Double, fsJIIPHANG);
                    dbCon.AddParameters("P_JIBONSUN", DbType.String, fsJIBONSUN);
                    dbCon.AddParameters("P_JIHWAJU", DbType.String, fsJIHWAJU);
                    dbCon.AddParameters("P_JIHWAMUL", DbType.String, fsJIHWAMUL);
                    dbCon.AddParameters("P_JIBLNO", DbType.String, fsJIBLNO);
                    dbCon.AddParameters("P_JIMSNSEQ", DbType.Double, fsJIMSNSEQ);
                    dbCon.AddParameters("P_JIHSNSEQ", DbType.Double, fsJIHSNSEQ);
                    dbCon.AddParameters("P_JIACTHJ", DbType.String, fsJIACTHJ);
                    dbCon.AddParameters("P_JICUSTIL", DbType.Double, fsJICUSTIL);
                    dbCon.AddParameters("P_JICHASU", DbType.Double, fsJICHASU);
                    dbCon.AddParameters("P_JIJGHWAJU", DbType.String, fsJIJGHWAJU);
                    dbCon.AddParameters("P_JIYSHWAJU", DbType.String, fsJIYSHWAJU);
                    dbCon.AddParameters("P_JIYDHWAJU", DbType.String, fsJIYDHWAJU);
                    dbCon.AddParameters("P_JIYSDATE", DbType.Double, fsJIYSDATE);
                    dbCon.AddParameters("P_JIYDSEQ", DbType.Double, fsJIYDSEQ);
                    dbCon.AddParameters("P_JIYSSEQ", DbType.Double, fsJIYSSEQ);
                    dbCon.AddParameters("P_JICHHJ", DbType.String, fsJICHHJ);
                    dbCon.AddParameters("P_JITANKNO", DbType.String, fsJITANKNO);
                    dbCon.AddParameters("P_JIIPTANK", DbType.String, fsJIIPTANK);
                    dbCon.AddParameters("P_JIIPQTY", DbType.Double, Get_Numeric(fsJIIPQTY));
                    dbCon.AddParameters("P_JIJEQTY", DbType.Double, Get_Numeric(fsJIJEQTY));
                    dbCon.AddParameters("P_JIJANQTY", DbType.Double, Get_Numeric(fsJIJANQTY));
                    dbCon.AddParameters("P_JIJANGB", DbType.String, fsJIJANGB);
                    dbCon.AddParameters("P_JITRGUBN", DbType.String, "");
                    dbCon.AddParameters("P_JITRJISI1", DbType.String, "");
                    dbCon.AddParameters("P_JITRJISI2", DbType.Double, "0");
                    dbCon.AddParameters("P_JICARNO1", DbType.String, fsJICARNO1);
                    dbCon.AddParameters("P_JICARNO2", DbType.String, fsJICARNO2);
                    dbCon.AddParameters("P_JICHJANG", DbType.String, fsJICHJANG);
                    dbCon.AddParameters("P_JICHTYPE", DbType.String, fsJICHTYPE);
                    dbCon.AddParameters("P_JIUNIT", DbType.String, fsJIUNIT);
                    dbCon.AddParameters("P_JIRACK", DbType.String, "");
                    dbCon.AddParameters("P_JIPUMP", DbType.String, "");
                    dbCon.AddParameters("P_JISINO1", DbType.Double, "0");
                    dbCon.AddParameters("P_JISINO2", DbType.Double, "0");
                    dbCon.AddParameters("P_JIORDNAME", DbType.String, fsJIORDNAME);
                    dbCon.AddParameters("P_JINAME", DbType.String, fsJINAME);
                    dbCon.AddParameters("P_JIPHONE", DbType.String, fsJIPHONE);
                    dbCon.AddParameters("P_JISEND", DbType.String, fsJISEND);
                    dbCon.AddParameters("P_JISTMTQTY", DbType.Double, Get_Numeric(fsJISTMTQTY));
                    dbCon.AddParameters("P_JIEDMTQTY", DbType.Double, Get_Numeric(fsJIEDMTQTY));
                    dbCon.AddParameters("P_JISTLTQTY", DbType.Double, Get_Numeric(fsJISTLTQTY));
                    dbCon.AddParameters("P_JIEDLTQTY", DbType.Double, Get_Numeric(fsJIEDLTQTY));
                    dbCon.AddParameters("P_JICONTNUM", DbType.String, fsJICONTNUM);
                    dbCon.AddParameters("P_JISILNUM", DbType.String, "");
                    dbCon.AddParameters("P_JITMGUBN", DbType.String, fsJITMGUBN);
                    dbCon.AddParameters("P_JIWKTYPE", DbType.String, fsJIWKTYPE);
                    dbCon.AddParameters("P_JITIMEHH", DbType.String, fsJITIMEHH);
                    dbCon.AddParameters("P_JITIMEMM", DbType.String, fsJITIMEMM);
                    dbCon.AddParameters("P_JIDNST", DbType.String, fsJIDNST);
                    dbCon.AddParameters("P_JIHISAB", DbType.String, fsJIHISAB);
                    dbCon.AddParameters("RET_MSG", DbType.String, "");
                    iResult = dbCon.ExcuteNonQuery("TYJINFWLIB.SP_TYCSI_CSI3011_UTIORDERF_UPDATE");
                }
                result = iResult == -1 ? true : false;
                fsMSG = iResult == -1 ? "" : "처리중 오류가 발생하였습니다.";
                
                return result;
            }
            catch
            {
                return false;
            }
        }
        #endregion	

        #region Description : UTIJISIF UPDATE
        private bool UP_UTIJISIF_UPDATE()
        {
            string[] sOUTMSG = new string[2];
            int iResult = 0;
            bool result = false;

            try
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {

                    dbCon.AddParameters("P_JIYYMM", DbType.Double, fsJIYYMM);
                    dbCon.AddParameters("P_JISEQ", DbType.Double, fsJISEQ);
                    dbCon.AddParameters("P_JIHISAB", DbType.String, fsJIHISAB);
                    dbCon.AddParameters("RET_MSG", DbType.String, "");

                    iResult = dbCon.ExcuteNonQuery("TYJINFWLIB.SP_TYCSI_CSI3011_UTIJISIF_UPDATE");
                }
                result = iResult == -1 ? true : false;
                fsMSG = iResult == -1 ? "" : "출고지시 등록 중 오류가 발생하였습니다.";

                return result;
            }
            catch
            {
                return false;
            }
        }
        #endregion

        #region Description : 입고지시등록
        public DataSet UP_CSI3021_SAVE(Hashtable ht)
        {
            DataSet dsWeek = new DataSet();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sWEEKGB = string.Empty;
            double dNOWTIME = 0;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));
            dt.Columns.Add("IOTKNO", typeof(System.String));

            fsJob = ht["Job"].ToString();
            fsIOIPDATE = ht["IOIPDATE"].ToString();
            fsIOTKNO = ht["IOTKNO"].ToString();
            fsIOHWAJU = ht["IOHWAJU"].ToString();
            fsIOHWAJUNM = ht["IOHWAJUNM"].ToString();
            fsIOHWAMUL = ht["IOHWAMUL"].ToString();
            fsIOHWAMULNM = ht["IOHWAMULNM"].ToString();
            fsIOTANKNO = ht["IOTANKNO"].ToString();
            if (fsIOTANKNO.Length < 4)
            {
                fsIOTANKNO = " " + fsIOTANKNO;
            }
            fsIOIPQTY = ht["IOIPQTY"].ToString();
            fsIOWKTYPE = ht["IOWKTYPE"].ToString();
            fsIOCARNO = ht["IOCARNO"].ToString();
            fsIOCONTAIN = ht["IOCONTAIN"].ToString();
            fsIOSEALNUM = ht["IOSEALNUM"].ToString();
            fsIOTMGUBN = ht["IOTMGUBN"].ToString();
            fsIOTMGUBNNM = ht["IOTMGUBNNM"].ToString();
            fsIOIPTIME1 = ht["IOIPTIME1"].ToString();
            fsIOIPTIME2 = ht["IOIPTIME2"].ToString();
            fsIODESC = ht["IODESC"].ToString();
            fsIOHISAB = ht["IOHISAB"].ToString();
            fsVNCODE = ht["VNCODE"].ToString();
            fsIOCARCNT = ht["IOCARCNT"].ToString();
            fsIOTKNOLIST = string.Empty;

            for (int i = 1; i <= Convert.ToInt32(fsIOCARCNT); i++)
            {
                // 고객사 오더 등록
                if (UP_UTIIPORF_UPDATE() == true)
                {
                    if (fsJob == "A")
                    {
                        // 여기부터 테스트
                        // 근태월력 , 현재시간 조회 
                        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                        {
                            dsWeek = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3011_GET_GTMRREF");

                            if (dsWeek.Tables[0].Rows.Count > 0)
                            {
                                sWEEKGB = dsWeek.Tables[0].Rows[0]["WEEK"].ToString();
                                dNOWTIME = Convert.ToDouble(dsWeek.Tables[0].Rows[0]["NOWTIME"]);
                            }
                        }

                        if (sWEEKGB == "2" && (dNOWTIME >= 830 && dNOWTIME < 1730))
                        {
                            // 김종술 차장 요청 일과시간에도 자동등록
                            if (fsIOHISAB == "0310-M")
                            {
                                if (UP_UTIPJIF_UPDATE() == true)
                                {
                                    if (i == Convert.ToInt32(fsIOCARCNT))
                                    {
                                        UP_IPMail_SEND();

                                        fsMSG = "저장 되었습니다.";
                                        row = dt.NewRow();
                                        row["STATE"] = "OK";
                                        row["MSG"] = fsMSG;
                                        row["IOTKNO"] = fsIOTKNO;
                                        dt.Rows.Add(row);
                                        ds.Tables.Add(dt);
                                        return ds;
                                    }
                                }
                                else
                                {
                                    row = dt.NewRow();
                                    row["STATE"] = "";
                                    row["MSG"] = fsMSG;
                                    row["IOTKNO"] = "";
                                    dt.Rows.Add(row);
                                    ds.Tables.Add(dt);
                                    return ds;
                                }
                            }
                            else
                            {
                                // 평일 08:30 ~ 17:30
                                // 메일 발송

                                if (i == Convert.ToInt32(fsIOCARCNT))
                                {
                                    UP_IPMail_SEND();

                                    fsMSG = "저장 되었습니다.";
                                    row = dt.NewRow();
                                    row["STATE"] = "OK";
                                    row["MSG"] = fsMSG;
                                    row["IOTKNO"] = fsIOTKNO;
                                    dt.Rows.Add(row);
                                    ds.Tables.Add(dt);
                                    return ds;
                                }
                            }
                        }
                        else
                        {
                            // 공휴일, 평일 08:30 이전 17:30 이후 
                            // 지시 자동등록
                            // 메일, 문자 발송
                            if (UP_UTIPJIF_UPDATE() == true)
                            {
                                if (i == Convert.ToInt32(fsIOCARCNT))
                                {
                                    if (sWEEKGB == "1")
                                    {
                                        UP_IPSMS_SEND("WEEK");
                                    }
                                    else
                                    {
                                        UP_IPSMS_SEND("");
                                    }
                                    UP_IPMail_SEND();

                                    fsMSG = "저장 되었습니다.";
                                    row = dt.NewRow();
                                    row["STATE"] = "OK";
                                    row["MSG"] = fsMSG;
                                    row["IOTKNO"] = fsIOTKNO;
                                    dt.Rows.Add(row);
                                    ds.Tables.Add(dt);
                                    return ds;
                                }
                            }
                            else
                            {
                                row = dt.NewRow();
                                row["STATE"] = "";
                                row["MSG"] = fsMSG;
                                row["IOTKNO"] = "";
                                dt.Rows.Add(row);
                                ds.Tables.Add(dt);
                                return ds;
                            }
                        }
                    }
                    else
                    {
                        fsMSG = "저장 되었습니다.";
                        row = dt.NewRow();
                        row["STATE"] = "OK";
                        row["MSG"] = fsMSG;
                        row["IOTKNO"] = fsIOTKNO;
                        dt.Rows.Add(row);
                        ds.Tables.Add(dt);
                        return ds;
                    }
                }
                else
                {
                    row = dt.NewRow();
                    row["STATE"] = "";
                    row["MSG"] = fsMSG;
                    row["IOTKNO"] = "";
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);
                    return ds;
                }
            }
            return ds;

        }
        #endregion

        #region Description : 입고지시삭제
        public DataSet UP_CSI3021_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));
            dt.Columns.Add("IOTKNO", typeof(System.String));

            fsJob = ht["Job"].ToString();
            fsIOIPDATE = ht["IOIPDATE"].ToString();
            fsIOTKNO = ht["IOTKNO"].ToString();

            fsIOIPQTY = "0";
            fsIOIPTIME1 = "0";
            fsIOIPTIME2 = "0";

            // 고객사 오더 삭제
            if (UP_UTIIPORF_UPDATE() == true)
            {
                fsMSG = "삭제 되었습니다.";
                row = dt.NewRow();
                row["STATE"] = "OK";
                row["MSG"] = fsMSG;
                row["IOTKNO"] = fsIOTKNO;
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }
            else
            {
                row = dt.NewRow();
                row["STATE"] = "";
                row["MSG"] = fsMSG;
                row["IOTKNO"] = "";
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : 입고지시번호 가져오기
        private string UP_GET_IOTKNO()
        {
            string sTKNO = string.Empty;
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_IOIPDATE", DbType.Double, fsIOIPDATE);

                ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3021_GET_IOTKNO");
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                sTKNO = ds.Tables[0].Rows[0]["IOTKNO"].ToString();
            }

            return sTKNO;
        }
        #endregion

        #region Description : UTIIPORF UPDATE
        private bool UP_UTIIPORF_UPDATE()
        {
            string[] sOUTMSG = new string[2];
            int iResult = 0;
            bool result = false;

            try
            {
                if (fsJob.ToString() == "A")
                {
                    // 입고 지시 번호 순차 부여
                    fsIOTKNO = UP_GET_IOTKNO();

                    if (fsIOTKNO == "")
                    {
                        fsMSG = "지시번호 생성중 오류가 발생하였습니다.";
                        return false;
                    }
                    else
                    {
                        if (fsIOTKNOLIST == "")
                        {
                            fsIOTKNOLIST = fsIOTKNO;
                        }
                        else
                        {
                            fsIOTKNOLIST += "," + fsIOTKNO;
                        }
                    }
                }

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_GUBN", DbType.String, fsJob);
                    dbCon.AddParameters("P_IOIPDATE", DbType.Double, fsIOIPDATE);
                    dbCon.AddParameters("P_IOTKNO", DbType.Double, fsIOTKNO);
                    dbCon.AddParameters("P_IOHWAJU", DbType.String, fsIOHWAJU);
                    dbCon.AddParameters("P_IOHWAMUL", DbType.String, fsIOHWAMUL);
                    dbCon.AddParameters("P_IOTANKNO", DbType.String, fsIOTANKNO);
                    dbCon.AddParameters("P_IOIPQTY", DbType.Double, Get_Numeric(fsIOIPQTY));
                    dbCon.AddParameters("P_IOWKTYPE", DbType.String, fsIOWKTYPE);
                    dbCon.AddParameters("P_IOCARNO", DbType.String, fsIOCARNO);
                    dbCon.AddParameters("P_IOCONTAIN", DbType.String, fsIOCONTAIN);
                    dbCon.AddParameters("P_IOSEALNUM", DbType.String, fsIOSEALNUM);
                    dbCon.AddParameters("P_IOTMGUBN", DbType.String, fsIOTMGUBN);
                    dbCon.AddParameters("P_IOIPTIME", DbType.Double, Set_Fill2(fsIOIPTIME1) + Set_Fill2(fsIOIPTIME2));
                    dbCon.AddParameters("P_IODESC", DbType.String, fsIODESC);
                    dbCon.AddParameters("P_IOHISAB", DbType.String, fsIOHISAB);
                    dbCon.AddParameters("RET_MSG", DbType.String, "");
                    iResult = dbCon.ExcuteNonQuery("TYJINFWLIB.SP_TYCSI_CSI3021_UTIIPORF_UPDATE");
                }
                result = iResult == -1 ? true : false;
                fsMSG = iResult == -1 ? "" : "처리중 오류가 발생하였습니다.";

                return result;
            }
            catch
            {
                return false;
            }
        }
        #endregion	

        #region Description : UTIPJIF UPDATE
        private bool UP_UTIPJIF_UPDATE()
        {
            string[] sOUTMSG = new string[2];
            int iResult = 0;
            bool result = false;

            try
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {

                    dbCon.AddParameters("P_IOIPDATE", DbType.Double, fsIOIPDATE);
                    dbCon.AddParameters("P_IOTKNO", DbType.Double, fsIOTKNO);
                    dbCon.AddParameters("P_IOHISAB", DbType.String, fsIOHISAB);
                    dbCon.AddParameters("RET_MSG", DbType.String, "");

                    iResult = dbCon.ExcuteNonQuery("TYJINFWLIB.SP_TYCSI_CSI3021_UTIPJIF_UPDATE");
                }
                result = iResult == -1 ? true : false;
                fsMSG = iResult == -1 ? "" : "입고지시 등록 중 오류가 발생하였습니다.";

                return result;
            }
            catch
            {
                return false;
            }
        }
        #endregion

        #region Description : 출고지시 문자 발송
        private void UP_SMS_SEND(string sGUBUN)
        {
             
            string sClient_id = string.Empty;    // 서비스아이디
            string sClient_Pwd = string.Empty;   // 서비스Password
            string sSendMessAge = string.Empty;  // 문자내용
            string sSender = string.Empty;        // 회신번호
            string sList_Receiver = string.Empty; // 수신번호
            string sList_Receiver1 = string.Empty; // 수신번호
            string sList_Receiver2 = string.Empty; // 수신번호
            string sList_Receiver3 = string.Empty; // 수신번호
            string sList_Receiver4 = string.Empty; // 수신번호

            string sRtnmsg = string.Empty;

            sClient_id = "taeyoungutt";        // 서비스아이디
            sClient_Pwd = "utt10449";            // 서비스Password

            //태영 담당자 핸드폰번호 받아오기
            if (sGUBUN == "")
            {
                sList_Receiver = UP_Mobile_Phone(fsJIHISAB.Trim().ToUpper());

                if (sList_Receiver.Trim() == "")
                {
                    return;
                }
            }
            else
            {
                //박동근
                sList_Receiver1 = UP_Mobile_Phone("0107-M");
                //김종술
                sList_Receiver2 = UP_Mobile_Phone("0310-M");
                //박선형
                sList_Receiver3 = UP_Mobile_Phone("0304-F");
                //김대현
                sList_Receiver4 = UP_Mobile_Phone("0419-M");


                if (sList_Receiver1.Trim() == "" &&
                sList_Receiver2.Trim() == "" &&
                sList_Receiver3.Trim() == "" &&
                sList_Receiver4.Trim() == "")
                {
                    return;
                }
            }

            //문자 전송 메세지 - 날짜 + 화주 + 화물 
            sSendMessAge = fsJIYYMM.Trim().Substring(4, 2) + "/" + fsJIYYMM.Trim().Substring(6, 2) + "-";   // 일자
            sSendMessAge = sSendMessAge + fsJIJGHWAJUNM + "-";                                              // 화주
            sSendMessAge = sSendMessAge + fsJIHWAMULNM.Trim() + "-";                                        // 화물
            sSendMessAge = sSendMessAge + fsJITANKNO + "-";                                                 // 탱크번호
            sSendMessAge = sSendMessAge + fsJICARNO2.Trim() + "-";                                          // 차량번호
            sSendMessAge = sSendMessAge + Get_Numeric(fsJISTMTQTY.Trim()) + "톤-";                          // 수량
            sSendMessAge = sSendMessAge + fsCARCNT + "대-출고";                                             // 대수

            sSender = "0522283510";             // 회신번호(고객지원파트 박동근)

            try
            {
                string sNowTime = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString() + ":" + DateTime.Now.Second.ToString();

                string sSendDate = String.Format("{0:yyyy-MM-dd}", DateTime.Now) + " " + sNowTime;

                ezSMSComponent.SMS oEzSMS = new ezSMSComponent.SMS();

                ezSMSComponent.Receivers objReceivers;

                objReceivers = oEzSMS.CreateReceivers();

                ezSMSComponent.ISendResults objSendResults;

                oEzSMS.ServiceCode = "020099675886D64240D7A73F1B9521AC18B5"; //  taeyoungutt : t10449

                oEzSMS.Login("smspia.com", 4545, sClient_id, sClient_Pwd);

                if (sGUBUN == "")
                {
                    objReceivers.AddDirect(sList_Receiver, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                }
                else
                {
                    objReceivers.AddDirect(sList_Receiver1, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                    objReceivers.AddDirect(sList_Receiver2, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                    objReceivers.AddDirect(sList_Receiver3, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                    objReceivers.AddDirect(sList_Receiver4, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                }
                //objReceivers.AddDirect("01026581018", sSendMessAge, 0, Convert.ToDateTime(sSendDate));

                objSendResults = oEzSMS.SendSMS(sSender, objReceivers);

                string sresult = "";

                for (int i = 0; i < objSendResults.Count; i++)
                {
                    sresult = objSendResults.Index[i].ToString();
                }

                if (sresult == "4")
                {
                    sRtnmsg = "OK";
                }
                else
                {
                    sRtnmsg = "ERR";
                }

            }
            catch(Exception ex)
            {
                fsMSG = ex.Message;
            }
            finally
            {
            }

            return;
        }
        #endregion

        #region Description : 출고지시 메일 발송
        private void UP_Mail_SEND()
        {

            try
            {
                string sFirst = string.Empty;
                string sLine = string.Empty;
                string sMailAddress = string.Empty;

                MailMessage mail = new MailMessage();

                sMailAddress = "";
                
                if (fsJIHISAB.Trim().ToUpper() == "0107-M") //박동근
                {
                    sMailAddress = "dkpark@taeyoung.co.kr";
                }
                if (fsJIHISAB.Trim().ToUpper() == "0304-F") //박선형
                {
                    sMailAddress = "shpark@taeyoung.co.kr";
                }
                if (fsJIHISAB.Trim().ToUpper() == "0310-M") //김종술
                {
                    sMailAddress = "jskim@taeyoung.co.kr";
                }
                if (fsJIHISAB.Trim().ToUpper() == "0419-M") //김대현
                {
                    sMailAddress = "dhkim@taeyoung.co.kr";
                }

                if (sMailAddress == "")
                {
                    sMailAddress = "khim@taeyoung.co.kr";
                }

                //sMailAddress = "shyeonlee@taeyoung.co.kr"; // 주석처리

                mail.From = "khim@taeyoung.co.kr";

                mail.To = sMailAddress;

                mail.Subject = fsJIJGHWAJUNM + "로부터 출고 요청메일이 도착하였습니다.";

                sFirst = "-//W3C//DTD XHTML 1.0 Transitional//EN ";

                sLine = "";
                sLine = sLine + " <!DOCTYPE HTML PUBLIC '" + sFirst + "'>    ";
                sLine = sLine + " <html>                                     ";
                sLine = sLine + "    <head>                                  ";
                sLine = sLine + "       <title> 출고 요청 화면 </title>      ";
                sLine = sLine + "    </head>                                 ";
                sLine = sLine + "    <body>                                  ";
                sLine = sLine + "      <table width = 500px height = 150px border = 1 cellpadding = 0 cellspacing = 0 > ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td align = 'Left'>구   분      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>내   용      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>오더  일자   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsJIYYMM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>오더  순번   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsJISEQLIST + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>화  물  명   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsJIHWAMUL + " - " + fsJIHWAMULNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";

                // 김종술 과장 요청 출고 유형이 TANKLORRY 가 아닌경우 컨테이너 번호로 발송 2019-08-21
                if (fsJIWKTYPE == "01")
                {
                    sLine = sLine + "         <tr>                               ";
                    sLine = sLine + "            <td ALIGN = 'Left'>차량  번호   ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "            <td ALIGN = 'Left'>" + fsJICARNO2 + " ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "         </tr>                              ";
                }
                else
                {
                    sLine = sLine + "         <tr>                               ";
                    sLine = sLine + "            <td ALIGN = 'Left'>컨테이너번호   ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "            <td ALIGN = 'Left'>" + fsJICONTNUM + " ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "         </tr>                              ";
                }

                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'> 출고화주    ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsJICHHJ + " - " + fsJICHHJNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>지시수량(MT) ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Right'>" + Get_Numeric(fsJISTMTQTY.Trim()) + " - " + Get_Numeric(fsJIEDMTQTY.Trim()) + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>지시수량(L)  ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Right'>" + Get_Numeric(fsJISTLTQTY.Trim()) + " - " + Get_Numeric(fsJIEDLTQTY.Trim()) + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>출고탱크     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsJITANKNO + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>특허구분     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsJITMGUBNNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>지시사항     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsJICARNO1 + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>지시대수     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsCARCNT + " 대";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "      </table>                              ";
                sLine = sLine + "    </body>                                 ";
                sLine = sLine + " </html>                                    ";


                mail.Body = sLine;

                mail.BodyFormat = MailFormat.Html;

                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                SmtpMail.Send(mail);
            }
            catch (Exception ex)
            {
                string a = string.Empty;

                a = ex.Message;
            }


        }
        #endregion

        #region Description : 입고지시 문자 발송
        private void UP_IPSMS_SEND(string sGUBUN)
        {
            string sClient_id = string.Empty;    // 서비스아이디
            string sClient_Pwd = string.Empty;   // 서비스Password
            string sSendMessAge = string.Empty;  // 문자내용
            string sSender = string.Empty;        // 회신번호
            string sList_Receiver = string.Empty; // 수신번호
            string sList_Receiver1 = string.Empty; // 수신번호
            string sList_Receiver2 = string.Empty; // 수신번호
            string sList_Receiver3 = string.Empty; // 수신번호
            string sList_Receiver4 = string.Empty; // 수신번호

            string sRtnmsg = string.Empty;

            sClient_id = "taeyoungutt";        // 서비스아이디
            sClient_Pwd = "utt10449";            // 서비스Password

            if (sGUBUN == "")
            {
                sList_Receiver = UP_Mobile_Phone(fsIOHISAB.Trim().ToUpper());

                if (sList_Receiver.Trim() == "")
                {
                    return;
                }
            }
            else
            {
                //박동근
                sList_Receiver1 = UP_Mobile_Phone("0107-M");
                //김종술
                sList_Receiver2 = UP_Mobile_Phone("0310-M");
                //박선형
                sList_Receiver3 = UP_Mobile_Phone("0304-F");
                //김대현
                sList_Receiver4 = UP_Mobile_Phone("0419-M");

                if (sList_Receiver1.Trim() == "" &&
                sList_Receiver2.Trim() == "" &&
                sList_Receiver3.Trim() == "" &&
                sList_Receiver4.Trim() == "")
                {
                    return;
                }
            }

            //문자 전송 메세지 - 날짜 + 화주 + 화물 
            sSendMessAge = fsIOIPDATE.Trim().Substring(4, 2) + "/" + fsIOIPDATE.Trim().Substring(6, 2) + "-";   // 일자
            sSendMessAge = sSendMessAge + fsIOHWAJUNM + "-";                                                    // 화주
            sSendMessAge = sSendMessAge + fsIOHWAMULNM.Trim() + "-";                                            // 화물
            sSendMessAge = sSendMessAge + fsIOTANKNO + "-";                                                     // 탱크번호
            if (fsIOWKTYPE == "01")
            {
                sSendMessAge = sSendMessAge + fsIOCARNO.Trim() + "-";                                           // 차량번호
            }
            else
            {
                sSendMessAge = sSendMessAge + fsIOCONTAIN.Trim() + "-";                                         // 컨테이너번호
            }
            sSendMessAge = sSendMessAge + Get_Numeric(fsIOIPQTY.Trim()) + "톤-";                                // 수량
            sSendMessAge = sSendMessAge + fsIOCARCNT + "대-입고";                            // 지시대수
            
            sSender = "0522283510";             // 회신번호(고객지원파트 박동근)

            try
            {

                ezSMSComponent.SMS oEzSMS = new ezSMSComponent.SMS();

                ezSMSComponent.Receivers objReceivers;

                objReceivers = oEzSMS.CreateReceivers();

                ezSMSComponent.ISendResults objSendResults;


                string sNowTime = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString() + ":" + DateTime.Now.Second.ToString();

                string sSendDate = String.Format("{0:yyyy-MM-dd}", DateTime.Now) + " " + sNowTime;

                oEzSMS.ServiceCode = "020099675886D64240D7A73F1B9521AC18B5"; //  taeyoungutt : t10449

                oEzSMS.Login("smspia.com", 4545, sClient_id, sClient_Pwd);

                if (sGUBUN == "")
                {
                    objReceivers.AddDirect(sList_Receiver, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                }
                else
                {
                    objReceivers.AddDirect(sList_Receiver1, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                    objReceivers.AddDirect(sList_Receiver2, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                    objReceivers.AddDirect(sList_Receiver3, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                    objReceivers.AddDirect(sList_Receiver4, sSendMessAge, 0, Convert.ToDateTime(sSendDate));
                }
                //objReceivers.AddDirect("01026581018", sSendMessAge, 0, Convert.ToDateTime(sSendDate));

                objSendResults = oEzSMS.SendSMS(sSender, objReceivers);

                string sresult = "";

                for (int i = 0; i < objSendResults.Count; i++)
                {
                    sresult = objSendResults.Index[i].ToString();
                }

                if (sresult == "4")
                {
                    sRtnmsg = "OK";
                }
                else
                {
                    sRtnmsg = "ERR";
                }

            }
            catch
            {
            }
            finally
            {
            }

            return;
        }
        #endregion

        #region Description : 입고지시 메일 발송
        private void UP_IPMail_SEND()
        {
            try
            {
                string sFirst = string.Empty;
                string sLine = string.Empty;
                string sMailAddress = string.Empty;

                MailMessage mail = new MailMessage();

                sMailAddress = "";
                
                if (fsIOHISAB.Trim().ToUpper() == "0107-M") //박동근
                {
                    sMailAddress = "dkpark@taeyoung.co.kr";
                }
                if (fsIOHISAB.Trim().ToUpper() == "0304-F") //박선형
                {
                    sMailAddress = "shpark@taeyoung.co.kr";
                }
                if (fsIOHISAB.Trim().ToUpper() == "0310-M") //김종술
                {
                    sMailAddress = "jskim@taeyoung.co.kr";
                }
                if (fsIOHISAB.Trim().ToUpper() == "0419-M") //김대현
                {
                    sMailAddress = "dhkim@taeyoung.co.kr";
                }

                if (sMailAddress == "")
                {
                    sMailAddress = "khim@taeyoung.co.kr";
                }

                //sMailAddress = "shyeonlee@taeyoung.co.kr";    // 주석처리

                mail.From = "khim@taeyoung.co.kr";

                mail.To = sMailAddress;

                mail.Subject = fsIOHWAJUNM.Trim() + "로부터 입고 요청메일이 도착하였습니다.";

                sFirst = "-//W3C//DTD XHTML 1.0 Transitional//EN ";

                sLine = "";
                sLine = sLine + " <!DOCTYPE HTML PUBLIC '" + sFirst + "'>    ";
                sLine = sLine + " <html>                                     ";
                sLine = sLine + "    <head>                                  ";
                sLine = sLine + "       <title> 입고 요청 화면 </title>      ";
                sLine = sLine + "    </head>                                 ";
                sLine = sLine + "    <body>                                  ";
                sLine = sLine + "      <table width = 500px height = 150px border = 1 cellpadding = 0 cellspacing = 0 > ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td align = 'Left'>구   분      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>내   용      ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>입고  일자   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOIPDATE + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>입고  순번   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOTKNOLIST + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>화  물  명   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOHWAMUL + " - " + fsIOHWAMULNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>차량  번호   ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOCARNO + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>컨테이너번호 ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOCONTAIN + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>입고수량(MT) ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Right'>" + Get_Numeric(fsIOIPQTY) + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>입고탱크     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOTANKNO + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>특허구분     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOTMGUBNNM + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>지시사항     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIODESC + " ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td ALIGN = 'Left'>지시대수     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td ALIGN = 'Left'>" + fsIOCARCNT + " 대";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";
                sLine = sLine + "      </table>                              ";
                sLine = sLine + "    </body>                                 ";
                sLine = sLine + " </html>                                    ";


                mail.Body = sLine;

                mail.BodyFormat = MailFormat.Html;

                //SmtpMail.SmtpServer.Insert(0, "192.168.100.72");

                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                SmtpMail.Send(mail);
            }
            catch (Exception ex)
            {
                string a = string.Empty;

                a = ex.Message;
            }
        }
        #endregion

        #region Description : 담당자 번호 조회
        private string UP_Mobile_Phone(string sSABUN)
        {
            string sPhone = "";
            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SABUN", DbType.String, sSABUN);

                ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_GET_PHONENUM");
            }

            if (ds.Tables[0].Rows.Count > 0)
            {
                sPhone = ds.Tables[0].Rows[0]["KBMOBILE"].ToString();
            }

            sPhone = sPhone.Replace("-", "");

            if (sPhone.Trim().Substring(0, 3) == "011" ||
                sPhone.Trim().Substring(0, 3) == "017" ||
                sPhone.Trim().Substring(0, 3) == "016" ||
                sPhone.Trim().Substring(0, 3) == "019")
            {
                if (sPhone.Trim().Length < 10)
                {
                    sPhone = "";
                }
            }
            else
            {
                if (sPhone.Trim().Length < 11)
                {
                    sPhone = "";
                }
            }

            return sPhone;
        }
        #endregion

        #region Description : 문자포맷 변환
        private string Get_Numeric(string sStr)
        {
            if (sStr == "") return "0";
            else return sStr.Replace(",", "");
        }

        public string StringToDate(string date)
        {
            string rst = date.Substring(0, 4) + "/" + date.Substring(4, 2) + "/" + date.Substring(6, 2);
            return rst;
        }
        public string DateToString(string date)
        {
            string rst = date.Substring(0, 4) + date.Substring(5, 2) + date.Substring(8, 2);
            return rst;
        }
        public string Get_NowDate()
        {
            string NowDate = System.DateTime.Now.ToShortDateString().Substring(0, 4) + System.DateTime.Now.ToShortDateString().Substring(5, 2) + System.DateTime.Now.ToShortDateString().Substring(8, 2);
            return NowDate;
        }
        public string Get_NowTime()
        {
            string NowTime = System.DateTime.Now.ToString("yyyyMMddHHmmssff").Substring(8, 6).ToString();
            return NowTime;
        }
        public string Set_Fill2(string sFirst)
        {
            if (sFirst.Length == 0)
            {
                sFirst = "00";
            }
            else if (sFirst.Length == 1)
            {
                sFirst = "0" + sFirst;
            }
            else if (sFirst.Length == 2)
            {
                sFirst = sFirst;
            }
            else sFirst = "00";

            return sFirst;
        }
        #endregion

        #region Description : 출고지시내용 조회
        public DataSet UP_CSI3030_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_JIYYMM", DbType.String, ht["JIYYMM"]);
                dbCon.AddParameters("P_JIGSPINO", DbType.String, ht["JIGSPINO"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3030_LIST ");
            }
        }
        #endregion

        #region Description : 출고지시 컨테이너 번호 저장
        public DataSet UP_CSI3030_SAVE(Hashtable ht, Hashtable[] hts)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_CSI3030_Check(hts);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    for (int i = 0; i < hts.Length; i++)
                    {
                        dbCon.AddParameters("P_JIYYMM", DbType.String, hts[i]["JIYYMM"]);
                        dbCon.AddParameters("P_JISEQ", DbType.String, hts[i]["JISEQ"]);
                        dbCon.AddParameters("P_JICONTNUM", DbType.String, hts[i]["JICONTNUM"]);

                        dbCon.ExcuteNonQuery("TYJINFWLIB.SP_TYCSI_CSI3030_JICONTNUM_UPDATE");
                    }
                }
                UP_CONTNUMMail_SEND(hts);

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

        #region Description : 출고지시 컨테이너 번호 저장 체크
        public string UP_CSI3030_Check(Hashtable[] hts)
        {
            string sMSG = string.Empty;

            DataSet ds = new DataSet();

            // 출고여부 체크
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_JIYYMM", DbType.String, hts[i]["JIYYMM"]);
                    dbCon.AddParameters("P_JISEQ", DbType.VarNumeric, hts[i]["JISEQ"]);

                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3030_CHCHULF_CHECK");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //sMSG = hts[i]["JIYYMM"].ToString() + "-" + hts[i]["JISEQ"].ToString() + " : 이미 출고 완료되었거나, 출고 중인 컨테이너 번호 입니다. 등록 및 수정은 불가능 하오니, 담당자에게 연락바랍니다.";
                        sMSG = ds.Tables[0].Rows[0]["CHCONTNUM"].ToString() + " : 이미 출고 완료되었거나, 출고 중인 컨테이너 번호 입니다. 등록 및 수정은 불가능 하오니, 담당자에게 연락바랍니다.";

                        return sMSG;
                    }
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : 컨테이너 번호 수정 메일 발송
        private void UP_CONTNUMMail_SEND(Hashtable[] hts)
        {
            try
            {
                DataSet ds = new DataSet();
                string sFirst = string.Empty;
                string sLine = string.Empty;
                string sMailAddress = string.Empty;

                MailMessage mail = new MailMessage();

                sMailAddress = "shpark@taeyoung.co.kr";


                //sMailAddress = "shyeonlee@taeyoung.co.kr";    // 주석처리

                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_JIYYMM", DbType.String, hts[0]["JIYYMM"]);
                    dbCon.AddParameters("P_JIGSPINO", DbType.String, hts[0]["GSPINO"]);

                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3030_LIST ");
                }

                mail.From = "shyeonlee@taeyoung.co.kr";

                mail.To = sMailAddress;

                mail.Subject = "수출용 컨테이너 번호 등록의 건-" + hts[0]["GSPINO"].ToString() + "▶" + hts[0]["MANAGER"].ToString();

                sFirst = "-//W3C//DTD XHTML 1.0 Transitional//EN ";

                sLine = "";
                sLine = sLine + " <!DOCTYPE HTML PUBLIC '" + sFirst + "'>    ";
                sLine = sLine + " <html>                                     ";
                sLine = sLine + "    <head>                                  ";
                sLine = sLine + "       <title> 입고 요청 화면 </title>      ";
                sLine = sLine + "    </head>                                 ";
                sLine = sLine + "    <body>                                  ";
                sLine = sLine + "      <table width = 1200px height = 150px border = 1 cellpadding = 0 cellspacing = 0 > ";

                sLine = sLine + "      <colgroup> ";
                sLine = sLine + "           <col width= 80px /> ";
                sLine = sLine + "           <col width= 50px /> ";
                sLine = sLine + "           <col width= 200px /> ";
                sLine = sLine + "           <col width= 180px /> ";
                sLine = sLine + "           <col width= 180px /> ";
                sLine = sLine + "           <col width= 180px /> ";
                sLine = sLine + "           <col width= 330px /> ";
                sLine = sLine + "      </colgroup> ";

                sLine = sLine + "         <tr>                               ";
                sLine = sLine + "            <td align = 'Left'>작업일자     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>순  번       ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>재고화주     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>화  물       ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>컨테이너번호 ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "            <td align = 'Left'>목적국       ";
                sLine = sLine + "            </td>                           ";                
                sLine = sLine + "            <td align = 'Left'>지시사항     ";
                sLine = sLine + "            </td>                           ";
                sLine = sLine + "         </tr>                              ";


                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    sLine = sLine + "         <tr>                               ";
                    sLine = sLine + "            <td align = 'Left'>" + ds.Tables[0].Rows[i]["JIYYMM"].ToString() + " ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "            <td align = 'Left'>" + ds.Tables[0].Rows[i]["JISEQ"].ToString() + " ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "            <td align = 'Left'>" + ds.Tables[0].Rows[i]["HJDESC"].ToString() + " ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "            <td align = 'Left'>" + ds.Tables[0].Rows[i]["HMDESC1"].ToString() + " ";
                    sLine = sLine + "            </td>                           ";

                    string sJISEQ = string.Empty;
                    for(int j = 0; j < hts.Length; j++)
                    {
                        if(ds.Tables[0].Rows[i]["JISEQ"].ToString() == hts[j]["JISEQ"].ToString())
                        {
                            sJISEQ = hts[j]["JISEQ"].ToString();
                        }
                    }

                    if(sJISEQ != "") { 
                        sLine = sLine + "            <td align = 'Left' style='color:RED'>" + ds.Tables[0].Rows[i]["JICONTNUM"].ToString() + " ";
                    }
                    else
                    {
                        sLine = sLine + "            <td align = 'Left' >" + ds.Tables[0].Rows[i]["JICONTNUM"].ToString() + " ";
                    }

                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "            <td align = 'Left'>" + ds.Tables[0].Rows[i]["GSDESC1"].ToString() + " ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "            <td align = 'Left'>" + ds.Tables[0].Rows[i]["JICARNO1"].ToString() + " ";
                    sLine = sLine + "            </td>                           ";
                    sLine = sLine + "         </tr>                              ";
                }

                //for (int i = 0; i < hts.Length; i++)
                //{
                //    sLine = sLine + "         <tr>                               ";
                //    sLine = sLine + "            <td align = 'Left'>" + hts[i]["JIYYMM"].ToString() + " ";
                //    sLine = sLine + "            </td>                           ";
                //    sLine = sLine + "            <td align = 'Left'>" + hts[i]["JISEQ"].ToString() + " ";
                //    sLine = sLine + "            </td>                           ";
                //    sLine = sLine + "            <td align = 'Left'>" + hts[i]["HJDESC"].ToString() + " ";
                //    sLine = sLine + "            </td>                           ";
                //    sLine = sLine + "            <td align = 'Left'>" + hts[i]["HMDESC1"].ToString() + " ";
                //    sLine = sLine + "            </td>                           ";
                //    sLine = sLine + "            <td align = 'Left' style='color:RED'>" + hts[i]["JICONTNUM"].ToString() + " ";
                //    sLine = sLine + "            </td>                           ";
                //    sLine = sLine + "            <td align = 'Left'>" + hts[i]["GSDESC1"].ToString() + " ";
                //    sLine = sLine + "            </td>                           ";
                //    sLine = sLine + "            <td align = 'Left'>" + hts[i]["JICARNO1"].ToString() + " ";
                //    sLine = sLine + "            </td>                           ";
                //    sLine = sLine + "         </tr>                              ";
                //}

                sLine = sLine + "      </table>                              ";
                sLine = sLine + "    </body>                                 ";
                sLine = sLine + " </html>                                    ";


                mail.Body = sLine;

                mail.BodyFormat = MailFormat.Html;

                //SmtpMail.SmtpServer.Insert(0, "192.168.100.72");

                SmtpMail.SmtpServer = "mail.taeyoung.co.kr";

                SmtpMail.Send(mail);
            }
            catch (Exception ex)
            {
                string a = string.Empty;

                a = ex.Message;
            }
        }
        #endregion

        #region Description : 출고내용 조회
        public DataSet UP_CSI3031_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CHCHULIL", DbType.String, ht["CHCHULIL"]);
                dbCon.AddParameters("P_JIGSPINO", DbType.String, ht["JIGSPINO"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSI_CSI3031_LIST ");
            }
        }
        #endregion
    }
}
