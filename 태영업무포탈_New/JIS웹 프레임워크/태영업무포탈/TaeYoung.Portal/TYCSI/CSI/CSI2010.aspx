<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI2010.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI2010" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {
            var today = new Date();
            txtFRDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)));

        }

        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" ) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="매출년월 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";
            ht["MCHWAJU"] = HwajuCode.substr(0,2);
            
            ht["MCDATE"] = txtFRDate.GetValue();            
            ht["GUBUN"] = "S";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }     
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="접안료 매출 조회" DefaultHide="False" LangCode="layer1" Description="접안료 매출 조회">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                   <th>
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="매출년월"></Ctl:Text>
                   </th>
                   <td>
                        <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar" CalendarGroup="GRP01"></Ctl:TextBox>                         
                   </td>
                   <td style="text-align:right;">
                        <!-- 상단의 버튼을 정의 -->
                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>                        
                   </td>
                </tr>
            </table>        
        </div>
          <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="650" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI2010_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            <Ctl:SheetField DataField="JBDATE" TextField="JBDATE" Description="매출일자" Width="130" HAlign="center" Align="left" runat="server"  />  
                                 
                            <Ctl:SheetField DataField="JBIPHANG" TextField="JBIPHANG" Description="입항일자" Width="180" HAlign="center" Align="left" runat="server" />       
                            <Ctl:SheetField DataField="JBBONSUN" TextField="JBBONSUN" Description="본  선" Width="230" HAlign="center" Align="left" runat="server" />         
                            <Ctl:SheetField DataField="JBINDATE" TextField="JBINDATE" Description="접안일자" Width="180" HAlign="center" Align="left" runat="server" />                                               
                            <Ctl:SheetField DataField="JBOUTDATE" TextField="JBOUTDATE" Description="이안일자" Width="180" HAlign="center" Align="left" runat="server" />       
                            <Ctl:SheetField DataField="JBTOTTIM" TextField="JBTOTTIM" Description="총접안시간" Width="180"  HAlign="right" Align="right" runat="server"  />
                            <Ctl:SheetField DataField="JBGROSS" TextField="JBGROSS" Description="G/T"  Width="120" HAlign="right" Align="right" runat="server" />                                                                        
                            <Ctl:SheetField DataField="JBAMT" TextField="JBAMT" Description="공급가" DataType="Number"  Width="150" HAlign="right" Align="right" runat="server" />                                                                        
                            <Ctl:SheetField DataField="JBVAT" TextField="JBVAT" Description="부가세" DataType="Number"  Width="150" HAlign="right" Align="right" runat="server" />                                                                        
                            <Ctl:SheetField DataField="JBHAP" TextField="JBHAP" Description="합  계" DataType="Number"  Width="170" HAlign="right" Align="right" runat="server" />                                                                        

                        </Ctl:WebSheet>
       
        </Ctl:Layer> 
    </div>
</asp:content>