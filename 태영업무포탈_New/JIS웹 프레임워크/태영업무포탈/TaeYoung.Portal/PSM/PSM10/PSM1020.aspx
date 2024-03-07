<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1020.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1020" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        // 페이지 로드
        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            // PageLoad시 이벤트 정의부분
            
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SAUP"] = "T";
            ht["LCODE"] = "";
            ht["MCODE"] = "";
            ht["SCODE"] = "";
            ht["SNAME"] = "";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            cboSAUP_Change();
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SearchCondition"] = 1;
            ht["PageSize"] = 15;
            ht["SAUP"] = cboSAUP.GetValue();
            ht["LCODE"] = cboLCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["SCODE"] = cboSCODE.GetValue();
            ht["SNAME"] = txtL3NAME.GetValue();

            //alert(ht["SearchCondition"] + "^" + ht["PageSize"] + "^" + ht["SAUP"] + "^" + ht["LCODE"] + "^" + ht["MCODE"] + "^" + ht["SCODE"] + "^" + ht["SNAME"]);

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 사업부 선택 이벤트
        function cboSAUP_Change()
        {
            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["GUBUN"] = "S";

            cboLCODE.TypeName = "PSM.PSM1020";
            cboLCODE.MethodName = "UP_GET_LCODE_LIST";
            cboLCODE.DataTextField = "L1CODENAME";
            cboLCODE.DataValueField = "L1CODE";
            cboLCODE.Params(ht);
            cboLCODE.BindList();

            cboLCODE_Change();
            return false;
        }

        // 대분류 선택 이벤트
        function cboLCODE_Change() {
            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["LCODE"] = cboLCODE.GetValue();
            ht["GUBUN"] = "S";

            cboMCODE.TypeName = "PSM.PSM1020";
            cboMCODE.MethodName = "UP_GET_MCODE_LIST";
            cboMCODE.DataTextField = "L2CODENAME";
            cboMCODE.DataValueField = "L2MCODE";
            cboMCODE.Params(ht);
            cboMCODE.BindList();

            cboMCODE_Change();
            return false;
        }

        // 중분류 선택 이벤트
        function cboMCODE_Change() {
            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["LCODE"] = cboLCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();

            cboSCODE.TypeName = "PSM.PSM1020";
            cboSCODE.MethodName = "UP_GET_SCODE_LIST";
            cboSCODE.DataTextField = "L3CODENAME";
            cboSCODE.DataValueField = "L3SCODE";
            cboSCODE.Params(ht);
            cboSCODE.BindList();

            return false;
        }

        // 신규 버튼 이벤트
        function btnNew_Click()
        {
            var CODE = '';

            fn_OpenPopCustom("PSM1021.aspx?CODE=" + CODE, 850, 350);
        }

        // 중분류 버튼 이벤트
        function btnCLASS2_Click() {
            
            fn_OpenPopCustom("PSM1022.aspx", 1000, 610, '');
        }

        // 대분류 버튼 이벤트
        function btnCLASS1_Click() {

            fn_OpenPopCustom("PSM1023.aspx", 1000, 450, '');
        }

        // 그리드 선택 이벤트
        function gridClick(r, c)
        {
            var rw = gridIndex.GetRow(r);

            var CODE = rw["L3SAUP"] + '^' + rw["L3BCODE"] + '^' + rw["L3MCODE"] + '^' + rw["L3SCODE"];

            fn_OpenPopCustom("PSM1021.aspx?CODE=" + CODE, 850, 350, CODE);
        }

        //var winPop;

        
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="위치코드관리" DefaultHide="False">
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
                        <Ctl:Text ID="lblLCODE" runat="server" LangCode="lblLCODE" Description="대분류" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboLCODE" Width="100%" runat="server" OnChange= "cboLCODE_Change()">
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
                        <Ctl:Text ID="lblSCODE" runat="server" LangCode="lblSCODE" Description="위치"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboSCODE" Width="100%" runat="server" RepeatColumns="2" >
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblL3NAME" runat="server" LangCode="lblL3NAME" Description="위치명"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtL3NAME" Width="100%" runat="server" LangCode="txtL3NAME" Description="위치명"></Ctl:TextBox>
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
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1020" MethodName="UP_GET_LOCATIONCODE_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="27">
                            <Ctl:SheetField DataField="L3SAUP" TextField="사업부" Description="사업부" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="L3BCODE" TextField="대분류코드" Description="대분류코드" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="L3BCODENM" TextField="대분류명" Description="대분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="L3MCODE" TextField="중분류코드" Description="중분류코드" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="L3MCODENM" TextField="중분류명" Description="중분류명" Width="200" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="L3SCODE" TextField="위치코드" Description="위치코드" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="L3NAME" TextField="위치명" Description="위치명" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
