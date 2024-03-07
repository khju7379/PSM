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
    /// Summary description for CSI1060_RPT.
    /// </summary>
    public partial class CSI1060_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();
        int iCount = 0;

        private string fsDate = string.Empty;

        public CSI1060_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSI1060_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            iCount = 0;

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            fsDate = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            using (TaeYoung.Biz.CSI.CSIBiz biz = new TaeYoung.Biz.CSI.CSIBiz())
            {
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"] = 100000;
                ht["SearchCondition"] = "";
                ht["DATE"] = fsDate;
                ht["IPHWAJU"] = TaeYoung.Biz.Document.UserInfo.KOSTL;
                ht["UserInfo"] = TaeYoung.Biz.Document.UserInfo;
                ht["GUBUN"] = "P";


                DataSet ds = biz.UP_CSI1060_LIST(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];

                    this.DataSource = ds.Tables[0];
                }
            }
        }

        private void pageHeader_Format(object sender, EventArgs e)
        {
            HWAJU.Text = TaeYoung.Biz.Document.UserInfo.UserName;
            DATE.Text = fsDate.Substring(0, 4) + "/" + fsDate.Substring(4, 2) + "/" + fsDate.Substring(6, 2);
        }

        private void detail_Format(object sender, EventArgs e)
        {
            iCount++;
        }

        private void groupFooter1_Format(object sender, EventArgs e)
        {
            if (iCount == _dt.Rows.Count)
            {
                groupFooter1.NewPage = NewPage.None;
            }
            else
            {
                groupFooter1.NewPage = NewPage.After;
            }
        }
    }
}
