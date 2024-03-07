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
    /// Summary description for CSS1050_RPT.
    /// </summary>
    public partial class CSS1050_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private string fsDate = string.Empty;

        public CSS1050_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSS1050_RPT(System.Collections.Specialized.NameValueCollection QueryString)
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
            Hashtable ht = new Hashtable();

            using (TaeYoung.Biz.CSS.CSSBiz biz = new TaeYoung.Biz.CSS.CSSBiz())
            {
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"]         = 15;
                ht["SearchCondition"]  = "";
                ht["DATE"]             = fsDate;
                ht["HWAJU"]            = TaeYoung.Biz.Document.UserInfo.KOSTL;
                ht["GUBUN"]            = "P";

                DataSet ds = biz.UP_CSS1050_LIST(ht);

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
            DATE.Text  = fsDate.ToString().Substring(0, 4) + "-" + fsDate.ToString().Substring(4, 2) + "-" + fsDate.ToString().Substring(6, 2);
        }

        private void groupFooter1_Format(object sender, EventArgs e)
        {
            this.groupFooter1.NewPage = NewPage.After;
        }
    }
}
