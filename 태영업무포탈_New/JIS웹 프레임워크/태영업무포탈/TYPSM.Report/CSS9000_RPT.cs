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
    /// Summary description for CSS9000_RPT.
    /// </summary>
    public partial class CSS9000_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private int fiCount = 0;
        private DataTable _dt = new DataTable();

        private string fsDate = string.Empty;

        public CSS9000_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSS9000_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();


            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            fsDate = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            int iYear = 0;
            int iMonth = 0;
            string sJUNWOLYYMM = string.Empty;

            Hashtable ht = new Hashtable();

            Hashtable ht1 = new Hashtable();

            using (TaeYoung.Biz.CSS.CSSBiz biz = new TaeYoung.Biz.CSS.CSSBiz())
            {
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"]         = 15;
                ht["SearchCondition"]  = "";
                ht["DATE"]             = fsDate;
                ht["GUBUN"]            = "P";

                DataSet ds = biz.UP_CSS9000_LIST(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];

                    this.DataSource = ds.Tables[0];
                }

                iYear = int.Parse(fsDate.ToString().Substring(0, 4));
                iMonth = int.Parse(fsDate.ToString().Substring(4, 2)) - 1;

                if (iMonth == 0)
                {
                    iYear = iYear - 1;

                    iMonth = 12;
                }

                sJUNWOLYYMM = Convert.ToString(iYear) + Set_Fill(Convert.ToString(iMonth));

                ht1["P_JUNYYMM"] = sJUNWOLYYMM.ToString();

                DataSet ds1 = biz.UP_CSS9000_EIS_SEARCH(ht1);

                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        this.TXTMON_PN.Text  = string.Format("{0:#,###.##0}", double.Parse(ds1.Tables[0].Rows[i]["AMPLANQTY"].ToString()));
                        this.TXTMON_US.Text  = string.Format("{0:#,###.##0}", double.Parse(ds1.Tables[0].Rows[i]["AMRESULTQTY"].ToString()));
                        this.TXTMON_YUL.Text = string.Format("{0:#,###.0}",   double.Parse(ds1.Tables[0].Rows[i]["AMACHRATE"].ToString()));
                    }
                    else if (i == 1)
                    {
                        this.TXTANNU_PN.Text  = string.Format("{0:#,###.##0}", double.Parse(ds1.Tables[0].Rows[i]["AMPLANQTY"].ToString()));
                        this.TXTANNU_US.Text  = string.Format("{0:#,###.##0}", double.Parse(ds1.Tables[0].Rows[i]["AMRESULTQTY"].ToString()));
                        this.TXTANNU_YUL.Text = string.Format("{0:#,###.0}",   double.Parse(ds1.Tables[0].Rows[i]["AMACHRATE"].ToString()));
                    }
                    else if (i == 2)
                    {
                        this.TXTYEAR_PN.Text  = string.Format("{0:#,###.##0}", double.Parse(ds1.Tables[0].Rows[i]["AMPLANQTY"].ToString()));
                        this.TXTYEAR_US.Text  = string.Format("{0:#,###.##0}", double.Parse(ds1.Tables[0].Rows[i]["AMRESULTQTY"].ToString()));
                        this.TXTYEAR_YUL.Text = string.Format("{0:#,###.0}",   double.Parse(ds1.Tables[0].Rows[i]["AMACHRATE"].ToString()));
                    }
                }

                this.lbl_PL.Text  = sJUNWOLYYMM.ToString().Substring(4, 2) + "월 계획";
                this.lbl_US.Text  = sJUNWOLYYMM.ToString().Substring(4, 2) + "월 실적";
                this.lbl_YUL.Text = sJUNWOLYYMM.ToString().Substring(4, 2) + "월 달성율(%)";
            }
        }

        private void pageHeader_Format(object sender, EventArgs e)
        {
            DATE.Text = "(" + fsDate.ToString().Substring(0, 4) + "-" + fsDate.ToString().Substring(4, 2) + ")";
        }

        private void detail_Format(object sender, EventArgs e)
        {
            if (_dt.Rows[fiCount]["COLOR"].ToString() == "BLUE")
            {
                this.SHVESSEL.ForeColor = System.Drawing.Color.Blue;
                this.SKDESC.ForeColor = System.Drawing.Color.Blue;
                this.GKDESC.ForeColor = System.Drawing.Color.Blue;
                this.WNDESC.ForeColor = System.Drawing.Color.Blue;
                this.SHETAULSAN.ForeColor = System.Drawing.Color.Blue;
                this.SHULSANQTY.ForeColor = System.Drawing.Color.Blue;
                this.SHETABUSAN.ForeColor = System.Drawing.Color.Blue;
                this.SHBUSANQTY.ForeColor = System.Drawing.Color.Blue;
                this.SHETAINCHE.ForeColor = System.Drawing.Color.Blue;
                this.SHINCHEQTY.ForeColor = System.Drawing.Color.Blue;
                this.BL_TOTQTY.ForeColor = System.Drawing.Color.Blue;
                this.SHMONTHQTY.ForeColor = System.Drawing.Color.Blue;
                this.SHANNUALQTY.ForeColor = System.Drawing.Color.Blue;
                this.SHETBDATE.ForeColor = System.Drawing.Color.Blue;
                this.SHETCD.ForeColor = System.Drawing.Color.Blue;
                this.BRDESC.ForeColor = System.Drawing.Color.Blue;
                this.SHREMARK.ForeColor = System.Drawing.Color.Blue;
            }
            else if (_dt.Rows[fiCount]["COLOR"].ToString() == "RED")
            {
                this.SHVESSEL.ForeColor = System.Drawing.Color.Red;

                this.SKDESC.ForeColor = System.Drawing.Color.Red;
                this.GKDESC.ForeColor = System.Drawing.Color.Red;
                this.WNDESC.ForeColor = System.Drawing.Color.Red;
                this.SHETAULSAN.ForeColor = System.Drawing.Color.Red;
                this.SHULSANQTY.ForeColor = System.Drawing.Color.Red;
                this.SHETABUSAN.ForeColor = System.Drawing.Color.Red;
                this.SHBUSANQTY.ForeColor = System.Drawing.Color.Red;
                this.SHETAINCHE.ForeColor = System.Drawing.Color.Red;
                this.SHINCHEQTY.ForeColor = System.Drawing.Color.Red;
                this.BL_TOTQTY.ForeColor = System.Drawing.Color.Red;
                this.SHMONTHQTY.ForeColor = System.Drawing.Color.Red;
                this.SHANNUALQTY.ForeColor = System.Drawing.Color.Red;
                this.SHETBDATE.ForeColor = System.Drawing.Color.Red;
                this.SHETCD.ForeColor = System.Drawing.Color.Red;
                this.BRDESC.ForeColor = System.Drawing.Color.Red;
                this.SHREMARK.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                this.SHVESSEL.ForeColor = System.Drawing.Color.Black;

                this.SKDESC.ForeColor = System.Drawing.Color.Black;
                this.GKDESC.ForeColor = System.Drawing.Color.Black;
                this.WNDESC.ForeColor = System.Drawing.Color.Black;
                this.SHETAULSAN.ForeColor = System.Drawing.Color.Black;
                this.SHULSANQTY.ForeColor = System.Drawing.Color.Black;
                this.SHETABUSAN.ForeColor = System.Drawing.Color.Black;
                this.SHBUSANQTY.ForeColor = System.Drawing.Color.Black;
                this.SHETAINCHE.ForeColor = System.Drawing.Color.Black;
                this.SHINCHEQTY.ForeColor = System.Drawing.Color.Black;
                this.BL_TOTQTY.ForeColor = System.Drawing.Color.Black;
                this.SHMONTHQTY.ForeColor = System.Drawing.Color.Black;
                this.SHANNUALQTY.ForeColor = System.Drawing.Color.Black;
                this.SHETBDATE.ForeColor = System.Drawing.Color.Black;
                this.SHETCD.ForeColor = System.Drawing.Color.Black;
                this.BRDESC.ForeColor = System.Drawing.Color.Black;
                this.SHREMARK.ForeColor = System.Drawing.Color.Black;
            }

            if (_dt.Rows.Count == fiCount + 1)
            {
                this.line9.LineWeight = 3;
            }

            fiCount++;
        }

        public string Set_Fill(string sFirst)
        {
            if (sFirst.Length == 1)
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
    }
}
