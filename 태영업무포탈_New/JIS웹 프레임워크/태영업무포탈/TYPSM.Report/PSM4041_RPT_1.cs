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
    /// Summary description for PSM4041_RPT_1.
    /// </summary>
    public partial class PSM4041_RPT_1 : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = null;
        private DataTable _dt2 = null;
        private DataTable[] _dt3 = null;
        private DataTable[] _dt4 = null;
        private byte[][] _sign1 = null;
        private byte[][] _sign2 = null;
        private byte[][] _sign3 = null;
        private byte[][] _sign4 = null;
        private int iCount = 0;
        private int iFirst = 0;
        private string[] _sSEQ = null;
        int iPageNum = 0;
        string _sSSORAPPDATE = string.Empty;
        string _sSSORSEQ = string.Empty;

        private string _CMWKTEAM = string.Empty;
        private string _CMWKDATE = string.Empty;
        private string _CMWKSEQ = string.Empty;
        private string _SMWKORAPPDATE = string.Empty;
        private string _SMWKORSEQ = string.Empty;
        string[] _WORKChecked;
        private string _PRINTNAME = string.Empty;
        private string _PRINTCNT = string.Empty;

        string fsGUBUN = string.Empty;

        public PSM4041_RPT_1(System.Collections.Specialized.NameValueCollection QueryString)
        {   
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            if (strArray.Length == 5)
            {
                ArryWk = strArray[1].Split('=');
                _CMWKTEAM = ArryWk[1].ToString();
                ArryWk = strArray[2].Split('=');
                _CMWKDATE = ArryWk[1].ToString();
                ArryWk = strArray[3].Split('=');
                _CMWKSEQ = ArryWk[1].ToString();
                ArryWk = strArray[4].Split('=');
                _WORKChecked = ArryWk[1].ToString().Split(',');

                fsGUBUN = "SAFEWORKDOC_LIST";
            }
            else if (strArray.Length == 6)
            {
                ArryWk = strArray[1].Split('=');
                _CMWKTEAM = ArryWk[1].ToString();
                ArryWk = strArray[2].Split('=');
                _CMWKDATE = ArryWk[1].ToString();
                ArryWk = strArray[3].Split('=');
                _CMWKSEQ = ArryWk[1].ToString();
                ArryWk = strArray[4].Split('=');
                _SMWKORAPPDATE = ArryWk[1].ToString();
                ArryWk = strArray[5].Split('=');
                _SMWKORSEQ = ArryWk[1].ToString();

                fsGUBUN = "SAFEWORKDOC";
            }

            UP_DataBing();
        }

        public PSM4041_RPT_1(string QueryString) // 웹 서비스 호출 용
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            _CMWKTEAM = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            _CMWKDATE = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            _CMWKSEQ = ArryWk[1].ToString();
            ArryWk = strArray[4].Split('=');
            _SMWKORAPPDATE = ArryWk[1].ToString();
            ArryWk = strArray[5].Split('=');
            _SMWKORSEQ = ArryWk[1].ToString();
            ArryWk = strArray[6].Split('=');
            _PRINTNAME = ArryWk[1].ToString();
            ArryWk = strArray[7].Split('=');
            _PRINTCNT = ArryWk[1].ToString();

            fsGUBUN = "SAFEWORKDOC";

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            if (fsGUBUN == "SAFEWORKDOC")
            {
                using (TaeYoung.Biz.PSM.PSM4040 biz = new TaeYoung.Biz.PSM.PSM4040())
                {

                    // 안전작업허가서 조회
                    ht = new Hashtable();

                    ht["P_SMWKTEAM"] = _CMWKTEAM;
                    ht["P_SMWKDATE"] = _CMWKDATE;
                    ht["P_SMWKSEQ"] = _CMWKSEQ;
                    ht["P_SMWKORAPPDATE"] = _SMWKORAPPDATE;
                    ht["P_SMWKORSEQ"] = _SMWKORSEQ;

                    DataSet ds = biz.UP_SAFEORDER_PRT(ht);

                    _dt = ds.Tables[0];

                    _dt2 = SaCode_GetData();
                    this.DataSource = _dt2;

                    _sSEQ = new string[1];
                    _sSEQ[0] = _CMWKTEAM + "-" + _CMWKDATE + "-" + _CMWKSEQ + "-" + _SMWKORAPPDATE + "-" + _SMWKORSEQ;

                    _dt3 = new DataTable[1];
                    _dt3[0] = ds.Tables[1];

                    _dt4 = new DataTable[1];

                    _sign1 = new byte[1][];
                    _sign1[0] = _dt.Rows[0]["SOIMGSIGN1"] as byte[];
                    _sign2 = new byte[1][];
                    _sign2[0] = _dt.Rows[0]["SOIMGSIGN2"] as byte[];
                    _sign3 = new byte[1][];
                    _sign3[0] = _dt.Rows[0]["SOIMGSIGN3"] as byte[];
                    _sign4 = new byte[1][];
                    _sign4[0] = _dt.Rows[0]["SOIMGSIGN4"] as byte[];
                }
            }
            else
            {

            }
        }

        #region Description : 안전/환경조치요구사항 가져오기
        private DataTable SaCode_GetData()
        {
            Hashtable ht = new Hashtable();

            DataTable rtnValue = new DataTable();

            int i = 0;

            int iCnt = 0;
            int iCnt1 = 0;
            int iCnt2 = 0;
            int iCnt3 = 0;

            DataSet ds = new DataSet();

            using (TaeYoung.Biz.PSM.PSM4040 biz = new TaeYoung.Biz.PSM.PSM4040())
            {

                // 안전작업허가서 조회
                ht = new Hashtable();

                ht["P_SSWKTEAM"] = _CMWKTEAM;
                ht["P_SSWKDATE"] = _CMWKDATE;
                ht["P_SSWKSEQ"] = _CMWKSEQ;
                ht["P_SSORAPPDATE"] = _SMWKORAPPDATE;
                ht["P_SSORSEQ"] = _SMWKORSEQ;

                ds = biz.UP_SAFEORDER_SACODE_LIST(ht);
            }   

            if (ds.Tables[0].Rows.Count > 0)
            {
                iCnt = int.Parse(ds.Tables[0].Rows[0]["CNT"].ToString());
            }

            string[] sSACODE1 = new string[iCnt];
            string[] sSWWKNAME1 = new string[iCnt];
            string[] sSSPUBSEL1 = new string[iCnt];
            string[] sSSREVSEL1 = new string[iCnt];
            string[] sSSFIXSEL1 = new string[iCnt];

            string[] sSACODE2 = new string[iCnt];
            string[] sSWWKNAME2 = new string[iCnt];
            string[] sSSPUBSEL2 = new string[iCnt];
            string[] sSSREVSEL2 = new string[iCnt];
            string[] sSSFIXSEL2 = new string[iCnt];

            string[] sSACODE3 = new string[iCnt];
            string[] sSWWKNAME3 = new string[iCnt];
            string[] sSSPUBSEL3 = new string[iCnt];
            string[] sSSREVSEL3 = new string[iCnt];
            string[] sSSFIXSEL3 = new string[iCnt];

            for (i = 0; i < iCnt; i++)
            {
                sSACODE1[i] = "";
                sSWWKNAME1[i] = "";
                sSSPUBSEL1[i] = "N";
                sSSREVSEL1[i] = "N";
                sSSFIXSEL1[i] = "N";

                sSACODE2[i] = "";
                sSWWKNAME2[i] = "";
                sSSPUBSEL2[i] = "N";
                sSSREVSEL2[i] = "N";
                sSSFIXSEL2[i] = "N";

                sSACODE3[i] = "";
                sSWWKNAME3[i] = "";
                sSSPUBSEL3[i] = "N";
                sSSREVSEL3[i] = "N";
                sSSFIXSEL3[i] = "N";
            }



            rtnValue.Columns.Add("SACODE1");
            rtnValue.Columns.Add("SWWKNAME1");
            rtnValue.Columns.Add("SSPUBSEL1");
            rtnValue.Columns.Add("SSREVSEL1");
            rtnValue.Columns.Add("SSFIXSEL1");

            rtnValue.Columns.Add("SACODE2");
            rtnValue.Columns.Add("SWWKNAME2");
            rtnValue.Columns.Add("SSPUBSEL2");
            rtnValue.Columns.Add("SSREVSEL2");
            rtnValue.Columns.Add("SSFIXSEL2");

            rtnValue.Columns.Add("SACODE3");
            rtnValue.Columns.Add("SWWKNAME3");
            rtnValue.Columns.Add("SSPUBSEL3");
            rtnValue.Columns.Add("SSREVSEL3");
            rtnValue.Columns.Add("SSFIXSEL3");

            if (ds.Tables[1].Rows.Count > 0)
            {
                for (i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    if (ds.Tables[1].Rows[i]["CODE"].ToString().Substring(0, 1) == "1")
                    {
                        sSACODE1[iCnt1] = ds.Tables[1].Rows[i]["CODE"].ToString();
                        sSWWKNAME1[iCnt1] = ds.Tables[1].Rows[i]["NAME"].ToString();
                        sSSPUBSEL1[iCnt1] = ds.Tables[1].Rows[i]["SSPUBSEL"].ToString();
                        sSSREVSEL1[iCnt1] = ds.Tables[1].Rows[i]["SSREVSEL"].ToString();
                        sSSFIXSEL1[iCnt1] = ds.Tables[1].Rows[i]["SSFIXSEL"].ToString();

                        iCnt1++;
                    }
                    else if (ds.Tables[1].Rows[i]["CODE"].ToString().Substring(0, 1) == "2")
                    {
                        sSACODE2[iCnt2] = ds.Tables[1].Rows[i]["CODE"].ToString();
                        sSWWKNAME2[iCnt2] = ds.Tables[1].Rows[i]["NAME"].ToString();
                        sSSPUBSEL2[iCnt2] = ds.Tables[1].Rows[i]["SSPUBSEL"].ToString();
                        sSSREVSEL2[iCnt2] = ds.Tables[1].Rows[i]["SSREVSEL"].ToString();
                        sSSFIXSEL2[iCnt2] = ds.Tables[1].Rows[i]["SSFIXSEL"].ToString();

                        iCnt2++;
                    }
                    else if (ds.Tables[1].Rows[i]["CODE"].ToString().Substring(0, 1) == "3")
                    {
                        sSACODE3[iCnt3] = ds.Tables[1].Rows[i]["CODE"].ToString();
                        sSWWKNAME3[iCnt3] = ds.Tables[1].Rows[i]["NAME"].ToString();
                        sSSPUBSEL3[iCnt3] = ds.Tables[1].Rows[i]["SSPUBSEL"].ToString();
                        sSSREVSEL3[iCnt3] = ds.Tables[1].Rows[i]["SSREVSEL"].ToString();
                        sSSFIXSEL3[iCnt3] = ds.Tables[1].Rows[i]["SSFIXSEL"].ToString();

                        iCnt3++;
                    }
                }
            }

            for (i = 0; i < iCnt; i++)
            {
                rtnValue.Rows.Add(sSACODE1[i].ToString(), sSWWKNAME1[i].ToString(), sSSPUBSEL1[i].ToString(), sSSREVSEL1[i].ToString(), sSSFIXSEL1[i].ToString(),
                                    sSACODE2[i].ToString(), sSWWKNAME2[i].ToString(), sSSPUBSEL2[i].ToString(), sSSREVSEL2[i].ToString(), sSSFIXSEL2[i].ToString(),
                                    sSACODE3[i].ToString(), sSWWKNAME3[i].ToString(), sSSPUBSEL3[i].ToString(), sSSREVSEL3[i].ToString(), sSSFIXSEL3[i].ToString()
                                    );
            }

            return rtnValue;
        }
        #endregion

        private void pageHeader_Format(object sender, EventArgs e)
        {
            //this._dt2 = this.DataSource as DataTable;

            if (iPageNum > 3)
            {
                iPageNum = 3;
            }
            this.SEQ.Text = _sSEQ[iPageNum];
            if (_dt3[iPageNum].Rows.Count > 0)
            {
                for (int i = 0; i < _dt3[iPageNum].Rows.Count; i++)
                {
                    switch (_dt3[iPageNum].Rows[i]["SWWKCODE"].ToString())
                    {
                        case "01":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE1.Text = "✔";
                            }
                            break;
                        case "02":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE2.Text = "✔";
                            }
                            break;
                        case "03":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE3.Text = "✔";
                            }
                            break;
                        case "04":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE4.Text = "✔";
                            }
                            break;
                        case "05":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE5.Text = "✔";
                            }
                            break;
                        case "06":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE6.Text = "✔";
                            }
                            break;
                        case "07":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE7.Text = "✔";
                            }
                            break;
                        case "08":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE8.Text = "✔";
                            }
                            break;
                        case "09":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE9.Text = "✔";
                            }
                            break;
                        case "10":
                            if (_dt3[iPageNum].Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE10.Text = "✔";
                            }
                            break;
                    }
                }
            }


            this.C3NAME.Text = _dt.Rows[iPageNum]["C3NAME"].ToString();
            this.SMMATERTEXT2.Text = _dt.Rows[iPageNum]["SMMATERTEXT2"].ToString();
            this.SMREVTEAMNM.Text = _dt.Rows[iPageNum]["SMREVTEAMNM"].ToString();
            this.SMSUBVEND.Text = _dt.Rows[iPageNum]["SMSUBVEND"].ToString();
            this.SMWORKTITLE.Text = _dt.Rows[iPageNum]["SMWORKTITLE"].ToString();

            this.SMAREACODE1.Text = _dt.Rows[iPageNum]["SMAREACODE1NM"].ToString();
            this.SMAREACODE2.Text = _dt.Rows[iPageNum]["SMAREACODE2NM"].ToString();
            this.SMAREACODE3.Text = _dt.Rows[iPageNum]["SMAREACODE3NM"].ToString();
            this.SMAREACODE4.Text = _dt.Rows[iPageNum]["SMAREACODE4NM"].ToString();
            this.SMAREACODE5.Text = _dt.Rows[iPageNum]["SMAREACODE5NM"].ToString();

            this.SMAREATEXT1.Text = _dt.Rows[iPageNum]["SMAREATEXT1"].ToString();
            this.SMAREATEXT2.Text = _dt.Rows[iPageNum]["SMAREATEXT2"].ToString();
            this.SMAREATEXT3.Text = _dt.Rows[iPageNum]["SMAREATEXT3"].ToString();
            this.SMAREATEXT4.Text = _dt.Rows[iPageNum]["SMAREATEXT4"].ToString();
            this.SMAREATEXT5.Text = _dt.Rows[iPageNum]["SMAREATEXT5"].ToString();

            this.SMOTAPPNAME.Text = _dt.Rows[iPageNum]["SMOTAPPNAME"].ToString();
            this.SMORNAME.Text = _dt.Rows[iPageNum]["SMORNAME"].ToString();
            this.SMGRNAME.Text = _dt.Rows[iPageNum]["SMGRNAME"].ToString();
            this.SMCONAME.Text = _dt.Rows[iPageNum]["SMCONAME"].ToString();
            this.SMSMNAME.Text = _dt.Rows[iPageNum]["SMSMNAME"].ToString();
            this.SMFSNAME.Text = _dt.Rows[iPageNum]["SMFSNAME"].ToString();

            if (_dt.Rows[iPageNum]["SMWKMETHOD"].ToString() == "1")
            {
                this.SMWKMETHOD1.Text = "✔";
            }
            else if (_dt.Rows[iPageNum]["SMWKMETHOD"].ToString() == "2")
            {
                this.SMWKMETHOD2.Text = "✔";
            }
            else if (_dt.Rows[iPageNum]["SMWKMETHOD"].ToString() == "3")
            {
                this.SMWKMETHOD3.Text = "✔";
            }

            this.SMSUBPERSON.Text = _dt.Rows[iPageNum]["SMSUBPERSON"].ToString();
            this.SMSUBTEL.Text = _dt.Rows[iPageNum]["SMSUBTEL"].ToString();
            this.SMWKMAN.Text = _dt.Rows[iPageNum]["SMWKMAN"].ToString();

            string sDATE1 = UP_getDay(Convert.ToDateTime(_dt.Rows[iPageNum]["SMTADATE1"].ToString().Substring(0, 4) + "/" + _dt.Rows[iPageNum]["SMTADATE1"].ToString().Substring(4, 2) + "/" + _dt.Rows[iPageNum]["SMTADATE1"].ToString().Substring(6, 2)));
            string sDATE2 = UP_getDay(Convert.ToDateTime(_dt.Rows[iPageNum]["SMTADATE2"].ToString().Substring(0, 4) + "/" + _dt.Rows[iPageNum]["SMTADATE2"].ToString().Substring(4, 2) + "/" + _dt.Rows[iPageNum]["SMTADATE2"].ToString().Substring(6, 2)));

            string sSMTADATE1 = _dt.Rows[iPageNum]["SMTADATE1"].ToString().Substring(0, 4) + "년　" + _dt.Rows[iPageNum]["SMTADATE1"].ToString().Substring(4, 2) + "월　" + _dt.Rows[iPageNum]["SMTADATE1"].ToString().Substring(6, 2) + "일　" + sDATE1 + "요일";
            string sSMTADATE2 = _dt.Rows[iPageNum]["SMTADATE2"].ToString().Substring(0, 4) + "년　" + _dt.Rows[iPageNum]["SMTADATE2"].ToString().Substring(4, 2) + "월　" + _dt.Rows[iPageNum]["SMTADATE2"].ToString().Substring(6, 2) + "일　" + sDATE2 + "요일";

            this.SMTATIME1.Text = _dt.Rows[iPageNum]["SMTATIME1_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMTATIME1_MM"].ToString();
            this.SMTATIME2.Text = _dt.Rows[iPageNum]["SMTATIME2_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMTATIME2_MM"].ToString();

            this.SMTADATE1.Text = sSMTADATE1;
            this.SMTADATE2.Text = sSMTADATE2;

            if (_dt.Rows[iPageNum]["SMNOTE_BURN"].ToString() == "Y")
            {
                this.SMNOTE_BURN.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_SUFF"].ToString() == "Y")
            {
                this.SMNOTE_SUFF.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_ELE"].ToString() == "Y")
            {
                this.SMNOTE_ELE.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_FIR"].ToString() == "Y")
            {
                this.SMNOTE_FIR.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_EXP"].ToString() == "Y")
            {
                this.SMNOTE_EXP.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_DROP"].ToString() == "Y")
            {
                this.SMNOTE_DROP.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_LEAK"].ToString() == "Y")
            {
                this.SMNOTE_LEAK.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_NARR"].ToString() == "Y")
            {
                this.SMNOTE_NARR.Text = "✔";
            }
            if (_dt.Rows[iPageNum]["SMNOTE_COLL"].ToString() == "Y")
            {
                this.SMNOTE_COLL.Text = "✔";
            }

            if (_dt.Rows[iPageNum]["SMORAPPDATE"].ToString() != "")
            {
                SIGN1.Visible = true;
                System.IO.Stream stream1 = new System.IO.MemoryStream(_sign1[iPageNum]);
                SIGN1.Image = Bitmap.FromStream(stream1);
            }
            else
            {
                SIGN1.Visible = false;
            }
            if (_dt.Rows[iPageNum]["SMGRAPPDATE"].ToString() != "")
            {
                SIGN2.Visible = true;
                System.IO.Stream stream2 = new System.IO.MemoryStream(_sign2[iPageNum]);
                SIGN2.Image = Bitmap.FromStream(stream2);
            }
            else
            {
                SIGN2.Visible = false;
            }
            if (_dt.Rows[iPageNum]["SMCOAPPDATE"].ToString() != "")
            {
                SIGN3.Visible = true;
                System.IO.Stream stream3 = new System.IO.MemoryStream(_sign3[iPageNum]);
                SIGN3.Image = Bitmap.FromStream(stream3);
            }
            else
            {
                SIGN3.Visible = false;
            }
            if (_dt.Rows[iPageNum]["SMSMAPPDATE"].ToString() != "")
            {
                SIGN4.Visible = true;
                System.IO.Stream stream4 = new System.IO.MemoryStream(_sign4[iPageNum]);
                SIGN4.Image = Bitmap.FromStream(stream4);
            }
            else
            {
                SIGN4.Visible = false;
            }
            if (_dt.Rows[iPageNum]["SMOTTIME1_HH"].ToString() != "")
            {
                this.SMODATE.Text = _dt.Rows[iPageNum]["SMOTTIME1_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMOTTIME1_MM"].ToString() + "~" + _dt.Rows[iPageNum]["SMOTTIME2_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMOTTIME2_MM"].ToString();
            }
            
            if (_dt.Rows[iPageNum]["SMFSTIME"].ToString() != "")
            {
                this.SMFSDATE.Text = _dt.Rows[iPageNum]["SMFSTIME"].ToString().Substring(0, 2) + ":" + _dt.Rows[iPageNum]["SMFSTIME"].ToString().Substring(2, 2) + ":" + _dt.Rows[iPageNum]["SMFSTIME"].ToString().Substring(4, 2);
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME1_HH"].ToString() != "")
            {
                this.SMCHKTIME1.Text = _dt.Rows[iPageNum]["SMCHKTIME1_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME1_MM"].ToString();
            }
            this.SMCHKOXYGEN1.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN1"].ToString();
            this.SMCHKOXYGENUNIT1.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT1"].ToString());
            this.SMCHKTOXNUM1.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM1"].ToString();
            this.SMCHKTOXGUBN1.Text = _dt.Rows[iPageNum]["SMCHKTOXGUBN1"].ToString();
            this.SMCHKTOXUNIT1.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT1"].ToString());
            this.SMCHKNAME1.Text = _dt.Rows[iPageNum]["SMCHKNAME1"].ToString();

            if (_dt.Rows[iPageNum]["SMCHKTIME2_HH"].ToString() != "")
            {
                this.SMCHKTIME2.Text = _dt.Rows[iPageNum]["SMCHKTIME2_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME2_MM"].ToString();
            }
            this.SMCHKOXYGEN2.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN2"].ToString();
            this.SMCHKOXYGENUNIT2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT2"].ToString());
            this.SMCHKTOXNUM2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM2"].ToString();
            this.SMCHKTOXGUBN2.Text = _dt.Rows[iPageNum]["SMCHKTOXGUBN2"].ToString();
            this.SMCHKTOXUNIT2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT2"].ToString());
            this.SMCHKNAME2.Text = _dt.Rows[iPageNum]["SMCHKNAME2"].ToString();

            if (_dt.Rows[iPageNum]["SMCHKTIME3_HH"].ToString() != "")
            {
                this.SMCHKTIME3.Text = _dt.Rows[iPageNum]["SMCHKTIME3_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME3_MM"].ToString();
            }
            this.SMCHKOXYGEN3.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN3"].ToString();
            this.SMCHKOXYGENUNIT3.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT3"].ToString());
            this.SMCHKTOXNUM3.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM3"].ToString();
            this.SMCHKTOXGUBN3.Text = _dt.Rows[iPageNum]["SMCHKTOXGUBN3"].ToString();
            this.SMCHKTOXUNIT3.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT3"].ToString());
            this.SMCHKNAME3.Text = _dt.Rows[iPageNum]["SMCHKNAME3"].ToString();

            if (_dt.Rows[iPageNum]["SMCHKTIME4_HH"].ToString() != "")
            {
                this.SMCHKTIME4.Text = _dt.Rows[iPageNum]["SMCHKTIME4_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME4_MM"].ToString();
            }
            this.SMCHKOXYGEN4.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN4"].ToString();
            this.SMCHKOXYGENUNIT4.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT4"].ToString());
            this.SMCHKTOXNUM4.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM4"].ToString();
            this.SMCHKTOXGUBN4.Text = _dt.Rows[iPageNum]["SMCHKTOXGUBN4"].ToString();
            this.SMCHKTOXUNIT4.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT4"].ToString());
            this.SMCHKNAME4.Text = _dt.Rows[iPageNum]["SMCHKNAME4"].ToString();

            if (_dt.Rows[iPageNum]["SMCHKTIME5_HH"].ToString() != "")
            {
                this.SMCHKTIME5.Text = _dt.Rows[iPageNum]["SMCHKTIME5_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME5_MM"].ToString();
            }
            this.SMCHKOXYGEN5.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN5"].ToString();
            this.SMCHKOXYGENUNIT5.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT5"].ToString());
            this.SMCHKTOXNUM5.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM5"].ToString();
            this.SMCHKTOXGUBN5.Text = _dt.Rows[iPageNum]["SMCHKTOXGUBN5"].ToString();
            this.SMCHKTOXUNIT5.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT5"].ToString());
            this.SMCHKNAME5.Text = _dt.Rows[iPageNum]["SMCHKNAME5"].ToString();

            if (_dt.Rows[iPageNum]["SMCHKTIME6_HH"].ToString() != "")
            {
                this.SMCHKTIME6.Text = _dt.Rows[iPageNum]["SMCHKTIME6_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME6_MM"].ToString();
            }
            this.SMCHKOXYGEN6.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN6"].ToString();
            this.SMCHKOXYGENUNIT6.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT6"].ToString());
            this.SMCHKTOXNUM6.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM6"].ToString();
            this.SMCHKTOXGUBN6.Text = _dt.Rows[iPageNum]["SMCHKTOXGUBN6"].ToString();
            this.SMCHKTOXUNIT6.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT6"].ToString());
            this.SMCHKNAME6.Text = _dt.Rows[iPageNum]["SMCHKNAME6"].ToString();

            SMORDERTEXT1.Text = _dt.Rows[iPageNum]["SMORDERTEXT1"].ToString();

            string temp = string.Empty;
            //for (int i = 0; i < _dt4[iPageNum].Rows.Count; i++)
            //{
            //    if (temp.Length > 0)
            //    {
            //        temp += ", ";
            //    }
            //    temp += _dt4[iPageNum].Rows[0]["AFFILENAME"].ToString();
            //}
            this.FILENAME.Text = temp;
        }
        private string UP_getDay(DateTime dt)
        {
            string day = string.Empty;

            var temp = dt.DayOfWeek;

            switch (temp)
            {
                case DayOfWeek.Monday:
                    day = "월";
                    break;
                case DayOfWeek.Tuesday:
                    day = "화";
                    break;
                case DayOfWeek.Wednesday:
                    day = "수";
                    break;
                case DayOfWeek.Thursday:
                    day = "목";
                    break;
                case DayOfWeek.Friday:
                    day = "금";
                    break;
                case DayOfWeek.Saturday:
                    day = "토";
                    break;
                case DayOfWeek.Sunday:
                    day = "일";
                    break;
            }
            return day;
        }

        private void detail_Format(object sender, EventArgs e)
        {
            
            
            if (_dt2.Rows[iCount]["SWWKNAME1"].ToString() != "")
            {
                this.SEL11.Text = "○";
                this.SEL12.Text = "○";
                this.SEL13.Text = "○";

                if (_dt2.Rows[iCount]["SSPUBSEL1"].ToString() == "Y")
                {
                    this.SSPUBSEL1.Text = "✔";
                }
                else
                {
                    this.SSPUBSEL1.Text = "";
                }
                if (_dt2.Rows[iCount]["SSREVSEL1"].ToString() == "Y")
                {
                    this.SSREVSEL1.Text = "✔";
                }
                else
                {
                    this.SSREVSEL1.Text = "";
                }
                if (_dt2.Rows[iCount]["SSFIXSEL1"].ToString() == "Y")
                {
                    this.SSFIXSEL1.Text = "✔";
                }
                else
                {
                    this.SSFIXSEL1.Text = "";
                }
            }
            else
            {
                this.SEL11.Text = "";
                this.SEL12.Text = "";
                this.SEL13.Text = "";
                this.SSPUBSEL1.Text = "";
                this.SSREVSEL1.Text = "";
                this.SSFIXSEL1.Text = "";
            }

            if (_dt2.Rows[iCount]["SWWKNAME2"].ToString() != "")
            {
                this.SEL21.Text = "○";
                this.SEL22.Text = "○";
                this.SEL23.Text = "○";

                if (_dt2.Rows[iCount]["SSPUBSEL2"].ToString() == "Y")
                {
                    this.SSPUBSEL2.Text = "✔";
                }
                else
                {
                    this.SSPUBSEL2.Text = "";
                }
                if (_dt2.Rows[iCount]["SSREVSEL2"].ToString() == "Y")
                {
                    this.SSREVSEL2.Text = "✔";
                }
                else
                {
                    this.SSREVSEL2.Text = "";
                }
                if (_dt2.Rows[iCount]["SSFIXSEL2"].ToString() == "Y")
                {
                    this.SSFIXSEL2.Text = "✔";
                }
                else
                {
                    this.SSFIXSEL2.Text = "";
                }

            }
            else
            {
                this.SEL21.Text = "";
                this.SEL22.Text = "";
                this.SEL23.Text = "";
                this.SSPUBSEL2.Text = "";
                this.SSREVSEL2.Text = "";
                this.SSFIXSEL2.Text = "";
            }

            if (_dt2.Rows[iCount]["SWWKNAME3"].ToString() != "")
            {
                this.SEL31.Text = "○";
                this.SEL32.Text = "○";
                this.SEL33.Text = "○";
                if (_dt2.Rows[iCount]["SSPUBSEL3"].ToString() == "Y")
                {
                    this.SSPUBSEL3.Text = "✔";
                }
                else
                {
                    this.SSPUBSEL3.Text = "";
                }
                if (_dt2.Rows[iCount]["SSREVSEL3"].ToString() == "Y")
                {
                    this.SSREVSEL3.Text = "✔";
                }
                else
                {
                    this.SSREVSEL3.Text = "";
                }
                if (_dt2.Rows[iCount]["SSFIXSEL3"].ToString() == "Y")
                {
                    this.SSFIXSEL3.Text = "✔";
                }
                else
                {
                    this.SSFIXSEL3.Text = "";
                }
            }
            else
            {
                this.SEL31.Text = "";
                this.SEL32.Text = "";
                this.SEL33.Text = "";
                this.SSPUBSEL3.Text = "";
                this.SSREVSEL3.Text = "";
                this.SSFIXSEL3.Text = "";
            }
            if(fsGUBUN != "SAFEWORKDOC")
            { 
                if (iCount == 0)
                {
                    _sSSORAPPDATE = _dt2.Rows[iCount]["SSORAPPDATE1"].ToString();
                    _sSSORSEQ = _dt2.Rows[iCount]["SSORSEQ1"].ToString();
                }
                else
                {
                    if (_sSSORSEQ != _dt2.Rows[iCount]["SSORSEQ1"].ToString() || _sSSORAPPDATE != _dt2.Rows[iCount]["SSORAPPDATE1"].ToString())
                    {
                        this.detail.NewPage = NewPage.Before;
                        _sSSORAPPDATE = _dt2.Rows[iCount]["SSORAPPDATE1"].ToString();
                        _sSSORSEQ = _dt2.Rows[iCount]["SSORSEQ1"].ToString();
                        iPageNum++;
                    }
                    else
                    {
                        this.detail.NewPage = NewPage.None;
                    }
                }
            }

            iCount++;
        }
        private string UP_UnitConvert(string sUnit)
        {
            string sRtn = string.Empty;

            if (sUnit == "1")
            {
                sRtn = "%";
            }
            else if (sUnit == "2")
            {
                sRtn = "ppm";
            }

            return sRtn;
        }

        private void PSM4041_RPT_1_ReportEnd(object sender, EventArgs e)
        {
            if (_PRINTNAME != "")
            {
                // 순서 바뀌면 안됨
                this.Document.Printer.PrinterName = _PRINTNAME;
                this.Document.Printer.PrinterSettings.Copies = Convert.ToInt16(_PRINTCNT);
                this.Document.PrintOptions.PageScaling = GrapeCity.ActiveReports.Extensibility.Printing.PageScaling.ShrinkToPrintableArea;
                this.Document.Print(false, false, false);
            }
        }
    }
}
