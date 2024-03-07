<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSMHome.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSMHome" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            // PageLoad시 이벤트 정의부분

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            ht["PageSize"] = "5";

            grid1.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid1.BindList(1);

            var htm = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            htm["PageSize"] = "5";
            GridDoc.Params(htm); // 선언한 파라미터를 그리드에 전달함
            GridDoc.BindList(1);

        }

        function Grid1RowClick(r, c) {
              var row = grid1.GetRow(r);

            var param = row["APP_NUM"];

            fn_OpenPopCustom("../PSM/PSM40/PSM4011.aspx?param=UPT&param1=" + param, 1200, 1000, param);
        }       

        //작업요청서
        function GridDocWorkRowClick(r, c) {
            var row = GridDoc.GetRow(r);

            var param = row["PO_NO"];

            fn_OpenPopCustom("../PSM/PSM40/PSM4011.aspx?param=UPT&param1=" + param, 1200, 1000, param);
        }

        //체크리스트
        function GridDocCheckRowClick(r, c) {
            var row = GridDoc.GetRow(r);

            var param = row["PO_NO"];

            fn_OpenPopCustom("../PSM/PSM40/PSM4011.aspx?param=UPT&param1=" + param, 1200, 1000, param);
        }

        //변경요구서
        function GridDocAskRowClick(r, c) {
            var row = GridDoc.GetRow(r);

            var param = row["PO_NO"];

            fn_OpenPopCustom("../PSM/PSM40/PSM4011.aspx?param=UPT&param1=" + param, 1200, 1000, param);
        }

        //변경검토서
        function GridDocRevRowClick(r, c) {
            var row = GridDoc.GetRow(r);

            var param = row["PO_NO"];

            fn_OpenPopCustom("../PSM/PSM40/PSM4011.aspx?param=UPT&param1=" + param, 1200, 1000, param);
        }

        //안전작업허가서
        function GridDocSafeRowClick(r, c) {
            var row = GridDoc.GetRow(r);

            var param = row["PO_NO"]+ "-" + row["OR_NO"].substr(0,8) + "-" + row["OR_NO"].substr(8,3);

            fn_OpenPopCustom("../PSM/PSM40/PSM4041.aspx?param=UPT&param1=" + param, 1200, 1000, param);            

        }


    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title" style="background-image:url(/Resources/Images/main_img.jpg); background-position:center,top; background-repeat:no-repeat; height:140px; margin:0px; padding:0px;">
        <h4>
            <%--<img src="/Resources/Images/main_img.jpg" width="100%" height="100%" alt="" />--%>
        </h4>

        <%--<div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
        </div>--%>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <!-- 레이아웃 테이블 -->
        <table border="0" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="25%" />
                <col width="10px" />
                <col width="*" />
            </colgroup>
            <tr>
                <td valign="top">
                    <Ctl:Layer ID="layer1" runat="server" Title="공지사항" DefaultHide="False">
                        <table class="table_01" style="width: 100%;">
                            <colgroup>
                                <col width="140" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th>
                                    첫번째 제목
                                </th>
                                <td>
                                    
                                </td>
                            </tr>
                        </table>
                    </Ctl:Layer>
                </td>
                <td></td>
                <td valign="top">
                    <Ctl:Layer ID="layer2" runat="server" Title="작업요청" DefaultHide="False">
                        <Ctl:WebSheet ID="grid1" runat="server" Paging="true" CheckBox="false" Width="100%" UseColumnSort="false" HFixation="false" Fixation="false" Height="300" Title="WebSheet" TypeName="PSM.PSMBiz" MethodName="getWorkOrder" HeaderHeight="20" CellHeight="20">
                            
                            <Ctl:SheetHeader TextField="tColumns1" Description="NO" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="0" runat="server" />
                            <Ctl:SheetHeader TextField="2Columns1" Description="요청번호" Align="center" Colspan="1" RowSpan="2" runat="server" RowIndex="1" ColIndex="1" />
                            <Ctl:SheetHeader TextField="3Columns1" Description="작업내용" Align="center" Colspan="1" RowSpan="2" runat="server" RowIndex="1" ColIndex="2" />
                            <Ctl:SheetHeader TextField="3Columns1" Description="요청" Align="center" Colspan="2" RowSpan="1" runat="server" RowIndex="1" ColIndex="3" />
                            <Ctl:SheetHeader TextField="3Columns1" Description="수신" Align="center" Colspan="2" RowSpan="1" runat="server" RowIndex="1" ColIndex="5" />
                            <Ctl:SheetHeader TextField="3Columns1" Description="작업기간" Align="center" Colspan="1" RowSpan="2" runat="server" RowIndex="1" ColIndex="7" />
                            <Ctl:SheetHeader TextField="3Columns1" Description="상태" Align="center" Colspan="1" RowSpan="2" runat="server" RowIndex="1" ColIndex="8" />

                            <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="NO" Width="50" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="APP_NUM" TextField="APP_NUM" Description="요청번호" Width="160" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WOWORKTITLE" TextField="WOWORKTITLE" Description="작업내용" Width="*" Align="left" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WOSOTEAMNM" TextField="WOSOTEAMNM" Description="요청팀" Width="90" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WOAPPORSABUNNM" TextField="WOAPPORSABUNNM" Description="요청자" Width="90" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WORETEAMNM" TextField="WORETEAMNM" Description="수신팀" Width="90" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WOAPPREVSABUNNM" TextField="WOAPPREVSABUNNM" Description="수신자" Width="90" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WOFROMTODATE" TextField="WOFROMTODATE" Description="작업기간" Width="180" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WKSTATUSNM" TextField="WKSTATUSNM" Description="상태" Width="150" Align="center" OnClick="Grid1RowClick" HiddenHeader="false" runat="server" />

                        </Ctl:WebSheet>
                    </Ctl:Layer>
                </td>
            </tr>
            <tr>
                <td colspan="3" valign="top">
                    <Ctl:Layer ID="layer3" runat="server" Title="결재문서" DefaultHide="False">
                        <Ctl:WebSheet ID="GridDoc" runat="server" Paging="true" CheckBox="false" Width="100%" UseColumnSort="false" HFixation="false" Fixation="false" Height="300" Title="WebSheet" TypeName="PSM.PSMBiz" MethodName="getDocWorkOrder">                           

                            <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="NO" Width="60" Align="center"  HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="PO_NO" TextField="PO_NO" Description="요청번호" Width="180" Align="center"  HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="OR_NO" TextField="OR_NO" Description="허가번호" Hidden="true"  Width="0" Align="center"  HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="PO_TITLE" TextField="PO_TITLE" Description="작업내용" Width="*" Align="left"  HiddenHeader="false" runat="server" />                            
                            <Ctl:SheetField DataField="PO_SABUNNM" TextField="PO_SABUNNM" Description="요청자" Width="100" Align="center" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="WORKGUBNNM" TextField="WORKGUBNNM" Description="변경구분" Width="100" Align="center" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="APPWKORDER_IMG" TextField="APPWKORDER_IMG" Description="작업요청" Width="100" Align="center"  OnClick="GridDocWorkRowClick" HiddenHeader="false" runat="server" />                            
                            <Ctl:SheetField DataField="APPCHECKLIST_IMG" TextField="APPCHECKLIST_IMG" Description="체크리스트" Width="100" Align="center" OnClick="GridDocCheckRowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="APPCHANGASK_IMG" TextField="APPCHANGASK_IMG" Description="변경요구서" Width="100" Align="center" OnClick="GridDocAskRowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="APPCHANGREV_IMG" TextField="APPCHANGREV_IMG" Description="변경검토서" Width="100" Align="center" OnClick="GridDocRevRowClick" HiddenHeader="false" runat="server" />
                            <Ctl:SheetField DataField="APPSAFE_IMG" TextField="APPSAFE_IMG" Description="안전작업허가서" Width="100" Align="center" OnClick="GridDocSafeRowClick" HiddenHeader="false" runat="server" />

                        </Ctl:WebSheet>
                    </Ctl:Layer>
                </td>
            </tr>
        </table>
    </div>
</asp:content>