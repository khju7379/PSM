<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Button.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.Button" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            // PageLoad시 이벤트 정의부분
        }

        /********************************************************************************************
        * 함수명      : btn1_Click
        * 작성목적    : 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-17
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn1_Click() {
            alert();
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn3_Click
        * 작성목적    : 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-17
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn3_Click() {
            alert('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="스크립트 호출" Literal="true"></Ctl:Text>');
            return true;
        }

        /********************************************************************************************
        * 함수명      : btn7_Click
        * 작성목적    : 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-17
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn7_Click() {
            if ($("#btn6").css("display") == "none") {
                $("#btn6").css("display", "inline");
            } else {
                $("#btn6").css("display", "none");
            }
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn8_Click
        * 작성목적    : 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-17
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn8_Click() {
            alert(btn8.GetValue());
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn9_Click
        * 작성목적    : 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-17
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn9_Click() {
            var str = txtBtn9.GetValue(); // 버튼에 넣을 TextBox값
            btn9.SetValue(str);
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn11_Click
        * 작성목적    : 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-17
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn11_Click() {
            btn10.Hide();
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn13_Click
        * 작성목적    : 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-17
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn13_Click() {
            btn12.Show();
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
                alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="해당 페이지는 업데이트 예정입니다." Literal="true"></Ctl:Text>');
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / Button
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="Button Control Sample" Literal="true"></Ctl:Text></h4>
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
            <Ctl:Button ID="btnNAME99" runat="server" Description="메인으로" Hidden="false" LangCode="TXT99" OnClientClick="fn_Redirect('Index');"></Ctl:Button>
        </div>

        <!--기본샘플-->
        <Ctl:Layer ID="layer1" runat="server" Title="Button Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="65%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT150" runat="server" LangCode="TXT150" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT30" runat="server" LangCode="TXT30" Description="
                        &#60Ctl:Button ID=&#34;btnBtn&#34; runat=&#34;server&#34; Description=&#34;버튼&#34; Height=&#34;40px&#34; Hidden=&#34;false&#34;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LangCode=&#34;TXT01&#34; Width=&#34;120px&#34; OnClientClick=&#34;return false;&#34;&#62<br />
                        &#60/Ctl:Button&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Button ID="btnBtn" runat="server" Description="버튼" Height="40px" Hidden="false" LangCode="TXT01" Width="120px" OnClientClick="return false;"></Ctl:Button>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="Button Control 샘플 DataSet" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="17%" />
                    <col width="13%" />
                    <col width="70%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="TypeName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT153" runat="server" LangCode="TXT153" Description="MethodName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT154" runat="server" LangCode="TXT154" Description="DataSet"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="Button Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT156" runat="server" LangCode="TXT156" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT23"><Ctl:Text ID="TXT159" runat="server" LangCode="TXT159" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT160" runat="server" LangCode="TXT160" Description="- 해당 컨트롤의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT191"><Ctl:Text ID="TXT188" runat="server" LangCode="TXT188" Description="Height" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT189" runat="server" LangCode="TXT189" Description="- 해당 컨트롤의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT26"><Ctl:Text ID="TXT161" runat="server" LangCode="TXT161" Description="Hidden" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT162" runat="server" LangCode="TXT162" Description="- 해당 컨트롤의 표시여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT20"><Ctl:Text ID="TXT157" runat="server" LangCode="TXT157" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT158" runat="server" LangCode="TXT158" Description="- 해당 컨트롤의 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT185"><Ctl:Text ID="TXT182" runat="server" LangCode="TXT182" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT183" runat="server" LangCode="TXT183" Description="- 해당 컨트롤의 너비"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="Button Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT167" runat="server" LangCode="TXT167" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT168" runat="server" LangCode="TXT168" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT07"><Ctl:Text ID="TXT163" runat="server" LangCode="TXT163" Description="OnClientClick" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT164" runat="server" LangCode="TXT164" Description="- 해당 컨트롤 클릭 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="Button Control Functions" DefaultHide="False">
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
                        <a href="#TXT55"><Ctl:Text ID="TXT169" runat="server" LangCode="TXT169" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT170" runat="server" LangCode="TXT170" Description="- 해당 컨트롤의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT61"><Ctl:Text ID="TXT178" runat="server" LangCode="TXT178" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT179" runat="server" LangCode="TXT179" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT58"><Ctl:Text ID="TXT171" runat="server" LangCode="TXT171" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT172" runat="server" LangCode="TXT172" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT63"><Ctl:Text ID="TXT180" runat="server" LangCode="TXT180" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT181" runat="server" LangCode="TXT181" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="Button Control Properties Examples" DefaultHide="False">
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
                        <a href="#TXT160"><Ctl:Text ID="TXT22" runat="server" LangCode="TXT22" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT23" runat="server" LangCode="TXT23" Description="- 해당 컨트롤의 설명" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 다국어코드가 등록되지 않았을 경우 Description을 버튼 컨트롤에 표시한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description에는 string 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT103" runat="server" LangCode="TXT103" Description="
                        <p style='display:inline;color:blue;'>Description=&#34;버튼&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Button ID="btn5" runat="server" LangCode="btn5" Description="버튼" OnClientClick="return false;"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT189"><Ctl:Text ID="TXT190" runat="server" LangCode="TXT190" Description="Height" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT191" runat="server" LangCode="TXT191" Description="- 해당 컨트롤의 높이" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT192" runat="server" LangCode="TXT192" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다. 
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT193" runat="server" LangCode="TXT193" 
                        Description="
                        <p style='display:inline;color:blue;'>Height=&#34;50&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Button ID="btn15" runat="server" LangCode="btn15" Description="버튼" OnClientClick="return false;" Height="50"></Ctl:Button>
                    </td>
                </tr>
                
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT162"><Ctl:Text ID="TXT25" runat="server" LangCode="TXT25" Description="Hidden" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT26" runat="server" LangCode="TXT26" Description="- 해당 컨트롤의 표시여부" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Hidden값이 true일 경우 컨트롤이 숨겨진다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Hidden에는 true | false 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT27" runat="server" LangCode="TXT27" 
                        Description="
                        <p style='display:inline;color:Blue;'>Hidden=&#34;true&#34;</p> <p style='display:inline;color:Green;'>/* 숨겨져 있는 btn6 컨트롤 */</p> <br />
                        <br />
                        function btn7_Click() {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;if ($(&#34;#btn6&#34;).css(&#34;display&#34;) == &#34;none&#34;) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$(&#34;#btn6&#34;).css(&#34;display&#34;, &#34;inline&#34;);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;} else {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$(&#34;#btn6&#34;).css(&#34;display&#34;, &#34;none&#34;);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;return false;<br />
                        }<br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Button ID="btn7" runat="server" LangCode="btn7" Description="btn7_Click()" OnClientClick="return btn7_Click();" Hidden="false"></Ctl:Button>
                        <Ctl:Button ID="btn6" runat="server" LangCode="btn6" Description="btn6" OnClientClick="return false;" Hidden="true"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT158"><Ctl:Text ID="TXT19" runat="server" LangCode="TXT19" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT20" runat="server" LangCode="TXT20" Description="- 해당 컨트롤의 다국어 언어코드 값" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT100" runat="server" LangCode="TXT100" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 다국어코드가 등록되지 않았을 경우 Description을 버튼 컨트롤에 표시한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="
                        <p style='display:inline;color:blue;'>LangCode=&#34;TXT13&#34;</p> Description=&#34;버튼&#34;
                        " />
                    </td>
                    <td>
                        <Ctl:Button ID="btn4" runat="server" LangCode="TXT13" Description="버튼" OnClientClick="return false;"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT183"><Ctl:Text ID="TXT184" runat="server" LangCode="TXT184" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT185" runat="server" LangCode="TXT185" Description="- 해당 컨트롤의 너비" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT186" runat="server" LangCode="TXT186" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다. 
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT187" runat="server" LangCode="TXT187" 
                        Description="
                        <p style='display:inline;color:blue;'>Width=&#34;130&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Button ID="btn14" runat="server" LangCode="btn14" Description="버튼" OnClientClick="return false;" Width="130"></Ctl:Button>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="Button Control Events Examples" DefaultHide="False">
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
                        <a href="#TXT164"><Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="OnClientClick" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="- 해당 컨트롤 클릭 시 발생할 스크립트 이벤트" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT105" runat="server" LangCode="TXT105" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 컨트롤 클릭 시 OnClientClick 에 있는 스크립트를 호출한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" 
                        Description="
                        <p style='display:inline;color:blue;'>OnClientClick=&#34;btn1_Click();&#34;</p> <p style='display:inline;color:Green;'>/* btn1 */</p>
                        <br /><br />
                        function btn1_Click() {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;alert();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;return false;<br />
                        }<br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Button ID="btn1" runat="server" LangCode="btn1" Description="btn1" OnClientClick="btn1_Click();"></Ctl:Button>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="Button Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT173" runat="server" LangCode="TXT173" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT174" runat="server" LangCode="TXT174" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT175" runat="server" LangCode="TXT175" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT176" runat="server" LangCode="TXT176" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT177" runat="server" LangCode="TXT177" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT170"><Ctl:Text ID="TXT54" runat="server" LangCode="TXT54" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT55" runat="server" LangCode="TXT55" Description="- 해당 컨트롤의 Value를 가져온다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT107" runat="server" LangCode="TXT107" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; LangCode가 등록됬을 경우 다국어 언어코드값을 가져오고, 없을경우 Description을 가져온다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).GetValue() 는 string 값을 반환한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT56" runat="server" LangCode="TXT56" Description="
                        <p style='display:inline;color:Blue;'>btn8.GetValue();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT179"><Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="- 해당 컨트롤을 숨긴다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT109" runat="server" LangCode="TXT109" Description="" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT110" runat="server" LangCode="TXT110" Description="
                        <p style='display:inline;color:Blue;'>btn10.Hide();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Button ID="btn10" runat="server" LangCode="btn10" Description="btn10" OnClientClick="return false;"></Ctl:Button>
                        <Ctl:Button ID="btn11" runat="server" LangCode="btn11" Description="Hide()" OnClientClick="return btn11_Click();"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT172"><Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT58" runat="server" LangCode="TXT58" Description="- 해당 컨트롤의 Value를 변경한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT108" runat="server" LangCode="TXT108" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetValue(str); <p style='display:inline;color:Green;'>/* str 변수에는 변경할 Value를 준다. */</p>
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="
                        var str = txtBtn9.GetValue(); <p style='display:inline;color:Green;'>/* btn9에 넣을 Value */</p><br />
                        <p style='display:inline;color:Blue;'>btn9.SetValue(str);</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="txtBtn9" runat="server" SetType="Text" style="width:120px;" PlaceHolder="btn9에 넣을 Value"></Ctl:TextBox>
                        <Ctl:Button ID="btn9" runat="server" LangCode="btn9" Description="btn9" OnClientClick="return btn9_Click();"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT181"><Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT63" runat="server" LangCode="TXT63" Description="- 숨겨진 컨트롤을 보여준다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT111" runat="server" LangCode="TXT111" Description="" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" Description="
                        <p style='display:inline;color:Blue;'>btn12.Show();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Button ID="btn12" runat="server" LangCode="btn12" Description="btn12" Hidden="True" OnClientClick="return false;"></Ctl:Button>
                        <Ctl:Button ID="btn13" runat="server" LangCode="btn13" Description="Show()" OnClientClick="return btn13_Click();"></Ctl:Button>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>