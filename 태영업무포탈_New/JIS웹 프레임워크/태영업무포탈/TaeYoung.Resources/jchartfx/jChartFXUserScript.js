/******************************************************************************************
* 함수명 : jChartFX
* 설  명 : jChartFX 객체 생성
* 작성일 : 2014-06-10
* 작성자 : 이재일
* 수  정 :
******************************************************************************************/
// ----------------------- jChartFX Import File -------------------------
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.system.js"></script>');
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.coreVector.js"></script>');
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.advanced.js"></script>');
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.coreVector3d.js"></script>');
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.ui.js"></script>');
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.vector.js"></script>');
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.gauge.js"></script>');
document.write('<script type="text/javascript" src="/Resources/jChartFX/js/jchartfx.animation.js"></script>');
// ----------------------------------------------------------------------

var jChartFX = function (chartType, displayDiv, useAnimation, useAutoSize) {
    // License 설정
    //cfx.Chart.setLicense("O;2014/6/10;0;;SEJONG Global Portal$SEJONG Industrial co,.Ltd;926c59ac474f95f45e25eb47d513655f83fa1a458bdef7632e29f6523c0ab800df3af0d40a9d8efad2319da6affa26fe5ee915677ba5c92165be85d045e3bea52d7530a3d02e164415aa79eb31368ee9fd13d7d06ca73e39327f6876d1880fc8b9e8e0c4c9721ea2163a44b18c85cc63ba309093b371bac5b49dfd964f109185");
//    cfx.Chart.setLicense("R;2016/3/9;0;nvhkorea.com;01951e341949a9bcc96fef94ba2f5a8196c4698e1d060648ac443a1f2f4bd6a07d0de29f9d164e79d595640a85bb9f6dd3077bdc6b9645203d3f158405dc96f9a34755b03fb362ffa1dad566aaa649093fdafb09abe8bb3241bc0c9a121f69e6c585928ad3b56f560349f702f5eea1a7eef7bfec38e0cc2619d74bc481c141ce");
    cfx.Chart.setLicense("R;2017/2/28;0;iTaeYoung.com;7b312f6532a10b161476b37551039e0bb1e2849210b18cb3840706afca52bcafc0fa5affb30636160421abaadc5b3613f4f9cb6fb8980cf85adedde33b3ff50cfbd84c4ac52edad25dedc90059920b2d1e859cdeab389de80fdd9109379081ca3ee1cbe60b17105c17e1d775d825b57c3e732b99a152ce57cb5baf396f74706a");
    // Default Parameter 설정
    if (useAnimation == undefined) useAnimation = true;
    if (useAutoSize == undefined) useAutoSize = true;

    // 변수 정의
    this.Chart = null;
    this._f = new jChartFXPrivate(this, chartType, displayDiv, useAnimation, useAutoSize);
    this.InitConfig = null;
    this.MainConfig = null;
    this.OnClick = null;

    // 유저 함수 정의
    this.Initialize = function () {
        this._f.DataBind([], 0);
    }

    this.SetFont = function (fontStyle) {
        this._f._fontStyle = fontStyle;
    }

    this.SetTitle = function (title) {
        this._f._title = title;
    }

    this.AddLabelField = function (fieldName) {
        this._f._labelField.push(fieldName);
    }

    this.AddValueField = function (fieldName) {
        this._f._valueField.push(fieldName);
    }

    this.DataBind = function (dataRows) {
        this._f.DataBind(dataRows, 0);
    }

    this.DataBindHiddenValue = function (dataRows) {
        this._f.DataBind(dataRows, 1);
    }

    this.ShowLoading = function () {
        this._f.ShowLoading();
    }

    this.HideLoading = function () {
        this._f.HideLoading();
    }
}

