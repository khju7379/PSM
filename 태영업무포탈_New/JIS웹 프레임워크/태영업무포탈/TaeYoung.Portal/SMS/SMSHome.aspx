<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMSHome.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSIHome" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">
        
        function OnLoad() {
            SetDesignInit();
            $(window).resize(SetDesignInit);

            // PageLoad시 이벤트 정의부분

            //            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            //            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            //            // 페이지 갯수 변경 예제 ( 기본 10개 )
            //            ht["PageSize"] = "5";

            //            grid1.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //            grid1.BindList(1);

            //            var htm = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            //            htm["PageSize"] = "5";
            //            GridDoc.Params(htm); // 선언한 파라미터를 그리드에 전달함
            //            GridDoc.BindList(1);

            ////            GridDoc.CallBack = function () {
            ////                // 편집 이벤트 제거
            ////                // id+row번호+cell번호 : gridCodeList_0_1
            ////                var pono;
            ////                var dt = GridDoc.GetAllRow();
            ////                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

            ////                    var dr = dt.Rows[i];

            ////                    if (dr["APPWKORDER"] = 'Y') {
            ////                        pono = dr["PO_NO"];
            ////                        GridDoc.SetValue(i, "APPWKORDER", "<img src='/Resources/Images/ext/doc.gif' style='cursor:pointer' onclick=GridDocRowClick('" + pono + "' )  />");
            ////                    }

            ////                }
            ////            }

        }

        function Grid1RowClick() {

        }

        function GridDocRowClick(PONO) {
            window.alert("ddd");
            window.alert(PONO);
        }

        function SetDesignInit() {
            var doc_height = $(document).height();
            var doc_height = doc_height - 100;
            $("form").height(doc_height);
            $("#container").height(doc_height);
            $("#content_bx").height(doc_height);
            $("#title").height(doc_height);
        }

    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title" style="background-image:url(/Resources/Images/bg_sub01.jpg); background-position:top,top; background-repeat:no-repeat; background-size:cover; height:860px; margin:0px; padding:0px;">
        <h4>
            <%--<img src="/Resources/Images/main_img.jpg" width="100%" height="100%" alt="" />--%>
        </h4>

        <%--<div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
        </div>--%>
        <%--<div class="clear"></div>--%>
    </div>
    <!--//타이틀끝-->

   
</asp:content>