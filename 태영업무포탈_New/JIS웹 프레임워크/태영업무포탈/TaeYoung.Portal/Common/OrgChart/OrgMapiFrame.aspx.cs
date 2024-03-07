using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using JINI.Base;
using TaeYoung.Common;

namespace TaeYoung.Portal.Common.OrgChart
{
    public partial class OrgMapiFrame : System.Web.UI.Page
    {
        protected string strOrgmapURL = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            strOrgmapURL = "OrgMap.aspx";
            string strParameters = Request.Url.Query;
            if (string.IsNullOrEmpty(strParameters))
            {
                Response.Redirect("about:blank", false);
                return;
            }

            strOrgmapURL += strParameters;
        }
    }
}