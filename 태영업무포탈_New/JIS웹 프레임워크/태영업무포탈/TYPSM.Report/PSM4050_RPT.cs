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
using System.Data;

namespace TYPSM.Report
{
    /// <summary>
    /// Summary description for PSM4050_RPT.
    /// </summary>
    public partial class PSM4050_RPT : GrapeCity.ActiveReports.SectionReport
    {
        int iCount = 0;
        int iTemp = 0;
        int iNum = 1;
        int irowCount = 1;
        int ipagenum = 1;
        int iSEQ = 1;
        int iReport = 0;
        int ipagecount = 0;
        string _NUM = string.Empty;

        private string fsWKGUBN = string.Empty;
        private string fsCMWKTEAM = string.Empty;
        private string fsCMWKDATE = string.Empty;
        private string fsCMWKSEQ = string.Empty;
        private string fsSMWKORAPPDATE = string.Empty;
        private string fsSESSIONID = string.Empty;

        DataTable[] _dt = null;
        DataTable[] _dtDetail = null;
        string[] _sSANAME = null;
        string[] _sTONAME = null;
        byte[][] _sImages;
        byte[][] _stoolImages;

        public PSM4050_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            fsWKGUBN = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            fsCMWKTEAM = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            fsCMWKDATE = ArryWk[1].ToString();
            ArryWk = strArray[4].Split('=');
            fsCMWKSEQ = ArryWk[1].ToString();
            ArryWk = strArray[5].Split('=');
            fsSMWKORAPPDATE = ArryWk[1].ToString();
            ArryWk = strArray[6].Split('=');
            fsSESSIONID = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();
            DataSet ds1 = new DataSet();

            using (TaeYoung.Biz.PSM.PSM4040 biz = new TaeYoung.Biz.PSM.PSM4040())
            {
                // JSA(변경관리) MASTER LIST 조회
                ht["P_JSMWKGUBN"] = fsWKGUBN;
                ht["P_JSMPOTEAM"] = fsCMWKTEAM;
                ht["P_JSMPODATE"] = fsCMWKDATE;
                ht["P_JSMPOSEQ"] = fsCMWKSEQ;
                ht["P_JSMDATE"] = fsSMWKORAPPDATE;

                ds1 = biz.UP_JSACHANGE_MASTER_LIST(ht);

                _dt = new DataTable[ds1.Tables[0].Rows.Count];
                _dtDetail = new DataTable[ds1.Tables[0].Rows.Count];
                _sSANAME = new string[ds1.Tables[0].Rows.Count];
                _sTONAME = new string[ds1.Tables[0].Rows.Count];
            }

