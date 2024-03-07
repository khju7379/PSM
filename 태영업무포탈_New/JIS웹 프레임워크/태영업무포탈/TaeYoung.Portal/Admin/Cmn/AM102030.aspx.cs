using System;
using TaeYoung.Common;
using TaeYoung.Biz.Common;
using TaeYoung.Biz;

namespace TaeYoung.Portal.Admin.Cmn
{
    /// <summary>
    /// 클래스 설명을 기술한다.
    /// </summary>
    public partial class AM102030 : BasePage
    {
        #region OnLangInit - 다국어 처리 데이터 정의
        /// <summary>
        /// 다국어 처리 데이터 정의
        /// </summary>
        /// <param name="e">arguments</param>
        protected override void OnLangInit(EventArgs e)
        {
            InitComboGroupType();
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

        #region InitComboGroupType - 그룹유형 콤보박스 세팅
        /// <summary>
        /// 그룹유형 콤보박스 세팅
        /// </summary>
        private void InitComboGroupType()
        {
            //using (CommonBiz biz = new CommonBiz())
            //{
            //    //Hashtable ht = new Hashtable();
            //    //ht["PCODE"] = "AM02";
            //    //ht["LANGCODE"] = TaeYoung.Biz.Document.ClientCultureName;
                
            //    cboGrpType.DataTextField = "CODTXT";
            //    cboGrpType.DataValueField = "CODE";
            //    cboGrpType.DataSource = biz.GetComCode(Document.UserInfo.CompanyCode, "AM02", Document.ClientCultureName);
            //    cboGrpType.DataBind();
            //    //cboGrpType.Items.Insert(0, "");
            //}
        }
        #endregion
    }
}