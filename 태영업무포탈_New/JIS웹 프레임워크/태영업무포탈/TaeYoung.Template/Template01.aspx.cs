using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Common;
using JINI.Control.WebControl;
using TaeYoung.Biz;

namespace TaeYoung.WebTemplate
{
    public partial class Template01 : BasePage
    {
        public Template01()
        {
            //this.Popup = true;
            //this.TopMenu = true;
            //this.LeftMenu = true;
            //this.Popup = true;
            //this.ReadMode = true;

            //this.TopMenu = false;
            //this.LeftMenu = false;

            //this.PostbackYN = true;
            //this.Popup = true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (IsAdmin) txt1.Visible = true;
            if (UserGroup.Exists(s => s == "99999"))
            {
                btn01.Visible = false;
            }
        }
    }
}