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
    /// Summary description for CSI1080_RPT.
    /// </summary>
    public partial class CSI1080_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();
        int iCount = 0;

        private string fsDate = string.Empty;

        public CSI1080_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSI1080_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            iCount = 0;

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
                ht["IPHWAJU"] = TaeYoung.Biz.Document.UserInfo.KOSTL;
                ht["UserInfo"] = TaeYoung.Biz.Document.UserInfo;
                ht["GUBUN"] = "P";


                DataSet ds = biz.UP_CSI1080_LIST(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];

                    this.DataSource = ds.Tables[0];
                }
            }
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
