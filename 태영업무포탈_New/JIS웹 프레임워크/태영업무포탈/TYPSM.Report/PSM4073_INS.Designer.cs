namespace TYPSM.Report
{
    /// <summary>
    /// Summary description for PSM4073_INS.
    /// </summary>
    partial class PSM4073_INS
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
            this.PECJKCDNM = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.KBHANGL = new GrapeCity.ActiveReports.SectionReportModel.TextBox();
            this.picture1 = new GrapeCity.ActiveReports.SectionReportModel.Picture();
            this.label46 = new GrapeCity.ActiveReports.SectionReportModel.Label();
            this.pageFooter = new GrapeCity.ActiveReports.SectionReportModel.PageFooter();
            ((System.ComponentModel.ISupportInitialize)(this.label1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECJKCDNM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.KBHANGL)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.picture1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label46)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeader
            // 
            this.pageHeader.Controls.AddRange(new GrapeCity.ActiveReports.SectionReportModel.ARControl[] {
            this.label1});
            this.pageHeader.Height = 0F;
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
            this.PECJKCDNM,
            this.KBHANGL,
            this.picture1,
            this.label46});
            this.detail.Height = 0.45F;
            this.detail.Name = "detail";
            this.detail.Format += new System.EventHandler(this.detail_Format);
            // 
            // PECJKCDNM
            // 
            this.PECJKCDNM.CanGrow = false;
            this.PECJKCDNM.DataField = "";
            this.PECJKCDNM.DistinctField = "";
            this.PECJKCDNM.Height = 0.25F;
            this.PECJKCDNM.Left = 0.072F;
            this.PECJKCDNM.Name = "PECJKCDNM";
            this.PECJKCDNM.Style = "color: Black; font-family: 돋움; font-size: 14.25pt; text-align: right; text-decora" +
    "tion: none; vertical-align: middle; ddo-char-set: 1";
            this.PECJKCDNM.SummaryGroup = "";
            this.PECJKCDNM.Text = "PECJKCDNM";
            this.PECJKCDNM.Top = 0.04F;
            this.PECJKCDNM.Width = 1.972001F;
            // 
            // KBHANGL
            // 
            this.KBHANGL.CanGrow = false;
            this.KBHANGL.DataField = "";
            this.KBHANGL.DistinctField = "";
            this.KBHANGL.Height = 0.25F;
            this.KBHANGL.Left = 2.337F;
            this.KBHANGL.Name = "KBHANGL";
            this.KBHANGL.Style = "color: Black; font-family: 돋움; font-size: 14.25pt; text-align: left; text-decorat" +
    "ion: none; vertical-align: middle; ddo-char-set: 1";
            this.KBHANGL.SummaryGroup = "";
            this.KBHANGL.Text = "KBHANGL";
            this.KBHANGL.Top = 0.04F;
            this.KBHANGL.Width = 0.806F;
            // 
            // picture1
            // 
            this.picture1.DataField = "IMGSIGN";
            this.picture1.Height = 0.38F;
            this.picture1.ImageData = null;
            this.picture1.Left = 3.745001F;
            this.picture1.Name = "picture1";
            this.picture1.SizeMode = GrapeCity.ActiveReports.SectionReportModel.SizeModes.Zoom;
            this.picture1.Top = 0.006F;
            this.picture1.Width = 0.919F;
            // 
            // label46
            // 
            this.label46.Height = 0.25F;
            this.label46.HyperLink = null;
            this.label46.Left = 3.243F;
            this.label46.Name = "label46";
            this.label46.Style = "font-family: 돋움; font-size: 14.25pt; font-weight: normal; text-align: right; vert" +
    "ical-align: middle; ddo-char-set: 129";
            this.label46.Text = "(인)";
            this.label46.Top = 0.04F;
            this.label46.Width = 0.4589999F;
            // 
            // pageFooter
            // 
            this.pageFooter.Height = 0F;
            this.pageFooter.Name = "pageFooter";
            // 
            // PSM4073_INS
            // 
            this.PageSettings.Margins.Bottom = 0.5F;
            this.PageSettings.Margins.Left = 0.4F;
            this.PageSettings.Margins.Right = 0.4F;
            this.PageSettings.Margins.Top = 0.5F;
            this.PageSettings.PaperHeight = 11F;
            this.PageSettings.PaperWidth = 8.5F;
            this.PrintWidth = 6F;
            this.Sections.Add(this.pageHeader);
            this.Sections.Add(this.detail);
            this.Sections.Add(this.pageFooter);
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Arial; font-style: normal; text-decoration: none; font-weight: norma" +
            "l; font-size: 10pt; color: Black", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 16pt; font-weight: bold", "Heading1", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Times New Roman; font-size: 14pt; font-weight: bold; font-style: ita" +
            "lic", "Heading2", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 13pt; font-weight: bold", "Heading3", "Normal"));
            ((System.ComponentModel.ISupportInitialize)(this.label1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PECJKCDNM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.KBHANGL)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.picture1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label46)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion
        private GrapeCity.ActiveReports.SectionReportModel.Label label1;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox PECJKCDNM;
        private GrapeCity.ActiveReports.SectionReportModel.TextBox KBHANGL;
        private GrapeCity.ActiveReports.SectionReportModel.Picture picture1;
        private GrapeCity.ActiveReports.SectionReportModel.Label label46;
    }
}
