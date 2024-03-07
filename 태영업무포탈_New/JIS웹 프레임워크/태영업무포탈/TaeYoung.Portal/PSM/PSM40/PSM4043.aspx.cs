using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Common;
using Ext.Net;

namespace TaeYoung.Portal.PSM.PSM40
{
    public partial class PSM4043 : BasePage
    {
        RemotePrint.SafeOrderService svc;

        public PSM4043()
        {
            this.Popup = true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [DirectMethod]
        public void UP_Print(string sDate, string sGubn)
        {
            svc = new RemotePrint.SafeOrderService();
            //svc.Set_SafeOrder_Prt(sCMWKTEAM, sCMWKDATE, sCMWKSEQ, sSMWKORAPPDATE, sSMWKORSEQ, sDevice, sJSA, sPrint, Session.SessionID, sCopies);
        }
    }
}