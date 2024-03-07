using System;
using System.Data;
using System.IO;
using System.Web;
using JINI.Base.Configuration;
using TaeYoung.Biz.Common;
using JINI.Util;

namespace TaeYoung.Resources.Framework
{
    /// <summary>
    /// 파일 다운로드 페이지
    /// </summary>
    public partial class FileExcelDownload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string unid = Request.QueryString["UNID"];
			string url_s = Request.QueryString["PATH"];
            string isExcelDown = Request.QueryString["ExcelDown"];

            string uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath");

			if (!string.IsNullOrEmpty(unid))
			{
                using (CommonBiz biz = new CommonBiz())
				{
					DataSet ds = biz.GetAttachFile(unid);

					if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
					{
                        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["UPLOAD_PATH"].ToString()))
                        {
                            uploadPath = ds.Tables[0].Rows[0]["UPLOAD_PATH"].ToString();
                        }

                        string filepath = uploadPath + ds.Tables[0].Rows[0]["FILE_PATH"].ToString();
                        filepath = filepath.Replace('₩', '\\');

                        FileInfo f = new FileInfo(filepath);

                        if (f.Exists)
                        {
                            // 파일 다운로드.

                            Response.ClearHeaders();

                            Response.ClearContent();

                            Response.ContentType = "application/octet-stream";

                            Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(ds.Tables[0].Rows[0]["FILE_NAME"].ToString()).Replace("+", "%20") + "\"");

                            Response.AppendHeader("FileSize", f.Length.ToString());

                            Response.TransmitFile(f.FullName);

                            Response.Flush();

                            //Response.Close();
                        }
					}
				}
			}
			else if(!string.IsNullOrEmpty(url_s))
			{
				string[] u = url_s.Split('|');
                if (url_s.IndexOf('§') > -1)
                {
                    u = url_s.Split('§');
                }
				string url = u[0];
				url = Server.UrlDecode(url);
				url = url.Replace("//", "/");
				url = url.Replace("/", "\\");
                url = url.Replace("₩", "\\");
				if (url.StartsWith(uploadPath))
				{
					url = url.Replace("\\\\","\\");
				}
				else
				{
					url = uploadPath + url;
				}

                string name = u[1];

                FileInfo f = new FileInfo(url);

                if (f.Exists)
                {
                    // 파일 다운로드.

                    Response.ClearHeaders();

                    Response.ClearContent();

                    Response.ContentType = "application/octet-stream";

                    Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(name).Replace("+", "%20") + "\"");

                    Response.AppendHeader("FileSize", f.Length.ToString());

                    Response.TransmitFile(f.FullName);

                    Response.Flush();

                    //Response.End();

                    //엑셀 다운로드 함수로 호출시 해당 엑셀 다운로드 후 삭제 처리
                    if (!string.IsNullOrEmpty(isExcelDown))
                    {
                        File.Delete(url);
                    }
                }
			}
			
        }
    }
}