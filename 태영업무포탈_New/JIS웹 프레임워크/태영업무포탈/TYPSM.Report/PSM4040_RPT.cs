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
    /// Summary description for PSM4040_RPT.
    /// </summary>
    public partial class PSM4040_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();
        private DataTable _dt2 = new DataTable();
        
        private byte[] _sign1 = null;
        private byte[] _sign2 = null;
        private byte[] _sign3 = null;

        private string _CMWKTEAM = string.Empty;
        private string _CMWKDATE = string.Empty;
        private string _CMWKSEQ = string.Empty;
        private string _SMWKORAPPDATE = string.Empty;
        private string _SMWKORSEQ = string.Empty;

        private string _sSEQ = string.Empty;
        private string _PRINTNAME = string.Empty;
        private string _PRINTCNT = string.Empty;

        public PSM4040_RPT(System.Collections.Specialized.NameValueCollection QueryString)
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

            UP_DataBing();
        }

        public PSM4040_RPT(string QueryString) // 웹 서비스 호출 용
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

            UP_DataBing();
        }
        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();


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

                _dt2 = ds.Tables[1];

                _sSEQ = _CMWKTEAM + "-" + _CMWKDATE + "-" + _CMWKSEQ + "-" + _SMWKORAPPDATE + "-" + _SMWKORSEQ;

                _sign1 =  _dt.Rows[0]["SOIMGSIGN3"] as byte[];
                _sign2 =  _dt.Rows[0]["SOIMGSIGN6"] as byte[];
                _sign3 =  _dt.Rows[0]["SOIMGSIGN4"] as byte[];
            }

        }
        private void pageHeader_Format(object sender, EventArgs e)
        {   
            if (_dt2.Rows.Count > 0)
            {
                for (int i = 0; i < _dt2.Rows.Count; i++)
                {
                    switch (_dt2.Rows[i]["SWWKCODE"].ToString())
                    {   
                        case "03":
                            if (_dt2.Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE3.Text = "✔";
                            }
                            break;
                        case "06":
                            if (_dt2.Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE6.Text = "✔";
                            }
                            break;
                        case "07":
                            if (_dt2.Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE7.Text = "✔";
                            }
                            break;
                        case "08":
                            if (_dt2.Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE8.Text = "✔";
                            }
                            break;
                        case "09":
                            if (_dt2.Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE9.Text = "✔";
                            }
                            break;
                        case "10":
                            if (_dt2.Rows[i]["SWCHECKGN"].ToString() == "Y")
                            {
                                this.SWWKCODE10.Text = "✔";
                            }
                            break;
                    }
                }
            }

            this.SMWORKTITLE.Text = _dt.Rows[0]["SMWORKTITLE"].ToString();

            this.SMCONAME.Text = _dt.Rows[0]["SMCONAME"].ToString();
            this.SMSMNAME.Text = _dt.Rows[0]["SMSMNAME"].ToString();
            this.SMFSNAME.Text = _dt.Rows[0]["SMFSNAME"].ToString();
            this.SMAREATEXT1.Text = _dt.Rows[0]["SMAREATEXT1"].ToString();
            this.SMAREACODE1NM.Text = _dt.Rows[0]["SMAREACODE1NM"].ToString();
            
            this.SMWKMAN.Text = _dt.Rows[0]["SMWKMAN"].ToString();

            string sSMTADATE1 = _dt.Rows[0]["SMTADATE1"].ToString().Substring(0, 4) + "년　" + _dt.Rows[0]["SMTADATE1"].ToString().Substring(4, 2) + "월　" + _dt.Rows[0]["SMTADATE1"].ToString().Substring(6, 2) + "일";
            string sSMTADATE2 = _dt.Rows[0]["SMTADATE2"].ToString().Substring(0, 4) + "년　" + _dt.Rows[0]["SMTADATE2"].ToString().Substring(4, 2) + "월　" + _dt.Rows[0]["SMTADATE2"].ToString().Substring(6, 2) + "일";

            string sSTTIME = _dt.Rows[0]["SMTADATE1"].ToString().Substring(0, 4) + "-" + _dt.Rows[0]["SMTADATE1"].ToString().Substring(4, 2) + "-" + _dt.Rows[0]["SMTADATE1"].ToString().Substring(6, 2) + " ";
            string sEDTIME = _dt.Rows[0]["SMTADATE2"].ToString().Substring(0, 4) + "-" + _dt.Rows[0]["SMTADATE2"].ToString().Substring(4, 2) + "-" + _dt.Rows[0]["SMTADATE2"].ToString().Substring(6, 2) + " ";
            string sTIME = string.Empty;

            if (_dt.Rows[0]["SMCOAPPTIME"].ToString() != "")
            {
                this.SMTATIME1.Text = _dt.Rows[0]["SMCOAPPTIME"].ToString().Substring(0, 2) + ":" + _dt.Rows[0]["SMCOAPPTIME"].ToString().Substring(2, 2);
                sSTTIME += _dt.Rows[0]["SMCOAPPTIME"].ToString().Substring(0, 2) + ":" + _dt.Rows[0]["SMCOAPPTIME"].ToString().Substring(2, 2) + ":00";
            }
            else
            {
                this.SMTATIME1.Text = _dt.Rows[0]["SMTATIME1_HH"].ToString() + ":" + _dt.Rows[0]["SMTATIME1_MM"].ToString();
                sSTTIME += _dt.Rows[0]["SMTATIME1_HH"].ToString() + ":" + _dt.Rows[0]["SMTATIME1_MM"].ToString() + ":00";
            }

            this.SMTATIME2.Text = _dt.Rows[0]["SMTATIME2_HH"].ToString() + ":" + _dt.Rows[0]["SMTATIME2_MM"].ToString();
            sEDTIME += _dt.Rows[0]["SMTATIME2_HH"].ToString() + ":" + _dt.Rows[0]["SMTATIME2_MM"].ToString() + ":00";

            if (Convert.ToInt16(_dt.Rows[0]["SMTATIME1_HH"].ToString()) <= 12 && Convert.ToInt16(_dt.Rows[0]["SMTATIME2_HH"].ToString()) >= 13)
            {
                sTIME = (Convert.ToDateTime(sEDTIME).AddHours(-1) - Convert.ToDateTime(sSTTIME)).ToString("hhmm");
            }
            else
            {
                sTIME = (Convert.ToDateTime(sEDTIME) - Convert.ToDateTime(sSTTIME)).ToString("hhmm");
            }
            
            this.SMTATIME.Text = "(" + sTIME.Substring(0, 2) + "시간" + sTIME.Substring(2, 2) + "분)";

            this.SMTADATE1.Text = sSMTADATE1;

            this.SMTADATE.Text = sSMTADATE1;

            if (_dt.Rows[0]["SMCOAPPDATE"].ToString() != "")
            {
                SIGN1.Visible = true;
                System.IO.Stream stream1 = new System.IO.MemoryStream(_sign1);
                SIGN1.Image = Bitmap.FromStream(stream1);
            }
            if (_dt.Rows[0]["SMFSDATE"].ToString() != "")
            {
                SIGN2.Visible = true;
                System.IO.Stream stream2 = new System.IO.MemoryStream(_sign2);
                SIGN2.Image = Bitmap.FromStream(stream2);
            }
            if (_dt.Rows[0]["SMSMAPPDATE"].ToString() != "")
            {
                SIGN3.Visible = true;
                System.IO.Stream stream3 = new System.IO.MemoryStream(_sign3);
                SIGN3.Image = Bitmap.FromStream(stream3);
            }

            if (_dt.Rows[0]["SMFSTIME"].ToString() != "")
            {
                this.SMFSDATE.Text = _dt.Rows[0]["SMFSTIME"].ToString().Substring(0, 2) + ":" + _dt.Rows[0]["SMFSTIME"].ToString().Substring(2, 2) + ":" + _dt.Rows[0]["SMFSTIME"].ToString().Substring(4, 2);
            }
            else
            {
                this.SMFSDATE.Text = "";
            }

            if (_dt.Rows[0]["SMCOAPPDATE"].ToString() != "")
            {
                this.SMCOAPPDATE.Text = _dt.Rows[0]["SMCOAPPDATE"].ToString().Substring(0, 4) + "-" + _dt.Rows[0]["SMCOAPPDATE"].ToString().Substring(4, 2) + "-" + _dt.Rows[0]["SMCOAPPDATE"].ToString().Substring(6, 2);
            }
            else
            {
                this.SMCOAPPDATE.Text = "";
            }
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

        private void PSM4040_RPT_ReportEnd(object sender, EventArgs e)
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
