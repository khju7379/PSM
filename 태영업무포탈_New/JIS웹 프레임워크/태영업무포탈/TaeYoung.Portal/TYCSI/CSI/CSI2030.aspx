<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI2030.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI2030" %>

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
            ht["IPHWAJU"] = HwajuCode;
            ht["MDATE"] = txtFRDate.GetValue();

            gridLeft.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridLeft.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function gridLeftClick(r, c) {
            var dr = gridLeft.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["MCDATE"] = dr["MCDATE"].replace('-', '').replace('-', '');
            ht["MCHWAJU"] = dr["MCHWAJU"];
            ht["MCHWAMUL"] = dr["MCHWAMUL"];

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩            
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="보관취급료 매출 조회" DefaultHide="False" LangCode="layer1" Description="보관취급료 매출 조회">
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

         <Ctl:WebSheet ID="gridLeft" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="650" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI2030_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            <Ctl:SheetField DataField="MCDATE" TextField="MCDATE" Description="매출일자" Width="150" HAlign="center" Align="center" runat="server"  AutoMerge="true" />     
                            <Ctl:SheetField DataField="MCHWAJU" TextField="MCHWAJU" Description="화   주" Width="150" Hidden="true" HAlign="center" Align="left" runat="server"  AutoMerge="true" />                                   
                            <Ctl:SheetField DataField="HMCDDESC1" TextField="HMCDDESC1" Description="화물명" Width="230"  HAlign="center" Align="left" runat="server"  AutoMerge="true" />
                            <Ctl:SheetField DataField="MCHAP" TextField="MCHAP" Description="매출합계" DataType="Number"  Width="230" HAlign="right" Align="right" runat="server"  AutoMerge="true" />                                                                        
                            <Ctl:SheetField DataField="MCHWAMUL" TextField="MCHWAMUL" Description="화   물" Width="150" Hidden="true"  HAlign="center" Align="left" runat="server"  AutoMerge="true" />       

                            <Ctl:SheetField DataField="MCTANKNO" TextField="MCTANKNO" Description="탱크번호" Width="130" HAlign="center" Align="center" runat="server" />       
                            <Ctl:SheetField DataField="MCREQGB" TextField="MCREQGB" Description="청구구분" Width="90"  HAlign="center" Align="center" runat="server" />                                                 
                            <Ctl:SheetField DataField="MCENBOAMT" TextField="MCENBOAMT" Description="보관료" DataType="Number"  Width="210" HAlign="right" Align="right" runat="server" />                                                                        
                            <Ctl:SheetField DataField="HANDAMT" TextField="HANDAMT" Description="취급료" DataType="Number"  Width="210" HAlign="right" Align="right" runat="server" />                                                                        
                            <Ctl:SheetField DataField="OVERTIMEAMT" TextField="OVERTIMEAMT" Description="할증료" DataType="Number"  Width="210" HAlign="right" Align="right" runat="server" />                                                                        
                            <Ctl:SheetField DataField="ETCAMT" TextField="ETCAMT" Description="기타금액" DataType="Number"  Width="210" HAlign="right" Align="right" runat="server" />                                                                        
         </Ctl:WebSheet>            
       
        </Ctl:Layer> 
    </div>
</asp:content>