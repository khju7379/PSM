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
    /// Summary description for CSG1030_RPT.
    /// </summary>
    public partial class CSG1030_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private string fsDate = string.Empty;

        int iCount = 0;

        public CSG1030_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSG1030_RPT(System.Collections.Specialized.NameValueCollection QueryString)
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

            using (TaeYoung.Biz.CSG.CSGBiz biz = new TaeYoung.Biz.CSG.CSGBiz())
            {
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"]         = 15;
                ht["SearchCondition"]  = "";
                ht["DATE"]             = fsDate;
                ht["HWAJU"]            = TaeYoung.Biz.Document.UserInfo.KOSTL;
                ht["GUBUN"]            = "P";

                DataSet ds = biz.UP_CSG1030_LIST(ht);

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

        private void pageHeader_Format(object sender, EventArgs e)
        {
            HWAJU.Text = TaeYoung.Biz.Document.UserInfo.UserName;
            //DATE.Text  = fsDate.ToString().Substring(0, 4) + "-" + fsDate.ToString().Substring(4, 2) + "-" + fsDate.ToString().Substring(6, 2);
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
                    //this.groupFooter1.NewPage = NewPage.After;
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
                if (_dt.Rows[iCount - 1]["COMPANY"].ToString() == _dt.Rows[iCount]["COMPANY"].ToString() && _dt.Rows[iCount - 1]["JGDATE"].ToString() == _dt.Rows[iCount]["JGDATE"].ToString())
                {
                    this.groupFooter2.NewPage = NewPage.After;
                }
                else
                {
                    this.groupFooter2.NewPage = NewPage.None; 
                }
            }
        }

        private void groupFooter3_Format(object sender, EventArgs e)
        {
            if (iCount == _dt.Rows.Count)
            {
                this.groupFooter1.NewPage = NewPage.None;
            }
            else
            {
                if (_dt.Rows[iCount - 1]["JGDATE"].ToString() == _dt.Rows[iCount]["JGDATE"].ToString())
                {
                    this.groupFooter1.NewPage = NewPage.None;
                }
                else
                {
                    this.groupFooter1.NewPage = NewPage.After;
                }
            }
        }
    }
}
