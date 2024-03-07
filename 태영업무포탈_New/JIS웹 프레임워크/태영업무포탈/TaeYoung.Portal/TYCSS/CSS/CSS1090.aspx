<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS1090.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSS.CSS1090" %>

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
            ht["YSGUBUN"]          = rdoYSGUBUN.GetValue();
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

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSS1090_RPT&Date_Fr=" + txtFRDate.GetValue() + "&Date_To=" + txtTODate.GetValue() + "&YSGUBUN=" + rdoYSGUBUN.GetValue(), 500, 500);
        }        

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="양수도 조회" DefaultHide="False" LangCode="layer1" Description="양수도 조회">
            <div class="btn_bx">        
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="100px" />
                        <col width="200px" />
                        <col width="120px" />
                        <col width="280px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                       <th style="text-align: center;">
                            <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="양수도일자"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                            <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                        </td>
                        <th style="text-align: center;">
                            <Ctl:Text ID="TXT_txtPRM_POPUP" runat="server" LangCode="TXT_txtPRM_POPUP" Description="양수도구분" />
                        </th>
                        <td>
                            <Ctl:Radio ID="rdoYSGUBUN" runat="server">
                                <asp:ListItem Value=""  Description="전체(ALL)" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="2" Description="양수(Acq)"></asp:ListItem>
                                <asp:ListItem Value="1" Description="양도(Trans)"></asp:ListItem>
                            </Ctl:Radio>
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
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" Height="650" CheckBox="false" Width="100%" TypeName="CSS.CSSBiz" MethodName="UP_CSS1090_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                <Ctl:SheetField DataField="TMHANGCHA"  TextField="TMHANGCHA"  Description="항차"         Width="90"   HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="VSDESC1"    TextField="VSDESC1"    Description="모선"         Width="210"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="GKDESC1"    TextField="GKDESC1"    Description="곡종"         Width="210"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="TMBLNO"     TextField="TMBLNO"     Description="B/L번호"      Width="180"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="TMHMN"      TextField="TMHMN"      Description="입고번호"     Width="150"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="TMCUSTIL"   TextField="TMCUSTIL"   Description="통관일자"     Width="130"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="TMSEQ"      TextField="TMSEQ"      Description="차수"         Width="100"   HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="TMGUBUN"    TextField="TMGUBUN"    Description="구분"         Width="100"   HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="TMYSDATE"   TextField="TMYSDATE"   Description="양수도일"     Width="120"  HAlign="left"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="YSDESC1"    TextField="YSDESC1"    Description="양수도화주"   Width="250"  HAlign="left"  Align="left"  runat="server" AutoMerge="true" />
                <Ctl:SheetField DataField="TMYSQTY"    TextField="TMYSQTY"    Description="수  량"       Width="130"  HAlign="right" Align="right" runat="server" DataType="number" />
            </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>