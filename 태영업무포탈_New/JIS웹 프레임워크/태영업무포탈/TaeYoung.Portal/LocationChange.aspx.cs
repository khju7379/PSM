using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Biz;
using System.Web.Security;

namespace TaeYoung.Portal
{
    public partial class LocationChange : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string location = Request.QueryString["LOC"];
            string loginid = Request.QueryString["ID"];

            Document.SiteCompanyCode = location;
            Document.VendLoginID = loginid;

            if (UserID.IndexOf('^') != -1)
            {
                FormsAuthentication.SetAuthCookie(loginid + "^" + UserID.Split('^')[1], false);
                System.Web.HttpCookie LoginCookie = System.Web.Security.FormsAuthentication.GetAuthCookie(loginid + "^" + UserID.Split('^')[1], false);
            }
            else
            {
                FormsAuthentication.SetAuthCookie(loginid, false);
                System.Web.HttpCookie LoginCookie = System.Web.Security.FormsAuthentication.GetAuthCookie(loginid, false);
            }
            Response.Redirect("/Portal/Main.aspx");
        }

        #region UserID - 사용자 ID를 리턴한다.
        /// <summary>
        /// 사용자 ID를 리턴한다. 
        /// </summary>
        public string UserID
        {
            get
            {
                string loginID = string.Empty;

                if (User.Identity.Name.Contains("\\"))
                {
                    loginID = User.Identity.Name.Split('\\')[1];
                }
                else
                {
                    loginID = User.Identity.Name;
                }

                return loginID;
            }
        }
        #endregion
    }
}