using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TaeYoung.Common;
using JINI.Control.WebControl;
using TaeYoung.Biz.Common;

namespace TaeYoung.Portal.Admin.Cmn
{
    public partial class MenuLangCodeExcelDown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string programid = Request.QueryString["ProgramID"];

            using (LangBiz biz = new LangBiz())
            {
                DataSet ds = biz.GetLangDataTree(programid);

                DataGrid grid = new DataGrid();
                grid.DataSource = ds;
                grid.DataBind();

                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                grid.RenderControl(htmlWrite);

                this.Response.Clear();

                this.Response.ContentType = "application/vnd.ms-excel";
                this.Response.AddHeader("content", "text/html; charset=utf-8");
                this.Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode("다국어정보") + ".xls");
                this.Response.Write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
                this.Response.Write(stringWrite.ToString());
                this.Response.Flush();
                this.Response.Close();
                this.Response.End();
            }
        }
    }
}