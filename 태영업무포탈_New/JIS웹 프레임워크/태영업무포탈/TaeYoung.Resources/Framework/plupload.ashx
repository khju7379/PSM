<%@ WebHandler Language="C#" Class="plupload" %>

using System;
using System.Web;
using System.IO;
using JINI.Base;
using JINI.Data;
using System.Data;
using System.Collections;

/// <summary>
/// ÷������ ó�� �ڵ鷯
/// </summary>
public class plupload : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";


        string chunk_str = context.Request["chunk"];
        string chunks_str = context.Request["chunks"];// ��üũ��
        if (context.Request["chunk"] == null || context.Request["chunk"] == "false")
        {
            chunk_str = "0";
        }
        if (context.Request["chunks"] == null || context.Request["chunks"] == "false")
        {
            chunks_str = "1";
        }

        //int chunk = context.Request["chunk"] != null ? int.Parse(context.Request["chunk"]) : 0;
        int chunk = chunk_str != null ? int.Parse(chunk_str) : 0;
        int chunks = chunks_str != null ? int.Parse(chunks_str) : 1;

        string fileName = context.Request["name"] ?? string.Empty;
        string folder = context.Request["folder"] ?? string.Empty;

        HttpPostedFile fileUpload = context.Request.Files[0];

        var uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath");

        // ��θ� yyyy/mm/dd
        string datePath = DateTime.Today.ToString("yyyy") + "\\" + DateTime.Today.ToString("MM") + "\\" + DateTime.Today.ToString("dd");
        datePath = folder.Replace('/','\\') + datePath;
        uploadPath = uploadPath + datePath;
        string dbfilePath = datePath;

        if (!Directory.Exists(uploadPath))
        {
            Directory.CreateDirectory(uploadPath);
        }

        using (
            var fs = new FileStream(Path.Combine(uploadPath, fileName),
                                    chunk == 0 ? FileMode.Create : FileMode.Append))
        {
            var buffer = new byte[fileUpload.InputStream.Length];
            fileUpload.InputStream.Read(buffer, 0, buffer.Length);

            fs.Write(buffer, 0, buffer.Length);

            fs.Flush();
            fs.Close();
        }

        // ���������� ������ ftp�� �����Ѵ�.
        if (chunk == chunks - 1)
        {
            string path = Path.Combine(uploadPath, fileName);


            ////B2B ���� ÷�� ���� ó��
            //if (folder.IndexOf("DWG_FILE") >= 0)
            //{
            //    JINI.Util.FtpFileHandler ftp = new JINI.Util.FtpFileHandler(folder);
            //    dbfilePath = folder;
            //    ftp.Upload(path, "");
            //}
            //else
            //{
            //    JINI.Util.FtpFileHandler ftp = new JINI.Util.FtpFileHandler();
            //    ftp.Upload(path, datePath.Replace('\\', '/'));
            //}
            //File.Delete(Path.Combine(uploadPath, fileName));// ���ε� �Ϸ��� ����          

            // ���ϰ��
            string sfileExt = Path.GetExtension(fileName);
            //path
            byte[] bytearray = File.ReadAllBytes(path);

            Hashtable ht = new Hashtable();

            ht["P_ATTACH_TYPE"] = "TEST";
            ht["P_ATTACH_UNID"] = fileName.Replace(sfileExt, "");
            ht["P_FILE_NAME"] = fileName;
            ht["P_FILE_SIZE"] = bytearray.Length;
            ht["P_FILE_PATH"] = Path.Combine(dbfilePath, fileName);
            ht["P_ATTACH_BYTE"] = bytearray;

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {


                dbCon.AddParameters("ATTACH_TYPE", DbType.String, ht["P_ATTACH_TYPE"]);
                dbCon.AddParameters("ATTACH_UNID", DbType.String, ht["P_ATTACH_UNID"]);
                dbCon.AddParameters("FILE_NAME", DbType.String, ht["P_FILE_NAME"]);
                dbCon.AddParameters("FILE_SIZE", DbType.Int32, ht["P_FILE_SIZE"]);
                dbCon.AddParameters("FILE_PATH", DbType.String, ht["P_FILE_PATH"]);
                dbCon.AddParameters("ATTACH_BYTE", DbType.Binary,   ht["P_ATTACH_BYTE"]);


                try
                {
                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_TEMP_ATTACH_ADD");
                }
                catch (Exception ex)
                {

                }

            }


            // DB���� �� ���ϻ���

            File.Delete(path); // ���ε� �Ϸ��� ����            
        }

        context.Response.ContentType = "text/plain";

        // return value

        string fileExt = Path.GetExtension(fileName);
        string filePath = Path.Combine(dbfilePath, fileName);
        string unid = fileName.Replace(fileExt, "");

        context.Response.Write(filePath + "|" + fileExt.ToLower() + "|" + unid);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
