<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1050.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1050" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var _TCNUM = "";
        var DataGubn = "";
        var selectRiskCode = "";
        var selectRiskMastCode = "";

        function OnLoad() {

            btnDel.Hide();
            btnCopy.Hide();
        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            wtRiskCode.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtRiskCode.BindTree('wtRiskCode'); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click() {

            var CODE = "";

            fn_OpenPopCustom("PSM1051.aspx?CODE=" + CODE, 600, 150, CODE);
        }

        // 복사버튼
        function btnCopy_Click() {

            if (selectRiskCode != "") {

                var CODE = selectRiskCode.replace('_', '^');

                fn_OpenPopCustom("PSM1051.aspx?CODE=" + CODE, 600, 250, CODE);
            }
        }

        // 삭제 체크
        function UP_FieldCheck() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            if (selectRiskCode != "") {

                ht["P_MENU_NAME"] = selectRiskCode;

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_DELCHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        alert('<Ctl:Text runat="server" Description="삭제할 수 없는 자료입니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        //UP_Delete();
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                    return false;
                });
            }
        }

        // 삭제 이벤트
        function UP_Delete() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            if (selectRiskCode != "") {

                ht["P_MENU_NAME"] = selectRiskCode;

                if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_DEL", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                                btnSearch_Click();

                                alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
                            }
                            else {
                                var msg = DataSet.Tables[0].Rows[0]["MSG"];
                                alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
                            }
                        }
                        else {
                            alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }

                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }
            }
        }

        // 삭제 버튼
        function btnDel_Click() {

            alert("1");
            UP_FieldCheck();
        }

        // 대분류등록 버튼
        function btnRMNew_Click() {

            if (selectRiskCode != "") {

                var CODE = selectRiskCode.replace('_', '^');

                fn_OpenPopCustom("PSM1052.aspx?CODE=" + CODE, 800, 150, CODE);
            }
            else {
                alert('<Ctl:Text runat="server" Description="마스타 선택 후 작업하세요." Literal="true"></Ctl:Text>');
            }
        }

        // 항목등록 버튼
        function btnRLNew_Click() {

            if (selectRiskMastCode != "") {
                
                var CODE = selectRiskMastCode.replace('_', '^');
                
                fn_OpenPopCustom("PSM1053.aspx?CODE=" + CODE, 800, 250, CODE);
            }
            else {
                alert('<Ctl:Text runat="server" Description="대분류 선택 후 작업하세요." Literal="true"></Ctl:Text>');
            }
        }

        // 등록 팝업 콜백
        function riskcode_popup_callback(RMYEAR, RMSEQ, RMCODE, RMNAME) {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            if (RMNAME != "") {
                selectRiskMastCode = RMYEAR + "^" + RMSEQ + "^" + RMCODE + "^" + RMNAME;
            }

            ht["P_MENU_NAME"] = RMYEAR + "_" + RMSEQ + "_" + RMCODE;

            gridMaster.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridMaster.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 위험성평가표 메뉴 선택 이벤트
        function wtRiskCode_click(o, s) {
            var ht = new Object();

            selectRiskCode = "";

            if (s.Item.Values[0] == "2") {
                selectRiskCode = s.Item.Text;
                selectRiskMastCode = "";

                ht["P_MENU_NAME"] = s.Item.Text;

                gridMaster.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridMaster.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                if (selectRiskCode != "") {

                    ht["P_MENU_NAME"] = selectRiskCode;

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_DELCHECK", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                            btnDel.Hide();
                        }
                        else {
                            btnDel.Show();
                        }
                    }, function (e) {
                        // Biz 연결오류
                        alert("Error");
                        return false;
                    });
                }
                btnCopy.Show();
            }
            else {
                btnDel.Hide();
                btnCopy.Hide();
            }
        }

        function wtRiskCode_Loaded() {
            wtRiskCode.AllChildClose();
        }

        // 마스타 그리드 선택 이벤트
        function gridMasterClick(r, c) {

            var ht = new Object();
            var rw = gridMaster.GetRow(r);

            selectRiskMastCode = rw["RMYEAR"] + "^" + rw["RMSEQ"] + "^" + rw["RMCODE"] + "^" + rw["RMNAME"];

            ht["P_MENU_NAME"] = rw["RMYEAR"] + "_" + rw["RMSEQ"] + "_" + rw["RMCODE"];

            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        // 마스타 그리드 수정버튼 이벤트
        function gridMasterEditClick(r, c) {

            var ht = new Object();
            var rw = gridMaster.GetRow(r);

            var CODE = rw["RMYEAR"] + "^" + rw["RMSEQ"] + "^" + rw["RMCODE"];

            fn_OpenPopCustom("PSM1052.aspx?CODE=" + CODE, 800, 150, CODE);
        }

        // 디테일 그리드 수정버튼 이벤트
        function gridDetailEditClick(r, c) {

            var ht = new Object();
            var rw = gridDetail.GetRow(r);

            var CODE = rw["RLYEAR"] + "^" + rw["RLSEQ"] + "^" + rw["RLCODE"] + "^" + rw["RLNAME"] + "^" + rw["RLITEMCODE"];

            fn_OpenPopCustom("PSM1053.aspx?CODE=" + CODE, 800, 250, CODE);
        }


    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="위험성평가기준표" DefaultHide="False">
        <table style="width: 100%;">
                <colgroup>
                    <col width="26%" />
                    <col width="74%" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <div class="btn_bx">
                            <table class="table_01" style="width: 100%;">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:right">
                                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnNew" runat="server" LangCode="btnRowAdd" Description="신규" OnClientClick="btnNew_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnDel" runat="server" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnCopy" runat="server" LangCode="btnCopy" Description="복사" OnClientClick="btnCopy_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="btn_bx" style="height:720px; overflow-y:hidden; overflow-x:hidden;">
                            <table class="table_01" style="width:100%;height:100%;margin-top:-5px">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:left;">
                                        <div style="height:700px;width:100%; overflow-y:auto; overflow-x:auto;" >
                                        <Ctl:WebTree ID="wtRiskCode" runat="server" CheckBox="false" Description="위험성평가" HideTitle="false" IndexBindFiledName="MENU_NO" TypeName="PSM.PSM1050" MethodName="UP_GET_RISKCODE_VER_LIST" ParentBindFieldName="UP_MENU_NO" TextBindFieldName="MENU_NAME"  Width="100%" OnClick="wtRiskCode_click" OnLoaded="wtRiskCode_Loaded"/>
                                            </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td valign="top">
                        <div class="btn_bx" >
                            <table class="table_01" style="width: 100%;">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:right">
                                        <Ctl:Button ID="btnRMNew" runat="server" LangCode="btnSave" Description="대분류등록" OnClientClick="btnRMNew_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                            <Ctl:WebSheet ID="gridMaster" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="260" TypeName="PSM.PSM1050" MethodName="UP_GET_RISKCODE_MASTER_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20" >
                                <Ctl:SheetField DataField="RMEDIT" DataType = "Button" TextField=""    Description="" Width="50" HAlign="center" Align="center"  OnClick="gridMasterEditClick"  runat="server" />
                                <Ctl:SheetField DataField="RMYEAR" TextField="RMYEAR" Description="년도" Width="100"  HAlign="center" Align="left" runat="server" OnClick="gridMasterClick" />
                                <Ctl:SheetField DataField="RMSEQ" TextField="RMSEQ" Description="순번" Width="100" HAlign="center" Align="left" runat="server" OnClick="gridMasterClick" />                            
                                <Ctl:SheetField DataField="RMCODE" TextField="RMCODE" Description="대분류코드" Width="100" HAlign="center" Align="left" runat="server" OnClick="gridMasterClick" />   
                                <Ctl:SheetField DataField="RMNAME" TextField="RMNAME" Description="대분류명" Width="*" HAlign="center" Align="left" runat="server" OnClick="gridMasterClick" />   
                            </Ctl:WebSheet>
                        </div>
                        <div class="btn_bx">
                            <table class="table_01" style="width: 100%;">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:right">
                                        <Ctl:Button ID="btnRLNew" runat="server" LangCode="btnSave" Description="항목등록" OnClientClick="btnRLNew_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                            <Ctl:WebSheet ID="gridDetail" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="310" TypeName="PSM.PSM1050" MethodName="UP_GET_RISKCODE_DETAIL_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20" >
                                <Ctl:SheetField DataField="RLEDIT" DataType = "Button" TextField=""    Description="" Width="50" HAlign="center" Align="center"  OnClick="gridDetailEditClick"  runat="server" />
                                <Ctl:SheetField DataField="RLYEAR" TextField="RLYEAR" Description="년도" Width="100"  HAlign="center" Align="left" runat="server" Hidden="true"/>
                                <Ctl:SheetField DataField="RLCODE" TextField="RLCODE" Description="대분류코드" Width="100"  HAlign="center" Align="left" runat="server" />
                                <Ctl:SheetField DataField="RLNAME" TextField="RLNAME" Description="대분류명" Width="*" HAlign="center" Align="left" runat="server" />
                                <Ctl:SheetField DataField="RLITEMCODE" TextField="RLITEMCODE" Description="항목코드" Width="100" HAlign="center" Align="left" runat="server" />
                                <Ctl:SheetField DataField="RLITEMNAME" TextField="RLITEMNAME" Description="항목명" Width="*" HAlign="center" Align="left" runat="server" />
                                <Ctl:SheetField DataField="RLRSINDEX0" TextField="RLRSINDEX0" Description="지수0" Width="*" HAlign="center" Align="left" runat="server" />
                                <Ctl:SheetField DataField="RLRSINDEX1" TextField="RLRSINDEX1" Description="지수1" Width="*" HAlign="center" Align="left" runat="server" />
                                <Ctl:SheetField DataField="RLRSINDEX2" TextField="RLRSINDEX2" Description="지수2" Width="*" HAlign="center" Align="left" runat="server" />
                                <Ctl:SheetField DataField="RLRSINDEX3" TextField="RLRSINDEX3" Description="지수3" Width="*" HAlign="center" Align="left" runat="server" />
                            </Ctl:WebSheet>
                        </div>
                        
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
