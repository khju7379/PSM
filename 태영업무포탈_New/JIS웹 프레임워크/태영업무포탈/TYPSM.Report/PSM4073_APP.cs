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
    /// Summary description for PSM4073_APP.
    /// </summary>
    public partial class PSM4073_APP : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        //private byte[] _sign1 = null;
        //private byte[] _sign2 = null;
        //private byte[] _sign3 = null;

        private int _iCnt = 0;

        public PSM4073_APP(DataTable dt)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            //_sign1 =  _dt.Rows[0]["SOIMGSIGN3"] as byte[];
            //_sign2 =  _dt.Rows[0]["SOIMGSIGN6"] as byte[];
            //_sign3 =  _dt.Rows[0]["SOIMGSIGN4"] as byte[];
            _dt = dt;
        }

        private void detail_Format(object sender, EventArgs e)
        {
            //byte[] sign = null;

            //sign = _dt.Rows[_iCnt]["IMGSIGN"] as byte[];

            //picture1.Visible = true;
            //System.IO.Stream stream = new System.IO.MemoryStream(sign);
            //picture1.Image = Bitmap.FromStream(stream);

            PECNAME.Text = _dt.Rows[_iCnt]["PECNAME"].ToString();

            if (_dt.Rows[_iCnt]["PECDATE"].ToString() != "")
            {
                picture1.Visible = true;
            }
            else
            {
                picture1.Visible = false;
            }

            if (_iCnt == 0)
            {
                PECJKCDNM.Text = "주 관 점 검 임 원 :";
            }
            else if(_iCnt == 1)
            {
                PECJKCDNM.Text = "주 관 점 검 팀 장 :";
            }
            else
            {
                PECJKCDNM.Text = "점 검 팀 장 :";
            }

            _iCnt++;
        }

        private void PSM4073_APP_ReportStart(object sender, EventArgs e)
        {

        }
    }
}
