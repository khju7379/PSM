<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemLogTest.aspx.cs" Inherits="TaeYoung.WebTemplate.SystemLogTest" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            // PageLoad시 이벤트 정의부분

        }

        function btnSearch_Click() {
            
        }
    </script>
</asp:content>
<asp:content id="LeftContent" runat="server" contentplaceholderid="conLeft">
    <!--타이틀시작-->
    <div>
        <h3>메뉴 제목</h3>
    </div>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="페이지 제목을 입력하세요" Literal="true"></Ctl:Text></h4>

        <div style="float:right;">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="레이어 제목을 입력하세요" DefaultHide="False">
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
                        첫번째 내용
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>