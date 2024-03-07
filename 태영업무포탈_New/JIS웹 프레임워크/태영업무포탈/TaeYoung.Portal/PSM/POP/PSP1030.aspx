<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSP1030.aspx.cs" Inherits="TaeYoung.Portal.PSM.POP.PSP1030" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        // 페이지 로드
        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            // PageLoad시 이벤트 정의부분

            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )

            //var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            //ht["CurrentPageIndex"] = 1;
            //ht["PageSize"] = 15;
            //ht["SAUP"] = "T";
            //ht["LCODE"] = "";
            //ht["MCODE"] = "";
            //ht["SCODE"] = "";
            //ht["SNAME"] = "";

            //gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            cboSAUP_Change();
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SearchCondition"] = 1;
            ht["PageSize"] = 10;
            ht["SAUP"] = cboSAUP.GetValue();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["SCODE"] = cboSCODE.GetValue();
            ht["SNAME"] = txtC3NAME.GetValue();

            //alert(ht["SearchCondition"] + "^" + ht["PageSize"] + "^" + ht["SAUP"] + "^" + ht["LCODE"] + "^" + ht["MCODE"] + "^" + ht["SCODE"] + "^" + ht["SNAME"]);

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();
        }

        // 사업부 선택 이벤트
        function cboSAUP_Change() {
            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["GUBUN"] = "S";

            cboBCODE.TypeName = "PSM.PSM1030";
            cboBCODE.MethodName = "UP_GET_BCODE_LIST";
            cboBCODE.DataTextField = "C1CODENAME";
            cboBCODE.DataValueField = "C1CODE";
            cboBCODE.Params(ht);
            cboBCODE.BindList();

            cboBCODE_Change();
            return false;
        }

        // 대분류 선택 이벤트
        function cboBCODE_Change() {
            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["GUBUN"] = "S";

            cboMCODE.TypeName = "PSM.PSM1030";
            cboMCODE.MethodName = "UP_GET_MCODE_LIST";
            cboMCODE.DataTextField = "C2CODENAME";
            cboMCODE.DataValueField = "C2MCODE";
            cboMCODE.Params(ht);
            cboMCODE.BindList();

            cboMCODE_Change();
            return false;
        }

        // 중분류 선택 이벤트
        function cboMCODE_Change() {
            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();

            cboSCODE.TypeName = "PSM.PSM1030";
            cboSCODE.MethodName = "UP_GET_SCODE_LIST";
            cboSCODE.DataTextField = "C3CODENAME";
            cboSCODE.DataValueField = "C3SCODE";
            cboSCODE.Params(ht);
            cboSCODE.BindList();

            return false;
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
        <Ctl:Layer ID="layer1" runat="server" Title="코드관리" DefaultHide="False">
        <!-- 상단의 버튼을 정의 -->
        <div class="btn_bx">
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="60px" />
                    <col width="75px" />
                    <col width="60px" />
                    <col width="115px" />
                    <col width="60px" />
                    <col width="215px" />
                    <col width="60px" />
                    <col width="245px" />
                    <col width="60px" />
                    <col width="250px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="lblSAUP" runat="server" LangCode="lblSAUP" Description="사업부"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboSAUP" Width="60px" runat="server" OnChange= "cboSAUP_Change()" >
                            <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                            <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblBCODE" runat="server" LangCode="lblBCODE" Description="대분류" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboBCODE" Width="100px" runat="server" OnChange= "cboBCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblMCODE" runat="server" LangCode="lblMCODE" Description="중분류"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboMCODE" Width="200px" runat="server"  OnChange= "cboMCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblSCODE" runat="server" LangCode="lblSCODE" Description="설비"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboSCODE" Width="230px" runat="server" RepeatColumns="2" >
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="lblC3NAME" runat="server" LangCode="lblC3NAME" Description="설비명"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtC3NAME" Width="230px" runat="server" LangCode="txtC3NAME" Description="설비명"></Ctl:TextBox>
                    </td>
                    <td colspan="7" style="text-align:right;">
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
                       <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1030" MethodName="UP_GET_ACFIXCLASS3_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="C3SAUP" TextField="사업부" Description="사업부" Width="50"  HAlign="center" Align="left" runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="C3BCODE" TextField="대분류코드" Description="대분류코드" Width="80"  HAlign="center" Align="left" Hidden="true" runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="C3BCODENM" TextField="대분류명" Description="대분류명" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3MCODE" TextField="중분류코드" Description="중분류코드" Width="65" HAlign="center" Align="left" Hidden="true" runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3MCODENM" TextField="중분류명" Description="중분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3SCODE" TextField="설비코드" Description="설비코드" Width="160" HAlign="center" Align="left" Hidden="true" runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3NAME" TextField="설비명" Description="설비명" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />            
                            <Ctl:SheetField DataField="C3LINKCODE1" TextField="연결설비1" Description="연결설비1" Width="70" HAlign="center" Align="left" Hidden="true" runat="server" OnClick="gridClick" />       
                            <Ctl:SheetField DataField="C3LINKCODE1NM" TextField="연결설비명1" Description="연결설비명1" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />       
                            <Ctl:SheetField DataField="C3LINKCODE2" TextField="연결설비2" Description="연결설비2" Width="70" HAlign="center" Align="left" Hidden="true" runat="server" OnClick="gridClick" />       
                            <Ctl:SheetField DataField="C3LINKCODE2NM" TextField="연결설비명2" Description="연결설비명2" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
