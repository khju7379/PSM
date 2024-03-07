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
    /// Summary description for PSM1070_RPT.
    /// </summary>
    public partial class PSM1070_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private string fsCISBCODE = string.Empty;
        private string fsCIGRCODE = string.Empty;
        private string fsCIGRSEQ = string.Empty;

        int iCount = 0;
        int iNum = 1;
        int i = 0;
        string fsGubn = string.Empty;

        public PSM1070_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public PSM1070_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();


            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            fsCISBCODE = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            fsCIGRCODE = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            fsCIGRSEQ = ArryWk[1].ToString();
            ArryWk = strArray[4].Split('=');
            fsGubn = ArryWk[1].ToString();


            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            using (TaeYoung.Biz.PSM.PSM1070 biz = new TaeYoung.Biz.PSM.PSM1070())
            {
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"] = 100000;
                ht["CISBCODE"] = fsCISBCODE;
                ht["CIGRCODE"] = fsCIGRCODE;
                ht["CIGRSEQ"] = fsCIGRSEQ;
                //ht["P_MENU_NAME"] = fsCISBCODE + "_" + fsCIGRCODE + "_" + fsCIGRSEQ;

                DataSet ds = biz.UP_GET_CHECKLIST_PRT(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    this.DataSource = ds.Tables[0];
                }
            
                ht = new Hashtable();

                ht["P_MENU_NAME"] = fsCISBCODE + "_" + fsCIGRCODE + "_" + fsCIGRSEQ;

                ds = biz.UP_CHECKLIST_MENU_RUN(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];
                }
            }
        }

        private void pageHeader_Format(object sender, EventArgs e)
        {
            if (_dt.Rows[0]["CMDESC"].ToString() != "")
            {
                this.CMDESC.Text = "장치 및 번호 : " + _dt.Rows[0]["CMDESC"].ToString();
            }
            else
            {
                this.CMDESC.Text = "";
            }
            this.CDDESC1.Text = "대　 　 　상 : " + _dt.Rows[0]["CDDESC1"].ToString();
            if (fsGubn == "1")
            {
                DataTable dt = this.DataSource as DataTable;
                this.KBHANGL.Text = "작 성 자 : " + dt.Rows[0]["CKMWRKBHANGL"].ToString();
                this.DATE.Text = "작성일자 : " + dt.Rows[0]["DATE1"].ToString();
                this.KBHANGL2.Text = "평 가 검토자 : " + dt.Rows[0]["CKMAPPKBHANGL"].ToString();
                this.DATE2.Text = "평가검토일자 : " + dt.Rows[0]["DATE2"].ToString();
            }
            else
            {
                this.KBHANGL.Text = "";
                this.DATE.Text = "";
                this.KBHANGL2.Text = "작 성 자 : " + _dt.Rows[0]["KBHANGL"].ToString();
                this.DATE2.Text = "작성일자 : " + _dt.Rows[0]["CMWRDATE"].ToString();
            }
        }

        private void detail_Format(object sender, EventArgs e)
        {
            DataTable dt = this.DataSource as DataTable;

            if (iCount == 0)
            {
                this.ROWNUM.Text = iNum.ToString();

                if (dt.Rows.Count > 1)
                {
                    if (dt.Rows[iCount]["CIEVAITEM"].ToString() == dt.Rows[iCount + 1]["CIEVAITEM"].ToString())
                    {
                        this.line_S.Visible = true;
                        this.line_L.Visible = false;
                        i++;
                    }
                    else
                    {
                        this.line_S.Visible = false;
                        this.line_L.Visible = true;
                    }
                }
                iNum++;

            }
            else
            {
                if (i != 0)
                {
                    this.CIEVAITEM.Text = "";
                    this.CIEVASTD.Text = "";
                }
                //마지막 줄
                if (iCount == dt.Rows.Count - 1)
                {
                    this.line_L.Visible = true;
                    this.line_S.Visible = false;
                    if (dt.Rows[iCount]["CIEVAITEM"].ToString() != dt.Rows[iCount - 1]["CIEVAITEM"].ToString())
                    {
                        this.ROWNUM.Text = iNum.ToString();
                    }
                    else
                    {
                        this.ROWNUM.Text = "";
                    }
                }
                else
                {
                    if (dt.Rows[iCount]["CIEVAITEM"].ToString() != dt.Rows[iCount + 1]["CIEVAITEM"].ToString())
                    {
                        this.line_L.Visible = true;
                        this.line_S.Visible = false;
                        i = 0;
                    }
                    else
                    {
                        this.line_L.Visible = false;
                        this.line_S.Visible = true;

                        i++;
                    }
                    if (dt.Rows[iCount]["CIEVAITEM"].ToString() != dt.Rows[iCount - 1]["CIEVAITEM"].ToString())
                    {
                        this.ROWNUM.Text = iNum.ToString();
                        iNum++;
                    }
                    else
                    {
                        this.ROWNUM.Text = "";
                    }
                }
            }
            iCount++;
        }
    }
}
