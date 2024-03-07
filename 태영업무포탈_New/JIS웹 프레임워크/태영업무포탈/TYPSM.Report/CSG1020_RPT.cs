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
    /// Summary description for CSG1020_RPT.
    /// </summary>
    public partial class CSG1020_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private string fsDate_Fr = string.Empty;
        private string fsDate_To = string.Empty;

        int iCount = 0;

        public CSG1020_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSG1020_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            iCount = 0;

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk    = strArray[1].Split('=');
            fsDate_Fr = ArryWk[1].ToString();
            ArryWk    = strArray[2].Split('=');
            fsDate_To = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            using (TaeYoung.Biz.CSG.CSGBiz biz = new TaeYoung.Biz.CSG.CSGBiz())
            {
                ht["SDATE"] = fsDate_Fr;
                ht["EDATE"] = fsDate_To;
                ht["HWAJU"] = TaeYoung.Biz.Document.UserInfo.KOSTL;

                DataSet ds = biz.UP_CSG1020_PRINT(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];

                    this.DataSource = ds.Tables[0];
                }
            }
        }

        private void pageHeader_Format(object sender, EventArgs e)
        {
        }

        private void detail_Format(object sender, EventArgs e)
        {
            iCount++;
        }

        private void groupFooter1_Format(object sender, EventArgs e)
        {
            if (iCount == _dt.Rows.Count)
            {
                this.groupFooter1.NewPage = NewPage.None;
            }
            else
            {
                if (_dt.Rows[iCount - 1]["COMPANY"].ToString() == _dt.Rows[iCount]["COMPANY"].ToString())
                {
                    this.groupFooter1.NewPage = NewPage.None;
                }
                else
                {
                    this.groupFooter1.NewPage = NewPage.After;
                }
            }
        }

        private void groupFooter2_Format(object sender, EventArgs e)
        {
            if (iCount == _dt.Rows.Count)
            {
                this.groupFooter2.NewPage = NewPage.None;
            }
            else
            {
                if (_dt.Rows[iCount - 1]["COMPANY"].ToString() == _dt.Rows[iCount]["COMPANY"].ToString())
                {
                    this.groupFooter2.NewPage = NewPage.After;
                }
                else
                {
                    this.groupFooter2.NewPage = NewPage.None;
                }
            }
        }
    }
}
