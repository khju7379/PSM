using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Biz.Template;
using System.Collections;

namespace TaeYoung.WebTemplate
{
    public partial class DBConnectTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //using (DBConnectTestBiz biz = new DBConnectTestBiz())
            //{
            //    GridView1.DataSource = biz.ListDBConnectTest(new Hashtable());
            //    GridView1.DataBind();
            //}

            using (TemplateBiz biz = new TemplateBiz())
            {
                //GridView1.DataSource = biz.GetRecruit(new Hashtable());
                //GridView1.DataBind();
            }
            
        }
    }
}