<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchsePoPopup.aspx.cs" Inherits="TaeYoung.Portal.PSM.POP.PurchsePoPopup" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        // 페이지 로드
        function OnLoad() {

            var today = new Date();
            var year = "";
            var month ="";

            if (today.getMonth() - 5 == 0) {

                year = CalLpad(today.getFullYear() - 1);
                month = "12";
            }
            else {
                year = today.getFullYear();
                month = today.getMonth() - 5;
            }

            txtSTDATE.SetValue(year + "-" + CalLpad((month)));
            txtEDDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)));
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var SAUP;
            var POMGUBN;

            if (deptcd.substring(0, 2) == "T" || deptcd == "E10100") {
                SAUP = "T,A";
            }
            else if (deptcd.substring(0, 2) == "S" || deptcd == "E10200") {
                SAUP = "S,A";
            }
            else if (deptcd.substring(0, 2) == "D1" || deptcd.substring(0, 1) == "A") {
                if (cboSAUP.GetValue() == "T") {
                    SAUP = "T, D, A";
                }
                else {
                    SAUP = "S, D, A";
                }
            }

            debugger;

            if (cboGUBN.GetValue() == "A") {
                POMGUBN = "Y,N";
            }
            else {
                POMGUBN = this.cboGUBN.Value.ToString();
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SearchCondition"] = 1;
            ht["PageSize"]        = 10;
            ht["P_SAUP"]          = SAUP;
            ht["P_STDATE"]        = txtSTDATE.GetValue();
            ht["P_EDDATE"]        = txtEDDATE.GetValue();
            ht["P_POM1180"]       = txtPOM1180.GetValue();
            ht["P_POMGUBN"]       = POMGUBN;

            //alert(ht["SearchCondition"] + "^" + ht["PageSize"] + "^" + ht["SAUP"] + "^" + ht["LCODE"] + "^" + ht["MCODE"] + "^" + ht["SCODE"] + "^" + ht["SNAME"]);

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {

            if (opener) {
                opener.btnPopup_Callback(gridIndex.GetRow(gridIndex.SelectedRow));
                self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
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
        <Ctl:Layer ID="layer1" runat="server" Title="구매발주조회" DefaultHide="False">
        <!-- 상단의 버튼을 정의 -->
        <div class="btn_bx">
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="100px" />
                    <col width="200px" />
                    <col width="100px" />
                    <col width="350px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="lblSAUP" runat="server" LangCode="lblSAUP" Description="사업부"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboSAUP" Width="60px" runat="server">
                            <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                            <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblData" runat="server" Required="true" LangCode="lblData" Description="일자" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtSTDATE" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar"></Ctl:TextBox> 
                        <Ctl:Text ID="lblsprate2" runat="server" LangCode="seprate" Description="-"></Ctl:Text>
                        <Ctl:TextBox ID="txtEDDATE" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar"></Ctl:TextBox> 
                    </td>
                    <th>
                        <Ctl:Text ID="lblGUBUN" runat="server" LangCode="lblMCODE" Description="마감구분"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboGUBN" Width="200px" runat="server">
                            <asp:ListItem Text="전체"   Value="A" Selected="True" ></asp:ListItem>
                            <asp:ListItem Text="마감"   Value="Y"></asp:ListItem>
                            <asp:ListItem Text="미마감" Value="N"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                </tr>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="lblPOM1180" runat="server" LangCode="lblC3NAME" Description="구매명"></Ctl:Text>
                    </th>
                    <td colspan="4" style="border-right:hidden">
                        <Ctl:TextBox ID="txtPOM1180" Width="500px" runat="server" LangCode="txtPOM1080" Description="구매명"></Ctl:TextBox>
                    </td>
                    <td style="text-align:right;">
                        <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                        <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>     
                    </td>
                    
                </tr>
            </table>
            
        </div>
        <table style="width: 100%;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                       <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSMBiz" MethodName="UP_GET_MRPPOMF_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                           
                           <Ctl:SheetField DataField="POM1000"   TextField="POM1000"  Description="POM1000"  HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="POM1010"   TextField="POM1010"  Description="POM1010"  HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="POM1020"   TextField="POM1020"  Description="POM1020"  HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="POM1030"   TextField="POM1030"  Description="POM1030"  HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="BUNHO"     TextField="발주번호" Description="발주번호" Width="110"     HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                           <Ctl:SheetField DataField="RRM1110"   TextField="RRM1110"  Description="RRM1110"  HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="POM1180"   TextField="구매명"   Description="구매명"   Width="200"     HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                           <Ctl:SheetField DataField="JEPUM1"    TextField="품목코드" Description="품목코드" Width="100"     HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                           <Ctl:SheetField DataField="Z1050131"  TextField="품목명"   Description="품목명"   Width="180"     HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                           <Ctl:SheetField DataField="PON1150"   TextField="PON1150"  Description="PON1150"  HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="PON1170"   TextField="PON1150"  Description="PON1150"  HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="VNSANGHO"  TextField="VNSANGHO" Description="VNSANGHO" HAlign="center" Align="left" runat="server" Hidden ="true" OnClick="gridClick" />
                           <Ctl:SheetField DataField="PON1620"   TextField="자산코드" Description="자산코드" Width="90"      HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                           <Ctl:SheetField DataField="PON1620NM" TextField="자산명"   Description="자산명"   Width="140"     HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
