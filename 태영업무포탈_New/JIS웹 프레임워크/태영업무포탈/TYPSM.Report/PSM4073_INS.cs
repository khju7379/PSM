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
    /// Summary description for PSM4073_INS.
    /// </summary>
    public partial class PSM4073_INS : GrapeCity.ActiveReports.SectionReport
    {
        private DataTable _dt = new DataTable();

        private int _iCnt = 0;

        public PSM4073_INS(DataTable dt)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            _dt = dt;
        }

        private void detail_Format(object sender, EventArgs e)
        {
            byte[] sign = null;

            sign = _dt.Rows[_iCnt]["IMGSIGN"] as byte[];

            picture1.Visible = true;
            System.IO.Stream stream = new System.IO.MemoryStream(sign);
            picture1.Image = Bitmap.FromStream(stream);

            KBHANGL.Text = _dt.Rows[_iCnt]["KBHANGL"].ToString();

            PECJKCDNM.Text = "점 검 원 :";

            //if (_iCnt == 0)
            //{
            //    PECJKCDNM.Text = "주 관 점 검 임 원 :";
            //}
            //else if(_iCnt == 1)
            //{
            //    PECJKCDNM.Text = "주 관 점 검 팀 장 :";
            //}
            //else
            //{
            //    PECJKCDNM.Text = "점 검 팀 장 :";
            //}

            _iCnt++;
        }
    }
}
