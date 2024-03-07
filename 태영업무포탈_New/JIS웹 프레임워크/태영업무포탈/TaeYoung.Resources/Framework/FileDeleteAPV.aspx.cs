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
    /// 결재 단일 업로드 삭제
    /// </summary>
    public partial class FileDeleteAPV : System.Web.UI.Page
    {
        #region Page_Load - 페이지 로드
        /// <summary>
        /// 페이지 로드
        /// </summary>
        /// <param name="sender">this</param>
        /// <param name="e">arguments</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            string url_s = Request.QueryString["PATH"];

			if(!string.IsNullOrEmpty(url_s))
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
                ftp.FileDelete(url.Replace("\\", "/"));
            }
        }
        #endregion
    }
}