using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JINI.Control.WebControl.AttachBiz;
using System.Data;
using System.IO;
using JINI.Util;
using JINI.Base.Configuration;

namespace TaeYoung.Resources.Framework
{
	/// <summary>
	/// 이미지를 브라우져에 이미지형식으로 보여준다
	/// </summary>
    public partial class editorimage : System.Web.UI.Page
	{
		/// <summary>
		/// 페이지 로드
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Page_Load(object sender, EventArgs e)
		{
            // URL만 체크해서 처리함(웹에디터용)
            string url = Request.QueryString["URL"];

            if (!string.IsNullOrEmpty(url))
            {
                try
                {
                    // 첨부파일을 FTP에서 가져와서 로컬에 저장
                    FtpFileHandler ftp = new FtpFileHandler();
                    MemoryStream fs = ftp.FileDownload(@"Editor\" + url);
                    string uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath");

                    FileInfo fi = new FileInfo(uploadPath + @"Editor\" + url.Replace("/","\\"));
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
                        imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(fi.FullName, "A", 0, 0));
                    }

                    // 이미지를 전송후 파일 삭제
                    fi.Delete();

                }
                catch // 오류시 공백표시
                {
                    // 섬네일 생성하여 이미지를 화면에 보여줌
                    using (Thumbnail thumbnail = new Thumbnail())
                    using (ImageRender imageRender = new ImageRender())
                    {
                        imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(Server.MapPath("/Resources/Images/none_user_photo2.png"), "A", 0, 0));
                    }
                }




                //string uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath") + "\\Editor\\";

                //url = url.Replace("/", "\\");

                //FileInfo fi = new FileInfo(uploadPath + url);

                //using (ImageRender imageRender = new ImageRender())
                //{
                //    if (fi.Exists)
                //    {
                //        imageRender.MakeImageResizeStream(System.Drawing.Image.FromFile(fi.FullName));
                //    }
                //    else
                //    {
                //        imageRender.MakeImageResizeStream(System.Drawing.Image.FromFile(Server.MapPath("/Resources/Framework/blank.gif")));
                //    }
                //}
            }
		}
	}
}