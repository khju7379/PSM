<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI1120.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI1120" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {
            var today = new Date();
            txtFRDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtTODate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
        }

        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            
            ht["SDATE"] = txtFRDate.GetValue();
            ht["EDATE"] = txtTODate.GetValue();
            ht["HWAJU"] = HwajuCode;
            ht["HWAMUL"] = $("#svHWAMUL_CDCODE").val();
            ht["WKTYPE"] = cmbJIWKTYPE.GetValue();
            ht["CHHJ"] = $("#svCHHJ_CDCODE").val();
            ht["CHDNST"] = $("#svJIDNST_CDCODE").val();
            ht["JIGSPINO"] = txtGSPINO.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function btnExcel_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="ISO/FLEXI 출고조회" DefaultHide="False" LangCode="layer1" Description="ISO/FLEXI 출고조회">
        <div class="btn_bx">        
           <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="200px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="조회일자 (Fr~To)"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                        <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtHWAMUL" runat="server" LangCode="txtHWAMUL" Description="화 물"></Ctl:Text>
                    </th>
                    <td>
                         <Ctl:SearchView ID="svHWAMUL" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_HWAMUL_LIST" Params="{'INDEX':'HM', 'IPHWAJU':HwajuCode }" >                        
                              <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="130" TextBox="true" Default="true" runat="server" />
                         </Ctl:SearchView>
                    </td>
                    <th>
                        <Ctl:Text ID="txtCHHJ" runat="server" LangCode="txtCHHJ" Description="출고화주"></Ctl:Text>
                    </th>
                    <td>
                          <Ctl:SearchView ID="svCHHJ" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'HJ'}" >                       
                              <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="130" TextBox="true" Default="true" runat="server" />
                         </Ctl:SearchView>
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>                     
                     <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>    
                    </td>
                </tr>
                 <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchGSPINO" runat="server" LangCode="txtSearchGSPINO" Description="GS-PI NO."></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtGSPINO" runat="server"></Ctl:TextBox>                        
                    </td>
                    <th>
                        <Ctl:Text ID="txtJIDNST" runat="server" LangCode="txtJIDNST" Description="목적국"></Ctl:Text>
                    </th>
                    <td>
                    <Ctl:SearchView ID="svJIDNST" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'GS'}" >                       
                       <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true" runat="server" />
                       <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="130" TextBox="false" Default="true" runat="server" />
                    </Ctl:SearchView>

                    </td>      
                    <th>
                        <Ctl:Text ID="txtJIWKTYPE" runat="server" LangCode="txtJIWKTYPE" Description="출고유형"></Ctl:Text>
                    </th>
                    <td colspan = "4" >
                    <Ctl:Combo ID="cmbJIWKTYPE" runat="server" RepeatColumns="2" >
                        <asp:ListItem Selected="True" Text="전체" Value="02,03"></asp:ListItem>
                        <asp:ListItem Text="ISO TANK" Value="02"></asp:ListItem>
                        <asp:ListItem Text="FLEXI BAG" Value="03"></asp:ListItem>
                    </Ctl:Combo>
                    </td>
                </tr>
            </table>  
        </div>
        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="610" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI1120_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="28" >
                
                <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화 물" Width="120"  HAlign="center" Align="left" runat="server"  />
                <Ctl:SheetField DataField="CHCHULIL" TextField="CHCHULIL" Description="출고일자" Width="110" HAlign="center" Align="left" runat="server" />                            
                <Ctl:SheetField DataField="CHCHTANK" TextField="CHCHTANK" Description="탱크번호" Width="90"  HAlign="center" Align="left" runat="server"  />
                <Ctl:SheetField DataField="CHBIJUNG" TextField="CHBIJUNG" Description="비중" DataType="Number" Width="80" HAlign="center" Align="right" runat="server" />   
                <Ctl:SheetField DataField="CHMTQTY" TextField="CHMTQTY" Description="출고량(MT)" DataType="Number" Width="115" HAlign="center" Align="right" runat="server" />                                   
                <Ctl:SheetField DataField="CHCONTNUM" TextField="CHCONTNUM" Description="컨테이너번호" Width="130" HAlign="center" Align="left" runat="server" />                     
                <Ctl:SheetField DataField="CHSILNUM" TextField="CHSILNUM" Description="SEAL번호" Width="110" HAlign="center" Align="left" runat="server" />       
                <Ctl:SheetField DataField="GSDESC1" TextField="GSDESC1" Description="목적국" Width="150" HAlign="center" Align="left" runat="server" />             
                <Ctl:SheetField DataField="CHCARNO" TextField="CHCARNO" Description="차량번호" Width="70" HAlign="center" Align="left" runat="server" />                            
                <Ctl:SheetField DataField="JIGSPINO" TextField="JIGSPINO" Description="GS-PI NO"  Width="150" HAlign="center" Align="left" runat="server" />  
                <Ctl:SheetField DataField="CHCHSTR" TextField="CHCHSTR" Description="입고시간" Width="80" HAlign="center" Align="left" runat="server" />           
                <Ctl:SheetField DataField="CHCHEND" TextField="CHCHEND" Description="출고시간" Width="80" HAlign="center" Align="left" runat="server" />     
                <Ctl:SheetField DataField="CHEMPTY" TextField="CHEMPTY" Description="공차" DataType="Number" Width="100" HAlign="center" Align="right" runat="server" />
                <Ctl:SheetField DataField="CHTOTAL" TextField="CHTOTAL" Description="실차" DataType="Number" Width="100" HAlign="center" Align="right" runat="server" />
                <Ctl:SheetField DataField="LTQTY" TextField="LTQTY" Description="출고량(L)" DataType="Number" Width="110" HAlign="center" Align="right" runat="server" />      
                <Ctl:SheetField DataField="DCDESC1" TextField="DCDESC1" Description="출고화주" Width="150" HAlign="center" Align="left" runat="server" />                            
                <Ctl:SheetField DataField="CHWKTYPE" TextField="CHWKTYPE" Description="출고유형" Width="100" HAlign="center" Align="left" runat="server" />         

            </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>