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
    public partial class FileDownload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ftp_root = Request.QueryString["FOLDER"];
            string ftp_fileName = Request.QueryString["FILE_NAME"];

            string unid = Request.QueryString["UNID"];
			string url_s = Request.QueryString["PATH"];
            string isExcelDown = Request.QueryString["ExcelDown"];

            string uploadPath = string.Empty;// JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath");

			if (!string.IsNullOrEmpty(unid))
			{
                using (CommonBiz biz = new CommonBiz())
				{
					DataSet ds = biz.GetAttachFile(unid);

					if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
					{
                        #region ftp방식일 경우
                        //if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["UPLOAD_PATH"].ToString()))
                        //{
                        //    uploadPath = ds.Tables[0].Rows[0]["UPLOAD_PATH"].ToString();
                        //}

                        //string filepath = uploadPath + ds.Tables[0].Rows[0]["FILE_PATH"].ToString();
                        //filepath = filepath.Replace('₩', '\\');
                        //filepath = filepath.Replace("&#94;", "^"); //구분기호 예외 처리

                        ////FileInfo f = new FileInfo(filepath);

                        //FtpFileHandler ftp = new FtpFileHandler();

                        //MemoryStream fs = ftp.FileDownload(filepath);

                        //if (fs == null) return;// 파일이 없을시 취소

                        //Response.ClearHeaders();

                        //Response.ClearContent();

                        //Response.ContentType = "application/octet-stream";

                        //Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(ds.Tables[0].Rows[0]["FILE_NAME"].ToString()).Replace("+", "%20") + "\"");

                        //Response.AppendHeader("FileSize", fs.Length.ToString());//f.Length.ToString());

                        //Response.BinaryWrite(fs.ToArray());

                        //Response.Flush();

                        ////if (f.Exists)
                        ////{
                        ////    // 파일 다운로드.

                        ////    Response.ClearHeaders();

                        ////    Response.ClearContent();

                        ////    Response.ContentType = "application/octet-stream";

                        ////    Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(ds.Tables[0].Rows[0]["FILE_NAME"].ToString()).Replace("+", "%20") + "\"");

                        ////    Response.AppendHeader("FileSize", f.Length.ToString());

                        ////    Response.TransmitFile(f.FullName);

                        ////    Response.Flush();

                        ////    //Response.Close();
                        ////}
                        #endregion

                        byte[] byteArray = ds.Tables[0].Rows[0]["ATTACH_BYTE"] as byte[];

                        MemoryStream fs = new MemoryStream();
                        fs.Write(byteArray, 0, byteArray.Length);

                        if (fs == null) return;// 파일이 없을시 취소

                        Response.ClearHeaders();

                        Response.ClearContent();

                        Response.ContentType = "application/octet-stream";

                        Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(ds.Tables[0].Rows[0]["FILE_NAME"].ToString()).Replace("+", "%20") + "\"");

                        Response.AppendHeader("FileSize", fs.Length.ToString());//f.Length.ToString());

                        Response.BinaryWrite(fs.ToArray());

                        Response.Flush();
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
				//Response.Write(url);
				string name = string.Empty;
                if (u.Length > 1)
                {
                    name = u[1];
                }
                else
                {
                    name = url.Split('\\')[url.Split('\\').Length-1];
                }

                FtpFileHandler ftp = new FtpFileHandler();

                MemoryStream fs = ftp.FileDownload(url);

                Response.ClearHeaders();

                Response.ClearContent();

                Response.ContentType = "application/octet-stream";

                Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(name).Replace("+", "%20") + "\"");

                Response.AppendHeader("FileSize", fs.Length.ToString());//f.Length.ToString());

                Response.BinaryWrite(fs.ToArray());

                Response.Flush();

                //FileInfo f = new FileInfo(url);

                //if (f.Exists)
                //{
                //    // 파일 다운로드.

                //    Response.ClearHeaders();

                //    Response.ClearContent();

                //    Response.ContentType = "application/octet-stream";

                //    Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(name).Replace("+", "%20") + "\"");

                //    Response.AppendHeader("FileSize", f.Length.ToString());
                    
                //    Response.TransmitFile(f.FullName);

                //    Response.Flush();

                //    //Response.End();

                //    //엑셀 다운로드 함수로 호출시 해당 엑셀 다운로드 후 삭제 처리
                //    if (!string.IsNullOrEmpty(isExcelDown))
                //    {
                //        File.Delete(url);
                //    }
                //}
            }
            else if (!string.IsNullOrEmpty(ftp_root))
            {

                FtpFileHandler ftp = new FtpFileHandler(ftp_root);
                
                MemoryStream fs = ftp.FileDownload("/" + ftp_fileName);

                if (fs == null) return;// 파일이 없을시 취소

                Response.ClearHeaders();

                Response.ClearContent();

                Response.ContentType = "application/octet-stream";

                Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(ftp_fileName).Replace("+", "%20") + "\"");

                Response.AppendHeader("FileSize", fs.Length.ToString());//f.Length.ToString());

                Response.BinaryWrite(fs.ToArray());

                Response.Flush();
            }
			
        }
    }
}