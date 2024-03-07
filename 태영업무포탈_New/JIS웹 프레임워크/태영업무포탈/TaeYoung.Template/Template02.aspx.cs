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
    public partial class Template02 : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (IsAdmin) txt1.Visible = true;
           // this.txtDate3.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            InitGrid();
        }

        private void InitGrid()
        {
            //grid1.AddField("TEST1", "컬럼1", "lang01", "50%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "null");
            //grid1.AddField("TEST2", "컬럼2", "lang02", "50%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "null");

            //grid1.TypeName = "";
            //grid1.MethodName = "";
        }
    }
}
