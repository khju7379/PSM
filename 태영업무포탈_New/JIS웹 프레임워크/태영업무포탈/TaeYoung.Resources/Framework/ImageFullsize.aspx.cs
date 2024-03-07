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

namespace TaeYoung.Resources.Framework
{
	/// <summary>
	/// 이미지를 브라우져에 이미지형식으로 보여준다
	/// </summary>
    public partial class ImageFullsize : System.Web.UI.Page
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
                string uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath") + "\\Editor\\";

                url = url.Replace("/", "\\");

                FileInfo fi = new FileInfo(uploadPath + url);

                using (ImageRender imageRender = new ImageRender())
                {
                    if (fi.Exists)
                    {
                        imageRender.MakeImageResizeStream(System.Drawing.Image.FromFile(fi.FullName));
                    }
                    else
                    {
                        imageRender.MakeImageResizeStream(System.Drawing.Image.FromFile(Server.MapPath("/Resources/Framework/blank.gif")));
                    }
                }
            }
		}
	}
}