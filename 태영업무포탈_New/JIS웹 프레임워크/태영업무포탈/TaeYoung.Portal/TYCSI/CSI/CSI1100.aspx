<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI1100.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI1100" %>

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
            ht["SearchCondition"] = "";
            ht["IPHWAJU"] = HwajuCode;           

            ht["SDATE"] = txtFRDate.GetValue();
            ht["EDATE"] = txtTODate.GetValue();
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
        <Ctl:Layer ID="layer1" runat="server" Title="양수도 조회" DefaultHide="False" LangCode="layer1" Description="양수도 조회">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
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
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>                     
                    </td>
                </tr>
            </table>        
        </div>
        <table style="width: 100%;">
                <colgroup>
                    <col width="10%" />
                    <col width="*" />
                </colgroup>               
                <tr>
                    <td  valign="top">
                        
                         <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true"  Height="640" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI1100_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                            <Ctl:SheetField DataField="YNIPHANG" TextField="YNIPHANG" Description="입항일자" Width="90" HAlign="center" Align="left" runat="server"  />                            
                            <Ctl:SheetField DataField="VSDESC1" TextField="VSDESC1" Description="본  선" Width="130" HAlign="center" Align="left" runat="server"  />                            
                            <Ctl:SheetField DataField="VEND" TextField="VEND" Description="입고화주" Width="130" HAlign="center" Align="left" runat="server"  />                            
                            <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화물명" Width="120"  HAlign="center" Align="left" runat="server"   />

                            <Ctl:SheetField DataField="YNBLNO" TextField="YNBLNO" Description="B/L NO" Width="110" HAlign="left" Align="left" runat="server" />                            
                            <Ctl:SheetField DataField="MSHSNSEQ" TextField="MSHSNSEQ" Description="MSN/HSN" Width="90" HAlign="center" Align="center" runat="server" />                                   
                            <Ctl:SheetField DataField="YNCUSTIL" TextField="YNCUSTIL" Description="통관일자/차수" Width="120" HAlign="center" Align="left" runat="server" />                     
                            <Ctl:SheetField DataField="ACVEND" TextField="ACVEND" Description="통관화주" Width="140" HAlign="center" Align="left" runat="server" />                                                               
                            <Ctl:SheetField DataField="YDVEND" TextField="YDVEND" Description="양도화주" Width="140" HAlign="center" Align="left" runat="server" />                                                               
                            <Ctl:SheetField DataField="YSVEND" TextField="YSVEND" Description="양수화주" Width="140" HAlign="center" Align="left" runat="server" />                            
                            <Ctl:SheetField DataField="YNYSDATE" TextField="YNYSDATE" Description="양수일자" Width="100" HAlign="center" Align="left" runat="server" />                            
                            <Ctl:SheetField DataField="CJYSQTY" TextField="CJYSQTY" Description="양수량" DataType="Number"  Width="90" HAlign="right" Align="right" runat="server" />                                                                             
                            <Ctl:SheetField DataField="CJYDQTY" TextField="CJYDQTY" Description="양도량" DataType="Number"  Width="90" HAlign="right" Align="right" runat="server" />                                                                             
                            <Ctl:SheetField DataField="YNYSCHQTY" TextField="YNYSCHQTY" Description="출고량" DataType="Number"  Width="90" HAlign="right" Align="right" runat="server" />                                                                             
                            <Ctl:SheetField DataField="JEGOQTY" TextField="JEGOQTY" Description="재고량" DataType="Number"  Width="90" HAlign="right" Align="right" runat="server" />                                                                             
                        </Ctl:WebSheet>
                        
                    </td>                   
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>