var jChartFXPrivate = function (parent, chartType, displayDiv, useAnimation, useAutoSize) {
    // 상수
    this._loadingImageURL = "/Resources/Framework/ajax_loding.gif";

    // 변수 정의
    this.parent = parent;
    this._chartType = chartType;
    this._displayDiv = displayDiv;
    this._useAnimation = useAnimation;
    this._title = null;
    this._fontStyle = null;
    this._labelField = new Array();
    this._valueField = new Array();
    this._onClickBind = false;

    // AutoSizeUpdate 함수 정의
    this.autoSizeUpdate = function (obj) {
        if (obj.parent.Chart != null) {
            try {
                if (obj.parent.Chart._h != undefined && obj.parent.Chart._h.clientWidth != undefined && obj.parent.Chart.Sw != obj.parent.Chart._h.clientWidth && obj.parent.Chart._h.clientWidth != 0) {
                    obj.parent.Chart.doUpdate(true);
                }
            } catch (ex) { }
        }

        setTimeout(function () { obj.autoSizeUpdate(obj) }, 300);
    }

    // AutoSizeUpdate 여부에 따라 실행
    if (useAutoSize) this.autoSizeUpdate(this);

    // Loading
    this.ShowLoading = function () {
        var progressImg = document.createElement("IMG");
        $(progressImg).appendTo($("#" + this._displayDiv));
        $(progressImg).css("position", "absolute");
        $(progressImg).css("left", $("#" + this._displayDiv).width() / 2);
        $(progressImg).css("top", $("#" + this._displayDiv).height() / 2);
        $(progressImg).attr("src", this._loadingImageURL);
        $(progressImg).attr("id", this._displayDiv + "_LoadingImage");
    }
    this.HideLoading = function () {
        $("#" + this._displayDiv + "_LoadingImage").remove();
    }

    // 함수 정의
    this.DataBind = function (dataRows, bindType) {
        if (dataRows != undefined && dataRows.length > 0) {
            var displayDiv = $(document.getElementById(this._displayDiv));

            displayDiv.empty();

            this.parent.Chart = new cfx.Chart();
            this.parent.Chart.getAnimations().getLoad().setEnabled(this._useAnimation);
            this.parent.Chart.setGallery(this._chartType);

            // Font 설정
            if (this._fontStyle != null && typeof (this._fontStyle) == "string") this.parent.Chart.setFont(this._fontStyle);
            //else this.parent.Chart.setFont("6pt Times New Roman");
            //else this.parent.Chart.setFont("8pt 맑은 고딕");
            else this.parent.Chart.setFont("8pt Arial");

            // bg
            this.parent.Chart.setBackColor("#FFFFFF");
            this.parent.Chart.setPlotAreaColor("#FFFFFF");

            // Title 설정
            if (this._title != null && typeof (this._title) == "string") this.parent.Chart.getTitles().add(new cfx.TitleDockable(this._title));
            else {
                //this.parent.Chart.getTitles().clear();
                //var title = new cfx.TitleDockable();
                //title.setText(this._title);
                //title.setDock(cfx.DockArea.Bottom);
                //this.parent.Chart.getTitles().add(title);
                this.parent.Chart.getTitles().add(new cfx.TitleDockable(""));
            }

            var template = '<DataTemplate xmlns:x="a"><DataTemplate.Resources><MultiplyConverter x:Key="multConverter"></MultiplyConverter><StringConverter x:Key="titleConverter"></StringConverter><Thickness x:Key="padding">12</Thickness></DataTemplate.Resources><Canvas Padding="{Binding Path=Padding}"><Border Margin="5,5,1,1" Stroke="#50000000" StrokeThickness="2" CornerRadius="6" CornerPercent="0.4" Canvas.Left="3" Canvas.Top="3" Fill="#80000000"><Border.BitmapEffect><BlurBitmapEffect Radius="2"></BlurBitmapEffect></Border.BitmapEffect></Border><Border BorderBrush="#727473" BorderThickness="1" Opacity="1" CornerPercent="0.4" CornerRadius="6" Padding="6,4,6,4" Background="#FFFFFF"><DockPanel x:Name="container" Orientation="Vertical"><TextBlock Text="{Binding Path=Title, Converter={StaticResource titleConverter},ConverterParameter=%u}}" FontSize="{Binding Path=FontSize, Converter={StaticResource multConverter},ConverterParameter=1}" Visible="{Binding Path=TitleVisible}" HorizontalAlignment="Center" Margin="0,3,0,4"></TextBlock></DockPanel></Border></Canvas></DataTemplate>';
            var tooltips = this.parent.Chart.getToolTips();
            tooltips.setBorderTemplate(template);
            tooltips.setShowStacked(false);
            tooltips.setAlignment(cfx.StringAlignment.Near);
            tooltips.setVerticalAlignment(cfx.StringAlignment.Center);


            // field 설정
            var fields = this.parent.Chart.getDataSourceSettings().getFields();

            if (this._labelField.length > 0) {
                for (var i = 0; i < this._labelField.length; i++) {
                    var field = new cfx.FieldMap();
                    field.setName(this._labelField[i]);
                    field.setUsage(cfx.FieldUsage.Label);
                    fields.add(field);
                }
            }

            if (this._valueField.length > 0) {
                for (var i = 0; i < this._valueField.length; i++) {
                    var field = new cfx.FieldMap();
                    field.setName(this._valueField[i]);
                    field.setUsage(cfx.FieldUsage.Value);
                    fields.add(field);
                }
            }

            // Data 바인딩
            if (bindType == 1) this.setHiddenDataSource(this.parent.Chart, dataRows);
            else this.parent.Chart.setDataSource(dataRows);

            //사용자 정의 호출
            if (this.parent.InitConfig != null && typeof (this.parent.InitConfig) == "function") this.parent.InitConfig();

            if (this.parent.MainConfig != null && typeof (this.parent.MainConfig) == "function") this.parent.MainConfig();

            // Chart 생성
            this.parent.Chart.create(this._displayDiv);

            if (!this._onClickBind && this.parent.OnClick != null && typeof (this.parent.OnClick) == "function") {
                this._onClickBind = true;
                displayDiv.click(this.parent.OnClick);
            }

        } else {
            var displayDiv = $(document.getElementById(this._displayDiv));

            displayDiv.empty();

            this.parent.Chart = new cfx.Chart();
            this.parent.Chart.setGallery(this._chartType);

            if (this._title != null && typeof (this._title) == "string") this.parent.Chart.getTitles().add(new cfx.TitleDockable(this._title));

            this.parent.Chart.setDataSource(dataRows);

            this.parent.Chart.create(this._displayDiv);
        }
    }

    this.setHiddenDataSource = function (chartObject, dataRows) {
        chartObject.setDataSource([]);
        var data = chartObject.getData();

        if (dataRows != undefined) {
            for (var i = 0; i < dataRows.length; i++) {
                var dataRow = dataRows[i];
                var dataColumn = Object.keys(dataRow);

                //AxisX 설정
                data.getLabels().setItem(i, dataRow[dataColumn[0]])

                for (var j = 0; j < dataColumn.length; j++) {

                    if (j > 0) {
                        if (!isNaN(parseInt(dataRow[dataColumn[j]]))) data.setItem(j - 1, i, dataRow[dataColumn[j]]);
                        else data.setItem(j - 1, i, 0);
                    }

                    if (i == 0 && j > 0) {
                        chartObject.getSeries().getItem(j - 1).setText(dataColumn[j]);
                    }
                    //if (!isNaN(Number(dataRow[dataColumn[j]]))) dataRow[dataColumn[j]] = Number(dataRow[dataColumn[j]]);
                }
            }

            for (var j = dataColumn.length - 1; j > 0; j--) {
                var exist = false;

                for (var k = 0; k < dataRows.length; k++) {
                    if (dataRows[k][dataColumn[j]].toString().length > 0) {
                        exist = true;
                        break;
                    }
                }

                if (!exist)
                    data.removeSeries(j - 1)

            }

        }
    }
}

