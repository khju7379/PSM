using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JINI.Control.WebControl.AttachBiz;
using System.Data;
using System.IO;
using JINI.Util;
using System.Collections;

namespace TaeYoung.Portal.PSM
{
    /// <summary>
    /// 이미지를 브라우져에 이미지형식으로 보여준다
    /// </summary>
    public partial class PSM1100_Down : System.Web.UI.Page
    {
        /// <summary>
        /// 페이지 로드
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // URL만 체크해서 처리함(웹에디터용)
            string sabun = Request.QueryString["sabun"];
            string name = Request.QueryString["name"];

            if (!string.IsNullOrEmpty(sabun))
            {
                using (TaeYoung.Biz.PSM.PSMBiz biz = new TaeYoung.Biz.PSM.PSMBiz())
                {
                    Hashtable ht = new Hashtable();

                    ht["P_KBSABUN"] = sabun;

                    DataSet ds = biz.UP_KBSABUN_RUN(ht);

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        byte[] byteArray = ds.Tables[0].Rows[0]["ATTACH_BYTE"] as byte[];

                        if (byteArray != null)
                        {
                            MemoryStream fs = new MemoryStream();
                            fs.Write(byteArray, 0, byteArray.Length);

                            if (fs == null) return;// 파일이 없을시 취소

                            Response.ClearHeaders();

                            Response.ClearContent();

                            Response.ContentType = "application/octet-stream";

                            Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpContext.Current.Server.UrlEncode(name).Replace("+", "%20") + "\"");

                            Response.AppendHeader("FileSize", fs.Length.ToString());//f.Length.ToString());

                            Response.BinaryWrite(fs.ToArray());

                            Response.Flush();
                        }
                    }
                    else
                    {

                    }
                }
            }
        }
    }
}