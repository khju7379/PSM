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
    /// Summary description for PSM4011_RPT.
    /// </summary>
    public partial class PSM4011_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();
        private DataTable _dt2 = new DataTable();

        private string _TEAM = string.Empty;
        private string _DATE = string.Empty;
        private string _SEQ = string.Empty;

        public PSM4011_RPT()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        public PSM4011_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();


            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            _TEAM = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            _DATE = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            _SEQ = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();

            using (TaeYoung.Biz.PSM.PSM4010 biz = new TaeYoung.Biz.PSM.PSM4010())
            {

                // 작업요청서 조회
                ht = new Hashtable();

                ht["P_WOORTEAM"] = _TEAM;
                ht["P_WOORDATE"] = _DATE;
                ht["P_WOSEQ"] = _SEQ;

                DataSet ds = biz.UP_WORKORDER_PRT(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    this.DataSource = ds.Tables[0];
                }
            }
        }

        private void reportHeader1_Format(object sender, EventArgs e)
        {
            if(WOAPPSOTIME1.Text == "")
            {
                SIGN1.Visible = false;
            }
            if (WOAPPSOTIME2.Text == "")
            {
                SIGN2.Visible = false;
            }
            if (WOAPPSOTIME3.Text == "")
            {
                SIGN3.Visible = false;
            }
            if (WOAPPSOTIME4.Text == "")
            {
                SIGN4.Visible = false;
            }
            if (WOAPPSOTIME5.Text == "")
            {
                SIGN5.Visible = false;
            }
            if (WOAPPRETIME1.Text == "")
            {
                SIGN6.Visible = false;
            }
            if (WOAPPRETIME2.Text == "")
            {
                SIGN7.Visible = false;
            }
            if (WOAPPRETIME3.Text == "")
            {
                SIGN8.Visible = false;
            }
            if (WOAPPRETIME4.Text == "")
            {
                SIGN9.Visible = false;
            }
            if (WOAPPRETIME5.Text == "")
            {
                SIGN10.Visible = false;
            }
        }

        private void PSM4011_RPT_ReportStart(object sender, EventArgs e)
        {

        }
    }
}
