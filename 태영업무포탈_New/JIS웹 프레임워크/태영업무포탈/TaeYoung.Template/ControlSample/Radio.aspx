<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Radio.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.Radio" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            //샘플 DataSet Grid Bind
            var ht = new Object();
            ht["PageSize"] = "5";
            grid99.Params(ht);
            grid99.BindList(1);

            // Show() 테스트를 위한 라디오버튼 숨김
            rdo14.Hide();

            // rdo16 라디오버튼 BindList
            setRdo16();

            //rdo17 CallBack함수
            rdo17.CallBack = function () {
                alert();
            };
        }

        /********************************************************************************************
        * 함수명      : rdo18_Click()
        * 작성목적    : 라디오 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-19
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function rdo18_Click() {
            alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="스크립트 호출" Literal="true"></Ctl:Text>');
            return true;
        }

        /********************************************************************************************
        * 함수명      : btnRdo10_Click()
        * 작성목적    : GetValue() 출력 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-19
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnRdo10_Click() {
            alert(rdo10.GetValue());
            return false;
        }

        /********************************************************************************************
        * 함수명      : btnRdo11_Click()
        * 작성목적    : GetText() 출력 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-19
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnRdo11_Click() {
            alert(rdo11.GetText());
            return false;
        }

        /********************************************************************************************
        * 함수명      : setRdo16()
        * 작성목적    : 라디오버튼 데이터 바인딩
        * Parameter   :
        * Return      :
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-19
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function setRdo16() {
            /* 데이터 바인딩 시 필요 속성 값을 스크립트에서 지정한다. */
            rdo16.TypeName = "Template.TemplateBiz";
            rdo16.MethodName = "ListTemplate";
            rdo16.DataTextField = "TITLE";
            rdo16.DataValueField = "IDX";

            /* 데이터 바인딩 시 넘길 파라미터 */
            var ht = new Object();
            ht["PageSize"] = 3;
            rdo16.Params(ht);

            /* 데이터 바인딩 */
            rdo16.BindList();

            return false;
        }


        /********************************************************************************************
        * 함수명      : setrdoTest2()
        * 작성목적    : rdoTest2 rdo 에 설정
        * Parameter   :
        * Return      :
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-11
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function setrdoTest2() {
            var ht = new Object();

            rdoTest4.TypeName = "Template.TemplateBiz";
            rdoTest4.MethodName = "ListTemplate";
            rdoTest4.DataTextField = "TITLE";
            rdoTest4.DataValueField = "IDX";
            rdoTest4.Params(ht);
            rdoTest4.BindList();
            rdoTest4.CallBack = function () {
            };
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / Radio
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="Radio Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="Radio Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="15%" />
                    <col width="50%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="구분"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT50" runat="server" LangCode="TXT50" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="&#60ListItem&#62 사용"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT53" runat="server" LangCode="TXT53" Description="
                            &#60Ctl:Radio ID=&#34;rdoIDX1&#34; runat=&#34;server&#34; DataMember=&#34;IDX&#34; ReadMode=&#34;false&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OnChanged=&#34;return true;&#34; &#62<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Text=&#34;첫번째&#34; Value=&#34;1&#34; Selected=&#34;false&#34; &#62&#60/asp:ListItem&#62<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Text=&#34;두번째&#34; Value=&#34;2&#34; &#62&#60/asp:ListItem&#62<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Text=&#34;세번째&#34; Value=&#34;3&#34; &#62&#60/asp:ListItem&#62<br />
                            &#60/Ctl:Radio&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdoIDX1" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return false;">
                            <asp:ListItem Text="첫번째" Value="1" Selected="true"></asp:ListItem>
                            <asp:ListItem Text="두번째" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                        </Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="데이터 바이딩"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="
                        &#60Ctl:Radio ID=&#34;rdoIDX2&#34; runat=&#34;server&#34; DataMember=&#34;IDX&#34;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TypeName=&#34;Template.TemplateBiz&#34; MethodName=&#34;ListTemplate&#34; Params=&#34;{'PageSize':3}&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DataTextField=&#34;TITLE&#34;  DataValueField=&#34;IDX&#34; ReadMode=&#34;false&#34; OnChanged=&#34;return false;&#34; &#62<br />
                        &#60/Ctl:Radio&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdoIDX2" runat="server" DataMember="IDX" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':3}" DataTextField="TITLE"  DataValueField="IDX" ReadMode="false" OnChanged="return false;">
                        </Ctl:Radio>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="Radio Control 샘플 DataSet" DefaultHide="False">
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
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="Template.TemplateBiz"></Ctl:Text>
                    </td>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT58" runat="server" LangCode="TXT58" Description="ListTemplate"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid99" runat="server" Paging="false" CheckBox="false" Width="100%" TypeName="Template.TemplateBiz" MethodName="ListTemplate">
                            <Ctl:SheetField DataField="NO" TextField="NO" Description="NO" Width="50"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="ROWNO" Width="60"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="IDX" TextField="IDX" Description="IDX" Width="40"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="TITLE" TextField="TITLE" Description="TITLE" Width="60"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATEDT" TextField="CREATEDT" Description="CREATEDT" Width="150"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATENM" TextField="CREATENM" Description="CREATENM" Width="80"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="NUM" TextField="NUM" Description="NUM" Width="120"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATEDT2" TextField="CREATEDT2" Description="CREATEDT2" Width="80"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="Radio Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT101"><Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="&#60ListItem&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="- 해당 컨트롤의 라디오버튼을 직접 추가한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT141"><Ctl:Text ID="TXT75" runat="server" LangCode="TXT75" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT76" runat="server" LangCode="TXT76" Description="- 해당 컨트롤의 DataMember 값 지정"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT129"><Ctl:Text ID="TXT69" runat="server" LangCode="TXT69" Description="DataTextField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT70" runat="server" LangCode="TXT70" Description="- 해당 컨트롤의 TextField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT133"><Ctl:Text ID="TXT71" runat="server" LangCode="TXT71" Description="DataValueField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT72" runat="server" LangCode="TXT72" Description="- 해당 컨트롤의 ValueField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT121"><Ctl:Text ID="TXT65" runat="server" LangCode="TXT65" Description="MethodName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT66" runat="server" LangCode="TXT66" Description="- 해당 컨트롤의 Biz의 메소드명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT125"><Ctl:Text ID="TXT67" runat="server" LangCode="TXT67" Description="Params" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT68" runat="server" LangCode="TXT68" Description="- 해당 컨트롤의 Biz에 넘겨줄 파라미터"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT137"><Ctl:Text ID="TXT73" runat="server" LangCode="TXT73" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT74" runat="server" LangCode="TXT74" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT117"><Ctl:Text ID="TXT63" runat="server" LangCode="TXT63" Description="TypeName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT64" runat="server" LangCode="TXT64" Description="- 해당 컨트롤의 Biz명"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="Radio Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT203"><Ctl:Text ID="TXT200" runat="server" LangCode="TXT200" Description="OnChanged" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT201" runat="server" LangCode="TXT201" Description="- 해당 컨트롤 값 변경 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="Radio Control Functions" DefaultHide="False">
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
                        <a href="#TXT169"><Ctl:Text ID="TXT91" runat="server" LangCode="TXT91" Description="BindList()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT92" runat="server" LangCode="TXT92" Description="- 해당 컨트롤을 데이터 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT173"><Ctl:Text ID="TXT93" runat="server" LangCode="TXT93" Description="CallBack()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT94" runat="server" LangCode="TXT94" Description="- 해당 컨트롤을 데이터 바인딩 후 콜백함수 호출"></Ctl:Text>
                    </td>
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
                        <a href="#TXT149"><Ctl:Text ID="TXT81" runat="server" LangCode="TXT81" Description="GetText()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT82" runat="server" LangCode="TXT82" Description="- 해당 컨트롤의 Text를 가져온다."></Ctl:Text>
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
                        <a href="#TXT157"><Ctl:Text ID="TXT85" runat="server" LangCode="TXT85" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT86" runat="server" LangCode="TXT86" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT165"><Ctl:Text ID="TXT89" runat="server" LangCode="TXT89" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT90" runat="server" LangCode="TXT90" Description="- 해당 컨트롤의 비활성화 여부를 변경한다."></Ctl:Text>
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
                        <a href="#TXT161"><Ctl:Text ID="TXT87" runat="server" LangCode="TXT87" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT88" runat="server" LangCode="TXT88" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="Radio Control Properties Examples" DefaultHide="False">
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
                        <a href="#TXT62"><Ctl:Text ID="TXT100" runat="server" LangCode="TXT100" Description="&#60ListItem&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="- 해당 컨트롤의 라디오버튼을 직접 추가한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 데이터 바인딩 시 직접 추가한 내용보다 바인딩된 내용이 우선된다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Text:라디오버튼의 Text, Value:라디오버튼의 Value, Selected:라디오버튼의 Default 선택
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT115" runat="server" LangCode="TXT115" Description="
                        <p style='display:inline;color:blue;'>&#60asp:ListItem Text=&#34;첫번째&#34; Value=&#34;1&#34; Selected=&#34;true&#34;&#62&#60/asp:ListItem&#62<br />
                        &#60asp:ListItem Text=&#34;두번째&#34; Value=&#34;2&#34; &#62&#60/asp:ListItem&#62<br />
                        &#60asp:ListItem Text=&#34;세번째&#34; Value=&#34;3&#34; &#62&#60/asp:ListItem&#62</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo2" runat="server">
                            <asp:ListItem Text="첫번째" Value="1"  Selected="true"></asp:ListItem>
                            <asp:ListItem Text="두번째" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                        </Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT76"><Ctl:Text ID="TXT140" runat="server" LangCode="TXT140" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT141" runat="server" LangCode="TXT141" Description="- 해당 컨트롤의 DataMember 값 지정"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT142" runat="server" LangCode="TXT142" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 에는 조회하는 데이터의 칼럼 명을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 로 지정한 컨트롤들의 Value를 Controls.GetDataMemberValue() 로 가져오거나<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Controls.SetDataMemberValue() 로 Value에 바인딩한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT143" runat="server" LangCode="TXT143" Description="
                        <p style='display:inline;color:blue;'>DataMember=&#34;TITLE&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo9" runat="server" DataMember="TITLE">
                            <asp:ListItem Value="1" Text="첫번째"></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                            <asp:ListItem Value="3" Text="세번째"></asp:ListItem>
                        </Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT70"><Ctl:Text ID="TXT128" runat="server" LangCode="TXT128" Description="DataTextField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT129" runat="server" LangCode="TXT129" Description="- 해당 컨트롤의 TextField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT130" runat="server" LangCode="TXT130" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT131" runat="server" LangCode="TXT131" Description="
                        <p style='display:inline;color:blue;'>DataTextField=&#34;TITLE&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo6" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':5}" DataTextField="TITLE"  DataValueField="IDX"></Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT72"><Ctl:Text ID="TXT132" runat="server" LangCode="TXT132" Description="DataValueField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT133" runat="server" LangCode="TXT133" Description="- 해당 컨트롤의 ValueField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT134" runat="server" LangCode="TXT134" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT135" runat="server" LangCode="TXT135" Description="
                        <p style='display:inline;color:blue;'>DataValueField=&#34;IDX&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo7" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':5}" DataTextField="TITLE"  DataValueField="IDX"></Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT66"><Ctl:Text ID="TXT120" runat="server" LangCode="TXT120" Description="MethodName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT121" runat="server" LangCode="TXT121" Description="- 해당 컨트롤의 Biz의 메소드명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT122" runat="server" LangCode="TXT122" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT123" runat="server" LangCode="TXT123" Description="
                        <p style='display:inline;color:blue;'>MethodName=&#34;ListTemplate&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo4" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':5}" DataTextField="TITLE"  DataValueField="IDX"></Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT68"><Ctl:Text ID="TXT124" runat="server" LangCode="TXT124" Description="Params" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT125" runat="server" LangCode="TXT125" Description="- 해당 컨트롤의 Biz에 넘겨줄 파라미터"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT126" runat="server" LangCode="TXT126" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 다중 파라미터 사용 시 {'파라미터명1':파라미터값1 , '파라미터명2':파라미터값2} 형식으로 사용.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT127" runat="server" LangCode="TXT127" Description="
                        <p style='display:inline;color:blue;'>Params=&#34;{'PageSize':8}&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo5" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':8}" DataTextField="TITLE"  DataValueField="IDX"></Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT74"><Ctl:Text ID="TXT136" runat="server" LangCode="TXT136" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT137" runat="server" LangCode="TXT137" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT138" runat="server" LangCode="TXT138" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 선택한 라디오버튼의 Text를 표시한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT139" runat="server" LangCode="TXT139" Description="
                        <p style='display:inline;color:blue;'>ReadMode=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo8" runat="server" ReadMode="true">
                            <asp:ListItem Text="첫번째" Value="1" ></asp:ListItem>
                            <asp:ListItem Text="두번째" Value="2" Selected="true"></asp:ListItem>
                            <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                        </Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT64"><Ctl:Text ID="TXT116" runat="server" LangCode="TXT116" Description="TypeName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT117" runat="server" LangCode="TXT117" Description="- 해당 컨트롤의 Biz명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT118" runat="server" LangCode="TXT118" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT119" runat="server" LangCode="TXT119" Description="
                        <p style='display:inline;color:blue;'>TypeName=&#34;Template.TemplateBiz&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo3" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':5}" DataTextField="TITLE"  DataValueField="IDX"></Ctl:Radio>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="Radio Control Events Examples" DefaultHide="False">
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
                        <a href="#TXT201"><Ctl:Text ID="TXT202" runat="server" LangCode="TXT202" Description="OnChanged" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT203" runat="server" LangCode="TXT203" Description="- 해당 컨트롤 값 변경 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT204" runat="server" LangCode="TXT204" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤 값 변경 시 OnChanged 에 있는 스크립트를 호출한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT205" runat="server" LangCode="TXT205" Description="
                        <p style='display:inline;color:blue;'>OnChanged=&#34;alert();&#34</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo18" runat="server" DataMember="chkBox1_2" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':5}" DataTextField="TITLE"  DataValueField="IDX" ReadMode="false" OnChanged="alert();">
                        </Ctl:Radio>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="Radio Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT305" runat="server" LangCode="TXT305" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT306" runat="server" LangCode="TXT306" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT307" runat="server" LangCode="TXT307" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT308" runat="server" LangCode="TXT308" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT309" runat="server" LangCode="TXT309" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT92"><Ctl:Text ID="TXT168" runat="server" LangCode="TXT168" Description="BindList()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT169" runat="server" LangCode="TXT169" Description="- 해당 컨트롤을 데이터 바인딩."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT170" runat="server" LangCode="TXT170" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 데이터 바인딩에 필요한 속성을 스크립트에서 지정한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT171" runat="server" LangCode="TXT171" Description="
                        <p style='display:inline;color:Green;'>/* OnLoad시 실행 스크립트 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 데이터 바인딩 시 필요 속성 값을 스크립트에서 지정한다. */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;rdo16.TypeName = &#34;Template.TemplateBiz&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;rdo16.MethodName = &#34;ListTemplate&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;rdo16.DataTextField = &#34;TITLE&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;rdo16.DataValueField = &#34;IDX&#34;;<br />
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 데이터 바인딩 시 넘길 파라미터 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;var ht = new Object();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;ht[&#34;PageSize&#34;] = 3;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;rdo16.Params(ht);<br />
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 데이터 바인딩 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Blue;'>rdo16.BindList();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo16" runat="server"></Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT94"><Ctl:Text ID="TXT172" runat="server" LangCode="TXT172" Description="CallBack()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT173" runat="server" LangCode="TXT173" Description="- 해당 컨트롤을 데이터 바인딩 후 콜백함수 호출"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT174" runat="server" LangCode="TXT174" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT175" runat="server" LangCode="TXT175" Description="
                        <p style='display:inline;color:Green;'>/* OnLoad 에서 rdo17 CallBack함수 */</p><br />
                        <p style='display:inline;color:Blue;'>rdo17.CallBack = function () {</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;alert();<br />
                        <p style='display:inline;color:Blue;'>};</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo17" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'PageSize':5}" DataTextField="TITLE"  DataValueField="IDX"></Ctl:Radio>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRdo17" runat="server" LangCode="btnRdo17" Description="BindList()" OnClientClick="rdo17.BindList();"></Ctl:Button>
                        </div>
                    </td>
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
                        <a href="#TXT82"><Ctl:Text ID="TXT148" runat="server" LangCode="TXT148" Description="GetText()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT149" runat="server" LangCode="TXT149" Description="- 해당 컨트롤의 Text를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT150" runat="server" LangCode="TXT150" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).GetText() 는 string 값을 반환한다.(미선택시 null 반환)
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="
                        <p style='display:inline;color:Blue;'>rdo11.GetText()</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT80"><Ctl:Text ID="TXT144" runat="server" LangCode="TXT144" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT145" runat="server" LangCode="TXT145" Description="- 해당 컨트롤의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT146" runat="server" LangCode="TXT146" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).GetValue() 는 string 값을 반환한다.(미선택시 null 반환)
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT147" runat="server" LangCode="TXT147" Description="
                       <p style='display:inline;color:Blue;'>rdo10.GetValue()</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT86"><Ctl:Text ID="TXT156" runat="server" LangCode="TXT156" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT157" runat="server" LangCode="TXT157" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT158" runat="server" LangCode="TXT158" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT159" runat="server" LangCode="TXT159" Description="
                        <p style='display:inline;color:Blue;'>rdo13.Hide();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo13" runat="server">
                            <asp:ListItem Value="1" Text="첫번째"></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                            <asp:ListItem Value="3" Text="세번째"></asp:ListItem>
                        </Ctl:Radio>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRdo13" runat="server" LangCode="btnRdo13" Description="Hide()" OnClientClick="rdo13.Hide();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT90"><Ctl:Text ID="TXT164" runat="server" LangCode="TXT164" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT165" runat="server" LangCode="TXT165" Description="- 해당 컨트롤의 비활성화 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT166" runat="server" LangCode="TXT166" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetDisabled(true | false); <br />
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT167" runat="server" LangCode="TXT167" Description="
                        <p style='display:inline;color:Blue;'>rdo15.SetDisabled(true);</p> <p style='display:inline;color:Green;'>/* 비활성화 */</p><br />
                        <p style='display:inline;color:Blue;'>rdo15.SetDisabled(false);</p> <p style='display:inline;color:Green;'>/* 활성화 */</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo15" runat="server">
                            <asp:ListItem Value="1" Text="첫번째"></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                            <asp:ListItem Value="3" Text="세번째"></asp:ListItem>
                        </Ctl:Radio>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRdo15_1" runat="server" LangCode="btnRdo15_1" Description="비활성화" OnClientClick="rdo15.SetDisabled(true);"></Ctl:Button>
                            <Ctl:Button ID="btnRdo15_2" runat="server" LangCode="btnRdo15_2" Description="활성화" OnClientClick="rdo15.SetDisabled(false);"></Ctl:Button>
                        </div>
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
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetValue(str); <p style='display:inline;color:Green;'>/* str 변수에는 변경할 값을 준다. */</p> <br/>
                         &nbsp;&nbsp;&nbsp;&nbsp;&#183; str = Value, 선택해제 시 : str = &#34;&#34;
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="
                        <p style='display:inline;color:Blue;'>rdo12.SetValue(1);</p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* Value=1 인 &#34;첫번째&#34; 라디오버튼 */</p><br />
                        <p style='display:inline;color:Blue;'>rdo12.SetValue(&#34;&#34;);</p>&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 선택해제 */</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo12" runat="server">
                            <asp:ListItem Text="첫번째" Value="1"></asp:ListItem>
                            <asp:ListItem Text="두번째" Value="2"></asp:ListItem>
                            <asp:ListItem Text="세번째" Value="3"></asp:ListItem>
                        </Ctl:Radio>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRdo12_2" runat="server" LangCode="btnRdo12_2" Description="첫번째 라디오버튼" OnClientClick="rdo12.SetValue(1);"></Ctl:Button>
                            <Ctl:Button ID="btnRdo12_1" runat="server" LangCode="btnRdo12_1" Description="선택해제" OnClientClick="rdo12.SetValue('');"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT88"><Ctl:Text ID="TXT160" runat="server" LangCode="TXT160" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT161" runat="server" LangCode="TXT161" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT162" runat="server" LangCode="TXT162" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT163" runat="server" LangCode="TXT163" Description="
                        <p style='display:inline;color:Blue;'>rdo14.Show();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdo14" runat="server">
                            <asp:ListItem Value="1" Text="첫번째"></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                            <asp:ListItem Value="3" Text="세번째"></asp:ListItem>
                        </Ctl:Radio>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRdo14" runat="server" LangCode="btnRdo14" Description="Show()" OnClientClick="rdo14.Show();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>