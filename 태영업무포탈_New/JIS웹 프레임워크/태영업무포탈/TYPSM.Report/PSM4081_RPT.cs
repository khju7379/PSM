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
    /// Summary description for PSM4081_RPT.
    /// </summary>
    public partial class PSM4081_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private string _PERTCTEAM = string.Empty;
        private string _PERTCDATE = string.Empty;
        private string _PERTCSEQ = string.Empty;
        private string _PERDATE = string.Empty;
        private string _PERSEQ = string.Empty;

        public PSM4081_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            _PERTCTEAM = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            _PERTCDATE = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            _PERTCSEQ = ArryWk[1].ToString();
            ArryWk = strArray[4].Split('=');
            _PERDATE = ArryWk[1].ToString();
            ArryWk = strArray[5].Split('=');
            _PERSEQ = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();


            using (TaeYoung.Biz.PSM.PSM4080 biz = new TaeYoung.Biz.PSM.PSM4080())
            {

                ht = new Hashtable();

                ht["P_PERTCTEAM"] = _PERTCTEAM;
                ht["P_PERTCDATE"] = _PERTCDATE;
                ht["P_PERTCSEQ"] = _PERTCSEQ;
                ht["P_PERDATE"] = _PERDATE;
                ht["P_PERSEQ"] = _PERSEQ;

                DataSet ds = biz.UP_EXAM_REPORT_RUN(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    this.DataSource = ds.Tables[0];
                }
            }
        }

        private void detail_Format(object sender, EventArgs e)
        {

        }

        private void reportHeader1_Format(object sender, EventArgs e)
        {
            DataTable dt = this.DataSource as DataTable;

            PERTCDATE.Text = dt.Rows[0]["PERTCDATE"].ToString().Substring(0, 4) + "³â " + dt.Rows[0]["PERTCDATE"].ToString().Substring(4, 2) + "¿ù " + dt.Rows[0]["PERTCDATE"].ToString().Substring(6, 2) + "ÀÏ";
        }
    }
}
