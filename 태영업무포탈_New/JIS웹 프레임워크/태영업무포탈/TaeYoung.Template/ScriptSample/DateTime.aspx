<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DateTime.aspx.cs" Inherits="TaeYoung.WebTemplate.ScriptSample.DateTime" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            // PageLoad시 이벤트 정의부분

            // 현재 날짜 가져오기
            var dt = new DateTime();
            AddLog("현재날짜 : " + dt.ToString("yyyy-MM-dd HH:mm:ss"));

            // 년도 추가
            dt.AddYears(2);
            AddLog("년도추가 : " + dt.ToString("yyyy-MM-dd"));

            // 월 추가
            dt.AddMonths(-3);
            AddLog("월추가 : " + dt.ToString("yyyy-MM-dd"));

            // 일 추가
            dt.AddDays(-3);
            AddLog("일추가 : " + dt.ToString("yyyy-MM-dd"));

            // 시간추가
            dt.AddHours(10);
            AddLog("시간추가 : " + dt.ToString("yyyy-MM-dd HH:mm:ss"));

            // 분추가
            dt.AddMinutes(10);
            AddLog("분추가 : " + dt.ToString("yyyy-MM-dd HH:mm:ss"));

            // 초추가
            dt.AddSeconds(10);
            AddLog("초추가 : " + dt.ToString("yyyy-MM-dd HH:mm:ss"));

            // 날짜 및 시간설정
            dt.Year(2010);
            dt.Month(01);
            dt.Day(20);
            dt.Hour(14);
            dt.Minute(21);
            dt.Second(39);
            AddLog("날짜 및 시간설정 : " + dt.ToString("yyyy-MM-dd HH:mm:ss"));

            // 초기설정으로 날짜 및 시간설정
            dt = new DateTime(2010);
            dt = new DateTime(2010, 01);
            dt = new DateTime(2010, 01, 20);
            dt = new DateTime(2010, 01, 20, 14);
            dt = new DateTime(2010, 01, 20, 14, 21);
            dt = new DateTime(2010, 01, 20, 14, 21, 39);
            AddLog("초기설정으로 날짜 및 시간설정 : " + dt.ToString("yyyy-MM-dd HH:mm:ss"));

            // format형으로 날짜 및 시간설정
            dt = new DateTime("2014-04-04 23:33:21");
            AddLog("format형으로 날짜 및 시간설정 : " + dt.ToString("yyyy-MM-dd HH:mm:ss"));
        }

        function AddLog(str) {
            $("#divLog").append("<div>"+str+"</div>");
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
        <h4><Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="날짜사용예제" Literal="true"></Ctl:Text></h4>

        <div style="float:right;">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="DateTime형 정의" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="140" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        로그
                    </th>
                    <td>
                        <div id="divLog"></div>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>