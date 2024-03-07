<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchView.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.SearchView" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            //샘플 DataSet Grid Bind
            var ht = new Object();
            ht["PageSize"] = "5";
            ht["SearchCondition"] = "";
            grid99.Params(ht);
            grid99.BindList(1);

            // svNAME8 ReadMode 테스트용 값
            svNAME8.SetValue("2563");

            // Show() 테스트를 위한 체크박스 숨김
            svNAME14.Hide();

            //svNAME17 에 CustomParams
            var ht1 = new Object();
            ht1["PageSize"] = 4;
            svNAME17_Layer.CustomParams(ht1);
        }

        function svIDX_Selected(r, dr) {
            return false;
        }

        /********************************************************************************************
        * 함수명      : svNAME10_Selected()
        * 작성목적    : OnSelected 실핼 이벤트
        * Parameter   :
        * Return      :
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-20
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function svNAME10_Selected(r, dr) {
            if (dr != undefined) {
                alert(dr["IDX"]);
            }
        }

        /********************************************************************************************
        * 함수명      : btnsvNAME11_Click()
        * 작성목적    : GetValue()
        * Parameter   :
        * Return      :
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-19
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnsvNAME11_Click() {
            alert(svNAME11.GetValue());
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / SearchView
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="SearchView Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="SearchView Control 기본샘플" DefaultHide="False">
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
                        &#60Ctl:SearchView ID=&#34;svIDX&#34; runat=&#34;server&#34; TypeName=&#34;Template.TemplateBiz&#34; <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MethodName=&#34;ListTemplatePaging&#34; Params=&#34;{'PageSize':5}&#34; PagingSize=&#34;5&#34; PlaceHolder=&#34;공백&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ReadMode=&#34;false&#34; OnSelected=&#34;svIDX_Selected&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SearchViewField runat=&#34;server&#34; DataField=&#34;IDX&#34;   TextField=&#34;IDX&#34;   Description=&#34;문서번호&#34; Hidden=&#34;false&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TextBox=&#34;true&#34; Width=&#34;100&#34; Default=&#34;true&#34;  /&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SearchViewField runat=&#34;server&#34; DataField=&#34;TITLE&#34; TextField=&#34;TITLE&#34; Description=&#34;제목&#34;     Hidden=&#34;false&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TextBox=&#34;true&#34; Width=&#34;100&#34; /&#62<br/>
                        &#60/Ctl:SearchView&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svIDX" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" PlaceHolder="공백" ReadMode="false" OnSelected="svIDX_Selected">
                            <Ctl:SearchViewField runat="server" DataField="IDX"   TextField="IDX"   Description="문서번호" Hidden="false" TextBox="true" Width="100" Default="true"  />
                            <Ctl:SearchViewField runat="server" DataField="TITLE" TextField="TITLE" Description="제목"     Hidden="false" TextBox="true" Width="100" />
                        </Ctl:SearchView>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="SearchView Control 샘플 DataSet" DefaultHide="False">
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
                        <Ctl:Text ID="TXT58" runat="server" LangCode="TXT58" Description="ListTemplatePaging"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid99" runat="server" Paging="false" CheckBox="false" Width="100%" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging">
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
        <Ctl:Layer ID="layer3" runat="server" Title="SearchView Control Properties" DefaultHide="False">
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
                        <a href="#TXT113"><Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="&#60SearchViewField&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="- 해당 컨트롤에 바인딩할 Field"></Ctl:Text>
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
                        <a href="#TXT129"><Ctl:Text ID="TXT69" runat="server" LangCode="TXT69" Description="PagingSize" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT70" runat="server" LangCode="TXT70" Description="- 해당 컨트롤의 PageSize"></Ctl:Text>
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
                        <a href="#TXT318"><Ctl:Text ID="TXT315" runat="server" LangCode="TXT315" Description="CustomParams" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT316" runat="server" LangCode="TXT316" Description="- 해당 컨트롤의 동작전에 미리 Biz에 넘겨줄 파라미터"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT141"><Ctl:Text ID="TXT73" runat="server" LangCode="TXT73" Description="PlaceHolder" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT74" runat="server" LangCode="TXT74" Description="- 해당 컨트롤 공백 시 표시할 설명Text"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT137"><Ctl:Text ID="TXT71" runat="server" LangCode="TXT71" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT72" runat="server" LangCode="TXT72" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
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
        <Ctl:Layer ID="layer4" runat="server" Title="SearchView Control Events" DefaultHide="False">
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
                        <a href="#TXT145"><Ctl:Text ID="TXT75" runat="server" LangCode="TXT75" Description="OnSelected" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT76" runat="server" LangCode="TXT76" Description="- 해당 컨트롤 항목 선택 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="SearchView Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT410" runat="server" LangCode="TXT410" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT411" runat="server" LangCode="TXT411" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT193"><Ctl:Text ID="TXT105" runat="server" LangCode="TXT105" Description="Clear()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT106" runat="server" LangCode="TXT106" Description="- 해당 컨트롤의 값을 초기화한다."></Ctl:Text>
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
                        <a href="#TXT181"><Ctl:Text ID="TXT97" runat="server" LangCode="TXT97" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT98" runat="server" LangCode="TXT98" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT189"><Ctl:Text ID="TXT103" runat="server" LangCode="TXT103" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="- 해당 컨트롤의 비활성화 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT185"><Ctl:Text ID="TXT99" runat="server" LangCode="TXT99" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT100" runat="server" LangCode="TXT100" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="SearchView Control Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT412" runat="server" LangCode="TXT412" Description="Properties"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT413" runat="server" LangCode="TXT413" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT414" runat="server" LangCode="TXT414" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT415" runat="server" LangCode="TXT415" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT416" runat="server" LangCode="TXT416" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT62"><Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" Description="&#60SearchViewField&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT113" runat="server" LangCode="TXT113" Description="- 해당 컨트롤에 바인딩할 Field"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT114" runat="server" LangCode="TXT114" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:red;'>SearchViewField 에 대해서는 SearchViewField Properties 와 Examples 참조한다.</p><br />
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT115" runat="server" LangCode="TXT115" Description="
                        <p style='display:inline;color:blue;'>
                        &#60Ctl:SearchViewField runat=&#34;server&#34; DataField=&#34;IDX&#34; TextField=&#34;IDX&#34; Description=&#34;문서번호&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;Hidden=&#34;false&#34; TextBox=&#34;true&#34; Width=&#34;100&#34; Default=&#34;true&#34; /&#62<br />
                        &#60Ctl:SearchViewField runat=&#34;server&#34; DataField=&#34;TITLE&#34; TextField=&#34;TITLE&#34; Description=&#34;제목&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;Hidden=&#34;false&#34; TextBox=&#34;true&#34; Width=&#34;100&#34; /&#62
                        </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField runat="server" DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" TextBox="true" Width="100" Default="true" />
                            <Ctl:SearchViewField runat="server" DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" TextBox="true" Width="100" />
                        </Ctl:SearchView>
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
                        <p style='display:inline;color:blue;'>MethodName=&#34;ListTemplatePaging&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME4" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT70"><Ctl:Text ID="TXT128" runat="server" LangCode="TXT128" Description="PagingSize" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT129" runat="server" LangCode="TXT129" Description="- 해당 컨트롤의 PageSize"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT130" runat="server" LangCode="TXT130" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; PagingSize 에는 int 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT131" runat="server" LangCode="TXT131" Description="
                        <p style='display:inline;color:blue;'>PagingSize=&#34;8&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME6" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" PagingSize="8" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
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
                        <p style='display:inline;color:blue;'>Params=&#34;{'PageSize':3}&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME5" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':3}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT316"><Ctl:Text ID="TXT317" runat="server" LangCode="TXT317" Description="CustomParams" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT318" runat="server" LangCode="TXT318" Description="- 해당 컨트롤의 동작전에 미리 Biz에 넘겨줄 파라미터"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT319" runat="server" LangCode="TXT319" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; OnLoad 에서 (컨트롤ID)_Layer.CustomParams(<p style='display:inline;color:green;'>/* Hashtable 형태의 데이터 */</p>); 형태로 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT320" runat="server" LangCode="TXT320" Description="
                        <p style='display:inline;color:Green;'>/* OnLoad시 실행 스크립트 */</p><br />
                        var ht1 = new Object();<br />
                        ht1[&#34;PageSize&#34;] = 4;<br />
                        <p style='display:inline;color:blue;'>svNAME17_Layer.CustomParams(ht1)</p>;
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME17" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
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
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Feild의 Default 가 true가 아닌 TextBox에만 Text를 표시한다.<br />
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
                        <Ctl:SearchView ID="svNAME9" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="PlaceHolder">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT72"><Ctl:Text ID="TXT136" runat="server" LangCode="TXT136" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT137" runat="server" LangCode="TXT137" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT138" runat="server" LangCode="TXT138" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 선택된 서치뷰의 값을 표시한다.<br />
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
                        <Ctl:SearchView ID="svNAME8" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="true" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
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
                        <Ctl:SearchView ID="svNAME3" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="SearchView Control Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT417" runat="server" LangCode="TXT417" Description="Events"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT418" runat="server" LangCode="TXT418" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT419" runat="server" LangCode="TXT419" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT420" runat="server" LangCode="TXT420" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT421" runat="server" LangCode="TXT421" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT76"><Ctl:Text ID="TXT144" runat="server" LangCode="TXT144" Description="OnSelected" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT145" runat="server" LangCode="TXT145" Description="- 해당 서치뷰 항목 클릭 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT146" runat="server" LangCode="TXT146" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 서치뷰 항목 클릭 시 OnSelected 에 있는 스크립트를 호출한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 스크립트 정의 시 &#34;스크립트명(r, dr)&#34; 형식으로 사용한다. (r : 바인딩된 field의 Value, dr : 바인딩된 data row) <br />
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT147" runat="server" LangCode="TXT147" Description="
                        <p style='display:inline;color:Blue;'>OnSelected=&#34;svNAME10_Selected&#34;</p>
                        <br /><br />
                        function svNAME10_Selected(r, dr) {<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;if (dr != undefined) {<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;alert(dr[&#34;IDX&#34;]);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br/>
                        }<br/>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME10" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="" OnSelected="svNAME10_Selected">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="SearchView Control Functions Examples" DefaultHide="False">
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
                        <a href="#TXT106"><Ctl:Text ID="TXT192" runat="server" LangCode="TXT192" Description="Clear()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT193" runat="server" LangCode="TXT193" Description="- 해당 컨트롤의 값을 초기화한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT194" runat="server" LangCode="TXT194" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT195" runat="server" LangCode="TXT195" Description="
                        <p style='display:inline;color:Blue;'>svNAME16.Clear();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME16" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnsvNAME16" runat="server" LangCode="btnsvNAME16" Description="Clear()" OnClientClick="svNAME16.Clear();"></Ctl:Button>
                        </div>
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
                        <p style='display:inline;color:Blue;'>svNAME11.GetValue()</p>);
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT98"><Ctl:Text ID="TXT180" runat="server" LangCode="TXT180" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT181" runat="server" LangCode="TXT181" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT182" runat="server" LangCode="TXT182" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 Value로 사용할 Field의 TextBox 를 숨긴다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p style='display:inline;color:Blue;'>svNAME13.Hide();</p>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME13" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnsvNAME13" runat="server" LangCode="btnsvNAME13" Description="Hide()" OnClientClick="svNAME13.Hide();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT104"><Ctl:Text ID="TXT188" runat="server" LangCode="TXT188" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT189" runat="server" LangCode="TXT189" Description="- 해당 컨트롤의 비활성화 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT190" runat="server" LangCode="TXT190" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetDisabled(true | false);
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT191" runat="server" LangCode="TXT191" Description="
                        <p style='display:inline;color:Blue;'>svNAME15.SetDisabled(true);</p> <p style='display:inline;color:Green;'>/* 비활성화 */ </p><br />
                        <p style='display:inline;color:Blue;'>svNAME15.SetDisabled(false);</p> <p style='display:inline;color:Green;'>/* 활성화 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME15" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnsvNAME15_1" runat="server" LangCode="btnsvNAME15_1" Description="비활성화" OnClientClick="svNAME15.SetDisabled(true);"></Ctl:Button>
                            <Ctl:Button ID="btnsvNAME15_2" runat="server" LangCode="btnsvNAME15_2" Description="활성화" OnClientClick="svNAME15.SetDisabled(false);"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT100"><Ctl:Text ID="TXT184" runat="server" LangCode="TXT184" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT185" runat="server" LangCode="TXT185" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT186" runat="server" LangCode="TXT186" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Value 로 사용되는 Field의 숨겨진 TextBox 를 보여준다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT187" runat="server" LangCode="TXT187" Description="
                        <p style='display:inline;color:Blue;'>svNAME14.Show();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME14" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnsvNAME14" runat="server" LangCode="btnChkBox14" Description="Show()" OnClientClick="svNAME14.Show();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>



        <!--SearchViewField Properties-->
        <Ctl:Layer ID="layer9" runat="server" Title="&#60SearchViewField&#62 Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT359" runat="server" LangCode="TXT359" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT360" runat="server" LangCode="TXT360" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT149"><Ctl:Text ID="TXT361" runat="server" LangCode="TXT361" Description="DataField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT362" runat="server" LangCode="TXT362" Description="- 해당 Field의 DataField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT173"><Ctl:Text ID="TXT373" runat="server" LangCode="TXT373" Description="Default" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT374" runat="server" LangCode="TXT374" Description="- 해당 컨트롤의 Value로 사용할 Field 지정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT157"><Ctl:Text ID="TXT365" runat="server" LangCode="TXT365" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT366" runat="server" LangCode="TXT366" Description="- 해당 Field 의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT161"><Ctl:Text ID="TXT367" runat="server" LangCode="TXT367" Description="Hidden" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT368" runat="server" LangCode="TXT368" Description="- 해당 Field의 표시 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT169"><Ctl:Text ID="TXT371" runat="server" LangCode="TXT371" Description="TextBox" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT372" runat="server" LangCode="TXT372" Description="- 해당 Field의 TextBox 표시 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT153"><Ctl:Text ID="TXT363" runat="server" LangCode="TXT363" Description="TextField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT364" runat="server" LangCode="TXT364" Description="- 해당 Field의 헤더에 표시할 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT165"><Ctl:Text ID="TXT369" runat="server" LangCode="TXT369" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT370" runat="server" LangCode="TXT370" Description="- 해당 Field의 너비"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--SearchViewField Properties Examples-->
        <Ctl:Layer ID="layer10" runat="server" Title="&#60SearchViewField&#62 Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT310" runat="server" LangCode="TXT310" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT311" runat="server" LangCode="TXT311" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT312" runat="server" LangCode="TXT312" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT313" runat="server" LangCode="TXT313" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT314" runat="server" LangCode="TXT314" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT362"><Ctl:Text ID="TXT148" runat="server" LangCode="TXT148" Description="DataField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT149" runat="server" LangCode="TXT149" Description="- 해당 Field의 DataField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT150" runat="server" LangCode="TXT150" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="
                        <p style='display:inline;color:blue;'>DataField=&#34;IDX&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2_1" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT374"><Ctl:Text ID="TXT172" runat="server" LangCode="TXT172" Description="Default" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT173" runat="server" LangCode="TXT173" Description="- 해당 컨트롤의 Value로 사용할 Field 지정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT174" runat="server" LangCode="TXT174" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 다중 선택 시 나중에 지정된 Field 를 Value로 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Default에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT175" runat="server" LangCode="TXT175" Description="
                        <p style='display:inline;color:blue;'>Default=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2_7" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT366"><Ctl:Text ID="TXT156" runat="server" LangCode="TXT156" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT157" runat="server" LangCode="TXT157" Description="- 해당 Field 의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT158" runat="server" LangCode="TXT158" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 다국어코드가 등록되지 않았을 경우 Description을 해당 Field의 헤더에 표시한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description이 에는 string 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT159" runat="server" LangCode="TXT159" Description="
                        <p style='display:inline;color:blue;'>Description=&#34;문서번호&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2_3" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT368"><Ctl:Text ID="TXT160" runat="server" LangCode="TXT160" Description="Hidden" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT161" runat="server" LangCode="TXT161" Description="- 해당 Field의 표시 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT162" runat="server" LangCode="TXT162" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Hidden값이 true일 경우 SearchView에서 Field가 숨겨진다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Hidden 에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT163" runat="server" LangCode="TXT163" Description="
                        Description = &#34;제목&#34; <p style='display:inline;color:blue;'>Hidden=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2_4" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="true" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT372"><Ctl:Text ID="TXT168" runat="server" LangCode="TXT168" Description="TextBox" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT169" runat="server" LangCode="TXT169" Description="- 해당 Field의 TextBox 표시 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT170" runat="server" LangCode="TXT170" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; TextBox에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT171" runat="server" LangCode="TXT171" Description="
                        <p style='display:inline;color:blue;'>TextBox=&#34;false&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2_6" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="false" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT364"><Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="TextField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT153" runat="server" LangCode="TXT153" Description="- 해당 Field의 헤더에 표시할 다국어 언어코드 값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT154" runat="server" LangCode="TXT154" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 다국어코드가 등록되지 않았을 경우 Description을 해당 Field의 헤더에 표시한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="
                        <p style='display:inline;color:blue;'>TextField=&#34;IDX&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2_2" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT370"><Ctl:Text ID="TXT164" runat="server" LangCode="TXT164" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT165" runat="server" LangCode="TXT165" Description="- 해당 Field의 너비"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT166" runat="server" LangCode="TXT166" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT167" runat="server" LangCode="TXT167" Description="
                        <p style='display:inline;color:blue;'>Width=&#34;100&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svNAME2_5" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                            <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="true" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>