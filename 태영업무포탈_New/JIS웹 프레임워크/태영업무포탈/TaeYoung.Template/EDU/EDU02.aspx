<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EDU02.aspx.cs" Inherits="TaeYoung.Template.EDU.EDU02" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            BindList();

        }

        function BindList() {
            // PageLoad시 이벤트 정의부분
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            //ht["PageSize"] = "10";

            grid1.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid1.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // 예외처리
            grid1.CallBack = grid1_Load;
        }

        function grid1_Load() {

            var dt = grid1.GetAllRow();

            for (var i = 0; i < dt.Rows.length; i++) {
                if (dt.Rows[i]["COLUMNS3"] == "2") {
                    //grid1.SetValue(i, "COLUMNS3", "승인");

                    grid1.SetValue(i, "COLUMNS3", "<select><option>1</option></select>");
                }
            }

        }

        function btnSearch_Click() {
            BindList();
        }

        function Grid1RowClick(r,c) {
            var dr = grid1.GetRow(r);

            //alert(dr["IDX"]);

            fn_OpenPop("EDU01.aspx?IDX="+ dr["IDX"], 1024, 768);
        }
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="페이지 제목을 입력하세요" Literal="true"></Ctl:Text></h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="레이어 제목을 입력하세요" DefaultHide="False">
            <Ctl:WebSheet ID="grid1" runat="server" Paging="true" CheckBox="true" Width="100%" TypeName="Template.TemplateBiz" MethodName="ListTemplate" UseColumnSort="true">
                <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="순번" Width="60"  HAlign="center" Align="left" runat="server" OnClick="" />
                <Ctl:SheetField DataField="IDX" TextField="IDX" Description="문서번호" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS1" TextField="COLUMNS1" Description="컬럼1" Width="*" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS2" TextField="COLUMNS2" Description="컬럼2" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS3" TextField="COLUMNS3" Description="컬럼3" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS4" TextField="COLUMNS4" Description="컬럼4" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS5" TextField="COLUMNS5" Description="컬럼5" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS6" TextField="COLUMNS6" Description="컬럼6" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS7" TextField="COLUMNS7" Description="컬럼7" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS8" TextField="COLUMNS8" Description="컬럼8" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="COLUMNS9" TextField="COLUMNS9" Description="컬럼9" Width="100" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="UPDID" TextField="UPDID" Description="등록자" Width="80" runat="server" OnClick="Grid1RowClick" />
                <Ctl:SheetField DataField="UPDDT" TextField="UPDDT" Description="등록일" Width="80" runat="server" OnClick="Grid1RowClick" />
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>