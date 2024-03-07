using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaeYoung.Common;
using System.Collections;

namespace Temp.WebTemplate.ControlSample
{
    public partial class WebTree : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region OnLangInit - 다국어 처리 데이터 정의
        /// <summary>
        /// 다국어 처리 데이터 정의
        /// </summary>
        /// <param name="e">arguments</param>
        protected override void OnLangInit(EventArgs e)
        {
            // wtNAME2
            wtNAME2.CheckBox = false;
            wtNAME2.Description = "WebTree 제목 설명";
            wtNAME2.HideTitle = false;
            wtNAME2.IndexBindFiledName = "IDX";
            wtNAME2.MethodName = "GetTreeTemplate";

            Hashtable ht = new Hashtable();
            ht["IDX"] = 0;
            wtNAME2.param = ht;

            wtNAME2.ParentBindFieldName = "PRTIDX";
            wtNAME2.TextBindFieldName = "TEXT";
            wtNAME2.TypeName ="Template.TemplateBiz";
            wtNAME2.Width=300;
            wtNAME2.OnClick = "wtNAME2_click";
            wtNAME2.OnLoaded = "wtNAME2_Loaded";


            // wtNAME8
            wtNAME8.CheckBox = false;
            wtNAME8.Description = "WebTree 제목 설명";
            wtNAME8.HideTitle = false;
            wtNAME8.IndexBindFiledName = "IDX";
            wtNAME8.MethodName = "GetTreeTemplate";

            Hashtable ht2 = new Hashtable();
            ht2["IDX"] = 1;
            wtNAME8.param = ht2;

            wtNAME8.ParentBindFieldName = "PRTIDX";
            wtNAME8.TextBindFieldName = "TEXT";
            wtNAME8.TypeName = "Template.TemplateBiz";
            wtNAME8.Width = 300;
            wtNAME8.OnClick = "wtNAME2_click";
            wtNAME8.OnLoaded = "wtNAME2_Loaded";
        }
        #endregion

    }
}