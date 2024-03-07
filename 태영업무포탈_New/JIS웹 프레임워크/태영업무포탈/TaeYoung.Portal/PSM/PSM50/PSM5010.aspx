<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM5010.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM50.PSM5010" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style>           
        
        
        #wtBoardlist
        {           
          overflow-y:auto;
        }         
        </style>

    <script type="text/javascript">


        var DataGubn = "";
        var NTCODE = "MA";

        function OnLoad() {

            btnSearch.Hide();
            btnNew.Hide();

            $("#txtPBMLCODEPL").attr("style", "font-size:large");

            UP_OrgTreeDataBing();
        }
        function UP_OrgTreeDataBing() {

            wtBoardlist.Clear("wtBoardlist");

            wtBoardlist.AllSelectCancelItem();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PBC1NTCODE"] = NTCODE;

            wtBoardlist.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtBoardlist.BindTree('wtBoardlist'); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["PBMCNTCODE"] = NTCODE;
            ht["PBMLCODE"] = txtPBMLCODE.GetValue();
            ht["PBMMCODE"] = cboPBMMCODE.GetValue();
            ht["PBMSCODE"] = cboPBMSCODE.GetValue();
            ht["PBMTITLE"] = txtPBMTITLE.GetValue();
            ht["PBMPUSABUN"] = svPBMPUSABUN.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click() {

            var CODE = NTCODE + "^" + txtPBMLCODE.GetValue();

            fn_OpenPopCustom("PSM5011.aspx?CODE=" + CODE, 800, 680, CODE);
        }

        // 등록 팝업 콜백
        function board_popup_callback() {

            btnSearch_Click();
        }

        // 메뉴 선택 이벤트
        function wtBoardlist_click(o, s) {

            if (s.Item.Values[0] == "1") {
                var ht = new Object();

                txtPBMLCODE.SetValue(s.Item.Name);
                txtPBMLCODENM.SetValue(s.Item.Text);
                txtPBMLCODEPL.SetValue(s.Item.Text);
                cboPBMMCODE.SetValue("");
                cboPBMSCODE.SetValue("");

                // 중분류 조회
                var ht = new Object();
                ht["PBMCNTCODE"] = NTCODE;
                ht["PBMLCODE"] = txtPBMLCODE.GetValue();
                ht["GUBUN"] = "S";

                cboPBMMCODE.TypeName = "PSM.PSM2010";
                cboPBMMCODE.MethodName = "UP_GET_PBMMCODE_LIST";
                cboPBMMCODE.DataTextField = "PBC2NAME";
                cboPBMMCODE.DataValueField = "PBC2MCODE";
                cboPBMMCODE.Params(ht);
                cboPBMMCODE.BindList();

                ht = new Object();

                ht["P_PBC3LCODE"] = s.Item.Name;

                PageMethods.InvokeServiceTable(ht, "PSM.PSM2010", "UP_BOARD_CLASS3_CHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                        btnNew.Show();
                        btnSearch.Show();
                    }
                    else {
                        btnNew.Hide();
                        btnSearch.Hide();
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                });

                cboPBMMCODE_Change();

                btnSearch_Click();
            }
        }

        // 중분류 선택 이벤트
        function cboPBMMCODE_Change() {

            var ht = new Object();
            ht["PBMCNTCODE"] = NTCODE;
            ht["PBMLCODE"] = txtPBMLCODE.GetValue();
            ht["PBMMCODE"] = cboPBMMCODE.GetValue();
            ht["GUBUN"] = "S";

            cboPBMSCODE.TypeName = "PSM.PSM2010";
            cboPBMSCODE.MethodName = "UP_GET_PBMSCODE_LIST";
            cboPBMSCODE.DataTextField = "PBC3NAME";
            cboPBMSCODE.DataValueField = "PBC3SCODE";
            cboPBMSCODE.Params(ht);
            cboPBMSCODE.BindList();

            //return false;
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {

            var ht = new Object();
            var rw = gridIndex.GetRow(r);

            var CODE = NTCODE + "^" + rw["PBMLCODE"] + "^" + rw["PBMMCODE"] + "^" + rw["PBMSCODE"] + "^" + rw["PBMNUM"];

            fn_OpenPopCustom("PSM5011.aspx?CODE=" + CODE, 800, 680, CODE);
        }


    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="예방점검 유지관리" DefaultHide="False">
        <table style="width: 100%;">
                <colgroup>
                    <col width="250px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <div class="btn_bx" style="height:770px; overflow-y:hidden; overflow-x:hidden;">
                            <table class="table_01" style="width:100%;height:100%;">    
                                <colgroup>
                                    <col width="100%" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:left;">
                                        <div style="height:750px;width:220px; overflow-y:auto; overflow-x:auto;" >
                                            <Ctl:WebTree ID="wtBoardlist" runat="server" CheckBox="false" Description="예방점검 유지관리" HideTitle="false" IndexBindFiledName="MENU_NO" EnableSearchBox="false"
                                                         MethodName="UP_GET_BOARD_MENU_LIST" ParentBindFieldName="UP_MENU_NO"  TextBindFieldName="MENU_NAME" TypeName="PSM.PSM2010" Width = "100%" OnClick="wtBoardlist_click" OnLoaded="" />
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
                                    <col width="60" />
                                    <col width="220" />
                                    <col width="60" />
                                    <col width="220" />
                                    <col width="60" />
                                    <col width="220" />
                                    <col width="*" />
                                </colgroup>
                                <tr>
                                    <td colspan="7" style="text-align:left;border:none;">
                                        <div>
                                            <Ctl:Text ID="txtPBMLCODEPL" runat="server" LangCode="txtPBMLCODEPL" Description="예방점검 유지관리"></Ctl:Text>
                                        </div>
                                    </td>
                                </tr>
                                <tr >
                                    <Ctl:TextBox ID="txtPBMLCODE" Width="0px" runat="server" LangCode="txtPBMLCODE" Description="대분류" ReadOnly="true" Hidden="true"></Ctl:TextBox>
                                    <Ctl:TextBox ID="txtPBMLCODENM" Width="0px" runat="server" LangCode="txtPBMLCODENM" Description="대분류명" ReadOnly="true" Hidden="true"></Ctl:TextBox>
                                    <th style="text-align:center">
                                        <Ctl:Text ID="lblPBMMCODE" runat="server" LangCode="lblPBMMCODE" Description="중분류" ></Ctl:Text>
                                    </th>
                                    <td style="text-align:left">
                                        <Ctl:Combo ID="cboPBMMCODE" Width="100%" runat="server" OnChange= "cboPBMMCODE_Change()">
                                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                                        </Ctl:Combo>
                                    </td>
                                    <th style="text-align:center">
                                        <Ctl:Text ID="lblPBMSCODE" runat="server" LangCode="lblPBMSCODE" Description="소분류" ></Ctl:Text>
                                    </th>
                                    <td style="text-align:left">
                                        <Ctl:Combo ID="cboPBMSCODE" Width="100%" runat="server" RepeatColumns="2" >
                                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                                        </Ctl:Combo>
                                    </td>
                                    <th style="text-align:center">
                                        <Ctl:Text ID="lblPBMPUSABUN" runat="server" LangCode="lblPBMPUSABUN" Description="게시자" ></Ctl:Text>
                                    </th>
                                    <td style="text-align:left">
                                        <Ctl:SearchView ID="svPBMPUSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                            <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="70" />
                                            <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="70" Default="true"/>                                            
                                        </Ctl:SearchView>
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <th style="text-align:center;">
                                        <Ctl:Text ID="lblPBMTITLE" runat="server" LangCode="lblPBMTITLE" Description="게시명" ></Ctl:Text>
                                    </th>
                                    <td colspan="3" style="text-align:left;">
                                        <Ctl:TextBox ID="txtPBMTITLE" Width="370px" runat="server" LangCode="txtPBMTITLE" Description="게시명"></Ctl:TextBox>
                                    </td>
                                    <td colspan="3" style="text-align:right;border-left:hidden;">
                                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnNew" runat="server" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM2010" MethodName="UP_GET_BOARD_MAST_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30">
                                <Ctl:SheetField DataField="PBMLCODE" TextField="PBMLCODE" Description="대분류코드" Width="0"  HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                                <Ctl:SheetField DataField="PBC1NAME" TextField="PBC1NAME" Description="대분류" Width="0"  HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                                <Ctl:SheetField DataField="PBMMCODE" TextField="PBMMCODE" Description="중분류코드" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>                            
                                <Ctl:SheetField DataField="PBC2NAME" TextField="PBC2NAME" Description="중분류" Width="190" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false"/>   
                                <Ctl:SheetField DataField="PBMSCODE" TextField="PBMSCODE" Description="소분류코드" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                                <Ctl:SheetField DataField="PBC3NAME" TextField="PBC3NAME" Description="소분류" Width="190" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false"/>   
                                <Ctl:SheetField DataField="PBMNUM" TextField="PBMNUM" Description="순번" Width="60" HAlign="center" Align="center" runat="server" OnClick="gridClick" Hidden="false"/>
                                <Ctl:SheetField DataField="PBMTITLE" TextField="PBMTITLE" Description="게시명" Width="*" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false" />
                                <Ctl:SheetField DataField="PBMPUSABUN" TextField="PBMPUSABUN" Description="사번" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                                <Ctl:SheetField DataField="KBHANGL" TextField="KBHANGL" Description="게시자" Width="100" HAlign="center" Align="center" runat="server" OnClick="gridClick" Hidden="false" />
                                <Ctl:SheetField DataField="PBMPUDATE" TextField="PBMPUDATE" Description="게시일자" Width="120" HAlign="center" Align="center" runat="server" OnClick="gridClick" Hidden="false" />
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>