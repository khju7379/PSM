<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebEditor.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.WebEditor" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            var html = "<html><body>5555555555555555555555</body></html>";
            SetEditorHtml(html)

        }

        function btnSearch_Click() {

        }

        function btnSave_Click() {
            var html = GetEditorHtml();
            alert(html);
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / WebEditor
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="WebEditor Control Sample" Literal="true"></Ctl:Text></h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
    </div>
</asp:content>