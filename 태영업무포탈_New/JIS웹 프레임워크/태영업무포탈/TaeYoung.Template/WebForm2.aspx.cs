using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace TaeYoung.Template
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string title = Request["title"];

            string file2 = Request["uploadfile"];

            HttpPostedFile file = Request.Files["uploadfile"];

            var buffer = new byte[file.InputStream.Length];
            file.InputStream.Read(buffer, 0, buffer.Length);

            Response.BinaryWrite(buffer);


            file.SaveAs("e:\\EDI업무흐름도2.pptx");

            Response.Write("업로드파일 : " + file2 + "<hr>");
        }
    }
}