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

namespace TaeYoung.Portal.PSM
{
	/// <summary>
	/// 이미지를 브라우져에 이미지형식으로 보여준다
	/// </summary>
    public partial class PSM1100_Sign : System.Web.UI.Page
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

            //string sabun = "0287-M";

            if (!string.IsNullOrEmpty(sabun))
            {
                using (ImageRender imageRender = new ImageRender())
                using (TaeYoung.Biz.PSM.PSM1100 biz = new TaeYoung.Biz.PSM.PSM1100())
                {
                    //DataSet ds = biz.UP_IMGSIGN_SELECT(sabun);

                    //if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    //{
                    //    byte[] byteArray = ds.Tables[0].Rows[0]["IMGSIGN"] as byte[];
                    //    Stream stream = new MemoryStream(byteArray);
                    //    imageRender.MakeImageResizeStream(System.Drawing.Image.FromStream(stream));
                    //}
                    //else
                    //{
                    //    imageRender.MakeImageResizeStream(System.Drawing.Image.FromFile(Server.MapPath("/Resources/Framework/blank.gif"))); // 공백이미지
                    //}
                }
            }
		}
	}
}