<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS2050.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSS.CSS2050" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {
            var today = new Date();
            txtDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)));
        }

        function btnSearch_Click() {

            if (txtDate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 15;
            ht["SearchCondition"]  = "";

            ht["DATE"]             = txtDate.GetValue();
            ht["HWAJU"]            = HwajuCode;
            ht["GUBUN"]            = "S";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function btnExcel_Click() {

            if (txtDate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }

        function btnPrint_Click() {

            if (txtDate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSS2050_RPT&Date=" + txtDate.GetValue(), 500, 500);
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="화물료 매출 조회" DefaultHide="False" LangCode="layer1" Description="화물료 매출 조회">
            <div class="btn_bx">
                <table class="table_01" style="width: 100%;">
                    <colgroup>
                        <col width="110px" />
                        <col width="100px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                       <th style="text-align: center;">
                            <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="조회년월"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar" CalendarGroup="GRP01"></Ctl:TextBox>
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
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" Height="650" CheckBox="false" TypeName="CSS.CSSBiz" MethodName="UP_CSS2050_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                <Ctl:SheetField DataField="HMMCYYMM"     TextField="HMMCYYMM"   Description="매출일자"   Width="120"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="IPHANG"       TextField="IPHANG"     Description="입항일자"   Width="120"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="VSDESC1"      TextField="VSDESC1"    Description="모 선 명"   Width="270"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="GKDESC1"      TextField="GKDESC1"    Description="곡    종"   Width="270"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="HMBEJNQTY"    TextField="HMBEJNQTY"  Description="배 정 량"   Width="210"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="CNHMAMT"      TextField="CNHMAMT"    Description="요    율"   Width="130"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="HMHAMULAMT"   TextField="HMHAMULAMT" Description="공급가액"   Width="170"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="HMHAMULVAT"   TextField="HMHAMULVAT" Description="부가세액"   Width="170"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="TOTAMT"       TextField="TOTAMT"     Description="합    계"   Width="210"  HAlign="right" Align="right" runat="server" DataType="number" />
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>