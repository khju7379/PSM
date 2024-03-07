using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Collections;
using JINI.Util;
using JINI.Base.Configuration;
using TaeYoung.Common;
using TaeYoung.Biz.Common;


namespace TaeYoung.Portal.PSM.PSM10
{
    public partial class PSM1100 : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
              
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //string serverPath = FxConfigManager.GetString("FileUploadPath");
            //string folderPath = "TEMP\\";
            //if (!Directory.Exists(serverPath + folderPath))
            //{
            //    Directory.CreateDirectory(serverPath + folderPath);
            //}
            ////string filePath = serverPath + folderPath + DateTime.Now.ToString("yyyyMMddhhmmsss") + Path.GetExtension(upExcel.FileName);

            //string filePath = serverPath + folderPath + upExcel.FileName;

            //upExcel.SaveAs(filePath);

            
            //byte[] bytearray = File.ReadAllBytes(filePath);

            //string dd = "Ddd";
        }
    }
}