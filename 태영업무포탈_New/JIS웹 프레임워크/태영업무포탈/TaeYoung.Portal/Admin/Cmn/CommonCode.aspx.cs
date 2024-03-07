using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TaeYoung.Common;
using JINI.Control.WebControl;
using TaeYoung.Biz.Common;

namespace TaeYoung.Portal.Admin.Cmn
{
    public partial class CommonCode : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // cs에서 다국어 처리 로드
            //string a = GetLangCode("TEST0001");

            //법인 코보 초기화
            this.InitComboForCompanyCode();

            //공통 코드 가져오기
            this.InitCombo(this.ScboDCODE, "CMN0100101", "CMN01001", false);
            this.InitCombo(this.IcboDCODE, "CMN0100101", "CMN01001", false);

            //트리 초기화
            this.InitTree();
        }

        #region InitComboForCompanyCode - 법인 콤보
        private void InitComboForCompanyCode()
        {
            Hashtable ht = new Hashtable();
            ht["LANGCD"] = TaeYoung.Biz.Document.UserInfo.ClientCultureName;

            OrgChartBiz biz = new OrgChartBiz();

            //법인 콤보
            DataTable dt = biz.GetCompanyCombo(ht).Tables[0];
            this.ScboCompanyCode.DataTextField = "COMPANY";
            this.ScboCompanyCode.DataValueField = "COMPANYCODE";
            this.ScboCompanyCode.DataSource = dt;
            this.ScboCompanyCode.DataBind();

            this.ScboCompanyCode.SelectedValue = TaeYoung.Biz.Document.UserInfo.SiteCompanyCode;

            this.IcboCompanyCode.DataTextField = "COMPANY";
            this.IcboCompanyCode.DataValueField = "COMPANYCODE";
            this.IcboCompanyCode.DataSource = dt;
            this.IcboCompanyCode.DataBind();

            this.IcboCompanyCode.SelectedValue = TaeYoung.Biz.Document.UserInfo.SiteCompanyCode;
        }
        #endregion

        #region InitCombo - 콤보박스 초기화
        /// <summary>
        /// 콤보박스 초기화
        /// </summary>
        private void InitCombo(Combo obj, string dcode ,string pcode, bool allFlag)
        {
            CommonBiz biz = new CommonBiz();
            Hashtable ht = new Hashtable();
            ht["COMPANYCODE"] = TaeYoung.Biz.Document.UserInfo.SiteCompanyCode;
            ht["DCODE"]       = dcode;
            ht["PCODE"]       = pcode;
            ht["LANGCODE"]    = TaeYoung.Biz.Document.UserInfo.ClientCultureName;

            DataTable dt = biz.GetCMN_CODE_LIST(ht).Tables[0];
            if (allFlag)
            {
                DataRow dr = dt.NewRow();

                dr["CODE"]   = "";
                dr["CODTXT"] = "";
                dt.Rows.InsertAt(dr, 0);
            }

            obj.DataTextField = "CODTXT";
            obj.DataValueField = "CODE";
            obj.DataSource = dt;
            obj.DataBind();

            obj.SelectedIndex = 0;
        }
        #endregion

        #region InitRadio - 라디로 버튼 초기화
        private void InitRadio(Radio obj, string dcode, string pcode, bool allFlag)
        {
            CommonBiz biz = new CommonBiz();
            Hashtable ht = new Hashtable();
            ht["COMPANYCODE"] = TaeYoung.Biz.Document.UserInfo.SiteCompanyCode;
            ht["DCODE"]       = dcode;
            ht["PCODE"]       = pcode;
            ht["LANGCODE"]    = TaeYoung.Biz.Document.UserInfo.ClientCultureName;

            DataTable dt = biz.GetCMN_CODE_LIST(ht).Tables[0];
            if (allFlag)
            {
                DataRow dr = dt.NewRow();

                dr["CODE"] = "";
                dr["CODTXT"] = "";
                dt.Rows.InsertAt(dr, 0);
            }

            obj.DataTextField = "CODTXT";
            obj.DataValueField = "CODE";
            obj.DataSource = dt;
            obj.DataBind();

            obj.SelectedIndex = 0;
        }
        #endregion

        #region InitTree - 트리 초기화
        private void InitTree()
        {
            wtWMSMENU.TypeName = "Common.CommonBiz";
            wtWMSMENU.MethodName = "GetCMN_CODETREE_LIST";
            wtWMSMENU.Title = "공토코드";
            wtWMSMENU.Description = "공통코드";
            wtWMSMENU.HideTitle = true;
            wtWMSMENU.IndexBindFiledName = "CODE";
            wtWMSMENU.TextBindFieldName = "CODTXT";
            wtWMSMENU.ParentBindFieldName = "PCODE";
            wtWMSMENU.OnLoaded = "wtWMSMENU_Loaded";
        }
        #endregion

    }
}