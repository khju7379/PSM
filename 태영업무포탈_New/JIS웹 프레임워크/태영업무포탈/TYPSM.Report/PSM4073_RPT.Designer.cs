namespace TYPSM.Report
{
    /// <summary>
    /// Summary description for PSM4073_RPT.
    /// </summary>
    partial class PSM4073_RPT
    {
        private GrapeCity.ActiveReports.SectionReportModel.PageHeader pageHeader;
        private GrapeCity.ActiveReports.SectionReportModel.Detail detail;
        private GrapeCity.ActiveReports.SectionReportModel.PageFooter pageFooter;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
            }
            base.Dispose(disposing);
        }

        #region ActiveReport Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pageHeader = new GrapeCity.ActiveReports.SectionReportModel.PageHeader();
            this.label1 = new GrapeCity.ActiveReports.SectionReportModel.Label();
            this.detail = new GrapeCity.ActiveReports.SectionReportModel.Detail();
            this.PECDDESC = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.PECDCHECK_G = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.PECDCHECK_F = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.PECDCHECK_N = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.pageFooter = new GrapeCity.ActiveReports.SectionReportModel.PageFooter();
            this.groupHeader1 = new GrapeCity.ActiveReports.SectionReportModel.GroupHeader();
            this.groupFooter1 = new GrapeCity.ActiveReports.SectionReportModel.GroupFooter();
            this.groupHeader2 = new GrapeCity.ActiveReports.SectionReportModel.GroupHeader();
            this.groupFooter2 = new GrapeCity.ActiveReports.SectionReportModel.GroupFooter();
            this.reportHeader1 = new GrapeCity.ActiveReports.SectionReportModel.ReportHeader();
            this.shape1 = new GrapeCity.ActiveReports.SectionReportModel.Shape();
            this.label7 = new GrapeCity.ActiveReports.SectionReportModel.Label();
            this.label45 = new GrapeCity.ActiveReports.SectionReportModel.Label();
            this.label46 = new GrapeCity.ActiveReports.SectionReportModel.Label();
            this.PECTITLE = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.PECINSDATE = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.PSM4073_APP = new GrapeCity.ActiveReports.SectionReportModel.SubReport();
            this.PSM4073_INS = new GrapeCity.ActiveReports.SectionReportModel.SubReport();
            this.reportFooter1 = new GrapeCity.ActiveReports.SectionReportModel.ReportFooter();
            ((System.ComponentModel.ISupportInitialize)(this.label1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDDESC)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDCHECK_G)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDCHECK_F)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDCHECK_N)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label45)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label46)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECTITLE)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECINSDATE)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeader
            // 
            this.pageHeader.Controls.AddRange(new GrapeCity.ActiveReports.SectionReportModel.ARControl[] {
            this.label1});
            this.pageHeader.Height = 0.302F;
            this.pageHeader.Name = "pageHeader";
            // 
            // label1
            // 
            this.label1.Height = 0.302F;
            this.label1.HyperLink = null;
            this.label1.Left = 6.854F;
            this.label1.Name = "label1";
            this.label1.Style = "font-family: 돋움; font-size: 8.25pt; font-weight: normal; text-align: right; text-" +
    "decoration: underline; vertical-align: middle; ddo-char-set: 129";
            this.label1.Text = "양호, 보완, 해당없음, 비고";
            this.label1.Top = 0F;
            this.label1.Width = 1.6465F;
            // 
            // detail
            // 
            this.detail.Controls.AddRange(new GrapeCity.ActiveReports.SectionReportModel.ARControl[] {
            this.PECDDESC,
            this.PECDCHECK_G,
            this.PECDCHECK_F,
            this.PECDCHECK_N});
            this.detail.Height = 0.25F;
            this.detail.Name = "detail";
            this.detail.Format += new System.EventHandler(this.detail_Format);
            // 
            // PECDDESC
            // 
            this.PECDDESC.DataField = "";
            this.PECDDESC.DistinctField = "";
            this.PECDDESC.Height = 0.25F;
            this.PECDDESC.Left = 0.062F;
            this.PECDDESC.Name = "PECDDESC";
            this.PECDDESC.Style = "color: Black; font-family: 돋움; font-size: 11.25pt; text-align: left; text-decorat" +
    "ion: none; vertical-align: middle; ddo-char-set: 129";
            this.PECDDESC.SummaryGroup = "";
            this.PECDDESC.Text = "PECDDESC";
            this.PECDDESC.Top = 0F;
            this.PECDDESC.Width = 6.93F;
            // 
            // PECDCHECK_G
            // 
            this.PECDCHECK_G.CanGrow = false;
            this.PECDCHECK_G.DataField = "";
            this.PECDCHECK_G.DistinctField = "";
            this.PECDCHECK_G.Height = 0.25F;
            this.PECDCHECK_G.Left = 7.072001F;
            this.PECDCHECK_G.Name = "PECDCHECK_G";
            this.PECDCHECK_G.Style = "color: Black; font-family: 돋움; font-size: 11.25pt; text-align: left; text-decorat" +
    "ion: none; vertical-align: middle; ddo-char-set: 129";
            this.PECDCHECK_G.SummaryGroup = "";
            this.PECDCHECK_G.Text = "PECDCHECK_G";
            this.PECDCHECK_G.Top = 0F;
            this.PECDCHECK_G.Width = 0.3049998F;
            // 
            // PECDCHECK_F
            // 
            this.PECDCHECK_F.CanGrow = false;
            this.PECDCHECK_F.DataField = "";
            this.PECDCHECK_F.DistinctField = "";
            this.PECDCHECK_F.Height = 0.25F;
            this.PECDCHECK_F.Left = 7.451001F;
            this.PECDCHECK_F.Name = "PECDCHECK_F";
            this.PECDCHECK_F.Style = "color: Black; font-family: 돋움; font-size: 11.25pt; text-align: left; text-decorat" +
    "ion: none; vertical-align: middle; ddo-char-set: 129";
            this.PECDCHECK_F.SummaryGroup = "";
            this.PECDCHECK_F.Text = "PECDCHECK_F";
            this.PECDCHECK_F.Top = 0F;
            this.PECDCHECK_F.Width = 0.3049999F;
            // 
            // PECDCHECK_N
            // 
            this.PECDCHECK_N.CanGrow = false;
            this.PECDCHECK_N.DataField = "";
            this.PECDCHECK_N.DistinctField = "";
            this.PECDCHECK_N.Height = 0.25F;
            this.PECDCHECK_N.Left = 7.826001F;
            this.PECDCHECK_N.Name = "PECDCHECK_N";
            this.PECDCHECK_N.Style = "color: Black; font-family: 돋움; font-size: 11.25pt; text-align: left; text-decorat" +
    "ion: none; vertical-align: middle; ddo-char-set: 129";
            this.PECDCHECK_N.SummaryGroup = "";
            this.PECDCHECK_N.Text = "PECDCHECK_N";
            this.PECDCHECK_N.Top = 0F;
            this.PECDCHECK_N.Width = 0.3049999F;
            // 
            // pageFooter
            // 
            this.pageFooter.Height = 0F;
            this.pageFooter.Name = "pageFooter";
            // 
            // groupHeader1
            // 
            this.groupHeader1.Height = 0F;
            this.groupHeader1.Name = "groupHeader1";
            // 
            // groupFooter1
            // 
            this.groupFooter1.Height = 0F;
            this.groupFooter1.Name = "groupFooter1";
            // 
            // groupHeader2
            // 
            this.groupHeader2.Height = 0F;
            this.groupHeader2.Name = "groupHeader2";
            // 
            // groupFooter2
            // 
            this.groupFooter2.Height = 0F;
            this.groupFooter2.Name = "groupFooter2";
            // 
            // reportHeader1
            // 
            this.reportHeader1.Controls.AddRange(new GrapeCity.ActiveReports.SectionReportModel.ARControl[] {
            this.shape1,
            this.label7,
            this.label45,
            this.label46,
            this.PECTITLE,
            this.PECINSDATE,
            this.PSM4073_APP,
            this.PSM4073_INS});
            this.reportHeader1.Height = 4.614583F;
            this.reportHeader1.Name = "reportHeader1";
            this.reportHeader1.NewPage = GrapeCity.ActiveReports.SectionReportModel.NewPage.After;
            this.reportHeader1.Format += new System.EventHandler(this.reportHeader1_Format);
            // 
            // shape1
            // 
            this.shape1.Height = 0.53125F;
            this.shape1.Left = 2.421F;
            this.shape1.Name = "shape1";
            this.shape1.RoundingRadius = new GrapeCity.ActiveReports.Controls.CornersRadius(10F, null, null, null, null);
            this.shape1.Top = 0.198F;
            this.shape1.Width = 3.510417F;
            // 
            // label7
            // 
            this.label7.Height = 0.406F;
            this.label7.HyperLink = null;
            this.label7.Left = 2.421F;
            this.label7.Name = "label7";
            this.label7.Style = "font-family: 돋움; font-size: 15.75pt; font-weight: bold; text-align: center; verti" +
    "cal-align: middle; ddo-char-set: 129";
            this.label7.Text = "가동전 안전점검표";
            this.label7.Top = 0.271F;
            this.label7.Width = 3.51F;
            // 
            // label45
            // 
            this.label45.Height = 0.302F;
            this.label45.HyperLink = null;
            this.label45.Left = 0.576F;
            this.label45.Name = "label45";
            this.label45.Style = "font-family: 돋움; font-size: 14.25pt; font-weight: normal; text-align: left; verti" +
    "cal-align: middle; ddo-char-set: 129";
            this.label45.Text = "Project    :  ";
            this.label45.Top = 1.756F;
            this.label45.Width = 1.157F;
            // 
            // label46
            // 
            this.label46.Height = 0.302F;
            this.label46.HyperLink = null;
            this.label46.Left = 0.576F;
            this.label46.Name = "label46";
            this.label46.Style = "font-family: 돋움; font-size: 14.25pt; font-weight: normal; text-align: left; verti" +
    "cal-align: middle; ddo-char-set: 129";
            this.label46.Text = "점검일자  :  ";
            this.label46.Top = 2.548F;
            this.label46.Width = 1.157F;
            // 
            // PECTITLE
            // 
            this.PECTITLE.CanGrow = false;
            this.PECTITLE.DataField = "PECTITLE";
            this.PECTITLE.DistinctField = "";
            this.PECTITLE.Height = 0.302F;
            this.PECTITLE.Left = 1.84F;
            this.PECTITLE.Name = "PECTITLE";
            this.PECTITLE.Style = "color: Black; font-family: 돋움; font-size: 13.25pt; text-align: left; text-decorat" +
    "ion: none; vertical-align: middle; ddo-char-set: 1";
            this.PECTITLE.SummaryGroup = "";
            this.PECTITLE.Text = "PECTITLE";
            this.PECTITLE.Top = 1.756F;
            this.PECTITLE.Width = 6.139F;
            // 
            // PECINSDATE
            // 
            this.PECINSDATE.CanGrow = false;
            this.PECINSDATE.DataField = "PECINSDATE";
            this.PECINSDATE.DistinctField = "";
            this.PECINSDATE.Height = 0.302F;
            this.PECINSDATE.Left = 1.84F;
            this.PECINSDATE.Name = "PECINSDATE";
            this.PECINSDATE.Style = "color: Black; font-family: 돋움; font-size: 13.25pt; text-align: left; text-decorat" +
    "ion: none; vertical-align: middle; ddo-char-set: 1";
            this.PECINSDATE.SummaryGroup = "";
            this.PECINSDATE.Text = "PECINSDATE";
            this.PECINSDATE.Top = 2.548F;
            this.PECINSDATE.Width = 1.504F;
            // 
            // PSM4073_APP
            // 
            this.PSM4073_APP.CloseBorder = false;
            this.PSM4073_APP.Height = 0.375F;
            this.PSM4073_APP.Left = 0.22F;
            this.PSM4073_APP.Name = "PSM4073_APP";
            this.PSM4073_APP.Report = null;
            this.PSM4073_APP.ReportName = "PSM4073_APP";
            this.PSM4073_APP.Top = 3.606F;
            this.PSM4073_APP.Width = 6F;
            // 
            // PSM4073_INS
            // 
            this.PSM4073_INS.CloseBorder = false;
            this.PSM4073_INS.Height = 0.375F;
            this.PSM4073_INS.Left = 0.22F;
            this.PSM4073_INS.Name = "PSM4073_INS";
            this.PSM4073_INS.Report = null;
            this.PSM4073_INS.ReportName = "PSM4073_INS";
            this.PSM4073_INS.Top = 3.985F;
            this.PSM4073_INS.Width = 6F;
            // 
            // reportFooter1
            // 
            this.reportFooter1.Height = 0F;
            this.reportFooter1.Name = "reportFooter1";
            // 
            // PSM4073_RPT
            // 
            this.PageSettings.Margins.Bottom = 0.5F;
            this.PageSettings.Margins.Left = 0.4F;
            this.PageSettings.Margins.Right = 0.4F;
            this.PageSettings.Margins.Top = 0.5F;
            this.PageSettings.PaperHeight = 11F;
            this.PageSettings.PaperWidth = 8.5F;
            this.PrintWidth = 8.5005F;
            this.Sections.Add(this.reportHeader1);
            this.Sections.Add(this.pageHeader);
            this.Sections.Add(this.groupHeader1);
            this.Sections.Add(this.groupHeader2);
            this.Sections.Add(this.detail);
            this.Sections.Add(this.groupFooter2);
            this.Sections.Add(this.groupFooter1);
            this.Sections.Add(this.pageFooter);
            this.Sections.Add(this.reportFooter1);
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Arial; font-style: normal; text-decoration: none; font-weight: norma" +
            "l; font-size: 10pt; color: Black", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 16pt; font-weight: bold", "Heading1", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Times New Roman; font-size: 14pt; font-weight: bold; font-style: ita" +
            "lic", "Heading2", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 13pt; font-weight: bold", "Heading3", "Normal"));
            ((System.ComponentModel.ISupportInitialize)(this.label1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDDESC)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDCHECK_G)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDCHECK_F)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECDCHECK_N)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label45)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label46)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECTITLE)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECINSDATE)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion
        private GrapeCity.ActiveReports.SectionReportModel.GroupHeader groupHeader1;
        private GrapeCity.ActiveReports.SectionReportModel.GroupFooter groupFooter1;
        private GrapeCity.ActiveReports.SectionReportModel.GroupHeader groupHeader2;
        private GrapeCity.ActiveReports.SectionReportModel.GroupFooter groupFooter2;
        private GrapeCity.ActiveReports.SectionReportModel.Label label1;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox PECDDESC;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox PECDCHECK_G;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox PECDCHECK_F;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox PECDCHECK_N;
        private GrapeCity.ActiveReports.SectionReportModel.ReportHeader reportHeader1;
        private GrapeCity.ActiveReports.SectionReportModel.Shape shape1;
        private GrapeCity.ActiveReports.SectionReportModel.Label label7;
        private GrapeCity.ActiveReports.SectionReportModel.Label label45;
        private GrapeCity.ActiveReports.SectionReportModel.Label label46;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox PECTITLE;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox PECINSDATE;
        private GrapeCity.ActiveReports.SectionReportModel.ReportFooter reportFooter1;
        private GrapeCity.ActiveReports.SectionReportModel.SubReport PSM4073_APP;
        private GrapeCity.ActiveReports.SectionReportModel.SubReport PSM4073_INS;
    }
}
