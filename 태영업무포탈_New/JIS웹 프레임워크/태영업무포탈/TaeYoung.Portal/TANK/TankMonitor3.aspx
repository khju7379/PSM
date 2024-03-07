<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TankMonitor3.aspx.cs" Inherits="TaeYoung.Portal.TANK.TankMonitor3" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style type="text/css">
        #container{background-color:#FFF;}
    </style>
    <script type="text/javascript">

        var start_run;
        var start_reload;
        var combo = "";
        var comboZoom = "";
        var levelfont = "white";
        var tempfont = "white";
        var pressfont = "white";

        function OnLoad() {

            SetCombo();
            setInterval("dpTime()", 1000);
            // PageLoad시 이벤트 정의부분
            PageInit();
            init();
            setTimeout("tank_AlramCheck()", '2000');
            start_reload = setInterval("saveCookie();", '3610000');
            //start_reload = setInterval("saveCookie();", '60000');
        }

        function init() {
            $("#fmCbo_0").find("select").prop("disabled", false);
            $("#fmCbo_1").find("select").prop("disabled", false);
            $("#fmCbo_2").find("select").prop("disabled", false);
            $("#fmCbo_3").find("select").prop("disabled", false);
            $("#fmCbo_4").find("select").prop("disabled", false);
            $("#fmCbo_5").find("select").prop("disabled", false);
            $("#fmCbo_6").find("select").prop("disabled", false);
            $("#fmCbo_7").find("select").prop("disabled", false);
            $("#fmCbo_8").find("select").prop("disabled", false);
            $("#fmCbo_9").find("select").prop("disabled", false);
            start_run = setInterval('run();', '45000');
        }

        function run() {
            $("#fmCbo_0").find("select").prop("disabled", true);
            $("#fmCbo_1").find("select").prop("disabled", true);
            $("#fmCbo_2").find("select").prop("disabled", true);
            $("#fmCbo_3").find("select").prop("disabled", true);
            $("#fmCbo_4").find("select").prop("disabled", true);
            $("#fmCbo_5").find("select").prop("disabled", true);
            $("#fmCbo_6").find("select").prop("disabled", true);
            $("#fmCbo_7").find("select").prop("disabled", true);
            $("#fmCbo_8").find("select").prop("disabled", true);
            $("#fmCbo_9").find("select").prop("disabled", true);

            Combo_Changed($("#fmCbo_0").find("select"));
            Combo_Changed($("#fmCbo_1").find("select"));
            Combo_Changed($("#fmCbo_2").find("select"));
            Combo_Changed($("#fmCbo_3").find("select"));
            Combo_Changed($("#fmCbo_4").find("select"));
            Combo_Changed($("#fmCbo_5").find("select"));
            Combo_Changed($("#fmCbo_6").find("select"));
            Combo_Changed($("#fmCbo_7").find("select"));
            Combo_Changed($("#fmCbo_8").find("select"));
            Combo_Changed($("#fmCbo_9").find("select"));
            if ($("#tankZoomState").val() == "on") {
                ComboZoom_Changed($("#fmCbo_Zoom").find("select"));
            }
            setTimeout("tank_AlramCheck()", '1000');
            clearInterval(start_run);

            init();
        }

        function setCookie(name, value) {
            var todayDate = new Date();
            todayDate.setTime(todayDate.getTime() + 120000);
            document.cookie = name + "=" + escape(value) + ";path=/; expires=" + todayDate.toGMTString() + ";";
        }
        function getCookie(name) {
            name += "=";
            var arr = decodeURIComponent(document.cookie).split(';');
            for (var i = 0; i < arr.length; i++) {
                var c = arr[i];
                while (c.charAt(0) == ' ') c = c.substring(1);
                if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
            }
            return "";
        }

        function PageInit() {

            var ht = new Object();
            if ((getCookie("gubn") == "") || (getCookie("gubn") == undefined)) {
                PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetTankPageList", function (e) {

                    var dt = eval(e).Tables[0];
                    btnPage_Click(dt.Rows[0]["TKINDEX"]);
                    dt = null;

                }, function (e) {
                    // Biz 연결오류
                    //alert("페이지 초기화 Error");
                });
            }
            else if (getCookie("gubn") == "refresh") {

                setTimeout("setRefreshData()", "1000");
                btnPageSelect(getCookie("PageState"));
            }
            ht = null;
        }
        function setRefreshData() {
            $("#PageState").val(getCookie("PageState"));

            $("#fmCbo_0").find("select").val(getCookie("fmCbo_0"));
            $("#fmCbo_1").find("select").val(getCookie("fmCbo_1"));
            $("#fmCbo_2").find("select").val(getCookie("fmCbo_2"));
            $("#fmCbo_3").find("select").val(getCookie("fmCbo_3"));
            $("#fmCbo_4").find("select").val(getCookie("fmCbo_4"));
            $("#fmCbo_5").find("select").val(getCookie("fmCbo_5"));
            $("#fmCbo_6").find("select").val(getCookie("fmCbo_6"));
            $("#fmCbo_7").find("select").val(getCookie("fmCbo_7"));
            $("#fmCbo_8").find("select").val(getCookie("fmCbo_8"));
            $("#fmCbo_9").find("select").val(getCookie("fmCbo_9"));

            Combo_Changed($("#fmCbo_0").find("select"));
            Combo_Changed($("#fmCbo_1").find("select"));
            Combo_Changed($("#fmCbo_2").find("select"));
            Combo_Changed($("#fmCbo_3").find("select"));
            Combo_Changed($("#fmCbo_4").find("select"));
            Combo_Changed($("#fmCbo_5").find("select"));
            Combo_Changed($("#fmCbo_6").find("select"));
            Combo_Changed($("#fmCbo_7").find("select"));
            Combo_Changed($("#fmCbo_8").find("select"));
            Combo_Changed($("#fmCbo_9").find("select"));

            if (getCookie("tankZoomState") == "on") {
                var width = $(document).width() / 2 - 240;
                $("#layZoom").css("left", width + "px");
                $("#comboZoom").val(getCookie("comboZoom"));
                ComboZoom_Changed($("#fmCbo_Zoom").find("select"));
                $("#tankZoomState").val("on");
                $("#layZoom").show();
            }
            if (getCookie("TrendState") == "on") {
                var height = $(document).height();
                $("#divTrend").css("height", height + "px");
                $("#cboTankNo").val(getCookie("cboTankNo"));
                $("#txtDate").val(getCookie("txtDate"));
                $("#txtTUSTTIME").val(getCookie("txtTUSTTIME"));
                $("#txtTUEDTIME").val(getCookie("txtTUEDTIME"));
                rdoTrendGubn.SetValue(getCookie("rdoTrendGubn"));
                rdoTimeGubn.SetValue(getCookie("rdoTrendTimeGubn"));
                btnTrendSerch_Click();
                $("#TrendState").val("on");
                $("#divTrend").show();
            }
            if (getCookie("btnAlramState") == "on") {
                var width = $(document).width() - 680;
                $("#divAlram").css("left", width + "px");
                $("#txtAlramDate").val(getCookie("txtAlramDate"));
                btnAlramSerch_Click();
                $("#divAlram").show();
                $("#btnAlramState").val("on")
            }
        }

        /********************************************************************************************
        *   작성목적    :  쿠키저장 & 페이지 새로고침
        *   수정내역    :
        ********************************************************************************************/
        function saveCookie() {

            var cboT1;
            var cboT2;
            var cboT3;
            var cboT4;
            var cboT5;
            var cboT6;
            var cboT7;
            var cboT8;
            var cboT9;
            var cboT10;
            var cboZoom;
            var cboTrend;
            var DateTrend;
            var TrendGubn;
            var TrendTimeGubn;
            var zoomState;
            var TrendState;
            var pageNo;
            var sttime;
            var edtime;
            var alramState;
            var DateAlram;
            var date = new Date();

            //$("#fmCbo_0").find("select").attr("style", "readonly:true");

            cboT1 = $("#fmCbo_0").find("select").val();
            cboT2 = $("#fmCbo_1").find("select").val();
            cboT3 = $("#fmCbo_2").find("select").val();
            cboT4 = $("#fmCbo_3").find("select").val();
            cboT5 = $("#fmCbo_4").find("select").val();
            cboT6 = $("#fmCbo_5").find("select").val();
            cboT7 = $("#fmCbo_6").find("select").val();
            cboT8 = $("#fmCbo_7").find("select").val();
            cboT9 = $("#fmCbo_8").find("select").val();
            cboT10 = $("#fmCbo_9").find("select").val();
            cboZoom = $("#comboZoom").val();
            cboTrend = $("#cboTankNo").val();
            DateTrend = $("#txtDate").val();
            TrendGubn = rdoTrendGubn.GetValue();
            TrendTimeGubn = rdoTimeGubn.GetValue();
            zoomState = $("#tankZoomState").val();
            TrendState = $("#TrendState").val();
            pageNo = $("#PageState").val();
            sttime = $("#txtTUSTTIME").val();
            edtime = $("#txtTUEDTIME").val();
            alramState = $("#btnAlramState").val();
            DateAlram = $("#txtAlramDate").val();

            clearInterval(start_run);
            clearInterval(start_reload);

            setCookie("gubn", "refresh");
            setCookie("fmCbo_0", cboT1);
            setCookie("fmCbo_1", cboT2);
            setCookie("fmCbo_2", cboT3);
            setCookie("fmCbo_3", cboT4);
            setCookie("fmCbo_4", cboT5);
            setCookie("fmCbo_5", cboT6);
            setCookie("fmCbo_6", cboT7);
            setCookie("fmCbo_7", cboT8);
            setCookie("fmCbo_8", cboT9);
            setCookie("fmCbo_9", cboT10);
            setCookie("comboZoom", cboZoom);
            setCookie("cboTankNo", cboTrend);
            setCookie("txtDate", DateTrend);
            setCookie("rdoTrendGubn", TrendGubn);
            setCookie("rdoTrendTimeGubn", TrendTimeGubn);
            setCookie("tankZoomState", zoomState);
            setCookie("TrendState", TrendState);
            setCookie("PageState", pageNo);
            setCookie("txtTUSTTIME", sttime);
            setCookie("txtTUEDTIME", edtime);
            setCookie("btnAlramState", alramState);
            setCookie("txtAlramDate", DateAlram);

            setTimeout('location.reload();', '1000');
        }

        // 콤보박스 데이터 바인딩
        function SetCombo() {
            var ht = new Object();
            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetTankCombo", function (e) {

                // 데이터를 가져와서 콤보를 만든다.

                var dt = eval(e).Tables[0];
                var selectBox = document.getElementById('cboTankNo');
                var option;
                var i;

                combo += "<select onchange='Combo_Changed(this);'>";
                comboZoom += "<select id='comboZoom' style='font-size:22pt;' onchange='ComboZoom_Changed(this);'>";
                combo += "<option value=''></option>";
                comboZoom += "<option style='font-size:20pt;' value=''></option>";
                for (i = 0; i < ObjectCount(dt.Rows); i++) {
                    combo += "<option value='" + dt.Rows[i]["TANKNO"] + "'>" + dt.Rows[i]["TANKNO"] + "</option>";
                    comboZoom += "<option style='font-size:20pt;' value='" + dt.Rows[i]["TANKNO"] + "'>" + dt.Rows[i]["TANKNO"] + "</option>";
                    option = document.createElement("option");
                    option.text = dt.Rows[i]["TANKNO"];
                    option.value = dt.Rows[i]["TANKNO"];
                    selectBox.add(option, null);
                }
                combo += "</select>";
                comboZoom += "</select>";

                // 시점문제로 콤보생성후 
                $("#tbMaster>tbody>tr>td").each(function (i) {
                    var dr = new Object();
                    dr["JEHMNAME"] = "";
                    dr["JEHMFULLNAME"] = "　";
                    dr["JECAPA"] = "";
                    dr["JENKLQTY"] = "";
                    dr["JEGKLQTY"] = "";
                    dr["JEGOMASS"] = "";
                    dr["JEHIGH"] = "";
                    dr["LEVEL_H"] = "";
                    dr["LEVEL_L"] = "";
                    dr["JEGOTEMP"] = "";
                    dr["TKTEMPH"] = "";
                    dr["TKTEMPL"] = "";
                    dr["JEPRESS"] = "";
                    dr["JEGOTM"] = "";
                    dr["TNHWAJUNM"] = "";

                    $(this).append(SetTank(dr, i));
                    if (i == 0) {
                        $("#layZoom").append(SetTankZoom(dr));
                    }
                });
                dt = null;
                selectBox = null;
                option = null;
                i = null;

            }, function (e) {
                // Biz 연결오류
                //alert("탱크번호 콤보박스Error");
                saveCookie();
            });

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetHwamulCombo", function (e) {

                // 데이터를 가져와서 콤보를 만든다.

                var dt = eval(e).Tables[0];
                var selectBox = document.getElementById('cboHwamul');
                var option;

                for (var i = 0; i < ObjectCount(dt.Rows); i++) {
                    option = document.createElement("option");
                    option.text = dt.Rows[i]["NAME"];
                    option.value = dt.Rows[i]["NAME"];
                    selectBox.add(option, null);
                }

                dt = null;
                selectBox = null;
                option = null;

            }, function (e) {
                // Biz 연결오류
                //alert("화물 콤보박스 Error");
                saveCookie();
            });

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetHwajuCombo", function (e) {

                // 데이터를 가져와서 콤보를 만든다.

                var dt = eval(e).Tables[0];
                var selectBox = document.getElementById('cboHwaju');
                var option;

                for (var i = 0; i < ObjectCount(dt.Rows); i++) {
                    option = document.createElement("option");
                    option.text = dt.Rows[i]["NAME"];
                    option.value = dt.Rows[i]["NAME"];
                    selectBox.add(option, null);
                }

                dt = null;
                selectBox = null;
                option = null;

            }, function (e) {
                // Biz 연결오류
                //alert("화물 콤보박스 Error");
                saveCookie();
            });

            ht = null;


        }

        // 탱크번호 선택 이벤트
        function Combo_Changed(obj) {
            //$("#runCheck").val("run");
            var ht = new Object();
            // 탱크테이블 상위객체(TD)
            var parent = $(obj).parent().parent().parent();
            // canvas index 가져오기
            var cvsIdx = $(parent).index();
            if ($(parent).parent().index() == 1) {
                cvsIdx += 5;
            }
            var cvsId = 'cvs_' + cvsIdx;

            var html;
            if ($(obj).val() != undefined) {
                ht["JEGOTK"] = $(obj).val();
            }
            else {
                ht["JEGOTK"] = "101";
            }

            if ($(obj).val() != '') {
                PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetTank", function (e) {

                    var dt = eval(e).Tables[0];

                    if (ObjectCount(dt.Rows) > 0) {

                        var color = WarningCheck(dt.Rows[0], cvsIdx);
                        html = SetTank(dt.Rows[0], cvsIdx);
                        RGraph.Reset(document.getElementById(cvsId));
                        // 탱크테이블 삭제
                        $(obj).parent().parent().remove();
                        // 탱크테이블 추가
                        $(parent).append(html);

                        // 컬럼정보를 가져온다
                        var keys = [""];
                        // 바인딩할 데이터를 가져온다
                        //alert(dt.Rows[0]["JEGOPER"].toString());
                        var datas = [dt.Rows[0]["JEGOPER"].toString()];
                        var wcf = ["W.C.F : " + dt.Rows[0]["HMWCF"].toString()];
                        //colors: ['Gradient(#99f:#27afe9:#058DC7:#058DC7)', 'Gradient(#94f776:#50B332:#B1E59F)', 'Gradient(#fe783e:#EC561B:#F59F7D)'],
                        var bar = new RGraph.Bar({
                            id: cvsId,
                            data: datas,
                            options: {
                                ymax: 100,
                                labels: keys,
                                colors: [color],
                                ylabels: true,
                                backgroundGridVlines: false,
                                backgroundGridBorder: false,
                                textSize: 9,
                                tooltips: wcf,
                                tooltipsEvent: 'mousemove',
                                tooltipsEffect: 'none',
                                strokestyle: 'rgba(0,0,0,0)',
                                gutterLeft: 25,
                                gutterRight: 5,
                                gutterBottom: 5,
                                gutterTop: 20,
                                numyticks: 5,
                                labelsAbove: true,
                                labelsAboveUnitsPost: '%',
                                labelsAboveSize: 14,
                                labelsAboveDecimals: 1
                            }
                        }).draw();

                        // 테이블 내부의 콤보박스 데이터 바인딩
                        $(parent).find("select").val(ht["JEGOTK"]);

                        bar = null;
                    }
                    else {
                        var dr = new Object();
                        dr["JEHMNAME"] = "";
                        dr["JEHMFULLNAME"] = "　";
                        dr["JECAPA"] = "";
                        dr["JENKLQTY"] = "";
                        dr["JEGKLQTY"] = "";
                        dr["JEGOMASS"] = "";
                        dr["JEHIGH"] = "";
                        dr["LEVEL_H"] = "";
                        dr["LEVEL_L"] = "";
                        dr["JEGOTEMP"] = "";
                        dr["TKTEMPH"] = "";
                        dr["TKTEMPL"] = "";
                        dr["JEPRESS"] = "";
                        dr["JEGOTM"] = "";
                        dr["TNHWAJUNM"] = "";

                        levelfont = "white";
                        tempfont = "white";
                        pressfont = "white";

                        html = SetTank(dr, cvsIdx);

                        // 탱크테이블 삭제
                        $(obj).parent().parent().remove();
                        // 탱크테이블 추가
                        $(parent).append(html);
                    }
                    dt = null;

                }, function (e) {
                    // Biz 연결오류
                    //alert("탱크레벨 조회 Error" + "/" + $(obj).val());
                    saveCookie();
                });
            }
            else {
                var dr = new Object();
                dr["JEHMNAME"] = "";
                dr["JEHMFULLNAME"] = "　";
                dr["JECAPA"] = "";
                dr["JENKLQTY"] = "";
                dr["JEGKLQTY"] = "";
                dr["JEGOMASS"] = "";
                dr["JEHIGH"] = "";
                dr["LEVEL_H"] = "";
                dr["LEVEL_L"] = "";
                dr["JEGOTEMP"] = "";
                dr["TKTEMPH"] = "";
                dr["TKTEMPL"] = "";
                dr["JEPRESS"] = "";
                dr["JEGOTM"] = "";
                dr["TNHWAJUNM"] = "";

                levelfont = "white";
                tempfont = "white";
                pressfont = "white";

                html = SetTank(dr, cvsIdx);

                // 탱크테이블 삭제
                $(obj).parent().parent().remove();
                // 탱크테이블 추가
                $(parent).append(html);
            }

            //ht = null;
            //parent = null;
            //cvsIdx = null;
            //cvsId = null;
            html = null;
            //setInterval("setRuncheck()", '2000');
        }

        // 탱크 데이터 바인딩
        function SetTank(dr, i) {
            var html = "";
            html += "<div class='tank'>";
            html += "   <form name='selectform'id='fmCbo_" + i + "'>";
            html += combo;
            html += "   <div style='width:190px;margin-left:-55px;margin-top:11px;background-color:#FFFFFF;border:1px solid; text-align:center;'>" + dr["TNHWAJUNM"] + "</div>";
            html += "   </form>";
            html += "   <div class='graph_bx'>";
            html += "       <canvas id='cvs_" + i + "' width='110px' height='290px'>";
            html += "       [No canvas support]";
            html += "       </canvas>";
            html += "   </div>";
            html += "   <table>";
            html += "       <colgroup>";
            html += "           <col style='width: 17%;' />";
            html += "           <col style='width: 26%;' />";
            html += "           <col style='width: 42%;' />";
            html += "       </colgroup>";
            html += "       <tr>";
            //html += "           <th colspan='2'>화물</th>";
            //html += "           <td style='text-align:center;'>" + dr["JEHMNAME"] + "</td>";
            html += "           <td colspan='3' style='text-align:center;font-size:9.5pt;' title='" + dr["JEHMFULLNAME"] + "'>" + dr["JEHMFULLNAME"] + "</td>";
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='2'>KL</th>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JECAPA"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JEGKLQTY"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='2'>MT</th>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JENKLQTY"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JEGOMASS"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='3' style='color:" + levelfont + "'>레벨</th>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JEHIGH"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["LEVEL_H"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>Low</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["LEVEL_L"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='3' style='color:" + tempfont + "'>온도</th>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + parseFloat(dr["JEGOTEMP"]).toFixed(1) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + parseFloat(dr["TKTEMPH"]).toFixed(1) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>Low</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + parseFloat(dr["TKTEMPL"]).toFixed(1) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th colspan='2' style='color:" + pressfont + "'>압력</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + dr["JEPRESS"] + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th colspan='2'>최종</th>";
            html += "           <td style='text-align:center;'>" + dr["JEGOTM"] + "</td>";
            html += "       </tr>";
            html += "   </table>";
            html += "   <div style='margin-top:-5px;'>";
            html += "       <img id='trend_" + i + "'src='/Resources/images/EX_quickmenu_07.png' alt='' onclick='TrendOpen(this);' />";
            html += "       <img id='zoom_" + i + "' src='/Resources/images/board_btn_open.gif' alt='' onclick='TankZoom(this);' />";
            html += "   </div>";
            html += "</div>";

            return html;
        }



        // 탱크 위험도 체크
        function WarningCheck(dr, idx) {

            levelfont = "white";
            tempfont = "white";
            pressfont = "white";

            var alram = 'S';

            var _dLEVEL = dr["LEVEL"];
            var _dLEVEL_H = dr["LEVEL_H"];
            var _dLEVEL_M = _dLEVEL_H - 30;
            var _dJEHIGH = dr["JEHIGH"];

            var _dTEMPMH = dr["TKTEMPH"];
            var _dTEMPML = dr["TKTEMPL"];
            var _dTEMP = dr["JEGOTEMP"];

            var _dPRESSH = 60;
            var _dPRESSL = -40;
            var _dPRESS = dr["JEPRESS"];

            //2019.08.06 임경화 수정
            if (dr["TANKVALUE"] == '904' || dr["TANKVALUE"] == '3007' || dr["TANKVALUE"] == '5001')
            {
               _dPRESSH = 3800;
            }

            var color = 'Gradient(#27afe9:#058DC7:#058DC7)'

            //colors: ['Gradient(#99f:#27afe9:#058DC7:#058DC7)', 'Gradient(#94f776:#50B332:#B1E59F)', 'Gradient(#fe783e:#EC561B:#F59F7D)'],
            //--------------위험레벨 초과------------
            if (_dJEHIGH > _dLEVEL_H) {
                levelfont = "red";
                alram = 'D';
                color = 'Gradient(#F73131:#FE1010:#FF0000)';
                if ($("#alramState").val() == "off") {
                    SoundOn();
                    $("#alramState").val("on");
                }
            }
            //--------------경고레벨 초과------------
            else if (_dJEHIGH > _dLEVEL_M) {
                levelfont = "yellow";
                color = 'Gradient(#FFE400:#FFDF24:#FFCD12)';
            }
            //--------------위험온도 초과------------
            if (_dTEMP > _dTEMPMH) {
                tempfont = "red";
                color = 'Gradient(#F73131:#FE1010:#FF0000)';
            }
            //-------------최저온도 미만-------------
            else if (_dTEMP < _dTEMPML) {
                tempfont = "red";
                color = 'Gradient(#F73131:#FE1010:#FF0000)';
            }
            //--------------위험온도 초과------------
            if (_dTEMP > _dTEMPMH) {
                tempfont = "red";
                color = 'Gradient(#F73131:#FE1010:#FF0000)';
            }
            //-------------최저온도 미만-------------
            else if (_dTEMP < _dTEMPML) {
                tempfont = "red";
                color = 'Gradient(#F73131:#FE1010:#FF0000)';
            }
            //--------------최고압력 이상------------
            if (dr["JEGOTK"] == "904" || dr["JEGOTK"] == "3007" || dr["JEGOTK"] == "5001") {
                _dPRESSH = 3800;
            }

            if (_dPRESS >= _dPRESSH) {
                pressfont = "red";
                alram = 'D';
                color = 'Gradient(#F73131:#FE1010:#FF0000)';
                if ($("#alramState").val() == "off") {
                    SoundOn();
                    $("#alramState").val("on");
                }
            }
            //-------------최저압력 이하-------------
            else if (_dPRESS <= _dPRESSL) {
                pressfont = "red";
                alram = 'D';
                color = 'Gradient(#F73131:#FE1010:#FF0000)';
                if ($("#alramState").val() == "off") {
                    SoundOn();
                    $("#alramState").val("on");
                }
            }

            if (idx != 'zoom') {
                $("#alram_" + idx).val(alram);
            }

            alram = null;

            _dLEVEL = null;
            _dLEVEL_H = null;
            _dLEVEL_M = null;
            _dJEHIGH = null;

            _dTEMPMH = null;
            _dTEMPML = null;
            _dTEMP = null;

            _dPRESSH = null;
            _dPRESSL = null;
            _dPRESS = null;

            return color;
        }

        // 탱크 알람 체크 구현 필요
        function tank_AlramCheck() {
            //$("#divBlock").hide();
            var ht = new Object();

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetPageWarnTank", function (e) {

                var dt = eval(e).Tables[0];

                if (ObjectCount(dt.Rows) > 0) {

                    if ($("#alramState").val() == "off") {
                        SoundOn();
                        $("#alramState").val("on");
                    }
                }
                else {
                    if ($("#alram_0").val() != "D" && $("#alram_1").val() != "D" && $("#alram_2").val() != "D" && $("#alram_3").val() != "D" && $("#alram_4").val() != "D"
                    && $("#alram_5").val() != "D" && $("#alram_6").val() != "D" && $("#alram_7").val() != "D" && $("#alram_8").val() != "D" && $("#alram_9").val() != "D") {
                        if ($("#alramState").val() == "on") {
                            SoundOff();
                            $("#alramState").val("off");
                        }
                    }
                    else { // 삭제
                        if ($("#alramState").val() == "off") {
                            SoundOn();
                            $("#alramState").val("on");
                        }
                    }
                }
                dt = null;
            }, function (e) {
                // Biz 연결오류
                //alert("알람 체크 Error");
                saveCookie();
            });

            var date = new Date();
            date = date.getFullYear() + "-" + ("00" + (date.getMonth() + 1)).slice(-2) + "-" + ("00" + date.getDate()).slice(-2);

            //ht["JALGOIL"] = date;
            ht["JALGOIL"] = "2018-04-11";

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetWarnTank", function (e) {

                var dt = eval(e).Tables[0];

                if (ObjectCount(dt.Rows) > 0) {
                    if (dt.Rows[0]["JALGUBN"] == "1") {
                        document.getElementById('lbAlram').innerHTML = "[알람] 일시 : " + dt.Rows[0]["JALGOILTM"] + " / 탱크번호 : " + dt.Rows[0]["JALTKNO"] + " / 내용 : " + dt.Rows[0]["JALALRGNNM"] + " / 기준 값 : " + dt.Rows[0]["JALSTVALUE"] + " / 현재 값 : " + dt.Rows[0]["JALNWVALUE"];
                    }
                    else {
                        document.getElementById('lbAlram').innerHTML = "";
                    }
                }
                else {
                    document.getElementById('lbAlram').innerHTML = "";
                }
                dt = null;
            }, function (e) {
                // Biz 연결오류
                //alert("알람 체크 Error");
                saveCookie();
            });
            //ht = null;
        }
        // 알람
        var audio = new Audio('/Resources/Images/tank/Exclamation.mp3');

        var start_Alram;

        function SoundOn() {
            clearInterval(start_Alram);
            audio.loop = 'true';
            audio.play();
            start_Alram = setInterval("btnAlramOn()", 1000);
        }
        function SoundOff() {
            clearInterval(start_Alram);
            audio.pause();
            btnAlramOff();
        }
        function btnAlramOn() {
            $("#btnAlram").attr("class", "on");
            setTimeout("$('#btnAlram').attr('class', '')", 500);
        }
        function btnAlramOff() {
            $("#btnAlram").attr('class', '');
        }

        // 화주 선택
        function Hwaju_Change() {

            var ht = new Object();
            ht["JEHWAJU"] = $("#cboHwaju").val();
            
            $("#cboHwamul").val("");
            $("#cboLocate").val("");

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetHwajuTank", function (e) {

                var dt = eval(e).Tables[0];

                if (ObjectCount(dt.Rows) > 0) {
                    $("#fmCbo_0").find("select").val(dt.Rows[0]["TKNO1"]);
                    $("#fmCbo_1").find("select").val(dt.Rows[0]["TKNO2"]);
                    $("#fmCbo_2").find("select").val(dt.Rows[0]["TKNO3"]);
                    $("#fmCbo_3").find("select").val(dt.Rows[0]["TKNO4"]);
                    $("#fmCbo_4").find("select").val(dt.Rows[0]["TKNO5"]);
                    $("#fmCbo_5").find("select").val(dt.Rows[0]["TKNO6"]);
                    $("#fmCbo_6").find("select").val(dt.Rows[0]["TKNO7"]);
                    $("#fmCbo_7").find("select").val(dt.Rows[0]["TKNO8"]);
                    $("#fmCbo_8").find("select").val(dt.Rows[0]["TKNO9"]);
                    $("#fmCbo_9").find("select").val(dt.Rows[0]["TKNO10"]);
                    Combo_Changed($("#fmCbo_0").find("select"));
                    Combo_Changed($("#fmCbo_1").find("select"));
                    Combo_Changed($("#fmCbo_2").find("select"));
                    Combo_Changed($("#fmCbo_3").find("select"));
                    Combo_Changed($("#fmCbo_4").find("select"));
                    Combo_Changed($("#fmCbo_5").find("select"));
                    Combo_Changed($("#fmCbo_6").find("select"));
                    Combo_Changed($("#fmCbo_7").find("select"));
                    Combo_Changed($("#fmCbo_8").find("select"));
                    Combo_Changed($("#fmCbo_9").find("select"));
                }
                dt = null;

            }, function (e) {
                // Biz 연결오류
                //alert("화물 선택 Error");
                saveCookie();
            });
        }

        // 화물 선택
        function Hwamul_Change() {

            var ht = new Object();
            ht["JEHWAMUL"] = $("#cboHwamul").val();

            $("#cboHwaju").val("");
            $("#cboLocate").val("");

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetHwamulTank", function (e) {

                var dt = eval(e).Tables[0];

                if (ObjectCount(dt.Rows) > 0) {
                    $("#fmCbo_0").find("select").val(dt.Rows[0]["TKNO1"]);
                    $("#fmCbo_1").find("select").val(dt.Rows[0]["TKNO2"]);
                    $("#fmCbo_2").find("select").val(dt.Rows[0]["TKNO3"]);
                    $("#fmCbo_3").find("select").val(dt.Rows[0]["TKNO4"]);
                    $("#fmCbo_4").find("select").val(dt.Rows[0]["TKNO5"]);
                    $("#fmCbo_5").find("select").val(dt.Rows[0]["TKNO6"]);
                    $("#fmCbo_6").find("select").val(dt.Rows[0]["TKNO7"]);
                    $("#fmCbo_7").find("select").val(dt.Rows[0]["TKNO8"]);
                    $("#fmCbo_8").find("select").val(dt.Rows[0]["TKNO9"]);
                    $("#fmCbo_9").find("select").val(dt.Rows[0]["TKNO10"]);
                    Combo_Changed($("#fmCbo_0").find("select"));
                    Combo_Changed($("#fmCbo_1").find("select"));
                    Combo_Changed($("#fmCbo_2").find("select"));
                    Combo_Changed($("#fmCbo_3").find("select"));
                    Combo_Changed($("#fmCbo_4").find("select"));
                    Combo_Changed($("#fmCbo_5").find("select"));
                    Combo_Changed($("#fmCbo_6").find("select"));
                    Combo_Changed($("#fmCbo_7").find("select"));
                    Combo_Changed($("#fmCbo_8").find("select"));
                    Combo_Changed($("#fmCbo_9").find("select"));
                }
                dt = null;

            }, function (e) {
                // Biz 연결오류
                //alert("화물 선택 Error");
                saveCookie();
            });
        }

        // 위치 선택
        function Locate_Change() {

            var ht = new Object();
            ht["TNLOCATE"] = $("#cboLocate").val();

            $("#cboHwaju").val("");
            $("#cboHwamul").val("");

            if (ht["TNLOCATE"] != "") {
                PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetLocateTank", cboLocateSave_After);
            }
        }
        function cboLocateSave_After() {
            btnPage_Click(3);
        }

        // 페이지 선택 이벤트
        function btnPage_Click(idx) {

            $("#fmCbo_0").find("select").prop("disabled", true);
            $("#fmCbo_1").find("select").prop("disabled", true);
            $("#fmCbo_2").find("select").prop("disabled", true);
            $("#fmCbo_3").find("select").prop("disabled", true);
            $("#fmCbo_4").find("select").prop("disabled", true);
            $("#fmCbo_5").find("select").prop("disabled", true);
            $("#fmCbo_6").find("select").prop("disabled", true);
            $("#fmCbo_7").find("select").prop("disabled", true);
            $("#fmCbo_8").find("select").prop("disabled", true);
            $("#fmCbo_9").find("select").prop("disabled", true);

            var ht = new Object();
            ht["TKINDEX"] = idx;

            btnPageSelect(idx);

            var id = ("00" + idx).slice(-2);
            $("#btnPage" + id).attr("src", "/Resources/images/tank/num_bt_" + id + "_on.png");
            $("#PageState").val(idx);


            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetTankPage", function (e) {

                var dt = eval(e).Tables[0];

                $("#fmCbo_0").find("select").val(dt.Rows[0]["TKNO1"]);
                $("#fmCbo_1").find("select").val(dt.Rows[0]["TKNO2"]);
                $("#fmCbo_2").find("select").val(dt.Rows[0]["TKNO3"]);
                $("#fmCbo_3").find("select").val(dt.Rows[0]["TKNO4"]);
                $("#fmCbo_4").find("select").val(dt.Rows[0]["TKNO5"]);
                $("#fmCbo_5").find("select").val(dt.Rows[0]["TKNO6"]);
                $("#fmCbo_6").find("select").val(dt.Rows[0]["TKNO7"]);
                $("#fmCbo_7").find("select").val(dt.Rows[0]["TKNO8"]);
                $("#fmCbo_8").find("select").val(dt.Rows[0]["TKNO9"]);
                $("#fmCbo_9").find("select").val(dt.Rows[0]["TKNO10"]);
                Combo_Changed($("#fmCbo_0").find("select"));
                Combo_Changed($("#fmCbo_1").find("select"));
                Combo_Changed($("#fmCbo_2").find("select"));
                Combo_Changed($("#fmCbo_3").find("select"));
                Combo_Changed($("#fmCbo_4").find("select"));
                Combo_Changed($("#fmCbo_5").find("select"));
                Combo_Changed($("#fmCbo_6").find("select"));
                Combo_Changed($("#fmCbo_7").find("select"));
                Combo_Changed($("#fmCbo_8").find("select"));
                Combo_Changed($("#fmCbo_9").find("select"));
                dt = null;

            }, function (e) {
                // Biz 연결오류
                //alert("페이지 선택 Error");
                saveCookie();
            });
            id = null;
            $("#fmCbo_0").find("select").prop("disabled", false);
            $("#fmCbo_1").find("select").prop("disabled", false);
            $("#fmCbo_2").find("select").prop("disabled", false);
            $("#fmCbo_3").find("select").prop("disabled", false);
            $("#fmCbo_4").find("select").prop("disabled", false);
            $("#fmCbo_5").find("select").prop("disabled", false);
            $("#fmCbo_6").find("select").prop("disabled", false);
            $("#fmCbo_7").find("select").prop("disabled", false);
            $("#fmCbo_8").find("select").prop("disabled", false);
            $("#fmCbo_9").find("select").prop("disabled", false);
        }

        // 페이지 선택 버튼 초기화
        function btnPageSelect(idx) {
            $("#btnPage1").attr("class", "");
            $("#btnPage2").attr("class", "");
            $("#btnPage3").attr("class", "");
            $("#btnPage4").attr("class", "");
            $("#btnPage5").attr("class", "");
            $("#btnPage6").attr("class", "");
            $("#btnPage7").attr("class", "");
            $("#btnPage8").attr("class", "");
            $("#btnPage9").attr("class", "");
            $("#btnPage10").attr("class", "");

            $("#btnPage" + idx).attr("class", "on");
            $("#PageNum").val(idx);
        }

        // 페이지 저장 버튼
        function btnPageSave_Click(obj) {
            if (!confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>')) {
                return false;
            }

            ht = new Object();

            ht["TKINDEX"] = $("#PageNum").val();
            ht["TKNO1"] = $("#fmCbo_0").find("select").val();
            ht["TKNO2"] = $("#fmCbo_1").find("select").val();
            ht["TKNO3"] = $("#fmCbo_2").find("select").val();
            ht["TKNO4"] = $("#fmCbo_3").find("select").val();
            ht["TKNO5"] = $("#fmCbo_4").find("select").val();
            ht["TKNO6"] = $("#fmCbo_5").find("select").val();
            ht["TKNO7"] = $("#fmCbo_6").find("select").val();
            ht["TKNO8"] = $("#fmCbo_7").find("select").val();
            ht["TKNO9"] = $("#fmCbo_8").find("select").val();
            ht["TKN10"] = $("#fmCbo_9").find("select").val();
            ht["TKGUBN"] = "A";

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "SetTankPage", btnPageSave_After);
        }
        function btnPageSave_After(e) {
            alert('<Ctl:Text ID="MSG1" runat="server" LangCode="MSG001" Description="저장 되었습니다." Literal="true" />')
        }

        // 알람 버튼
        function btnAlram_Click(obj) {

            if ($("#btnAlramState").val() == "off") {
                var ht = new Object();
                var date = new Date();
                date = date.getFullYear() + "-" + ("00" + (date.getMonth() + 1)).slice(-2) + "-" + ("00" + date.getDate()).slice(-2);

                $("#txtAlramDate").val(date);

                ht["JALGOIL"] = $("#txtAlramDate").val();

                gridAlram.Params(ht);
                gridAlram.BindList(1);

                gridAlram.CallBack = grid_change;

                var width = $(document).width() - 680;

                $("#divAlram").css("left", width + "px");

                $("#divAlram").show();
                $("#btnAlramState").val("on")
                width = null;
            }
            else if ($("#btnAlramState").val() == "on") {
                btnAlramClose_Click();
                $("#btnAlramState").val("off")
            }
        }
        // 알람 조회 버튼
        function btnAlramSerch_Click() {
            BindList();
        }
        function BindList() {
            // PageLoad시 이벤트 정의부분
            var ht = new Object();
            ht["JALGOIL"] = $("#txtAlramDate").val();

            gridAlram.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridAlram.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // 예외처리
            gridAlram.CallBack = grid_change;
        }

        function btnAlramClose_Click(obj) {
            $("#divAlram").hide();
        }
        function grid_change() {
            // 전체데이터
            ht = gridAlram.GetAllRow();

            for (i = 0; i < ObjectCount(ht.Rows); i++) {
                if (ht.Rows[i]["JALGUBN"] == "1" && ht.Rows[i]["JALPGUBN"] == "1") {
                    $("#gridAlram_" + i + "_0").find("div").attr("style", "color:red");
                    $("#gridAlram_" + i + "_1").find("div").attr("style", "color:red");
                    $("#gridAlram_" + i + "_2").find("div").attr("style", "color:red");
                    $("#gridAlram_" + i + "_3").find("div").attr("style", "color:red");
                    $("#gridAlram_" + i + "_4").find("div").attr("style", "color:red");
                    $("#gridAlram_" + i + "_5").find("div").attr("style", "color:red");
                    $("#gridAlram_" + i + "_6").find("div").attr("style", "color:red");
                }
                else if (ht.Rows[i]["JALGUBN"] == "1" && ht.Rows[i]["JALPGUBN"] == "2") {
                    $("#gridAlram_" + i + "_0").find("div").attr("style", "color:blue");
                    $("#gridAlram_" + i + "_1").find("div").attr("style", "color:blue");
                    $("#gridAlram_" + i + "_2").find("div").attr("style", "color:blue");
                    $("#gridAlram_" + i + "_3").find("div").attr("style", "color:blue");
                    $("#gridAlram_" + i + "_4").find("div").attr("style", "color:blue");
                    $("#gridAlram_" + i + "_5").find("div").attr("style", "color:blue");
                    $("#gridAlram_" + i + "_6").find("div").attr("style", "color:blue");
                }
            }
        }


        // 탱크 확대 버튼 이벤트
        function TankZoom(obj) {

            $("#comboZoom").val($(obj).parent().parent().parent().find("select").val());

            ComboZoom_Changed($("#comboZoom"));
            var width = $(document).width() / 2 - 240;

            $("#layZoom").css("left", width + "px");

            $("#layZoom").show();
            $("#tankZoomState").val("on");

            width = null;
        }

        // 탱크 확대 종료
        function TankUnZoom(obj) {
            $("#layZoom").hide();
            $("#tankZoomState").val("off");
        }

        // 확대 탱크번호 선택 이벤트
        function ComboZoom_Changed(obj) {

            var ht = new Object();

            if ($(obj).val() != undefined) {
                ht["JEGOTK"] = $(obj).val();
            }
            else {
                ht["JEGOTK"] = "101";
            }
            //ht["JEGOTK"] = $(obj).val();

            // 탱크테이블 상위객체(TD)
            var parent = $(obj).parent().parent().parent();

            if ($(obj).val() != '') {
                PageMethods.InvokeServiceTable(ht, "TYSCMLIB.TankBiz", "GetTank", function (e) {

                    // 탱크테이블 삭제
                    var dt = eval(e).Tables[0];
                    var color = WarningCheck(dt.Rows[0], 'zoom');
                    var html = SetTankZoom(dt.Rows[0]);

                    RGraph.Reset(document.getElementById("cvs_zoom"));
                    $(obj).parent().parent().remove();
                    // 탱크테이블 추가
                    $(parent).append(html);

                    // 컬럼정보를 가져온다
                    var keys = [""];
                    // 바인딩할 데이터를 가져온다
                    var datas = [dt.Rows[0]["JEGOPER"].toString()];
                    var wcf = ["W.C.F : " + dt.Rows[0]["HMWCF"].toString()];

                    var bar = new RGraph.Bar({
                        id: 'cvs_zoom',
                        data: datas,
                        options: {
                            ymax: 100,
                            labels: keys,
                            colors: [color],
                            ylabels: true,
                            backgroundGridVlines: false,
                            backgroundGridBorder: false,
                            textSize: 14,
                            strokestyle: 'rgba(0,0,0,0)',
                            tooltips: wcf,
                            tooltipsEvent: 'mousemove',
                            tooltipsEffect: 'none',
                            gutterLeft: 35,
                            gutterRight: 0,
                            gutterBottom: 5,
                            gutterTop: 40,
                            numyticks: 5,
                            labelsAbove: true,
                            labelsAboveUnitsPost: '%',
                            labelsAboveSize: 16,
                            labelsAboveDecimals: 1
                        }
                    }).draw();

                    // 테이블 내부의 콤보박스 데이터 바인딩
                    $(parent).find("select").val(ht["JEGOTK"]);

                    bar = null;

                }, function (e) {
                    // Biz 연결오류
                    //alert("탱크 확대 Error");
                    saveCookie();
                });
            }
            else {
                var dr = new Object();
                dr["JEHMNAME"] = "";
                dr["JEHMFULLNAME"] = "　";
                dr["JECAPA"] = "";
                dr["JENKLQTY"] = "";
                dr["JEGKLQTY"] = "";
                dr["JEGOMASS"] = "";
                dr["JEHIGH"] = "";
                dr["LEVEL_H"] = "";
                dr["LEVEL_L"] = "";
                dr["JEGOTEMP"] = "";
                dr["TKTEMPH"] = "";
                dr["TKTEMPL"] = "";
                dr["JEPRESS"] = "";
                dr["JEGOTM"] = "";
                dr["TNHWAJUNM"] = "";

                html = SetTankZoom(dr);

                // 탱크테이블 삭제
                $(obj).parent().parent().remove();
                // 탱크테이블 추가
                $(parent).append(html);

                dr = null;
            }
            //ht = null;
            //parent = null;
        }

        // 탱크 확대 데이터 바인딩
        function SetTankZoom(dr) {
            var html = "";
            html += "<div class='tankzoom'>";
            html += "   <form name='selectform' id='fmCbo_Zoom'>";
            html += comboZoom;
            html += "   <div style='width:290px;height:27px;margin-left:-87px;margin-top:11px;background-color:#FFFFFF;border:1px solid; text-align:center;vertical-align:middle;font-size:19px'>" + dr["TNHWAJUNM"] + "</div>";
            html += "   </form>";
            html += "   </form>";
            html += "   <div class='graphzoom_bx'>";
            html += "       <canvas id='cvs_zoom' width='150px' height='435px'>";
            html += "       [No canvas support]";
            html += "       </canvas>";
            html += "   </div>";
            html += "   <table>";
            html += "       <colgroup>";
            html += "           <col style='width: 17%;' />";
            html += "           <col style='width: 26%;' />";
            html += "           <col style='width: 42%;' />";
            html += "       </colgroup>";
            html += "       <tr>";
            //html += "           <th colspan='2'>화물</th>";
            //html += "           <td style='text-align:center;'>" + dr["JEHMNAME"] + "</td>";
            html += "           <td colspan='3' style='text-align:center;' title='" + dr["JEHMFULLNAME"] + "'>" + dr["JEHMFULLNAME"] + "</td>";
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='2'>KL</th>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JECAPA"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JEGKLQTY"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='2'>MT</th>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JENKLQTY"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JEGOMASS"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='3' style='color:" + levelfont + "'>레벨</th>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["JEHIGH"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["LEVEL_H"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>Low</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + SetComma(parseFloat(dr["LEVEL_L"]).toFixed(3)) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th rowspan='3' style='color:" + tempfont + "'>온도</th>";
            html += "           <th>현재</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + parseFloat(dr["JEGOTEMP"]).toFixed(1) + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>High</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'><input type='text' id='txtTempHigh' value='" + parseFloat(dr["TKTEMPH"]).toFixed(1) + "'></td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th>Low</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'><input type='text' id='txtTempLow' value='" + parseFloat(dr["TKTEMPL"]).toFixed(1) + "'></td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th colspan='2' style='color:" + pressfont + "'>압력</th>";
            if (dr["JEHMNAME"] != "") {
                html += "           <td style='text-align:right;'>" + dr["JEPRESS"] + "</td>";
            }
            else {
                html += "           <td style='text-align:right;'></td>";
            }
            html += "       </tr>";
            html += "       <tr>";
            html += "           <th colspan='2'>최종</th>";
            html += "           <td style='text-align:center;'>" + dr["JEGOTM"] + "</td>";
            html += "       </tr>";
            html += "   </table>";
            html += "   <div id='Zbtn' style='margin-top:5px;margin-left:5px;'>";
            html += "       <img src='/Resources/images/board_btn_close.gif' alt='' onclick='TankUnZoom(this);' />";
            html += "       <ul>";
            html += "           <li>";
            html += "               <a href='#' onclick='btnTempSave_Click(this);'><img src='/Resources/Images/tank/btn_icon_save_temp.png' alt='온도저장'/>온도저장</a>";
            html += "           </li>";
            html += "       </ul>";
            html += "   </div>";
            html += "</div>";

            return html;
        }

        // 온도저장 버튼
        function btnTempSave_Click(obj) {
            if (!confirm('<Ctl:Text ID="MSG04" runat="server" LangCode="MSG02" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>')) {
                return false;
            }

            ht = new Object();

            ht["TANKNO"] = $("#fmCbo_Zoom").find("select").val();
            ht["TANKTEMPH"] = document.getElementById('txtTempHigh').value;
            ht["TANKTEMPL"] = document.getElementById('txtTempLow').value;

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "SetTankTemp", btnTempSave_After);
        }
        function btnTempSave_After(e) {
            alert('<Ctl:Text ID="MSG3" runat="server" LangCode="MSG001" Description="저장 되었습니다." Literal="true" />')
        }
        /********************************************************************************************
        *   작성목적    :  배너 시계 이벤트
        *   수정내역    :
        ********************************************************************************************/

        // 물량추이도 팝업 버튼 이벤트
        function TrendOpen(obj) {

            var date = new Date();
            date = date.getFullYear() + "-" + ("00" + (date.getMonth() + 1)).slice(-2) + "-" + ("00" + date.getDate()).slice(-2);

            var now = new Date();
            var edhours = now.getHours();
            var sthours = now.getHours();

            if (edhours < 4) {
                sthours = 0;
            }
            else {
                sthours = now.getHours() - 3;
            }

            if (edhours < 10) {
                edhours = "0" + edhours;
            }
            if (sthours < 10) {
                sthours = "0" + sthours;
            }

            $("#txtTUSTTIME").val(sthours);
            $("#txtTUEDTIME").val(edhours);

            $("#cboTankNo").val($(obj).parent().parent().parent().find("select").val());
            $("#txtDate").val(date);

            //var height = $(document).height() - 85;
            var height = $(document).height();

            $("#divTrend").css("height", height + "px");
            $("#divTrend").show();
            $("#TrendState").val("on");

            btnTrendSerch_Click();

            date = null;
            height = null;
        }

        // 물량추이도 조회 버튼 이벤트
        function btnTrendSerch_Click() {
            var ht = new Object();
            var graphWidth;

            ht["TUGOTK"] = $("#cboTankNo").val();
            ht["TUGOIL"] = $("#txtDate").val();
            ht["TUSTTIME"] = $("#txtTUSTTIME").val();
            ht["TUEDTIME"] = $("#txtTUEDTIME").val();
            ht["TUGOTM"] = rdoTimeGubn.GetValue();
            ht["TIME"] = "0";

            if (rdoTimeGubn.GetValue() == "60") {
                $("#cvs_trend").attr("width", "1500px");
                graphWidth = "1500px";
            }
            else if (rdoTimeGubn.GetValue() == "30") {
                $("#cvs_trend").attr("width", "3000px");
                graphWidth = "3000px";
            }
            else if (rdoTimeGubn.GetValue() == "10") {
                $("#cvs_trend").attr("width", "9000px");
                graphWidth = "9000px";
            }
            else if (rdoTimeGubn.GetValue() == "1") {

                if ($("#txtTUSTTIME").val() >= $("#txtTUEDTIME").val()) {
                    alert("시작시간이 종료시간보다 크거나 같습니다.");
                    return;
                }
                if ($("#txtTUSTTIME").val() == "" || $("#txtTUEDTIME").val() == "") {
                    alert("1분단위 조회시 시간을 입력해야 합니다.(최대 3시간)");
                    return;
                }
                else {
                    var time = $("#txtTUEDTIME").val() - $("#txtTUSTTIME").val();
                    ht["TIME"] = time;
                    if (time == 1) {
                        $("#cvs_trend").attr("width", "3750px");
                        graphWidth = "3750px";
                    }
                    else if (time == 2) {
                        $("#cvs_trend").attr("width", "7500px");
                        graphWidth = "7500px";
                    }
                    else if (time == 3) {
                        $("#cvs_trend").attr("width", "11250px");
                        graphWidth = "11250px";
                    }
                    else if (time > 3) {
                        alert("1분단위 조회시 최대 3시간까지 조회가능 합니다.");
                        return;
                    }
                }
            }

            PageMethods.InvokeServiceTable(ht, "TYSCMLIB.TankBiz", "GetTrend", function (e) {

                RGraph.Reset(document.getElementById('cvs_trend'));

                var dt = eval(e).Tables[0];

                var keysArr = new Array();
                var datasArr = new Array();
                var massArr = new Array();
                var tempArr = new Array();
                var gklArr = new Array();
                var levelArr = new Array();
                var pressArr = new Array();
                var tooltips = [];
                var maxVal = 0;
                var minVal = 0;
                var decimal = 0;

                for (i = 0; i < ObjectCount(dt.Rows); i++) {
                    keysArr.push(dt.Rows[i]["TUGOTM"]);
                    massArr.push(dt.Rows[i]["TUGOMASS"]);
                    tempArr.push(dt.Rows[i]["TUGOTEMP"]);
                    gklArr.push(dt.Rows[i]["TUGKLQTY"]);
                    levelArr.push(dt.Rows[i]["TUHIGH"]);
                    pressArr.push(dt.Rows[i]["JEPRESS"]);
                }

                if (rdoTrendGubn.GetValue() == "M") {
                    datasArr = massArr;
                    if (dt.Rows[0]["JECAPA"] > dt.Rows[0]["JENKLQTY"]) {
                        maxVal = dt.Rows[0]["JECAPA"];
                    }
                    else {
                        maxVal = dt.Rows[0]["JENKLQTY"];
                    }
                    minVal = 0;
                    decimal = 3;
                }
                else if (rdoTrendGubn.GetValue() == "L") {
                    datasArr = levelArr;
                    maxVal = dt.Rows[0]["TNHIGH"];
                    minVal = 0;
                    decimal = 1;
                }
                else if (rdoTrendGubn.GetValue() == "T") {
                    datasArr = tempArr;
                    maxVal = 120;
                    minVal = -30;
                    decimal = 1;
                }
                else if (rdoTrendGubn.GetValue() == "P") {
                    datasArr = pressArr;  // 압력으로 변경 필요
                    
                    if (dt.Rows[0]["TUGOTK"] == '904' || dt.Rows[0]["TUGOTK"] == '3007' || dt.Rows[0]["TUGOTK"] == '5001') {
                        maxVal = 5000;
                    }
                    else {
                        maxVal = 300;
                    }
                    minVal = -100;
                    decimal = 0;
                }

                datasArr.forEach(function (v, k, arr) {
                    tooltips[k] = '<p>' + keysArr[k] + '</p>';
                    tooltips[k] += '<p align="left"><b>MASS : </b>' + massArr[k] + '</p>';
                    tooltips[k] += '<p align="left"><b>온도 : </b>' + tempArr[k] + '℃</p>';
                    tooltips[k] += '<p align="left"><b>K/L : </b>' + gklArr[k] + '</p>';
                    tooltips[k] += '<p align="left"><b>레벨 : </b>' + levelArr[k] + '</p>';
                    tooltips[k] += '<p align="left"><b>압력 : </b>' + pressArr[k] + '</p>';
                });


                var line = new RGraph.Line({
                    id: 'cvs_trend',
                    data: datasArr,
                    options: {
                        ymax: maxVal,
                        ymin: minVal,
                        labels: keysArr,
                        ylabels: true,
                        ylabelsCount: 10,
                        labelsAbove: true,   //차트 위에 데이터 바로보임
                        labelsAboveBorder: true,
                        labelsAboveDecimals: decimal,
                        labelsAboveSize: 10,
                        tickmarks: 'circle',
                        ticksize: 5,
                        tooltips: function (index) {
                            return tooltips[index];
                        },
                        backgroundGridAutofitNumhlines: 20,
                        backgroundGridColor: '#eee',
                        textSize: 12,
                        gutterLeft: 45,
                        gutterRight: 10,
                        gutterBottom: 5,
                        gutterTop: 50,
                        numyticks: 10
                    }
                }).trace();

                $("#cvs_trend_rgraph_domtext_wrapper span").css("margin-top", "-5px");
                $("#cvs_trend_rgraph_domtext_wrapper").css("width", graphWidth);

            }, function (e) {
                // Biz 연결오류
                //alert("트렌드 조회 Error");
                saveCookie();
            });
        }

        // 물량추이도 닫기 버튼
        function btnTrendClose_Click(obj) {
            $("#TrendState").val("off");
            $("#divTrend").hide();
        }

        // 압력 팝업 버튼
        function btnPress_Click() {
            var xWidth = window.screen.width;
            var xHeight = window.screen.height;

            var userAgent = navigator.userAgent.toLowerCase();

            window.open("/Portal/TANK/TankPressMonitor.aspx", "압력모니터링", "resizable=yes,channelmode=no, width=" + xWidth + ", height=" + xHeight);
            //window.open("http://192.168.100.93:8110//Template/EDU/TankPressMonitor.aspx", "압력모니터링","resizable=yes,channelmode=no, width="+xWidth+", height="+xHeight);
            //window.open("http://localhost:8110//Template/EDU/TankPressMonitor.aspx", "압력모니터링", "resizable=yes,channelmode=no, width=" + xWidth + ", height=" + xHeight);
        }

        /********************************************************************************************
        *   작성목적    :  배너 시계 이벤트
        *   수정내역    :
        ********************************************************************************************/


        function dpTime() {
            var now = new Date();
            var years = now.getYear() + 1900;
            var month = ("00" + (now.getMonth() + 1)).slice(-2);
            var days = ("00" + now.getDate()).slice(-2);
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();

            if (years < 2000) {
                years = years + 1900;
            }
            if (hours < 10) {
                hours = "0" + hours;
            }
            if (minutes < 10) {
                minutes = "0" + minutes;
            }
            if (seconds < 10) {
                seconds = "0" + seconds;
            }
            document.getElementById("clock").innerHTML = years + "-" + month + "-" + days + "<br>" + hours + ":" + minutes + ":" + seconds;

            now = null;
            years = null;
            month = null;
            days = null;
            hours = null;
            minutes = null;
            seconds = null;
        }
        // 세자리 콤마
        function SetComma(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody" >
    <!--컨텐츠시작-->
    <div id="main_body" >
      <!--상단시작-->
      <div id="top" >
         TANK MONITORING SYSTEM
         <div id="clock">
         </div>
      </div>
      <!--//상단끝-->

      <!--버튼시작-->
      <div id="btn" >
         <a href="#" id="btnEmer" style="display:none"><img src="/Resources/Images/tank/btn_icon_alarm.png" alt="비상통보" /> 비상통보</a>
         <lable id="lbAlram" style="margin-left:5px;color:Red;"></lable>
         <ul>
            <li>
                화주 :
      			<select name="cboHwaju" id="cboHwaju" title="화주" onchange="Hwaju_Change()" style="width:200px;margin-right:5px;">
      				<option value=""></option>
      			</select>

      			화물 :
      			<select name="cboHwamul" id="cboHwamul" title="화물" onchange="Hwamul_Change()" style="width:200px;margin-right:5px;">
      				<option value=""></option>
      			</select>
      			
      			위치 :
      			<select name="cboLocate" id="cboLocate" title="위치" onchange="Locate_Change()" style="width:80px;">
      				<option value=""></option>
                    <option value="1">상단지</option>
                    <option value="2">하단지</option>
                    <option value="5">송유단지</option>
                    <option value="7">해안단지</option>
      			</select>
            </li>
            <li class="page">
               <a href="#" id="btnPage1" onclick="btnPage_Click(1);" class="on">1</a>
               <a href="#" id="btnPage2" onclick="btnPage_Click(2);">2</a>
               <a href="#" id="btnPage3" onclick="btnPage_Click(3);">3</a>
               <a href="#" id="btnPage4" onclick="btnPage_Click(4);">4</a>
               <a href="#" id="btnPage5" onclick="btnPage_Click(5);">5</a>
               <a href="#" id="btnPage6" onclick="btnPage_Click(6);">6</a>
               <a href="#" id="btnPage7" onclick="btnPage_Click(7);">7</a>
               <a href="#" id="btnPage8" onclick="btnPage_Click(8);">8</a>
               <a href="#" id="btnPage9" onclick="btnPage_Click(9);">9</a>
               <a href="#" id="btnPage10" onclick="btnPage_Click(10);">10</a>
            </li>
            <li>
               <a href="#" onclick="btnPageSave_Click(this);"><img src="/Resources/Images/tank/btn_icon_save.png" alt="저장" /> 저장</a>
               <a href="#" id="btnAlram" onclick="btnAlram_Click(this);"><img src="/Resources/Images/tank/btn_icon_alram.gif" alt="알람" /> 알람</a>
               <a href="#" id="btnPress" onclick="btnPress_Click(this);"><img src="/Resources/Images/tank/btn_icon_press.png" alt="압력" /> 압력</a>
               <%--<a href="#"><img src="/Resources/Images/tank/btn_icon_reset.png" alt="전환" /> 전환</a>--%>
               <a href="#" onclick="window.close();"><img src="/Resources/Images/tank/btn_icon_close.png" alt="닫기" /> 닫기</a>
            </li>
         </ul>
      </div>
      <!--//버튼끝-->

      <!--컨텐츠시작-->
      <div id="container" style="z-index:1;overflow:auto;white-space:nowrap;">
        <table border="0" cellpadding="0" cellspacing="0" id="tbMaster" align="center" width="100%">
            <colgroup>
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
            </colgroup>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <input type="hidden" id="PageNum" value="1"/>
        <input type="hidden" id="alram_0" value="S"/>
        <input type="hidden" id="alram_1" value="S"/>
        <input type="hidden" id="alram_2" value="S"/>
        <input type="hidden" id="alram_3" value="S"/>
        <input type="hidden" id="alram_4" value="S"/>
        <input type="hidden" id="alram_5" value="S"/>
        <input type="hidden" id="alram_6" value="S"/>
        <input type="hidden" id="alram_7" value="S"/>
        <input type="hidden" id="alram_8" value="S"/>
        <input type="hidden" id="alram_9" value="S"/>
        <input type="hidden" id="alramState" value="off"/>
        <input type="hidden" id="tankZoomState" value="off"/>
        <input type="hidden" id="TrendState" value="off"/>
        <input type="hidden" id="PageState" value=""/>
        <input type="hidden" id="runCheck" value=""/>
        <input type="hidden" id="btnAlramState" value="off"/>
      </div>
      <!--//컨텐츠끝-->
      
      <!--//알람 페이지-->
      <div id="divAlram" style="display:none;position:absolute;top:110px;width:680px;height:400px;background:white;z-index:2" align="left">
        　일자
        <Ctl:TextBox ID="txtAlramDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" style ="width:110px;"></Ctl:TextBox>
        <a href="#" onclick="btnAlramSerch_Click();"><img src="/Resources/Images/tank/btn_icon_search.gif" style="margin-left:10px;" alt="조회"/>조회</a>
        <Ctl:Layer ID="layer4" runat="server" Title="">
            <Ctl:WebSheet ID="gridAlram" runat="server" Paging="false" CheckBox="false" HFixation="true" Width="100%" Height="322" TypeName="TYSCMLIB.TankBiz" MethodName="GetWarnTank" UseColumnSort="true">
                <Ctl:SheetField DataField="JALGOILTM" TextField="JALGOILTM" Description="알람 일시" Width="100" HAlign="left" Align="left" runat="server" />
                <Ctl:SheetField DataField="JALTKNO" TextField="TNTANKNO" Description="탱크번호" Width="40"  HAlign="left" Align="left" runat="server" OnClick="" />
                <Ctl:SheetField DataField="JALALRGNNM" TextField="JALALRGNNM" Description="알람내용" Width="60" HAlign="left" Align="left" runat="server" />
                <Ctl:SheetField DataField="JALSTVALUE" TextField="JALSTVALUE" Description="기준 값" Width="40" HAlign="right" Align="right" runat="server" />
                <Ctl:SheetField DataField="JALNWVALUE" TextField="JALNWVALUE" Description="발생 값" Width="40" HAlign="right" Align="right" runat="server" />
                <Ctl:SheetField DataField="JALCLGOILTM" TextField="JALCLGOIL" Description="해제 일시" Width="100" HAlign="left" Align="left" runat="server" />
                <Ctl:SheetField DataField="JALCLVALUE" TextField="JALCLVALUE" Description="해제 값" Width="40" HAlign="right" Align="right" runat="server" />
                <Ctl:SheetField DataField="JALGUBN" TextField="JALGUBN" Description="종료구분" Hidden="true" runat="server" />
                <Ctl:SheetField DataField="JALPGUBN" TextField="JALPGUBN" Description="저장구분" Hidden="true" runat="server" />
            </Ctl:WebSheet>
        </Ctl:Layer>
      </div>
      <!--//확대, 트렌트 시작-->
      <div id="layZoom" style="display:none;position:absolute;top:105px;width:480px;height:690px;background:rgba(0,0,0,0);z-index:3"></div>
      <div id="divTrend" style="display:none;position:absolute;top:75px;left:0px;width:100%;background-color:#D5D5D5;z-index:3;overflow:auto;">
        <div id="Tbtn">
            <ul>
                <li>
                    탱크번호
                    <select id="cboTankNo" onchange="" style="margin-right:10px;width:80px;">
                        <option value=""></option>
                    </select>
                    일자
                    <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" style ="margin-right:10px;width:110px;"></Ctl:TextBox>
                    <Ctl:Text ID="Text1" runat="server" Description="구분" Height="22"></Ctl:Text>
                    <div style="border: 1px solid #B3B7BC;border-radius:5px;position:absolute;left:330px;top:1px;">                    
                    <Ctl:Radio ID="rdoTrendGubn" runat="server" RepeatColumns="2">
                        <asp:ListItem Selected="True" Text=" MASS" Value="M"></asp:ListItem>
                        <asp:ListItem Text=" LEVEL" Value="L"></asp:ListItem>
                        <asp:ListItem Text=" 온도" Value="T"></asp:ListItem>
                        <asp:ListItem Text="압력" Value="P"></asp:ListItem>
                    </Ctl:Radio>
                    </div>
                    <Ctl:Text ID="Text2" runat="server" style="margin-left:250px;" Description="단위" Height="22"></Ctl:Text>
                    <div style="border: 1px solid #B3B7BC;border-radius:5px;position:absolute;left:610px;top:1px;">
                    <Ctl:Radio ID="rdoTimeGubn" runat="server" RepeatColumns="2">
                        <asp:ListItem Text=" 1시간" Value="60"></asp:ListItem>
                        <asp:ListItem Selected="True" Text=" 30분" Value="30"></asp:ListItem>
                        <asp:ListItem Text=" 10분" Value="10"></asp:ListItem>
                        <asp:ListItem Text=" 1분" Value="1"></asp:ListItem>
                    </Ctl:Radio>
                    </div>
                    <Ctl:Text ID="Text3" runat="server" style="margin-left:240px;" Description="시간" Height="22"></Ctl:Text>
                    <Ctl:TextBox ID="txtTUSTTIME" runat="server" SetType="Number" style ="width:20px;" MaxLength="2"></Ctl:TextBox>
                    ~
                    <Ctl:TextBox ID="txtTUEDTIME" runat="server" SetType="Number" style ="margin-right:10px;width:20px;" MaxLength="2"></Ctl:TextBox>
                    <a href="#" onclick="btnTrendSerch_Click();"><img src="/Resources/Images/tank/btn_icon_search.gif" alt="조회"/> 조회</a>
                    <a href="#" onclick="btnTrendClose_Click(this);"><img src="/Resources/Images/tank/btn_icon_close.png" alt="닫기"/> 닫기</a>
                </li>
            </ul>
        </div>
        <div style="height:800px;width:100%;overflow:auto;">
            <canvas id='cvs_trend' width="3000px" height="750px;">
                [No canvas support]
            </canvas>
        </div>
    </div>
      <!--//확대, 트렌트 끝-->
      
      <!--하단시작-->
      <div id="btm">
         <img src="/Resources/Images/tank/btm_logo.gif" alt="" /> COPYRIGHT 2013 BY TAEYOUNG INDUSTRY PSM SYSTEM
      </div>
      <!--//하단끝-->
      
   </div>
</asp:content>