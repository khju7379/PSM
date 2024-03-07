using System;
using TaeYoung.Common;

namespace TaeYoung.Portal.Admin.Cmn
{
    /// <summary>
    /// 클래스 설명을 기술한다.
    /// </summary>
    public partial class AM102033P : BasePage
    {
        public AM102033P()
		{
			this.Popup = true;
		}

		public string MENUID
		{
			get
			{
				return Request.QueryString["MENUID"];
			}
		}

		#region OnLangInit - 다국어 처리 데이터 정의
		/// <summary>
		/// 다국어 처리 데이터 정의
		/// </summary>
		/// <param name="e">arguments</param>
		protected override void OnLangInit(EventArgs e)
		{

		}
		#endregion

		#region Page_Load - 페이지 로드
		/// <summary>
		/// 페이지 로드
		/// </summary>
		/// <param name="sender">this</param>
		/// <param name="e">arguments</param>
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
			}
		}
		#endregion

    }
}