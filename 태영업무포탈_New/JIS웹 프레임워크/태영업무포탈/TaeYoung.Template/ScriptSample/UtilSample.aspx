<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UtilSample.aspx.cs" Inherits="TaeYoung.WebTemplate.ScriptSample.UtilSample" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">
        
        function OnLoad() {

            // PageLoad시 이벤트 정의부분

            // DateTime 형태의 현재 달의 1일
            AddLog("DateTime 형태의 현재 달의 1일 : " + Util.ThisMonthFirstDay().ToString("yyyy-MM-dd"));

            // DateTime 형태의 현재 달의 말일
            AddLog("DateTime 형태의 현재 달의 말일 : " + Util.ThisMonthLastDay().ToString("yyyy-MM-dd"));

            // ThisYearFirstDay - DateTime 형태의 금년의 1월 1일
            AddLog("DateTime 형태의 금년의 1월 1일 : " + Util.ThisYearFirstDay().ToString("yyyy-MM-dd"));

            // DateTime 형태의 금년의 12월 31일
            AddLog("DateTime 형태의 금년의 12월 31일 : " + Util.ThisYearLastDay().ToString("yyyy-MM-dd"));

            // 구분자 없는 날짜형 string을 DateTime으로 변환

            // 값을 bool로 변환

            // 값을 int로 변환

            // 값을 double로 변환

            // 값을 전화번호 형태로 변경
            AddLog("값을 전화번호 형태로 변경 : " + Util.ConvertToPhoneNumber("0522761338"));

            // LOT NO를 생산일자로 변환
            AddLog("LOT NO를 생산일자로 변환 : " + Util.GetCRT_YMDByLOTNO("SEOHAN", "DAA"));

            // 해당 일자를 LOT번호로 반환
            AddLog("해당 일자를 LOT번호로 반환 : " + Util.GetLOTNOByDate("SEOHAN", "20161001"));

            // 해당 일자를 LOT번호로 반환

            // '-' 이 들어가는 품번 형태로 변환
            AddLog("'-' 이 들어가는 품번 형태로 변환 : " + Util.FormatITMNO("1111111111"));

            // 숫자 형태의 문자열로 변환

        }

        function AddLog(str) {
            $("#divLog").append("<div>" + str + "</div>");
        }

        function btnSearch_Click() {
            
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="Util 사용방법" Literal="true"></Ctl:Text></h4>

        <div style="float:right;">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="Util cs(biz.Util)" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="200" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        DateTime 형태의 현재 달의 1일
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ThisMonthFirstDay.ToString("yyyy-MM-dd") %>
                    </td>
                </tr>
                <tr>
                    <th>
                        DateTime 형태의 현재 달의 말일
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ThisMonthLastDay.ToString("yyyy-MM-dd")%>
                    </td>
                </tr>
                <tr>
                    <th>
                        ThisYearFirstDay - DateTime 형태의 금년의 1월 1일
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ThisYearFirstDay.ToString("yyyy-MM-dd")%>
                    </td>
                </tr>
                <tr>
                    <th>
                        DateTime 형태의 금년의 12월 31일
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ThisYearLastDay.ToString("yyyy-MM-dd")%>
                    </td>
                </tr>
                <tr>
                    <th>
                        구분자 없는 날짜형 string을 DateTime으로 변환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ConvertToDateTime("20140101").ToString("yyyy-MM-dd")%>
                    </td>
                </tr>
                <tr>
                    <th>
                        값을 bool로 변환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ConvertToBoolean("Y").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        값을 int로 변환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ConvertToInt32("12321").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        값을 double로 변환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ConvertToDouble("12321").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        값을 전화번호 형태로 변경
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.ConvertToPhoneNumber("0522761338").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        LOT NO를 생산일자로 변환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.GetCRT_YMDByLOTNO("SEOHAN","DAA").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        해당 일자를 LOT번호로 반환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.GetLOTNOByDate("SEOHAN", DateTime.Now).ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        해당 일자를 LOT번호로 반환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.GetLOTNOByDate("SEOHAN", "20161001").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        '-' 이 들어가는 품번 형태로 변환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.FormatITMNO("1111111111").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        숫자 형태의 문자열로 변환
                    </th>
                    <td>
                        <%= TaeYoung.Biz.Util.FormatNumber("1111111111").ToString()%>
                    </td>
                </tr>
                <tr>
                    <th>
                        스크립트로 Util사용
                    </th>
                    <td>
                        <div id="divLog"></div>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>