<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSG1030.aspx.cs" Inherits="TaeYoung.Portal.TGCSI.CSI.CSG1030" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad()
        {
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

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSG1030_RPT&Date=" + txtDate.GetValue(), 500, 500);           
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="모선별 재고 조회" DefaultHide="False" LangCode="layer1" Description="모선별 재고 조회">
        <div class="btn_bx">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="110px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                   <th style="text-align: center;">
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="재고일자"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" CalendarGroup="GRP01"></Ctl:TextBox>
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
        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" Height="600" CheckBox="false" Width="100%" TypeName="CSG.CSGBiz" MethodName="UP_CSG1030_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >                            
            <Ctl:SheetField DataField="JGDATE"    TextField="JGDATE"    Description="일자"     Width="50"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
            <Ctl:SheetField DataField="COMPANY"    TextField="COMPNAY"    Description="하역회사"     Width="135"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
            <Ctl:SheetField DataField="IHIPHANG"   TextField="IHIPHANG"   Description="입항일자"     Width="90"   HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
            <Ctl:SheetField DataField="VSDESC1"    TextField="VSDESC1"    Description="모선"         Width="155"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
            <Ctl:SheetField DataField="GKDESC1"    TextField="GKDESC1"    Description="곡종"         Width="150"  HAlign="left"  Align="left"  runat="server" />
            <Ctl:SheetField DataField="IPIPSTDAT"  TextField="IPIPSTDAT"  Description="보관료초일"   Width="90"   HAlign="left"  Align="left"  runat="server" />
            <Ctl:SheetField DataField="HAPBAE"     TextField="HAPBAE"     Description="배정량"       Width="95"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPHWAK"    TextField="HAPHWAK"    Description="확정량"       Width="95"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPCS"      TextField="HAPCS"      Description="통관량"       Width="95"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPCHUL"    TextField="HAPCHUL"    Description="출고량"       Width="95"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPJEGO"    TextField="HAPJEGO"    Description="자가재고"     Width="100"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPYD"      TextField="HAPYD"      Description="양도량"       Width="95"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPYS"      TextField="HAPYS"      Description="양수량"       Width="95"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPYSYD"    TextField="HAPYSYD"    Description="양수양도"     Width="100"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPYSCH"    TextField="HAPYSCH"    Description="양수출고"     Width="95"  HAlign="right" Align="right" runat="server" DataType="number" />
            <Ctl:SheetField DataField="HAPJAE"     TextField="HAPJAE"     Description="전체재고"     Width="100"  HAlign="right" Align="right" runat="server" DataType="number" />
        </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>