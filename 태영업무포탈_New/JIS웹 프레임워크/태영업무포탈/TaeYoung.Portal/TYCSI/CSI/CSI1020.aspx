<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI1020.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI1020" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

           
        }

        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";
            ht["IPHWAJU"] = HwajuCode;           

            ht["SDATE"] = txtFRDate.GetValue();
            ht["EDATE"] = txtTODate.GetValue();
            ht["GUBUN"] = "S";
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

//            gridIndex.CallBack = function () {
//                // 디자인 보정 코드
//                $("#gridIndex_main_ScrollDiv").width(350);
//            }

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

        function btnPrint_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=CSI1020_RPT&Date_Fr=" + txtFRDate.GetValue() + "&Date_To=" + txtTODate.GetValue(), 500, 500);           
        }

        function btnExcel_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="입고화물별 출고조회" DefaultHide="False" LangCode="layer1" Description="입고화물별 출고조회">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                   <th>
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="조회일자(Fr~To)"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtFRDate"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                        <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnPrint" runat="server" LangCode="btnPrint" Description="출력" OnClientClick="btnPrint_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>                     
                    </td>
                </tr>
            </table>        
        </div>
       <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="650" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI1020_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
            <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화물명" Width="130"  HAlign="center" Align="left" runat="server" AutoMerge="true"/>
            <Ctl:SheetField DataField="CHCHULIL" TextField="CHCHULIL" Description="출고일자" Width="100" HAlign="center" Align="left" runat="server" AutoMerge="true"/>                            
            <Ctl:SheetField DataField="CHDESC1" TextField="CHDESC1" Description="출고화주" Width="120" HAlign="center" Align="left" runat="server" AutoMerge="true"/>    
                                                    
            <Ctl:SheetField DataField="CHIPHANG" TextField="CHIPHANG" Description="입항일자" Width="100" HAlign="center" Align="left" runat="server" AutoMerge="true" />                            
            <Ctl:SheetField DataField="VSDESC1" TextField="VSDESC1" Description="본  선" Width="150" HAlign="center" Align="left" runat="server" AutoMerge="true" />                            
            <Ctl:SheetField DataField="ACDESC1" TextField="ACDESC1" Description="통관화주" Width="120" HAlign="center" Align="left" runat="server" AutoMerge="true" />                            
            <Ctl:SheetField DataField="CHBLNO" TextField="CHBLNO" Description="B/L NO" Width="150" HAlign="center" Align="left" runat="server" AutoMerge="true" />                            
            <Ctl:SheetField DataField="MSHSNSEQ" TextField="MSHSNSEQ" Description="MSN/HSN" Width="100" HAlign="center" Align="left" runat="server" AutoMerge="true"/>     
            <Ctl:SheetField DataField="CHMTQTY" TextField="CHMTQTY" Description="출고량" DataType="Number"  Width="85" HAlign="right" Align="right" runat="server" />                                                 
            <Ctl:SheetField DataField="CHCHTIME" TextField="CHCHTIME" Description="출고시간" Width="100" HAlign="center" Align="left" runat="server" />                            
            <Ctl:SheetField DataField="CHOVTIME" TextField="CHOVTIME" Description="할증시간" Width="100" HAlign="center" Align="left" runat="server" />                            
            <Ctl:SheetField DataField="CHNUMBER" TextField="CHNUMBER" Description="차량번호" Width="120" HAlign="center" Align="left" runat="server" />                            
            <Ctl:SheetField DataField="CHTEMP" TextField="CHTEMP" Description="비   고" Width="295" HAlign="center" Align="left" runat="server" />                            

       </Ctl:WebSheet>      
                            
            
        </Ctl:Layer> 
    </div>
</asp:content>