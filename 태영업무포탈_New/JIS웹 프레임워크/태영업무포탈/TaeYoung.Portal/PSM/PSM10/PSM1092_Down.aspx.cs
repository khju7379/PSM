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

namespace TaeYoung.Portal.PSM.PSM10
{
    public partial class PSM1092_Down : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // URL만 체크해서 처리함(웹에디터용)
            string fileid = Request.QueryString["fileid"];
            string name = Request.QueryString["name"];
            string gubun = Request.QueryString["fileid"].Split('-')[1];

            if (!string.IsNullOrEmpty(fileid))
            {
                if (fileid.Length <= 18)    // JSA 기준관리
                {
                    using (TaeYoung.Biz.PSM.PSM1090 biz = new TaeYoung.Biz.PSM.PSM1090())
                    {
                        Hashtable ht = new Hashtable();

                        ht["JSDBLASS"] = fileid.Substring(0, 2);
                        ht["JSDMLASS"] = fileid.Substring(2, 2);
                        ht["JSDSLASS"] = fileid.Substring(4, 3);
                        ht["JSDSEQ"] = fileid.Substring(7, 3);
                        ht["JSDITEMSEQ"] = fileid.Substring(10, 3);

                        DataSet ds = biz.UP_JSA_DETAIL_RUN(ht);

                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            byte[] byteArray;
                            if (gubun == "JSA")
                            {
                                byteArray = ds.Tables[0].Rows[0]["ATTACH_BYTE_JSA"] as byte[];
                            }
                            else
                            {
                                byteArray = ds.Tables[0].Rows[0]["ATTACH_BYTE_TOOL"] as byte[];
                            }


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
                else // JSA 변경관리
                {
                    using (TaeYoung.Biz.PSM.PSM4045 biz = new TaeYoung.Biz.PSM.PSM4045())
                    {
                        Hashtable ht = new Hashtable();

                        ht["P_JSDWKGUBN"] = fileid.Substring(0, 1);
                        ht["P_JSDPOTEAM"] = fileid.Substring(1, 6);
                        ht["P_JSDPODATE"] = fileid.Substring(7, 8);
                        ht["P_JSDPOSEQ"] = fileid.Substring(15, 3);
                        ht["P_JSDDATE"] = fileid.Substring(18, 8);
                        ht["P_JSDMSEQ"] = fileid.Substring(26, 3);
                        ht["P_JSDBLASS"] = fileid.Substring(29, 2);
                        ht["P_JSDMLASS"] = fileid.Substring(31, 2);
                        ht["P_JSDSLASS"] = fileid.Substring(33, 3);
                        ht["P_JSDSEQ"] = fileid.Substring(36, 3);
                        ht["P_JSDITEMSEQ"] = fileid.Substring(39, 3);

                        DataSet ds = biz.UP_JSACHANGE_DETAIL_RUN(ht);

                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            byte[] byteArray;
                            if (gubun == "JSA")
                            {
                                byteArray = ds.Tables[0].Rows[0]["ATTACH_BYTE_JSA"] as byte[];
                            }
                            else
                            {
                                byteArray = ds.Tables[0].Rows[0]["ATTACH_BYTE_TOOL"] as byte[];
                            }


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
}