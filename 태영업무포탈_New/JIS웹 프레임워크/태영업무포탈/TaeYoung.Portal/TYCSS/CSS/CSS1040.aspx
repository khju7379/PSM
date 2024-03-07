<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS1040.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSS.CSS1040" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

           
        }

        function btnSearch_Click() {

            if (txtDate_From.GetValue() == "" || txtDate_To.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 15;
            ht["SearchCondition"]  = "";

            ht["SDATE"] = txtDate_From.GetValue();
            ht["EDATE"] = txtDate_To.GetValue();
            ht["HWAJU"] = HwajuCode;
            ht["GUBUN"] = "S";
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function btnExcel_Click() {

            if (txtDate_From.GetValue() == "" || txtDate_To.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }

        function btnPrint_Click() {

            if (txtDate_From.GetValue() == "" || txtDate_To.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSS1040_RPT&Date_Fr=" + txtDate_From.GetValue() + "&Date_To=" + txtDate_To.GetValue(), 500, 500);
        }        

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="모선별 조체선 조회" DefaultHide="False" LangCode="layer1" Description="모선별 조체선 조회">
            <div class="btn_bx">        
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="110px" />
                        <col width="200px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                       <th style="text-align: center;">
                            <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="기준일자"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtDate_From" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                            <Ctl:TextBox ID="txtDate_To"   runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
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
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" Height="650" CheckBox="false" Width="100%" TypeName="CSS.CSSBiz" MethodName="UP_CSS1040_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >                            
                <Ctl:SheetField DataField="IHIPHANG"  TextField="IHIPHANG"  Description="입항일자"   Width="100"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="LTHANGCHA" TextField="LTHANGCHA" Description="항    차"   Width="100"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="VSDESC1"   TextField="VSDESC1"   Description="모 선 명"   Width="250"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="SKDESC1"   TextField="SKDESC1"   Description="화    주"   Width="250"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="GKDESC1"   TextField="GKDESC1"   Description="곡    종"   Width="250"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="LTSAVE"    TextField="LTSAVE"    Description="조체선시간" Width="250"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="LTBLQTY"   TextField="LTBLQTY"   Description="배 정 량"   Width="150"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="LTTOTSAVE" TextField="LTTOTSAVE" Description="금    액"   Width="150"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="LTGUBUN"   TextField="LTGUBUN"   Description="구    분"   Width="170"  HAlign="left"  Align="left"  runat="server"  />
            </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>