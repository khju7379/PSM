<%@ WebHandler Language="C#" Class="editorupload" %>

using System;
using System.Web;
using System.IO;

/// <summary>
/// ÷������ ó�� �ڵ鷯
/// </summary>
public class editorupload : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        //context.Response.ContentType = "text/plain";

        var uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath") + "\\Editor\\";
        string key = context.Request["BoraKey"] ?? string.Empty;
        
		// ��θ� yyyy/mm/dd
        //string datePath = DateTime.Today.ToString("yyyy") + "\\" + DateTime.Today.ToString("MM") + "\\" + DateTime.Today.ToString("dd") + "\\" + key;
        string datePath = key;
		uploadPath = uploadPath + datePath;
		string dbfilePath = datePath;

		if (!Directory.Exists(uploadPath))
		{
			Directory.CreateDirectory(uploadPath);
		}

        for (int i = 0; i < context.Request.Files.Count; i++)
        {
            HttpPostedFile fileUpload = context.Request.Files[i];

            string fileName = Path.GetFileName(fileUpload.FileName);
            
            fileUpload.SaveAs(Path.Combine(uploadPath, fileName));
            
            // ���� ���ε� �Ϸ��� FTP ����

            JINI.Util.FtpFileHandler ftp = new JINI.Util.FtpFileHandler();
            ftp.Upload(Path.Combine(uploadPath, fileName), "Editor/" + datePath.Replace('\\', '/'));

            File.Delete(Path.Combine(uploadPath, fileName));
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
