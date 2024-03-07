<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimeStampChartNew.aspx.cs" Inherits="TaeYoung.Portal.Admin.Log.TimeStampChartNew" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <!-- 차트 스크립트 정의 -->
    <Ctl:ChartFxScript ID="chart_script" runat="server"></Ctl:ChartFxScript>

    <script type="text/javascript">
        var plant = "<%= TaeYoung.Biz.Document.UserInfo.LocationCode %>";
        var corpcd = "<%= TaeYoung.Biz.Document.UserInfo.SiteCompanyCode %>";
        var ori_corpcd = "<%= TaeYoung.Biz.Document.UserInfo.CompanyCode %>";
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
        var loginid = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";
        var userName = "<%= TaeYoung.Biz.Document.UserInfo.UserName %>";
        var isVend = "<%= TaeYoung.Biz.Document.UserInfo.IsVend %>";
        // 차트 컨트롤 선언
        var char_year = new jChartFX(cfx.Gallery.Bar, "char_year", true, true);
        var char_month = new jChartFX(cfx.Gallery.Area, "char_month", true, true);
        var char_day = new jChartFX(cfx.Gallery.Area, "char_day", true, true);
        var char_top_month_grid = new jChartFX(cfx.Gallery.Lines, "char_top_month_grid", true, true);
        var char_top_day_grid = new jChartFX(cfx.Gallery.Doughnut, "char_top_day_grid", true, true);

        /********************************************************************************************
        * 함수명      : OnLoad()
        * 작성목적    : OnLoad
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function OnLoad() {
            JFxChartInitYear(char_year);
            JFxChartInitMonth(char_month);
            JFxChartInitDay(char_day);
            JFxChartInitMonthGrid(char_top_month_grid);
            JFxChartInitDayGrid(char_top_day_grid);

            // PageLoad시 이벤트 정의부분
            txtYearYYYY.SetValue(GetYear());
            txtMonthYYYYMM.SetValue(GetMonth());
            txtDayYYYYMMDD.SetValue(GetTodate("Now"));
            txtTopMonthDate.SetValue(GetYear());
            txtTopDayDate.SetValue(GetTodate("Now"));

            btnSearch_Click();
        }

        /********************************************************************************************
        * 함수명      : btnSearch_Click()
        * 작성목적    : 조회 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnSearch_Click() {
            SetYearChart();
            SetMonthChart();
            SetDayChart();
            SetTopMonthGrid();
            //SetTopDayGrid();

            return false;
        }

        /********************************************************************************************
        * 함수명      : SetYearChart()
        * 작성목적    : 년도별 로그 차트 바인딩 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function SetYearChart() {
            // 차트 데이터 바인딩
            var ht = new Object();
            ht["YEAR"] = txtYearYYYY.GetValue();
            ht["MONTH"] = "";
            ht["DAY"] = "";
            ht["DIV_TOP"] = "0";
            ht["GUBUN"] = "YEAR";

            PageMethods.InvokeServiceTable(ht, "Portal.TimeLogBiz", "GetCmn_Systemlog_List", function (e) {
                var ds = eval(e);
                var rows = new Array();
                var str = "<Ctl:Text runat='server' LangCode='CHART_YEAR_FIELDS_LABEL' Description='월별 발생량' Literal='true' />";

                for (var i = 0; i < ObjectCount(ds.Tables[0].Rows); i++) {
                    var ht = new Object();
                    ht["MONTH"] = ds.Tables[0].Rows[i]["OCCUR_MONTH"];
                    ht[str] = ds.Tables[0].Rows[i]["LOG_CNT"];
                    rows.push(ht);
                }
                // 차트 바인드
                char_year.DataBind(rows);
            });

            return false;
        }

        /********************************************************************************************
        * 함수명      : SetMonthChart()
        * 작성목적    : 월별 로그 차트 바인딩 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function SetMonthChart() {
            // 차트 데이터 바인딩
            var ht = new Object();
            ht["YEAR"] = txtMonthYYYYMM.GetValue().substring(0, 4);
            ht["MONTH"] = txtMonthYYYYMM.GetValue().substring(4, 6);
            ht["DAY"] = "";
            ht["DIV_TOP"] = "0";

            PageMethods.InvokeServiceTable(ht, "Portal.TimeLogBiz", "GetChart", function (e) {
                var ds = eval(e);
                var rows = new Array();
                var str = "<Ctl:Text runat='server' LangCode='CHART_MONTH_FIELDS_LABEL' Description='일별 발생량' Literal='true' />";
                var str2 = "<Ctl:Text runat='server' LangCode='CHART_MONTH_FIELDS_LABEL2' Description='총 발생량' Literal='true' />";

                if (ds.Tables[1].Rows.length < 1)
                    return false;

                for (var i = 0; i < ObjectCount(ds.Tables[1].Rows); i++) {
                    var ht = new Object();
                    ht["DAY"] = ds.Tables[1].Rows[i]["OCCUR_DAY"];
                    ht[str2] = ds.Tables[1].Rows[i]["LOG_TOTAL"];
                    ht[str] = ds.Tables[1].Rows[i]["LOG_CNT"];
                    rows.push(ht);
                }

                // 차트 바인드
                char_month.DataBind(rows);
            });

            return false;
        }

        /********************************************************************************************
        * 함수명      : SetDayChart()
        * 작성목적    : 일별 로그 차트 바인딩 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function SetDayChart() {
            // 차트 데이터 바인딩
            var ht = new Object();
            ht["YEAR"] = txtDayYYYYMMDD.GetValue().substring(0, 4);
            ht["MONTH"] = txtDayYYYYMMDD.GetValue().substring(4, 6);
            ht["DAY"] = txtDayYYYYMMDD.GetValue().substring(6, 8);
            ht["DIV_TOP"] = "0";

            PageMethods.InvokeServiceTable(ht, "Portal.TimeLogBiz", "GetChart", function (e) {
                var ds = eval(e);
                var rows = new Array();
                var str = "<Ctl:Text runat='server' LangCode='CHART_DAY_FIELDS_LABEL' Description='시간대별 발생량' Literal='true' />";
                var str2 = "<Ctl:Text runat='server' LangCode='CHART_DAY_FIELDS_LABEL2' Description='총 발생량' Literal='true' />";

                if (ds.Tables[2].Rows.length < 1)
                    return false;

                for (var i = 0; i < ObjectCount(ds.Tables[2].Rows); i++) {
                    var ht = new Object();
                    ht["TIME"] = ds.Tables[2].Rows[i]["OCCUR_TIME_FORMAT"];
                    ht[str2] = ds.Tables[2].Rows[i]["LOG_TOTAL"];
                    ht[str] = ds.Tables[2].Rows[i]["LOG_CNT"];
                    rows.push(ht);
                }

                // 차트 바인드
                char_day.DataBind(rows);
            });

            return false;
        }

        /********************************************************************************************
        * 함수명      : SetTopMonthGrid()
        * 작성목적    : 월별TOP 그리드 바인딩 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function SetTopMonthGrid() {
            // 차트 데이터 바인딩
            var ht = new Object();
            ht["YEAR"] = txtTopMonthDate.GetValue().substring(0, 4);
            ht["MONTH"] = "";
            ht["DAY"] = "";
            ht["DIV_TOP"] = cboTopMonthCnt.GetValue();

            grid_month.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid_month.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            grid_month.CallBack = function () {

                $("#grid_month_chkall").click(function () { setTopMonthChart(); });
                $("#grid_month_Mainbody .JINSheet_ChkCell input").click(function () { setTopMonthChart(); });

                $('#grid_month_MainRow_' + 0 + ' .JINSheet_ChkCell input').prop('checked', true);
                $('#grid_month_MainRow_' + 1 + ' .JINSheet_ChkCell input').prop('checked', true);
                $('#grid_month_MainRow_' + 2 + ' .JINSheet_ChkCell input').prop('checked', true);

                setTopMonthChart();
            }

            return false;
        }

        /********************************************************************************************
        * 함수명      : SetTopDayGrid()
        * 작성목적    : 일별TOP 그리드 바인딩 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function SetTopDayGrid() {
            // 차트 데이터 바인딩
            var ht = new Object();
            ht["YEAR"] = txtTopDayDate.GetValue().substring(0, 4);
            ht["MONTH"] = txtTopDayDate.GetValue().substring(4, 6);
            ht["DAY"] = txtTopDayDate.GetValue().substring(6, 8);
            ht["DIV_TOP"] = cboTopDayCnt.GetValue();

            grid_day.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid_day.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            grid_day.CallBack = function () {

                $("#grid_day_chkall").click(function () { setTopDayChart(); });
                $("#grid_day_Mainbody .JINSheet_ChkCell input").click(function () { setTopDayChart(); });

                $('#grid_day_MainRow_' + 0 + ' .JINSheet_ChkCell input').prop('checked', true);
                $('#grid_day_MainRow_' + 1 + ' .JINSheet_ChkCell input').prop('checked', true);
                $('#grid_day_MainRow_' + 2 + ' .JINSheet_ChkCell input').prop('checked', true);

                setTopDayChart();
            }

            return false;
        }

        /********************************************************************************************
        * 함수명      : setTopMonthChart()
        * 작성목적    : 월별TOP 로그 차트 바인딩 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function setTopMonthChart() {
            var RowData;
            var ChartDataSets = new Array();
            var checkRows = grid_month.GetCheckRow();

            if (checkRows.length < 1) {
                RowData = {};
                ChartDataSets.push(RowData);
            } else {

                for (var i = 1; i < 13; i++) {
                    RowData = {};
                    //RowData["DESCRIPTION"] = i;

                    for (var j = 0; j < ObjectCount(checkRows); j++) {
                        RowData[checkRows[j]["DESCRIPTION"]] = checkRows[j]['LOG_CNT_' + i] == '' ? 0 : checkRows[j]['LOG_CNT_' + i];
                    }

                    ChartDataSets.push(RowData);
                }
            }

            char_top_month_grid.Initialize();
            char_top_month_grid.DataBind(ChartDataSets);

            return false;
        }

        /********************************************************************************************
        * 함수명      : setTopDayChart()
        * 작성목적    : 일별TOP 로그 차트 바인딩 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function setTopDayChart() {
            var RowData;
            var ChartDataSets = new Array();
            var checkRows = grid_day.GetCheckRow();

            if (checkRows.length < 1) {
                RowData = {};
                ChartDataSets.push(RowData);
            } else {

                for (var j = 0; j < ObjectCount(checkRows); j++) {
                    RowData = {};
                    RowData["DESCRIPTION"] = checkRows[j]['DESCRIPTION'] == '' ? '' : checkRows[j]['DESCRIPTION'];
                    RowData["LOG_CNT"] = checkRows[j]['LOG_CNT'] == '' ? 0 : checkRows[j]['LOG_CNT'];

                    ChartDataSets.push(RowData);
                }
            }

            char_top_day_grid.Initialize();
            char_top_day_grid.DataBind(ChartDataSets);

            return false;
        }

        // 차트 초기화 함수
        function JFxChartInitYear(chart) {
            chart.Initialize();
            chart.InitConfig = function () {
                chart.Chart.setCulture(_cuture_info);

                //범례 넓이 지정
                chart.Chart.getLegendBox().setWidth(130);
                //타이틀 설정
                var titles = chart.Chart.getTitles();
                var title = new cfx.TitleDockable();
                title.setText(txtYearYYYY.GetValue() + "<Ctl:Text runat='server' LangCode='CHART_YEAR_TITLE' Description=' 년 차트' Literal='true' />");
                titles.add(title);

                chart.Chart.getPlotAreaMargin().setLeft(50);
            }
        }

        function JFxChartInitMonth(chart) {
            chart.Initialize();
            chart.InitConfig = function () {
                chart.Chart.setCulture(_cuture_info);

                //범례 표시 여부
                chart.Chart.getLegendBox().setVisible(true);
                //범례 넓이 지정
                chart.Chart.getLegendBox().setWidth(130);
                //타이틀 설정
                var titles = chart.Chart.getTitles();
                var title = new cfx.TitleDockable();
                title.setText(txtMonthYYYYMM.GetValue().substring(0, 4) + "<Ctl:Text runat='server' LangCode='CHART_MONTH_YYYY_TITLE' Description='년 ' Literal='true' />" +
                              txtMonthYYYYMM.GetValue().substring(4, 6) + "<Ctl:Text runat='server' LangCode='CHART_MONTH_MM_TITLE' Description='월 차트' Literal='true' />");
                titles.add(title);

                //그리드 표시 
                chart.Chart.getDataGrid().setVisible(false);
                chart.Chart.getDataGrid().setHeight(100);

                chart.Chart.getPlotAreaMargin().setLeft(50);
            }
        }

        function JFxChartInitDay(chart) {
            chart.Initialize();
            chart.InitConfig = function () {
                chart.Chart.setCulture(_cuture_info);

                //범례 표시 여부
                chart.Chart.getLegendBox().setVisible(true);
                //범례 넓이 지정
                chart.Chart.getLegendBox().setWidth(130);
                //타이틀 설정
                var titles = chart.Chart.getTitles();
                var title = new cfx.TitleDockable();
                title.setText(txtDayYYYYMMDD.GetValue().substring(0, 4) + "<Ctl:Text runat='server' LangCode='CHART_DAY_YYYY_TITLE' Description='년 ' Literal='true' />" +
                              txtDayYYYYMMDD.GetValue().substring(4, 6) + "<Ctl:Text runat='server' LangCode='CHART_DAY_MM_TITLE' Description='월 ' Literal='true' />" +
                              txtDayYYYYMMDD.GetValue().substring(6, 8) + "<Ctl:Text runat='server' LangCode='CHART_DAY_DD_TITLE' Description='일 차트' Literal='true' />");
                titles.add(title);
                //그리드 표시 
                chart.Chart.getDataGrid().setVisible(false);
                chart.Chart.getDataGrid().setHeight(100);
                //X축 라벨 각도 조절
                chart.Chart.getAxisX().setLabelAngle(30);
                //Y축 라벨 표시 위치 좌/우
                //chart.Chart.getAxisY().setPosition(cfx.AxisPosition.Far);  //우측
                chart.Chart.getAxisY().setPosition(cfx.AxisPosition.Near); //좌측
                //차트 값 표현
                chart.Chart.getAllSeries().getPointLabels().setVisible(false);

                chart.Chart.getPlotAreaMargin().setLeft(50);
            }
        }

        function JFxChartInitMonthGrid(chart) {
            chart.Initialize();
            chart.InitConfig = function () {
                chart.Chart.setCulture(_cuture_info);
                //차트 값 표현
                chart.Chart.getAllSeries().getPointLabels().setVisible(true);
                //Y축 간격
                //chart.Chart.getAxisY().setStep(50);
                                
                var pane = new cfx.Pane();
                chart.Chart.getPanes().add(pane);

                for (var i = 0; i < ObjectCount(grid_month.GetCheckRow()); i++) {
                    if (i % 2 == 0) {
                        var series = chart.Chart.getSeries().getItem(i);
                        series.setVolume(50);
                        series.setPane(pane);
                        series.setGallery(cfx.Gallery.Bar);
                    }
                }
                
                //그래프 꺽은선 색상변경
                var colorArray = new Array();
                colorArray.push('#666666');
                colorArray.push('#1D2793');
                colorArray.push('#FF00FF');
                colorArray.push('#FFFF00');
                colorArray.push('#000000');

                //갤러리 타입 변경(CS,RS,PPM 꺽은선)
                for (var i = 0; i < colorArray.length; i++) {
                    if (i < ObjectCount(grid_month.GetCheckRow())) {
                        chart.Chart.getSeries().getItem(i).setColor(colorArray[i]);
                    }
                }

                chart.Chart.getPlotAreaMargin().setLeft(50);
            }
        }

        function JFxChartInitDayGrid(chart) {
            chart.Initialize();
            chart.InitConfig = function () {
                chart.Chart.setCulture(_cuture_info);

                //차트 값 표현
                chart.Chart.getAllSeries().getPointLabels().setVisible(true);


                var fields = chart.Chart.getDataSourceSettings().getFields();

                var field = new cfx.FieldMap();
                field.setName("LOG_CNT");
                field.setDisplayName("<Ctl:Text runat='server' LangCode='CHART_TOP_DAY_GRID_FIELDS_LABEL' Description='발생량' Literal='true' />");
                field.setUsage(cfx.FieldUsage.Value);
                fields.add(field);
                
                var LabelField = new cfx.FieldMap();
                LabelField.setName("DESCRIPTION");
                LabelField.setUsage(cfx.FieldUsage.Label);
                fields.add(LabelField);
            }
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="시스템 로그" Literal="true"></Ctl:Text></h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer_Year" runat="server" Title="년도별 로그" DefaultHide="false">
            <!-- 조회 조건 -->
            <ul class = "search">
                <li><Ctl:Text ID="TXT_txtYearYYYY" runat="server" LangCode="TXT_txtYearYYYY" Description="기준년" ></Ctl:Text></li>
                <li><Ctl:TextBox ID="txtYearYYYY" runat="server" SetCalendarFormat="YYYY" SetType="Calendar" OnCalendarChanged = "SetYearChart"></Ctl:TextBox></li>
            </ul>
            
            <!-- 차트를 바인딩할 div -->
            <div id="char_year" style="width:100%; height:280px;display:inline-block; position:relative;"></div>

            
        </Ctl:Layer>

        <Ctl:Layer ID="layer_Month" runat="server" Title="월별 로그" DefaultHide="false">
            <!-- 조회 조건 -->
            <ul class = "search">
                <li><Ctl:Text ID="TXT_txtMonthYYYYMM" runat="server" LangCode="TXT_txtMonthYYYYMM" Description="기준년월" ></Ctl:Text></li>
                <li><Ctl:TextBox ID="txtMonthYYYYMM" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar" OnCalendarChanged = "SetMonthChart"></Ctl:TextBox></li>
            </ul>
            
            <!-- 차트를 바인딩할 div -->
            <div id="char_month" style="width:100%; height:380px;display:inline-block; position:relative;"></div>
        </Ctl:Layer>

        <Ctl:Layer ID="layer_Day" runat="server" Title="일별 로그" DefaultHide="false">
            <!-- 조회 조건 -->
            <ul class = "search">
                <li><Ctl:Text ID="TXT_txtDayYYYYMMDD" runat="server" LangCode="txtDayYYYYMMDD" Description="기준일" ></Ctl:Text></li>
                <li><Ctl:TextBox ID="txtDayYYYYMMDD" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" OnCalendarChanged = "SetDayChart"></Ctl:TextBox></li>
            </ul>
            
            <!-- 차트를 바인딩할 div -->
            <div id="char_day" style="width:100%; height:380px;display:inline-block; position:relative;"></div>
        </Ctl:Layer>

        <Ctl:Layer ID="layer_Top_Month" runat="server" Title="월별 TOP" DefaultHide="false">
            <!-- 조회 조건 -->
            <ul class = "search">
                <li><Ctl:Text ID="TXT_txtTopMonthDate" runat="server" LangCode="TXT_txtTopMonthDate" Description="기준일" ></Ctl:Text></li>
                <li><Ctl:TextBox ID="txtTopMonthDate" runat="server" SetCalendarFormat="YYYY" SetType="Calendar" OnCalendarChanged = "SetTopMonthGrid"></Ctl:TextBox></li>
                <li><Ctl:Text ID="TXT_cboTopMonthCnt" runat="server" LangCode="TXT_cboTopMonthCnt" Description="Top" ></Ctl:Text></li>
                <li>
                    <Ctl:Combo ID="cboTopMonthCnt" runat="server" OnChange="SetTopMonthGrid();">
                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                        <asp:ListItem Value="10" Text="10"></asp:ListItem>
                        <asp:ListItem Value="20" Text="20"></asp:ListItem>
                        <asp:ListItem Value="30" Text="30"></asp:ListItem>
                    </Ctl:Combo>
                </li>
            </ul>
            
            <!-- 차트를 바인딩할 div -->
            <div id="char_top_month_grid" style="width:100%; height:580px;display:inline-block; position:relative;"></div>

            <Ctl:WebSheet ID="grid_month" runat="server" Paging="false" CheckBox="true" Width="100%" UseColumnSort="false" HFixation="false" Fixation="false" Height="300" Title="WebSheet" TypeName="Portal.TimeLogBiz" MethodName="GetTopLogGridForMonth">
                <Ctl:SheetField DataField="DESCRIPTION" TextField="DESCRIPTION" Description="프로그램 명" Width="*" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_1" TextField="LOG_CNT_1" Description="1월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_2" TextField="LOG_CNT_2" Description="2월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_3" TextField="LOG_CNT_3" Description="3월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_4" TextField="LOG_CNT_4" Description="4월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_5" TextField="LOG_CNT_5" Description="5월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_6" TextField="LOG_CNT_6" Description="6월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_7" TextField="LOG_CNT_7" Description="7월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_8" TextField="LOG_CNT_8" Description="8월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_9" TextField="LOG_CNT_9" Description="9월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_10" TextField="LOG_CNT_10" Description="10월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_11" TextField="LOG_CNT_11" Description="11월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="LOG_CNT_12" TextField="LOG_CNT_12" Description="12월" Width="80" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />

            </Ctl:WebSheet>
        </Ctl:Layer>
        <Ctl:Layer ID="layer_Top_Day" runat="server" Title="일별 TOP" DefaultHide="True" Collapsible = "True">
            <!-- 조회 조건 -->
            <ul class = "search">
                <li><Ctl:Text ID="TXT_txtTopDayDate" runat="server" LangCode="TXT_txtTopDayDate" Description="기준일" ></Ctl:Text></li>
                <li><Ctl:TextBox ID="txtTopDayDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" OnCalendarChanged = "SetTopDayGrid"></Ctl:TextBox></li>
                <li><Ctl:Text ID="TXT_cboTopDayCnt" runat="server" LangCode="TXT_cboTopDayCnt" Description="Top" ></Ctl:Text></li>
                <li>
                    <Ctl:Combo ID="cboTopDayCnt" runat="server" OnChange="SetTopDayGrid();">
                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                        <asp:ListItem Value="10" Text="10"></asp:ListItem>
                        <asp:ListItem Value="20" Text="20"></asp:ListItem>
                        <asp:ListItem Value="30" Text="30"></asp:ListItem>
                    </Ctl:Combo>
                </li>
            </ul>
            
            <!-- 차트를 바인딩할 div -->
            <div id="char_top_day_grid" style="width:100%; height:380px;display:inline-block; position:relative;"></div>

            <Ctl:WebSheet ID="grid_day" runat="server" Paging="false" CheckBox="true" Width="100%" UseColumnSort="false" HFixation="false" Fixation="false" Height="300" Title="WebSheet" TypeName="Portal.TimeLogBiz" MethodName="GetTopLogGridForDay">
                <Ctl:SheetField DataField="LOG_CNT" TextField="LOG_CNT" Description="오류 건수" Width="60" Height="24" Edit="false" DataType="number" EditType="text" HAlign="center" Align="right" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="DESCRIPTION" TextField="DESCRIPTION" Description="프로그램 명" Width="*" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>