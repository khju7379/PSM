<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuLangCode.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.MenuLangCode" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style type="text/css">
        #wtMENU
        {
            height:300px;
            overflow-y:auto;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#wtMENU").height(370);
        });
        //선택된 트리 값
        var selectWtMENU = "";
        var selectWtPROGRAM = "";
        var selectWtLANG = "";

        //데이터 셋 초기값(빈값)
        var initDataSet = 
        (
            {
                "DataSetName": "NewDataSet",
                "Tables": [
                    {
                        "TableName": "Table1",
                        "Rows": [
                        ]
                    },
                    {
                        "TableName": "Table2",
                        "Rows": [
                            {
                                "TOTALCOUNT": "1"
                            }
                        ]
                    }
                ]
            }
        );

        function OnLoad() {
            //선택 된 트리 값 초기화
            selectWtMENU = "";
            selectWtPROGRAM = "";
            selectWtLANG = "";

            //메뉴관리 조회
            treeMeNu_Inquery();

            //프로그램 관리 조회
            //treePRORAM_Inquery();

//            wtPRORAM.ParserJSON(initDataSet);
//            wtPRORAM.Rander("wtPRORAM");

            //다국어 조회
            //treeLANG_Inquery();

//            wtLANG.ParserJSON(initDataSet);
            //            wtLANG.Rander("wtLANG");

            // 트리 소팅 변경
            wtMENU.sortItem = function (a, b) {
                if (a.Values[11] > b.Values[11]) return 1;
                else return -1;
            }
        }

        /**********************************************************************
        * 메뉴 트리 조회
        **********************************************************************/
        function treeMeNu_Inquery() {
//            selectWtMENU = "";
            selectWtPROGRAM = "";
            selectWtLANG = "";

            

            //입력 폼 초기화
            initMenuInputData();

            var ht = new Object();
            ht["MENUID"] = cboMenuList.GetValue() == "MENU00" ? "" : cboMenuList.GetValue();

            wtMENU.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtMENU.BindTree("wtMENU");

            return false;
        }

        /**********************************************************************
        * 메뉴 트리 초기값
        **********************************************************************/
        function wtMENU_Loaded() {
            wtMENU.AllChildClose();
            var itemList = wtMENU.Search(selectWtMENU);
            if (itemList.length > 0) {
                itemList[0].Select();
                wtMENU_click(0,0);
            }

            return false;
        }

        /**********************************************************************
        * 메뉴 신규 버튼 클릭 이벤트
        **********************************************************************/
        function btnMenuNew_Click() {
            var prtMenuId = "";
            if (txtMN_MENUID.GetValue() != "") {
                prtMenuId = txtMN_MENUID.GetValue(); 
            }

            initMenuInputData();

            txtMN_PRTMENU.SetValue(prtMenuId);
            return false;
        }

        /**********************************************************************
        * 메뉴 저장 버튼 클릭 이벤트
        **********************************************************************/
        function btnMenuSave_Click() {
            if(txtMN_MENUID.GetValue() == ""){
                alert('<Ctl:Text ID="SAVE_MENU_MSG01" runat="server" LangCode="SAVE_MENU_MSG01" Description="메뉴아이디를 입력하십시오." Literal="true" />');
                return false;
            }

            if (!confirm('<Ctl:Text ID="SAVE_MENU_MSG02" runat="server" LangCode="SAVE_MENU_MSG02" Description="입력하신 정보를 저장하시겠습니까?" Literal="true" />')) 
            {
                return false;
            }

            var ht = new Object();
            ht["MENUID"] = txtMN_MENUID.GetValue();
            ht["PROGRAMID"] = txtMN_PROGRAMID.GetValue();
            ht["HIGHRANKID"] = txtMN_PRTMENU.GetValue();
            ht["SORTNO"] = txtMN_SORTNO.GetValue();
            ht["MENUTYPE"] = cboMN_MENUTYPE.GetValue();
            ht["IPYN"] = rdoMN_IPYN.GetValue() == "Y" ? "Y" : "N";
            ht["DISPLAYYN"] = rdoMN_DISPLAYYN.GetValue() == "Y" ? "Y" : "N";
            ht["KO"] = txtMN_MENU_KO.GetValue();
            ht["EN"] = txtMN_MENU_EN.GetValue();
            ht["CN"] = txtMN_MENU_ZH.GetValue();
            ht["RU"] = txtMN_MENU_RU.GetValue();

            selectWtMENU = txtMN_MENUID.GetValue();

            PageMethods.InvokeServiceTable(ht, "Common.MenuBiz", "AddMenuTree", btnMenuSave_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 메뉴 저장 버튼 클릭 콜백 함수
        **********************************************************************/
        function btnMenuSave_CallBack(e) {
            alert('<Ctl:Text ID="SAVE_MENU_MSG03" runat="server" LangCode="SAVE_MENU_MSG03" Description="입력하신 정보가 저장되었습니다." Literal="true" />');
            treeMeNu_Inquery();
            return false;
        }

        /**********************************************************************
        * 메뉴 삭제 버튼 클릭 이벤트
        **********************************************************************/
        function btnMenuRemove_Click() {
            if (!confirm('<Ctl:Text ID="REMOVE_MSG01" runat="server" LangCode="REMOVE_MSG01" Description="선택하신 정보를 삭제하시겠습니까?" Literal="true" />')) {
                return false;
            }

            selectWtMENU = "";
            
            var ht = new Object();
            ht["MENUID"] = txtMN_MENUID.GetValue();

            PageMethods.InvokeServiceTable(ht, "Portal.MenuBiz", "DeleteMenu", btnMenuRemove_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 메뉴 삭제 버튼 클릭 콜백 함수
        **********************************************************************/
        function btnMenuRemove_CallBack(e) {
            alert('<Ctl:Text ID="REMOVE_MSG02" runat="server" LangCode="REMOVE_MSG02" Description="입력하신 정보가 삭제되었습니다." Literal="true" />');

            initMenuInputData();
            treeMeNu_Inquery();

            return false;
        }

        /**********************************************************************
        * 메뉴 트리 클릭 이벤트
        **********************************************************************/
        function wtMENU_click(e, s) {
            selectWtMENU = txtMN_MENUID.GetValue();            

            txtChk_MN_MENUID.SetValue("");
            hdnMN_MENUID.SetValue(wtMENU.SelectedItems[0].Values[0]);
            txtMN_MENUID.SetValue(wtMENU.SelectedItems[0].Values[0]);
            txtMN_PROGRAMID.SetValue(wtMENU.SelectedItems[0].Values[1]);
            txtMN_PRTMENU.SetValue(wtMENU.SelectedItems[0].Values[2]);
            rdoMN_DISPLAYYN.SetValue(wtMENU.SelectedItems[0].Values[3]);
            rdoMN_IPYN.SetValue(wtMENU.SelectedItems[0].Values[4]);
            txtMN_MENU_KO.SetValue(wtMENU.SelectedItems[0].Values[5]);
            txtMN_MENU_EN.SetValue(wtMENU.SelectedItems[0].Values[6]);
            txtMN_MENU_ZH.SetValue(wtMENU.SelectedItems[0].Values[7]);
            txtMN_MENU_RU.SetValue(wtMENU.SelectedItems[0].Values[8])
            cboMN_MENUTYPE.SetValue(wtMENU.SelectedItems[0].Values[10]);
            txtMN_SORTNO.SetValue(wtMENU.SelectedItems[0].Values[11]);

            //프로그램 관리 조회
            treePRORAM_Inquery();

            return false;
        }

        /**********************************************************************
        * 메뉴 입력값 초기화 함수
        **********************************************************************/
        function initMenuInputData() {
            txtChk_MN_MENUID.SetValue("");
            hdnMN_MENUID.SetValue(""); //메뉴아이디
            txtMN_MENUID.SetValue("");//메뉴아이디
            txtMN_PROGRAMID.SetValue(""); //프로그램아이디
            txtMN_PRTMENU.SetValue(""); //상위메뉴아이디
            cboMN_MENUTYPE.SetValue(""); //메뉴목록
            txtMN_SORTNO.SetValue(""); //정렬순서
            rdoMN_IPYN.SetValue(""); //접속허용여부
            rdoMN_DISPLAYYN.SetValue(""); //DISPLAY YN
            txtMN_MENU_KO.SetValue(""); //KO
            txtMN_MENU_EN.SetValue(""); //EN
            txtMN_MENU_ZH.SetValue(""); //ZH
            txtMN_MENU_RU.SetValue(""); //RU

            return false;
        }

        /**********************************************************************
        * 메뉴 아이디 중복 체크
        **********************************************************************/
        function chkDupMENUID(chk_div) {
            if (chk_div == "M") {
                if (hdnMN_MENUID.GetValue() == txtMN_MENUID.GetValue()) {
                    txtChk_MN_MENUID.SetValue("");
                    return false;
                }
            } else if (chk_div == "P") {
                if (hdnPRM_PROGRAMID.GetValue() == txtPRM_PROGRAMID.GetValue()) {
                    txtChk_PRM_PROGRAMID.SetValue("");
                    return false;
                }
            }

            var ht = new Object();
            ht["MENUID"] = txtMN_MENUID.GetValue();
            ht["PROGRAMID"] = txtPRM_PROGRAMID.GetValue();
            ht["CHK_DIV"] = chk_div;

            PageMethods.InvokeServiceTable(ht, "Portal.MenuBiz", "DupMenuProgamID", chkDupMENUID_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 메뉴 아이디 중복 체크 콜백
        **********************************************************************/
        function chkDupMENUID_CallBack(e) {
            var ds = eval(e);

            var chkCount = ds.Tables[0].Rows[0]["CHK_CNT"];
            var chkDiv = ds.Tables[0].Rows[0]["CHK_DIV"];

            if (chkCount > 0) {
                if (chkDiv == "M") {
                    $("#" + txtChk_MN_MENUID.items).css('color', 'red');

                    txtChk_MN_MENUID.SetValue('<Ctl:Text ID="CHK_MENU_MSG01" runat="server" LangCode="CHK_MENU_MSG01" Description="등록 된 메뉴 아이디 입니다." Literal="true" />');
                } else {
                    $("#" + txtChk_PRM_PROGRAMID.items).css('color', 'red');

                    txtChk_PRM_PROGRAMID.SetValue('<Ctl:Text ID="CHK_MENU_MSG02" runat="server" LangCode="CHK_MENU_MSG02" Description="등록 된 프로그램 아이디 입니다." Literal="true" />');
                }
            } else {
                if (chkDiv == "M") {
                    $("#" + txtChk_MN_MENUID.items).css('color', '');

                    txtChk_MN_MENUID.SetValue('<Ctl:Text ID="CHK_MENU_MSG03" runat="server" LangCode="CHK_MENU_MSG03" Description="사용 가능한 메뉴 아이디 입니다." Literal="true" />');
                } else {
                    $("#" + txtChk_PRM_PROGRAMID.items).css('color', '');

                    txtChk_PRM_PROGRAMID.SetValue('<Ctl:Text ID="CHK_MENU_MSG04" runat="server" LangCode="CHK_MENU_MSG04" Description="사용 가능한 프로그램 아이디 입니다." Literal="true" />');
                }
            }

            return false;
        }



        /**********************************************************************
        * 프로그램 신규 버튼 클릭 이벤트
        **********************************************************************/
        function btnPrmNew_Click() {
            initProgramInputData();

            txtPRM_MENUID.SetValue(txtMN_MENUID.GetValue());
            txtPRD_MENUTYPE.SetValue(cboMN_MENUTYPE.GetValue());
            return false;
        }

        /**********************************************************************
        * 프로그램 트리 조회
        **********************************************************************/
        function treePRORAM_Inquery() {
//            selectWtPROGRAM = "";
            selectWtLANG = "";

            //입력 폼 초기화
            initProgramInputData();

            var ht = new Object();
            ht["MENUID"] = txtMN_MENUID.GetValue();

            wtPRORAM.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtPRORAM.BindTree("wtPRORAM");

            return false;
        }

        /**********************************************************************
        * 프로그램 트리 초기값
        **********************************************************************/
        function wtPRORAM_Loaded() {
            wtPRORAM.AllChildClose();
            var itemList = wtPRORAM.Search(selectWtPROGRAM);
            if (itemList.length > 0) {
                itemList[0].Select();
                wtPRORAM_click(0, 0);
            } else {
                treeLANG_Inquery();
            }

            return false;
        }

        /**********************************************************************
        * 프로그램 트리 클릭 이벤트
        **********************************************************************/
        function wtPRORAM_click(e, s) {
            txtChk_PRM_PROGRAMID.SetValue("");
            txtPRM_MENUID.SetValue(wtPRORAM.SelectedItems[0].Values[0]); //메뉴아이디
            hdnPRM_PROGRAMID.SetValue(wtPRORAM.SelectedItems[0].Values[1]); //프로그램아이디
            txtPRM_PROGRAMID.SetValue(wtPRORAM.SelectedItems[0].Values[1]); //프로그램아이디
            txtPRM_PROGRAMPATH.SetValue(wtPRORAM.SelectedItems[0].Values[2]); //경로
            txtPRM_DESCRIPTION.SetValue(wtPRORAM.SelectedItems[0].Values[3]); //설명
            rdoPRM_POPUP.SetValue(wtPRORAM.SelectedItems[0].Values[4]); //팝업여부
            var popup_size = wtPRORAM.SelectedItems[0].Values[5].split(',');
            txtPRM_PopupSize1.SetValue(popup_size[0]); //팝업크기
            txtPRM_PopupSize2.SetValue(popup_size[1]); //팝업크기
            txtPRD_MENUTYPE.SetValue(wtPRORAM.SelectedItems[0].Values[6]);

            treeLANG_Inquery();
            return false;
        }

        /**********************************************************************
        * 프로그램 입력값 초기화 함수
        **********************************************************************/
        function initProgramInputData() {
            txtChk_PRM_PROGRAMID.SetValue("");
            hdnPRM_PROGRAMID.SetValue(""); //프로그램아이디
            txtPRM_PROGRAMID.SetValue(""); //프로그램아이디
            txtPRM_MENUID.SetValue(""); //메뉴아이디
            txtPRM_DESCRIPTION.SetValue(""); //설명
            txtPRM_PROGRAMPATH.SetValue(""); //경로
            rdoPRM_POPUP.SetValue("0");
            txtPRM_PopupSize1.SetValue("");
            txtPRM_PopupSize2.SetValue("");
            txtPRD_MENUTYPE.SetValue("");
            return false;
        }

        /**********************************************************************
        * 프로그램 저장 버튼 클릭 이벤트
        **********************************************************************/
        function btnPrmSave_Click() {
            if (txtPRM_PROGRAMID.GetValue() == "") {
                alert('<Ctl:Text ID="SAVE_PROGRAM_MSG01" runat="server" LangCode="SAVE_PROGRAM_MSG01" Description="프로그램아이디를 입력하십시오." Literal="true" />');
                return false;
            }

            if (!confirm('<Ctl:Text ID="SAVE_PROGRAM_MSG02" runat="server" LangCode="SAVE_PROGRAM_MSG02" Description="입력하신 정보를 저장하시겠습니까?" Literal="true" />')) {
                return false;
            }

            var ht = new Object();
            ht["PROGRAMID"] = txtPRM_PROGRAMID.GetValue();
            ht["MENUID"] = txtPRM_MENUID.GetValue();
            ht["DESCRIPTION"] = txtPRM_DESCRIPTION.GetValue();
            ht["PROGRAMPATH"] = txtPRM_PROGRAMPATH.GetValue();
            ht["POPUP"] = rdoPRM_POPUP.GetValue();
            ht["POPUP_SIZE"] = txtPRM_PopupSize1.GetValue() + "," + txtPRM_PopupSize2.GetValue();
            ht["MENUTYPE"] = cboMN_MENUTYPE.GetValue();

            selectWtPROGRAM = txtPRM_PROGRAMID.GetValue();

            PageMethods.InvokeServiceTable(ht, "Portal.MenuBiz", "AddProgramTree", btnPrmSave_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 프로그램 저장 버튼 클릭 콜백 함수
        **********************************************************************/
        function btnPrmSave_CallBack(e) {
            alert('<Ctl:Text ID="SAVE_PROGRAM_MSG03" runat="server" LangCode="SAVE_PROGRAM_MSG03" Description="입력하신 정보가 저장되었습니다." Literal="true" />');
            treePRORAM_Inquery();
            return false;
        }

        /**********************************************************************
        * 프로그램 삭제 버튼 클릭 이벤트
        **********************************************************************/
        function btnPrmRemove_Click() {
            if (!confirm('<Ctl:Text ID="REMOVE_PROGRAM_MSG01" runat="server" LangCode="REMOVE_PROGRAM_MSG01" Description="선택하신 정보를 삭제하시겠습니까?" Literal="true" />')) {
                return false;
            }

            selectWtPROGRAM = "";

            var ht = new Object();
            ht["MENUID"] = txtPRM_MENUID.GetValue();
            ht["PROGRAMID"] = txtPRM_PROGRAMID.GetValue();

            PageMethods.InvokeServiceTable(ht, "Portal.MenuBiz", "DeleteProgram", btnPrmRemove_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 프로그램 삭제 버튼 클릭 콜백 함수
        **********************************************************************/
        function btnPrmRemove_CallBack(e) {
            alert('<Ctl:Text ID="REMOVE_PROGRAM_MSG02" runat="server" LangCode="REMOVE_PROGRAM_MSG02" Description="선택하신 정보가 삭제되었습니다." Literal="true" />');

            initProgramInputData();
            treePRORAM_Inquery();

            return false;
        }

        /**********************************************************************
        * 프로그램 다국어 일괄생성 클릭 함수
        **********************************************************************/
        function btnPrmBatch_Click() {
            alert("개발 중입니다.");
            return false;
        }










        /**********************************************************************
        * 다국어 신규 버튼 클릭 이벤트
        **********************************************************************/
        function btnLangNew_Click() {
            initLangInputData();

            txtLang_PROGRAMID.SetValue(txtPRM_PROGRAMID.GetValue());
            return false;
        }

        /**********************************************************************
        * 다국어 트리 조회
        **********************************************************************/
        function treeLANG_Inquery() {
//            var selectWtLANG = "";

            //입력 폼 초기화
            initLangInputData();

            var ht = new Object();
            ht["PROGRAMID"] = txtPRM_PROGRAMID.GetValue();

            wtLANG.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtLANG.BindTree("wtLANG");

            return false;
        }

        /**********************************************************************
        * 다국어 트리 초기값
        **********************************************************************/
        function wtLANG_Loaded() {
            wtLANG.AllChildClose();
            var itemList = wtLANG.Search(selectWtLANG);
            if (itemList.length > 0) {
                itemList[0].Select();
                wtLANG_click(0, 0);
            }

            return false;
        }

        /**********************************************************************
        * 다국어 트리 클릭 이벤트
        **********************************************************************/
        function wtLANG_click(e, s) {

            txtLang_PROGRAMID.SetValue(wtLANG.SelectedItems[0].Values[0]); //프로그램아이디
            txtLang_CODE.SetValue(wtLANG.SelectedItems[0].Values[1]); //코드
            txtLang_MENU_KO.SetValue(wtLANG.SelectedItems[0].Values[2]); //KO
            txtLang_MENU_EN.SetValue(wtLANG.SelectedItems[0].Values[3]); //EM
            txtLang_MENU_ZH.SetValue(wtLANG.SelectedItems[0].Values[4]); //ZH
            txtLang_MENU_RU.SetValue(wtLANG.SelectedItems[0].Values[5]); //RU

            return false;
        }

        /**********************************************************************
        * 다국어 입력값 초기화 함수
        **********************************************************************/
        function initLangInputData() {
            txtLang_PROGRAMID.SetValue(""); //프로그램아이디
            txtLang_CODE.SetValue(""); //코드
            txtLang_MENU_KO.SetValue(""); //KO
            txtLang_MENU_EN.SetValue(""); //EM
            txtLang_MENU_ZH.SetValue(""); //ZH
            txtLang_MENU_RU.SetValue(""); //RU

            return false;
        }

        /**********************************************************************
        * 다국어 저장 버튼 클릭 이벤트
        **********************************************************************/
        function btnLangSave_Click() {
            if (txtLang_CODE.GetValue() == "") {
                alert('<Ctl:Text ID="SAVE_LANG_MSG01" runat="server" LangCode="SAVE_LANG_MSG01" Description="코드를 입력하십시오." Literal="true" />');
                return false;
            }

            if (!confirm('<Ctl:Text ID="SAVE_LANG_MSG02" runat="server" LangCode="SAVE_LANG_MSG02" Description="입력하신 정보를 저장하시겠습니까?" Literal="true" />')) {
                return false;
            }

            var ht = new Object();
            ht["PROGRAMID"] = txtLang_PROGRAMID.GetValue();
            ht["CODE"] = txtLang_CODE.GetValue();
            ht["KO"] = txtLang_MENU_KO.GetValue();
            ht["EN"] = txtLang_MENU_EN.GetValue();
            ht["ZH"] = txtLang_MENU_ZH.GetValue();
            ht["RU"] = txtLang_MENU_RU.GetValue();

            selectWtLANG = txtLang_CODE.GetValue();

            PageMethods.InvokeServiceTable(ht, "Portal.MenuBiz", "AddLang", btnLangSave_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 다국어 저장 버튼 클릭 콜백 함수
        **********************************************************************/
        function btnLangSave_CallBack(e) {
            alert('<Ctl:Text ID="SAVE_LANG_MSG03" runat="server" LangCode="SAVE_LANG_MSG03" Description="입력하신 정보가 저장되었습니다." Literal="true" />');
            treeLANG_Inquery();
            return false;
        }

        /**********************************************************************
        * 다국어 삭제 버튼 클릭 이벤트
        **********************************************************************/
        function btnLangRemove_Click() {
            if (!confirm('<Ctl:Text ID="REMOVE_LANG_MSG01" runat="server" LangCode="REMOVE_LANG_MSG01" Description="선택하신 정보를 삭제하시겠습니까?" Literal="true" />')) {
                return false;
            }

            selectWtLANG = "";

            var ht = new Object();
            ht["CODE"] = txtLang_CODE.GetValue();
            ht["PROGRAMID"] = txtLang_PROGRAMID.GetValue();

            PageMethods.InvokeServiceTable(ht, "Portal.MenuBiz", "DeleteLang", btnLangRemove_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 다국어 삭제 버튼 클릭 콜백 함수
        **********************************************************************/
        function btnLangRemove_CallBack(e) {
            alert('<Ctl:Text ID="REMOVE_LANG_MSG02" runat="server" LangCode="REMOVE_LANG_MSG02" Description="선택하신 정보가 삭제되었습니다." Literal="true" />');

            initLangInputData();
            treeLANG_Inquery();

            return false;
        }

        /**********************************************************************
        * 다국어 생성 버튼 함수
        **********************************************************************/
        function btnLang_Click() {
            if (!confirm('<Ctl:Text ID="CREATE_LANG_MSG01" runat="server" LangCode="CREATE_LANG_MSG01" Description="선택하신 프로그램의 다국어 정보를 생성하시겠습니까?" Literal="true" />')) {
                return false;
            }

            var url = txtPRM_PROGRAMPATH.GetValue();
            if (url.indexOf("ShowPopup") > -1){
                url = url.split(",")[0].replace("ShowPopup(", "").replace(/"/gi, "");
            }

            if (url.indexOf("?") > -1){
                url += "&makeLang=1";
            }else{
                url += "?makeLang=1";
            }


            $('#IFRM_LANG').attr('src', url);

            

            return false;
        }

        $(document).ready(function () {
            $('#IFRM_LANG').load(function () {
                alert('<Ctl:Text ID="CREATE_LANG_MSG02" runat="server" LangCode="CREATE_LANG_MSG02" Description="다국어 생성을 완료 하였습니다." Literal="true" />');
                treeLANG_Inquery();
            });
        });

        /**********************************************************************
        * 다국어 엑셀 다운로드 버튼 함수
        **********************************************************************/
        function btnLangExcelDown_Click(){
            var programid = txtPRM_PROGRAMID.GetValue();
            if(programid.length>0){
                location.href = "MenuLangCodeExcelDown.aspx?ProgramID=" + programid;
            }

            return false;
        }

        /**********************************************************************
        * 다국어 엑셀 업로드 버튼 함수
        **********************************************************************/
        function btnLangExcelUp_Click() {
            ShowPopup("MenuLangCodeExcelUpload.aspx", "_blank", 800, 800);
            return false;
        }

        //미사용 취소선 스타일 
        function setTreeValue(obj) {
            if (obj.Items.length > 0) {
                for (var i = 0; i < obj.Items.length; i++) {
                    if (obj.Items[i].Values[14] == "N") {
                        $(obj.Items[i].TextNode).css("text-decoration", "line-through")
                    }

                    setTreeValue(obj.Items[i]);
                }
            }
        }


        function rdoPRM_POPUP_Changed() {
//            var isPopup = rdoPRM_POPUP.GetValue();
//            alert(isPopup);
//            if (isPopup) {
//                alert("dd");
//            }
        }

        function btnMenuACL_Click() {
            var menuid = txtMN_MENUID.GetValue();
            if (menuid.trim() == "") {
                alert("메뉴를 선택하세요");
            }
            else {
                fn_OpenPop("/Portal/Admin/Cmn/AM102021P.aspx?p=" + txtMN_MENUID.GetValue(), 1200, 700);
            }
        }

    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    
    <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT_TITLE_01" runat="server" LangCode="TXT_TITLE_01" Description="<h4>메뉴관리</h4>"></Ctl:Text>
        </h4>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <table class="table_01" style="width: 100%;border-bottom:1px">
                <colgroup>
                    <col width="30%" />
                    <col width="30%" />
                    <col width="40%" />
                </colgroup>
                <tr style="vertical-align:top;" >

                    <!-- 메뉴 관리-->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer_Menu" runat="server" Title="메뉴목록" DefaultHide="False" Collapsible = "False">
                             <ul class="search" style="border-bottom:0px;">
                                <li><Ctl:Text ID="TXT_cboMenuList" runat="server" LangCode="TXT_cboMenuList" Description="메뉴목록"></Ctl:Text></li>
                                <li><Ctl:Combo ID="cboMenuList" runat="server" OnChange= "treeMeNu_Inquery()" Width="70" /></li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnMenuRemove" runat="server" LangCode="btnMenuRemove" Description="삭제" OnClientClick="btnMenuRemove_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnMenuSave" runat="server" LangCode="btnMenuSave" Description="저장" OnClientClick="btnMenuSave_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnMenuNew" runat="server" LangCode="btnMenuNew" Description="신규" OnClientClick="btnMenuNew_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnMenuACL" runat="server" LangCode="btnMenuACL" Description="권한처리" OnClientClick="btnMenuACL_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                            </ul>
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                                <tr style="vertical-align:top;" >
                                    <td colspan = "2" style = "height:200px;">
                                        <Ctl:WebTree ID="wtMENU" runat="server" Width = "100%" Height="200" OnClick="wtMENU_click" EnableSearchBox="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtMN_MENUID" runat="server" LangCode="TXT_txtMN_MENUID" Description="메뉴아이디" /></th>
                                    <td>
                                        <Ctl:TextBox ID="txtMN_MENUID" runat="server" Onchange= "chkDupMENUID('M')"/>
                                        <Ctl:TextBox ID = "hdnMN_MENUID" runat = "server" Hidden ="True" />
                                        <Ctl:Text ID="txtChk_MN_MENUID" runat="server" LangCode="txtChk_MN_MENUID" Description="" style = "color: Red;" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtMN_PROGRAMID" runat="server" LangCode="TXT_txtMN_PROGRAMID" Description="프로그램아이디" /></th>
                                    <td><Ctl:TextBox ID="txtMN_PROGRAMID" runat="server" /></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtMN_PRTMENU" runat="server" LangCode="TXT_txtMN_PRTMENU" Description="상위메뉴아이디" /></th>
                                    <td><Ctl:TextBox ID="txtMN_PRTMENU" runat="server" /></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_cboMN_MENUTYPE" runat="server" LangCode="TXT_cboMN_MENUTYPE" Description="메뉴 목록" /></th>
                                    <td>
                                        <Ctl:Combo ID="cboMN_MENUTYPE" runat="server" RepeatColumns="2" Width="75px">
                                            <asp:ListItem Selected="True" Text="포탈" Value="GP" LangCode="tGP" Description="포탈"></asp:ListItem>
                                        </Ctl:Combo>
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtMN_SORTNO" runat="server" LangCode="TXT_txtMN_SORTNO" Description="정렬순서" /></th>
                                    <td><Ctl:TextBox ID="txtMN_SORTNO" runat="server" SetType="Number" /></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_rdoMN_IPYN" runat="server" LangCode="TXT_rdoMN_IPYN" Description="접속허용여부" /></th>
                                    <td>
                                        <Ctl:Radio ID="rdoMN_IPYN" runat="server" RepeatColumns="2">
                                            <asp:ListItem Value="Y" Text="예"></asp:ListItem>
                                            <asp:ListItem Value="N" Text="아니요"></asp:ListItem>
                                        </Ctl:Radio>
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_rdoMN_DISPLAYYN" runat="server" LangCode="TXT_rdoMN_DISPLAYYN" Description="DISPLAY 여부" /></th>
                                    <td>
                                        <Ctl:Radio ID="rdoMN_DISPLAYYN" runat="server" RepeatColumns="2" >
                                            <asp:ListItem Value="Y" Text="예"></asp:ListItem>
                                            <asp:ListItem Value="N" Text="아니요"></asp:ListItem>
                                        </Ctl:Radio>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="TXT_txtMN_MENU_KO" runat="server" LangCode="TXT_txtMN_MENU_KO" Description="KO" />
                                        <img src="/Resources/Images/Flag/ko.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtMN_MENU_KO" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="TXT_txtMN_MENU_EN" runat="server" LangCode="TXT_txtMN_MENU_EN" Description="EN" />
                                        <img src="/Resources/Images/Flag/en.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtMN_MENU_EN" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr style="display:none;">
                                    <th>
                                        <Ctl:Text ID="TXT_txtMN_MENU_ZH" runat="server" LangCode="TXT_txtMN_MENU_ZH" Description="ZH" />
                                        <img src="/Resources/Images/Flag/cn.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtMN_MENU_ZH" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr style="display:none;">
                                    <th>
                                        <Ctl:Text ID="TXT_txtMN_MENU_RU" runat="server" LangCode="TXT_txtMN_MENU_RU" Description="RU" />
                                        <img src="/Resources/Images/Flag/ru.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtMN_MENU_RU" runat="server" Width ="100%" /></td>
                                </tr>
                            </table>
                        </Ctl:Layer>
                    </td>

                    <!-- 프로그램 관리 -->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer_Program" runat="server" Title="프로그램 관리" DefaultHide="False" Collapsible = "False">
                             <ul class="search" style="border-bottom:0px;">
                                <li style="float:right;">
                                    <Ctl:Button ID="btnPrmRemove" runat="server" LangCode="btnPrmRemove" Description="삭제" OnClientClick="btnPrmRemove_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnPrmSave" runat="server" LangCode="btnPrmSave" Description="저장" OnClientClick="btnPrmSave_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnPrmNew" runat="server" LangCode="btnPrmNew" Description="신규" OnClientClick="btnPrmNew_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                            </ul>
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                                <tr style="vertical-align:top;" >
                                    <td colspan = "2" style = "height:200px;">
                                        <Ctl:WebTree ID="wtPRORAM" runat="server" Width = "100%" Height="200" OnClick="wtPRORAM_click" EnableSearchBox="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtPRM_PROGRAMID" runat="server" LangCode="TXT_txtPRM_PROGRAMID" Description="프로그램아이디" /></th>
                                    <td>
                                        <Ctl:TextBox ID="txtPRM_PROGRAMID" runat="server" Onchange= "chkDupMENUID('P')" />
                                        <Ctl:TextBox ID="hdnPRM_PROGRAMID" runat="server" Hidden = "true" />
                                        
                                        <Ctl:Text ID="txtChk_PRM_PROGRAMID" runat="server" LangCode="txtChk_PRM_PROGRAMID" Description="" style = "color: Red;" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtPRM_MENUID" runat="server" LangCode="TXT_txtPRM_MENUID" Description="메뉴아이디" /></th>
                                    <td><Ctl:TextBox ID="txtPRM_MENUID" runat="server" ReadOnly = "true" /></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtPRM_DESCRIPTION" runat="server" LangCode="TXT_txtPRM_DESCRIPTION" Description="설명" /></th>
                                    <td><Ctl:TextBox ID="txtPRM_DESCRIPTION" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtPRM_PROGRAMPATH" runat="server" LangCode="TXT_txtPRM_PROGRAMPATH" Description="경로" /></th>
                                    <td><Ctl:TextBox ID="txtPRM_PROGRAMPATH" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtPRD_MENUTYPE" runat="server" LangCode="TXT_txtPRD_MENUTYPE" Description="메뉴 목록" /></th>
                                    <td><Ctl:Text ID="txtPRD_MENUTYPE" runat="server"></Ctl:Text></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtPRM_POPUP" runat="server" LangCode="TXT_txtPRM_POPUP" Description="팝업여부" /></th>
                                    <td>
                                        <Ctl:Radio ID="rdoPRM_POPUP" runat="server" onchange="rdoPRM_POPUP_Changed();">
                                            <asp:ListItem Value="1" Description="예"></asp:ListItem>
                                            <asp:ListItem Value="0" Description="아니오" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="E" Description="ERP"></asp:ListItem>
                                        </Ctl:Radio>
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtPRM_POPUPSIZE" runat="server" LangCode="TXT_txtPRM_POPUPSIZE" Description="팝업크기" /></th>
                                    <td>
                                        <Ctl:TextBox ID="txtPRM_PopupSize1" runat="server" Width ="40px" SetType="Number" />px ,
                                        <Ctl:TextBox ID="txtPRM_PopupSize2" runat="server" Width ="40px" SetType="Number" />px
                                    </td>
                                </tr>
                            </table>
                        </Ctl:Layer>
                    </td>

                    <!-- 다국어 -->
                    <td>
                        <Ctl:Layer ID="layer_Lang" runat="server" Title="다국어" DefaultHide="False" Collapsible = "False">
                             <ul class="search" style="border-bottom:0px;">
                                <li style="float:right;">
                                    <Ctl:Button ID="btnLangExcelUp" runat="server" LangCode="btnLangExcelUp" Description="엑셀업로드" OnClientClick="btnLangExcelUp_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnLangExcelDown" runat="server" LangCode="btnLangExcelDown" Description="엑셀다운로드" OnClientClick="btnLangExcelDown_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnLangRemove" runat="server" LangCode="btnLangRemove" Description="삭제" OnClientClick="btnLangRemove_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnLangSave" runat="server" LangCode="btnLangSave" Description="저장" OnClientClick="btnLangSave_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnLangNew" runat="server" LangCode="btnLangNew" Description="신규" OnClientClick="btnLangNew_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                                <li style="float:right;">
                                    <Ctl:Button ID="btnLang" runat="server" LangCode="btnLang" Description="다국어" OnClientClick="btnLang_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                            </ul>
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                                <tr style="vertical-align:top;" >
                                    <td colspan = "2" style = "height:200px;">
                                        <Ctl:WebTree ID="wtLANG" runat="server" Height="200" Width = "100%" OnClick="wtLANG_click" EnableSearchBox="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtLang_PROGRAMID" runat="server" LangCode="TXT_txtLang_PROGRAMID" Description="프로그램아이디" /></th>
                                    <td><Ctl:TextBox ID="txtLang_PROGRAMID" runat="server" ReadOnly = "true"  /></td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="TXT_txtLang_CODE" runat="server" LangCode="TXT_txtLang_CODE" Description="코드" /></th>
                                    <td><Ctl:TextBox ID="txtLang_CODE" runat="server" /></td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="TXT_txtLang_MENU_KO" runat="server" LangCode="TXT_txtLang_MENU_KO" Description="KO" />
                                        <img src="/Resources/Images/Flag/ko.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtLang_MENU_KO" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="TXT_txtLang_MENU_EN" runat="server" LangCode="TXT_txtLang_MENU_EN" Description="EN" />
                                        <img src="/Resources/Images/Flag/en.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtLang_MENU_EN" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr style="display:none;">
                                    <th>
                                        <Ctl:Text ID="TXT_txtLang_MENU_ZH" runat="server" LangCode="TXT_txtLang_MENU_ZH" Description="ZH" />
                                        <img src="/Resources/Images/Flag/cn.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtLang_MENU_ZH" runat="server" Width ="100%" /></td>
                                </tr>
                                <tr style="display:none;">
                                    <th>
                                        <Ctl:Text ID="TXT_txtLang_MENU_RU" runat="server" LangCode="TXT_txtLang_MENU_RU" Description="RU" />
                                        <img src="/Resources/Images/Flag/ru.png" alt="" title="" />
                                    </th>
                                    <td><Ctl:TextBox ID="txtLang_MENU_RU" runat="server" Width ="100%" /></td>
                                </tr>
                            </table>
                        </Ctl:Layer>
                    </td>
                
                </tr>
        </table>

        <!-- 다국어 생성 -->
        <iframe id ="IFRM_LANG" name = "IFRM_LANG" style ="display : none;" ></iframe>
    </div>
</asp:content>
