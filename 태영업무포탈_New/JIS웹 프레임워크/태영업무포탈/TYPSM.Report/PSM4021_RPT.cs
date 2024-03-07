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
    /// Summary description for PSM4021_RPT.
    /// </summary>
    public partial class PSM4021_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private string _CAASKTEAM = string.Empty;
        private string _CAASKDATE = string.Empty;
        private string _CAASKSEQ = string.Empty;

        public PSM4021_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            _CAASKTEAM = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            _CAASKDATE = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            _CAASKSEQ = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();


            using (TaeYoung.Biz.PSM.PSM4020 biz = new TaeYoung.Biz.PSM.PSM4020())
            {

                // 변경요구서 조회
                ht = new Hashtable();

                ht["P_CAASKTEAM"] = _CAASKTEAM;
                ht["P_CAASKDATE"] = _CAASKDATE;
                ht["P_CAASKSEQ"] = _CAASKSEQ;                

                DataSet ds = biz.UP_CHANGEASK_DOC_PRT(ht);

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
                if(_dt.Rows[0]["CAASKSTEPGN1"].ToString() == "Y")
                {
                    CAASKSTEPGN1.Text = "○";
                    CAASKSTEPGN2.Text = "";
                    CAASKSTEPGN3.Text = "";
                    CAASKSTEPGN4.Text = "";
                }
                else if (_dt.Rows[0]["CAASKSTEPGN2"].ToString() == "Y")
                {
                    CAASKSTEPGN1.Text = "";
                    CAASKSTEPGN2.Text = "○";
                    CAASKSTEPGN3.Text = "";
                    CAASKSTEPGN4.Text = "";
                }
                else if (_dt.Rows[0]["CAASKSTEPGN3"].ToString() == "Y")
                {
                    CAASKSTEPGN1.Text = "";
                    CAASKSTEPGN2.Text = "";
                    CAASKSTEPGN3.Text = "○";
                    CAASKSTEPGN4.Text = "";
                }
                else if (_dt.Rows[0]["CAASKSTEPGN4"].ToString() == "Y")
                {
                    CAASKSTEPGN1.Text = "";
                    CAASKSTEPGN2.Text = "";
                    CAASKSTEPGN3.Text = "";
                    CAASKSTEPGN4.Text = "○";
                }

                for (int i = 0; i < _dt.Rows.Count; i++)
                {
                    if (_dt.Rows[i]["FILE_NAME"].ToString() != "")
                    {
                        if (i == 0)
                        {
                            sAttachFile = sAttachFile + (i + 1) + ") " + _dt.Rows[0]["FILE_NAME"].ToString();
                        }
                        else
                        {
                            sAttachFile = sAttachFile + "\n" + (i + 1) + ") " + _dt.Rows[0]["FILE_NAME"].ToString();
                        }
                    }
                }

                FILE_NAME.Text = sAttachFile;
            }
        }
    }
}
