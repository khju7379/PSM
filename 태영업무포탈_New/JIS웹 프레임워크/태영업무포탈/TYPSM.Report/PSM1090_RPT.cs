using System;
using System.Drawing;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using GrapeCity.ActiveReports;
using GrapeCity.ActiveReports.Document;
using GrapeCity.ActiveReports.SectionReportModel;
using GrapeCity.ActiveReports.Document.Section;
using GrapeCity.ActiveReports.Drawing;

using TaeYoung.Biz;
using System.Data;

namespace TYPSM.Report
{
    /// <summary>
    /// Summary description for PSM1090_RPT.
    /// </summary>
    public partial class PSM1090_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private int iCount = 0;
        private int iNum = 0;
        private int irowCount = 1;
        private int ipagenum = 1;
        private string _NUM = string.Empty;

        private DataTable _dt = new DataTable();
        private string _sSANAME = string.Empty;
        private string _sTONAME = string.Empty;

        private string fsSESSIONID = string.Empty;
        private string fsWKGUBN = string.Empty;
        private string fsPOTEAM = string.Empty;
        private string fsPODATE = string.Empty;
        private string fsPOSEQ = string.Empty;
        private string fsDATE = string.Empty;
        private string fsMSEQ = string.Empty;
        private string fsBLASS = string.Empty;
        private string fsMLASS = string.Empty;
        private string fsSLASS = string.Empty;
        private string fsSEQ = string.Empty;

        private string fsGUBUN = string.Empty;
        private string fsPRINTNAME = string.Empty;
        private string fsPRINTCNT = string.Empty;

        private byte[][] _sImages;
        private byte[][] _stoolImages;

        public PSM1090_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public PSM1090_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();


            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            if(strArray.Length == 6) { 
                ArryWk = strArray[1].Split('=');
                fsSESSIONID = ArryWk[1].ToString();
                ArryWk = strArray[2].Split('=');
                fsBLASS = ArryWk[1].ToString();
                ArryWk = strArray[3].Split('=');
                fsMLASS = ArryWk[1].ToString();
                ArryWk = strArray[4].Split('=');
                fsSLASS = ArryWk[1].ToString();
                ArryWk = strArray[5].Split('=');
                fsSEQ = ArryWk[1].ToString();

                fsGUBUN = "JSA";
            }
            else
            {
                ArryWk = strArray[1].Split('=');
                fsSESSIONID = ArryWk[1].ToString();
                ArryWk = strArray[2].Split('=');
                fsWKGUBN = ArryWk[1].ToString();
                ArryWk = strArray[3].Split('=');
                fsPOTEAM = ArryWk[1].ToString();
                ArryWk = strArray[4].Split('=');
                fsPODATE = ArryWk[1].ToString();
                ArryWk = strArray[5].Split('=');
                fsPOSEQ = ArryWk[1].ToString();
                ArryWk = strArray[6].Split('=');
                fsDATE = ArryWk[1].ToString();
                ArryWk = strArray[7].Split('=');
                fsMSEQ = ArryWk[1].ToString();
                ArryWk = strArray[8].Split('=');
                fsBLASS = ArryWk[1].ToString();
                ArryWk = strArray[9].Split('=');
                fsMLASS = ArryWk[1].ToString();
                ArryWk = strArray[10].Split('=');
                fsSLASS = ArryWk[1].ToString();
                ArryWk = strArray[11].Split('=');
                fsSEQ = ArryWk[1].ToString();

                fsGUBUN = "JSACHANGE";
            }

