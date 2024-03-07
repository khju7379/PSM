<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS1010.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSS.CSS1010" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";        

        function OnLoad() {


        }

        function SetComma(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        function Grid1RowClick(r, c) {

            var dr = gridIndex.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";
            ht["HANGCHA"] = dr["IHHANGCHA"];

            PageMethods.InvokeServiceTable(ht, "CSS.CSSBiz", "UP_CSS1010_GETTEXT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    ht["CurrentPageIndex"] = 1;
                    ht["PageSize"] = 15;
                    ht["SearchCondition"] = "";
                    ht["HANGCHA"] = DataSet.Tables[0].Rows[0]["IHHANGCHA"];
                    ht["GOKJONG"] = DataSet.Tables[0].Rows[0]["IHGOKJONG1"];


                    gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
                    gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";
            ht["HWAJU"] = HwajuCode;
            ht["SDATE"] = txtFRDate.GetValue();
            ht["EDATE"] = txtTODate.GetValue();

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

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSS1010_RPT&Date_Fr=" + txtFRDate.GetValue() + "&Date_To=" + txtTODate.GetValue(), 500, 500);
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="항차모선 및 하역작업 조회" DefaultHide="False" LangCode="layer1" Description="항차모선 및 하역작업 조회">
            <div class="btn_bx">
                <table class="table_01" style="width: 100%;">
                    <colgroup>
                        <col width="110px" />
                        <col width="200px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                       <th style="text-align: center;">
                            <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="조회일자 (Fr~To)" ></Ctl:Text>
                        </th>
                        <td >
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
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" CheckBox="false" height="650" TypeName="CSS.CSSBiz" MethodName="UP_CSS1010_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                <Ctl:SheetField DataField="IHHANGCHA"   TextField="IHHANGCHA" Description="항차"     Width="150"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="VSDESC1"     TextField="VSDESC1"   Description="모선"     Width="300"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="IHIPHANG"    TextField="IHIPHANG"  Description="입항일자" Width="150"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="GKDESC1"     TextField="GKDESC1"   Description="곡종"     Width="300"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="SKDESC1"     TextField="SKDESC1"   Description="소속협회" Width="300"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="IHBLQTY1"    TextField="IHBLQTY1"  Description="B/L량"    Width="150"  HAlign="right" Align="right" runat="server" AutoMerge="true" DataType="number" />
                <Ctl:SheetField DataField="IPIPDAT"     TextField="IPIPDAT"   Description="입고일자" Width="150"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="IPIPQTY"     TextField="IPIPQTY"   Description="수량"     Width="170"  HAlign="right" Align="right" runat="server"  DataType="number"/>
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>