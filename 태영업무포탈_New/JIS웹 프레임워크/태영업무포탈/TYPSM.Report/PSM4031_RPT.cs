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
    /// Summary description for PSM4031_RPT.
    /// </summary>
    public partial class PSM4031_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private string _CRREVTEAM = string.Empty;
        private string _CRREVDATE = string.Empty;
        private string _CRREVSEQ = string.Empty;

        public PSM4031_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            _CRREVTEAM = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            _CRREVDATE = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            _CRREVSEQ = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();


            using (TaeYoung.Biz.PSM.PSM4030 biz = new TaeYoung.Biz.PSM.PSM4030())
            {

                // 변경요구서 조회
                ht = new Hashtable();

                ht["P_CRREVTEAM"] = _CRREVTEAM;
                ht["P_CRREVDATE"] = _CRREVDATE;
                ht["P_CRREVSEQ"] = _CRREVSEQ;                

                DataSet ds = biz.UP_CHANGEREV_DOC_PRT(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    this.DataSource = ds.Tables[0];
                }

                _dt = ds.Tables[0];
            }

        }
        private void reportHeader1_Format(object sender, EventArgs e)
        {
            string sAttachFile = string.Empty;

            if(_dt.Rows.Count > 0)
            {
                if(_dt.Rows[0]["CRREVAPPROVAL"].ToString() == "Y")
                {
                    CRREVAPPROVAL1.Text = "( ○ )";
                    CRREVAPPROVAL2.Text = "(    )";
                }
                else
                {
                    CRREVAPPROVAL1.Text = "(    )";
                    CRREVAPPROVAL2.Text = "( ○ )";
                }

                for (int i = 0; i < _dt.Rows.Count; i++)
                {
                    if(_dt.Rows[i]["FILE_NAME"].ToString() != "")
                    { 
                        if (i == 0) {
                            sAttachFile = sAttachFile + (i + 1) + ") " + _dt.Rows[0]["FILE_NAME"].ToString();
                        }
                        else
                        {
                            sAttachFile = sAttachFile + "\n" + (i + 1) + ") " + _dt.Rows[0]["FILE_NAME"].ToString();
                        }
                    }
                }

                FILE_NAME.Text = sAttachFile;

                if (_dt.Rows[0]["CRREVTIME1"].ToString() == "")
                {
                    IMGSIGN1.Visible = false;
                }
                if (_dt.Rows[0]["CRREVTIME2"].ToString() == "")
                {
                    IMGSIGN2.Visible = false;
                }
                if (_dt.Rows[0]["CRREVTIME3"].ToString() == "")
                {
                    IMGSIGN3.Visible = false;
                }
                if (_dt.Rows[0]["CRREVTIME4"].ToString() == "")
                {
                    IMGSIGN4.Visible = false;
                }
                if (_dt.Rows[0]["CRREVTIME5"].ToString() == "")
                {
                    IMGSIGN5.Visible = false;
                }
                if (_dt.Rows[0]["CRREVTIME6"].ToString() == "")
                {
                    IMGSIGN6.Visible = false;
                }
                if (_dt.Rows[0]["CRREVAPPTIME"].ToString() == "")
                {
                    IMGSIGN7.Visible = false;
                }
            }
        }
    }
}
