<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Text.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.Text" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            // PageLoad시 이벤트 정의부분
        }

        /********************************************************************************************
        * 함수명      : TXT143_Click
        * 작성목적    : 텍스트 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function TXT143_Click() {
            alert();
            return false;
        }

        /********************************************************************************************
        * 함수명      : TXT143_Click
        * 작성목적    : TXT148.GetValue() 값확인 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn1_Click() {
            alert(TXT148.GetValue());
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn2_Click
        * 작성목적    : SetValue() 기능확인 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn2_Click() {
            var str = txtTXT153.GetValue(); // 텍스트에 넣을 TextBox값
            TXT153.SetValue(str);
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn3_Click
        * 작성목적    : Hide() 기능확인 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn3_Click() {
            TXT158.Hide();
            return false;
        }

        /********************************************************************************************
        * 함수명      : btn4_Click
        * 작성목적    : Show() 기능확인 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btn4_Click() {
            TXT163.Show();
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / Text
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="Text Control Sample" Literal="true"></Ctl:Text></h4>
        <div class="btn_bx">
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
        <Ctl:Layer ID="layer1" runat="server" Title="Text Control 기본샘플" DefaultHide="False">
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
                        &#60Ctl:Text ID=&#34;TXT53&#34; runat=&#34;server&#34; DataMember=&#34;IDX&#34; Description=&#34;텍스트&#34; Height=&#34;50px&#34;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LangCode=&#34;TXT53&#34; Literal=&#34;false&#34; ReadMode=&#34;false&#34; Required=&#34;true&#34; style=&#34;font-size:20px;&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Width=&#34;150px&#34; &#62<br />
                        &#60/Ctl:Text&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT53" runat="server" Width="100px" Height="50px" LangCode="TXT53" Description="텍스트" Required="true" Literal="false" ReadMode="false" DataMember="IDX" Style="font-size:20px;"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="Text Control 샘플 DataSet" DefaultHide="False">
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
        <Ctl:Layer ID="layer3" runat="server" Title="Text Control Properties" DefaultHide="False">
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
                        <a href="#TXT130"><Ctl:Text ID="TXT73" runat="server" LangCode="TXT73" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT74" runat="server" LangCode="TXT74" Description="- 해당 컨트롤의 DataMember 값 지정"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT110"><Ctl:Text ID="TXT65" runat="server" LangCode="TXT65" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT66" runat="server" LangCode="TXT66" Description="- 해당 컨트롤의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT100"><Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="Height" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="- 해당 컨트롤의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT103"><Ctl:Text ID="TXT63" runat="server" LangCode="TXT63" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT64" runat="server" LangCode="TXT64" Description="- 해당 컨트롤의 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT120"><Ctl:Text ID="TXT69" runat="server" LangCode="TXT69" Description="Literal" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT70" runat="server" LangCode="TXT70" Description="- 해당 컨트롤의 텍스트만 표시여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT125"><Ctl:Text ID="TXT71" runat="server" LangCode="TXT71" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT72" runat="server" LangCode="TXT72" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT115"><Ctl:Text ID="TXT67" runat="server" LangCode="TXT67" Description="Required" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT68" runat="server" LangCode="TXT68" Description="- 해당 컨트롤의 필수입력 표시여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT23"><Ctl:Text ID="TXT75" runat="server" LangCode="TXT75" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT76" runat="server" LangCode="TXT76" Description="- 해당 컨트롤의 스타일"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT95"><Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="- 해당 컨트롤의 너비"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="Text Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT77" runat="server" LangCode="TXT77" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT78" runat="server" LangCode="TXT78" Description="설명"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="Text Control Functions" DefaultHide="False">
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
                        <a href="#TXT145"><Ctl:Text ID="TXT79" runat="server" LangCode="TXT79" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT80" runat="server" LangCode="TXT80" Description="- 해당 컨트롤의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT155"><Ctl:Text ID="TXT85" runat="server" LangCode="TXT85" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT86" runat="server" LangCode="TXT86" Description="- 해당 컨트롤을 숨긴다." ></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT150"><Ctl:Text ID="TXT81" runat="server" LangCode="TXT81" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT82" runat="server" LangCode="TXT82" Description="- 해당 컨트롤의 Value을 변경한다." ></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT160"><Ctl:Text ID="TXT87" runat="server" LangCode="TXT87" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT88" runat="server" LangCode="TXT88" Description="- 숨겨진 컨트롤을 보여준다." DataMember="aaaS" ></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="Text Control Properties Examples" DefaultHide="False">
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
                        <a href="#TXT74"><Ctl:Text ID="TXT129" runat="server" LangCode="TXT129" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT130" runat="server" LangCode="TXT130" Description="- 해당 컨트롤의 DataMember 값 지정" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT131" runat="server" LangCode="TXT131" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 에는 조회하는 데이터의 칼럼 명을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 로 지정한 컨트롤들의 Value를 Controls.GetDataMemberValue() 로 가져오거나<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Controls.SetDataMemberValue() 로 Value에 바인딩한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT132" runat="server" LangCode="TXT132" Description="
                        <p style='display:inline;color:blue;'>DataMember=&#34;TITLE&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT133" runat="server" LangCode="TXT133" Description="텍스트" DataMember="TITLE" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT66"><Ctl:Text ID="TXT109" runat="server" LangCode="TXT109" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT110" runat="server" LangCode="TXT110" Description="- 해당 컨트롤의 설명" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT111" runat="server" LangCode="TXT111" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 다국어코드가 등록되지 않았을 경우 Description을 컨트롤에 표시한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description에는 string 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" 
                        Description="
                        <p style='display:inline;color:blue;'>Description=&#34;텍스트&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT113" runat="server" LangCode="TXT113" Description="텍스트" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT62"><Ctl:Text ID="TXT99" runat="server" LangCode="TXT99" Description="Height" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT100" runat="server" LangCode="TXT100" Description="- 해당 컨트롤의 높이" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다. 
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT105" runat="server" LangCode="TXT105" Description="
                        <p style='display:inline;color:blue;'>Height=&#34;50&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT106" runat="server" LangCode="TXT106" Description="텍스트" Height="50" Style="border:1px solid #8f8f8f;" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT64"><Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT103" runat="server" LangCode="TXT103" Description="- 해당 컨트롤의 다국어 언어코드 값" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 다국어코드가 등록되지 않았을 경우 Description을 컨트롤에 표시한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT107" runat="server" LangCode="TXT107" 
                        Description="
                        <p style='display:inline;color:blue;'>LangCode=&#34;TXT108&#34;</p> Description=&#34;텍스트&#34;
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT108" runat="server" LangCode="TXT108" Description="텍스트" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT70"><Ctl:Text ID="TXT119" runat="server" LangCode="TXT119" Description="Literal" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT120" runat="server" LangCode="TXT120" Description="- 해당 컨트롤의 텍스트만 표시여부" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT121" runat="server" LangCode="TXT121" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Literal 이 true 일 경우에는 태그를 제외한 텍스트값만을 출력한다. <p style='display:inline;color:green;'>/* ex : 텍스트 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Literal 이 false 일 경우에는 태그를 포함한 값을 출력한다. <p style='display:inline;color:green;'>/* ex : &#60span id=&#34;TXT123&#34;&#62텍스트&#60/span&#62 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Literal 에는 true | false 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT122" runat="server" LangCode="TXT122" 
                        Description="
                        <p style='display:inline;color:blue;'>Literal=&#34;true&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT123" runat="server" LangCode="TXT123" Description="텍스트" Literal="true" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT72"><Ctl:Text ID="TXT124" runat="server" LangCode="TXT124" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT125" runat="server" LangCode="TXT125" Description="- 해당 컨트롤의 읽기모드 여부" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT126" runat="server" LangCode="TXT126" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 가 true 일 경우 Required 가 true 일때 표시되는 빨간 별표가 표시되지 않는다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 에는 true | false 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT127" runat="server" LangCode="TXT127" Description="
                        <p style='display:inline;color:blue;'>ReadMode=&#34;true&#34;</p> Required=&#34;true&#34;
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT128" runat="server" LangCode="TXT128" Description="텍스트" ReadMode="true" Required="true" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT68"><Ctl:Text ID="TXT114" runat="server" LangCode="TXT114" Description="Required" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT115" runat="server" LangCode="TXT115" Description="- 해당 컨트롤의 필수입력 표시여부" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT116" runat="server" LangCode="TXT116" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 빨간 별표로 필수입력 표시를 나타낸다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Required 에는 true | false 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT117" runat="server" LangCode="TXT117" 
                        Description="
                        <p style='display:inline;color:blue;'>Required=&#34;true&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT118" runat="server" LangCode="TXT118" Description="텍스트" Required="true" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT76"><Ctl:Text ID="TXT134" runat="server" LangCode="TXT134" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT135" runat="server" LangCode="TXT135" Description="- 해당 컨트롤의 스타일" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT136" runat="server" LangCode="TXT136" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Style은 기본태그의 Style 처럼 사용할 수 있지만 width와 height 값은 사용할 수 없다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT137" runat="server" LangCode="TXT137" Description="
                        <p style='display:inline;color:blue;'>Style=&#34;border:3px solid red;color:white;background-color:black;padding:3px;&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT138" runat="server" LangCode="TXT138" Description="텍스트" Style="border:3px solid red;color:white;background-color:black;padding:3px;" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT60"><Ctl:Text ID="TXT94" runat="server" LangCode="TXT94" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT95" runat="server" LangCode="TXT95" Description="- 해당 컨트롤의 너비" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT96" runat="server" LangCode="TXT96" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다. 
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT97" runat="server" LangCode="TXT97" 
                        Description="
                        <p style='display:inline;color:blue;'>Width=&#34;130&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Text ID="TXT98" runat="server" LangCode="TXT98" Description="텍스트" Width="130" Style="border:1px solid #8f8f8f;" />
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="Text Control Events Examples" DefaultHide="False">
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
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="Text Control Functions Examples" DefaultHide="False">
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
                        <a href="#TXT80"><Ctl:Text ID="TXT144" runat="server" LangCode="TXT144" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT145" runat="server" LangCode="TXT145" Description="- 해당 컨트롤의 Value를 가져온다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT146" runat="server" LangCode="TXT146" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; LangCode값이 등록됬을 경우 다국어 언어코드값을 가져오고, 없을경우 Description을 가져온다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).GetValue() 는 string 값을 반환한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT147" runat="server" LangCode="TXT147" Description="
                        <p style='display:inline;color:Blue;'>TXT148.GetValue()</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT148" runat="server" LangCode="TXT148" Description=" "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT86"><Ctl:Text ID="TXT154" runat="server" LangCode="TXT154" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="- 해당 컨트롤을 숨긴다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT156" runat="server" LangCode="TXT156" Description="" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT157" runat="server" LangCode="TXT157" Description="
                        <p style='display:inline;color:Blue;'>TXT158.Hide();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT158" runat="server" LangCode="TXT158" Description="TXT158" />
                        <Ctl:Button ID="btn3" runat="server" LangCode="btn3" Description="Hide()" OnClientClick="TXT158.Hide();"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT82"><Ctl:Text ID="TXT149" runat="server" LangCode="TXT149" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT150" runat="server" LangCode="TXT150" Description="- 해당 컨트롤의 Value를 변경한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetValue(str); <p style='display:inline;color:Green;'>/* str 변수에는 변경할 Value를 준다. */</p>
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="
                        var str = txtTXT153.GetValue(); <p style='display:inline;color:Green;'>/* TXT153에 넣을 Value */</p><br />
                        <p style='display:inline;color:Blue;'>TXT153.SetValue(str);</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:TextBox ID="txtTXT153" runat="server" SetType="Text" style="width:130px;" PlaceHolder="TXT153에 넣을 Value"></Ctl:TextBox>
                        <Ctl:Text ID="TXT153" runat="server" LangCode="TXT153" Description="TXT153"></Ctl:Text>
                        <Ctl:Button ID="btn2" runat="server" LangCode="btn2" Description="SetValue()" OnClientClick="return btn2_Click();"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT88"><Ctl:Text ID="TXT159" runat="server" LangCode="TXT159" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT160" runat="server" LangCode="TXT160" Description="- 숨겨진 컨트롤을 보여준다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT161" runat="server" LangCode="TXT161" Description="" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT162" runat="server" LangCode="TXT162" Description="
                        <p style='display:inline;color:Blue;'>TXT163.Show();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT163" runat="server" LangCode="TXT163" Description="TXT163" Style="display:none;" />
                        <Ctl:Button ID="btn4" runat="server" LangCode="btn4" Description="Show()" OnClientClick="TXT163.Show();"></Ctl:Button>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>