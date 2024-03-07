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

namespace TaeYoung.Resources.Framework
{
    /// <summary>
    /// 이미지 크기를 변경하여 브라우져에 이미지형식으로 보여준다
    /// </summary>
    public partial class ImageMigResize : System.Web.UI.Page
    {
        /// <summary>
        /// 페이지 로드
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            string unid = Request.QueryString["UNID"];
            int width = Convert.ToInt32(Request.QueryString["width"]);
            int height = Convert.ToInt32(Request.QueryString["height"]);
            string src = Request.QueryString["SRC"];
            string url = Request.QueryString["URL"];
            string mig_folder = Request.QueryString["volumeId"];
            string uploadPath = JINI.Base.Configuration.FxConfigManager.GetString("FileUploadPath"); ;
            if (!string.IsNullOrEmpty(url))
            {
                src = Server.MapPath(url);
                // 섬네일 생성하여 이미지를 화면에 보여줌
                using (Thumbnail thumbnail = new Thumbnail())
                using (ImageRender imageRender = new ImageRender())
                {
                    imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(src, "A", width == 0 ? 10000 : width, height == 0 ? 10000 : height));
                }
            }
            //else if (!string.IsNullOrEmpty(src))
            //{
            //    // 섬네일 생성하여 이미지를 화면에 보여줌
            //    using (Thumbnail thumbnail = new Thumbnail())
            //    using (ImageRender imageRender = new ImageRender())
            //    {
            //        string filePath = string.Empty;
            //
            //        if (!string.IsNullOrEmpty(mig_folder))
            //        {
            //            if (mig_folder == "bizwell.gw.app.sign.dir")
            //            {
            //                filePath = @"F:\Attach\sign\sjku" + src.Replace("/", @"\");
            //            }
            //            else
            //            {
            //                using (AttachFileBiz biz = new AttachFileBiz())
            //                {
            //                    DataSet ds = biz.GetMigPath(mig_folder);
            //                    if (ds != null && ds.Tables[0].Rows.Count > 0)
            //                    {
            //                        filePath = ds.Tables[0].Rows[0]["MIG_PATH"].ToString() + src.Replace("/", @"\");
            //                    }
            //                }
            //            }
            //        }
            //        else
            //        {
            //            if (src.IndexOf(uploadPath) < -1)
            //            {
            //                filePath = src;
            //            }
            //            else
            //            {
            //                filePath = uploadPath + src;
            //            }
            //        }
            //
            //        if (width == 0 && height == 0)
            //        {
            //            Response.ClearHeaders();
            //
            //            Response.ClearContent();
            //
            //            Response.ContentType = "image/GIF";
            //
            //            if (new FileInfo(filePath).Exists)
            //            {
            //                base.Response.WriteFile(filePath);
            //            }
            //
            //            base.Response.Flush();
            //            base.Response.End();
            //        }
            //        else
            //        {
            //            imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(filePath, "A", width == 0 ? 10000 : width, height == 0 ? 10000 : height));
            //        }
            //    }
            //}
            else
            {
                // UNID로 이미지 경로 리턴
                using (AttachFileBiz biz = new AttachFileBiz())
                {
                    DataSet ds = biz.GetAttachFile(unid);

                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        FileInfo f = new FileInfo(uploadPath + ds.Tables[0].Rows[0]["FILE_PATH"].ToString());

                        if (f.Exists)
                        {
                            // 섬네일 생성하여 이미지를 화면에 보여줌
                            using (Thumbnail thumbnail = new Thumbnail())
                            using (ImageRender imageRender = new ImageRender())
                            {
                                imageRender.MakeImageResizeStream(thumbnail.thumbnailImage(f.FullName, "A", width, height));
                            }

                        }
                    }
                }
            }
        }
    }
}