using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using JINI.Base;
using TaeYoung.Biz.Common;
using TaeYoung.Common;
using TaeYoung.Biz;
using JINI.Control.WebControl;
using System.Web.UI;

namespace TaeYoung.WebTemplate
{
    public partial class Design : BasePage 
    {
        public Design()
        {
            this.None = true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Head1.Title = Head1.Title + "(" + Document.UserInfo.UserName + ")";

            string prtMenuID = string.Empty;
            // 프로그램 및 메뉴 ID 로드
            // 프로그램 경로로 현 페이지의 프로그램ID, 메뉴ID를 가져와서 페이지에 설정한다.
            using (ProgramBiz biz = new ProgramBiz())
            {
                string url = Request.Url.AbsolutePath;
                if (!string.IsNullOrEmpty(Request.QueryString["foid"]))
                {
                    url += "?foid=" + Request.QueryString["foid"];
                }
                else if (!string.IsNullOrEmpty(Request.QueryString["SID"]))
                {
                    if (url.IndexOf('?') > -1)
                    {
                        url += "&";
                    }
                    else
                    {
                        url += "?";
                    }
                    url += "SID=" + Request.QueryString["SID"];
                }

                DataSet ds = biz.GetProgramID(url, Document.UserInfo.IsVend);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    ltlProgramID.Text = ds.Tables[0].Rows[0]["PROGRAMID"].ToString();
                    ltlMenuID.Text = ds.Tables[0].Rows[0]["MENUID"].ToString();
                }
                else
                {
                    ltlProgramID.Text = string.Empty;
                    ltlMenuID.Text = string.Empty;
                }

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    ltlTopMenuID.Text = ds.Tables[1].Rows[0]["MENUID"].ToString().Trim();
                }

                // QueryString에 MENUID가 있으면 대체(결재 예외처리)
                if (!string.IsNullOrEmpty(Request.QueryString["MENUID"]))
                {
                    ltlMenuID.Text = Request.QueryString["MENUID"];
                }
            }

            //// 사용자 그룹 및 현재 페이지의 권한 설정
            //using (OrgChartBiz biz = new OrgChartBiz())
            //{
            //    DataSet ds = biz.GetACL(Document.UserInfo.EmpID, Document.UserInfo.CompanyCode, ltlMenuID.Text);

            //    UserGroup = new List<string>();

            //    if (ds != null && ds.Tables.Count > 0)
            //    {
            //        // 첫번째 테이블은 그룹 리스트
            //        foreach (DataRow dr in ds.Tables[0].Rows)
            //        {
            //            UserGroup.Add(dr[0].ToString());
            //        }

            //        // 두번째 테이블은 현 페이지의 사용권한
            //        if (Convert.ToInt32(ds.Tables[1].Rows[0][0]) > 0)
            //        {
            //            ACL = true;
            //        }
            //        else
            //        {
            //            ACL = false;
            //        }
            //    }
            //}

            // 좌측메뉴 예외처리 확인후 컨트롤이 있을시 페이지에서 바인딩한 메뉴를 바인딩하고 
            // 없을시 기본메뉴가 바인딩되도록 처리한다.
            bool isMenu = false;
            
            if (!isMenu)
            {
                WebTree treeMenu = new WebTree();
                treeMenu.ID = "treeMenu";
                treeMenu.Width = 199;
                treeMenu.OnClick = "treeMenu_click";
                //treeMenu.OnLoaded = "treeMenu_Loaded";
                treeMenu.Commonable = true;
                treeMenu.TypeName = "Common.MenuBiz";
                treeMenu.MethodName = "GetMenuSubData";
                treeMenu.Title = "테스트트리";
                treeMenu.HideTitle = true;
                //treeMenu.EnableSearchBox = true;

                // 테스트 위하여 기본페이지는 테스트페이지로
                Hashtable ht = new Hashtable();
                //ht.Add("MENUID", ltlMenuID.Text.Length>0?ltlMenuID.Text.Substring(0, 2):"");
                //ht.Add("MENUID", ltlMenuID.Text.Length > 0 ? ltlMenuID.Text.Substring(0, 2) : "");
                ht.Add("MENUID", ltlTopMenuID.Text);
                treeMenu.param = ht;

                
            }

            // 개발시 ACL 확인안함
            if (Request.Url.AbsoluteUri.IndexOf("localhost") > -1)
            {
                ACL = true;
            }

            // 개발시 임시로 권한체크를 안함
            ACL = true;

            
        }
    }
}