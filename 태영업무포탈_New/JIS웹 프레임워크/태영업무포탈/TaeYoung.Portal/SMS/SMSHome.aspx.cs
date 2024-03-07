using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Common;
using TaeYoung.Biz.PSM;
using System.Data;
using System.Collections;
using TaeYoung.Biz;

namespace TaeYoung.Portal.SMS
{
    public partial class SMSHome : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ////Document.SiteCompanyCode
            //if (Document.UserInfo.CompanyCode == "TY")
            //{
            //    Server.Transfer("CSIHome_UT.aspx");
            //}
            //else
            //{
            //    Server.Transfer("CSIHome_" + Document.UserInfo.CompanyCode + ".aspx");
            //}
        }
    }
}