<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChartFxScript.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.ChartFxScript" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            //샘플 DataSet Grid Bind
            var ht = new Object();
            ht["PageSize"] = "5";
            grid99.Params(ht);
            grid99.BindList(1);


        }

        /************************************************************************
        함수명		: fn_Redirect
        작성목적	: 해당 페이지로 이동한다.
        작 성 자	: 이정홍
        최초작성일	: 2018-06-07
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function fn_Redirect(url) {
            self.location.href = "/WebTemplate/ControlSample/" + url + ".aspx";
            return false;
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / ChartFxScript
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="ChartFxScript Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="ChartFxScript Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="65%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="
                        <p style='display:inline;color:Green;'> /* 차트 스크립트 정의  */ </p><br/>
                        &#60Ctl:ChartFxScript ID=&#34;chart_script&#34; runat=&#34;server&#34;&#62&#60/Ctl:ChartFxScript&#62<br/>
                        <br/>
                        <p style='display:inline;color:Green;'> /* 차트를 바인딩할 div */ </p><br/>
                        &#60div id=&#34;chart1&#34; style=&#34;width:280px;height:280px;display:inline-block;&#34;&#62&#60/div&#62<br />
                        <br />
                        <p style='display:inline;color:Green;'> /* 차트 선언 및 바인딩 */ </p><br/>
                        &#60script type=&#34;text/javascript&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'> /* 차트 컨트롤 선언 */ </p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;var chart1 = new jChartFX(cfx.Gallery.Bar, &#34;chart1&#34;, true, true);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'> /* 차트 초기화 함수 */ </p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;function JFxChartInit(chart) {<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chart.Initialize();<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chart.InitConfig = function () {<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chart.Chart.setCulture(_cuture_info);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chart.Chart.getLegendBox().setVisible(true);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chart.Chart.getAllSeries().getPointLabels().setVisible(true);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var title;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;title = new cfx.TitleDockable();<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;title.setText(&#34;테스트 차트&#34;);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chart.Chart.getTitles().add(title);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;JFxChartInit(chart1); <p style='display:inline;color:Green;'> /* 차트 초기화 */ </p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'> /* 차트 데이터 바인딩 */ </p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;var ht = new Object();<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;PageMethods.InvokeServiceTable(ht, &#34;Template.TemplateBiz&#34;, &#34;GetChart&#34;, function (e) {<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var dataSet = eval(e);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'> /* 차트 바인드 */ </p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chart1.DataBind(dataSet.Tables[0].Rows);<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;});<br/>
                        &#60/script&#62
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트 스크립트 정의 -->
                        <Ctl:ChartFxScript ID="chart_script" runat="server"></Ctl:ChartFxScript>

                        <!-- 차트를 바인딩할 div -->
                        <div id="chart1" style="width:280px;height:280px;display:inline-block;"></div>

                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart1 = new jChartFX(cfx.Gallery.Bar, "chart1", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(true);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(true);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit(chart1); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht = new Object();
                            PageMethods.InvokeServiceTable(ht, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart1.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="ChartFxScript Control 샘플 DataSet" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="17%" />
                    <col width="13%" />
                    <col width="70%" />
                </colgroup>
                <tr>
                    <th rowspan="2">
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="TypeName"></Ctl:Text>
                    </th>
                    <th rowspan="2">
                        <Ctl:Text ID="TXT52" runat="server" LangCode="TXT52" Description="MethodName"></Ctl:Text>
                    </th>
                     <th>
                        <Ctl:Text ID="TXT53" runat="server" LangCode="TXT53" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT54" runat="server" LangCode="TXT54" Description="DataSet"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="2" style="text-align:center;">
                        <Ctl:Text ID="TXT55" runat="server" LangCode="TXT55" Description="Template.TemplateBiz"></Ctl:Text>
                    </td>
                    <td rowspan="2" style="text-align:center;">
                        <Ctl:Text ID="TXT56" runat="server" LangCode="TXT56" Description="GetChart"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="
                        - 차트에 가상 데이터를 가져온다. <br/>
                        - 매번 조회할때마다 1 ~  9 사이의 랜덤한 값을 가져온다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:WebSheet ID="grid99" runat="server" Paging="false" CheckBox="false" Width="100%" TypeName="Template.TemplateBiz" MethodName="GetChart">
                            <Ctl:SheetField DataField="V1" TextField="V1" Description="V1" Width="20%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="V2" TextField="V2" Description="V2" Width="20%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="V3" TextField="V3" Description="V3" Width="20%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="V4" TextField="V4" Description="V4" Width="20%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="V5" TextField="V5" Description="V5" Width="20%"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="ChartFxScript Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="35%" />
                    <col width="65%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT201" runat="server" LangCode="TXT201" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT202" runat="server" LangCode="TXT202" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT357"><Ctl:Text ID="TXT203" runat="server" LangCode="TXT203" Description="Chart.getAllSeries().getPointLabels().setVisible()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT204" runat="server" LangCode="TXT204" Description="- 해당 차트의 라벨 표시 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT361"><Ctl:Text ID="TXT205" runat="server" LangCode="TXT205" Description="Chart.getLegendBox().setVisible()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="- 해당 차트의 범례 표시 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT369"><Ctl:Text ID="TXT209" runat="server" LangCode="TXT209" Description="Chart.getTitles().add()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="- 해당 차트의 타이틀을 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT373"><Ctl:Text ID="TXT211" runat="server" LangCode="TXT211" Description="Chart.setCulture()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT212" runat="server" LangCode="TXT212" Description="- 해당 차트의 Culture를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT377"><Ctl:Text ID="TXT213" runat="server" LangCode="TXT213" Description="DataBind()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT214" runat="server" LangCode="TXT214" Description="- 해당 차트를 데이터 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT381"><Ctl:Text ID="TXT215" runat="server" LangCode="TXT215" Description="InitConfig()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT216" runat="server" LangCode="TXT216" Description="- 해당 차트의 설정 초기화함수 호출"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT385"><Ctl:Text ID="TXT217" runat="server" LangCode="TXT217" Description="Initialize()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT218" runat="server" LangCode="TXT218" Description="- 해당 차트의 데이터를 초기화한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT389"><Ctl:Text ID="TXT219" runat="server" LangCode="TXT219" Description="jChartFX()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT220" runat="server" LangCode="TXT220" Description="- 차트 컨트롤을 생성한다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="Combo Control Functions Examples" DefaultHide="False">
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
                        <a href="#TXT204"><Ctl:Text ID="TXT356" runat="server" LangCode="TXT356" Description="Chart.getAllSeries().getPointLabels().setVisible()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT357" runat="server" LangCode="TXT357" Description="- 해당 차트의 라벨 표시 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT358" runat="server" LangCode="TXT358" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (차트 div의 ID값).Chart.getAllSeries().getPointLabels().setVisible(true | false) 형식으로 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT359" runat="server" LangCode="TXT359" Description="
                        <p style='display:inline;color:blue;'> chart2.Chart.getAllSeries().getPointLabels().setVisible(true); </p> <p style='display:inline;color:green;'> /* 표시 */ </p>
                        <p style='display:inline;color:blue;'> chart2.Chart.getAllSeries().getPointLabels().setVisible(flase); </p> <p style='display:inline;color:green;'> /* 숨김 */ </p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <div id="chart2" style="width:280px;height:280px;display:inline-block;"></div>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnChart2_1" runat="server" LangCode="btnChart2_1" Description="표시" OnClientClick="chart2.Chart.getAllSeries().getPointLabels().setVisible(true);"></Ctl:Button>
                            <Ctl:Button ID="btnChart2_2" runat="server" LangCode="btnChart2_2" Description="숨김" OnClientClick="chart2.Chart.getAllSeries().getPointLabels().setVisible(false);"></Ctl:Button>
                        </div>
                        
                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart2 = new jChartFX(cfx.Gallery.Bar, "chart2", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit2(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(false);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(true);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);
                                    chart.Chart.getSeries().getItem(0).setGallery(cfx.Gallery.Bar);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit2(chart2); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht2 = new Object();
                            PageMethods.InvokeServiceTable(ht2, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart2.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT206"><Ctl:Text ID="TXT360" runat="server" LangCode="TXT360" Description="Chart.getLegendBox().setVisible()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT361" runat="server" LangCode="TXT361" Description="- 해당 차트의 범례 표시 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT362" runat="server" LangCode="TXT362" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (차트 div의 ID값).Chart.getLegendBox().setVisible(true | false) 형식으로 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT363" runat="server" LangCode="TXT363" Description="
                        <p style='display:inline;color:blue;'> chart3.Chart.getLegendBox().setVisible(true); </p> <p style='display:inline;color:Green;'> /* 표시 */ </p><br />
                        <p style='display:inline;color:blue;'> chart3.Chart.getLegendBox().setVisible(false); </p> <p style='display:inline;color:Green;'> /* 숨김 */ </p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <div id="chart3" style="width:280px;height:280px;display:inline-block;"></div>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnChart3_1" runat="server" LangCode="btnChart3_1" Description="표시" OnClientClick="chart3.Chart.getLegendBox().setVisible(true);"></Ctl:Button>
                            <Ctl:Button ID="btnChart3_2" runat="server" LangCode="btnChart3_2" Description="숨김" OnClientClick="chart3.Chart.getLegendBox().setVisible(false);"></Ctl:Button>
                        </div>
                        
                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart3 = new jChartFX(cfx.Gallery.Bar, "chart3", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit3(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(true);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(false);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);
                                    chart.Chart.getSeries().getItem(0).setGallery(cfx.Gallery.Bar);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit3(chart3); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht3 = new Object();
                            PageMethods.InvokeServiceTable(ht3, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart3.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT210"><Ctl:Text ID="TXT368" runat="server" LangCode="TXT368" Description="Chart.getTitles().add()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT369" runat="server" LangCode="TXT369" Description="- 해당 차트의 타이틀을 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT370" runat="server" LangCode="TXT370" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT371" runat="server" LangCode="TXT371" Description="
                        var title;<br />
                        title = new cfx.TitleDockable(); <p style='display:inline;color:Green;'> /* 타이틀설정 */ </p><br />
                        title.setText(&#34;테스트 차트&#34;);<br />
                        <p style='display:inline;color:Blue;'>chart.Chart.getTitles().add(title);</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <div id="chart5" style="width:280px;height:280px;display:inline-block;"></div>
                        
                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart5 = new jChartFX(cfx.Gallery.Bar, "chart5", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit5(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(false);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(false);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);
                                    chart.Chart.getSeries().getItem(0).setGallery(cfx.Gallery.Bar);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit5(chart5); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht5 = new Object();
                            PageMethods.InvokeServiceTable(ht5, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart5.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT212"><Ctl:Text ID="TXT372" runat="server" LangCode="TXT372" Description="Chart.setCulture()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT373" runat="server" LangCode="TXT373" Description="- 해당 차트의 Culture를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT374" runat="server" LangCode="TXT374" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Currecy 유형 설정 때문에 사용하며 차트 초기화 시 선언한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 미리 설정해둔 &#34;_cuture_info&#34; 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT375" runat="server" LangCode="TXT375" Description="
                        <p style='display:inline;color:Blue;'> chart.Chart.setCulture(_cuture_info);</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>

                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT214"><Ctl:Text ID="TXT376" runat="server" LangCode="TXT376" Description="DataBind()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT377" runat="server" LangCode="TXT377" Description="- 해당 차트를 데이터 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT378" runat="server" LangCode="TXT378" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataRow 값을 바인딩한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 표시할 칼럼은 int 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT379" runat="server" LangCode="TXT379" Description="
                        <p style='display:inline;color:Blue;'>chart6.DataBind(dataSet.Tables[0].Rows);</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <div id="chart6" style="width:280px;height:280px;display:inline-block;"></div>
                        
                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart6 = new jChartFX(cfx.Gallery.Bar, "chart6", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit6(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(false);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(false);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);
                                    chart.Chart.getSeries().getItem(0).setGallery(cfx.Gallery.Bar);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit6(chart6); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht6 = new Object();
                            PageMethods.InvokeServiceTable(ht6, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart6.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>

                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT216"><Ctl:Text ID="TXT380" runat="server" LangCode="TXT380" Description="InitConfig()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT381" runat="server" LangCode="TXT381" Description="- 해당 차트의 설정 초기화함수 호출"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT382" runat="server" LangCode="TXT382" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 설정을 초기화할 내부의 함수를 호출한다. 
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT383" runat="server" LangCode="TXT383" Description="
                        <p style='display:inline;color:blue;'> chart.InitConfig = function () {</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;chart.Chart.setCulture(_cuture_info);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;......<br />
                        <p style='display:inline;color:blue;'> }</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <div id="chart7" style="width:280px;height:280px;display:inline-block;"></div>
                        
                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart7 = new jChartFX(cfx.Gallery.Bar, "chart7", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit7(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(false);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(false);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);
                                    chart.Chart.getSeries().getItem(0).setGallery(cfx.Gallery.Bar);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit7(chart7); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht7 = new Object();
                            PageMethods.InvokeServiceTable(ht7, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart7.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT218"><Ctl:Text ID="TXT384" runat="server" LangCode="TXT384" Description="Initialize()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT385" runat="server" LangCode="TXT385" Description="- 해당 차트의 데이터를 초기화한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT386" runat="server" LangCode="TXT386" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT387" runat="server" LangCode="TXT387" Description="
                        <p style='display:inline;color:blue;'> chart8.Initialize();</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <div id="chart8" style="width:280px;height:280px;display:inline-block;"></div>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnChart8_1" runat="server" LangCode="btnChart8_1" Description="초기화" OnClientClick="chart8.Initialize();"></Ctl:Button>
                        </div>

                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart8 = new jChartFX(cfx.Gallery.Bar, "chart8", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit8(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(false);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(false);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);
                                    chart.Chart.getSeries().getItem(0).setGallery(cfx.Gallery.Bar);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit8(chart8); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht8 = new Object();
                            PageMethods.InvokeServiceTable(ht8, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart8.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>

                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT220"><Ctl:Text ID="TXT388" runat="server" LangCode="TXT388" Description="jChartFX()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT389" runat="server" LangCode="TXT389" Description="- 차트 컨트롤을 생성한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT390" runat="server" LangCode="TXT390" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; jChartFX(<p style='display:inline;color:green;'>/* 차트타입값 */, /* 차트 div의 ID값 */, /* 애니메이션 여부 */, /* 자동사이즈 여부 */</p>) 형식으로 생성한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 차트타입값에는 cfx.Gallery.(None | Lines | Bar | Scatter | Pie | Curve | Step | Cube | Doughnut | Gantt) 값을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 애니메이션 여부에는 true | false 값을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 자동사이즈 여부에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT391" runat="server" LangCode="TXT391" Description="
                        var chart9 = new <p style='display:inline;color:Blue;'>jChartFX(cfx.Gallery.Gantt, &#34;chart9&#34;, true, true);</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <div id="chart9" style="width:280px;height:280px;display:inline-block;"></div>

                        <!-- 차트 선언 및 바인딩 -->
                        <script type="text/javascript">
                            // 차트 컨트롤 선언
                            var chart9 = new jChartFX(cfx.Gallery.Gantt, "chart9", true, true);

                            // 차트 초기화 함수
                            function JFxChartInit9(chart) {
                                chart.Initialize();
                                chart.InitConfig = function () {
                                    chart.Chart.setCulture(_cuture_info);

                                    //chart.Chart.getAllSeries().getBorder().setEffect(cfx.BorderEffect.Raised);
                                    chart.Chart.getLegendBox().setVisible(false);
                                    chart.Chart.getAllSeries().getPointLabels().setVisible(false);
                                    //chart.Chart.getAllSeries().setBarShape(cfx.BarShape.Cylinder);
                                    //chart.Chart.getSeries().getItem(0).setGallery(cfx.Gallery.Bar);

                                    var title;
                                    title = new cfx.TitleDockable(); // 타이틀설정
                                    title.setText("테스트 차트");
                                    chart.Chart.getTitles().add(title);
                                }
                            }
                            JFxChartInit9(chart9); // 차트 초기화

                            // 차트 데이터 바인딩
                            var ht9 = new Object();
                            PageMethods.InvokeServiceTable(ht9, "Template.TemplateBiz", "GetChart", function (e) {
                                var dataSet = eval(e);

                                var dataRow = dataSet.Tables[0].Rows;

                                //dataRow[0]["V1"] = 1;
                                //dataRow[0]["V2"] = 2;
                                //dataRow[0]["V3"] = 3;
                                //dataRow[0]["V4"] = 4;

                                // 차트 바인드
                                chart9.DataBind(dataSet.Tables[0].Rows);
                            });
                        </script>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>