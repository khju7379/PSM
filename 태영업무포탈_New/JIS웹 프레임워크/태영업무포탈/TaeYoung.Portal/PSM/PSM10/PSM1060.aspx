<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1060.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1060" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var _TCNUM = "";
        var DataGubn = "";
        var selectRiskCode = "";
        var selectRiskMastCode = "";

        function OnLoad() {
        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            wtHazop.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtHazop.BindTree('wtHazop'); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click() {

            //var CODE = "";

            //fn_OpenPopCustom("PSM1051.aspx?CODE=" + CODE, 600, 150, CODE);
        }

        // 복사버튼
        function btnCopy_Click() {

            //if (selectRiskCode != "") {

            //    var CODE = selectRiskCode.replace('_', '^');

            //    fn_OpenPopCustom("PSM1051.aspx?CODE=" + CODE, 600, 250, CODE);
            //}
        }

        // 삭제 버튼
        function btnDel_Click() {

            //var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            //if (selectRiskCode != "") {

            //    ht["P_MENU_NAME"] = selectRiskCode;

            //    if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

            //        PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_DEL", function (e) {

            //            var DataSet = eval(e);

            //            if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

            //                if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
            //                    btnSearch_Click();

            //                    alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
            //                }
            //                else {
            //                    var msg = DataSet.Tables[0].Rows[0]["MSG"];
            //                    alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
            //                }
            //            }
            //            else {
            //                alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //            }

            //        }, function (e) {
            //            // Biz 연결오류
            //            alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //        });
            //    }
            //}
        }
        

        // 대분류등록 버튼
        function btnRMNew_Click() {

            //if (selectRiskCode != "") {

            //    var CODE = selectRiskCode.replace('_', '^');

            //    fn_OpenPopCustom("PSM1052.aspx?CODE=" + CODE, 800, 150, CODE);
            //}
        }

        // 항목등록 버튼
        function btnRLNew_Click() {

            //if (selectRiskMastCode != "") {
                
            //    var CODE = selectRiskMastCode.replace('_', '^');
                
            //    fn_OpenPopCustom("PSM1053.aspx?CODE=" + CODE, 800, 250, CODE);
            //}
            
        }

        // 등록 팝업 콜백
        function riskcode_popup_callback(RMYEAR, RMSEQ, RMCODE, RMNAME) {

            //var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            //if (RMNAME != "") {
            //    selectRiskMastCode = RMYEAR + "^" + RMSEQ + "^" + RMCODE + "^" + RMNAME;
            //}

            //ht["P_MENU_NAME"] = RMYEAR + "_" + RMSEQ + "_" + RMCODE;

            //gridMaster.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //gridMaster.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            //gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 위험성평가표 메뉴 선택 이벤트
        function wtHazop_click(o, s) {
            //var ht = new Object();

            //selectRiskCode = "";

            //if (s.Item.Values[0] == "2")
            //{
            //    selectRiskCode = s.Item.Text;
            //    selectRiskMastCode = "";
            
            //    ht["P_MENU_NAME"] = s.Item.Text;

            //    gridMaster.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //    gridMaster.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            //    gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //    gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
            //}
        }

        function wtHazop_Loaded() {
            wtHazop.AllChildClose();
        }

        // 마스타 그리드 선택 이벤트
        function gridClick(r, c) {

            //var ht = new Object();
            //var rw = gridMaster.GetRow(r);

            //selectRiskMastCode = rw["RMYEAR"] + "^" + rw["RMSEQ"] + "^" + rw["RMCODE"] + "^" + rw["RMNAME"];

            //ht["P_MENU_NAME"] = rw["RMYEAR"] + "_" + rw["RMSEQ"] + "_" + rw["RMCODE"];

            //gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        // 마스타 그리드 수정버튼 이벤트
        function gridMasterEditClick(r, c) {

            //var ht = new Object();
            //var rw = gridMaster.GetRow(r);

            //var CODE = rw["RMYEAR"] + "^" + rw["RMSEQ"] + "^" + rw["RMCODE"];

            //fn_OpenPopCustom("PSM1052.aspx?CODE=" + CODE, 800, 150, CODE);
        }

        // 디테일 그리드 수정버튼 이벤트
        function gridDetailEditClick(r, c) {

            //var ht = new Object();
            //var rw = gridDetail.GetRow(r);

            //var CODE = rw["RLYEAR"] + "^" + rw["RLSEQ"] + "^" + rw["RLCODE"] + "^" + rw["RLNAME"] + "^" + rw["RLITEMCODE"];

            //fn_OpenPopCustom("PSM1053.aspx?CODE=" + CODE, 800, 250, CODE);
        }

        var winPop;

        function fn_OpenPopCustom(url, w, h, name) {
            if (url == "" || url == null || url == undefined) return;

            w = (w == undefined || w == null) ? 600 : w;
            h = (h == undefined || h == null) ? 400 : h;

            var strLeft = (window.screen.width - w) / 2;
            var strTop = (window.screen.height - h) / 2;

            var feat = "toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=" + w + ",height=" + h + ",top=" + strTop + ",left=" + strLeft;

            if (!winPop || (winPop && winPop.closed)) {
                winPop = window.open(url, name, feat);
            } else {
                winPop.location.href = url;
            }
            winPop.focus();
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="Hazop분석관리" DefaultHide="False">
        <table style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
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
                        <div class="btn_bx" style="height:755px; overflow-y:auto;">
                            <table class="table_01" style="width:100%;height:100%;margin-top:-5px">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:left;">
                                        <Ctl:WebTree ID="wtHazop" runat="server" CheckBox="false" Description="HAZOP분석표" HideTitle="false" IndexBindFiledName="MENU_NO" TypeName="PSM.PSM1060" MethodName="UP_GET_HAZOP_MENU_LIST" ParentBindFieldName="UP_MENU_NO" TextBindFieldName="CODE_NAME"  Width="100%" OnClick="wtHazop_click" OnLoaded="wtHazop_Loaded"/>
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
                            <Ctl:WebSheet ID="gridMaster" runat="server" Paging="false" CheckBox="false" Width="100%" Height="800" HFixation="true" TypeName="PSM.PSM1050" MethodName="UP_GET_RISKCODE_MASTER_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20" >
                                <Ctl:SheetField DataField="PRROWNUM" TextField="RMYEAR" Description="년도" Width="100"  HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                                <Ctl:SheetField DataField="PRHSPLCODE" TextField="RMSEQ" Description="순번" Width="100" HAlign="center" Align="left" runat="server" OnClick="gridClick" />                            
                                <Ctl:SheetField DataField="" TextField="RMCODE" Description="대분류코드" Width="100" HAlign="center" Align="left" runat="server" OnClick="gridClick" />   
                                <Ctl:SheetField DataField="RMNAME" TextField="RMNAME" Description="대분류명" Width="*" HAlign="center" Align="left" runat="server" OnClick="gridClick" />   
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>