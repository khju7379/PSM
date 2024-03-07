using System;
using TaeYoung.Common;
using System.Collections;
using TaeYoung.Biz.Common;
using TaeYoung.Biz;

namespace TaeYoung.Portal.Admin.Cmn
{
    /// <summary>
    /// 클래스 설명을 기술한다.
    /// </summary>
    public partial class AM102031P : BasePage
    {
        public AM102031P()
        {
            this.Popup = true;
        }

        #region OnLangInit - 다국어 처리 데이터 정의
        /// <summary>
        /// 다국어 처리 데이터 정의
        /// </summary>
        /// <param name="e">arguments</param>
        protected override void OnLangInit(EventArgs e)
        {
            this.InitComboGroupType();
            this.GetQueryString();
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

        #region GetQueryString - Query스트링을 가져온다.
		/// <summary>
        /// Query스트링을 가져온다.
        /// </summary>
        private void GetQueryString()
        {
            this.txtGroupCode.Text = string.IsNullOrEmpty(Request.QueryString["GrpID"]) ? string.Empty : System.Web.HttpUtility.UrlDecode(Request.QueryString["GrpID"]);
            if (!string.IsNullOrEmpty(this.txtGroupCode.Text))
            {
                this.txtGroupCode.ReadOnly = true;
            }
        } 
	#endregion

        #region InitComboGroupType - 그룹유형 콤보박스 세팅
        /// <summary>
        /// 그룹유형 콤보박스 세팅
        /// </summary>
        private void InitComboGroupType()
        {
            //using (CommonBiz biz = new CommonBiz())
            //{
            //    cboGrpType.DataTextField = "CODTXT";
            //    cboGrpType.DataValueField = "CODE";
            //    cboGrpType.DataSource = biz.GetComCode(Document.UserInfo.CompanyCode, "AM02", Document.ClientCultureName);
            //    cboGrpType.DataBind();
            //}
        }
        #endregion
    }
}