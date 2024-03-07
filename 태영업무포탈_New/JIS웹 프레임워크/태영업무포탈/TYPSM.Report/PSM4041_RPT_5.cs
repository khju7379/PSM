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
    /// Summary description for SafeWorkDoc2017_PRT2.
    /// </summary>
    public partial class PSM4041_RPT_5 : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = null;
        private DataTable _dt2 = null;
        private DataTable[] _dt3 = null;
        private DataTable[] _dt4 = null;
        private DataTable[] _dt5 = null;
        private DataTable[] _dt6 = null;
        private byte[][] _sign1 = null;
        private byte[][] _sign2 = null;
        private byte[][] _sign3 = null;
        private byte[][] _sign4 = null;
        private byte[][] _sign5 = null;
        private int iCount = 0;
        private int iFirst = 0;
        private string[] _sSEQ = null;
        private int iPageNum = 0;
        private string _sSSORAPPDATE = string.Empty;
        private string _sSSORSEQ = string.Empty;

        private string _CMWKTEAM = string.Empty;
        private string _CMWKDATE = string.Empty;
        private string _CMWKSEQ = string.Empty;
        private string _SMWKORAPPDATE = string.Empty;
        private string _SMWKORSEQ = string.Empty;
        private string[] _WORKChecked;
        private string _PRINTNAME = string.Empty;
        private string _PRINTCNT = string.Empty;

        private string fsGUBUN = string.Empty;

        public PSM4041_RPT_5(System.Collections.Specialized.NameValueCollection QueryString)
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

        public PSM4041_RPT_5(string QueryString) // 웹 서비스 호출 용
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

                    _dt2 = UP_WKDatatable(1);

                    _sSEQ = new string[1];
                    _sSEQ[0] = _CMWKTEAM + "-" + _CMWKDATE + "-" + _CMWKSEQ + "-" + _SMWKORAPPDATE + "-" + _SMWKORSEQ;
                    
                    _dt3 = new DataTable[1];
                    _dt3[0] = ds.Tables[1];
                    
                    _dt5 = new DataTable[1];
                    _dt5[0] = ds.Tables[2];
                    
                    _dt6 = new DataTable[1];
                    _dt6[0] = ds.Tables[3];
                    
                    _dt4 = new DataTable[1];

                    _sign1 = new byte[1][];
                    _sign1[0] = _dt.Rows[0]["SOIMGSIGN1"] as byte[];
                    _sign2 = new byte[1][];
                    _sign2[0] = _dt.Rows[0]["SOIMGSIGN2"] as byte[];
                    _sign3 = new byte[1][];
                    _sign3[0] = _dt.Rows[0]["SOIMGSIGN3"] as byte[];
                    _sign4 = new byte[1][];
                    _sign4[0] = _dt.Rows[0]["SOIMGSIGN4"] as byte[];
                    _sign5 = new byte[1][];
                    _sign5[0] = _dt.Rows[0]["SOIMGSIGN5"] as byte[];
                }
            }
            else
            {
                
            }
        }

        private void pageHeader_Format(object sender, EventArgs e)
        {
            //this._dt2 = this.DataSource as DataTable;

            if (iPageNum > 3)
            {
                iPageNum = 3;
            }
            this.SEQ.Text = _sSEQ[iPageNum];
            this.SEQ2.Text = _sSEQ[iPageNum];
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

            if (_dt.Rows[iPageNum]["SMCOAPPTIME"].ToString() != "")
            {
                this.SMTATIME1.Text = _dt.Rows[iPageNum]["SMCOAPPTIME"].ToString().Substring(0, 2) + ":" + _dt.Rows[iPageNum]["SMCOAPPTIME"].ToString().Substring(2, 2);
            }
            else
            {
                this.SMTATIME1.Text = _dt.Rows[iPageNum]["SMTATIME1_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMTATIME1_MM"].ToString();
            }

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
            //운영팀 확인
            if (_dt.Rows[iPageNum]["SMOPSABUN"].ToString() != "")
            {
                SIGN5.Visible = true;
                System.IO.Stream stream5 = new System.IO.MemoryStream(_sign5[iPageNum]);
                SIGN5.Image = Bitmap.FromStream(stream5);

                this.SMOPNAME.Text = _dt.Rows[iPageNum]["SMOPHANGL"].ToString();
                this.SMOPAPPTIME.Text = _dt.Rows[iPageNum]["SMOPAPPTIME"].ToString().Substring(0, 2) + ":" + _dt.Rows[0]["SMOPAPPTIME"].ToString().Substring(2, 2);
                this.SMOPCOMMENT.Text = _dt.Rows[iPageNum]["SMOPCOMMENT"].ToString();
            }
            else
            {
                SIGN5.Visible = false;

                this.SMOPNAME.Text = "";
                this.SMOPAPPTIME.Text = "";
                this.SMOPCOMMENT.Text = "";
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
            if (_dt.Rows[iPageNum]["SMCHKSABUN1"].ToString() != "")
            {
                this.SMCHKOXYGEN1.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN1"].ToString();
                this.SMCHKOXYGENUNIT1.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT1"].ToString());
                this.SMCHKTOXNUM1.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM1"].ToString();
                this.SMCHKTOXUNIT1.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT1"].ToString());
                this.SMCHKTOXNUM1DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM1DS"].ToString();
                this.SMCHKTOXUNIT1DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT1DS"].ToString());
                this.SMCHKTOXNUM1CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM1CO2"].ToString();
                this.SMCHKTOXUNIT1CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT1CO2"].ToString());
                this.SMCHKTOXNUM1CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM1CO"].ToString();
                this.SMCHKTOXUNIT1CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT1CO"].ToString());
                this.SMCHKTOXNUM1H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM1H2S"].ToString();
                this.SMCHKTOXUNIT1H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT1H2S"].ToString());
                this.SMCHKNAME1.Text = _dt.Rows[iPageNum]["SMCHKNAME1"].ToString();
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME2_HH"].ToString() != "")
            {
                this.SMCHKTIME2.Text = _dt.Rows[iPageNum]["SMCHKTIME2_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME2_MM"].ToString();
            }
            if (_dt.Rows[iPageNum]["SMCHKSABUN2"].ToString() != "")
            {
                this.SMCHKOXYGEN2.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN2"].ToString();
                this.SMCHKOXYGENUNIT2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT2"].ToString());
                this.SMCHKTOXNUM2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM2"].ToString();
                this.SMCHKTOXUNIT2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT2"].ToString());
                this.SMCHKTOXNUM2DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM2DS"].ToString();
                this.SMCHKTOXUNIT2DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT2DS"].ToString());
                this.SMCHKTOXNUM2CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM2CO2"].ToString();
                this.SMCHKTOXUNIT2CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT2CO2"].ToString());
                this.SMCHKTOXNUM2CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM2CO"].ToString();
                this.SMCHKTOXUNIT2CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT2CO"].ToString());
                this.SMCHKTOXNUM2H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM2H2S"].ToString();
                this.SMCHKTOXUNIT2H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT2H2S"].ToString());
                this.SMCHKNAME2.Text = _dt.Rows[iPageNum]["SMCHKNAME2"].ToString();
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME3_HH"].ToString() != "")
            {
                this.SMCHKTIME3.Text = _dt.Rows[iPageNum]["SMCHKTIME3_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME3_MM"].ToString();
            }
            if (_dt.Rows[iPageNum]["SMCHKSABUN3"].ToString() != "")
            {
                this.SMCHKOXYGEN3.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN3"].ToString();
                this.SMCHKOXYGENUNIT3.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT3"].ToString());
                this.SMCHKTOXNUM3.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM3"].ToString();
                this.SMCHKTOXUNIT3.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT3"].ToString());
                this.SMCHKTOXNUM3DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM3DS"].ToString();
                this.SMCHKTOXUNIT3DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT3DS"].ToString());
                this.SMCHKTOXNUM3CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM3CO2"].ToString();
                this.SMCHKTOXUNIT3CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT3CO2"].ToString());
                this.SMCHKTOXNUM3CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM3CO"].ToString();
                this.SMCHKTOXUNIT3CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT3CO"].ToString());
                this.SMCHKTOXNUM3H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM3H2S"].ToString();
                this.SMCHKTOXUNIT3H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT3H2S"].ToString());
                this.SMCHKNAME3.Text = _dt.Rows[iPageNum]["SMCHKNAME3"].ToString();
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME4_HH"].ToString() != "")
            {
                this.SMCHKTIME4.Text = _dt.Rows[iPageNum]["SMCHKTIME4_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME4_MM"].ToString();
            }
            if (_dt.Rows[iPageNum]["SMCHKSABUN4"].ToString() != "")
            {
                this.SMCHKOXYGEN4.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN4"].ToString();
                this.SMCHKOXYGENUNIT4.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT4"].ToString());
                this.SMCHKTOXNUM4.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM4"].ToString();
                this.SMCHKTOXUNIT4.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT4"].ToString());
                this.SMCHKTOXNUM4DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM4DS"].ToString();
                this.SMCHKTOXUNIT4DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT4DS"].ToString());
                this.SMCHKTOXNUM4CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM4CO2"].ToString();
                this.SMCHKTOXUNIT4CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT4CO2"].ToString());
                this.SMCHKTOXNUM4CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM4CO"].ToString();
                this.SMCHKTOXUNIT4CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT4CO"].ToString());
                this.SMCHKTOXNUM4H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM4H2S"].ToString();
                this.SMCHKTOXUNIT4H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT4H2S"].ToString());
                this.SMCHKNAME4.Text = _dt.Rows[iPageNum]["SMCHKNAME4"].ToString();
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME5_HH"].ToString() != "")
            {
                this.SMCHKTIME5.Text = _dt.Rows[iPageNum]["SMCHKTIME5_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME5_MM"].ToString();
            }
            if (_dt.Rows[iPageNum]["SMCHKSABUN5"].ToString() != "")
            {
                this.SMCHKOXYGEN5.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN5"].ToString();
                this.SMCHKOXYGENUNIT5.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT5"].ToString());
                this.SMCHKTOXNUM5.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM5"].ToString();
                this.SMCHKTOXUNIT5.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT5"].ToString());
                this.SMCHKTOXNUM5DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM5DS"].ToString();
                this.SMCHKTOXUNIT5DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT5DS"].ToString());
                this.SMCHKTOXNUM5CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM5CO2"].ToString();
                this.SMCHKTOXUNIT5CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT5CO2"].ToString());
                this.SMCHKTOXNUM5CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM5CO"].ToString();
                this.SMCHKTOXUNIT5CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT5CO"].ToString());
                this.SMCHKTOXNUM5H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM5H2S"].ToString();
                this.SMCHKTOXUNIT5H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT5H2S"].ToString());
                this.SMCHKNAME5.Text = _dt.Rows[iPageNum]["SMCHKNAME5"].ToString();
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME6_HH"].ToString() != "")
            {
                this.SMCHKTIME6.Text = _dt.Rows[iPageNum]["SMCHKTIME6_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME6_MM"].ToString();
            }
            if (_dt.Rows[iPageNum]["SMCHKSABUN6"].ToString() != "")
            {
                this.SMCHKOXYGEN6.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN6"].ToString();
                this.SMCHKOXYGENUNIT6.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT6"].ToString());
                this.SMCHKTOXNUM6.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM6"].ToString();
                this.SMCHKTOXUNIT6.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT6"].ToString());
                this.SMCHKTOXNUM6DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM6DS"].ToString();
                this.SMCHKTOXUNIT6DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT6DS"].ToString());
                this.SMCHKTOXNUM6CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM6CO2"].ToString();
                this.SMCHKTOXUNIT6CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT6CO2"].ToString());
                this.SMCHKTOXNUM6CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM6CO"].ToString();
                this.SMCHKTOXUNIT6CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT6CO"].ToString());
                this.SMCHKTOXNUM6H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM6H2S"].ToString();
                this.SMCHKTOXUNIT6H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT6H2S"].ToString());
                this.SMCHKNAME6.Text = _dt.Rows[iPageNum]["SMCHKNAME6"].ToString();
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME7_HH"].ToString() != "")
            {
                this.SMCHKTIME7.Text = _dt.Rows[iPageNum]["SMCHKTIME7_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME7_MM"].ToString();
            }
            if (_dt.Rows[iPageNum]["SMCHKSABUN7"].ToString() != "")
            {
                this.SMCHKOXYGEN7.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN7"].ToString();
                this.SMCHKOXYGENUNIT7.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT7"].ToString());
                this.SMCHKTOXNUM7.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM7"].ToString();
                this.SMCHKTOXUNIT7.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT7"].ToString());
                this.SMCHKTOXNUM7DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM7DS"].ToString();
                this.SMCHKTOXUNIT7DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT7DS"].ToString());
                this.SMCHKTOXNUM7CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM7CO2"].ToString();
                this.SMCHKTOXUNIT7CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT7CO2"].ToString());
                this.SMCHKTOXNUM7CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM7CO"].ToString();
                this.SMCHKTOXUNIT7CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT7CO"].ToString());
                this.SMCHKTOXNUM7H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM7H2S"].ToString();
                this.SMCHKTOXUNIT7H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT7H2S"].ToString());
                this.SMCHKNAME7.Text = _dt.Rows[iPageNum]["SMCHKNAME7"].ToString();
            }

            if (_dt.Rows[iPageNum]["SMCHKTIME8_HH"].ToString() != "")
            {
                this.SMCHKTIME8.Text = _dt.Rows[iPageNum]["SMCHKTIME8_HH"].ToString() + ":" + _dt.Rows[iPageNum]["SMCHKTIME8_MM"].ToString();
            }
            if (_dt.Rows[iPageNum]["SMCHKSABUN8"].ToString() != "")
            {
                this.SMCHKOXYGEN8.Text = _dt.Rows[iPageNum]["SMCHKOXYGEN8"].ToString();
                this.SMCHKOXYGENUNIT8.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKOXYGENUNIT8"].ToString());
                this.SMCHKTOXNUM8.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM8"].ToString();
                this.SMCHKTOXUNIT8.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT8"].ToString());
                this.SMCHKTOXNUM8DS.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM8DS"].ToString();
                this.SMCHKTOXUNIT8DS.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT8DS"].ToString());
                this.SMCHKTOXNUM8CO2.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM8CO2"].ToString();
                this.SMCHKTOXUNIT8CO2.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT8CO2"].ToString());
                this.SMCHKTOXNUM8CO.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM8CO"].ToString();
                this.SMCHKTOXUNIT8CO.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT8CO"].ToString());
                this.SMCHKTOXNUM8H2S.Text = _dt.Rows[iPageNum]["SMCHKTOXNUM8H2S"].ToString();
                this.SMCHKTOXUNIT8H2S.Text = UP_UnitConvert(_dt.Rows[iPageNum]["SMCHKTOXUNIT8H2S"].ToString());
                this.SMCHKNAME8.Text = _dt.Rows[iPageNum]["SMCHKNAME8"].ToString();
            }

            SMORDERTEXT1.Text = _dt.Rows[iPageNum]["SMORDERTEXT1"].ToString();

            string temp = string.Empty;
            //for (int i = 0; i < _dt4[iPageNum].Rows.Count; i++)
            //{
            //    if (temp.Length > 0)
            //    {
            //        temp += ", ";
            //    }
            //    temp += _dt4[iPageNum].Rows[i]["AFFILENAME"].ToString();
            //}
            this.FILENAME.Text = temp;

            if (_dt.Rows[iPageNum]["SMCOAPPTIME"].ToString() != "")
            {
                this.SMGRAPPTIME.Text = _dt.Rows[iPageNum]["SMCOAPPTIME"].ToString().Substring(0, 2) + ":" + _dt.Rows[iPageNum]["SMCOAPPTIME"].ToString().Substring(2, 2);
            }
            else
            {
                this.SMGRAPPTIME.Text = "";
            }

            #region Description : 1번 block 일반위험작업

            this.SSCODENAME1_1.Text = _dt5[iPageNum].Rows[0]["NAME"].ToString();
            this.SSCODENAME1_2.Text = _dt5[iPageNum].Rows[1]["NAME"].ToString();
            this.SSCODENAME1_3.Text = _dt5[iPageNum].Rows[2]["NAME"].ToString();
            this.SSCODENAME1_4.Text = _dt5[iPageNum].Rows[3]["NAME"].ToString();
            this.SSCODENAME1_5.Text = _dt5[iPageNum].Rows[4]["NAME"].ToString();
            this.SSCODENAME1_6.Text = _dt5[iPageNum].Rows[5]["NAME"].ToString();
            this.SSCODENAME1_7.Text = _dt5[iPageNum].Rows[6]["NAME"].ToString();
            this.SSCODENAME1_8.Text = _dt5[iPageNum].Rows[7]["NAME"].ToString();
            this.SSCODENAME1_9.Text = _dt5[iPageNum].Rows[8]["NAME"].ToString();
            this.SSCODENAME1_10.Text = _dt5[iPageNum].Rows[9]["NAME"].ToString();
            this.SSCODENAME1_11.Text = _dt5[iPageNum].Rows[10]["NAME"].ToString();
            this.SSCODENAME1_12.Text = _dt5[iPageNum].Rows[11]["NAME"].ToString();
            this.SSCODENAME1_13.Text = _dt5[iPageNum].Rows[12]["NAME"].ToString();
            this.SSCODENAME1_14.Text = _dt5[iPageNum].Rows[13]["NAME"].ToString();
            this.SSCODENAME1_15.Text = _dt5[iPageNum].Rows[14]["NAME"].ToString();
            this.SSCODENAME1_16.Text = _dt5[iPageNum].Rows[15]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[0]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[1]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[2]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[3]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[4]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[5]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[6]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[7]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[8]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[9]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[10]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[11]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[12]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[13]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[14]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[15]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL1_16.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[0]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[1]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[2]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[3]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[4]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[5]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[6]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[7]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[8]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[9]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[10]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[11]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[12]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[13]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[14]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[15]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL1_16.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[0]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[1]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[2]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[3]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[4]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[5]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[6]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[7]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[8]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[9]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[10]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[11]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[12]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[13]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[14]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[15]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL1_16.Text = "✔";
            }

            #endregion

            #region Description : 2번 block 열간(화기)작업

            this.SSCODENAME2_1.Text = _dt5[iPageNum].Rows[16]["NAME"].ToString();
            this.SSCODENAME2_2.Text = _dt5[iPageNum].Rows[17]["NAME"].ToString();
            this.SSCODENAME2_3.Text = _dt5[iPageNum].Rows[18]["NAME"].ToString();
            this.SSCODENAME2_4.Text = _dt5[iPageNum].Rows[19]["NAME"].ToString();
            this.SSCODENAME2_5.Text = _dt5[iPageNum].Rows[20]["NAME"].ToString();
            this.SSCODENAME2_6.Text = _dt5[iPageNum].Rows[21]["NAME"].ToString();
            this.SSCODENAME2_7.Text = _dt5[iPageNum].Rows[22]["NAME"].ToString();
            this.SSCODENAME2_8.Text = _dt5[iPageNum].Rows[23]["NAME"].ToString();
            this.SSCODENAME2_9.Text = _dt5[iPageNum].Rows[24]["NAME"].ToString();
            this.SSCODENAME2_10.Text = _dt5[iPageNum].Rows[25]["NAME"].ToString();
            this.SSCODENAME2_11.Text = _dt5[iPageNum].Rows[26]["NAME"].ToString();
            this.SSCODENAME2_12.Text = _dt5[iPageNum].Rows[27]["NAME"].ToString();
            this.SSCODENAME2_13.Text = _dt5[iPageNum].Rows[28]["NAME"].ToString();
            this.SSCODENAME2_14.Text = _dt5[iPageNum].Rows[29]["NAME"].ToString();
            this.SSCODENAME2_15.Text = _dt5[iPageNum].Rows[30]["NAME"].ToString();
            this.SSCODENAME2_16.Text = _dt5[iPageNum].Rows[31]["NAME"].ToString();
            this.SSCODENAME2_17.Text = _dt5[iPageNum].Rows[32]["NAME"].ToString();
            this.SSCODENAME2_18.Text = _dt5[iPageNum].Rows[33]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[16]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[17]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[18]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[19]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[20]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[21]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[22]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[23]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[24]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[25]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[26]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[27]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[28]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[29]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[30]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[31]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_16.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[32]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_17.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[33]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL2_18.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[16]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[17]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[18]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[19]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[20]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[21]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[22]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[23]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[24]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[25]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[26]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[27]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[28]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[29]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[30]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[31]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_16.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[32]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_17.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[33]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL2_18.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[16]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[17]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[18]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[19]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[20]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[21]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[22]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[23]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[24]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[25]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[26]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[27]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[28]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[29]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[30]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[31]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_16.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[32]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_17.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[33]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL2_18.Text = "✔";
            }

            #endregion

            #region Description : 3번 block (밀폐공간출입작업)

            this.SSCODENAME3_1.Text = _dt5[iPageNum].Rows[34]["NAME"].ToString();
            this.SSCODENAME3_2.Text = _dt5[iPageNum].Rows[35]["NAME"].ToString();
            this.SSCODENAME3_3.Text = _dt5[iPageNum].Rows[36]["NAME"].ToString();
            this.SSCODENAME3_4.Text = _dt5[iPageNum].Rows[37]["NAME"].ToString();
            this.SSCODENAME3_5.Text = _dt5[iPageNum].Rows[38]["NAME"].ToString();
            this.SSCODENAME3_6.Text = _dt5[iPageNum].Rows[39]["NAME"].ToString();
            this.SSCODENAME3_7.Text = _dt5[iPageNum].Rows[40]["NAME"].ToString();
            this.SSCODENAME3_8.Text = _dt5[iPageNum].Rows[41]["NAME"].ToString();
            this.SSCODENAME3_9.Text = _dt5[iPageNum].Rows[42]["NAME"].ToString();
            this.SSCODENAME3_10.Text = _dt5[iPageNum].Rows[43]["NAME"].ToString();
            this.SSCODENAME3_11.Text = _dt5[iPageNum].Rows[44]["NAME"].ToString();
            this.SSCODENAME3_12.Text = _dt5[iPageNum].Rows[45]["NAME"].ToString();
            this.SSCODENAME3_13.Text = _dt5[iPageNum].Rows[46]["NAME"].ToString();
            this.SSCODENAME3_14.Text = _dt5[iPageNum].Rows[47]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[34]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[35]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[36]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[37]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[38]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[39]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[40]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[41]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[42]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[43]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[44]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[45]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[46]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[47]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL3_14.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[34]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[35]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[36]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[37]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[38]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[39]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[40]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[41]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[42]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[43]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[44]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[45]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[46]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[47]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL3_14.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[34]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[35]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[36]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[37]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[38]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[39]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[40]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[41]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[42]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[43]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[44]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[45]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[46]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[47]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL3_14.Text = "✔";
            }

            #endregion

            #region Description : 4번 block 전기(정전)작업

            this.SSCODENAME4_1.Text = _dt5[iPageNum].Rows[48]["NAME"].ToString();
            this.SSCODENAME4_2.Text = _dt5[iPageNum].Rows[49]["NAME"].ToString();
            this.SSCODENAME4_3.Text = _dt5[iPageNum].Rows[50]["NAME"].ToString();
            this.SSCODENAME4_4.Text = _dt5[iPageNum].Rows[51]["NAME"].ToString();
            this.SSCODENAME4_5.Text = _dt5[iPageNum].Rows[52]["NAME"].ToString();
            this.SSCODENAME4_6.Text = _dt5[iPageNum].Rows[53]["NAME"].ToString();
            this.SSCODENAME4_7.Text = _dt5[iPageNum].Rows[54]["NAME"].ToString();
            this.SSCODENAME4_8.Text = _dt5[iPageNum].Rows[55]["NAME"].ToString();
            this.SSCODENAME4_9.Text = _dt5[iPageNum].Rows[56]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[48]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[49]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[50]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[51]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[52]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[53]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[54]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[55]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[56]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL4_9.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[48]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[49]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[50]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[51]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[52]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[53]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[54]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[55]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[56]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL4_9.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[48]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[49]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[50]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[51]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[52]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[53]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[54]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[55]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[56]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL4_9.Text = "✔";
            }

            #endregion

            #region Description : 5번 block 방사선사용작업

            this.SSCODENAME5_1.Text = _dt5[iPageNum].Rows[57]["NAME"].ToString();
            this.SSCODENAME5_2.Text = _dt5[iPageNum].Rows[58]["NAME"].ToString();
            this.SSCODENAME5_3.Text = _dt5[iPageNum].Rows[59]["NAME"].ToString();
            this.SSCODENAME5_4.Text = _dt5[iPageNum].Rows[60]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[57]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL5_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[58]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL5_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[59]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL5_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[60]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL5_4.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[57]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL5_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[58]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL5_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[59]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL5_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[60]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL5_4.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[57]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL5_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[58]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL5_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[59]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL5_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[60]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL5_4.Text = "✔";
            }

            #endregion

            #region Description : 6번 block 고소작업

            this.SSCODENAME6_1.Text = _dt5[iPageNum].Rows[61]["NAME"].ToString();
            this.SSCODENAME6_2.Text = _dt5[iPageNum].Rows[62]["NAME"].ToString();
            this.SSCODENAME6_3.Text = _dt5[iPageNum].Rows[63]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[61]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL6_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[62]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL6_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[63]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL6_3.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[61]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL6_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[62]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL6_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[63]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL6_3.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[61]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL6_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[62]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL6_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[63]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL6_3.Text = "✔";
            }
            #endregion

            #region Description : 7번 block 중장비사용작업

            this.SSCODENAME7_1.Text = _dt5[iPageNum].Rows[64]["NAME"].ToString();
            this.SSCODENAME7_2.Text = _dt5[iPageNum].Rows[65]["NAME"].ToString();
            this.SSCODENAME7_3.Text = _dt5[iPageNum].Rows[66]["NAME"].ToString();
            this.SSCODENAME7_4.Text = _dt5[iPageNum].Rows[67]["NAME"].ToString();
            this.SSCODENAME7_5.Text = _dt5[iPageNum].Rows[68]["NAME"].ToString();
            this.SSCODENAME7_6.Text = _dt5[iPageNum].Rows[69]["NAME"].ToString();
            this.SSCODENAME7_7.Text = _dt5[iPageNum].Rows[70]["NAME"].ToString();
            this.SSCODENAME7_8.Text = _dt5[iPageNum].Rows[71]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[64]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[65]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[66]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[67]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[68]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[69]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[70]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[71]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL7_8.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[64]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[65]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[66]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[67]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[68]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[69]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[70]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[71]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL7_8.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[64]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[65]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[66]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[67]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[68]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[69]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[70]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[71]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL7_8.Text = "✔";
            }

            #endregion

            #region Description : 8번 block 굴착작업

            if (_dt6[iPageNum].Rows.Count > 0)
            {

                this.SSCODENAME8_1.Text = _dt6[iPageNum].Rows[0]["DRCODENAME"].ToString();
                this.SSCODENAME8_2.Text = _dt6[iPageNum].Rows[1]["DRCODENAME"].ToString();
                this.SSCODENAME8_3.Text = _dt6[iPageNum].Rows[2]["DRCODENAME"].ToString();
                this.SSCODENAME8_4.Text = _dt6[iPageNum].Rows[3]["DRCODENAME"].ToString();
                this.SSCODENAME8_5.Text = _dt6[iPageNum].Rows[4]["DRCODENAME"].ToString();

                if (_dt6[iPageNum].Rows[0]["DRYESSEL"].ToString() == "Y")
                {
                    this.SSPUBSEL8_1.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[1]["DRYESSEL"].ToString() == "Y")
                {
                    this.SSPUBSEL8_2.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[2]["DRYESSEL"].ToString() == "Y")
                {
                    this.SSPUBSEL8_3.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[3]["DRYESSEL"].ToString() == "Y")
                {
                    this.SSPUBSEL8_4.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[4]["DRYESSEL"].ToString() == "Y")
                {
                    this.SSPUBSEL8_5.Text = "✔";
                }

                if (_dt6[iPageNum].Rows[0]["DRNOSEL"].ToString() == "Y")
                {
                    this.SSREVSEL8_1.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[1]["DRNOSEL"].ToString() == "Y")
                {
                    this.SSREVSEL8_2.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[2]["DRNOSEL"].ToString() == "Y")
                {
                    this.SSREVSEL8_3.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[3]["DRNOSEL"].ToString() == "Y")
                {
                    this.SSREVSEL8_4.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[4]["DRNOSEL"].ToString() == "Y")
                {
                    this.SSREVSEL8_5.Text = "✔";
                }

                if (_dt6[iPageNum].Rows[0]["DRNASEL"].ToString() == "Y")
                {
                    this.SSFIXSEL8_1.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[1]["DRNASEL"].ToString() == "Y")
                {
                    this.SSFIXSEL8_2.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[2]["DRNASEL"].ToString() == "Y")
                {
                    this.SSFIXSEL8_3.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[3]["DRNASEL"].ToString() == "Y")
                {
                    this.SSFIXSEL8_4.Text = "✔";
                }
                if (_dt6[iPageNum].Rows[4]["DRNASEL"].ToString() == "Y")
                {
                    this.SSFIXSEL8_5.Text = "✔";
                }

                this.DRSORT1.Text = _dt6[iPageNum].Rows[0]["DRSORT"].ToString();
                this.DRSORT2.Text = _dt6[iPageNum].Rows[1]["DRSORT"].ToString();
                this.DRSORT3.Text = _dt6[iPageNum].Rows[2]["DRSORT"].ToString();
                this.DRSORT4.Text = _dt6[iPageNum].Rows[3]["DRSORT"].ToString();
                this.DRSORT5.Text = _dt6[iPageNum].Rows[4]["DRSORT"].ToString();

                this.DRSTAND1.Text = _dt6[iPageNum].Rows[0]["DRSTAND"].ToString();
                this.DRSTAND2.Text = _dt6[iPageNum].Rows[1]["DRSTAND"].ToString();
                this.DRSTAND3.Text = _dt6[iPageNum].Rows[2]["DRSTAND"].ToString();
                this.DRSTAND4.Text = _dt6[iPageNum].Rows[3]["DRSTAND"].ToString();
                this.DRSTAND5.Text = _dt6[iPageNum].Rows[4]["DRSTAND"].ToString();

                this.DRDEPTH1.Text = _dt6[iPageNum].Rows[0]["DRDEPTH"].ToString();
                this.DRDEPTH2.Text = _dt6[iPageNum].Rows[1]["DRDEPTH"].ToString();
                this.DRDEPTH3.Text = _dt6[iPageNum].Rows[2]["DRDEPTH"].ToString();
                this.DRDEPTH4.Text = _dt6[iPageNum].Rows[3]["DRDEPTH"].ToString();
                this.DRDEPTH5.Text = _dt6[iPageNum].Rows[4]["DRDEPTH"].ToString();

                this.DRKBHANGL1.Text = _dt6[iPageNum].Rows[0]["KBHANGL"].ToString();
                this.DRKBHANGL2.Text = _dt6[iPageNum].Rows[1]["KBHANGL"].ToString();
                this.DRKBHANGL3.Text = _dt6[iPageNum].Rows[2]["KBHANGL"].ToString();
                this.DRKBHANGL4.Text = _dt6[iPageNum].Rows[3]["KBHANGL"].ToString();
                this.DRKBHANGL5.Text = _dt6[iPageNum].Rows[4]["KBHANGL"].ToString();
            }
            else
            {
                this.SSCODENAME8_1.Text = "";
                this.SSCODENAME8_2.Text = "";
                this.SSCODENAME8_3.Text = "";
                this.SSCODENAME8_4.Text = "";
                this.SSCODENAME8_5.Text = "";

                this.DRSORT1.Text = "";
                this.DRSORT2.Text = "";
                this.DRSORT3.Text = "";
                this.DRSORT4.Text = "";
                this.DRSORT5.Text = "";

                this.DRSTAND1.Text = "";
                this.DRSTAND2.Text = "";
                this.DRSTAND3.Text = "";
                this.DRSTAND4.Text = "";
                this.DRSTAND5.Text = "";

                this.DRDEPTH1.Text = "";
                this.DRDEPTH2.Text = "";
                this.DRDEPTH3.Text = "";
                this.DRDEPTH4.Text = "";
                this.DRDEPTH5.Text = "";

                this.DRKBHANGL1.Text = "";
                this.DRKBHANGL2.Text = "";
                this.DRKBHANGL3.Text = "";
                this.DRKBHANGL4.Text = "";
                this.DRKBHANGL5.Text = "";
            }
            #endregion

            #region Description : 9번 block 안전보호구

            this.SSCODENAME9_1.Text = _dt5[iPageNum].Rows[72]["NAME"].ToString();
            this.SSCODENAME9_2.Text = _dt5[iPageNum].Rows[73]["NAME"].ToString();
            this.SSCODENAME9_3.Text = _dt5[iPageNum].Rows[74]["NAME"].ToString();
            this.SSCODENAME9_4.Text = _dt5[iPageNum].Rows[75]["NAME"].ToString();
            this.SSCODENAME9_5.Text = _dt5[iPageNum].Rows[76]["NAME"].ToString();
            this.SSCODENAME9_6.Text = _dt5[iPageNum].Rows[77]["NAME"].ToString();
            this.SSCODENAME9_7.Text = _dt5[iPageNum].Rows[78]["NAME"].ToString();
            this.SSCODENAME9_8.Text = _dt5[iPageNum].Rows[79]["NAME"].ToString();
            this.SSCODENAME9_9.Text = _dt5[iPageNum].Rows[80]["NAME"].ToString();
            this.SSCODENAME9_10.Text = _dt5[iPageNum].Rows[81]["NAME"].ToString();
            this.SSCODENAME9_11.Text = _dt5[iPageNum].Rows[82]["NAME"].ToString();
            this.SSCODENAME9_12.Text = _dt5[iPageNum].Rows[83]["NAME"].ToString();
            this.SSCODENAME9_13.Text = _dt5[iPageNum].Rows[84]["NAME"].ToString();
            this.SSCODENAME9_14.Text = _dt5[iPageNum].Rows[85]["NAME"].ToString();
            this.SSCODENAME9_15.Text = _dt5[iPageNum].Rows[86]["NAME"].ToString();
            this.SSCODENAME9_16.Text = _dt5[iPageNum].Rows[87]["NAME"].ToString();

            if (_dt5[iPageNum].Rows[72]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[73]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[74]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[75]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[76]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[77]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[78]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[79]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[80]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[81]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[82]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[83]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[84]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[85]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[86]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[87]["SSPUBSEL"].ToString() == "Y")
            {
                this.SSPUBSEL9_16.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[72]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[73]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[74]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[75]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[76]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[77]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[78]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[79]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[80]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[81]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[82]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[83]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[84]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[85]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[86]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[87]["SSREVSEL"].ToString() == "Y")
            {
                this.SSREVSEL9_16.Text = "✔";
            }

            if (_dt5[iPageNum].Rows[72]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_1.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[73]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_2.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[74]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_3.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[75]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_4.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[76]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_5.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[77]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_6.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[78]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_7.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[79]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_8.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[80]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_9.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[81]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_10.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[82]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_11.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[83]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_12.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[84]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_13.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[85]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_14.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[86]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_15.Text = "✔";
            }
            if (_dt5[iPageNum].Rows[87]["SSFIXSEL"].ToString() == "Y")
            {
                this.SSFIXSEL9_16.Text = "✔";
            }

            #endregion
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

        private void groupFooter1_Format(object sender, EventArgs e)
        {
            iPageNum++;
            if (_dt2.Rows.Count > iPageNum)
            {
                this.groupFooter1.NewPage = NewPage.Before;
            }
            else
            {
                this.groupFooter1.NewPage = NewPage.None;
            }
        }

        #region Description : 안전작업허가서 건수 빈 테이블
        private DataTable UP_WKDatatable(int icount)
        {
            DataTable rtnValue = new DataTable();

            rtnValue.Columns.Add("WORKCOUNT");

            for (int i = 0; i < icount; i++)
            {
                rtnValue.Rows.Add(i);
            }

            return rtnValue;
        }
        #endregion

        private void PSM4041_RPT_5_ReportEnd(object sender, EventArgs e)
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

