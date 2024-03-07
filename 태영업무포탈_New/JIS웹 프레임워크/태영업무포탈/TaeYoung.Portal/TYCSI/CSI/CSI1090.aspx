<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI1090.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI1090" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

           
        }

        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;            
            ht["IPHWAJU"] = HwajuCode;
            ht["SDATE"] = txtFRDate.GetValue();
            ht["EDATE"] = txtTODate.GetValue();
            ht["IPHWAMUL"] = $("#svHWAMUL_CDCODE").val();
            ht["JGCHECK"] = cmbYN.GetValue();
            ht["GUBUN"] = "S";
            
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
        <Ctl:Layer ID="layer1" runat="server" Title="모선 B/L별 통관 재고 조회" DefaultHide="False" LangCode="layer1" Description="모선 B/L별 통관 재고 조회">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="230px" />
                    <col width="80px" />
                    <col width="110px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="조회일자 (Fr~To)"></Ctl:Text>
                    </th>
                    <td style="text-align:left;">
                        <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                        <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtHWAMUL" runat="server" LangCode="txtHWAMUL" Description="화 물"></Ctl:Text>
                    </th>
                    <td>
                         <Ctl:SearchView ID="svHWAMUL" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_HWAMUL_LIST" Params="{'INDEX':'HM', 'IPHWAJU':HwajuCode }" >                       
                              <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="120" TextBox="true" Default="true" runat="server" />
                         </Ctl:SearchView>
                    </td>
                    <th>
                        <Ctl:Text ID="txtYN" runat="server" LangCode="txtYN" Description="재고유무"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cmbYN" runat="server" width = "80" RepeatColumns="2">
                             <asp:ListItem Text="전체" Value="ALL" LangCode="chk1_1" Description="전체"></asp:ListItem>
                             <asp:ListItem Selected="True" Text="유" Value="Y"></asp:ListItem>
                             <asp:ListItem Text="무" Value="N"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>
                    </td>
                </tr>
            </table>        
        </div>
          <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true"   Fixation = "true" Height="650" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI1090_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                            <Ctl:SheetField DataField="IPIPHANG" TextField="IPIPHANG" Description="입항일자"  Width="100" HAlign="center" Align="left" runat="server"  />                            
                            <Ctl:SheetField DataField="VSDESC1" TextField="VSDESC1" Description="본  선"   Width="150" HAlign="center" Align="left" runat="server"    />                                                        
                            <Ctl:SheetField DataField="IPBLNO" TextField="IPBLNO" Description="B/L NO"   Width="200" HAlign="left" Align="left" runat="server" />                            
                            <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화물명"   Width="150" HAlign="left" Align="left" runat="server"    />                            

                            <Ctl:SheetField DataField="IPBSQTY" TextField="IPBSQTY" Description="B/L량"    DataType="Number"  Width="130" HAlign="right" Align="right" runat="server"  />                                                                             
                            <Ctl:SheetField DataField="IPMTQTY" TextField="IPMTQTY" Description="입고량"  DataType="Number"  Width="130" HAlign="right" Align="right" runat="server"  />                                                                             
                            <Ctl:SheetField DataField="IPPAQTY" TextField="IPPAQTY" Description="통관량"   DataType="Number"  Width="130" HAlign="right" Align="right" runat="server"  />                                                                             
                            <Ctl:SheetField DataField="REIPPAQTY" TextField="REIPPAQTY" Description="미통관량"  DataType="Number"  Width="140" HAlign="right" Align="right" runat="server"  />            
                            <Ctl:SheetField DataField="CHCHULIL" TextField="CHCHULIL" Description="출고일자" Width="130" HAlign="center" Align="center" runat="server" />                                                                                           
                            <Ctl:SheetField DataField="CHULQTY" TextField="CHULQTY" Description="출고량" DataType="Number"  Width="135" HAlign="right" Align="right" runat="server" />                                                                             
                            <Ctl:SheetField DataField="JEGOQTY" TextField="JEGOQTY" Description="재고량" DataType="Number"  Width="135" HAlign="right" Align="right" runat="server" />                                                                             
                            <Ctl:SheetField DataField="TONGJEGOQTY" TextField="TONGJEGOQTY" Description="통관재고량" DataType="Number"  Width="140" HAlign="right" Align="right" runat="server" />                                                                               

                        </Ctl:WebSheet>
        
        </Ctl:Layer> 
    </div>
</asp:content>