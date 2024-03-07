using System;
using System.IO;
using System.Reflection;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections;

using JINI.Data;
using JINI.Base.Configuration;
using GrapeCity.ActiveReports;
using GrapeCity.ActiveReports.SectionReportModel;
using GrapeCity.ActiveReports.Export.Pdf;
using GrapeCity.ActiveReports.Export.Pdf.Section;

namespace TaeYoung.Portal.PSM
{
    /// <summary>
    /// SafeOrderService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
     [System.Web.Script.Services.ScriptService]
    public class SafeOrderService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public void Set_SafeOrder_Prt(string sDOCNAME,   string sCMWKTEAM,      string sCMWKDATE,  
                                      string sCMWKSEQ,   string sSMWKORAPPDATE, string sSMWKORSEQ, 
                                      string sJSA,       string sPrint,         string sCopies,    string sSESSIONID)
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

            // 안전작업허가서 출력
            string typeString = sDOCNAME;

            System.Type type = assembly.GetType(dllName + "." + typeString);

            if (type != null)
            {
                try
                {
                    
                    string sParams = "RPT=" + sDOCNAME + "&CMWKTEAM=" + sCMWKTEAM + "&CMWKDATE=" + sCMWKDATE + "&CMWKSEQ=" + sCMWKSEQ + "&SMWKORAPPDATE=" + sSMWKORAPPDATE + "&SMWKORSEQ=" + sSMWKORSEQ + "&PRINTNAME=" + sPrint + "&PRINTCNT=" + sCopies;

                    SectionReport rpt = Activator.CreateInstance(type, sParams) as SectionReport;

                    rpt.Run(false);
                }
                catch (GrapeCity.ActiveReports.ReportException eRunReport)
                {
                    // Failure running report, just report the error to the user.
                    return;
                }

            }
            else
            {
                // Failure running report, just report the error to the user.
                return;
            }

            // 화기작업허가서 출력
            type = assembly.GetType(dllName + ".PSM4040_RPT");

            if (type != null)
            {
                try
                {   
                    string sParams = "RPT=PSM4040_RPT&CMWKTEAM=" + sCMWKTEAM + "&CMWKDATE=" + sCMWKDATE + "&CMWKSEQ=" + sCMWKSEQ + "&SMWKORAPPDATE=" + sSMWKORAPPDATE + "&SMWKORSEQ=" + sSMWKORSEQ + "&PRINTNAME=" + sPrint + "&PRINTCNT=" + sCopies;

                    SectionReport rpt = Activator.CreateInstance(type, sParams) as SectionReport;

                    rpt.Run(false);
                }
                catch (GrapeCity.ActiveReports.ReportException eRunReport)
                {
                    // Failure running report, just report the error to the user.
                    return;
                }

            }
            else
            {
                // Failure running report, just report the error to the user.
                return;
            }

            // 일일 JSA 출력
            if (sJSA == "true")
            {
                type = assembly.GetType(dllName + ".PSM1090_RPT");

                if (type != null)
                {
                    try
                    {
                        DataSet ds;
                        // 일일 JSA 조회
                        using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                        {
                            dbCon.AddParameters("P_JSMWKGUBN", DbType.String, "D");
                            dbCon.AddParameters("P_JSMPOTEAM", DbType.String, sCMWKTEAM);
                            dbCon.AddParameters("P_JSMPODATE", DbType.String, sCMWKDATE);
                            dbCon.AddParameters("P_JSMPOSEQ", DbType.String, sCMWKSEQ);
                            dbCon.AddParameters("P_JSMDATE", DbType.String, sSMWKORAPPDATE);


                            ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4043_JSACHANGE_MASTER_LIST");
                        }

                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            string sParams = "RPT=PSM1090_RPT&SESSIONID=" + sSESSIONID + "&JSMWKGUBN=" + "D" + "&JSMPOTEAM=" + sCMWKTEAM
                            + "&JSMPODATE=" + sCMWKDATE + "&JSMPOSEQ=" + sCMWKSEQ + "&P_JSMDATE=" + sSMWKORAPPDATE + "&P_JSMMSEQ=" + ds.Tables[0].Rows[i]["JSMMSEQ"].ToString()
                            + "&P_JSMBLASS=" + ds.Tables[0].Rows[i]["JSMBLASS"].ToString() + "&P_JSMMLASS=" + ds.Tables[0].Rows[i]["JSMMLASS"].ToString()
                            + "&P_JSMSLASS=" + ds.Tables[0].Rows[i]["JSMSLASS"].ToString() + "&P_JSMSEQ=" + ds.Tables[0].Rows[i]["JSMSEQ"].ToString() + "&PRINTNAME=" + sPrint + "&PRINTCNT=" + sCopies;

                            SectionReport rpt = Activator.CreateInstance(type, sParams) as SectionReport;

                            rpt.Run(false);
                        }
                    }
                    catch (GrapeCity.ActiveReports.ReportException eRunReport)
                    {
                        // Failure running report, just report the error to the user.
                        return;
                    }

                }
                else
                {
                    // Failure running report, just report the error to the user.
                    return;
                }
            }
        }
    }
}
