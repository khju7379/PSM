<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1030.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1030" %>

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
            //ht["BCODE"] = "";
            //ht["MCODE"] = "";
            //ht["SCODE"] = "";
            //ht["SNAME"] = "";

            //gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            cboSAUP_Change();

            btnSearch_Click();
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SAUP"] = cboSAUP.GetValue();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["SCODE"] = cboSCODE.GetValue();
            ht["SNAME"] = txtC3NAME.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 사업부 선택 이벤트
        function cboSAUP_Change()
        {
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

        // 신규 버튼 이벤트
        function btnNew_Click()
        {
            var CODE = '';

            fn_OpenPopCustom("PSM1031.aspx?CODE=" + CODE, 850, 380, CODE);
        }

        // 중분류 버튼 이벤트
        function btnCLASS2_Click() {
            
            fn_OpenPopCustom("PSM1032.aspx", 1100, 580, '');
        }

        // 대분류 버튼 이벤트
        function btnCLASS1_Click() {

            fn_OpenPopCustom("PSM1033.aspx", 1000, 450, '');
        }

        // 그리드 선택 이벤트
        function gridClick(r, c)
        {
            var rw = gridIndex.GetRow(r);

            var CODE = rw["C3SAUP"] + '^' + rw["C3BCODE"] + '^' + rw["C3MCODE"] + '^' + rw["C3SCODE"];

            fn_OpenPopCustom("PSM1031.aspx?CODE=" + CODE, 850, 380, CODE);
        }
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="설비코드관리" DefaultHide="False">
        <!-- 상단의 버튼을 정의 -->
        <div class="btn_bx">
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="80px" />
                    <col width="320px" />
                    <col width="80px" />
                    <col width="320px" />
                    <col width="80px" />
                    <col width="320px" />
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
                        <Ctl:Combo ID="cboBCODE" Width="100%" runat="server" OnChange= "cboBCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblMCODE" runat="server" LangCode="lblMCODE" Description="중분류"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboMCODE" Width="100%" runat="server"  OnChange= "cboMCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <td  style="border-left:hidden"></td>
                </tr>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="lblSCODE" runat="server" LangCode="lblSCODE" Description="설비"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboSCODE" Width="100%" runat="server" RepeatColumns="2" >
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblC3NAME" runat="server" LangCode="lblC3NAME" Description="설비명"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtC3NAME" Width="100%" runat="server" LangCode="txtC3NAME" Description="설비명"></Ctl:TextBox>
                    </td>
                    <td colspan="3" style="text-align:right;border-left:hidden;">
                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                        <Ctl:Button ID="btnNew" runat="server" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();"></Ctl:Button>
                        <Ctl:Button ID="btnCLASS2" runat="server" LangCode="btnCLASS2" Description="중분류" OnClientClick="btnCLASS2_Click();"></Ctl:Button>
                        <Ctl:Button ID="btnCLASS1" runat="server" LangCode="btnCLASS1" Description="대분류" OnClientClick="btnCLASS1_Click();"></Ctl:Button>
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
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1030" MethodName="UP_GET_ACFIXCLASS3_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="27">
                            <Ctl:SheetField DataField="C3SAUP" TextField="사업부" Description="사업부" Width="50"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="C3BCODE" TextField="대분류코드" Description="대분류코드" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="C3BCODENM" TextField="대분류명" Description="대분류명" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3MCODE" TextField="중분류코드" Description="중분류코드" Width="65" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3MCODENM" TextField="중분류명" Description="중분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3SCODE" TextField="설비코드" Description="설비코드" Width="160" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="C3NAME" TextField="설비명" Description="설비명" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />            
                            <Ctl:SheetField DataField="C3LINKCODE1" TextField="연결설비1" Description="연결설비1" Width="85" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />       
                            <Ctl:SheetField DataField="C3LINKCODE1NM" TextField="연결설비명1" Description="연결설비명1" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />       
                            <Ctl:SheetField DataField="C3LINKCODE2" TextField="연결설비2" Description="연결설비2" Width="85" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />       
                            <Ctl:SheetField DataField="C3LINKCODE2NM" TextField="연결설비명2" Description="연결설비명2" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
