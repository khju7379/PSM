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
    /// Summary description for CSS1080_RPT.
    /// </summary>
    public partial class CSS1080_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private int fiCount = 0;

        private int fi_GK_CarCnt  = 0;
        private int fi_Day_CarCnt = 0;
        private int fi_TOT_CarCnt = 0;

        private string fsDate_Fr = string.Empty;
        private string fsDate_To = string.Empty;

        public CSS1080_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSS1080_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();


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

            using (TaeYoung.Biz.CSS.CSSBiz biz = new TaeYoung.Biz.CSS.CSSBiz())
            {
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"]         = 15;
                ht["SearchCondition"]  = "";
                ht["SDATE"]            = fsDate_Fr;
                ht["EDATE"]            = fsDate_To;
                ht["HWAJU"]            = TaeYoung.Biz.Document.UserInfo.KOSTL;
                ht["GUBUN"]            = "P";

                DataSet ds = biz.UP_CSS1080_LIST(ht);

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
            DATE.Text = fsDate_Fr.Substring(0, 4) + "/" + fsDate_Fr.Substring(4, 2) + "/" + fsDate_Fr.Substring(6, 2) + " ~ " +
                        fsDate_To.Substring(0, 4) + "/" + fsDate_To.Substring(4, 2) + "/" + fsDate_To.Substring(6, 2);
        }

        private void detail_Format(object sender, EventArgs e)
        {
            if (fiCount > 0)
            {
                if (_dt.Rows[fiCount - 1]["GKDESC1"].ToString() == _dt.Rows[fiCount]["GKDESC1"].ToString())
                {
                    fi_GK_CarCnt++;

                    if (_dt.Rows[fiCount - 1]["CHCHULDAT"].ToString() == _dt.Rows[fiCount]["CHCHULDAT"].ToString())
                    {
                        fi_Day_CarCnt++;
                    }
                }
                else
                {
                }
            }
            else if (fiCount == 0)
            {
                fi_GK_CarCnt++;
                fi_Day_CarCnt++;
            }

            fi_TOT_CarCnt++;

            fiCount++;
        }

        // 총합계
        private void groupFooter1_Format(object sender, EventArgs e)
        {
            this.TOT_CarCnt.Text = Convert.ToString(fi_TOT_CarCnt);
        }

        private void groupFooter2_Format(object sender, EventArgs e)
        {
            
        }

        // 곡종
        private void groupFooter3_Format(object sender, EventArgs e)
        {
            this.GK_CarCnt.Text = Convert.ToString(fi_GK_CarCnt);

            fi_GK_CarCnt = 1;

            this.groupFooter3.NewPage = NewPage.After;
        }

        // 출고일자
        private void groupFooter4_Format(object sender, EventArgs e)
        {
            this.Day_CarCnt.Text = Convert.ToString(fi_Day_CarCnt);

            fi_Day_CarCnt = 1;
        }
    }
}
