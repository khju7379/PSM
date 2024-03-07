using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Common;

namespace TaeYoung.Portal.SMS.SMS10
{
    public partial class SMS1010 : BasePage
    {
        public SMS1010()
        {
            //this.Popup = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 팝업여부 강제지정
            if (!string.IsNullOrEmpty(Request.QueryString["POPUP"]))
            {
                this.Popup = true;
            }

        }
    }
}