var jChartFXGauge = function ( displayDiv, useAnimation, useAutoSize) {
    // License 설정
    //cfx.Chart.setLicense("O;2014/6/10;0;;SEJONG Global Portal$SEJONG Industrial co,.Ltd;926c59ac474f95f45e25eb47d513655f83fa1a458bdef7632e29f6523c0ab800df3af0d40a9d8efad2319da6affa26fe5ee915677ba5c92165be85d045e3bea52d7530a3d02e164415aa79eb31368ee9fd13d7d06ca73e39327f6876d1880fc8b9e8e0c4c9721ea2163a44b18c85cc63ba309093b371bac5b49dfd964f109185");
    //    cfx.Chart.setLicense("R;2016/3/9;0;nvhkorea.com;01951e341949a9bcc96fef94ba2f5a8196c4698e1d060648ac443a1f2f4bd6a07d0de29f9d164e79d595640a85bb9f6dd3077bdc6b9645203d3f158405dc96f9a34755b03fb362ffa1dad566aaa649093fdafb09abe8bb3241bc0c9a121f69e6c585928ad3b56f560349f702f5eea1a7eef7bfec38e0cc2619d74bc481c141ce");
    cfx.Chart.setLicense("R;2017/2/28;0;iTaeYoung.com;7b312f6532a10b161476b37551039e0bb1e2849210b18cb3840706afca52bcafc0fa5affb30636160421abaadc5b3613f4f9cb6fb8980cf85adedde33b3ff50cfbd84c4ac52edad25dedc90059920b2d1e859cdeab389de80fdd9109379081ca3ee1cbe60b17105c17e1d775d825b57c3e732b99a152ce57cb5baf396f74706a");
    // Default Parameter 설정
    if (useAnimation == undefined) useAnimation = true;
    if (useAutoSize == undefined) useAutoSize = true;

    // 변수 정의
    this.Chart = null;
    this._f = new jChartFXPrivateGauge(this, displayDiv, useAnimation, useAutoSize);
    this.InitConfig = null;
    this.MainConfig = null;
    this.OnClick = null;

    // 유저 함수 정의
    this.Initialize = function () {
        this._f.DataBind(100, 0);
    }

    //타이틀 설정
    this.SetTitle = function (title) {
        this._f._title = title;
    }

    //라인 굵기
    this.SetThickness = function (thickness) {
        this._f._thickness = thickness;
    }

    this.DataBind = function (max, value) {
        this._f.DataBind(max, value);
    }
}


