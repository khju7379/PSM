<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSP1090.aspx.cs" Inherits="TaeYoung.Portal.PSM.POP.PSP1090" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        // 페이지 로드
        function OnLoad() {

            // PageLoad시 이벤트 정의부분

            var ht = new Object();
            ht["GUBUN"] = "S";

            cboBCODE.TypeName = "PSM.PSM1080";
            cboBCODE.MethodName = "UP_GET_JSA_BCODE_LIST";
            cboBCODE.DataTextField = "J1CODENAME";
            cboBCODE.DataValueField = "J1CODE";
            cboBCODE.Params(ht);
            cboBCODE.BindList();

            cboBCODE_Change();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 10;
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["SCODE"] = cboSCODE.GetValue();
            ht["SNAME"] = txtJ3NAME.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 10;
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["SCODE"] = cboSCODE.GetValue();
            ht["SNAME"] = txtJ3NAME.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();
        }

        // 대분류 선택 이벤트
        function cboBCODE_Change() {

            var ht = new Object();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["GUBUN"] = "S";

            cboMCODE.TypeName = "PSM.PSM1080";
            cboMCODE.MethodName = "UP_GET_JSA_MCODE_LIST";
            cboMCODE.DataTextField = "J2CODENAME";
            cboMCODE.DataValueField = "J2MCODE";
            cboMCODE.Params(ht);
            cboMCODE.BindList();

            cboMCODE_Change();
            //return false;
        }

        // 중분류 선택 이벤트
        function cboMCODE_Change() {

            var ht = new Object();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["GUBUN"] = "S";

            cboSCODE.TypeName = "PSM.PSM1080";
            cboSCODE.MethodName = "UP_GET_JSA_SCODE_LIST";
            cboSCODE.DataTextField = "J3CODENAME";
            cboSCODE.DataValueField = "J3SCODE";
            cboSCODE.Params(ht);
            cboSCODE.BindList();

            //return false;
        }

        // 중분류 버튼 이벤트
        function btnCLASS2_Click() {
            
            fn_OpenPopCustom("PSM1082.aspx", 1100, 580, '');
        }

        // 대분류 버튼 이벤트
        function btnCLASS1_Click() {

            fn_OpenPopCustom("PSM1083.aspx", 1000, 450, '');
        }

        // 그리드 선택 이벤트
        function gridClick(r, c)
        {
            if (opener) {
                opener.btnAddClass_Callback(gridIndex.GetRow(gridIndex.SelectedRow));
                self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="JSA코드조회" DefaultHide="False">
        <!-- 상단의 버튼을 정의 -->
        <div class="content">
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="60px" />
                    <col width="75px" />
                    <col width="60px" />
                    <col width="115px" />
                    <col width="60px" />
                    <col width="215px" />
                    <col width="*" />
                </colgroup>
                <tr>
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
                        <Ctl:Text ID="lblSCODE" runat="server" LangCode="lblSCODE" Description="소분류"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboSCODE" Width="230px" runat="server" RepeatColumns="2" >
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    
                    <td style="text-align:right;">
                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                        <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ3NAME" runat="server" LangCode="lblJ3NAME" Description="소분류명"></Ctl:Text>
                    </th>
                    <td colspan="6">
                        <Ctl:TextBox ID="txtJ3NAME" Width="230px" runat="server" LangCode="txtJ3NAME" Description="소분류명"></Ctl:TextBox>
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
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1080" MethodName="UP_GET_JSA_CLASS3_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="J3BCODE" TextField="대분류코드" Description="대분류코드" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" Hidden="true"/>
                            <Ctl:SheetField DataField="J3BCODENM" TextField="대분류명" Description="대분류명" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="J3MCODE" TextField="중분류코드" Description="중분류코드" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick" Hidden="true"/>                            
                            <Ctl:SheetField DataField="J3MCODENM" TextField="중분류명" Description="중분류명" Width="180" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="J3SCODE" TextField="소분류코드" Description="소분류코드" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick" Hidden="true"/>                            
                            <Ctl:SheetField DataField="J3NAME" TextField="소분류명" Description="소분류명" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />            
                            <Ctl:SheetField DataField="J3BIGO" TextField="비고" Description="비고" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" Hidden="true"/>            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
