using System;
using System.Data;
using System.Web;
using TaeYoung.Biz.Common;
using TaeYoung.Biz;

namespace TaeYoung.Common.VirtualPath
{
	public partial class Popup : System.Web.UI.MasterPage
	{
		//public void event   

		public delegate void mLoaded();
		public event mLoaded MasterLoaded;

		public string CompanyCode
		{
			get
			{
				if (Session["CompanyCode"] != null)
				{
					return Session["CompanyCode"].ToString();
				}
				return "Q100";
			}
		}
		/// <summary>
		/// 
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Page_Load(object sender, EventArgs e)
		{
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

                DataSet ds = biz.GetProgramID(url,Document.UserInfo.IsVend);

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

                // QueryString에 MENUID가 있으면 대체(결재 예외처리)
                if (!string.IsNullOrEmpty(Request.QueryString["MENUID"]))
                {
                    ltlMenuID.Text = Request.QueryString["MENUID"];
                }
            }

			if (MasterLoaded != null) MasterLoaded();
		}

		protected void btnCustName_Click(object sender, EventArgs e)
		{
		}

		#region btnLogout_Click - Logout 버튼 클릭 이벤트
		/// <summary>
		/// Logout 버튼 클릭 이벤트
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void btnLogout_Click(object sender, EventArgs e)
		{
			HttpContext.Current.Session.Clear();
			System.Web.Security.FormsAuthentication.SignOut();
			Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl);
		}
		#endregion

        #region
        /// <summary>
        /// Head1 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::System.Web.UI.HtmlControls.HtmlHead Head1;

        /// <summary>
        /// ltlProgramID 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Literal ltlProgramID;

        /// <summary>
        /// ltlMenuID 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Literal ltlMenuID;

        /// <summary>
        /// conHead 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::System.Web.UI.WebControls.ContentPlaceHolder conHead;

        /// <summary>
        /// form1 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::System.Web.UI.HtmlControls.HtmlForm form1;

        /// <summary>
        /// conBody 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::System.Web.UI.WebControls.ContentPlaceHolder conBody;

        /// <summary>
        /// tOpinion 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::JINI.Control.WebControl.Text tOpinion;
        #endregion

    }
}