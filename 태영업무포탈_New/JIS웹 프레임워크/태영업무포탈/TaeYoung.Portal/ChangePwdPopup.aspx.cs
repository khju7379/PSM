using System;
using System.Data;
using System.Collections;

using TaeYoung.Common;
using TaeYoung.Biz.Common;

namespace TaeYoung.Portal
{
    public partial class ChangePwdPopup : BasePage
    {
        public ChangePwdPopup()
        {
            this.Popup = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region OnLangInit - 다국어 처리 데이터 정의
        protected override void OnLangInit(EventArgs e)
        {
        }
        #endregion

    }
}