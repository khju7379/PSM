<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSG1020.aspx.cs" Inherits="TaeYoung.Portal.TGCSI.CSI.CSG1020" %>

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

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            var dr = gridIndex.GetRow(r);

            txtIHHANGCHA.SetValue(dr["IHHANGCHA"]);
            txtVSDESC1.SetValue(dr["VSDESC1"]);
            txtIHIPHANG.SetValue(dr["IHIPHANG"]);
            txtIPGOKJONG.SetValue(dr["IPGOKJONG"]);
            txtGKDESC1.SetValue(dr["GKDESC1"]);
            txtIHJAKENDAT.SetValue(dr["IHJAKENDAT"]);
            txtSKDESC1.SetValue(dr["SKDESC1"]);
            txtIPIPSTDAT.SetValue(dr["IPIPSTDAT"]);
            txtWNDESC1.SetValue(dr["WNDESC1"]);
            txtIHJUKHANO.SetValue(dr["IHJUKHANO"]);

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 15;
            ht["SearchCondition"]  = "";
            ht["COMPANY"]          = dr["COMPANY"];
            ht["HANGCHA"]          = dr["IHHANGCHA"];
            ht["GOKJONG"]          = dr["IPGOKJONG"];
            ht["HWAJU"]            = HwajuCode;

            gridDetail.Params(ht);  // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
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

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSG1020_RPT&Date_Fr=" + txtFRDate.GetValue() + "&Date_To=" + txtTODate.GetValue(), 500, 500);
        }     
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="감량확정 모선조회" DefaultHide="False" LangCode="layer1" Description="감량확정 모선조회">
            <div class="btn_bx">
                <table class="table_01" style="width: 100%;">
                    <colgroup>
                        <col width="110px" />
                        <col width="200px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                       <th style="text-align: center;">
                            <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="입항년월 (Fr~To)" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                            <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
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
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" CheckBox="false" height="650" TypeName="CSG.CSGBiz" MethodName="UP_CSG1020_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                <Ctl:SheetField DataField="COMPANY"    TextField="COMPANY"    Description="하역회사"   Width="135"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="IHHANGCHA"  TextField="IHHANGCHA"  Description="모선"       Width="85"   HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="VSDESC1"    TextField="VSDESC1"    Description="모선명"     Width="190"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="IHIPHANG"   TextField="IHIPHANG"   Description="입항일자"   Width="110"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="IHJAKENDAT" TextField="IHJAKENDAT" Description="작업종료일" Width="110"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="SKDESC1"    TextField="SKDESC1"    Description="협회"       Width="150"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="WNDESC1"    TextField="WNDESC1"    Description="원산지"     Width="150"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="IHJUKHANO"  TextField="IHJUKHANO"  Description="적하목록"   Width="120"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="IPGOKJONG"  TextField="IPGOKJONG"  Description="곡종"       Width="85"   HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="GKDESC1"    TextField="GKDESC1"    Description="곡종명"     Width="175"  HAlign="left"  Align="left"   runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="JBBEJNQTY"  TextField="JBBEJNQTY"  Description="배정량"     Width="120"  HAlign="right" Align="right"  runat="server" DataType="number" />
                <Ctl:SheetField DataField="JBHWAKQTY"  TextField="JBHWAKQTY"  Description="인증량"     Width="120"  HAlign="right" Align="right"  runat="server" DataType="number" />
                <Ctl:SheetField DataField="GAMQTY"     TextField="GAMQTY"     Description="감  량"     Width="120"  HAlign="right" Align="right"  runat="server" DataType="number" />
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>