<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridBindAfter.aspx.cs" Inherits="TaeYoung.Template.Sample.GridBindAfter" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            BindList();
        }

        function btnSearch_Click() {
            BindList();
        }

        function BindList() {
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            //ht["PageSize"] = "10";

            grid1.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid1.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
            //grid1.CallBack = grid1_Loaded;
            grid1.CallBack = function () { // 바인딩 이후 처리할내용
                var dt = grid1.GetAllRow();

                //for (var i = 0; i < dt.Rows.length; i++) {
                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                    // 컬럼 내부에 테이블 추가
                    var dr = dt.Rows[i];

                    var tmpHtml = "<table class = 'table_01' style = 'table-layout: fixed; width : 100%;' >";
                    tmpHtml += "<tr>";
                    tmpHtml += "<td style = 'overflow: hidden;white-space: nowrap;-ms-text-overflow: ellipsis; cursor : pointer;' onclick = 'grid1Req1_RowClick(" + i + ", " + 0 + ")'>" + dr["COLUMNS1"] + "</td>";
                    tmpHtml += "</tr>";
                    tmpHtml += "<tr>";
                    tmpHtml += "<td style = 'overflow: hidden;white-space: nowrap;-ms-text-overflow: ellipsis;cursor : pointer;' onclick = 'grid1Req1_RowClick(" + i + ", " + 1 + ")'>" + dr["COLUMNS2"] + "</td>";
                    tmpHtml += "</tr>";
                    tmpHtml += "<tr>";
                    tmpHtml += "<td style = 'overflow: hidden;white-space: nowrap;-ms-text-overflow: ellipsis;cursor : pointer;' onclick = 'grid1Req1_RowClick(" + i + ", " + 1 + ")'>" + dr["COLUMNS2"] + "</td>";
                    tmpHtml += "</tr>";
                    tmpHtml += "</table>";

                    grid1.SetValue(i, "COLUMNS1", tmpHtml);

                    grid1.SetValue(i, "COLUMNS3", "<img src='/Resources/Images/btn_submenu_open2.gif' alt='' />");

                    // 틀고정일시 고정테이블의 높이를 맞춤
                    $("#grid1_" + i + "_0").height(94);

                    // 내용 디자인변경
                    if (dr["COLUMNS6"] == "1") {
                        $("#grid1_" + i + "_7").css("background", "#ff0").find("div").css("color", "red");
                    }
                    else {
                        $("#grid1_" + i + "_7").css("background", "green").find("div").css("color", "#f00");
                    }
                }
            };
        }

        function grid1_Loaded() {
        }

        function grid1Req1_RowClick(i, j) {
            i++;
            j++;
            alert(i+"번째줄 "+j+"번째 선택");
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
        <Ctl:Layer ID="layer1" runat="server" Title="일반적인 그리드" DefaultHide="False">
            <Ctl:WebSheet ID="grid1" runat="server" Paging="true" CheckBox="true" Width="100%" TypeName="Template.TemplateBiz" MethodName="ListTemplate" UseColumnSort="true" Fixation="true">
                <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="순번" Width="60"  HAlign="center" Align="left" runat="server" Fix="true" />
                <Ctl:SheetField DataField="IDX" TextField="IDX" Description="문서번호" Width="60"  HAlign="center" Align="left" runat="server" Fix="true" />
                <Ctl:SheetField DataField="COLUMNS1" TextField="COLUMNS1" Description="컬럼1" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS2" TextField="COLUMNS2" Description="컬럼2" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS3" TextField="COLUMNS3" Description="컬럼3" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS4" TextField="COLUMNS4" Description="컬럼4" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS5" TextField="COLUMNS5" Description="컬럼5" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS6" TextField="COLUMNS6" Description="컬럼6" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS7" TextField="COLUMNS7" Description="컬럼7" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS8" TextField="COLUMNS8" Description="컬럼8" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS9" TextField="COLUMNS9" Description="컬럼9" Width="200" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="UPDID" TextField="UPDID" Description="등록자" Width="80" runat="server" />
                <Ctl:SheetField DataField="UPDDT" TextField="UPDDT" Description="등록일" Width="80" runat="server" />
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>