using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Data;
using JINI.Util;
using System.IO;
using System.Drawing;
using System.Text;

namespace TaeYoung.Portal.PSM
{
    public partial class PSMImageViewer : System.Web.UI.Page
    {
        #region Page_Load()
        protected void Page_Load(object sender, EventArgs e)
        {
            Hashtable ht = new Hashtable();

            ht["P_AFFILENAME"] = Request.QueryString[0].ToString();

            string sFilePath = Path.GetExtension(Request.QueryString[0].ToString());

            if (sFilePath != ".pdf")
            {
                using (Biz.PSM.PSM2010 biz = new Biz.PSM.PSM2010())
                {
                    DataSet ds = biz.UP_ATTFILE_DOWN(ht);

                    byte[] bin = (byte[])ds.Tables[0].Rows[0]["AFBINARY"];

                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(bin);

                    // 섬네일 생성하여 이미지를 화면에 보여줌
                    //using (ImageRender imageRender = new ImageRender())
                    //{

                    //    imageRender.MakeImageResizeStream(byteArrayToImage((byte[])ds.Tables[0].Rows[0]["AFBINARY"]));
                    //}                
                }
            }
            else
            {
                // dwg file -> pdf 변환
                ht["P_AFFILENAME"] = "200-107(2022.03).dwg";

                using (Biz.PSM.PSM2010 biz = new Biz.PSM.PSM2010())
                {
                    DataSet ds = biz.UP_ATTFILE_DOWN(ht);

                    byte[] bin = (byte[])ds.Tables[0].Rows[0]["AFBINARY"];

                    MemoryStream ms = new MemoryStream(bin);

                    MemoryStream msfile = new MemoryStream();

                    //using (Aspose.CAD.Image image = Aspose.CAD.Image.Load(ms))
                    //{

                    //    // Create an instance of CadRasterizationOptions and set its various properties
                    //    Aspose.CAD.ImageOptions.CadRasterizationOptions rasterizationOptions = new Aspose.CAD.ImageOptions.CadRasterizationOptions();
                    //    rasterizationOptions.BackgroundColor = Aspose.CAD.Color.White;
                    //    rasterizationOptions.PageWidth = 1920;
                    //    rasterizationOptions.PageHeight = 1080;

                    //    // Create an instance of PdfOptions
                    //    Aspose.CAD.ImageOptions.PdfOptions pdfOptions = new Aspose.CAD.ImageOptions.PdfOptions();
                    //    // Set the VectorRasterizationOptions property
                    //    pdfOptions.VectorRasterizationOptions = rasterizationOptions;

                    //    //MyDir = MyDir + "d:\\Bottom_plate_out.pdf";
                    //    //Export the DWG to PDF

                    //    //image.Save("e:\\TY-T-106-003_out.pdf", pdfOptions);                    

                    //    //byte[] pdffile = UP_Get_Byte("e:\\TY-T-106-003_out.pdf");

                    //    //Response.ContentType = "application/pdf";
                    //    //Response.BinaryWrite(pdffile);                        

                    //    image.Save(msfile, pdfOptions);

                    //    byte[] bytearray = msfile.ToArray();

                    //    Response.ContentType = "application/pdf";
                    //    Response.BinaryWrite(bytearray);

                    //    ms.Dispose();
                    //    msfile.Dispose();
                    //}
                }
            }
        }
        #endregion

        #region byteArrayToImage()
        public Image byteArrayToImage(byte[] byteArrayIn)
        {
            MemoryStream ms = new MemoryStream(byteArrayIn);
            Image returnImage = Image.FromStream(ms);
            return returnImage;

        }
        #endregion


    }
}