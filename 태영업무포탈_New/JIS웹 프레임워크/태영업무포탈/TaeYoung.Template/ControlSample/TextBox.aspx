<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TextBox.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.TextBox" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            // PageLoad시 이벤트 정의부분
        }


        /********************************************************************************************
        * 함수명      : TextBox7()
        * 작성목적    : TextBox7 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function TextBox7() {
            alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="스크립트 호출" Literal="true"></Ctl:Text>');
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn3_Click()
        * 작성목적    : btn3_Click 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn3_Click() {
            alert(TextBox18.GetValue());
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn4_Click()
        * 작성목적    : btn4_Click 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn4_Click() {
            var str = TextBox19_1.GetValue()
            TextBox19.SetValue(str);
            return false;
        }

        /************************************************************************
        함수명		: fn_Redirect
        작성목적	: 해당 페이지로 이동한다.
        작 성 자	: 이정홍
        최초작성일	: 2018-04-27
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function fn_Redirect(url) {
            /* 작업중인 페이지는 접근 차단 */
            if (url == "ChartFxScript" || url == "FlipSwitch" || url == "WebSheet" || url == "WebTree") {
                alert('<Ctl:Text ID="MSG09" runat="server" LangCode="MSG09" Description="해당 페이지는 업데이트 예정입니다." Literal="true"></Ctl:Text>');
                return false;
            }
            self.location.href = "/WebTemplate/ControlSample/" + url + ".aspx";
            return false;
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / TextBox
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="TextBox Control Sample" Literal="true"></Ctl:Text></h4>
        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <!-- 메인버튼 -->
        <div style="text-align: right;margin-bottom:15px;">
            <Ctl:Button ID="btn99" runat="server" Description="메인으로" Hidden="false" LangCode="TXT99" OnClientClick="fn_Redirect('Index');"></Ctl:Button>
        </div>

        <!--기본샘플-->
        <Ctl:Layer ID="layer1" runat="server" Title="TextBox Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="65%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT50" runat="server" LangCode="TXT50" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT52" runat="server" LangCode="TXT52" Description="
                        &#60Ctl:TextBox ID=&#34;txtIDX&#34; runat=&#34;server&#34; CalendarGroup=&#34;GRP0&#34; DataMember=&#34;IDX&#34; Height=&#34;30&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PlaceHolder=&#34;빈칸&#34; ReadMode=&#34;false&#34; ReadOnly=&#34;false&#34; SetCalendarFormat=&#34;YYYYMMDD&#34; SetType=&#34;text&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Style=&#34;font-size:20px;&#34; Text=&#34;텍스트박스&#34; TextMode=&#34;MultiLine&#34; Validation=&#34;false&#34; Width=&#34;150&#34; <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OnCalendarChanged=&#34;return false;&#34; &#62<br/>
                        &#60/Ctl:TextBox&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="txtIDX" runat="server" CalendarGroup="GRP0" DataMember="IDX" Height="50" PlaceHolder="빈칸" ReadMode="false" ReadOnly="false" SetCalendarFormat="YYYYMMDD" SetType="text" Text="텍스트박스" TextMode="MultiLine" Validation="false" Width="150" Style="font-size:20px;" OnCalendarChanged="return false;">
                        </Ctl:TextBox>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="TextBox Control 샘플 DataSet" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="17%" />
                    <col width="13%" />
                    <col width="70%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT54" runat="server" LangCode="TXT54" Description="TypeName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT55" runat="server" LangCode="TXT55" Description="MethodName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT56" runat="server" LangCode="TXT56" Description="DataSet"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="TextBox Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT149"><Ctl:Text ID="TXT77" runat="server" LangCode="TXT77" Description="CalendarGroup" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT78" runat="server" LangCode="TXT78" Description="- 해당 기간 컨트롤의 그룹지정값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT157"><Ctl:Text ID="TXT81" runat="server" LangCode="TXT81" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT82" runat="server" LangCode="TXT82" Description="- 해당 컨트롤의 DataMember 값 지정"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT117"><Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="Height" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="- 해당 컨트롤의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT141"><Ctl:Text ID="TXT73" runat="server" LangCode="TXT73" Description="PlaceHolder" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT74" runat="server" LangCode="TXT74" Description="- 해당 컨트롤 공백 시 표시할 Text"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT153"><Ctl:Text ID="TXT79" runat="server" LangCode="TXT79" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT80" runat="server" LangCode="TXT80" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT137"><Ctl:Text ID="TXT71" runat="server" LangCode="TXT71" Description="ReadOnly" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT72" runat="server" LangCode="TXT72" Description="- 해당 컨트롤의 읽기전용 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT129"><Ctl:Text ID="TXT67" runat="server" LangCode="TXT67" Description="SetCalendarFormat" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT68" runat="server" LangCode="TXT68" Description="- 해당 달력 컨트롤의 입출력 형식"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT125"><Ctl:Text ID="TXT65" runat="server" LangCode="TXT65" Description="SetType" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT66" runat="server" LangCode="TXT66" Description="- 해당 컨트롤의 타입"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT169"><Ctl:Text ID="TXT87" runat="server" LangCode="TXT87" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT88" runat="server" LangCode="TXT88" Description="- 해당 컨트롤의 스타일"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT121"><Ctl:Text ID="TXT63" runat="server" LangCode="TXT63" Description="Text" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT64" runat="server" LangCode="TXT64" Description="- 해당 컨트롤의 입력 Text"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT202"><Ctl:Text ID="TXT199" runat="server" LangCode="TXT199" Description="TextMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT200" runat="server" LangCode="TXT200" Description="- 해당 컨트롤의 텍스트 모드"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT145"><Ctl:Text ID="TXT75" runat="server" LangCode="TXT75" Description="Validation" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT76" runat="server" LangCode="TXT76" Description="- 해당 컨트롤의 유효성 검사대상 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT113"><Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="- 해당 컨트롤의 너비" />
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="TextBox Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT58" runat="server" LangCode="TXT58" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT133"><Ctl:Text ID="TXT69" runat="server" LangCode="TXT69" Description="OnCalendarChanged" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT70" runat="server" LangCode="TXT70" Description="- 해당 달력 컨트롤 값 변경 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="TextBox Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT211" runat="server" LangCode="TXT211" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT325"><Ctl:Text ID="TXT320" runat="server" LangCode="TXT320" Description="Controls.GetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT321" runat="server" LangCode="TXT321" Description="- DataMember로 지정한 컨트롤들의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT330"><Ctl:Text ID="TXT322" runat="server" LangCode="TXT322" Description="Controls.SetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT323" runat="server" LangCode="TXT323" Description="- DataMember로 지정한 컨트롤들의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT177"><Ctl:Text ID="TXT93" runat="server" LangCode="TXT93" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT94" runat="server" LangCode="TXT94" Description="- 해당 컨트롤의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT184"><Ctl:Text ID="TXT97" runat="server" LangCode="TXT97" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT98" runat="server" LangCode="TXT98" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT196"><Ctl:Text ID="TXT103" runat="server" LangCode="TXT103" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="- 해당 컨트롤의 비활성화 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT180"><Ctl:Text ID="TXT95" runat="server" LangCode="TXT95" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT96" runat="server" LangCode="TXT96" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT188"><Ctl:Text ID="TXT99" runat="server" LangCode="TXT99" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT100" runat="server" LangCode="TXT100" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT192"><Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="ValidationCheck()<br/><p style='display:inline;color:red;'>(현재 return값 없음. 추가예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="- 검사대상 컨트롤들의 유효성 검사를 한다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="TextBox Control Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT212" runat="server" LangCode="TXT212" Description="Properties"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT213" runat="server" LangCode="TXT213" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT214" runat="server" LangCode="TXT214" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT215" runat="server" LangCode="TXT215" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT216" runat="server" LangCode="TXT216" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT78"><Ctl:Text ID="TXT148" runat="server" LangCode="TXT148" Description="CalendarGroup" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT149" runat="server" LangCode="TXT149" Description="- 해당 기간 컨트롤의 그룹지정값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT150" runat="server" LangCode="TXT150" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:Red;'>SetType = &#34;Calendar_FrTo&#34; 인 컨트롤만 사용할 수 있다.</p> <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 같은 그룹으로 지정할 기간 컨트롤의 CalendarGroup 값을 동일 값으로 지정한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CalendarGroup 에는 string 값을 넣는다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="
                        <p style='display:inline;color:blue;'>CalendarGroup=&#34;GRP02&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox11Fr" runat="server" SetType="Calendar_FrTo" SetCalendarFormat="YYYYMMDD" CalendarGroup="GRP02"></Ctl:TextBox>
                        <Ctl:TextBox ID="TextBox11To" runat="server" SetType="Calendar_FrTo" SetCalendarFormat="YYYYMMDD" CalendarGroup="GRP02"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT82"><Ctl:Text ID="TXT156" runat="server" LangCode="TXT156" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT157" runat="server" LangCode="TXT157" Description="- 해당 컨트롤의 DataMember 값 지정"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT158" runat="server" LangCode="TXT158" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 에는 조회하는 데이터의 칼럼 명을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 로 지정한 컨트롤들의 Value를 Controls.GetDataMemberValue() 로 가져오거나<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Controls.SetDataMemberValue() 로 Value에 바인딩한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT159" runat="server" LangCode="TXT159" Description="
                        <p style='display:inline;color:blue;'>DataMember=&#34;TITLE&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox13" runat="server" DataMember="TITLE"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT62"><Ctl:Text ID="TXT116" runat="server" LangCode="TXT116" Description="Height" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT117" runat="server" LangCode="TXT117" Description="- 해당 컨트롤의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT118" runat="server" LangCode="TXT118" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다. 
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT119" runat="server" LangCode="TXT119" Description="
                        <p style='display:inline;color:blue;'>Height=&#34;50&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox3" runat="server" Height="50px"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT74"><Ctl:Text ID="TXT140" runat="server" LangCode="TXT136" Description="PlaceHolder" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT141" runat="server" LangCode="TXT141" Description="- 해당 컨트롤 공백 시 표시할 Text"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT142" runat="server" LangCode="TXT142" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; PlaceHolder 에는 string 값을 넣는다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT143" runat="server" LangCode="TXT143" Description="
                        <p style='display:inline;color:blue;'>PlaceHolder=&#34;PlaceHolder 텍스트&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox9" runat="server" PlaceHolder="PlaceHolder 텍스트"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT80"><Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT153" runat="server" LangCode="TXT153" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT154" runat="server" LangCode="TXT154" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="
                        <p style='display:inline;color:blue;'>ReadMode=&#34;true&#34;</p> Text=&#34;텍스트박스&#34;
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox12" runat="server" SetType="Calendar" SetCalendarFormat="YYYYMMDD"  ReadMode="true" Text="텍스트박스"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT72"><Ctl:Text ID="TXT136" runat="server" LangCode="TXT136" Description="ReadOnly" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT137" runat="server" LangCode="TXT137" Description="- 해당 컨트롤의 읽기전용 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT138" runat="server" LangCode="TXT138" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadOnly 에는 true | false 값을 넣는다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT139" runat="server" LangCode="TXT139" Description="
                        <p style='display:inline;color:blue;'>ReadOnly=&#34;true&#34;</p> Text=&#34;텍스트박스&#34;
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox8" runat="server" ReadOnly="true" Text="텍스트박스"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT68"><Ctl:Text ID="TXT128" runat="server" LangCode="TXT128" Description="SetCalendarFormat" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT129" runat="server" LangCode="TXT129" Description="- 해당 달력 컨트롤의 입출력 형식"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT130" runat="server" LangCode="TXT130" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:Red;'>SetType = &#34;Calendar | Calendar_FrTo&#34;인 컨트롤만 사용할 수 있다.</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 달력|기간 컨트롤의 입출력 형식을 지정한다. <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SetCalendarFormat 에는 YYYY | YYYYMM | YYYYMMDD 을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (YYYY : 연도, YYYYMM : 연월, YYYYMMDD : 연월일)
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT131" runat="server" LangCode="TXT131" Description="
                        SetType=&#34;Calendar&#34; <p style='display:inline;color:blue;'>SetCalendarFormat=&#34;YYYYMMDD&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox6" runat="server" SetType="Calendar" SetCalendarFormat="YYYYMMDD"  ReadMode="false"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT66"><Ctl:Text ID="TXT124" runat="server" LangCode="TXT124" Description="SetType" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT125" runat="server" LangCode="TXT125" Description="- 해당 컨트롤의 타입"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT126" runat="server" LangCode="TXT126" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SetType 에는 Text | Number | Percent | NumberComma | Calendar | Calendar_FrTo 을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Text : 텍스트, Number : 숫자, Percent : 퍼센트, NumberComma : 콤마숫자, Calendar : 달력, Calendar_FrTo : 기간)
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT127" runat="server" LangCode="TXT127" Description="
                        <p style='display:inline;color:blue;'>SetType=&#34;Calendar&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox5" runat="server" SetType="Calendar"  SetCalendarFormat="YYYYMMDD"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT88"><Ctl:Text ID="TXT168" runat="server" LangCode="TXT168" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT169" runat="server" LangCode="TXT169" Description="- 해당 컨트롤의 스타일"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT170" runat="server" LangCode="TXT170" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Style은 기본태그의 Style 처럼 사용할 수 있지만 width와 height 값은 사용할 수 없다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT171" runat="server" LangCode="TXT171" Description="
                        <p style='display:inline;color:blue;'>Style=&#34;background-color:Red;&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox16" runat="server" Style="background-color:Red;"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT64"><Ctl:Text ID="TXT120" runat="server" LangCode="TXT120" Description="Text" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT121" runat="server" LangCode="TXT121" Description="- 해당 컨트롤의 입력 Text"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT122" runat="server" LangCode="TXT122" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 Value로 Text를 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Text 에는 string값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT123" runat="server" LangCode="TXT123" Description="
                        <p style='display:inline;color:blue;'>Text=&#34;텍스트&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox4" runat="server" Text="텍스트"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT200"><Ctl:Text ID="TXT201" runat="server" LangCode="TXT201" Description="TextMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT202" runat="server" LangCode="TXT202" Description="- 해당 컨트롤의 텍스트 모드"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT233" runat="server" LangCode="TXT233" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; TextMode 가 MultiLine 일 경우 멀티라인을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; TextMode 가 Password 일 경우 비밀번호를 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT234" runat="server" LangCode="TXT234" Description="
                        <p style='display:inline;color:blue;'>TextMode=&#34;MultiLine&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox24" runat="server" SetType="Text" TextMode="MultiLine" ></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT76"><Ctl:Text ID="TXT144" runat="server" LangCode="TXT144" Description="Validation" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT145" runat="server" LangCode="TXT145" Description="- 해당 컨트롤의 유효성 검사대상 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT146" runat="server" LangCode="TXT146" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ValidationCheck() 로 유효성 검사 시 검사대상 여부를 지정한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Validation 에는 true | false 값을 넣는다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT147" runat="server" LangCode="TXT147" Description="
                        <p style='display:inline;color:blue;'>Validation=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox10" runat="server" Width="130" Validation="true" Text="텍스트"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT60"><Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT113" runat="server" LangCode="TXT113" Description="- 해당 컨트롤의 너비"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT114" runat="server" LangCode="TXT114" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다. 
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT115" runat="server" LangCode="TXT115" Description="
                        <p style='display:inline;color:blue;'>Width=&#34;200&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox2" runat="server" Width="200px"></Ctl:TextBox>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="TextBox Control Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT217" runat="server" LangCode="TXT217" Description="Events"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT218" runat="server" LangCode="TXT218" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT219" runat="server" LangCode="TXT219" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT220" runat="server" LangCode="TXT220" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT221" runat="server" LangCode="TXT221" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT70"><Ctl:Text ID="TXT132" runat="server" LangCode="TXT132" Description="OnCalendarChanged" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT133" runat="server" LangCode="TXT133" Description="- 해당 달력 컨트롤 값 변경 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT134" runat="server" LangCode="TXT134" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 달력 컨트롤 값 변경 시 OnCalendarChanged에 있는 스크립트를 호출한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT135" runat="server" LangCode="TXT135" Description="
                        <p style='display:inline;color:blue;'>OnCalendarChanged=&#34;alert();&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox7" runat="server" SetType="Calendar" SetCalendarFormat="YYYYMMDD" OnCalendarChanged="alert();"></Ctl:TextBox>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="TextBox Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT205" runat="server" LangCode="TXT205" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT207" runat="server" LangCode="TXT207" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT208" runat="server" LangCode="TXT208" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT209" runat="server" LangCode="TXT209" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT321"><Ctl:Text ID="TXT324" runat="server" LangCode="TXT324" Description="Controls.GetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT325" runat="server" LangCode="TXT325" Description="- DataMember로 지정한 컨트롤들의 Value를 가져온다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT326" runat="server" LangCode="TXT326" Description="
                        
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT327" runat="server" LangCode="TXT327" Description="
                        <p style='display:inline;color:Blue;'>Controls.GetDataMemberValue()</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT328" runat="server" LangCode="TXT328" Description=" "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT323"><Ctl:Text ID="TXT329" runat="server" LangCode="TXT329" Description="Controls.SetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT330" runat="server" LangCode="TXT330" Description="- DataMember로 지정한 컨트롤들의 Value를 변경한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT331" runat="server" LangCode="TXT331" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; RowData 값의 칼럼과 일치하는 DataMember 의 컨트롤들에 Value를 바인딩한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT332" runat="server" LangCode="TXT332" Description="
                        <p style='display:inline;color:Blue;'>Controls.SetDataMemberValue(<p style='display:inline;color:Green;'>/* RowData 값 사용 */</p>)</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT333" runat="server" LangCode="TXT333" Description=" "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT94"><Ctl:Text ID="TXT176" runat="server" LangCode="TXT176" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT177" runat="server" LangCode="TXT177" Description="- 해당 컨트롤의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT178" runat="server" LangCode="TXT178" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).GetValue() 는 string 값을 반환한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT179" runat="server" LangCode="TXT179" Description="
                        <p style='display:inline;color:Blue;'>TextBox18.GetValue()</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT98"><Ctl:Text ID="TXT183" runat="server" LangCode="TXT183" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT184" runat="server" LangCode="TXT184" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT185" runat="server" LangCode="TXT185" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT186" runat="server" LangCode="TXT186" Description="
                        <p style='display:inline;color:Blue;'>TextBox20.Hide();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox20" runat="server" Text="TextBox20"></Ctl:TextBox>
                        <Ctl:Button ID="btn5" runat="server" LangCode="btn5" Description="Hide()" OnClientClick="TextBox20.Hide();"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT104"><Ctl:Text ID="TXT195" runat="server" LangCode="TXT195" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT196" runat="server" LangCode="TXT196" Description="- 해당 컨트롤의 비활성화 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT197" runat="server" LangCode="TXT197" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetDisabled(true | false); <br />
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT198" runat="server" LangCode="TXT198" Description="
                        <p style='display:inline;color:Blue;'>TextBox23.SetDisabled(true);</p> <p style='display:inline;color:Green;'>/* 비활성화 */ </p><br />
                        <p style='display:inline;color:Blue;'>TextBox23.SetDisabled(false);</p> <p style='display:inline;color:Green;'>/* 활성화 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox23" runat="server" Text="텍스트박스"></Ctl:TextBox>
                        <Ctl:Button ID="btn8" runat="server" LangCode="btn8" Description="비활성화" OnClientClick="TextBox23.SetDisabled(true);"></Ctl:Button>
                        <Ctl:Button ID="btn9" runat="server" LangCode="btn9" Description="활성화" OnClientClick="TextBox23.SetDisabled(false);"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT96"><Ctl:Text ID="TXT203" runat="server" LangCode="TXT203" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT180" runat="server" LangCode="TXT180" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT181" runat="server" LangCode="TXT181" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetValue(str); <p style='display:inline;color:Green;'>/* str 변수에는 변경할 Value를 준다. */
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT182" runat="server" LangCode="TXT182" Description="
                        var str = TextBox19_1.GetValue() <p style='display:inline;color:Green;'>/* TextBox19에 넣을 Value */</p><br />
                        <p style='display:inline;color:Blue;'>TextBox19.SetValue(str);</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox19_1" runat="server" PlaceHolder="TextBox19에 넣을 Value" Width="140"></Ctl:TextBox>
                        <Ctl:TextBox ID="TextBox19" runat="server" PlaceHolder="TextBox19" Width="140"></Ctl:TextBox>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btn4" runat="server" LangCode="btn4" Description="SetValue()" OnClientClick="btn4_Click();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT100"><Ctl:Text ID="TXT187" runat="server" LangCode="TXT187" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT188" runat="server" LangCode="TXT188" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT189" runat="server" LangCode="TXT189" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT190" runat="server" LangCode="TXT190" Description="
                        <p style='display:inline;color:Blue;'>TextBox21.Show();</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox21" runat="server" Text="TextBox21" Style="display:none;"></Ctl:TextBox>
                        <Ctl:Button ID="btn6" runat="server" LangCode="btn6" Description="Show()" OnClientClick="TextBox21.Show();"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT102"><Ctl:Text ID="TXT191" runat="server" LangCode="TXT191" Description="ValidationCheck()<br/><p style='display:inline;color:Red;'>(현재 return값 없음. 추가예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT192" runat="server" LangCode="TXT192" Description="- 검사대상 컨트롤들의 유효성 검사를 한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT193" runat="server" LangCode="TXT193" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Validation=&#34;true&#34; 인 컨트롤들의 유효성 검사를 한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 공백일 경우 텍스트박스에 &#34;필수입력부분입니다.&#34; 라는 표시가 나온다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT194" runat="server" LangCode="TXT194" Description="
                        <p style='display:inline;color:Blue;'>ValidationCheck();</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="TextBox22" runat="server" Validation="true" Width="120" Style="border:1px solid #d4d4d4;"></Ctl:TextBox>
                        <Ctl:Button ID="btn7" runat="server" LangCode="btn7" Description="ValidationCheck()" OnClientClick="ValidationCheck();"></Ctl:Button>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>