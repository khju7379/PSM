﻿using System;
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
    public partial class CSS2010_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private string fsDate = string.Empty;
        private double dHAP_BOKAMT   = 0;
        private double dHAP_BOKVAT   = 0;
        private double dHAP_CHQTY    = 0;

        //private double dHAP_BOKTOTAL = 0;

        private int fiCount = 0;

        private DataTable _dt = new DataTable();

        public CSS2010_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public CSS2010_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            InitializeComponent();


            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk    = strArray[1].Split('=');
            fsDate    = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            using (TaeYoung.Biz.CSS.CSSBiz biz = new TaeYoung.Biz.CSS.CSSBiz())
            {
                ht["DATE"]  = fsDate;
                ht["HWAJU"] = TaeYoung.Biz.Document.UserInfo.KOSTL;

                DataSet ds = biz.UP_CSS2010_PRINT(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    _dt = ds.Tables[0];

                    this.DataSource = ds.Tables[0];
                }
            }
        }

        //private void pageHeader_Format(object sender, EventArgs e)
        //{
        //    _dt = (DataTable)this.DataSource;
        //}

        private void detail_Format(object sender, EventArgs e)
        {
            if (fiCount > 0)
            {
                if (_dt.Rows[fiCount - 1]["BKYSDATE"].ToString() != _dt.Rows[fiCount]["BKYSDATE"].ToString())
                {
                    dHAP_BOKAMT = dHAP_BOKAMT + double.Parse(_dt.Rows[fiCount]["BOKAMT"].ToString());

                    dHAP_CHQTY = dHAP_CHQTY + double.Parse(_dt.Rows[fiCount]["CHQTY"].ToString());
                }
                else
                {
                    dHAP_BOKAMT = dHAP_BOKAMT + double.Parse(_dt.Rows[fiCount]["BOKAMT"].ToString());

                    dHAP_CHQTY = dHAP_CHQTY + double.Parse(_dt.Rows[fiCount]["CHQTY"].ToString());
                }
            }
            else
            {
                dHAP_BOKAMT = dHAP_BOKAMT + double.Parse(_dt.Rows[fiCount]["BOKAMT"].ToString());

                dHAP_CHQTY = dHAP_CHQTY + double.Parse(_dt.Rows[fiCount]["CHQTY"].ToString());
            }

            if (double.Parse(_dt.Rows[fiCount]["CHQTY"].ToString()) == 0)
            {
                this.CHQTY.Visible = false;
            }
            else
            {
                this.CHQTY.Visible = true;
            }

            fiCount++;
        }

        private void groupFooter1_Format(object sender, EventArgs e)
        {
            GROUP_CHQTY.Text = string.Format("{0:#,##0.000}", dHAP_CHQTY);



            dHAP_BOKVAT = double.Parse(UP_DotDelete(Convert.ToString(dHAP_BOKAMT * 0.1)));

            GROUP_BOKAMT.Text   = string.Format("{0:#,##0}", dHAP_BOKAMT);
            GROUP_BOKVAT.Text   = string.Format("{0:#,##0}", dHAP_BOKVAT);
            GROUP_BOKTOTAL.Text = string.Format("{0:#,##0}", (dHAP_BOKAMT + dHAP_BOKVAT));

            dHAP_BOKAMT   = 0;
            dHAP_BOKVAT   = 0;
            //dHAP_BOKTOTAL = 0;

            dHAP_CHQTY = 0;

            this.groupFooter1.NewPage = NewPage.After;
        }

        #region Description : 소수점 이하 절삭하는 함수
        private string UP_DotDelete(string sStr)
        {
            string sValue = "";
            for (int i = 0; i < sStr.Length; i++)
            {
                if (sStr.Substring(i, 1) != ".")
                {
                    sValue = sValue + sStr.Substring(i, 1);
                }
                else
                {
                    break;
                }
            }
            return sValue;
        }
        #endregion
    }
}
