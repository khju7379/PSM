using System;
using System.Data;
using System.IO;
using System.Web;
using JINI.Base.Configuration;
using System.Collections;
using TaeYoung.Biz.Common;
using JINI.Util;

namespace TaeYoung.Resources.Framework
{
    /// <summary>
    /// 파일 다운로드 페이지
    /// </summary>
    public partial class FileDownloadByAttNoFirst : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string attch_type = string.Empty;
            string attch_no = string.Empty;
            string filename = string.Empty;

            if (Request.QueryString["TYPE"] != null)
            {
                attch_type = Request.QueryString["TYPE"];
            }

            if (Request.QueryString["ATTNO"] != null)
            {
                attch_no = Request.QueryString["ATTNO"];
            }
            string uploadPath = string.Empty;// JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath");
            Hashtable ht = new Hashtable();
            ht["ATTACH_TYPE"] = attch_type;
            ht["ATTACH_NO"] = attch_no;
            DataSet ds = null;
            using (CommonBiz biz = new CommonBiz())
            {
                ds = biz.GetAttachFileList(ht);
            }
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["UPLOAD_PATH"].ToString()))
                {
                    uploadPath = ds.Tables[0].Rows[0]["UPLOAD_PATH"].ToString();
                }

                string filepath = uploadPath + ds.Tables[0].Rows[0]["FILE_PATH"].ToString();
                filepath = filepath.Replace('₩', '\\');
                filepath = filepath.Replace("&#94;", "^"); //구분기호 예외 처리
                //FileInfo fi = new FileInfo(filePath);
                FtpFileHandler ftp = new FtpFileHandler();
                MemoryStream fs = ftp.FileDownload(filepath);
                if (fs == null) return;// 파일이 없을시 취소

                filename = ds.Tables[0].Rows[0]["FILE_NAME"].ToString();
                Response.Clear();

                Response.ClearHeaders();

                Response.ClearContent();

                Response.ContentType = "application/octet-stream";

                Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(ds.Tables[0].Rows[0]["FILE_NAME"].ToString()).Replace("+", "%20") + "\"");

                Response.AppendHeader("FileSize", fs.Length.ToString());//f.Length.ToString());

                Response.BinaryWrite(fs.ToArray());

                Response.Flush();

                Response.Close();
            }
        }
    }
}