<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS9000.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSS.CSS9000" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            var today = new Date();
            txtDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)));

            btnSearch_Click();

            // EIS 데이터 SEARCH
            UP_EIS_Search();
        }

        function SetComma(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        function btnSearch_Click()
        {
            if (txtDate.GetValue() == "")
            {
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

            // EIS 데이터 SEARCH
            UP_EIS_Search();

        }

        function btnExcel_Click() {

            if (txtDate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }

        function btnPrint_Click()
        {
            if (txtDate.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSS9000_RPT&Date=" + txtDate.GetValue(), 500, 500);
        }

        function UP_EIS_Search() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            var JUNWOLYYMM = '';
            var iYear = 0;
            var iMonth = 0;

            iYear = parseInt(txtDate.GetValue().substr(0, 4));
            iMonth = parseInt(txtDate.GetValue().substr(4, 2)) - 1;

            if (iMonth == 0) {

                iYear = iYear - 1;

                iMonth = 12;
            }

            txtJUNWOLDATE.SetValue("[" + iYear + "년 " + Set_Fill(iMonth.toString()) + "월 실적]");

            JUNWOLYYMM = iYear.toString() + Set_Fill(iMonth.toString());

            ht["P_JUNYYMM"] = JUNWOLYYMM.toString();

            PageMethods.InvokeServiceTable(ht, "CSS.CSSBiz", "UP_CSS9000_EIS_SEARCH", function (e) {

                var DataSet = eval(e);

                for (var i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                    if (i == 0) {
                        txtMON_PN.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[0]["AMPLANQTY"])));
                        txtMON_US.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[0]["AMRESULTQTY"])));
                        txtMON_YUL.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[0]["AMACHRATE"])));
                    }
                    else if (i == 1) {
                        txtANNU_PN.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[1]["AMPLANQTY"])));
                        txtANNU_US.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[1]["AMRESULTQTY"])));
                        txtANNU_YUL.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[1]["AMACHRATE"])));
                    }
                    else if (i == 2) {
                        txtYEAR_PN.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[2]["AMPLANQTY"])));
                        txtYEAR_US.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[2]["AMRESULTQTY"])));
                        txtYEAR_YUL.SetValue(SetComma(parseFloat(DataSet.Tables[0].Rows[2]["AMACHRATE"])));
                    }
                }

            }, function (e) {

            });
        }

        function Set_Fill(iMonth) {

            var sMonth = '';

            if (iMonth.toString().length == 1) {

                sMonth = "0" + iMonth.toString();
            }
            else {
                sMonth = iMonth.toString();
            }

            return sMonth;
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody" OnLoad="OnLoad();">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="모선 스케줄 조회" DefaultHide="False" LangCode="layer1" Description="모선 스케줄 조회">
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
            <table class="table_01" style="width:500px; margin-left : 5px;" border="0">
                <colgroup>
                    <col style="width:125px;" />
                    <col style="width:125px;" />
                    <col style="width:125px;" />
                    <col style="width:125px;" />
                </colgroup>
                <tr>
                    <td colspan="4" border = "0">
                        <Ctl:Text ID="txtJUNWOLDATE" runat="server" style="text-align:center;" forecolor="red" LangCode="txtJUNWOLDATE" Description=""></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left">구 분</td>
                    <td style="text-align:right">계 획</td>
                    <td style="text-align:right">실 적</td>
                    <td style="text-align:right">달성율</td>
                </tr>
                <tr>
                    <td style="text-align:left">월 계</td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtMON_PN" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtMON_US" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtMON_YUL" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left">누 계</td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtANNU_PN" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtANNU_US" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtANNU_YUL" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left">년 간</td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtYEAR_PN" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtYEAR_US" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                    <td style="text-align:right">
                        <Ctl:TextBox ID="txtYEAR_YUL" style="width:100%;text-align:right" readonly="true" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
            </table>
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" Height="515" CheckBox="false" Width="100%" TypeName="CSS.CSSBiz" MethodName="UP_CSS9000_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" OnLoaded="OnLoad();">                            
                <Ctl:SheetField DataField="SHCOMPANY"   TextField="SHCOMPANY"   Description="구분"     Width="50"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHVESSEL"    TextField="SHVESSEL"    Description="모선명"   Width="150"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SKDESC"      TextField="SKDESC"      Description="협회"     Width="100"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="GKDESC"      TextField="GKDESC"      Description="곡종"     Width="100"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="WNDESC"      TextField="WNDESC"      Description="원산지"   Width="100"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHETAULSAN"  TextField="SHETAULSAN"  Description="울산"     Width="50"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHULSANQTY"  TextField="SHULSANQTY"  Description="B/L량"    Width="90"   HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="SHETABUSAN"  TextField="SHETABUSAN"  Description="부산"     Width="50"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHBUSANQTY"  TextField="SHBUSANQTY"  Description="B/L량"    Width="90"   HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="SHETAINCHE"  TextField="SHETAINCHE"  Description="평택"     Width="50"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHINCHEQTY"  TextField="SHINCHEQTY"  Description="B/L량"    Width="90"   HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="BL_TOTQTY"   TextField="BL_TOTQTY"   Description="총B/L량"  Width="90"   HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="SHMONTHQTY"  TextField="SHMONTHQTY"  Description="월누계량" Width="90"   HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="SHANNUALQTY" TextField="SHANNUALQTY" Description="년누계량" Width="90"   HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="SHHWDATE"    TextField="SHHWDATE"    Description="접안년월" Width="80"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHETBDATE"   TextField="SHETBDATE"   Description="접안일자" Width="90"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHETCD"      TextField="SHETCD"      Description="작업기간" Width="100"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="BRDESC"      TextField="BRDESC"      Description="대리점"   Width="110"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="SHREMARK"    TextField="SHREMARK"    Description="비고"     Width="100"  HAlign="left"  Align="left"  runat="server" />
                <%--<Ctl:SheetField DataField="COLOR"       TextField="COLOR"       Description="COLOR"    Width="100"  HAlign="left" Align="left" runat="server" />--%>
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>