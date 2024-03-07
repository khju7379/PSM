using System;
using System.Collections;
using System.Data;
using TaeYoung.Common;


namespace TaeYoung.Portal.Admin.Cmn
{
    public partial class MenuLangCode : BasePage
    {
        //public MenuLangCode()
        //{
        //    this.Popup = true;
        //}
        protected void Page_Load(object sender, EventArgs e)
        {
            // cs에서 다국어 처리 로드
            //string a = GetLangCode("TEST0001");
            
            //메뉴목록 콤보 초기화
            this.InitComboForMenu();

            //트리 초기화
            this.InitTree();
        }

        #region InitComboForMenu - 메뉴목록 콤보
        private void InitComboForMenu()
        {
            Hashtable ht = new Hashtable();
            TaeYoung.Biz.Common.MenuBiz biz = new TaeYoung.Biz.Common.MenuBiz();

            //법인 콤보
            DataTable dt = biz.GetMenuCombo(ht).Tables[0];

            this.cboMenuList.DataTextField = TaeYoung.Biz.Document.UserInfo.ClientCultureName;
            this.cboMenuList.DataValueField = "MENUID";
            this.cboMenuList.DataSource = dt;
            this.cboMenuList.DataBind();

            this.cboMenuList.SelectedValue = "MENU00";
        }
        #endregion

        #region InitTree - 트리 초기화
        private void InitTree()
        {
            //메뉴 관리 트리
            wtMENU.TypeName = "Portal.MenuBiz";
            wtMENU.MethodName = "GetMenuSearchTree";
            wtMENU.Title = "메뉴관리";
            wtMENU.Description = "메뉴관리";
            wtMENU.HideTitle = true;
            wtMENU.IndexBindFiledName = "MENUID";
            wtMENU.TextBindFieldName = "KO";
            wtMENU.ParentBindFieldName = "PRTMENU";
            wtMENU.OnLoaded = "wtMENU_Loaded";

            Hashtable wtMENUHt = new Hashtable();
            wtMENUHt.Add("MENUID", "");
            wtMENUHt.Add("PROGRAMID", "");

            wtMENU.param = wtMENUHt;

            //프로그램 관리 트리
            wtPRORAM.TypeName = "Portal.MenuBiz";
            wtPRORAM.MethodName = "GetProgramDataTree";
            wtPRORAM.Title = "프로그램 관리";
            wtPRORAM.Description = "프로그램 관리";
            wtPRORAM.HideTitle = true;
            wtPRORAM.IndexBindFiledName = "PROGRAMID";
            wtPRORAM.TextBindFieldName = "DESCRIPTION";
            wtPRORAM.ParentBindFieldName = "";
            wtPRORAM.OnLoaded = "wtPRORAM_Loaded";
            wtPRORAM.param = wtMENUHt;

            //다국어 관리 트리
            wtLANG.TypeName = "Portal.MenuBiz";
            wtLANG.MethodName = "GetLangDataTree";
            wtLANG.Title = "프로그램 관리";
            wtLANG.Description = "프로그램 관리";
            wtLANG.HideTitle = true;
            wtLANG.IndexBindFiledName = "CODE";
            wtLANG.TextBindFieldName = "KO";
            wtLANG.ParentBindFieldName = "";
            wtLANG.OnLoaded = "wtLANG_Loaded";
            wtLANG.param = wtMENUHt;
        }
        #endregion
    }
}