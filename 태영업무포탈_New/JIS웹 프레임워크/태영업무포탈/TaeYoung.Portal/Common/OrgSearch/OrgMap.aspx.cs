using System;
using System.Data;
using System.Collections;
using JINI.Control.WebControl;
using TaeYoung.Biz;
using TaeYoung.Common;
using TaeYoung.Biz.Common;
using JINI.Base.Configuration;

namespace TaeYoung.Portal.Common.OrgSearch
{
    public partial class OrgMap : BasePage
    {
        public OrgMap()
        {
            this.None = true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            this.SetOrg();

            if(UserGroup.Exists(s=>s=="9999"))
            {
                passwd_clear.Visible = true;
            }
        }

        public bool IsAdmin
        {
            get
            {
                return UserGroup.Exists(s => s == "9999");
            }
        }

        public string GetDominoDomain 
        {
            get
            {
                return FxConfigManager.GetString("DominoURL");
            }
        }

        #region DEPTCD - 부서코드
        /// <summary>
        /// 부서코드
        /// </summary>
        public string DEPTCD
        {
            get
            {
                return Document.UserInfo.DeptCode;
            }
        }
        #endregion

        

        #region LANGCODE - 언어코드
        /// <summary>
        /// 언어코드
        /// </summary>
        public string LANGCODE
        {
            get
            {
                return Document.ClientCultureName;
            }
        }
        #endregion

        #region SetOrg - 조직도 초기화
        /// <summary>
        /// 조직도 초기화
        /// </summary>
        private void SetOrg()
        {
            DataSet dsCompany = null;
            //DataSet dsAddGroup = null;
            Hashtable ht1 = new Hashtable();
            ht1["LANGCD"] = Document.UserInfo.ClientCultureName;

            using (OrgChartBiz biz = new OrgChartBiz())
            {
                dsCompany = biz.GetCompanyCombo(ht1);
                //dsAddGroup = biz.SelectGroup(Document.UserInfo.CompanyCode, Document.UserInfo.ClientCultureName);
            }
            this.cboOrg.ClientIDMode = System.Web.UI.ClientIDMode.Static;
            this.cboOrg.DataSource = dsCompany.Tables[0];
            this.cboOrg.DataValueField = "COMPANYCODE";
            this.cboOrg.DataTextField = "COMPANY";
            this.cboOrg.DataBind();
            this.cboOrg.Value = Document.UserInfo.CompanyCode;

            //this.cboGrp.DataSource = dsAddGroup.Tables[0];
            //this.cboGrp.DataValueField = "GroupCode";
            //this.cboGrp.DataTextField = "GroupName";
            //this.cboGrp.DataBind();
            //this.cboGrp.Items.Insert(0, new System.Web.UI.WebControls.ListItem("=== SELECT ==="));


            treeOrg.Width = 190;
            treeOrg.OnClick = "treeOrg_click";
            treeOrg.OnLoaded = "treeOrg_Loaded";
            //treeOrg.Commonable = true;
            treeOrg.TypeName = "Common.OrgChartBiz";
            treeOrg.MethodName = "GetOrgSearch";
            treeOrg.Title = "조직도";
            treeOrg.HideTitle = true;
            //treeOrg.EnableSearchBox = true;

            Hashtable ht2 = new Hashtable();
            ht2.Add("COMPANYCODE", this.cboOrg.Value);
            ht2.Add("LANGCODE", Document.UserInfo.ClientCultureName);
            ht2.Add("SEARCHSTRING", "");
            treeOrg.param = ht2;

        }
        #endregion
    }
}