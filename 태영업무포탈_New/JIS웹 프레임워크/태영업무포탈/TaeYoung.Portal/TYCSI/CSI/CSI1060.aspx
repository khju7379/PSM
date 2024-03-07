<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI1060.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI1060" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {
            var today = new Date();
            txtDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
        }

        function btnSearch_Click() {

            if (txtDate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="재고일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";
            ht["IPHWAJU"] = HwajuCode;

            ht["DATE"] = txtDate.GetValue();
            ht["GUBUN"] = "S";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function btnPrint_Click() {

            if (txtDate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="재고일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSI1060_RPT&Date=" + txtDate.GetValue(), 500, 500);
        }

        function btnExcel_Click() {

            if (txtDate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="재고일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="통관화물별 재고조회" DefaultHide="False" LangCode="layer1" Description="통관화물별 재고조회">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="110px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                   <th>
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="재고일자"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox>
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnPrint" runat="server" LangCode="btnPrint" Description="출력" OnClientClick="btnPrint_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>   
                    </td>
                </tr>
            </table>        
        </div>
         <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="650" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI1060_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                            <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화물명" Width="130"  HAlign="center" Align="left" runat="server"  AutoMerge="true"/>
                            <Ctl:SheetField DataField="IPIPHANG" TextField="IPIPHANG" Description="입항일자" Width="100" HAlign="center" Align="left" runat="server" AutoMerge="true"/>                            
                            <Ctl:SheetField DataField="VSDESC1" TextField="VSDESC1" Description="본  선" Width="140" HAlign="center" Align="left" runat="server"  AutoMerge="true"/>                            
                            <Ctl:SheetField DataField="HJDESC1" TextField="HJDESC1" Description="입고화주" Width="130" HAlign="center" Align="left" runat="server"  AutoMerge="true"/>                            

                            <Ctl:SheetField DataField="IPBLNO" TextField="IPBLNO" Description="B/L번호" Width="200" HAlign="center" Align="left" runat="server" AutoMerge="true"/>
                            <Ctl:SheetField DataField="IPMSNSEQ" TextField="IPMSNSEQ" Description="MSN" Width="60" HAlign="center" Align="center" runat="server" AutoMerge="true"/>                            
                            <Ctl:SheetField DataField="IPHSNSEQ" TextField="IPHSNSEQ" Description="HSN" Width="50" HAlign="center" Align="center" runat="server" AutoMerge="true"/>
                            <Ctl:SheetField DataField="IPMTQTY" TextField="IPMTQTY" Description="입고량" DataType="Number"  Width="140" HAlign="right" Align="right" runat="server" />                                                 
                            <Ctl:SheetField DataField="CSCUQTY" TextField="CSCUQTY" Description="통관량" DataType="Number"  Width="140" HAlign="right" Align="right" runat="server" />                                                 
                            <Ctl:SheetField DataField="CHMTQTY" TextField="CHMTQTY" Description="출고량" DataType="Number"  Width="140" HAlign="right" Align="right" runat="server" />                                                 
                            <Ctl:SheetField DataField="JUNIPMTQTY" TextField="JUNIPMTQTY" Description="B/L분할수량" DataType="Number"  Width="140" HAlign="right" Align="right" runat="server" />                                                 
                            <Ctl:SheetField DataField="REJEGOQTY" TextField="REJEGOQTY" Description="통관재고량" DataType="Number"  Width="140" HAlign="right" Align="right" runat="server" />                                                 
                            <Ctl:SheetField DataField="REPAQTY" TextField="REPAQTY" Description="미통관재고량" DataType="Number"  Width="160" HAlign="right" Align="right" runat="server" />                                                 
                            

                        </Ctl:WebSheet>
        
        </Ctl:Layer> 
    </div>
</asp:content>