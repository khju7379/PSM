<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Layer.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.Layer" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            // PageLoad시 이벤트 정의부분

            // show() 기능 테스트용
            layer32.hide();

            // ReadMode 테스트용
            PageProgressShow();
            fuName1.FileLoad("FileUpload", "0", function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });

            fuName2.FileLoad("FileUpload", "0", function () {
            });

            // ReadMode 시 첨부파일 제거 버튼 빠져있음. 제이쿼리로 처리.
            $("#fuName2 .ui-icon-circle-minus").hide();
        }

        function TabChanged(num) {
            if (num == 0) {
                /* 첫번째 탭 클릭 시 */
                alert(0);
            }
            else if (num == 1) { 
                /* 두번째 탭 클릭 시 */
                alert(1);
            }
            else if (num == 2) {
                /* 세번째 탭 클릭 시 */
                alert(2);
            }
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / Layer
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="Layer Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="Layer Control 기본샘플" DefaultHide="False">
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
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="단일 Layer"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="
                        &#60Ctl:Layer ID=&#34;layer21&#34; runat=&#34;server&#34; DefaultHide=&#34;false&#34; Description=&#34;단일 레이어&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LangCode=&#34;TXT10&#34; ReadMode=&#34;false&#34; Title=&#34;레이어 제목&#34;&#62<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:green'>&#60!-- 레이어 내용 작성 --&#62</p><br />
                        &#60/Ctl:Layer&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer21" runat="server" DefaultHide="false" Description="단일 레이어" LangCode="layer21" ReadMode="false" Title="레이어 제목">
                            <Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="레이어 내부영역"></Ctl:Text>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="LayerTap 사용"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="
                        <p style='display:inline;color:Green;'>/* 탭 클릭 시 같은 Index 의 LayerTapBody의 내부영역을 화면에 바인딩된다.<br />
                        모든 Layer 컨트롤 탭 클릭 시 TabChanged()가 실행된다.
                        */</p>
                        <br /><br />
                        &#60Ctl:Layer ID=&#34;layer22&#34; runat=&#34;server&#34; DefaultHide=&#34;false&#34; Description=&#34;LayerTap 사용 Layer&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LangCode=&#34;layer22&#34; ReadMode=&#34;false&#34; Title=&#34;LayerTap 사용 Layer&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTap ID=&#34;tap1&#34; runat=&#34;server&#34; Description=&#34;첫번째&#34; LangCode=&#34;TAP1&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Width=&#34;100px&#34; Title=&#34;첫번째 제목&#34;&#62&#60/Ctl:LayerTap&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTap ID=&#34;tap2&#34; runat=&#34;server&#34; Description=&#34;두번째&#34; LangCode=&#34;TAP2&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Width=&#34;100px&#34; Title=&#34;두번째 제목&#34;&#62&#60/Ctl:LayerTap&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTap ID=&#34;tap3&#34; runat=&#34;server&#34; Description=&#34;세번째&#34; LangCode=&#34;TAP3&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Width=&#34;100px&#34; Title=&#34;세번째 제목&#34;&#62&#60/Ctl:LayerTap&#62<br/>
                            <br />
		                &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTapBody ID=&#34;tap1_body&#34; runat=&#34;server&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60!-- 첫번째 레이어 내부영역 --&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60/Ctl:LayerTapBody&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTapBody ID=&#34;tap2_body&#34; runat=&#34;server&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60!-- 두번째 레이어 내부영역 --&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60/Ctl:LayerTapBody&#62<br/>
		                &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTapBody ID=&#34;tap3_body&#34; runat=&#34;server&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60!-- 세번째 레이어 내부영역 --&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60/Ctl:LayerTapBody&#62<br/>
                        &#60/Ctl:Layer&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer22" runat="server" DefaultHide="false" Description="LayerTap 사용 Layer" LangCode="layer22" ReadMode="false" Title="LayerTap 사용 Layer">
                            <Ctl:LayerTap ID="tap1" runat="server" Description="첫번째" LangCode="TAP1" Width="100px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap2" runat="server" Description="두번째" LangCode="TAP2" Width="100px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap3" runat="server" Description="세번째" LangCode="TAP3" Width="100px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap1_body" runat="server">
                                <Ctl:Text ID="TXT09" runat="server" LangCode="TXT09" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap2_body" runat="server">
                                <Ctl:Text ID="TXT11" runat="server" LangCode="TXT11" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap3_body" runat="server">
                                <Ctl:Text ID="TXT12" runat="server" LangCode="TXT12" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="Layer Control 샘플 DataSet" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="17%" />
                    <col width="13%" />
                    <col width="70%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT13" runat="server" LangCode="TXT13" Description="TypeName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT14" runat="server" LangCode="TXT14" Description="MethodName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT15" runat="server" LangCode="TXT15" Description="DataSet"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="Layer Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT52" runat="server" LangCode="TXT52" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT257"><Ctl:Text ID="TXT63" runat="server" LangCode="TXT63" Description="&#60LayerTap&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT64" runat="server" LangCode="TXT64" Description="- 해당 컨트롤의 탭"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT264"><Ctl:Text ID="TXT65" runat="server" LangCode="TXT65" Description="&#60LayerTapBody&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT66" runat="server" LangCode="TXT66" Description="- 해당 컨트롤의 탭 클릭시 내부영역"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT271"><Ctl:Text ID="TXT53" runat="server" LangCode="TXT53" Description="DefaultHide" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT54" runat="server" LangCode="TXT54" Description="- 해당 컨트롤의 내부영역 숨김 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT276"><Ctl:Text ID="TXT55" runat="server" LangCode="TXT55" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT56" runat="server" LangCode="TXT56" Description="- 해당 컨트롤의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT281"><Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT58" runat="server" LangCode="TXT58" Description="- 해당 컨트롤의 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT286"><Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT290"><Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="Title" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="- 해당 컨트롤의 제목"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="Layer Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="설명"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="Layer Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT357"><Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT156" runat="server" LangCode="TXT156" Description="- 해당 컨트롤의 내부영역을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT362"><Ctl:Text ID="TXT157" runat="server" LangCode="TXT157" Description="show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT158" runat="server" LangCode="TXT158" Description="- 숨겨진 컨트롤의 내부영역을 보여준다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT367"><Ctl:Text ID="TXT103" runat="server" LangCode="TXT103" Description="TabChanged()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="- 모든 컨트롤 탭 변경 시 실행된다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="Layer Control Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT251" runat="server" LangCode="TXT251" Description="Properties"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT252" runat="server" LangCode="TXT252" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT253" runat="server" LangCode="TXT253" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT254" runat="server" LangCode="TXT254" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT255" runat="server" LangCode="TXT255" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT64"><Ctl:Text ID="TXT256" runat="server" LangCode="TXT256" Description="&#60LayerTap&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT257" runat="server" LangCode="TXT257" Description="- 해당 컨트롤의 탭"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT258" runat="server" LangCode="TXT258" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:red;'>SearchViewField 에 대해서는 LayerTap Properties 와 Examples 참조한다.</p><br />
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT259" runat="server" LangCode="TXT259" Description="
                        <p style='display:inline;color:blue;'>
                        &#60Ctl:LayerTap ID=&#34;tap1&#34; runat=&#34;server&#34; Description=&#34;첫번째&#34; LangCode=&#34;TAP1&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;Width=&#34;100px&#34; Title=&#34;첫번째 제목&#34;&#62&#60/Ctl:LayerTap&#62<br />
                        &#60Ctl:LayerTap ID=&#34;tap2&#34; runat=&#34;server&#34; Description=&#34;두번째&#34; LangCode=&#34;TAP2&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;Width=&#34;100px&#34; Title=&#34;두번째 제목&#34;&#62&#60/Ctl:LayerTap&#62<br />
                        &#60Ctl:LayerTap ID=&#34;tap3&#34; runat=&#34;server&#34; Description=&#34;세번째&#34; LangCode=&#34;TAP3&#34;<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;Width=&#34;100px&#34; Title=&#34;세번째 제목&#34;&#62&#60/Ctl:LayerTap&#62<br />
                        </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer23" runat="server" DefaultHide="false" Description="LayerTap 사용 Layer" LangCode="layer23" ReadMode="false" Title="LayerTap 사용 Layer">
                            <Ctl:LayerTap ID="tap11" runat="server" Description="첫번째" LangCode="TAP1" Width="100px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap12" runat="server" Description="두번째" LangCode="TAP2" Width="100px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap13" runat="server" Description="세번째" LangCode="TAP3" Width="100px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap11_body" runat="server">
                                <Ctl:Text ID="TXT260" runat="server" LangCode="TXT260" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap12_body" runat="server">
                                <Ctl:Text ID="TXT261" runat="server" LangCode="TXT261" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap13_body" runat="server">
                                <Ctl:Text ID="TXT262" runat="server" LangCode="TXT262" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT66"><Ctl:Text ID="TXT263" runat="server" LangCode="TXT263" Description="&#60LayerTapBody&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT264" runat="server" LangCode="TXT264" Description="- 해당 컨트롤의 탭 클릭시 내부영역"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT265" runat="server" LangCode="TXT265" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤 탭 클릭 시 같은 Index 의 LayerTapBody의 내부영역을 화면에 바인딩한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT266" runat="server" LangCode="TXT266" Description="
                        <p style='display:inline;color:blue;'>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTapBody ID=&#34;tap1_body24&#34; runat=&#34;server&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60!-- 첫번째 레이어 내부영역 --&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60/Ctl:LayerTapBody&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTapBody ID=&#34;tap2_body24&#34; runat=&#34;server&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60!-- 두번째 레이어 내부영역 --&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60/Ctl:LayerTapBody&#62<br/>
		                &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:LayerTapBody ID=&#34;tap3_body24&#34; runat=&#34;server&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60!-- 세번째 레이어 내부영역 --&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60/Ctl:LayerTapBody&#62
                        </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer24" runat="server" DefaultHide="false" Description="LayerTap 사용 Layer" LangCode="layer24" ReadMode="false" Title="LayerTap 사용 Layer">
                            <Ctl:LayerTap ID="tap21" runat="server" Description="첫번째" LangCode="TAP1" Width="100px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap22" runat="server" Description="두번째" LangCode="TAP2" Width="100px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap23" runat="server" Description="세번째" LangCode="TAP3" Width="100px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap21_body" runat="server">
                                <Ctl:Text ID="TXT267" runat="server" LangCode="TXT267" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap22_body" runat="server">
                                <Ctl:Text ID="TXT268" runat="server" LangCode="TXT268" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap23_body" runat="server">
                                <Ctl:Text ID="TXT269" runat="server" LangCode="TXT269" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT54"><Ctl:Text ID="TXT270" runat="server" LangCode="TXT270" Description="DefaultHide" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT271" runat="server" LangCode="TXT271" Description="- 해당 컨트롤의 내부영역 숨김 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT272" runat="server" LangCode="TXT272" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DefaultHide = &#34;true&#34; 이면 Tab 영역만 표시된다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT273" runat="server" LangCode="TXT273" Description="
                        <p style='display:inline;color:blue;'>DefaultHide=&#34;true&#34;</p> <p style='display:inline;color:Green;'> /* 해당 컨트롤 내부영역에 작성한 TEXT 컨트롤 표시안됨. */</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer25" runat="server" DefaultHide="true" Description="단일 레이어" LangCode="layer24" ReadMode="false" Title="DefaultHide 속성 Layer">
                            <Ctl:Text ID="TXT274" runat="server" LangCode="TXT274" Description="레이어 내부영역"></Ctl:Text>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT56"><Ctl:Text ID="TXT275" runat="server" LangCode="TXT275" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT276" runat="server" LangCode="TXT276" Description="- 해당 컨트롤의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT277" runat="server" LangCode="TXT277" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 다국어코드가 등록되지 않았을 경우 Description을 탭에 표시한다. <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description에는 string 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT278" runat="server" LangCode="TXT278" Description="
                        <p style='display:inline;color:blue;'>Description=&#34;Layer Description&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer26" runat="server" DefaultHide="false" Description="Layer Description" LangCode="layer26" ReadMode="false" Title="Description Layer">
                            <Ctl:Text ID="TXT279" runat="server" LangCode="TXT274" Description="레이어 내부영역"></Ctl:Text>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT58"><Ctl:Text ID="TXT280" runat="server" LangCode="TXT280" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT281" runat="server" LangCode="TXT281" Description="- 해당 컨트롤의 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT282" runat="server" LangCode="TXT282" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 다국어코드가 등록되지 않았을 경우 Description을 컨트롤에 표시한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT283" runat="server" LangCode="TXT283" Description="
                        <p style='display:inline;color:blue;'>LangCode=&#34;layer26&#34;</p> Description=&#34;단일 레이어&#34;
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer27" runat="server" DefaultHide="false" Description="단일 레이어" LangCode="layer27" ReadMode="false" Title="LangCode Layer">
                            <Ctl:Text ID="TXT284" runat="server" LangCode="TXT284" Description="레이어 내부영역"></Ctl:Text>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT60"><Ctl:Text ID="TXT285" runat="server" LangCode="TXT285" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT286" runat="server" LangCode="TXT286" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT287" runat="server" LangCode="TXT287" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 에는 true | false 값을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 이 true 이면 내부영역의 특정 컨트롤들도 ReadMode 가 true가 된다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Combo, CheckBox, Radio, FileUpload)
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT288" runat="server" LangCode="TXT288" Description="
                        <p style='display:inline;color:blue;'>ReadMode=&#34;false&#34;</p> <p style='display:inline;color:green;'> /* 상단 레이어 */ </p><br />
                        <p style='display:inline;color:blue;'>ReadMode=&#34;true&#34;</p> <p style='display:inline;color:green;'> /* 하단 레이어 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer28" runat="server" DefaultHide="false" Description="ReadMode FALSE" LangCode="layer28" ReadMode="false" Title="ReadMode FALSE">
                            <Ctl:Combo ID="cbo1" runat="server" DataMember="IDX" ReadMode="false" SelectedIndex="0" SelectedValue="1" Width="200px" OnChanged="return false;">
                                <asp:ListItem Value="1" Text="첫번째" Selected="true"></asp:ListItem>
                                <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                                <asp:ListItem Value="3" Text="세번째"></asp:ListItem>
                            </Ctl:Combo><br /><br />
                            <Ctl:CheckBox ID="chkBox1" runat="server" ReadMode="false" DataMember="chkBox1_1">
                                <asp:ListItem Text="첫번째" Value="1" ></asp:ListItem>
                                <asp:ListItem Text="두번째" Value="2" Selected="true"></asp:ListItem>
                                <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                            </Ctl:CheckBox><br /><br />
                            <Ctl:Radio ID="rdo1" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return false;">
                                <asp:ListItem Text="첫번째" Value="1" ></asp:ListItem>
                                <asp:ListItem Text="두번째" Value="2" ></asp:ListItem>
                                <asp:ListItem Text="세번째" Value="3" Selected="true"></asp:ListItem>
                            </Ctl:Radio><br /><br />
                            <Ctl:FileUpload ID="fuName1" runat="server" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        </Ctl:Layer>
                        <Ctl:Layer ID="layer29" runat="server" DefaultHide="false" Description="ReadMode TRUE" LangCode="layer29" ReadMode="true" Title="ReadMode TRUE">
                            <Ctl:Combo ID="cbo2" runat="server" DataMember="IDX" ReadMode="false" SelectedIndex="0" SelectedValue="1" Width="200px" OnChanged="return false;">
                                <asp:ListItem Value="1" Text="첫번째" Selected="true"></asp:ListItem>
                                <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                                <asp:ListItem Value="3" Text="세번째"></asp:ListItem>
                            </Ctl:Combo><br /><br />
                            <Ctl:CheckBox ID="chkBox2" runat="server" ReadMode="false" DataMember="chkBox1_1">
                                <asp:ListItem Text="첫번째" Value="1" ></asp:ListItem>
                                <asp:ListItem Text="두번째" Value="2" Selected="true"></asp:ListItem>
                                <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                            </Ctl:CheckBox><br /><br />
                            <Ctl:Radio ID="rdo2" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return false;">
                                <asp:ListItem Text="첫번째" Value="1" ></asp:ListItem>
                                <asp:ListItem Text="두번째" Value="2" ></asp:ListItem>
                                <asp:ListItem Text="세번째" Value="3" Selected="true"></asp:ListItem>
                            </Ctl:Radio><br /><br />
                            <Ctl:FileUpload ID="fuName2" runat="server" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT62"><Ctl:Text ID="TXT289" runat="server" LangCode="TXT289" Description="Title" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT290" runat="server" LangCode="TXT290" Description="- 해당 컨트롤의 제목"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT291" runat="server" LangCode="TXT291" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 다국어코드가 등록되지 않았고 Description이 없으면 탭에 표시한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Title 에는 string 값을 사용한다.<br/>
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT292" runat="server" LangCode="TXT292" Description="
                        <p style='display:inline;color:blue;'>Title=&#34;Layer Title&#34;</p> 
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer30" runat="server" DefaultHide="false" LangCode="layer30" ReadMode="false" Title="Layer Title">
                            <Ctl:Text ID="TXT293" runat="server" LangCode="TXT290" Description="- 레이어 내부영역"></Ctl:Text>
                        </Ctl:Layer>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="Layer Control Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT301" runat="server" LangCode="TXT301" Description="Events"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT302" runat="server" LangCode="TXT302" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT303" runat="server" LangCode="TXT303" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT304" runat="server" LangCode="TXT304" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT305" runat="server" LangCode="TXT305" Description="결과"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer9" runat="server" Title="Layer Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT351" runat="server" LangCode="TXT351" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT352" runat="server" LangCode="TXT352" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT353" runat="server" LangCode="TXT353" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT354" runat="server" LangCode="TXT354" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT355" runat="server" LangCode="TXT355" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT156"><Ctl:Text ID="TXT356" runat="server" LangCode="TXT356" Description="hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT357" runat="server" LangCode="TXT357" Description="- 해당 컨트롤의 내부영역을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT358" runat="server" LangCode="TXT358" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT359" runat="server" LangCode="TXT359" Description="
                        <p style='display:inline;color:blue;'>layer31.hide();</p> 
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer31" runat="server" DefaultHide="false" LangCode="layer31" ReadMode="false" Title="단일 레이어">
                            <Ctl:Text ID="TXT360" runat="server" LangCode="TXT360" Description="- 레이어 내부영역"></Ctl:Text>
                        </Ctl:Layer>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnLayer31" runat="server" LangCode="btnLayer31" Description="hide()" OnClientClick="layer31.hide();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT158"><Ctl:Text ID="TXT361" runat="server" LangCode="TXT361" Description="show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT362" runat="server" LangCode="TXT362" Description="- 숨겨진 컨트롤의 내부영역을 보여준다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT363" runat="server" LangCode="TXT363" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT364" runat="server" LangCode="TXT364" Description="
                        <p style='display:inline;color:blue;'>layer32.show();</p> 
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer32" runat="server" DefaultHide="false" LangCode="layer32" ReadMode="false" Title="단일 레이어">
                            <Ctl:Text ID="TXT365" runat="server" LangCode="TXT365" Description="- 레이어 내부영역"></Ctl:Text>
                        </Ctl:Layer>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnLayer32" runat="server" LangCode="btnLayer32" Description="show()" OnClientClick="layer32.show();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT104"><Ctl:Text ID="TXT366" runat="server" LangCode="TXT366" Description="TabChanged()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT367" runat="server" LangCode="TXT367" Description="- 모든 컨트롤 탭 변경 시 실행된다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT368" runat="server" LangCode="TXT368" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 스크립트 영역에 TabChanged(num) 를 작성한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; num 은 클릭하는 페이지의 인덱스에 따라 0, 1, 2, ... 순으로 입력된다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT369" runat="server" LangCode="TXT369" Description="
                        <p style='display:inline;color:green;'>/* 스크립트 영역에 작성 */</p><br/>
                        function <p style='display:inline;color:blue;'>TabChanged(num)</p> {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;if (num == 0) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:green;'>/* 첫번째 탭 클릭 시 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;alert(0);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;else if (num == 1) { <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:green;'>/* 두번째 탭 클릭 시 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;alert(1);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;else if (num == 2) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:green;'>/* 세번째 탭 클릭 시 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;alert(2);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer33" runat="server" DefaultHide="false" LangCode="layer33" ReadMode="false" Title="TITLE Layer">
                            <Ctl:LayerTap ID="tap31" runat="server" Description="첫번째" LangCode="TAP1" Width="100px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap32" runat="server" Description="두번째" LangCode="TAP2" Width="100px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap33" runat="server" Description="세번째" LangCode="TAP3" Width="100px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap31_body" runat="server">
                                <Ctl:Text ID="TXT370" runat="server" LangCode="TXT370" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap32_body" runat="server">
                                <Ctl:Text ID="TXT371" runat="server" LangCode="TXT371" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap33_body" runat="server">
                                <Ctl:Text ID="TXT372" runat="server" LangCode="TXT372" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--LayerTap Properties List-->
        <Ctl:Layer ID="layer6" runat="server" Title="&#60LayerTap&#62 Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT201" runat="server" LangCode="TXT201" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT202" runat="server" LangCode="TXT202" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT408"><Ctl:Text ID="TXT203" runat="server" LangCode="TXT203" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT204" runat="server" LangCode="TXT204" Description="- 해당 탭의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT415"><Ctl:Text ID="TXT205" runat="server" LangCode="TXT205" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="- 해당 탭의 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT422"><Ctl:Text ID="TXT207" runat="server" LangCode="TXT207" Description="Title" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT208" runat="server" LangCode="TXT208" Description="- 해당 탭의 제목"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT429"><Ctl:Text ID="TXT209" runat="server" LangCode="TXT209" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="- 해당 탭의 너비"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--LayerTap Properties Examples-->
        <Ctl:Layer ID="layer10" runat="server" Title="&#60LayerTap&#62 Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT401" runat="server" LangCode="TXT401" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT402" runat="server" LangCode="TXT402" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT403" runat="server" LangCode="TXT403" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT404" runat="server" LangCode="TXT404" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT405" runat="server" LangCode="TXT405" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT204"><Ctl:Text ID="TXT406" runat="server" LangCode="TXT406" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT408" runat="server" LangCode="TXT408" Description="- 해당 탭의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT409" runat="server" LangCode="TXT409" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 탭에 다국어코드가 등록되지 않았을 경우 Description을 탭에 표시한다. <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description에는 string 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT410" runat="server" LangCode="TXT410" Description="
                        <p style='display:inline;color:blue;'>Description=&#34;첫번째&#34; </p><p style='display:inline;color:green;'>/* 첫번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>Description=&#34;두번째&#34; </p><p style='display:inline;color:green;'>/* 두번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>Description=&#34;세번째&#34; </p><p style='display:inline;color:green;'>/* 세번째 LayerTap */</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer34" runat="server" DefaultHide="false" LangCode="layer34" ReadMode="false" Title="Description">
                            <Ctl:LayerTap ID="tap41" runat="server" Description="첫번째" LangCode="TAP1" Width="100px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap42" runat="server" Description="두번째" LangCode="TAP2" Width="100px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap43" runat="server" Description="세번째" LangCode="TAP3" Width="100px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap41_body" runat="server">
                                <Ctl:Text ID="TXT411" runat="server" LangCode="TXT411" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap42_body" runat="server">
                                <Ctl:Text ID="TXT412" runat="server" LangCode="TXT412" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap43_body" runat="server">
                                <Ctl:Text ID="TXT413" runat="server" LangCode="TXT413" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT206"><Ctl:Text ID="TXT414" runat="server" LangCode="TXT414" Description="LangCode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT415" runat="server" LangCode="TXT415" Description="- 해당 탭의 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT416" runat="server" LangCode="TXT416" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 탭에 다국어코드가 등록되지 않았을 경우 Description을 탭에 표시한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT417" runat="server" LangCode="TXT417" Description="
                        <p style='display:inline;color:blue;'>LangCode=&#34;TXT418&#34;</p> Description=&#34;첫번째&#34; <p style='display:inline;color:green;'>/* 첫번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>LangCode=&#34;TXT418&#34;</p> Description=&#34;두번째&#34; <p style='display:inline;color:green;'>/* 두번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>LangCode=&#34;TXT418&#34;</p> Description=&#34;세번째&#34; <p style='display:inline;color:green;'>/* 세번째 LayerTap */</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer35" runat="server" DefaultHide="false" LangCode="layer35" ReadMode="false" Title="Description">
                            <Ctl:LayerTap ID="tap51" runat="server" Description="첫번째" LangCode="TAP1" Width="100px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap52" runat="server" Description="두번째" LangCode="TAP2" Width="100px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap53" runat="server" Description="세번째" LangCode="TAP3" Width="100px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap51_body" runat="server">
                                <Ctl:Text ID="TXT418" runat="server" LangCode="TXT418" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap52_body" runat="server">
                                <Ctl:Text ID="TXT419" runat="server" LangCode="TXT419" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap53_body" runat="server">
                                <Ctl:Text ID="TXT420" runat="server" LangCode="TXT420" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT208"><Ctl:Text ID="TXT421" runat="server" LangCode="TXT421" Description="Title" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT422" runat="server" LangCode="TXT422" Description="- 해당 탭의 제목"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT423" runat="server" LangCode="TXT423" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 탭에 다국어코드가 등록되지 않았고 Description이 없으면 탭에 표시한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Title 에는 string 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT424" runat="server" LangCode="TXT424" Description="
                        <p style='display:inline;color:blue;'>Title=&#34;첫번째 제목&#34;</p> <p style='display:inline;color:green;'>/* 첫번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>Title=&#34;두번째 제목&#34;</p> <p style='display:inline;color:green;'>/* 두번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>Title=&#34;세번째 제목&#34;</p> <p style='display:inline;color:green;'>/* 세번째 LayerTap */</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer36" runat="server" DefaultHide="false" LangCode="layer35" ReadMode="false" Title="Description">
                            <Ctl:LayerTap ID="tap61" runat="server" LangCode="TAP1" Width="100px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap62" runat="server" LangCode="TAP2" Width="100px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap63" runat="server" LangCode="TAP3" Width="100px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap61_body" runat="server">
                                <Ctl:Text ID="TXT425" runat="server" LangCode="TXT425" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap62_body" runat="server">
                                <Ctl:Text ID="TXT426" runat="server" LangCode="TXT426" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap63_body" runat="server">
                                <Ctl:Text ID="TXT427" runat="server" LangCode="TXT427" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT210"><Ctl:Text ID="TXT428" runat="server" LangCode="TXT428" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT429" runat="server" LangCode="TXT429" Description="- 해당 탭의 너비"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT430" runat="server" LangCode="TXT430" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT431" runat="server" LangCode="TXT431" Description="
                        <p style='display:inline;color:blue;'>Width=&#34;70px&#34;</p> <p style='display:inline;color:green;'>/* 첫번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>Width=&#34;90px&#34;</p> <p style='display:inline;color:green;'>/* 두번째 LayerTap */</p><br />
                        <p style='display:inline;color:blue;'>Width=&#34;120px&#34;</p> <p style='display:inline;color:green;'>/* 세번째 LayerTap */</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer37" runat="server" DefaultHide="false" LangCode="layer35" ReadMode="false" Title="Description">
                            <Ctl:LayerTap ID="tap71" runat="server" LangCode="TAP1" Description="첫번째" Width="70px" Title="첫번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap72" runat="server" LangCode="TAP2" Description="두번째" Width="90px" Title="두번째 제목"></Ctl:LayerTap>
                            <Ctl:LayerTap ID="tap73" runat="server" LangCode="TAP3" Description="세번째" Width="120px" Title="세번째 제목"></Ctl:LayerTap>
		                    <Ctl:LayerTapBody ID="tap71_body" runat="server">
                                <Ctl:Text ID="TXT432" runat="server" LangCode="TXT432" Description="첫번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap72_body" runat="server">
                                <Ctl:Text ID="TXT433" runat="server" LangCode="TXT433" Description="두번째 레이어 내부영역"></Ctl:Text>
                            </Ctl:LayerTapBody>
		                    <Ctl:LayerTapBody ID="tap73_body" runat="server">
                                <Ctl:Text ID="TXT434" runat="server" LangCode="TXT434" Description="세번째 레이어 내부영역"></Ctl:Text> 
                            </Ctl:LayerTapBody>
                        </Ctl:Layer>
                    </td>
                </tr>


            </table>
        </Ctl:Layer>
    </div>
</asp:content>