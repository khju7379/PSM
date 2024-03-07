<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS1020.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSS.CSS1020" %>

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
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="날짜를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";

            ht["DATE"] = txtDate.GetValue();
            ht["GUBUN"] = "S";
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

//            gridIndex.CallBack = function () {
//                // 편집 이벤트 제거
//                // id+row번호+cell번호 : gridCodeList_0_1
//                var pono;
//                var dt = gridIndex.GetAllRow();
//                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

//                    var dr = dt.Rows[i];

//                    if (dr["GUBN"] == 'B') {
//                        // window.alert(dr["GUBN"]);
//                        pono = dr["CHDESC1"];
//                        //gridIndex.SetValue(i, "CHDESC1", "<td> <font font-weight: bold>" + pono + "</font><br></td> ");
//                        //gridIndex.SetValue(i, "CHDESC1", "<td style=\"background-color:#e9eff8; font-size:15px;\">" + pono + "</td> ");
//                        //gridIndex_MainRow_8
//                        $("#gridIndex_MainRow_" + i).css("background-color", "#FF6347"); // 현재 color
//                        $("#gridIndex_MainRow_" + i).attr("orgbgcolor", "#FF6347"); // default color

//                    }
//                    else {
//                        gridIndex.SetValue(i, "CHDESC1", pono);
//                    }

//                }
//            }


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

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSS1020_RPT&Date=" + txtDate.GetValue(), 500, 500);           
        }        

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
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
                            <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="기준일자"></Ctl:Text>
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
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation="true" Height="650" CheckBox="false" Width="100%" TypeName="CSS.CSSBiz" MethodName="UP_CSS1020_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >                            
                <Ctl:SheetField DataField="SHVSNAME" TextField="SHVSNAME" Description="모선명"       Width="250"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="SKDESC1"  TextField="SKDESC1"  Description="협회"         Width="200"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="GKDESC1"  TextField="GKDESC1"  Description="곡종"         Width="210"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="WNDESC1"  TextField="WNDESC1"  Description="원산지"       Width="200"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="SHJUBDAT" TextField="SHJUBDAT" Description="입항일자"     Width="100"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="SHBLQTY"  TextField="SHBLQTY"  Description="B/L량"        Width="150"  HAlign="right" Align="right" runat="server" DataType="number" />
                <Ctl:SheetField DataField="SHIHSDAT" TextField="SHIHSDAT" Description="하역예상기간" Width="250"  HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="SHAGENT"  TextField="SHAGENT"  Description="선사"         Width="80"   HAlign="left"  Align="left"  runat="server"  />
                <Ctl:SheetField DataField="SHICANNY" TextField="SHICANNY" Description="비고"         Width="230"  HAlign="left"  Align="left"  runat="server"  />
            </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>