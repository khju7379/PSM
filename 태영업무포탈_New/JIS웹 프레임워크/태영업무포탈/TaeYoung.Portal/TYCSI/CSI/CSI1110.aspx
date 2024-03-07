<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI1110.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI1110" %>

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
            ht["HWAMUL"] = $("#svHWAMUL_CDCODE").val();
            ht["CHHJ"] = $("#svCHHJ_CDCODE").val();
            ht["CARNO"] = txtCARNO.GetValue();
            ht["TANKNO"] = txtTANKNO.GetValue();           

            ht["GUBUN"] = "S";
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }     
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="출고지시 조회" DefaultHide="False" LangCode="layer1" Description="출고지시 조회">
        <div class="btn_bx">        
           <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="210px" />
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
                         <Ctl:SearchView ID="svHWAMUL" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'HM'}" >                       
                              <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="130" TextBox="true" Default="true" runat="server" />
                         </Ctl:SearchView>
                    </td>
                    <th>
                        <Ctl:Text ID="txtYN" runat="server" LangCode="txtYN" Description="도착지"></Ctl:Text>
                    </th>
                    <td>
                          <Ctl:SearchView ID="svCHHJ" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'DC'}" >                       
                              <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="130" TextBox="true" Default="true" runat="server" />
                         </Ctl:SearchView>
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>                     
                    </td>
                </tr>
                 <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchTANKNO" runat="server" LangCode="txtSearchTANKNO" Description="탱크번호"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtTANKNO" runat="server"></Ctl:TextBox>                        
                    </td>
                    <th>
                        <Ctl:Text ID="txtSearchCARNO" runat="server" LangCode="txtSearchCARNO" Description="차량번호"></Ctl:Text>
                    </th>
                    <td colspan = "4" >
                        <Ctl:TextBox ID="txtCARNO" runat="server"></Ctl:TextBox>                        
                    </td>                    
                </tr>
            </table>  
        </div>
        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="610" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI1110_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="28" >
                            
                <Ctl:SheetField DataField="ORNUM" TextField="ORNUM" Description="오더번호" Width="110" HAlign="center" Align="left" runat="server"   />                            
                <Ctl:SheetField DataField="JISI" TextField="JISI" Description="지시번호" Width="110" HAlign="center" Align="left" runat="server"  />       
                                     
                <Ctl:SheetField DataField="ACVEND" TextField="ACVEND" Description="화 주" Width="130" HAlign="center" Align="left" runat="server" />                            
                <Ctl:SheetField DataField="HMDESC11" TextField="HMDESC11" Description="화 물" Width="120"  HAlign="center" Align="left" runat="server"  />
                <Ctl:SheetField DataField="JITANKNO" TextField="JITANKNO" Description="출고탱크" Width="80" HAlign="left" Align="left" runat="server" />                            
                <Ctl:SheetField DataField="HJDESC1" TextField="HJDESC1" Description="도착지" Width="130" HAlign="center" Align="left" runat="server" />                                   
                <Ctl:SheetField DataField="JITMGUBN" TextField="JITMGUBN" Description="특허" Width="60" HAlign="center" Align="left" runat="server" />                     
                <Ctl:SheetField DataField="JICARNO2" TextField="JICARNO2" Description="차량번호" Width="110" HAlign="center" Align="left" runat="server" />                                                               
                <Ctl:SheetField DataField="JICONTNUM" TextField="JICONTNUM" Description="CON NO" Width="130" HAlign="center" Align="left" runat="server" />                                                               
                <Ctl:SheetField DataField="JICARNO1" TextField="JICARNO1" Description="지시사항" Width="170" HAlign="center" Align="left" runat="server" />                            
                                                        
                <Ctl:SheetField DataField="JIJIQTY" TextField="JIJIQTY" Description="지시수량" DataType="Number"  Width="75" HAlign="right" Align="right" runat="server" />                                                                             
                <Ctl:SheetField DataField="JICHQTY" TextField="JICHQTY" Description="출고수량" DataType="Number"  Width="85" HAlign="right" Align="right" runat="server" />           
                            
                <Ctl:SheetField DataField="JIIPHANG" TextField="JIIPHANG" Description="입항일자" Width="90" HAlign="center" Align="left" runat="server" />                                                                                              
                <Ctl:SheetField DataField="VSDESC1" TextField="VSDESC1" Description="본선" Width="120" HAlign="center" Align="left" runat="server" />                            
                <Ctl:SheetField DataField="JIBLNO" TextField="JIBLNO" Description="MASTER B/L" Width="150" HAlign="center" Align="left" runat="server" />                            

            </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>