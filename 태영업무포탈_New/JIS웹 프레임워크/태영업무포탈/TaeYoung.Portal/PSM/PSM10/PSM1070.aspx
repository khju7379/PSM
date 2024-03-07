<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1070.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1070" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var DataGubn = "";
        var _CheckNode = "";

        function OnLoad() {

            btnDCNew.Hide();
            btnPrt.Hide();
        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            wtChecklist.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtChecklist.BindTree('wtChecklist'); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click() {

            var CODE = "";

            fn_OpenPopCustom("PSM1071.aspx?CODE=" + CODE, 650, 300, CODE);
        }

        // 수정버튼
        function btnEdit_Click() {

            var CODE = _CheckNode;

            if (CODE == "") {

                alert('<Ctl:Text runat="server" Description="선택된 항목이 없습니다." Literal="true"></Ctl:Text>');
                return false;
            }
            else { 

                CODE = CODE.replace(/_/gi, '^');

                fn_OpenPopCustom("PSM1071.aspx?CODE=" + CODE, 650, 300, CODE);
            }
        }

        function btnPrt_Click() {
            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM1070_RPT&CISBCODE=" + txtCISBCODE.GetValue() + "&CIGRCODE=" + txtCIGRCODE.GetValue() + "&CIGRSEQ=" + txtRSEQ.GetValue() + "&GUBUN=", 1000, 600);
        }

        // 항목등록 버튼
        function btnDCNew_Click() {

            var CODE = txtCISBCODE.GetValue() + "^" + txtCISBCODENM.GetValue() + "^" + txtCIGRCODE.GetValue() + "^" + txtCIGRCODENM.GetValue() + "^" + txtRSEQ.GetValue() + "^" + txtITEMNUM.GetValue();

            fn_OpenPopCustom("PSM1072.aspx?CODE=" + CODE, 1000, 680, CODE);
        }

        // 등록 팝업 콜백
        function checklist_popup_callback() {

            var ht = new Object();
            ht["P_MENU_NAME"] = txtCISBCODE.GetValue() + "_" + txtCIGRCODE.GetValue() + "_" + txtRSEQ.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // checklist 메뉴 선택 이벤트
        function wtChecklist_click(o, s) {
            var ht = new Object();

            if (s.Item.Values[0] == "3")
            {
                ht["P_MENU_NAME"] = s.Item.Name;

                _CheckNode = s.Item.Name;

                gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩


                PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_MENU_RUN", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        txtCISBCODE.SetValue(DataSet.Tables[0].Rows[0]["CMSBCODE"]);
                        txtCISBCODENM.SetValue(DataSet.Tables[0].Rows[0]["CMSBCODENM"]);
                        txtCIGRCODE.SetValue(DataSet.Tables[0].Rows[0]["CMGRCODE"]);
                        txtCIGRCODENM.SetValue(DataSet.Tables[0].Rows[0]["CMGRCODE"] + "-" + DataSet.Tables[0].Rows[0]["CDDESC1"]);
                        txtRSEQ.SetValue(DataSet.Tables[0].Rows[0]["CMGRSEQ"]);
                        txtITEMNUM.SetValue(DataSet.Tables[0].Rows[0]["CMMCNUM"]);
                        txtNAME.SetValue(DataSet.Tables[0].Rows[0]["KBHANGL"]);
                        txtHIDAT.SetValue(DataSet.Tables[0].Rows[0]["CMWRDATE"]);

                        btnDCNew.Show();
                        btnPrt.Show();
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                });

                var treeNode = $("#wtChecklist").find("#undefined_Items");

                // 하위 노드 검색 체크 해제
                $(treeNode).children("div").each(function () {

                    NodeCheckClear(this);
                });

                // 현재 선택 노드
                var result_node = wtChecklist.FindItem(s.Item.Name); // 선택할 Node의 IDX값

                // 해당 컨트롤의 Node 체크
                result_node.SelNode.checked = true; //선택한 Node 체크
                this.TreeView.SelectItem(result_node); //선택한 Node 선택
            }

            
        }

        // 체크박스 초기화
        function NodeCheckClear(node) {

            if ($(node).children("div").eq(1).children("div").length > 0) {

                $(node).children("div").eq(1).children("div").each(function () {
                    NodeCheckClear(this); // 재귀
                });

            }
            else {

                var val = $(node).children("div").eq(0).attr("id");
                var result_node = wtChecklist.FindItem(val); // 선택할 Node의 IDX값

                // 해당 컨트롤의 Node 체크
                result_node.SelNode.checked = false; //선택한 Node 체크
                node.TreeView.SelectItem(result_node); //선택한 Node 선택
            }
        }

        // 트리 체크박스 표시
        function wtChecklist_Loaded() {
            wtChecklist.AllChildClose();

            wtChecklist.Sort = function () { }

            // 최종 노드의 체크박스를 제외한 체크박스를 모두 숨기기 예제
            $("#wtChecklist input[type=checkbox]").hide();

            // 구조 문제로 인하여 
            var treeNode = $("#wtChecklist").find("#undefined_Items");

            //// 하위 노드 검색
            $(treeNode).children("div").each(function () {
                
                FindLastNode(this);
            });
        }

        // 노드에서 마지막 노드일시 체크박스 활성화
        function FindLastNode(node) {

            if ($(node).children("div").eq(1).children("div").length > 0) {

                $(node).children("div").eq(1).children("div").each(function () {
                    FindLastNode(this); // 재귀
                });

            }
            else {
                
                $(node).children("div").eq(0).find("input[type=checkbox]").show();
            }
        }

        

        // 그리드 선택 이벤트
        function gridClickDCode(r, c) {

            var ht = new Object();
            var rw = gridIndex.GetRow(r);

            var CODE = txtCISBCODE.GetValue() + "^" + txtCISBCODENM.GetValue() + "^" + txtCIGRCODE.GetValue() + "^" + txtCIGRCODENM.GetValue() + "^" + txtRSEQ.GetValue() + "^" + txtITEMNUM.GetValue();

            CODE += "^" + rw["CIITEMNUM"];
            
            fn_OpenPopCustom("PSM1072.aspx?CODE=" + CODE, 1000, 680, CODE);
        }

        function gridClickResult(r, c) {

            var ht = new Object();
            var rw = gridIndex.GetRow(r);

            var CODE = txtCISBCODE.GetValue() + "^" + txtCISBCODENM.GetValue() + "^" + txtCIGRCODE.GetValue() + "^" + txtCIGRCODENM.GetValue() + "^" + txtRSEQ.GetValue() + "^" + txtITEMNUM.GetValue();

            CODE += "^" + rw["CIITEMNUM"] + "^" + rw["CIEVAITEM"] + "^" + rw["CIEVASTD"] + "^" + rw["CSTSEQ"];

            fn_OpenPopCustom("PSM1072.aspx?CODE=" + CODE, 1000, 680, CODE);
        }
        

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="Hazop분석관리" DefaultHide="False">
        <table style="width: 100%;">
                <colgroup>
                    <col width="250px" />
                    <col width="*" />
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
                                        <Ctl:Button ID="btnEdit" runat="server" LangCode="btnEdit" Description="수정" OnClientClick="btnEdit_Click();"></Ctl:Button>
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
                                        <div style="height:700px;width:220px; overflow-y:auto; overflow-x:auto;" >
                                            <Ctl:WebTree ID="wtChecklist" runat="server" CheckBox="true" Description="CHECKLIST" HideTitle="false" IndexBindFiledName="MENU_NO" 
                                                TypeName="PSM.PSM1070" MethodName="UP_GET_CHECKLIST_MENU_LIST" ParentBindFieldName="UP_MENU_NO" TextBindFieldName="MENU_NAME"  
                                                Width="100%" OnClick="wtChecklist_click" OnLoaded="wtChecklist_Loaded" />
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
                                    <col width="60px" />
                                    <col width="80px" />
                                    <col width="60px" />
                                    <col width="200px" />
                                    <col width="60px" />
                                    <col width="60px" />
                                    <col width="60px" />
                                    <col width="60px" />
                                    <col width="*" />
                                </colgroup>
                                <tr >
                                    <td style="text-align:left">
                                        <Ctl:Text ID="lblCISBCODE" runat="server" LangCode="lblCISBCODE" Description="사업부:" ></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="txtCISBCODE" runat="server" LangCode="txtCISBCODE" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                        <Ctl:Text ID="txtCISBCODENM" runat="server" LangCode="txtCISBCODENM" Description="" ForeColor="Blue"></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="lblCIGRCODE" runat="server" LangCode="lblCIGRCODE" Description="그룹:" ></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="txtCIGRCODE" runat="server" LangCode="txtCIGRCODE" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                        <Ctl:Text ID="txtCIGRCODENM" runat="server" LangCode="txtCIGRCODENM" Description="" ForeColor="Blue"></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="lblRSEQ" runat="server" LangCode="lblRSEQ" Description="그룹순번:" ></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="txtRSEQ" runat="server" LangCode="txtRSEQ" Description="" ForeColor="Blue"></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="lblITEMNUM" runat="server" LangCode="lblITEMNUM" Description="장치번호:" ></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="txtITEMNUM" runat="server" LangCode="txtITEMNUM" Description="" ForeColor="Blue"></Ctl:Text>
                                    </td>
                                    <td  ></td>
                                </tr>
                                <tr>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="lblNAME" runat="server" LangCode="lblNAME" Description="작성자:" ></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="txtNAME" runat="server" LangCode="txtNAME" Description="" ForeColor="Blue"></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="lblHIDAT" runat="server" LangCode="lblHIDAT" Description="작성일자" ></Ctl:Text>
                                    </td>
                                    <td style="text-align:left">
                                        <Ctl:Text ID="txtHIDAT" runat="server" LangCode="txtHIDAT" Description="" ForeColor="Blue"></Ctl:Text>
                                    </td>
                                    <td colspan="5'" style="text-align:right">
                                        <Ctl:Button ID="btnDCNew" runat="server" LangCode="btnDCNew" Description="항목등록" OnClientClick="btnDCNew_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnPrt" runat="server" LangCode="btnPrt" Description="출력" OnClientClick="btnPrt_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" Height="670" HFixation="true" TypeName="PSM.PSM1070" MethodName="UP_GET_CHECKLIST_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                                <Ctl:SheetField DataField="CISBCODE" TextField="CISBCODE" Description="" Width="0"  HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                                <Ctl:SheetField DataField="CIGRCODE" TextField="CIGRCODE" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>                            
                                <Ctl:SheetField DataField="CIGRSEQ" TextField="CIGRSEQ" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CIITEMNUM" TextField="CIITEMNUM" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                                <Ctl:SheetField DataField="CIEVAITEM" TextField="CIEVAITEM" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CIEVASTD" TextField="CIEVASTD" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CIWRSABUN" TextField="CIWRSABUN" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CIWRDATE" TextField="CIWRDATE" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CIHIGB" TextField="CIHIGB" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CIITEMNUM2" TextField="CIITEMNUM2" Description="순번" Width="50" HAlign="center" Align="left" runat="server" OnClick="gridClickDCode" />   
                                <Ctl:SheetField DataField="CIEVAITEM2" TextField="CIEVAITEM2" Description="평가항목" Width="30%" HAlign="center" Align="left" runat="server" OnClick="gridClickDCode" />   
                                <Ctl:SheetField DataField="CIEVASTD2" TextField="CIEVASTD2" Description="평가기준" Width="30%" HAlign="center" Align="left" runat="server" OnClick="gridClickDCode" />   
                                <Ctl:SheetField DataField="CSTGRCODE" TextField="CSTGRCODE" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CSTGRSEQ" TextField="CSTGRSEQ" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CSTITEMNUM" TextField="CSTITEMNUM" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CSTSEQ" TextField="CSTSEQ" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="CSTACTDESC" TextField="CSTACTDESC" Description="안전조치" Width="20%" HAlign="center" Align="left" runat="server" OnClick="gridClickResult" />   
                                <Ctl:SheetField DataField="CSTADVDESC" TextField="CSTADVDESC" Description="개선권고" Width="20%" HAlign="center" Align="left" runat="server" OnClick="gridClickResult" />   
                                <Ctl:SheetField DataField="CSTWRSABUN" TextField="CSTWRSABUN" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>