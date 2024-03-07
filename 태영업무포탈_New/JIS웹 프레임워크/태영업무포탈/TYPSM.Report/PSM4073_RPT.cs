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
    /// Summary description for PSM4073_RPT.
    /// </summary>
    public partial class PSM4073_RPT : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();
        private DataTable _dtApproval = new DataTable();
        private DataTable _dtInspect = new DataTable();

        //private byte[] _sign1 = null;
        //private byte[] _sign2 = null;
        //private byte[] _sign3 = null;

        private string _PECTEAM = string.Empty;
        private string _PECDATE = string.Empty;
        private string _PECSEQ = string.Empty;

        private int _iCnt = 0;

        public PSM4073_RPT(System.Collections.Specialized.NameValueCollection QueryString)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            string[] ArryWk;

            string[] strArray = QueryString.ToString().Split('&');

            ArryWk = strArray[1].Split('=');
            _PECTEAM = ArryWk[1].ToString();
            ArryWk = strArray[2].Split('=');
            _PECDATE = ArryWk[1].ToString();
            ArryWk = strArray[3].Split('=');
            _PECSEQ = ArryWk[1].ToString();

            UP_DataBing();
        }

        private void UP_DataBing()
        {
            Hashtable ht = new Hashtable();


            using (TaeYoung.Biz.PSM.PSM4070 biz = new TaeYoung.Biz.PSM.PSM4070())
            {

                // 가동전 점검 조회
                ht = new Hashtable();

                ht["P_PECTEAM"] = _PECTEAM;
                ht["P_PECDATE"] = _PECDATE;
                ht["P_PECSEQ"] = _PECSEQ;

                DataSet ds = biz.UP_EXAM_CHECK_PRT(ht);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    this.DataSource = ds.Tables[0];
                }

                _dt = ds.Tables[0];

                _dtApproval = ds.Tables[1];

                _dtInspect = ds.Tables[2];

                //_sign1 =  _dt.Rows[0]["SOIMGSIGN3"] as byte[];
                //_sign2 =  _dt.Rows[0]["SOIMGSIGN6"] as byte[];
                //_sign3 =  _dt.Rows[0]["SOIMGSIGN4"] as byte[];
            }

        }

        private void reportHeader1_Format(object sender, EventArgs e)
        {
            PSM4073_APP subReport = new PSM4073_APP(_dtApproval);
            subReport.DataSource = _dtApproval;
            PSM4073_APP.Report = subReport;

            PSM4073_INS subReport2 = new PSM4073_INS(_dtInspect);
            subReport2.DataSource = _dtInspect;
            PSM4073_INS.Report = subReport2;
        }

        private void detail_Format(object sender, EventArgs e)
        {
            int iLevel = Convert.ToInt32(_dt.Rows[_iCnt]["PECLEVEL"].ToString());
            string space = string.Empty;

            if(iLevel == 1)
            {
                PECDDESC.Font = new System.Drawing.Font("돋움", 13, System.Drawing.FontStyle.Bold);
            }
            else
            {
                for (int i = 1; i < iLevel; i++)
                {
                    space += "　";
                }
                PECDDESC.Font = new System.Drawing.Font("돋움", 11, System.Drawing.FontStyle.Regular);
            }

            PECDDESC.Text = space + _dt.Rows[_iCnt]["PECDDESC"].ToString();

            if (_dt.Rows[_iCnt]["PECCCHECK"].ToString() == "Y")
            {
                if (_dt.Rows[_iCnt]["PECDCHECK_G"].ToString() == "Y")
                {
                    PECDCHECK_G.Text = "▣";
                    PECDCHECK_F.Text = "□";
                    PECDCHECK_N.Text = "□";
                }
                else if (_dt.Rows[_iCnt]["PECDCHECK_F"].ToString() == "Y")
                {
                    PECDCHECK_G.Text = "□";
                    PECDCHECK_F.Text = "▣";
                    PECDCHECK_N.Text = "□";
                }
                else if (_dt.Rows[_iCnt]["PECDCHECK_N"].ToString() == "Y")
                {
                    PECDCHECK_G.Text = "□";
                    PECDCHECK_F.Text = "□";
                    PECDCHECK_N.Text = "▣";
                }
                else
                {
                    PECDCHECK_G.Text = "□";
                    PECDCHECK_F.Text = "□";
                    PECDCHECK_N.Text = "□";
                }
            }
            else
            {
                PECDCHECK_G.Text = "";
                PECDCHECK_F.Text = "";
                PECDCHECK_N.Text = "";
            }

            _iCnt++;
        }

        
    }
}
