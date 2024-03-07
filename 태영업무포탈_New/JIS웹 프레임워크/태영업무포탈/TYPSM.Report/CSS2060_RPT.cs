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
    /// Summary description for TYUTME017R.
    /// </summary>
    public partial class CSS2060_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private string fsDate = string.Empty;
        private int fiMaxCnt = 0;
        private DataTable _dt = new DataTable();

        public CSS2060_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSS2060_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
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

                DataSet ds = biz.UP_CSS2060_LIST(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];

                    this.DataSource = ds.Tables[0];

                    fiMaxCnt = _dt.Rows.Count;
                }
            }
        }

        //private void pageHeader_Format(object sender, EventArgs e)
        //{
        //    _dt = (DataTable)this.DataSource;
        //    fiMaxCnt = _dt.Rows.Count;
        //}

        private void detail_Format(object sender, EventArgs e)
        {
            //if (fiCount > 0)
            //{
            //    if (_dt.Rows[fiCount - 1]["VNSAUPJA"].ToString() != _dt.Rows[fiCount]["VNSAUPJA"].ToString())
            //    {
            //        this.detail.NewPage = NewPage.Before;
            //    }
            //    else
            //    {
            //        this.detail.NewPage = NewPage.None;
            //    }
            //}

            //fiCount++;
        }

        private void groupFooter1_Format(object sender, EventArgs e)
        {
            this.groupFooter1.NewPage = NewPage.After;
        }        
    }
}
