using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Biz.Common;
using TaeYoung.Biz;


namespace TaeYoung.Portal
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string sSignID = TaeYoung.Biz.Document.UserInfo.SignID;

            string domain = Request.Url.Host;

            Session.Abandon();
            Session.Clear();
            System.Web.Security.FormsAuthentication.SignOut();            

            Response.Cookies[".ASPXAUTH"].Value = "";// 다른 응용프로그램도 종료하기 위한 인증값 강제 비움
            Response.Cookies["ASP.NET_SessionId"].Value = "";// 다른 응용프로그램도 종료하기 위한 인증값 강제 비움            

            if (domain == "emg.taeyoung.co.kr")
            {
                Response.Redirect("PortalLogin.aspx");
            }
            else
            {
                Response.Redirect("PortalLogin.aspx");
            }


        }
    }
}