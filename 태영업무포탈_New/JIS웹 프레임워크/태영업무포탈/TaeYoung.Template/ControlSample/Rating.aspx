<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rating.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.Rating" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            // ratNAME10 컨트롤 Show() 기능 테스트
            ratNAME10.Hide();
        }

        /********************************************************************************************
        * 함수명      : ratNAME9_Click()
        * 작성목적    : ratNAME9
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-18
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function ratNAME9_Click() {
            alert();
            return true;
        }

        function ratNAME11_Click() {
            ratNAME11.SetValue(3); 
            $("#conBody_ratNAME11").find("span.click_score").text(3);
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / Rating
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="Rating Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="Rating Control 기본샘플" DefaultHide="False">
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
                        <Ctl:Text ID="TXT53" runat="server" LangCode="TXT53" Description="
                        &#60Ctl:Rating ID=&#34;ratSTAR&#34; runat=&#34;server&#34; DataMember=&#34;IDX&#34; Gap=&#34;Half&#34; ItemCount=&#34;10&#34; ReadMode=&#34;false&#34;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Value=&#34;1&#34; Style=&#34;border:1px solid #646464;&#34; /&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratSTAR" runat="server" DataMember="IDX" Gap="Half" ItemCount="10" ReadMode="false" Value="1" Style="border:1px solid #646464;" />
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="Rating Control 샘플 DataSet" DefaultHide="False">
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
        <Ctl:Layer ID="layer3" runat="server" Title="Rating Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="설명"></Ctl:Text>
                    </th>
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
                        <a href="#TXT113"><Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="Gap" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="- 해당 컨트롤의 구간 값 유형"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT117"><Ctl:Text ID="TXT63" runat="server" LangCode="TXT63" Description="ItemCount" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT64" runat="server" LangCode="TXT64" Description="- 해당 컨트롤에 위치 할 아이템 개수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT121"><Ctl:Text ID="TXT65" runat="server" LangCode="TXT65" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT66" runat="server" LangCode="TXT66" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT125"><Ctl:Text ID="TXT67" runat="server" LangCode="TXT67" Description="Value" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT68" runat="server" LangCode="TXT68" Description="- 해당 컨트롤의 Value"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT129"><Ctl:Text ID="TXT69" runat="server" LangCode="TXT69" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT70" runat="server" LangCode="TXT70" Description="- 해당 컨트롤의 스타일"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="Rating Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="설명"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>
        
        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="Rating Control Functions" DefaultHide="False">
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
                        <a href="#TXT137"><Ctl:Text ID="TXT93" runat="server" LangCode="TXT93" Description="GetValue()" Literal="true"></Ctl:Text></a>
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
                        <a href="#TXT153"><Ctl:Text ID="TXT83" runat="server" LangCode="TXT83" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT84" runat="server" LangCode="TXT84" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
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
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="Rating Control Properties Examples" DefaultHide="False">
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
                        <Ctl:Rating ID="ratTITLE" runat="server" DataMember="TITLE" ItemCount="10" ReadMode="false" Value="1"/>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT62"><Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" Description="Gap" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT113" runat="server" LangCode="TXT113" Description="- 해당 컨트롤의 점수 아이템 모양"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT114" runat="server" LangCode="TXT114" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Gap 이 Half 일 때에는 1점당 별 반조각씩 표시한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Gap 이 Full 일 때에는 1점당 별 한조각씩 표시한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT115" runat="server" LangCode="TXT115" Description="
                        <p style='display:inline;color:blue;'>Gap=&#34;Half&#34;</p><br />
                        <p style='display:inline;color:blue;'>Gap=&#34;Full&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME2" runat="server" Gap="Half" ItemCount="8" ReadMode="false" Value="1"/>
                        <Ctl:Rating ID="ratNAME12" runat="server" Gap="Full" ItemCount="8" ReadMode="false" Value="1"/>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT64"><Ctl:Text ID="TXT116" runat="server" LangCode="TXT116" Description="ItemCount" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT117" runat="server" LangCode="TXT117" Description="- 해당 컨트롤의 점수 아이템 개수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT118" runat="server" LangCode="TXT118" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ItemCount 에는 int 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT119" runat="server" LangCode="TXT119" Description="
                        Gap=&#34;Half&#34; <p style='display:inline;color:blue;'>ItemCount=&#34;8&#34;</p>
                        "></Ctl:Text>
                        <br />
                        <Ctl:Text ID="TXT319" runat="server" LangCode="TXT319" Description="
                        Gap=&#34;Full&#34; <p style='display:inline;color:blue;'>ItemCount=&#34;8&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME3" runat="server" Gap="Half" ItemCount="8" ReadMode="false" Value="1"/>
                        <Ctl:Rating ID="ratNAME13" runat="server" Gap="Full" ItemCount="8" ReadMode="false" Value="1"/>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT66"><Ctl:Text ID="TXT120" runat="server" LangCode="TXT120" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT121" runat="server" LangCode="TXT121" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT122" runat="server" LangCode="TXT122" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT123" runat="server" LangCode="TXT123" Description="
                        <p style='display:inline;color:blue;'>ReadMode=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME4" runat="server" Gap="half" ItemCount="10" ReadMode="true" Value="1"/>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT68"><Ctl:Text ID="TXT124" runat="server" LangCode="TXT124" Description="Value" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT125" runat="server" LangCode="TXT125" Description="- 해당 컨트롤의 Value"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT126" runat="server" LangCode="TXT126" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Value 에는 int 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT127" runat="server" LangCode="TXT127" Description="
                        <p style='display:inline;color:blue;'>Value=&#34;3&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME5" runat="server" Gap="Half" ItemCount="10" ReadMode="false" Value="3"/>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT70"><Ctl:Text ID="TXT128" runat="server" LangCode="TXT128" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT129" runat="server" LangCode="TXT129" Description="- 해당 컨트롤의 스타일"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT130" runat="server" LangCode="TXT130" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Style은 기본태그의 Style 처럼 사용할 수 있지만 width와 height 값은 사용할 수 없다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT131" runat="server" LangCode="TXT131" Description="
                        <p style='display:inline;color:blue;'>Style=&#34;border:1px solid red;&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME6" runat="server" Gap="Half" ItemCount="10" ReadMode="false" Value="1" Style="border:1px solid red;"/>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="Region Control Events Examples" DefaultHide="False">
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
        <Ctl:Layer ID="layer8" runat="server" Title="Rating Control Functions Examples" DefaultHide="False">
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
                        <a href="#TXT94"><Ctl:Text ID="TXT136" runat="server" LangCode="TXT136" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT137" runat="server" LangCode="TXT137" Description="- 해당 컨트롤의 Value를 가져온다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT138" runat="server" LangCode="TXT138" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; LangCode가 등록됬을 경우 다국어 언어코드값을 가져오고, 없을경우 Description을 가져온다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).GetValue() 는 string 값을 반환한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT139" runat="server" LangCode="TXT139" Description="
                        <p style='display:inline;color:Blue;'>ratNAME7.GetValue()</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT179"><Ctl:Text ID="TXT140" runat="server" LangCode="TXT140" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT141" runat="server" LangCode="TXT141" Description="- 해당 컨트롤을 숨긴다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT142" runat="server" LangCode="TXT142" Description="" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT143" runat="server" LangCode="TXT143" Description="
                        <p style='display:inline;color:Blue;'>ratNAME8.Hide();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME8" runat="server" Gap="Half" ItemCount="10" ReadMode="false" Value="1" />
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btn1" runat="server" LangCode="TXTBTN1" Description="Hide()" OnClientClick="ratNAME8.Hide();"></Ctl:Button>
                        </div>
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
                        <p style='display:inline;color:Blue;'>ratNAME9.SetDisabled(true);</p> <p style='display:inline;color:Green;'>/* 비활성화 */ </p><br />
                        <p style='display:inline;color:Blue;'>ratNAME9.SetDisabled(false);</p> <p style='display:inline;color:Green;'>/* 활성화 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME9" runat="server" Gap="Half" ItemCount="10" Value="1" />
                        <Ctl:Button ID="btn8" runat="server" LangCode="btn8" Description="비활성화" OnClientClick="ratNAME9.SetDisabled(true);"></Ctl:Button>
                        <Ctl:Button ID="btn9" runat="server" LangCode="btn9" Description="활성화" OnClientClick="ratNAME9.SetDisabled(false);"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT84"><Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT153" runat="server" LangCode="TXT153" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT154" runat="server" LangCode="TXT154" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetValue(str); <p style='display:inline;color:Green;'>/* str 에는 ItemCount 이하의 int타입 Value를 준다. */</p><br />
                         &nbsp;&nbsp;&nbsp;&nbsp;&#183; $(&#34;#conBody_(컨트롤ID)&#34;).find(&#34;span.click_score&#34;).text(str); <p style='display:inline;color:Green;'>/* 점수  Text 변경 시 사용 */</p>
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="
                        <p style='display:inline;color:Blue;'>ratNAME11.SetValue(3);</p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        <p style='display:inline;color:Blue;'>$(&#34;#conBody_ratNAME11&#34;).find(&#34;span.click_score&#34;).text(3);</p> <p style='display:inline;color:Green;'>/* 점수 Text 변경 시 사용 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME11" runat="server" Gap="Half" ItemCount="10" Value="1" />
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRatNAME11" runat="server" LangCode="btnRdo12_2" Description="SetValue()" OnClientClick="ratNAME11_Click();"></Ctl:Button>
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
                        <p style='display:inline;color:Blue;'>ratNAME10.Show();</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratNAME10" runat="server" Gap="Half" ItemCount="10" Value="1" />
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btn6" runat="server" LangCode="btn6" Description="Show()" OnClientClick="ratNAME10.Show();"></Ctl:Button>
                        </div>
                    </td>
                </tr>

            </table>
        </Ctl:Layer>
    </div>
</asp:content>