<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1110.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1110" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        // 페이지 로드
        function OnLoad() {          

            //게시판 구분 코드 바인딩
            UP_Set_PBC1NTCODE();

            UP_Get_DataBinding();
        }

        function UP_Get_DataBinding() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["P_PBC3NTCODE"] = cboPBC3NTCODE.GetValue();
            ht["P_PBC3LCODE"] = cboPBC3LCODE.GetValue();
            ht["P_PBC3MCODE"] = cboPBC3MCODE.GetValue();
            ht["P_PBC3NAME"] = txtPBC3NAME.GetValue();

            GridScodeList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            GridScodeList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩            
        } 
          

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            UP_Get_DataBinding();

        }  


         // 게시판 구분 코드 바인딩
        function UP_Set_PBC1NTCODE() {         

            var ht = new Object();

            ht["P_GUBUN"] = 'S';

            cboPBC3NTCODE.TypeName = "PSM.PSM1111";
            cboPBC3NTCODE.MethodName = "UP_GET_NTCODE_LIST";
            cboPBC3NTCODE.DataTextField = "CODENAME";
            cboPBC3NTCODE.DataValueField = "CODE";
            cboPBC3NTCODE.Params(ht);
            cboPBC3NTCODE.BindList();
            
        }

        // 게시판 구분 선택 이벤트
        function cboPBC3NTCODE_Change() {

            var ht = new Object();

            ht["P_PBC1NTCODE"] = cboPBC3NTCODE.GetValue();
            ht["P_GUBUN"] = 'S';

            cboPBC3LCODE.TypeName = "PSM.PSM1112";
            cboPBC3LCODE.MethodName = "UP_GET_LCODE_LIST";
            cboPBC3LCODE.DataTextField = "PBC1LCODENAME";
            cboPBC3LCODE.DataValueField = "PBC1LCODE";
            cboPBC3LCODE.Params(ht);
            cboPBC3LCODE.BindList();

            cboPBC3LCODE_Change();
        }
  

        // 대분류 선택 이벤트
        function cboPBC3LCODE_Change() {

            var ht = new Object();

            ht["P_PBC2NTCODE"] = cboPBC3NTCODE.GetValue();
            ht["P_PBC2LCODE"] = cboPBC3LCODE.GetValue();
            ht["P_GUBUN"] = 'S';

            cboPBC3MCODE.TypeName = "PSM.PSM1113";
            cboPBC3MCODE.MethodName = "UP_GET_MCODE_LIST";
            cboPBC3MCODE.DataTextField = "PBC2MCODENAME";
            cboPBC3MCODE.DataValueField = "PBC2MCODE";
            cboPBC3MCODE.Params(ht);
            cboPBC3MCODE.BindList();
        }       

        // 신규 버튼 이벤트
        function btnNew_Click()
        {
            var CODE = '';

            fn_OpenPopCustom("PSM1113.aspx?CODE="+ CODE, 850, 400, '');
                        
        }

        // 중분류 버튼 이벤트
        function btnCLASS2_Click() {
            
            fn_OpenPopCustom("PSM1112.aspx", 1000, 610, '');
        }

        // 대분류 버튼 이벤트
        function btnCLASS1_Click() {

            fn_OpenPopCustom("PSM1111.aspx", 1000, 450, '');
        }

        // 그리드 선택 이벤트
        function gridClick(r, c)
        {
            var rw = GridScodeList.GetRow(r);

            var CODE = rw["PBC3NTCODE"] + '^' + rw["PBC3LCODE"] + '^' + rw["PBC3MCODE"] + '^' + rw["PBC3SCODE"];

            fn_OpenPopCustom("PSM1113.aspx?CODE=" + CODE, 850, 400, CODE);
        }

        function btnSearch_Callback(){
             btnSearch_Click();
        }

      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="공전안전자료 분류코드관리" DefaultHide="False">
        <!-- 상단의 버튼을 정의 -->
        <div class="btn_bx">
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="80px" />
                    <col width="320px" />
                    <col width="80px" />
                    <col width="320px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">                    
                    <th>
                        <Ctl:Text ID="lblPBC3NTCODE" runat="server" LangCode="lblPBC3NTCODE" Description="게시판 구분" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboPBC3NTCODE" Width="100%" runat="server" OnChange= "cboPBC3NTCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblPBC3LCODE" runat="server" LangCode="lblLCODE" Description="대분류" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboPBC3LCODE" Width="100%" runat="server" OnChange= "cboPBC3LCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <td  style="border-left:hidden"></td>
                </tr>
                <tr style="text-align:left;">                    
                    
                    <th>
                        <Ctl:Text ID="lblPBC3MCODE" runat="server" LangCode="lblPBC3MCODE" Description="중분류"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboPBC3MCODE" Width="100%" runat="server"  OnChange= "cboPBC3MCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>                   
                    <th>
                        <Ctl:Text ID="lblPBC3NAME" runat="server" LangCode="lblL3NAME" Description="소분류명"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtPBC3NAME" Width="100%" runat="server" LangCode="txtPBC3NAME" Description="소분류명"></Ctl:TextBox>
                    </td>
                    
                    <td style="text-align:right;border-left:hidden;">
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
                        <Ctl:WebSheet ID="GridScodeList" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1110" MethodName="UP_GET_SCODE_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30">
                            <Ctl:SheetField DataField="PBC3NTCODE" TextField="게시판 코드" Description="게시판 코드" Width="0"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PBC3NTCODENM" TextField="게시판 구분" Description="게시판 구분" Width="180"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PBC3LCODE" TextField="대분류코드" Description="대분류코드" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PBC3LCODENM" TextField="대분류명" Description="대분류명" Width="250" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="PBC3MCODE" TextField="중분류코드" Description="중분류코드" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="PBC3MCODENM" TextField="중분류명" Description="중분류명" Width="250" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="PBC3SCODE" TextField="소분류코드" Description="소분류코드" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="PBC3NAME" TextField="소분류명" Description="소분류명" Width="250" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="PBC3BIGO" TextField="비 고" Description="비 고" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
