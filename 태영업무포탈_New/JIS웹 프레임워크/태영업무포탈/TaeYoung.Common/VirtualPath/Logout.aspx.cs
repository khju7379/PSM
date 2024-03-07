using System;

namespace TaeYoung.Common.VirtualPath
{
	/// <summary>
	/// 로그아웃 페이지
	/// </summary>
	public partial class Logout : System.Web.UI.Page
    {
		public string Path 
		{
			get
			{
                return Request.Url.LocalPath.Replace("/VirtualPageDir/Logout.aspx", "").Replace("/", ""); //		LocalPath	"/Templete/LoginPageDir/Logout.aspx"	string
			}
		}

		#region Page_Load - 페이지 로드 이벤트
		/// <summary>
		/// 페이지 로드 이벤트
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Page_Load(object sender, EventArgs e)
		{
			Session.Abandon();
			Session.Clear();
			System.Web.Security.FormsAuthentication.SignOut();
		} 
		#endregion

        #region
        /// <summary>
        /// form1 컨트롤입니다.
        /// </summary>
        /// <remarks>
        /// 자동 생성 필드입니다.
        /// 수정하려면 디자이너 파일에서 코드 숨김 파일로 필드 선언을 이동하십시오.
        /// </remarks>
        protected global::System.Web.UI.HtmlControls.HtmlForm form1;
        #endregion
    }
}