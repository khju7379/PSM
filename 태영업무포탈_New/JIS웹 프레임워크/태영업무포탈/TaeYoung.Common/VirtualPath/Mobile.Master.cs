using System;
using JINI.Base;
using TaeYoung.Biz;


namespace TaeYoung.Common.VirtualPath
{
	/// <summary>
	/// 공통 마스터 페이지
	/// </summary>
    public partial class Mobile : MasterBase
    {
		public delegate void mLoaded();
		public event mLoaded MasterLoaded;

		#region OnInit - 페이지 초기화
		/// <summary>
		/// 페이지 초기화
		/// </summary>
		/// <param name="e"></param>
		protected override void OnInit(EventArgs e)
		{
			if (Session["UserInfo"] == null)
			{
				return;
			}

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

            //string prtMenuID = string.Empty;
            //// 프로그램 및 메뉴 ID 로드
            //// 프로그램 경로로 현 페이지의 프로그램ID, 메뉴ID를 가져와서 페이지에 설정한다.
            //using (ProgramBiz biz = new ProgramBiz())
            //{
            //    string url = Request.Url.AbsolutePath;
            //    if (!string.IsNullOrEmpty(Request.QueryString["foid"]))
            //    {
            //        url += "?foid=" + Request.QueryString["foid"];
            //    }
            //    else if (!string.IsNullOrEmpty(Request.QueryString["SID"]))
            //    {
            //        if (url.IndexOf('?') > -1)
            //        {
            //            url += "&";
            //        }
            //        else
            //        {
            //            url += "?";
            //        }
            //        url += "SID=" + Request.QueryString["SID"];
            //    }

            //    DataSet ds = biz.GetProgramID(url);

            //    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            //    {
            //        ltlProgramID.Text = ds.Tables[0].Rows[0]["PROGRAMID"].ToString();
            //        ltlMenuID.Text = ds.Tables[0].Rows[0]["MENUID"].ToString();
            //    }
            //    else
            //    {
            //        ltlProgramID.Text = string.Empty;
            //        ltlMenuID.Text = string.Empty;
            //    }

            //    // QueryString에 MENUID가 있으면 대체(결재 예외처리)
            //    if (!string.IsNullOrEmpty(Request.QueryString["MENUID"]))
            //    {
            //        ltlMenuID.Text = Request.QueryString["MENUID"];
            //    }
            //}

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

            //// 개발시 ACL 확인안함
            //if (Request.Url.AbsoluteUri.IndexOf("localhost") > -1)
            //{
            //    ACL = true;
            //}

            //// 개발시 임시로 권한체크를 안함
            //ACL = true;

            //if (MasterLoaded != null) MasterLoaded();

            //// 메뉴 권한을 체크하여 권한이 없을시 화면 숨김
            //if (!ACL)
            //{
            //    conBody.Visible = false;
            //}
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
        /// tOpinion 컨트롤입니다.
        /// </summary>
        protected global::JINI.Control.WebControl.Text tOpinion;
        #endregion
    }
}