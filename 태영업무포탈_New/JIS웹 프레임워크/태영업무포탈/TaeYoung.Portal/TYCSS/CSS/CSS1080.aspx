<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS1080.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSS.CSS1080" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

           
        }

        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 15;
            ht["SearchCondition"]  = "";

            ht["SDATE"]            = txtFRDate.GetValue();
            ht["EDATE"]            = txtTODate.GetValue();
            ht["HWAJU"]            = HwajuCode;
            ht["GUBUN"]            = "S";
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function btnExcel_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }

        function btnPrint_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSS1080_RPT&Date_Fr=" + txtFRDate.GetValue() + "&Date_To=" + txtTODate.GetValue(), 500, 500);
        }        

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="일자별 출고 조회" DefaultHide="False" LangCode="layer1" Description="일자별 출고 조회">
            <div class="btn_bx">        
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="110px" />
                        <col width="200px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                       <th style="text-align: center;">
                            <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="출고일자"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                            <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                        </td>
                        <td>
                          <!-- 상단의 버튼을 정의 -->
                         <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                         <Ctl:Button ID="btnPrint" runat="server" LangCode="btnPrint" Description="출력" OnClientClick="btnPrint_Click();"></Ctl:Button>
                         <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>
                        </td>
                    </tr>
                </table>
            </div>
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" Height="650" CheckBox="false" Width="100%" TypeName="CSS.CSSBiz" MethodName="UP_CSS1080_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                <Ctl:SheetField DataField="GKDESC1"    TextField="GKDESC1"    Description="곡종"         Width="170"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="VSDESC1"    TextField="VSDESC1"    Description="모선"         Width="200"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="CHBLNO"     TextField="CHBLNO"     Description="B/L번호"      Width="200"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="CHCHULDAT"  TextField="CHCHULDAT"  Description="출고일자"     Width="100"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="CHTKNO"     TextField="CHTKNO"     Description="전표"         Width="100"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHCUSTIL"   TextField="CHCUSTIL"   Description="통관일자"     Width="100"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHSEQ"      TextField="CHSEQ"      Description="차수"         Width="85"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHEMPTY"    TextField="CHEMPTY"    Description="공차"         Width="100"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="CHTOTAL"    TextField="CHTOTAL"    Description="실차"         Width="100"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="CHMTQTY"    TextField="CHMTQTY"    Description="실중량"       Width="100"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="CHTIME"     TextField="CHTIME"     Description="입출문시간"   Width="125"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHNUMBER"   TextField="CHNUMBER"   Description="차량"         Width="105"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="HJDESC1"    TextField="HJDESC1"    Description="양도화주"     Width="185"  HAlign="left"  Align="left"  runat="server" />
            </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>