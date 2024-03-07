using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaeYoung.Portal.Common.OrgChart
{
    /// <summary>
    /// SetLine.aspx 에 대한 코드 비하인드 구현
    /// </summary>
    /// <history>
    /// 장경환 2010-07-07 작성
    /// </history>
    public partial class SetLine : System.Web.UI.Page
    {
        protected string strURL = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            strURL = "SetLineMain.aspx";
            string strParameters = Request.Url.Query;

            strURL += strParameters;
        }
    }
}