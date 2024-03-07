using System;
using TaeYoung.Common;

namespace TaeYoung.Portal.Admin.Cmn
{
    /// <summary>
    /// 클래스 설명을 기술한다.
    /// </summary>
    public partial class AM102032P : BasePage
    {
        public AM102032P()
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
            // cs 에서 다국어 호출을 지정 (다국어코드와 설명을 추가하여 cs에서 강제로 호출한다.)
            //LangCodeList.Add(new string[] { "TEST0006", "제목" });

            // 다국어 처리를 위하여 컨트롤 정의 부분은 OnLageLoad에 정의해야함. (데이터그리드, SearchView, 웹트리)
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