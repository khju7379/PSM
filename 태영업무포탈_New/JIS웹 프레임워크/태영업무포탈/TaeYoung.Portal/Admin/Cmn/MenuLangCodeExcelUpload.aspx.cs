using System;
using System.IO;
using System.Data;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JINI.Util;
using JINI.Base.Configuration;
using TaeYoung.Common;
using TaeYoung.Biz.Common;

namespace TaeYoung.Portal.Admin.Cmn
{
    public partial class MenuLangCodeExcelUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string serverPath = FxConfigManager.GetString("FileUploadPath");
            string folderPath = "TEMP\\";
            if (!Directory.Exists(serverPath + folderPath))
            {
                Directory.CreateDirectory(serverPath + folderPath);
            }
            string filePath = serverPath + folderPath + DateTime.Now.ToString("yyyyMMddhhmmsss") + Path.GetExtension(upExcel.FileName);
            upExcel.SaveAs(filePath);

            DataSet ds = ExcelCommon.ImportExcelToDataSet(filePath, true);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (string.IsNullOrEmpty(Convert.ToString(dr[0])))
                    continue;
                Hashtable ht = new Hashtable();
                ht["programid"] = dr[0];
                ht["code"] = dr[1];
                ht["ko"] = dr[2];
                ht["en"] = dr[3] == DBNull.Value ? "" : dr[3];
                ht["zh"] = dr[4] == DBNull.Value ? "" : dr[4];
                ht["ru"] = dr[5] == DBNull.Value ? "" : dr[5];

                using (LangBiz biz = new LangBiz())
                {
                    biz.AddLang(ht);
                }
            }

            File.Delete(filePath);
        }
    }
}