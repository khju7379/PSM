<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1040.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1040" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var _TCNUM = "";
        var DataGubn = "";

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            // PageLoad시 이벤트 정의부분
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            DataGubn = "A";
            btnDel.Hide();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["TCNUM"] = _TCNUM;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1040", "UP_TKCHANGE_FACTOR_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtTCNUM.SetValue(DataSet.Tables[0].Rows[0]["TCNUM"]);
                    txtTCCHFANAME.SetValue(DataSet.Tables[0].Rows[0]["TCCHFANAME"]);
                    cboTCATTACH.SetValue(DataSet.Tables[0].Rows[0]["TCATTACH"]);
                    txtTCNUM.SetDisabled(true);
                    //txtTCCHFANAME.SetDisabled(true);
                    var DataGubn = "";

                    btnDel.Show();
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click() {
            txtTCNUM.SetValue("");
            txtTCCHFANAME.SetValue("");
            cboTCATTACH.SetValue("N");
            txtTCNUM.SetDisabled(false);
            //txtTCCHFANAME.SetDisabled(false);

            DataGubn = "A";

            btnDel.Hide();
        }

        // 저장 체크
        function UP_FieldCheck() {

            if (txtTCNUM.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="번호를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtTCCHFANAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="항목명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboTCATTACH.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="첨부유무를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (DataGubn == "A") {
                ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["TCNUM"] = txtTCNUM.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1040", "UP_TKCHANGE_FACTOR_SAVECHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        alert('<Ctl:Text runat="server" Description="동일한 번호가 등록되어 있습니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        UP_Save();
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                    return false;
                });
            }
            else {
                UP_Save();
            }
        }

        function UP_Save() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            var WKGUBUN;
            if (DataGubn == "A") {
                WKGUBUN = "A";
            }
            else {
                WKGUBUN = "C";
            }

            ht["WKGUBUN"] = WKGUBUN;
            ht["TCNUM"] = txtTCNUM.GetValue();
            ht["TCCHFANAME"] = txtTCCHFANAME.GetValue();
            ht["TCATTACH"] = cboTCATTACH.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1040", "UP_TKCHANGE_FACTOR_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            DataGubn = "";
                            _TCNUM = txtTCNUM.GetValue();

                            UP_DataBind_Run();
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 저장 버튼
        function btnSave_Click() {

            UP_FieldCheck();
        }

        // 삭제 버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["TCNUM"] = txtTCNUM.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1040", "UP_TKCHANGE_FACTOR_DEL", function (e) {
    
                    btnNew_Click();
                    btnSearch_Click();

                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {
            var rw = gridIndex.GetRow(r);

            DataGubn = "";
            _TCNUM = rw["TCNUM"];

            UP_DataBind_Run();
        
        }
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="Tank저장물질 요소관리" DefaultHide="False">
        <table style="width: 100%;">
                <colgroup>
                    <col width="50%" />
                    <col width="50%" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <div class="btn_bx">
                            <table class="table_01" style="width: 100%;">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:right";>
                                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                         <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1040" MethodName="UP_GET_TKCHANGE_FACTOR_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            <Ctl:SheetField DataField="TCNUM" TextField="TCNUM" Description="번호" Width="60"  HAlign="center" Align="center" runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="TCCHFANAME" TextField="TCCHFANAME" Description="항목명" Width="*" HAlign="center" Align="left" runat="server" OnClick="gridClick" />                            
                             <Ctl:SheetField DataField="TCATTACH" TextField="TCATTACH" Description="첨부유무" Width="100" HAlign="center" Align="center" runat="server" OnClick="gridClick" />   
                        </Ctl:WebSheet>
                    </td>
                    <td valign="top">
                        <div class="btn_bx">
                            <table class="table_01" style="width: 100%;">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:right";>
                                        <Ctl:Button ID="btnNew" runat="server" LangCode="btnRowAdd" Description="신규" OnClientClick="btnNew_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnDel" runat="server" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table class="table_01" style="width: 100%;margin:5px;" border="0" ">
                            <colgroup>
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lslTCNUM" runat="server" LangCode="lslTCNUM" Description="번호" Required = "true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtTCNUM" Width="60px" runat="server" LangCode="txtTCNUM" Description="번호" MaxLength="2"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblTCCHFANAME" runat="server" LangCode="lblTCCHFANAME" Description="항목명" Required = "true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtTCCHFANAME" Width="450px" runat="server" LangCode="txtTCCHFANAME" Description="항목명"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblTCATTACH" runat="server" LangCode="lblTCATTACH" Description="첨부유무" Required = "true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:Combo ID="cboTCATTACH" Width="60px" runat="server" >
                                        <asp:ListItem Text="Y" Value="Y"></asp:ListItem>
                                        <asp:ListItem Selected="True" Text="N" Value="N"></asp:ListItem>
                                    </Ctl:Combo>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
