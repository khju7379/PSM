<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSSHome.aspx.cs" Inherits="TaeYoung.Portal.TYCSS.CSSHome" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            SetDesignInit();
            $(window).resize(SetDesignInit);

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
    <div id="title" style="background-image:url(/Resources/Images/bg_sub02.jpg); background-position:top,top; background-repeat:no-repeat; background-size:cover; height:860px; margin:0px; padding:0px;">
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