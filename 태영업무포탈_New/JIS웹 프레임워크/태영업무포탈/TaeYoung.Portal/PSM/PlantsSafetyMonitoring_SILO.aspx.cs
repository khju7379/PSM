using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Common;

namespace TaeYoung.Portal.PSM
{
    public partial class PlantsSafetyMonitoring_SILO : BasePage
    {
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