            for(int j = 0; j < ds1.Tables[0].Rows.Count; j++)
            { 
                using (TaeYoung.Biz.PSM.PSM4045 biz = new TaeYoung.Biz.PSM.PSM4045())
                {
                    // JSA(변경관리) MASTER 조회
                    ht["P_JSMWKGUBN"] = fsWKGUBN;
                    ht["P_JSMPOTEAM"] = fsCMWKTEAM;
                    ht["P_JSMPODATE"] = fsCMWKDATE;
                    ht["P_JSMPOSEQ"] = fsCMWKSEQ;
                    ht["P_JSMDATE"] = fsSMWKORAPPDATE;
                    ht["P_JSMMSEQ"] = ds1.Tables[0].Rows[j]["JSMMSEQ"].ToString();
                    ht["P_JSMBLASS"] = ds1.Tables[0].Rows[j]["JSMBLASS"].ToString();
                    ht["P_JSMMLASS"] = ds1.Tables[0].Rows[j]["JSMMLASS"].ToString();
                    ht["P_JSMSLASS"] = ds1.Tables[0].Rows[j]["JSMSLASS"].ToString();
                    ht["P_JSMSEQ"] = ds1.Tables[0].Rows[j]["JSMSEQ"].ToString();

                    DataSet ds = biz.UP_JSACHANGE_MASTER_RUN(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        _dt[j] = ds.Tables[0];
                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                _sSANAME[j] = ds.Tables[1].Rows[i]["NAME"].ToString();
                            }
                            else
                            {
                                _sSANAME[j] = _sSANAME[j] + ", " + ds.Tables[1].Rows[i]["NAME"].ToString();
                            }
                        }
                    }
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                _sTONAME[j] = ds.Tables[2].Rows[i]["NAME"].ToString();
                            }
                            else
                            {
                                _sTONAME[j] = _sTONAME[j] + ", " + ds.Tables[2].Rows[i]["NAME"].ToString();
                            }
                        }
                    }

                    // JSA(변경관리) DETAIL 조회
                    ht = new Hashtable();

                    ht["P_SESSIONID"] = fsSESSIONID;
                    ht["P_JSMWKGUBN"] = fsWKGUBN;
                    ht["P_JSMPOTEAM"] = fsCMWKTEAM;
                    ht["P_JSMPODATE"] = fsCMWKDATE;
                    ht["P_JSMPOSEQ"] = fsCMWKSEQ;
                    ht["P_JSMDATE"] = fsSMWKORAPPDATE;
                    ht["P_JSMMSEQ"] = ds1.Tables[0].Rows[j]["JSMMSEQ"].ToString();
                    ht["P_JSMBLASS"] = ds1.Tables[0].Rows[j]["JSMBLASS"].ToString();
                    ht["P_JSMMLASS"] = ds1.Tables[0].Rows[j]["JSMMLASS"].ToString();
                    ht["P_JSMSLASS"] = ds1.Tables[0].Rows[j]["JSMSLASS"].ToString();
                    ht["P_JSMSEQ"] = ds1.Tables[0].Rows[j]["JSMSEQ"].ToString();
                    ht["P_SABUN"] = "";
                    ht["P_GUBUN"] = "P";

                    ds = biz.UP_JSACHANGE_PRT_LIST(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        _dtDetail[j] = ds.Tables[0];

                        _sImages = new byte[Convert.ToInt32(ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["PRITEMSEQ"]) + 1][];
                        _stoolImages = new byte[Convert.ToInt32(ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["PRITEMSEQ"]) + 1][];
                    }

                    // 사진 조회
                    ht = new Hashtable();
                    ht["P_JSMWKGUBN"] = fsWKGUBN;
                    ht["P_JSMPOTEAM"] = fsCMWKTEAM;
                    ht["P_JSMPODATE"] = fsCMWKDATE;
                    ht["P_JSMPOSEQ"] = fsCMWKSEQ;
                    ht["P_JSMDATE"] = fsSMWKORAPPDATE;
                    ht["P_JSMMSEQ"] = ds1.Tables[0].Rows[j]["JSMMSEQ"].ToString(); 
                    ht["P_JSMBLASS"] = ds1.Tables[0].Rows[j]["JSMBLASS"].ToString();
                    ht["P_JSMMLASS"] = ds1.Tables[0].Rows[j]["JSMMLASS"].ToString();
                    ht["P_JSMSLASS"] = ds1.Tables[0].Rows[j]["JSMSLASS"].ToString();
                    ht["P_JSMSEQ"] = ds1.Tables[0].Rows[j]["JSMSEQ"].ToString();

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

            if(ds1.Tables[0].Rows.Count > 0)
            { 
                this.DataSource = UP_DataSet_Change(ds1);
            }
            else
            {
                this.DataSource = new DataTable();
            }
        }

        private DataTable UP_DataSet_Change(DataSet ds)
        {
            DataTable rtnValue = new DataTable();

            rtnValue.Columns.Add("GUBN");
            rtnValue.Columns.Add("JSMDATE");
            rtnValue.Columns.Add("JSMMSEQ");
            rtnValue.Columns.Add("PRBLASS");

            rtnValue.Columns.Add("PRMLASS");
            rtnValue.Columns.Add("PRSLASS");
            rtnValue.Columns.Add("PRSEQ");

            rtnValue.Columns.Add("PRITEMSEQ");
            rtnValue.Columns.Add("PRITEMTEXT");
            rtnValue.Columns.Add("PRTOOLTEXT");

            rtnValue.Columns.Add("PRRSUBSEQ");
            rtnValue.Columns.Add("PRRISKTEXT");
            rtnValue.Columns.Add("PRESUBSEQ");

            rtnValue.Columns.Add("PREREFORMTEXT");

            rtnValue.Columns.Add("PRRISKCNT");
            rtnValue.Columns.Add("PRRISKSOLID");
            rtnValue.Columns.Add("PRRISKDEGREE");

            rtnValue.Columns.Add("PREREFORMCNT");
            rtnValue.Columns.Add("PREREFORMSOLID");
            rtnValue.Columns.Add("PREREFORMDEGREE");

            string sGUBN = string.Empty;
            for (int iCount = 0; iCount < _dtDetail.Length; iCount++)
            {
                if (_dtDetail[iCount] != null)
                {
                    for (int i = 0; i < _dtDetail[iCount].Rows.Count; i++)
                    {
                        if (i + 1 == 1)
                        {
                            sGUBN = i.ToString();
                        }
                        else if (i + 1 == 3)
                        {
                            sGUBN = i.ToString();
                        }
                        else if ((i - 2) % 6 == 0 && i > 6)
                        {
                            sGUBN = i.ToString();
                        }

                        rtnValue.Rows.Add(sGUBN, ds.Tables[0].Rows[iCount]["JSMDATE"].ToString(), ds.Tables[0].Rows[iCount]["JSMMSEQ"].ToString(), _dtDetail[iCount].Rows[i]["PRBLASS"].ToString(),
                                            _dtDetail[iCount].Rows[i]["PRMLASS"].ToString(), _dtDetail[iCount].Rows[i]["PRSLASS"].ToString(), _dtDetail[iCount].Rows[i]["PRSEQ"].ToString(),
                                            _dtDetail[iCount].Rows[i]["PRITEMSEQ"].ToString(), _dtDetail[iCount].Rows[i]["PRITEMTEXT"].ToString(), _dtDetail[iCount].Rows[i]["PRTOOLTEXT"].ToString(),
                                            _dtDetail[iCount].Rows[i]["PRRSUBSEQ"].ToString(), _dtDetail[iCount].Rows[i]["PRRISKTEXT"].ToString(), _dtDetail[iCount].Rows[i]["PRESUBSEQ"].ToString(),
                                            _dtDetail[iCount].Rows[i]["PREREFORMTEXT"].ToString(), _dtDetail[iCount].Rows[i]["PRRISKCNT"].ToString(), _dtDetail[iCount].Rows[i]["PRRISKSOLID"].ToString(),
                                            _dtDetail[iCount].Rows[i]["PRRISKDEGREE"].ToString(), _dtDetail[iCount].Rows[i]["PREREFORMCNT"].ToString(), _dtDetail[iCount].Rows[i]["PREREFORMSOLID"].ToString(),
                                            _dtDetail[iCount].Rows[i]["PREREFORMDEGREE"].ToString());
                        
                    }
                }
            }            

            return rtnValue;
        }

        private void pageHeader_Format(object sender, EventArgs e)
        {
            DataTable dt = this.DataSource as DataTable;

            if (_dt[iReport] != null)
            {
                if (_dt[iReport].Rows.Count > 0)
                {
                    if (_dt[iReport].Rows[0]["JSMPODATE"].ToString() != "")
                    {
                        this.JSMPODATE.Text = _dt[iReport].Rows[0]["JSMPODATE"].ToString().Substring(0, 4) + "-" + _dt[iReport].Rows[0]["JSMPODATE"].ToString().Substring(4, 2) + "-" + _dt[iReport].Rows[0]["JSMPODATE"].ToString().Substring(6, 2);
                    }
                    else
                    {
                        this.JSMPODATE.Text = "";
                    }
                    if (pageHeader.Visible == true)
                    {
                        ipagecount = 0;
                    }
                    if (_dt[iReport] != null)
                    {
                        this.JSMWKNAME.Text = _dt[iReport].Rows[0]["JSMWKNAME"].ToString();
                        this.JSMSYSTEM.Text = _dt[iReport].Rows[0]["JSMSYSTEM"].ToString();
                        this.JSMWKDATE.Text = _dt[iReport].Rows[0]["JSMWKDATE"].ToString().Substring(0, 4) + "-" + _dt[iReport].Rows[0]["JSMWKDATE"].ToString().Substring(4, 2) + "-" + _dt[iReport].Rows[0]["JSMWKDATE"].ToString().Substring(6, 2);
                        this.JSMADDATE.Text = _dt[iReport].Rows[0]["JSMADDATE"].ToString().Substring(0, 4) + "-" + _dt[iReport].Rows[0]["JSMADDATE"].ToString().Substring(4, 2) + "-" + _dt[iReport].Rows[0]["JSMADDATE"].ToString().Substring(6, 2);
                        this.JSMADCHASU.Text = _dt[iReport].Rows[0]["JSMADCHASU"].ToString();
                        this.JSMSECTIONNUM.Text = _dt[iReport].Rows[0]["JSMSECTIONNUM"].ToString();
                        this.JSMMSDSCODE.Text = _dt[iReport].Rows[0]["JSMMSDSCODE"].ToString();
                        this.JSMWKSABUN.Text = _dt[iReport].Rows[0]["JSMWKSABUNNM"].ToString();
                        this.JSMWKSUMMARY.Text = _dt[iReport].Rows[0]["JSMWKSUMMARY"].ToString();
                        this.JSMNEEDDATA.Text = _dt[iReport].Rows[0]["JSMNEEDDATA"].ToString();
                        this.JSMRISKCASE.Text = _dt[iReport].Rows[0]["JSMRISKCASE"].ToString();
                        this.JSMSELFNAME1.Text = _dt[iReport].Rows[0]["JSMSELFNAME1"].ToString();
                        this.JSMSELFTEXT1.Text = _dt[iReport].Rows[0]["JSMSELFTEXT1"].ToString();
                        this.JSMSELFNAME2.Text = _dt[iReport].Rows[0]["JSMSELFNAME2"].ToString();
                        this.JSMSELFTEXT2.Text = _dt[iReport].Rows[0]["JSMSELFTEXT2"].ToString();
                        this.JSMSELFNAME3.Text = _dt[iReport].Rows[0]["JSMSELFNAME3"].ToString();
                        this.JSMSELFTEXT3.Text = _dt[iReport].Rows[0]["JSMSELFTEXT3"].ToString();
                        this.JSMSELFNAME4.Text = _dt[iReport].Rows[0]["JSMSELFNAME4"].ToString();
                        this.JSMSELFTEXT4.Text = _dt[iReport].Rows[0]["JSMSELFTEXT4"].ToString();
                        this.JSMSELFNAME5.Text = _dt[iReport].Rows[0]["JSMSELFNAME5"].ToString();
                        this.JSMSELFTEXT5.Text = _dt[iReport].Rows[0]["JSMSELFTEXT5"].ToString();
                        this.JSMSCOMNAME1.Text = _dt[iReport].Rows[0]["JSMSCOMNAME1"].ToString();
                        this.JSMSCOMTEXT1.Text = _dt[iReport].Rows[0]["JSMSCOMTEXT1"].ToString();
                        this.JSMSCOMNAME2.Text = _dt[iReport].Rows[0]["JSMSCOMNAME2"].ToString();
                        this.JSMSCOMTEXT2.Text = _dt[iReport].Rows[0]["JSMSCOMTEXT2"].ToString();
                        this.SANAME.Text = _sSANAME[iReport];
                        this.TONAME.Text = _sTONAME[iReport];
                        this.JSMSANAME.Text = _dt[iReport].Rows[0]["JSMSANAME"].ToString();
                    }
                    ipagecount++;
                }
            }
        }

        private void detail_Format(object sender, EventArgs e)
        {
            DataTable dt = this.DataSource as DataTable;

            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    this.PRITEMTEXT.Text = dt.Rows[iCount]["PRITEMTEXT"].ToString();
                    this.PRRISKTEXT.Text = dt.Rows[iCount]["PRRISKTEXT"].ToString();
                    this.PREREFORMTEXT.Text = dt.Rows[iCount]["PREREFORMTEXT"].ToString();
                    this.PRTOOLTEXT.Text = dt.Rows[iCount]["PRTOOLTEXT"].ToString();


                    if (iCount > 1)
                    {
                        if (dt.Rows[iCount - 1]["JSMDATE"].ToString() != dt.Rows[iCount]["JSMDATE"].ToString() || dt.Rows[iCount - 1]["JSMMSEQ"].ToString() != dt.Rows[iCount]["JSMMSEQ"].ToString())
                        {
                            iSEQ = 1;
                            iReport++;
                        }
                    }
                    if (dt.Rows[iCount]["PRITEMTEXT"].ToString() != "")
                    {
                        this.SEQ.Text = iSEQ.ToString();
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
                        iSEQ++;
                    }
                    else
                    {
                        this.SEQ.Text = "";
                        Picture.Image = null;
                        Picturetool.Image = null;
                    }

                    //if (_sImages.Length > iCount + 1)
                    if (dt.Rows.Count > iCount + 1)
                    {
                        if (dt.Rows[iCount + 1]["PRITEMTEXT"].ToString() == "")
                        {
                            underline.X2 = 2.023F;
                        }
                    }

                    if (ipagenum == 1)
                    {
                        if (iTemp == 1)
                        {
                            this.detail.NewPage = NewPage.Before;
                            this.pageHeader.Visible = false;
                            ipagenum++;
                        }
                        else
                        {
                            this.detail.NewPage = NewPage.None;
                        }
                        if (iTemp + 1 == 2)
                        {
                            underline.X2 = 0;
                        }
                    }
                    else
                    {
                        if (irowCount == 6)
                        {
                            underline.X2 = 0;
                            this.detail.NewPage = NewPage.Before;
                            irowCount = 0;
                        }
                        else
                        {
                            this.detail.NewPage = NewPage.None;
                        }
                        //if (irowCount + 1 == 6)
                        //{
                        //    underline.X2 = 0;
                        //}
                        irowCount++;
                    }

                    if (iCount > 0)
                    {
                        if (iCount + 1 < dt.Rows.Count)
                        {
                            if (dt.Rows[iCount + 1]["JSMDATE"].ToString() != dt.Rows[iCount]["JSMDATE"].ToString() || dt.Rows[iCount + 1]["JSMMSEQ"].ToString() != dt.Rows[iCount]["JSMMSEQ"].ToString())
                            {
                                groupFooter1.Visible = true;
                            }
                            else
                            {
                                groupFooter1.Visible = false;
                            }
                        }

                        if (dt.Rows[iCount - 1]["JSMDATE"].ToString() != dt.Rows[iCount]["JSMDATE"].ToString() || dt.Rows[iCount - 1]["JSMMSEQ"].ToString() != dt.Rows[iCount]["JSMMSEQ"].ToString())
                        {
                            this.detail.NewPage = NewPage.Before;
                            pageHeader.Visible = true;
                            ipagenum = 1;
                            irowCount = 1;
                            iTemp = 0;

                        }
                        else
                        {
                            this.detail.NewPage = NewPage.None;
                        }

                    }
                    iTemp++;
                    iCount++;
                    if (iCount == dt.Rows.Count)
                    {
                        groupFooter1.Visible = true;
                    }
                }
            }
        }

        private void groupHeader1_Format(object sender, EventArgs e)
        {
            
        }

        private void groupFooter1_Format(object sender, EventArgs e)
        {
            this.groupFooter1.NewPage = NewPage.Before;
        }

        private void pageFooter_Format(object sender, EventArgs e)
        {
            this.pagenum.Text = ipagecount.ToString();
        }
    }
}
