using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using JINI.Util;
using TaeYoung.Biz.Common;

namespace TaeYoung.Resources.Framework
{
	/// <summary>
	/// 이미지 크기를 변경하여 브라우져에 이미지형식으로 보여준다
	/// </summary>
	public partial class ImageResize : System.Web.UI.Page
	{
		/// <summary>
		/// 페이지 로드
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Page_Load(object sender, EventArgs e)
		{
			string unid = Request.QueryString["UNID"];
			int width = ConvertType.ToInt32(Request.QueryString["width"]);
            int height = ConvertType.ToInt32(Request.QueryString["height"]);
			string src = Request.QueryString["SRC"];
			string url = Request.QueryString["URL"];
            string mig_folder = Request.QueryString["volumeId"];
			string uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath");
            if (!string.IsNullOrEmpty(src))
            {
                src = src.Replace('₩', '\\');
                src = src.Replace("^*^", "\\");

                // 첨부파일을 FTP에서 가져와서 로컬에 저장
                FtpFileHandler ftp = new FtpFileHandler();
                MemoryStream fs = ftp.FileDownload(src.Replace('\\','/'));

                FileInfo fi = new FileInfo(uploadPath + src);
                if (!Directory.Exists(fi.DirectoryName))
                {
                    Directory.CreateDirectory(fi.DirectoryName);// 없을시 생성
                }
                // 파일을 저장
                using (FileStream file = new FileStream(fi.FullName, FileMode.Create, System.IO.FileAccess.Write))
                {
                    byte[] bytes = new byte[fs.Length];
                    fs.Read(bytes, 0, (int)fs.Length);
                    file.Write(bytes, 0, bytes.Length);
                    fs.Close();
                }

                // 섬네일 생성하여 이미지를 화면에 보여줌
                using (Thumbnail thumbnail = new Thumbnail())
                using (ImageRender imageRender = new ImageRender())
                {
                    imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(uploadPath + src, "A", width, height));
                }

                // 이미지를 전송후 파일 삭제
                fi.Delete();
            }
            else if (!string.IsNullOrEmpty(url))
            {
                url = url.Replace('₩', '\\');
                src = Server.MapPath(url);
                // 섬네일 생성하여 이미지를 화면에 보여줌
                using (Thumbnail thumbnail = new Thumbnail())
                using (ImageRender imageRender = new ImageRender())
                {
                    imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(src, "A", width, height));
                }
            }
            else
            {
                // UNID로 이미지 경로 리턴
                using (CommonBiz biz = new CommonBiz())
                {
                    DataSet ds = biz.GetAttachFile(unid);

                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        string ext = ds.Tables[0].Rows[0]["FILE_EXT"].ToString().Replace(".", "").ToLower();

                        if (!(ext == "jpg" || ext == "jpeg" || ext == "gif" || ext == "png" || ext == "bmp")) return;

                        string filepath = uploadPath + ds.Tables[0].Rows[0]["FILE_PATH"].ToString();
                        filepath = filepath.Replace('₩', '\\');

                        // src 쪽 부분 참고 추가 2017-05-11 장윤호
                        // 첨부파일을 FTP에서 가져와서 로컬에 저장
                        string path = ds.Tables[0].Rows[0]["FILE_PATH"].ToString().Replace('₩', '\\');
                        FtpFileHandler ftp = new FtpFileHandler();
                        MemoryStream fs = ftp.FileDownload(path.Replace('\\', '/'));

                        FileInfo fi = new FileInfo(uploadPath + path);
                        if (!Directory.Exists(fi.DirectoryName))
                        {
                            Directory.CreateDirectory(fi.DirectoryName);// 없을시 생성
                        }
                        // 파일을 저장
                        using (FileStream file = new FileStream(fi.FullName, FileMode.Create, System.IO.FileAccess.Write))
                        {
                            byte[] bytes = new byte[fs.Length];
                            fs.Read(bytes, 0, (int)fs.Length);
                            file.Write(bytes, 0, bytes.Length);
                            fs.Close();
                        }
                        // 추가 끝
                        
                        FileInfo f = new FileInfo(filepath);

                        if (f.Exists)
                        {
                            // 섬네일 생성하여 이미지를 화면에 보여줌
                            using (Thumbnail thumbnail = new Thumbnail())
                            using (ImageRender imageRender = new ImageRender())
                            {
                                imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(f.FullName, "A", width, height));
                            }

                        }
                    }
                }
            }
		}
	}
}