var jChartFXPrivateGauge = function (parent, displayDiv, useAnimation, useAutoSize) {
    // 상수
    this._loadingImageURL = "/Resources/Framework/ajax_loding.gif";

    // 변수 정의
    this.parent = parent;
    this._displayDiv = displayDiv;
    this._useAnimation = useAnimation;
    this._thickness = 1;
    this._title = null;

    // 함수 정의
    this.DataBind = function (max, value) {
        this.parent.Chart = new cfx.gauge.RadialGauge();

        var mainScale = this.parent.Chart.getMainScale();
        mainScale.setMax(max);
        var majorTickmarks = mainScale.getTickmarks().getMajor();
        majorTickmarks.setVisible(false);
        var mediumTickmarks = mainScale.getTickmarks().getMedium();
        mediumTickmarks.setVisible(false);
        mainScale.setStartAngle(270);
        mainScale.setSweepAngle(360);
        mainScale.setPosition(0.25);

        var bar = mainScale.getBar();
        bar.setPosition(0);
        bar.setThickness(this._thickness);
        bar.setVisible(true);
        mainScale.setThickness(0.2);


        var filler = new cfx.gauge.Filler();
        filler.setPosition(0.25);
        filler.setSize(this._thickness);

        this.parent.Chart.setMainIndicator(filler);
        this.parent.Chart.setMainValue(value);

        this.parent.Chart.getBorder().setTemplate("<DataTemplate></DataTemplate>");

        var title = new cfx.gauge.Title();
        title.setTag("GaugeTitleLarge");
        title.setText("%v %%");
        title.setX(0.5);
        title.setY(0.5);
        title.setResizeableFont(cfx.gauge.ResizeFont.Never);
        this.parent.Chart.getTitles().add(title);

        // Title 설정
        if (this._title != null && typeof (this._title) == "string") {
            title = new cfx.gauge.Title();
            title.setTag("DockedTitle");
            title.setText(this._title);
            title.setDock(cfx.DockArea.Top);
            this.parent.Chart.getTitles().add(title);
        }

        var loadAnimation = this.parent.Chart.getAnimations().getLoad();
        loadAnimation.setEnabled(true);
        loadAnimation.setTiming(cfx.AnimationTiming.EaseOut);

        //사용자 정의 호출
        if (this.parent.InitConfig != null && typeof (this.parent.InitConfig) == "function") this.parent.InitConfig();

        //var border = '<T><T.R><s K="plotMargin">targetChart</s><Th K="externalMargin">16</Th><Th K="internalRectMargin">2</Th><Th K="uiMargin">4,4,0,0</Th><T K="internalRect"><B CR="6" F="{B F}" S="{B S}" CP="0.5"/></T><T K="internal"><Line S="{B S}" X1="{B X1}" X2="{B X2}" Y1="{B Y1}" Y2="{B Y2}"/></T></T.R><C><B F="{B F}" S="{B S}" ><g><g.RD><RD H="32"/><RD H="*"/></g.RD><C><B><B.F><L S="0,0" E="0,1" ><G C="#99FDFDFD" O="0"/><G C="#99F2F2F3" O="1"/></L></B.F><DockPanel Orientation="Horizontal"><r V="{B UIVisible}" W="{B UISize}" M="0,0,4,0" H="1" F="{N}" S="{N}"/><TextBlock M="8,0" Text="{B Title}" FontFamily="{Binding Class=DashboardTitle.font-family}" FontSize="11" FontWeight="Bold" VerticalAlignment="Center" HorizontalAlignment="Left" Foreground="{Binding Class=DashboardTitle.fill}"/></DockPanel></B></C><B g.R="1" F="{B F}"><C N="targetChart" M="0,0,0,4"/></B></g></B></C></T>';
        this.parent.Chart.getDashboardBorder().setTemplate("<DataTemplate></DataTemplate>"); // This is only required if you use motifs
        this.parent.Chart.create(this._displayDiv);
    }
}


// Culture (Currecy 유형 설정 때문에 선언)
var _cuture_info = {
    "shortDate": "yyyy-MM-dd",
    "days": ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    "abbDays": ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
    "months": ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
    "abbMonths": ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
    "am": "AM",
    "pm": "PM",
    "dateSepa": "-",
    "timeSepa": ":",
    // Numeric
    "decSymb": ".",
    "groupNumb": 3,
    "groupCurr": 3,
    "groupSymb": ",",
    "currSymb": "",
    "currPos": 0,
    "currNeg": 0,
    "percSymb": "%",
    "percPos": 1,
    "percNeg": 1
};