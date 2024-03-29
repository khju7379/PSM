﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI1080.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI1080" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

           
        }

        function btnSearch_Click() {
            

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";
            ht["IPHWAJU"] = HwajuCode;           
            ht["GUBUN"] = "S";
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function btnPrint_Click() {

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSI1080_RPT", 500, 500);           
        }

        function btnExcel_Click() {

            gridIndex.ExcelDownload("EXCEL.xls");
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="통관화물별 DRUM 재고조회" DefaultHide="False" LangCode="layer1" Description="통관화물별 DRUM 재고조회">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="*" />
                </colgroup>
                <tr>                    
                    <td colspan="3" >
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnPrint" runat="server" LangCode="btnPrint" Description="출력" OnClientClick="btnPrint_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button> 
                    </td>
                </tr>
            </table>        
        </div>
         <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="650" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI1080_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화물명" Width="250"  HAlign="center" Align="left" runat="server"  />                            
                <Ctl:SheetField DataField="DJIPHANG" TextField="DJIPHANG" Description="입항일자" Width="150" HAlign="center" Align="left" runat="server"  />                            
                <Ctl:SheetField DataField="VSDESC1" TextField="VSDESC1" Description="본  선" Width="250" HAlign="center" Align="left" runat="server"  />     
                                                                               
                <Ctl:SheetField DataField="DJBLNO" TextField="DJBLNO" Description="B/L NO" Width="220" HAlign="left" Align="left" runat="server" />                            
                <Ctl:SheetField DataField="DJMSNSEQ" TextField="DJMSNSEQ" Description="MSN" Width="110" HAlign="center" Align="center" runat="server" />       
                <Ctl:SheetField DataField="DJHSNSEQ" TextField="DJHSNSEQ" Description="HSN" Width="110" HAlign="center" Align="center" runat="server" />       
                <Ctl:SheetField DataField="DJJUNG" TextField="DJJUNG" Description="중 량"   Width="110" HAlign="right" Align="right" runat="server" />                                                                             
                <Ctl:SheetField DataField="DJPOQTY" TextField="DJPOQTY" Description="포장량" DataType="Number"  Width="150" HAlign="right" Align="right" runat="server" />                                                                             
                <Ctl:SheetField DataField="DJCHQTY" TextField="DJCHQTY" Description="출고량" DataType="Number"  Width="150" HAlign="right" Align="right" runat="server" />                                                                             
                <Ctl:SheetField DataField="DJJEQTY" TextField="DJJEQTY" Description="재고량" DataType="Number"  Width="170" HAlign="right" Align="right" runat="server" />                                                                             
            </Ctl:WebSheet>
       
        </Ctl:Layer> 
    </div>
</asp:content>