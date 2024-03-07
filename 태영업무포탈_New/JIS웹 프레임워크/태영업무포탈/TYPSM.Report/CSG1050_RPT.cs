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
    /// Summary description for CSG1050_RPT.
    /// </summary>
    public partial class CSG1050_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        int iCount = 0;

        private string fsDate_Fr = string.Empty;
        private string fsDate_To = string.Empty;
        private string fsYSGUBUN = string.Empty;

        public CSG1050_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSG1050_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            iCount = 0;

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            fsDate_Fr = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            fsDate_To = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            fsYSGUBUN = ArryWk[1].ToString();

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
                ht["SDATE"]            = fsDate_Fr;
                ht["EDATE"]            = fsDate_To;
                ht["HWAJU"]            = TaeYoung.Biz.Document.UserInfo.KOSTL;
                ht["YSGUBUN"]          = fsYSGUBUN;
                ht["GUBUN"]            = "P";

                DataSet ds = biz.UP_CSG1050_LIST(ht);

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
            DATE.Text = fsDate_Fr.Substring(0, 4) + "/" + fsDate_Fr.Substring(4, 2) + "/" + fsDate_Fr.Substring(6, 2) + " ~ " +
                        fsDate_To.Substring(0, 4) + "/" + fsDate_To.Substring(4, 2) + "/" + fsDate_To.Substring(6, 2);
        }

        // 하역사별
        private void groupFooter3_Format(object sender, EventArgs e)
        {
            if (iCount == _dt.Rows.Count)
            {
                this.groupFooter3.NewPage = NewPage.None;
            }
            else
            {
                if (_dt.Rows[iCount - 1]["COMPANY"].ToString() == _dt.Rows[iCount]["COMPANY"].ToString())
                {
                    this.groupFooter3.NewPage = NewPage.None;
                }
                else
                {
                    this.groupFooter3.NewPage = NewPage.After;
                }
            }

            
        }

        // 항차
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
                    this.groupFooter1.NewPage = NewPage.After;
                }
                else
                {
                    this.groupFooter1.NewPage = NewPage.None;
                }
            }
        }
    }
}
