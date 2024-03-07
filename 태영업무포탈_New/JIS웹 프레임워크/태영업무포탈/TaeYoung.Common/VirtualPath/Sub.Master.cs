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
using System.Web.UI.WebControls;


namespace TaeYoung.Common.VirtualPath
{
	/// <summary>
	/// 공통 마스터 페이지
	/// </summary>
    public partial class Sub : MasterBase
    {
		public delegate void mLoaded();
		public event mLoaded MasterLoaded;

        public string LangCode
        {
            get
            {
                return Document.ClientCultureName.ToUpper();
            }
        }

		#region OnInit - 페이지 초기화
		/// <summary>
		/// 페이지 초기화
		/// </summary>
		/// <param name="e"></param>
		protected override void OnInit(EventArgs e)
		{
            //if (Session["UserInfo"] == null)
            //{
            //    return;
            //}

            base.OnInit(e);

            this.Load += new EventHandler(Page_Load);
		} 
		#endregion
	
		#region Page_Load - 페이지 로드
		/// <summary>
		/// 페이지 로드
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Page_Load(object sender, EventArgs e)
		{
            Head1.Title = Head1.Title + "(" + Document.UserInfo.UserName + ")";

            bool isLeftMenuDefault = false;

            if (Document.UserInfo.IsVend || Document.UserInfo.CompanyCode == "TY")
            {
                
                //member_search2.Visible = false;
                if (Document.UserInfo.SignID == "Portal")
                {
                    menuQList.Visible = true;
                }
                else
                {
                    menuQList.Visible = false;
                }
            }


            member_search2.Visible = false;

            string prtMenuID = string.Empty;
			// 프로그램 및 메뉴 ID 로드
			// 프로그램 경로로 현 페이지의 프로그램ID, 메뉴ID를 가져와서 페이지에 설정한다.
            using (ProgramBiz biz = new ProgramBiz())
			{
                //string url = Request.Url.PathAndQuery;
                var nvc = HttpUtility.ParseQueryString(Request.Url.Query);
                nvc.Remove("company");
                nvc.Remove("DomAuthSessId");

                // 각 페이지별 쿼리스트링 문제로 프로그램 아이디를 가져오지 못하므로 여기서 예외처리한다.
                //nvc.Remove("COMPANYCODE");

                string url = string.Empty;

                if (nvc.Count > 0)
                    url = Request.Url.AbsolutePath + "?" + nvc.ToString();
                else
                    url = Request.Url.AbsolutePath;

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

                // DB 저장시 & 자동변경
                url = url.Replace("?Chk=1", "").Replace("&Chk=1", "").Replace("?AllChk=1", "").Replace("&AllChk=1", "").Replace("?makeLang=1", "").Replace("&makeLang=1", "").Replace("&", "&amp;");
                
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

                    // 좌측메뉴의 예외처리가 없을시 정의
                    if (this.conLeft.Controls.Count == 0)
                    {
                        Literal ltlLeftTitle = new Literal();
                        // 메뉴열고 닫기 추가에 따른 수정 2017-07-18 (장윤호)
                        ltlLeftTitle.Text = "<div><h3>" + ds.Tables[1].Rows[0]["MENUNAME"].ToString().Trim() + "<a onclick='LeftMenuHideShow();'>◀</a></h3></div>";
                        ltlMenuName.Text = " - " + ds.Tables[1].Rows[0]["MENUNAME"].ToString().Trim();
                        //ltlLeftTitle.Text = "<div><h3>" + ds.Tables[1].Rows[0]["MENUNAME"].ToString().Trim() + "</h3></div>";
                        this.conLeft.Controls.Add(ltlLeftTitle);
                        isLeftMenuDefault = true;
                    }
                    else
                    {
                        Literal ltlLeftTitle = new Literal();
                        // 메뉴열고 닫기 추가에 따른 수정 2017-07-18 (장윤호)
                        ltlLeftTitle.Text = "<div><h3>" + ds.Tables[1].Rows[0]["MENUNAME"].ToString().Trim() + "<a onclick='LeftMenuHideShow();'>◀</a></h3></div>";
                        ltlMenuName.Text = " - " + ds.Tables[1].Rows[0]["MENUNAME"].ToString().Trim();
                        this.conLeft.Controls.AddAt(0,ltlLeftTitle);
                        isLeftMenuDefault = true;
                    }
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
            foreach (Control treeCtl in conLeft.Controls)
            {
                if (treeCtl is WebTree)
                {
                    isMenu = true;
                }
            }
            if (!isMenu)
            {
                // 좌측메뉴의 예외처리가 없을시 정의
                // 속도 문제로 인하여 강제로 마스터 페이지에서 처리함
                //if (isLeftMenuDefault)
                //{
                //    WebTree treeMenu = new WebTree();
                //    treeMenu.ID = "treeMenu";
                //    treeMenu.Width = 219;
                //    treeMenu.OnClick = "treeMenu_click";
                //    //treeMenu.OnLoaded = "treeMenu_Loaded";
                //    treeMenu.Commonable = true;
                //    treeMenu.TypeName = "Common.MenuBiz";
                //    treeMenu.MethodName = "GetMenuSubData";
                //    treeMenu.Title = "";
                //    treeMenu.HideTitle = true;
                //    //treeMenu.EnableSearchBox = true;

                //    // 테스트 위하여 기본페이지는 테스트페이지로
                //    Hashtable ht = new Hashtable();
                //    //ht.Add("MENUID", ltlMenuID.Text.Length>0?ltlMenuID.Text.Substring(0, 2):"");
                //    //ht.Add("MENUID", ltlMenuID.Text.Length > 0 ? ltlMenuID.Text.Substring(0, 2) : "");
                //    ht.Add("MENUID", ltlTopMenuID.Text);
                //    treeMenu.param = ht;
                //    treeMenu.OnLoaded = "LeftMenuLoaded";

                //    conLeft.Controls.Add(treeMenu);
                //}
            }

			// 개발시 ACL 확인안함
			if (Request.Url.AbsoluteUri.IndexOf("localhost") > -1)
			{
				ACL = true;
			}

            // 개발시 임시로 권한체크를 안함
            ACL = true;

			if (MasterLoaded != null) MasterLoaded();

			// 메뉴 권한을 체크하여 권한이 없을시 화면 숨김
			if (!ACL)
			{
				conBody.Visible = false;
                lblNoACL.Visible = true;
			}


            //UTT 운송사는 매출메뉴 사용권한 제한
            if ((ltlMenuID.Text == "TYCSI1010" || ltlMenuID.Text == "TYCSI1020" ||
                 ltlMenuID.Text == "TYCSI1030" || ltlMenuID.Text == "TYCSI1040" ||
                 ltlMenuID.Text == "TYCSI1050" || ltlMenuID.Text == "TYCSI1060" ||
                 ltlMenuID.Text == "TYCSI1090" || ltlMenuID.Text == "TYCSI1100" ||
                 ltlMenuID.Text == "TYCSI2020" || ltlMenuID.Text == "TYCSI2030") && Document.UserInfo.JobCode == "Y")
            {
                conBody.Visible = false;
                lblNoACL.Visible = true;
            }

            // 회사변경 처리
            //LocationlinkBtn.Visible = false;

            //ltlLocation

            //LocationlinkBtn.Visible = false;
		} 
		#endregion

        #region
        /// <summary>
        /// Head1 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.HtmlControls.HtmlHead Head1;

        /// <summary>
        /// ltlProgramID 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.Literal ltlProgramID;

        /// <summary>
        /// ltlCustomStyle 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.Literal ltlCustomStyle;

        /// <summary>
        /// ltlTopMenuID 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.Literal ltlTopMenuID;

        /// <summary>
        /// lblNoACL 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.Label lblNoACL;

        /// <summary>
        /// ltlMenuID 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.Literal ltlMenuID;

        /// <summary>
        /// ltlManualExist 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.Literal ltlManualExist;

        /// <summary>
        /// conHead 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.ContentPlaceHolder conHead;

        /// <summary>
        /// form1 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.HtmlControls.HtmlForm form1;

        /// <summary>
        /// conBody 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.ContentPlaceHolder conBody;

        /// <summary>
        /// conBody 컨트롤입니다.
        /// </summary>
        protected global::System.Web.UI.WebControls.ContentPlaceHolder conLeft;

        /// <summary>
        /// tOpinion 컨트롤입니다.
        /// </summary>
        protected global::JINI.Control.WebControl.Text tOpinion;

        protected global::System.Web.UI.HtmlControls.HtmlAnchor LocationlinkBtn;

        protected global::System.Web.UI.WebControls.Literal ltlLocation;

        protected global::System.Web.UI.WebControls.Literal ltlMenuName;

        protected global::System.Web.UI.HtmlControls.HtmlGenericControl menuQList;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl member_search2;
        #endregion
    }
}