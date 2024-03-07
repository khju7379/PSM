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
    /// Summary description for ReportSample.
    /// </summary>
    public partial class ReportSample : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();
        int iCount = 0;

        private string fsDate_Fr = string.Empty;
        private string fsDate_To = string.Empty;
        

        public ReportSample()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public ReportSample(System.Collections.Specialized.NameValueCollection QueryString)
        {
            InitializeComponent();

            iCount = 0;
            
            //RPT=ReportSample&Date_Fr=20210101&Date_To=20210331&Hwaju=SSQ

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            fsDate_Fr = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            fsDate_To = ArryWk[1].ToString();


            UP_DataBing();

        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            using (TaeYoung.Biz.CSI.CSIBiz biz = new TaeYoung.Biz.CSI.CSIBiz())
            {
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"] = 15;
                ht["SearchCondition"] = "";
                ht["SDATE"] = fsDate_Fr;
                ht["EDATE"] = fsDate_To;
                ht["IPHWAJU"] = TaeYoung.Biz.Document.UserInfo.KOSTL; 
                ht["UserInfo"] = TaeYoung.Biz.Document.UserInfo;
                

                DataSet ds = biz.UP_CSI1020_LIST(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];

                    //tihsActiveReport rpt = new TYPSM.Report.ReportSample();
                    this.DataSource = ds.Tables[0];
                    //this.Run(true);

                    
                }
            }
        }

       

        private void detail_Format(object sender, EventArgs e)
        {
            //DataTable dt = this.DataSource as DataTable;

            //if (iCount <= 5)
            //{
            //    textBox1.Text = dt.Rows[iCount][1].ToString();
            //    textBox2.Text = dt.Rows[iCount][2].ToString();

            //    iCount = iCount + 1;
            //}
        }
    }
}
