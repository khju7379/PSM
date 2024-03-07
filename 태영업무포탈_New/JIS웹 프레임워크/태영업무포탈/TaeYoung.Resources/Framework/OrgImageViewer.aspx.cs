using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JINI.Util;
using System.IO;
using JINI.Base.Configuration;

namespace TaeYoung.Resources.Framework
{
    public partial class OrgImageViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string empid = Request.QueryString["id"];
            string width = Request.QueryString["width"];
            string height = Request.QueryString["height"];
            if (!string.IsNullOrEmpty(width))
            {
                width = "110";
            }
            if (!string.IsNullOrEmpty(height))
            {
                height = "110";
            }
            string uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath");

            if (!string.IsNullOrEmpty(empid))
            {
                try
                {
                    // 첨부파일을 FTP에서 가져와서 로컬에 저장
                    FtpFileHandler ftp = new FtpFileHandler();
                    ftp.SERVER = FxConfigManager.GetString("FTP_SERVER") + "/SeohanGroup/서한그룹임직원사진/";
                    MemoryStream fs = ftp.FileDownload(empid + ".jpg");

                    FileInfo fi = new FileInfo(uploadPath + @"UserImage\" + empid + ".jpg");
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
                        imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(fi.FullName, "A", Convert.ToInt32(width), Convert.ToInt32(height)));
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
            }
            else
            {
                // 섬네일 생성하여 이미지를 화면에 보여줌
                using (Thumbnail thumbnail = new Thumbnail())
                using (ImageRender imageRender = new ImageRender())
                {
                    imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(Server.MapPath("/Resources/Images/none_user_photo2.png"), "A", 0, 0));
                }
            }
        }
    }
}