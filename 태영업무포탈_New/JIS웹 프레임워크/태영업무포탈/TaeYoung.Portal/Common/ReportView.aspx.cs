using System;
using System.IO;
using System.Reflection;
using System.Web;
using JINI.Base.Configuration;
using GrapeCity.ActiveReports;
using GrapeCity.ActiveReports.SectionReportModel;
using GrapeCity.ActiveReports.Export.Pdf;
using GrapeCity.ActiveReports.Export.Pdf.Section;

namespace TaeYoung.Portal.Common
{
    public partial class ReportView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)  
        {
            

            // 에셈블리를 체크하여 버전이 있을시 로드 없을시 복사한다.
            string dllPath = HttpContext.Current.Server.MapPath("~/bin/TYPSM.Report.dll"); 
            string dllName = "TYPSM.Report";

            System.Diagnostics.FileVersionInfo ver = System.Diagnostics.FileVersionInfo.GetVersionInfo(dllPath);

            string AssemblyTempPath = string.Empty;

            if (string.IsNullOrEmpty(FxConfigManager.GetString("AssemblyTempPath")))
            {
                AssemblyTempPath = "C:\\AssemblyTempPath";
            }
            else
            {
                AssemblyTempPath = FxConfigManager.GetString("AssemblyTempPath");
            }

            // 경로 생성
            string tempDllString = AssemblyTempPath + "\\" + dllName + "\\" + ver.FileVersion + ".dll";


            // 뒤에 \\ 가있을시 제거
            AssemblyTempPath = AssemblyTempPath.TrimEnd('\\');

            FileInfo dll_file = new FileInfo(tempDllString);

            if (!dll_file.Exists)
            {
                Directory.CreateDirectory(dll_file.Directory.FullName);
                File.Copy(dllPath, tempDllString); // 파일이 없을시 복사
            }

            Assembly assembly = Assembly.LoadFile(tempDllString);

            // querystring으로 리포트명을 가져옴
            string typeString = Request.QueryString["RPT"];

            System.Type type = assembly.GetType(dllName + "." + typeString);

            if (type != null)
            {
                //DataDynamics.ActiveReports.ActiveReport rpt = Activator.CreateInstance(type, Request.QueryString) as ActiveReport;
                //DataDynamics.ActiveReports.ActiveReport rpt = Activator.CreateInstance(type) as ActiveReport;
                //DataDynamics.ActiveReports.ActiveReport rpt = Activator.CreateInstance(type,null) as ActiveReport;
                //SectionReport rpt = Activator.CreateInstance(type, Request.QueryString) as SectionReport;
                //SectionReport rpt = Activator.CreateInstance(type, null) as SectionReport;

                SectionReport rpt = Activator.CreateInstance(type, Request.QueryString) as SectionReport;
                //rpt.Run(true);

                try
                {
                    
                    rpt.Run(false);

                    // Tell the browser this is a PDF document so it will use an appropriate viewer.
                    // If the report has been exported in a different format, the content-type will 
                    // need to be changed as noted in the following table:
                    //    ExportType  ContentType
                    //    PDF       "application/pdf"  (needs to be in lowercase)
                    //    RTF       "application/rtf"
                    //    TIFF      "image/tiff"       (will open in separate viewer instead of browser)
                    //    HTML      "message/rfc822"   (only applies to compressed HTML pages that includes images)
                    //    Excel     "application/vnd.ms-excel"
                    //    Excel     "application/excel" (either of these types should work) 
                    //    Text      "text/plain"  
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "inline; filename=MyPDF.PDF");
                    //// Create the PDF export object.
                    PdfExport pdf = new PdfExport();
                    //// Create a new memory stream that will hold the pdf output.
                    System.IO.MemoryStream memStream = new System.IO.MemoryStream();
                    //// Export the report to PDF.

                    ////SectionReport rpt = classInstance as SectionReport;

                    pdf.Export(rpt.Document, memStream);
                    //// Write the PDF stream to the output stream.
                    Response.BinaryWrite(memStream.ToArray());
                    //// Send all buffered content to the client.
                    Response.End();

                }
                catch (GrapeCity.ActiveReports.ReportException eRunReport)
                {
                    // Failure running report, just report the error to the user.
                    Response.Clear();
                    Response.Write("<h1>Error running report:</h1>");
                    Response.Write(eRunReport.ToString());
                    return;
                }

            }
            else
            {
                // Failure running report, just report the error to the user.
                Response.Clear();
                Response.Write("<h1>리포트 파일을 찾을수 없습니다.("+typeString+")</h1>");
                return;
            }

            //SectionReport rpt = new NVH.Portal.Report.Templete();
            //try
            //{
            //    rpt.Run(false);
            //}
            //catch (GrapeCity.ActiveReports.ReportException eRunReport)
            //{
            //    // Failure running report, just report the error to the user.
            //    Response.Clear();
            //    Response.Write("<h1>Error running report:</h1>");
            //    Response.Write(eRunReport.ToString());
            //    return;
            //}

            
        }
    }
}