            UP_DataBing();
        }

        public PSM1090_RPT(string QueryString) // 웹 서비스 호출 용
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();


            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');


            ArryWk = strArray[1].Split('=');
            fsSESSIONID = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            fsWKGUBN = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            fsPOTEAM = ArryWk[1].ToString();
            ArryWk = strArray[4].Split('=');
            fsPODATE = ArryWk[1].ToString();
            ArryWk = strArray[5].Split('=');
            fsPOSEQ = ArryWk[1].ToString();
            ArryWk = strArray[6].Split('=');
            fsDATE = ArryWk[1].ToString();
            ArryWk = strArray[7].Split('=');
            fsMSEQ = ArryWk[1].ToString();
            ArryWk = strArray[8].Split('=');
            fsBLASS = ArryWk[1].ToString();
            ArryWk = strArray[9].Split('=');
            fsMLASS = ArryWk[1].ToString();
            ArryWk = strArray[10].Split('=');
            fsSLASS = ArryWk[1].ToString();
            ArryWk = strArray[11].Split('=');
            fsSEQ = ArryWk[1].ToString();
            ArryWk = strArray[12].Split('=');
            fsPRINTNAME = ArryWk[1].ToString();
            ArryWk = strArray[13].Split('=');
            fsPRINTCNT = ArryWk[1].ToString();

            fsGUBUN = "JSACHANGE";


            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            if (fsGUBUN == "JSA")
            {
                using (TaeYoung.Biz.PSM.PSM1090 biz = new TaeYoung.Biz.PSM.PSM1090())
                {

                    // JSA MASTER 조회
                    ht["P_MENU_NAME"] = fsBLASS + "_" + fsMLASS + "_" + fsSLASS + "_" + fsSEQ;

                    DataSet ds = biz.UP_JSA_MASTER_RUN(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        _dt = ds.Tables[0];
                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                _sSANAME = ds.Tables[1].Rows[i]["NAME"].ToString();
                            }
                            else
                            {
                                _sSANAME = _sSANAME + ", " + ds.Tables[1].Rows[i]["NAME"].ToString();
                            }
                        }
                    }
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                _sTONAME = ds.Tables[2].Rows[i]["NAME"].ToString();
                            }
                            else
                            {
                                _sTONAME = _sTONAME + ", " + ds.Tables[2].Rows[i]["NAME"].ToString();
                            }
                        }
                    }

                    // JSA DETAIL 조회
                    ht = new Hashtable();

                    ht["SESSIONID"] = fsSESSIONID;
                    ht["P_MENU_NAME"] = fsBLASS + "_" + fsMLASS + "_" + fsSLASS + "_" + fsSEQ;
                    ht["GUBUN"] = "P";

                    ds = biz.UP_JSA_PRT_LIST(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        this.DataSource = ds.Tables[0];

                        //_sImages = new byte[Convert.ToInt32(ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["PRITEMSEQ"]) + 1][];
                        //_stoolImages = new byte[Convert.ToInt32(ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["PRITEMSEQ"]) + 1][];
                        _sImages = new byte[500][];
                        _stoolImages = new byte[500][];
                    }
                    else
                    {
                        this.DataSource = new DataTable();
                    }

                    // 사진 조회
                    ht = new Hashtable();
                    ht["ATTACH_NO"] = fsBLASS + fsMLASS + fsSLASS + fsSEQ;

                    ds = biz.PSM_PSM1090_JSA_ATTACH_LIST(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            if (ds.Tables[0].Rows[i]["GUBUN"].ToString() == "JSA")
                            {
                                _sImages[Convert.ToInt32(ds.Tables[0].Rows[i]["SEQ"])] = ds.Tables[0].Rows[i]["ATTACH_BYTE"] as byte[];
                            }
                            else
                            {
                                _stoolImages[Convert.ToInt32(ds.Tables[0].Rows[i]["SEQ"])] = ds.Tables[0].Rows[i]["ATTACH_BYTE"] as byte[];
                            }
                        }
                    }
                }
            }
            else
            {
                using (TaeYoung.Biz.PSM.PSM4045 biz = new TaeYoung.Biz.PSM.PSM4045())
                {
                    // JSA(변경관리) MASTER 조회
                    ht["P_JSMWKGUBN"] = fsWKGUBN;
                    ht["P_JSMPOTEAM"] = fsPOTEAM;
                    ht["P_JSMPODATE"] = fsPODATE;
                    ht["P_JSMPOSEQ"] = fsPOSEQ;
                    ht["P_JSMDATE"] = fsDATE;
                    ht["P_JSMMSEQ"] = fsMSEQ;
                    ht["P_JSMBLASS"] = fsBLASS;
                    ht["P_JSMMLASS"] = fsMLASS;
                    ht["P_JSMSLASS"] = fsSLASS;
                    ht["P_JSMSEQ"] = fsSEQ;

                    DataSet ds = biz.UP_JSACHANGE_MASTER_RUN(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        _dt = ds.Tables[0];
                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                _sSANAME = ds.Tables[1].Rows[i]["NAME"].ToString();
                            }
                            else
                            {
                                _sSANAME = _sSANAME + ", " + ds.Tables[1].Rows[i]["NAME"].ToString();
                            }
                        }
                    }
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                _sTONAME = ds.Tables[2].Rows[i]["NAME"].ToString();
                            }
                            else
                            {
                                _sTONAME = _sTONAME + ", " + ds.Tables[2].Rows[i]["NAME"].ToString();
                            }
                        }
                    }

                    // JSA(변경관리) DETAIL 조회
                    ht = new Hashtable();

                    ht["P_SESSIONID"] = fsSESSIONID;
                    ht["P_JSMWKGUBN"] = fsWKGUBN;
                    ht["P_JSMPOTEAM"] = fsPOTEAM;
                    ht["P_JSMPODATE"] = fsPODATE;
                    ht["P_JSMPOSEQ"] = fsPOSEQ;
                    ht["P_JSMDATE"] = fsDATE;
                    ht["P_JSMMSEQ"] = fsMSEQ;
                    ht["P_JSMBLASS"] = fsBLASS;
                    ht["P_JSMMLASS"] = fsMLASS;
                    ht["P_JSMSLASS"] = fsSLASS;
                    ht["P_JSMSEQ"] = fsSEQ;
                    ht["P_SABUN"] = "";
                    ht["P_GUBUN"] = "P";

                    ds = biz.UP_JSACHANGE_PRT_LIST(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        this.DataSource = ds.Tables[0];

                        //_sImages = new byte[Convert.ToInt32(ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["PRITEMSEQ"]) + 1][];
                        //_stoolImages = new byte[Convert.ToInt32(ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["PRITEMSEQ"]) + 1][];
                        _sImages = new byte[500][];
                        _stoolImages = new byte[500][];
                    }
                    else
                    {
                        this.DataSource = new DataTable();
                    }

                    // 사진 조회
                    ht = new Hashtable();
                    ht["P_JSMWKGUBN"] = fsWKGUBN;
                    ht["P_JSMPOTEAM"] = fsPOTEAM;
                    ht["P_JSMPODATE"] = fsPODATE;
                    ht["P_JSMPOSEQ"] = fsPOSEQ;
                    ht["P_JSMDATE"] = fsDATE;
                    ht["P_JSMMSEQ"] = fsMSEQ;
                    ht["P_JSMBLASS"] = fsBLASS;
                    ht["P_JSMMLASS"] = fsMLASS;
                    ht["P_JSMSLASS"] = fsSLASS;
                    ht["P_JSMSEQ"] = fsSEQ;

                    ds = biz.PSM_PSM4045_JSACHANGE_ATTACH_LIST(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            if (ds.Tables[0].Rows[i]["GUBUN"].ToString() == "JSA")
                            {
                                _sImages[Convert.ToInt32(ds.Tables[0].Rows[i]["SEQ"])] = ds.Tables[0].Rows[i]["ATTACH_BYTE"] as byte[];
                            }
                            else
                            {
                                _stoolImages[Convert.ToInt32(ds.Tables[0].Rows[i]["SEQ"])] = ds.Tables[0].Rows[i]["ATTACH_BYTE"] as byte[];
                            }
                        }
                    }
                }
            }
        }

        private void reportHeader1_Format(object sender, EventArgs e)
        {
            if (_dt.Rows[0]["JSMPODATE"].ToString() != "")
            {
                this.JSMPODATE.Text = _dt.Rows[0]["JSMPODATE"].ToString().Substring(0, 4) + "-" + _dt.Rows[0]["JSMPODATE"].ToString().Substring(4, 2) + "-" + _dt.Rows[0]["JSMPODATE"].ToString().Substring(6, 2);
            }
            else
            {
                this.JSMPODATE.Text = "";
            }
            this.JSMWKNAME.Text = _dt.Rows[0]["JSMWKNAME"].ToString();
            this.JSMSYSTEM.Text = _dt.Rows[0]["JSMSYSTEM"].ToString();
            this.JSMWKDATE.Text = _dt.Rows[0]["JSMWKDATE"].ToString().Substring(0, 4) + "-" + _dt.Rows[0]["JSMWKDATE"].ToString().Substring(4, 2) + "-" + _dt.Rows[0]["JSMWKDATE"].ToString().Substring(6, 2);
            this.JSMADDATE.Text = _dt.Rows[0]["JSMADDATE"].ToString().Substring(0, 4) + "-" + _dt.Rows[0]["JSMADDATE"].ToString().Substring(4, 2) + "-" + _dt.Rows[0]["JSMADDATE"].ToString().Substring(6, 2);
            this.JSMADCHASU.Text = _dt.Rows[0]["JSMADCHASU"].ToString();
            this.JSMSECTIONNUM.Text = _dt.Rows[0]["JSMSECTIONNUM"].ToString();
            this.JSMMSDSCODE.Text = _dt.Rows[0]["JSMMSDSCODE"].ToString();
            this.JSMWKSABUN.Text = _dt.Rows[0]["JSMWKSABUNNM"].ToString();
            this.JSMWKSUMMARY.Text = _dt.Rows[0]["JSMWKSUMMARY"].ToString();
            this.JSMNEEDDATA.Text = _dt.Rows[0]["JSMNEEDDATA"].ToString();
            this.JSMRISKCASE.Text = _dt.Rows[0]["JSMRISKCASE"].ToString();
            this.JSMSELFNAME1.Text = _dt.Rows[0]["JSMSELFNAME1"].ToString();
            this.JSMSELFTEXT1.Text = _dt.Rows[0]["JSMSELFTEXT1"].ToString();
            this.JSMSELFNAME2.Text = _dt.Rows[0]["JSMSELFNAME2"].ToString();
            this.JSMSELFTEXT2.Text = _dt.Rows[0]["JSMSELFTEXT2"].ToString();
            this.JSMSELFNAME3.Text = _dt.Rows[0]["JSMSELFNAME3"].ToString();
            this.JSMSELFTEXT3.Text = _dt.Rows[0]["JSMSELFTEXT3"].ToString();
            this.JSMSELFNAME4.Text = _dt.Rows[0]["JSMSELFNAME4"].ToString();
            this.JSMSELFTEXT4.Text = _dt.Rows[0]["JSMSELFTEXT4"].ToString();
            this.JSMSELFNAME5.Text = _dt.Rows[0]["JSMSELFNAME5"].ToString();
            this.JSMSELFTEXT5.Text = _dt.Rows[0]["JSMSELFTEXT5"].ToString();
            this.JSMSCOMNAME1.Text = _dt.Rows[0]["JSMSCOMNAME1"].ToString();
            this.JSMSCOMTEXT1.Text = _dt.Rows[0]["JSMSCOMTEXT1"].ToString();
            this.JSMSCOMNAME2.Text = _dt.Rows[0]["JSMSCOMNAME2"].ToString();
            this.JSMSCOMTEXT2.Text = _dt.Rows[0]["JSMSCOMTEXT2"].ToString();
            this.SANAME.Text = _sSANAME;
            this.TONAME.Text = _sTONAME;
            this.JSMSANAME.Text = _dt.Rows[0]["JSMSANAME"].ToString();
        }
        private void detail_Format(object sender, EventArgs e)
        {
            DataTable dt = this.DataSource as DataTable;

            if (dt.Rows.Count > 0)
            {
                this.PRITEMTEXT.Text = dt.Rows[iCount]["PRITEMTEXT"].ToString();
                this.PRRISKTEXT.Text = dt.Rows[iCount]["PRRISKTEXT"].ToString();
                this.PREREFORMTEXT.Text = dt.Rows[iCount]["PREREFORMTEXT"].ToString();
                this.PRTOOLTEXT.Text = dt.Rows[iCount]["PRTOOLTEXT"].ToString();

                if (dt.Rows[iCount]["PRITEMTEXT"].ToString() != "")
                {
                    this.SEQ.Text = (iNum+1).ToString();
                    if (_sImages.Length > iNum)
                    {
                        if (_sImages[Convert.ToInt32(dt.Rows[iCount]["PRITEMSEQ"])] != null)
                        {
                            System.IO.Stream stream1 = new System.IO.MemoryStream(_sImages[Convert.ToInt32(dt.Rows[iNum]["PRITEMSEQ"])]);
                            Picture.Image = Bitmap.FromStream(stream1);

                        }
                        else
                        {
                            Picture.Image = null;
                        }
                        if (_stoolImages[Convert.ToInt32(dt.Rows[iCount]["PRITEMSEQ"])] != null)
                        {
                            System.IO.Stream stream1 = new System.IO.MemoryStream(_stoolImages[Convert.ToInt32(dt.Rows[iNum]["PRITEMSEQ"])]);
                            Picturetool.Image = Bitmap.FromStream(stream1);

                        }
                        else
                        {
                            Picturetool.Image = null;
                        }
                    }
                    iNum++;
                }
                else
                {
                    this.SEQ.Text = "";
                    Picture.Image = null;
                    Picturetool.Image = null;
                }

                if (dt.Rows.Count > iCount + 1)
                {
                    if (dt.Rows[iCount + 1]["PRITEMTEXT"].ToString() == "")
                    {
                        underline.X1 = 2.023F;
                    }
                }
                if (ipagenum == 1)
                {
                    if (iCount == 2)
                    {
                        this.detail.NewPage = NewPage.Before;
                        ipagenum++;
                    }
                    else
                    {
                        this.detail.NewPage = NewPage.None;
                    }
                    if (iCount + 1 == 2)
                    {
                        underline.X1 = 0;
                    }
                }
                else
                {
                    if (irowCount == 6)
                    {
                        this.detail.NewPage = NewPage.Before;
                        irowCount = 0;
                    }
                    else
                    {
                        this.detail.NewPage = NewPage.None;
                    }
                    if (irowCount + 1 == 6)
                    {
                        underline.X1 = 0;
                    }
                    irowCount++;
                }

                iCount++;
                if (dt.Rows.Count == iCount)
                {
                    this.reportFooter1.NewPage = NewPage.Before;
                }
            }
        }

        private void reportFooter1_Format(object sender, EventArgs e)
        {
            this.pageHeader1.Visible = false;
        }

        private void PSM1090_RPT_ReportEnd(object sender, EventArgs e)
        {
            if (fsPRINTNAME != "")
            {
                // 순서 바뀌면 안됨
                this.Document.Printer.PrinterName = fsPRINTNAME;
                this.Document.Printer.PrinterSettings.Copies = Convert.ToInt16(fsPRINTCNT);
                this.Document.PrintOptions.PageScaling = GrapeCity.ActiveReports.Extensibility.Printing.PageScaling.ShrinkToPrintableArea;
                this.Document.Print(false, false, false);
            }
        }
    }
}
