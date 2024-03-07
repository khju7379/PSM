<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlantsSafetyMonitoring.aspx.cs" Inherits="TaeYoung.Portal.PSM.PlantsSafetyMonitoring" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style>
            label
            {
                position:relative;
                overflow:visible;
                visibility:visible;
            }
            
            .unitTitle *
            {
                font : 11px/13px arial, tahoma, helvetica, sans-serif;
                line-height:normal;
            }   
            
            .x-table-layout {
                /*padding : 5px;*/
            }
        
            .x-table-layout td {
                font-size : 11px;
                padding   : 3px;
                vertical-align : top;
            }
            .x-table-layout .x-panel-header-default
            {
                border-top-left-radius:5px;
                border-top-right-radius:5px;
            }
            
            .x-panel-default-framed
            {
                border-width:0px;
                border-top-left-radius:0px;
                border-top-right-radius:0px;
                border-bottom-left-radius:8px;
                border-bottom-right-radius:8px;
                background-color:#FFFFFF;
            }
            .mGrid .x-nlg .x-panel-header-default-framed-top
            {
                height:30px;
                padding-top:5px;
                background-color:#b13f6b;
                background-images:none;
            }
            .x-grid-header-ct
            {
                /*margin-left:1px;*/
            }
            .x-column-header 
            {
                font-family:맑은 고딕;
            }
            .x-grid-body
            {
                background-color:#f5f6f8;
            }
            
            #winUnitInfos .x-panel-header-default
            {
                border-top-left-radius:6px;
                border-top-right-radius:6px;
            }
            
            #winUnitInfos .x-panel-body-default 
            {
                border-bottom-left-radius:6px;
                border-bottom-right-radius:6px;
            }
            
            #winUnitInfos .x-fieldset 
            {
                border-top-left-radius:5px;
                border-top-right-radius:5px;
                border-bottom-left-radius:5px;
                border-bottom-right-radius:5px;
                background-color:#f5f6f8;
            }
            
            @keyframes mymove
            {
                from {
                    opacity:1;
                    filter:alpha(opacity=100); /* For IE8 and earlier */
                }
                to {
                    opacity:0.4;
                    filter:alpha(opacity=40); /* For IE8 and earlier */
                }
            }

            @-webkit-keyframes mymove /*Safari and Chrome*/
            {
                from {
                    opacity:1;
                    filter:alpha(opacity=100); /* For IE8 and earlier */
                }
                to {
                    opacity:0.4;
                    filter:alpha(opacity=40); /* For IE8 and earlier */
                }
            }
            
            #bodyContents_pnlMain_Content 
            {
                height:800px;
            }
            
            .MonitorSubWin {position:absolute; z-index:100;}
            .MonitorSubWin .mswHeader { width:100%; height:30px; background-color:#b13f6b; border-top-left-radius:8px; border-top-right-radius:8px;}
            .MonitorSubWin .mswHeader .mswTitle {color:#FFFFFF;font-size:13pt;padding:5px 15px;}
            .MonitorSubWin .mswHeader .mswClose {position:absolute; right:0px; top:0px; padding:3px 15px;}
            .MonitorSubWin .mswHeader .mswClose a {color:#FFFFFF; font-size:15pt; text-decoration:none;}
            .MonitorSubWin .mswBody {position:relative; width:100%; background-color:#FFFFFF; padding:5px; border-bottom-left-radius:8px; border-bottom-right-radius:8px;}
            
            /* 상태별 이미지 표시 지정 */
            div.unitTitle { position:absolute; left:0px; top:0px; height:100%; width:100%; z-index:1; }
            .unitTitle table { height:100%; width:100%; }
            .unitTitle a { color:#FFFFFF; text-decoration:none; }
            /*
            div.unitTitle { position:absolute; left:0px; top:0px; height:100%; width:100%; z-index:10; }
            .unitTitle div { position:relative; height:auto; width:100%; margin-top:10px; margin-bottom:10px; }
            .unitTitle table { height:100%; width:100%; }
            .unitTitle td { color:#FFFFFF; }
            .unitTitle td a { color:#FFFFFF; top:0px; text-decoration:none; }
            */
            
            div.mUnit { z-index:5; }
            div.st01 { z-index:5; }
            div.st02 { z-index:9; }
            div.st03 { z-index:8; }
            div.st04 { z-index:7; }
            
            div.st01 img.st01
            {
                display:inline;
            }
            div.st01 img.st02,
            div.st01 img.st03,
            div.st01 img.st04, 
            div.st01 .st01Hide 
            {
                display: none;
            }
            
            
            div.st02 img.st02
            {
                display:inline;
                animation:mymove 1s infinite;
                -webkit-animation:mymove 1s infinite; /*Safari and Chrome*/
                animation-timing-function:ease-in-out;
            }
            div.st02 img.st01,
            div.st02 img.st03,
            div.st02 img.st04
            {
                display: none;
            }
            
            div.st03 img.st03
            {
                display:inline;
                animation:mymove 1s infinite;
                -webkit-animation:mymove 1s infinite; /*Safari and Chrome*/
                animation-timing-function:ease-in-out;
            }
            div.st03 img.st01,
            div.st03 img.st02,
            div.st03 img.st04
            {
                display: none;
            }
            
            div.st04 img.st04
            {
                display:inline;
                animation:mymove 1s infinite;
                -webkit-animation:mymove 1s infinite; /*Safari and Chrome*/
                animation-timing-function:ease-in-out;
            }
            div.st04 img.st01,
            div.st04 img.st02,
            div.st04 img.st03
            {
                display: none;
            }
            
            
    </style>
    <ext:ResourceManager ID="ResourceManager1" runat="server" /> 
    <ext:XScript ID="XScript1" runat="server">
    <script>
            //문자열을 구분자 사이에 값을 가져옴
            function GetMiddleString(pStr, pfStr, tStr) {
                var fp = pStr.indexOf(pfStr);
                if (fp < 0) return "";
                fp += pfStr.length;
                var tp = pStr.indexOf(tStr, fp);
                if (tp < 0) return pStr.substr(fp);
                else return pStr.substring(fp, tp);
            }

            // 정보화면 보이기
            function OpenUnitInfoWin(recordKey) {                

                if( recordKey.substr(6,3) == "000" )
                {
                   SetWorkUnitGroup(recordKey);
                }
                else
                {
                    #{btnPrevious}.hide();
                    #{btnNext}.hide();
                }
                var sto = #{stoPlantUnits};
                var record = sto.findRecord("UNITCODE", recordKey);
                var form = #{fmUnitInfos};
                if (record) {
                    if (record.data.UNITSTATUS == "01") return;
                    document.getElementById("winUnitInfos").style.display = "";
                    #{fsUnitInfos}.updateLayout(false, false);
                    var rObj = document.getElementById("unit_" + recordKey);
                    var x = 1650 / 2;
                    var y = 756 / 2;
                    var sx = 0;
                    var sy = 0;
                    if (record.data.UNITWINDOW != "Main") {
                        var sWin = document.getElementById("winMonitor" + record.data.UNITWINDOW);
                        sx = sWin.offsetLeft;
                        sy = sWin.offsetTop + 30;
                    }
                    var cx = rObj.offsetLeft + parseInt(rObj.offsetWidth / 2, 10);
                    var cy = rObj.offsetTop + parseInt(rObj.offsetHeight / 2, 10);
                    var px = 0;
                    var py = 0;

                    if ((sx + cx) < x) {
                        px = rObj.offsetLeft + sx + rObj.offsetWidth + 10;
                    } else {
                        px = rObj.offsetLeft + sx - document.getElementById("winUnitInfos").offsetWidth - 10;
                    }

                    if ((sy + cy) < y) {
                        py = rObj.offsetTop + sy - 10;
                    } else {
                        py = rObj.offsetTop + sy - 10;
                        if (((y * 2) - py) < document.getElementById("winUnitInfos").offsetHeight) {
                            py = py - document.getElementById("winUnitInfos").offsetHeight + ((y * 2) - py);
                        }
                    }

                    document.getElementById("winUnitInfos").style.left = px + "px";
                    document.getElementById("winUnitInfos").style.top = py + "px";
                    form.loadRecord(record);

                    //SetWorkUnitGroup(recordKey); 
                }
            }

            function CloseUnitInfoWin() {
                document.getElementById("winUnitInfos").style.display = "none";
            }

            function OpenSubWin(id) {
                document.getElementById(id).style.display = "";

               if( id == "winShipInofs" ){
                  #{grdShip}.updateLayout(false, false);
               }

            }

            function CloseSubWin(id) {
                document.getElementById(id).style.display = "none";
            }

            function setTransformStyle(obj, attrName, value) {
                var setFlags = ["", "ms", "webkit", "moz", "o"];
                for (var i = 0; i < setFlags.length; i++) {
                    obj.style[setFlags[i] + attrName] = value;
                }
            }

            function drowUnits(store) {
                var count = store.getCount();
                var data = null;
                for (var i = 0; i < count; i++) {
                    data = store.getAt(i).data;
                    setUnit(data);
                }
            }

            // 시설 임시아이템 추가
            function getTestData(store) {
                var tList = [
                    { UNITCODE: "T0001", UNITDESC: "CHAIN CONVEYOR", UNITWINDOW: "Main", UNITPOINTX: 523, UNITPOINTY: 273, UNITTYPE: "SUBPOINT", UNITSTATUS: "01", UNITSTYTLE: "" },
                    { UNITCODE: "T0002", UNITDESC: "CHAIN CONVEYOR", UNITWINDOW: "Main", UNITPOINTX: 732, UNITPOINTY: 513, UNITTYPE: "SUBPOINT", UNITSTATUS: "01", UNITSTYTLE: "" }
                ];

                store.add(tList);
                return;
            }

            // 작업 현황 임시 추가
            function getTestData_1(store) {
                var tList = [
                    //{ PONUM: "13213213", SMWKORSEQ: "010", SMSYSTEMCODE1: "40045001", SMSYSTEMCODE2: "", DSPCOLOR: "3" }
                ];

                store.add(tList);
                return;
            }

            function setUnit(data) {
                // 상태별 개체생성
                if (data.UNITWINDOW == "") return;
                var div = document.getElementById("unit_" + data.UNITCODE);
                if (!div) {
                    div = document.createElement("div");
                    div.id = "unit_" + data.UNITCODE;
                    div.style.position = "absolute";
                    var imgStr = "";
                    var ImgFileName = "";
                    var addStyle = "";
                    if (data.UNITTYPE == "TANK100") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%; padding-bottom:5px;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "TANK101") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "TANK102") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "TANK103") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"right\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"right\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "TANK200") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%; padding-bottom:5px;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "TANK201") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "TANK202") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "TANK203") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"right\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"right\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "SHIP") {
                        imgStr += "<a href=\"javascript:void(0);\""+GetUnitClickFunction(data.UNITCODE)+ "\">";
                        imgStr += "<img id='" + data.UNITCODE + "_01'  src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02'  src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<div id = 'winunitship_Now' class=\"unitTitle\" style=\"margin-top:18px; \"><table style=\"width:100px;position:relative; left:200px; top:-20px; display:none; \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:red;\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div id = 'winunitship_Target' class=\"unitTitle\" style=\"margin-top:18px; \"><table style=\"width:100px;position:relative; left:200px; top:-20px; display:none; \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:red;\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "</a>";
                    } else if (data.UNITTYPE == "UNLOADER") {
                        imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (data.UNITTYPE == "AREA") {
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        addStyle = "padding-bottom:15px;";
                        //imgStr += "<div class=\"unitTitle st01Hide\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle st01Hide\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else if (data.UNITTYPE == "SUBPOINT") {
                        imgStr += "<a href=\"javascript:void(0);\"" + GetUnitClickFunction(data.UNITCODE) + " onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (data.UNITTYPE == "CHAINCONVEYOR") {
                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_03.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITTYPE + "_04.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"margin-top:10px;\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\" style=\"color:#000000;\">" + data.UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"margin-top:10px;\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" style=\"color:#000000;\">" + data.UNITDESC + "</a></td></tr></table></div>";
                    } else {
                        //imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" >";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_01.png\" class=\"st01\" />";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_02.png\" class=\"st02\" />";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_03.png\" class=\"st03\" />";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_04.png\" class=\"st04\" />";

                        ImgFileName = data.UNITCODE.substr(1, 1) + data.UNITCODE.substr(3, 4);

                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_01.png\" class=\"st01\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_02.png\" class=\"st02\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_03.png\" class=\"st03\" />";
                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_04.png\" class=\"st04\" />";


//                        imgStr += "<img id='" + data.UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(1, data.UNITCODE.length - 4) + "_01.png\" class=\"st01\" />";
//                        imgStr += "<img id='" + data.UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(1, data.UNITCODE.length - 4) + "_02.png\" class=\"st02\" />";
//                        imgStr += "<img id='" + data.UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(1, data.UNITCODE.length - 4) + "_03.png\" class=\"st03\" />";
//                        imgStr += "<img id='" + data.UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + data.UNITCODE.substr(1, data.UNITCODE.length - 4) + "_04.png\" class=\"st04\" />";

                        imgStr += "</a>";
                        if (data.UNITCODE == "S200025000") {
                            // 별관은 부원료창고와 겹치므로 위에 오도록 예외처리
                            div.style.zIndex = "6";
                        }
                        if (data.UNITCODE == "S400015000") div.style.zIndex = "3";
                        else if (data.UNITCODE == "S400020000") div.style.zIndex = "3";
                        else if (data.UNITCODE == "S400030000") div.style.zIndex = "3";
                        else if (data.UNITCODE == "S400035000") div.style.zIndex = "3";
                        else if (data.UNITCODE == "S400040000") div.style.zIndex = "3";
                    }
                    div.innerHTML = imgStr;
                    
                    if (data.UNITTYPE == "SUBPOINT") {
                        div.style.left = (data.UNITPOINTX - 23) + "px";
                        div.style.top = (data.UNITPOINTY - 66) + "px";
                    } else if (data.UNITTYPE == "AREA") {
                        div.style.left = (data.UNITPOINTX - 27) + "px";
                        div.style.top = (data.UNITPOINTY - 42) + "px";
                    } else {
                        div.style.left = data.UNITPOINTX + "px";
                        div.style.top = data.UNITPOINTY + "px";
                    }
                }
                div.className = "mUnit st" + data.UNITSTATUS;
                var mBody = document.getElementById("Monitor" + data.UNITWINDOW);
                mBody.appendChild(div);
            }
            
            // 특정설비 클릭이벤트 부여
            function GetUnitClickFunction(code) {
                var retStr = "";
                switch (code) {
                    case "T0001":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub1');\"";
                        break;
                    case "T0002":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub2');\"";
                        break;
                    case "S70001001":
                        retStr = " onclick=\"OpenSubWin('winShipInofs');\"";
                        break;
                }
                return retStr;
            }

            function GetSubPointKey(code) {
                if (code >= "400045" && code <= "400120") {
                    return "T0001";
                } else if (code >= "400125" && code <= "400140") {
                    return "T0002";
                }
                return "";
            }
        
            //설비 작업현황 갱신
            function setWorkingList(workStore, unitStore) {
                // 모든 설비 상태 초기화
                var count = unitStore.getCount();
                var data = null;
                for (var i = 0; i < count; i++) {
                    data = unitStore.getAt(i).data;
                    data.UNITSTATUS = "01";
                    data.UNITCODEDETAIL = "";
                    data.UNITDESCDETAIL = "";
                    data.SMMETHODCODENM = "";
                    data.SMAREATEXT1 = "";
                    data.SMWKMETHODNM = "";
                    data.SMREVTEAMNM = "";
                    data.SMRESSABUNNM = "";
                    data.PONUM = "";
                    data.SMWKORAPPDATE = "";
                    data.SMWKORSEQ = "";
                }

                // 가져온 설비작업에 따라 설비상태 설정
                var count = workStore.getCount();
                var data = null;
                for (var i = 0; i < count; i++) {
                    data = workStore.getAt(i).data;
                    setWorkingData(data, unitStore);
                }
                drowUnits(unitStore);
            }

            // 작업정보 설정
            function setWorkingData(data, unitStore) {
                //sto.findRecord("UNITCODE", recordKey);
                var recordKey = "";
                var recordKeyname = "";
                var record = "";

                // 설비1
                recordKey = data.SMSYSTEMCODE1;
                recordKeyname = data.SMSYSTEMCODE1NM;
                if (recordKey) {
                    record = unitStore.findRecord("UNITCODE", recordKey)
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 6)))
                    record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 7)))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                }
                // 설비2
                recordKey = data.SMSYSTEMCODE2;
                recordKeyname = data.SMSYSTEMCODE2NM;
                if (recordKey) {
                    record = unitStore.findRecord("UNITCODE", recordKey)
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 6)))
                    record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 7)))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                }

                // 설비3
                recordKey = data.SMSYSTEMCODE3;
                recordKeyname = data.SMSYSTEMCODE3NM;
                if (recordKey) {
                    record = unitStore.findRecord("UNITCODE", recordKey)
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 6)))
                    record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 7)))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                }

                // 설비4
                recordKey = data.SMSYSTEMCODE4;
                recordKeyname = data.SMSYSTEMCODE4NM;
                if (recordKey) {
                    record = unitStore.findRecord("UNITCODE", recordKey)
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 6)))
                    record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 7)))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                }

                // 설비5
                recordKey = data.SMSYSTEMCODE5;
                recordKeyname = data.SMSYSTEMCODE5NM;
                if (recordKey) {
                    record = unitStore.findRecord("UNITCODE", recordKey)
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                    //record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 6)))
                    record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 7)))
                    if (record) {
                        setWorkingData2Unit(data, record.data,recordKey, recordKeyname);
                    }
                }
                
                // 연관설비1
                for (var i=1; i<=5; i++) {
                    recordKey = data["SMCONNCODE" + i + "1"];
                    recordKeyname = data["SMCONNCODE" + i + "1NM"];
                    if (recordKey) {
                        record = unitStore.findRecord("UNITCODE", recordKey)
                        if (record) {
                            setWorkingData2Unit(data, record.data, recordKey, recordKeyname);
                        }
                        //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                        record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                        if (record) {
                            setWorkingData2Unit(data, record.data, recordKey, recordKeyname);
                        }
                        //record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 6)))
                        record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 7)))
                        if (record) {
                            setWorkingData2Unit(data, record.data, recordKey, recordKeyname);
                        }
                    }
                    recordKey = data["SMCONNCODE" + i + "2"];
                    recordKeyname = data["SMCONNCODE" + i + "2NM"];
                    if (recordKey) {
                        record = unitStore.findRecord("UNITCODE", recordKey)
                        if (record) {
                            setWorkingData2Unit(data, record.data, recordKey, recordKeyname);
                        }
                        //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                        record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                        if (record) {
                            setWorkingData2Unit(data, record.data, recordKey, recordKeyname);
                        }
                        //record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 6)))
                        record = unitStore.findRecord("UNITCODE", GetSubPointKey(recordKey.substr(0, 7)))
                        if (record) {
                            setWorkingData2Unit(data, record.data, recordKey, recordKeyname);
                        }
                    }
                }

                // 주변지역
                for (var i=1; i<=5; i++) {
                    recordKey = data["SMAREACODE" + i];
                    recordKeyname = data["SMAREACODE" + i+"NM"];
                    if (recordKey) {
                        record = unitStore.findRecord("UNITCODE", recordKey)
                        if (record) {
                            setWorkingData2Unit(data, record.data, recordKey, recordKeyname);
                        }
                    }
                }
            }
            
            // 설비데이터에 작업정보 설정
            function setWorkingData2Unit(wData, uData, recordKey, recordKeyname) {
                //변경 우선순위 확인
                var tS = "01";
                if (wData.DSPCOLOR == "1") tS = "02";
                else if (wData.DSPCOLOR == "2") tS = "03";
                else if (wData.DSPCOLOR == "3") tS = "04";

                if (uData.UNITSTATUS == "01" || uData.UNITSTATUS > tS) {
                    uData.UNITSTATUS = tS;
                    uData.UNITCODEDETAIL = recordKey;
                    uData.UNITDESCDETAIL = recordKeyname;
                    uData.SMMETHODCODENM = wData.SMMETHODCODENM;
                    uData.SMAREATEXT1 = wData.SMAREATEXT1;
                    uData.SMWKMETHODNM = wData.SMWKMETHODNM;
                    uData.SMREVTEAMNM = wData.SMREVTEAMNM;
                    uData.SMRESSABUNNM = wData.SMRESSABUNNM;
                    uData.PONUM = wData.PONUM;
                    uData.SMWKORAPPDATE = wData.SMWKORAPPDATE;
                    uData.SMWKORSEQ = wData.SMWKORSEQ;
                }
            }

            // 창 화면에 따른 모니터링 화면 크기조정
            function MonitorBodyResize(winName) {
                var winSize = { Main: { x: 1694, y: 800} };
                var wbody = document.getElementById("Monitor" + winName);
                var factorX = wbody.parentNode.offsetWidth / winSize[winName].x;
                var factorY = wbody.parentNode.offsetHeight / winSize[winName].y;
                var factor = (factorX < factorY ? factorX : factorY);
                setTransformStyle(wbody, "Transform", "scaleX(" + factor + ") scaleY(" + factor + ")");
                setTransformStyle(wbody, "TransformOrigin", "top left");
                
                var mbody = #{pnlMain}.body.dom;
                var fh = winSize[winName].y * factor;
                var m = parseInt((mbody.offsetHeight - fh) / 2, 10);
                wbody.parentNode.style.paddingTop = m + "px";

                // 화면위치 예외처리
                $("#MonitorMain").css("margin","30px");
            }


            //작업현황 클릭시 해당 설비 5초동안 깜빡이기 
              var ext = false;

              function fade(v, x, y, z) {
                var pntid = v;
                var exe_cnt = x + 1;
                var b = y;
                var c = z;

                if (exe_cnt >= 1000) {
                    document.getElementById(pntid).filters.alpha.opacity = 100;
                    return;
                }

                if (pntid.length == 0)
                    return;

                if (document.all);
                if (c == true) {
                    b++;
                }
                if (b == 100) {
                    b--;
                    c = false
                }
                if (b == 10) {
                    b++;
                    c = true;
                }
                if (c == false) {
                    b--;
                }

                if (ext == true) {
                    document.getElementById(pntid).filters.alpha.opacity = 0 + b;
                    setTimeout("fade('" + pntid + "', " + exe_cnt + ", " + b + ", " + c + ");", 5);
                }
                else {
                    document.getElementById(pntid).filters.alpha.opacity = 100;
                    return;
                }
            }

            function start_fade(id) {
                ext = true;
                fade(id, 0, 1, true);
            }

            function grdLst_ClientCellClick(item, td, cellIndex, data, tr, rowIndex, e) {
                var unitStore = #{stoPlantUnits};
                
                var recordKey = "";
                var record = "";
                var unitcode = "";

               
                // 설비1
                recordKey = data.data.SMSYSTEMCODE1;
                if (recordKey) {
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        unitcode = record.data.UNITCODE;
                        setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                    }
                }
                // 설비2
                recordKey = data.data.SMSYSTEMCODE2;
                if (recordKey) {
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        unitcode = record.data.UNITCODE;
                        setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                    }
                }

                 // 설비3
                recordKey = data.data.SMSYSTEMCODE3;
                if (recordKey) {
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        unitcode = record.data.UNITCODE;
                        setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                    }
                }

                 // 설비4
                recordKey = data.data.SMSYSTEMCODE4;
                if (recordKey) {
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        unitcode = record.data.UNITCODE;
                        setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                    }
                }
                
                // 설비5
                recordKey = data.data.SMSYSTEMCODE5;
                if (recordKey) {
                    //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                    record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                    if (record) {
                        unitcode = record.data.UNITCODE;
                        setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                    }
                }

                // 연관설비1
                for (var i=1; i<=5; i++) {
                    recordKey = data.data["SMCONNCODE" + i + "1"];
                    if (recordKey) {
                         //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                         record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                         if (record) {
                            unitcode = record.data.UNITCODE;
                            setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                        }
                    }
                    recordKey = data.data["SMCONNCODE" + i + "2"];
                    if (recordKey) {
                        //record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 6))
                        record = unitStore.findRecord("UNITCODE", recordKey.substr(0, 7))
                        if (record) {
                            unitcode = record.data.UNITCODE;
                            setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                        }
                    }
                }

                // 주변지역
                for (var i=1; i<=5; i++) {
                    recordKey = data.data["SMAREACODE" + i];
                    if (recordKey) {
                        record = unitStore.findRecord("UNITCODE", recordKey)
                        if (record) {
                            unitcode = record.data.UNITCODE;
                            setTimeout("start_fade('" + unitcode + "_" + document.getElementById("unit_" + unitcode).className.substring(8) + "');", 20);
                        }
                    }
                }                
            }

           //////////////////////////////////////////////////////////////////////////////////////////////////////////////
            function OpenUnitInfoWinReload(recordKey) {
                var sto = #{stoPlantUnits};
                var record = sto.findRecord("UNITCODE", recordKey);
                var form = #{fmUnitInfos};
                if (record) {
                    if (record.data.UNITSTATUS == "01") return;
                    document.getElementById("winUnitInfos").style.display = "";
                    #{fsUnitInfos}.updateLayout(false, false);
                    var rObj = document.getElementById("unit_" + recordKey);
                    var x = 1650 / 2;
                    var y = 756 / 2;
                    var sx = 0;
                    var sy = 0;
                    if (record.data.UNITWINDOW != "Main") {
                        var sWin = document.getElementById("winMonitor" + record.data.UNITWINDOW);
                        sx = sWin.offsetLeft;
                        sy = sWin.offsetTop + 30;
                    }
                    var cx = rObj.offsetLeft + parseInt(rObj.offsetWidth / 2, 10);
                    var cy = rObj.offsetTop + parseInt(rObj.offsetHeight / 2, 10);
                    var px = 0;
                    var py = 0;

                    if ((sx + cx) < x) {
                        px = rObj.offsetLeft + sx + rObj.offsetWidth + 10;
                    } else {
                        px = rObj.offsetLeft + sx - document.getElementById("winUnitInfos").offsetWidth - 10;
                    }

                    if ((sy + cy) < y) {
                        py = rObj.offsetTop + sy - 10;
                    } else {
                        py = rObj.offsetTop + sy - 10;
                        if (((y * 2) - py) < document.getElementById("winUnitInfos").offsetHeight) {
                            py = py - document.getElementById("winUnitInfos").offsetHeight + ((y * 2) - py);
                        }
                    }

                    document.getElementById("winUnitInfos").style.left = px + "px";
                    document.getElementById("winUnitInfos").style.top = py + "px";
                    form.loadRecord(record);
                }
            }


           function SetWorkUnitGroup(recordkey){
               
                var record = "";
                var recordConKey = "";
                var recordConKeyname = "";
                var tS = "01";

                var workStore = #{stoWorkingList};

                var count = workStore.getCount();
                var data = null;

                #{stoWorkUnitGroup}.removeAll();

                for (var i = 0; i < count; i++) {
                    data = workStore.getAt(i).data;
                    if( recordkey.substring(1,2) != 8 && recordkey.substring(1,2) != 9 )
                    {
                        //설비코드1
                        if( data.SMSYSTEMCODE1.substr(0,6) == recordkey.substr(0,6) )
                        {          
                            tS = UP_Get_DSPCOLOR(data.DSPCOLOR);
                            UP_Set_StoreAdd(#{stoWorkUnitGroup},recordkey,data.SMSYSTEMCODE1,data.SMSYSTEMCODE1NM,data,tS);
                        }             
                        //설비코드2
                        if( data.SMSYSTEMCODE2.substr(0,6) == recordkey.substr(0,6) )
                        {          
                            tS = UP_Get_DSPCOLOR(data.DSPCOLOR);
                            UP_Set_StoreAdd(#{stoWorkUnitGroup},recordkey,data.SMSYSTEMCODE2,data.SMSYSTEMCODE2NM,data,tS);
                        }
                        //설비코드3
                        if( data.SMSYSTEMCODE3.substr(0,6) == recordkey.substr(0,6) )
                        {          
                            tS = UP_Get_DSPCOLOR(data.DSPCOLOR);
                            UP_Set_StoreAdd(#{stoWorkUnitGroup},recordkey,data.SMSYSTEMCODE3,data.SMSYSTEMCODE3NM,data,tS);
                        }
                        //설비코드4
                        if( data.SMSYSTEMCODE4.substr(0,6) == recordkey.substr(0,6) )
                        {          
                            tS = UP_Get_DSPCOLOR(data.DSPCOLOR);
                            UP_Set_StoreAdd(#{stoWorkUnitGroup},recordkey,data.SMSYSTEMCODE4,data.SMSYSTEMCODE4NM,data,tS);
                        }
                        //설비코드5
                        if( data.SMSYSTEMCODE5.substr(0,6) == recordkey.substr(0,6) )
                        {          
                            tS = UP_Get_DSPCOLOR(data.DSPCOLOR);
                            UP_Set_StoreAdd(#{stoWorkUnitGroup},recordkey,data.SMSYSTEMCODE5,data.SMSYSTEMCODE5NM,data,tS);
                        }                     
                    }
                    else
                    {
                        //주변지역                    
                        for (var k=1; k<=5; k++) {
                            recordConKey = data["SMAREACODE" + k];
                            recordConKeyname = data["SMAREACODE" + k+"NM"];
                            if (recordConKey) {
                               if( recordConKey == recordkey ){
                                  tS = UP_Get_DSPCOLOR(data.DSPCOLOR);
                                  UP_Set_StoreAdd(#{stoWorkUnitGroup},recordConKey,recordConKey, recordConKeyname, data,tS);
                                }
                            }
                        }       
                    }                                           
                }                                           

                if( #{stoWorkUnitGroup}.data.items.length <= 1 ){
                    #{btnPrevious}.hide();
                    #{btnNext}.hide();
                }
                else
                {

                   var iNowindex;
                   var stoTotalCnt;
                   
                   var wkunitsto = #{stoWorkUnitGroup};                   
                   var record = #{stoPlantUnits}.findRecord("UNITCODE", recordkey);
                   var systemcode  = record.data.UNITCODEDETAIL; //설비코드값 
                   var systemponum = record.data.PONUM; //요청번호
                   var systemdate  = record.data.SMWKORAPPDATE; //허가일자
                   var systemseq   = record.data.SMWKORSEQ; //허가번호
                   var datas = wkunitsto.data.items;
                   stoTotalCnt = datas.length;
                   for (var i = 0 ; i < datas.length; i++) {                    
                       //현재 위치
                       if( datas[i].data.DSUNITCODEDETAIL == systemcode &&
                           (datas[i].data.DSPONUM == systemponum &&
                           datas[i].data.DSSMWKORAPPDATE == systemdate &&
                           datas[i].data.DSSMWKORSEQ == systemseq)  )
                           {
                               iNowindex = i;
                           }
                   }

                   //버튼 상태 처리
                   //이전버튼
                   #{btnPrevious}.show();
                   if( iNowindex <= 0 ) { #{btnPrevious}.hide(); }
                   
                   //이후버튼 
                   #{btnNext}.show();
                   if( iNowindex == stoTotalCnt - 1 ){
                      #{btnNext}.hide();
                   }
                }

            }

            function SetWorkDetailDisPlay(fsUnitInfos, value){
               var iRowindex;
               var iNowindex;
               var wData = null;
               var uData= null;
               var tS = "01";
               var stoTotalCnt;

               var wkunitsto = #{stoWorkUnitGroup};
               
               var systemcode  = fsUnitInfos.items.items[0].items.items[0].value; //설비코드값(소분류기준)  
               var systemponum = fsUnitInfos.items.items[5].items.items[0].value; //요청번호
               var systemdate  = fsUnitInfos.items.items[5].items.items[1].value; //허가일자
               var systemseq   = fsUnitInfos.items.items[5].items.items[2].value; //허가번호

               var datas = wkunitsto.data.items;
               stoTotalCnt = datas.length;

               for (var i = 0 ; i < datas.length; i++) {                    
                   //현재 위치
                   if( datas[i].data.DSUNITCODEDETAIL == systemcode &&
                       (datas[i].data.DSPONUM == systemponum &&
                       datas[i].data.DSSMWKORAPPDATE == systemdate &&
                       datas[i].data.DSSMWKORSEQ == systemseq)  )
                       {
                           iNowindex = i;
                       }
               }

               if( value == "1" ) //이전버튼
               {
                   iRowindex = iNowindex - 1;
                   if( iRowindex < 0 ) { iRowindex = 0; }                    
               }
               else //다음버튼
               {
                   iRowindex = iNowindex + 1;
                   if( iRowindex > stoTotalCnt - 1 ) { iRowindex = stoTotalCnt - 1; }
               }

               wData = wkunitsto.getAt(iRowindex).data;

               //최종설비 정보에 update
               uData = #{stoPlantUnits}.findRecord("UNITCODE", systemcode.substr(0,6));
               if( uData != null )
               {                   
                        uData.data.UNITSTATUS = wData.DSUNITSTATUS;
                        uData.data.UNITCODEDETAIL = wData.DSUNITCODEDETAIL;
                        uData.data.UNITDESCDETAIL = wData.DSUNITDESCDETAIL;
                        uData.data.SMMETHODCODENM = wData.DSSMMETHODCODENM;
                        uData.data.SMAREATEXT1 = wData.DSSMAREATEXT1;
                        uData.data.SMWKMETHODNM = wData.DSSMWKMETHODNM;
                        uData.data.SMREVTEAMNM = wData.DSSMREVTEAMNM;
                        uData.data.SMRESSABUNNM = wData.DSSMRESSABUNNM;
                        uData.data.PONUM = wData.DSPONUM;
                        uData.data.SMWKORAPPDATE = wData.DSSMWKORAPPDATE;
                        uData.data.SMWKORSEQ = wData.DSSMWKORSEQ;

                        OpenUnitInfoWinReload(systemcode.substr(0,6)+"000");
                }
                
                //이전 버튼 처리
                #{btnPrevious}.show();
                if( iRowindex == 0 ){
                   #{btnPrevious}.hide();
                }
                #{btnNext}.show();
                if( iRowindex == stoTotalCnt - 1 ){
                   #{btnNext}.hide();
                }
            }

            function UP_Get_DSPCOLOR(value){

              var  tS = "01";       
              if (value == "1") tS = "02";
              else if (value == "2") tS = "03";
              else if (value == "3") tS = "04";

              return tS;
            }

            function UP_Set_StoreAdd(store,recordkey,recordkeydetail,recordkeyname, data,tS){
                store.add({
                                        DSUNITSAUP: "S",
                                        DSUNITCODE: recordkey,
                                        DSUNITDESC: data.SMSYSTEMCODE2NM,
                                        DSUNITSTATUS: tS,
                                        DSUNITCODEDETAIL: recordkeydetail,
                                        DSUNITDESCDETAIL: recordkeyname,
                                        DSSMMETHODCODENM: data.SMMETHODCODENM,
                                        DSSMAREATEXT1: data.SMAREATEXT1,
                                        DSSMWKMETHODNM: data.SMWKMETHODNM,
                                        DSSMREVTEAMNM: data.SMREVTEAMNM,
                                        DSSMRESSABUNNM: data.SMRESSABUNNM,
                                        DSPONUM: data.PONUM,
                                        DSSMWKORAPPDATE: data.SMWKORAPPDATE,
                                        DSSMWKORSEQ: data.SMWKORSEQ
                });
            }

            
             //선박입항현황 
            function setShipList(shipStore, unitStore) {                
                
                var recordKey = "";
                var record = "";
                var datas = null;

                var shipListid = "";
                var shipListTargetid = "";

                var shipSHIPCOMECheck = "";
                var shipSHIPSCHED = "";                  
                
                document.getElementById("S70001001_01").style.display = "none";
                document.getElementById("S70001001_02").style.display = "none";                
                document.getElementById("winunitship_Now").style.display = "none";
                document.getElementById("winunitship_Target").style.display = "none";
                            

                // 가져온 설비작업에 따라 설비상태 설정
                var data = null;                
                    
                    datas = shipStore;

                    if( datas != null ){
                        for( j = 0; j < datas.data.items.length; j++){
                            
                            data = datas.data.items[j];

                            recordKey = data.data.PIERUNITCODE;

                             shipListid = "winunitship_Now"; 
                             shipListTargetid = "winunitship_Target";
                          
                            if (recordKey) {
                                record = unitStore.findRecord("UNITCODE", recordKey)
                                if (record) {
                                   //현재 입항
                                   if( data.data.SHIPCOME == "Y"){   
                                      document.getElementById(recordKey+"_01").style.display = "block";
                                      setShipunitName(shipListid, data.data.IHJUBDAT, data.data.SHHANGCHANM);

                                      shipSHIPCOMECheck = "Y";
                                   }
                                   //출항 
                                   if( data.data.SHIPSAIL == "Y"){   
                                      document.getElementById(recordKey+"_01").style.display = "none";
                                   }              
                                   //예정                    
                                   if( data.data.SHIPSCHED == "Y"){   
                                      shipSHIPSCHED = "";
                                      //입합선박 이미지 있으면 입항예정 이미지는 뺀다.
                                      if( shipSHIPCOMECheck != "Y")
                                      {
                                         shipSHIPSCHED = "Y";
                                      }
                                      if( shipSHIPSCHED == "Y" )
                                      {
                                         document.getElementById(recordKey+"_02").style.display = "block";
                                         setShipunitName(shipListTargetid,data.data.IHJUBDAT, data.data.SHHANGCHANM);
                                      }
                                      else
                                      {
                                         setShipunitName(shipListTargetid,data.data.IHJUBDAT, data.data.SHHANGCHANM);
                                      }
                                      break;
                                   }  
                                }
                            }//if (recordKey) ..end
                        }                        
                        
                    }                
            }

            // 선박 이름 표현
            function setShipunitName(id, ipdate, shipname) {
              var left;
              var top;
              var color;
               
               if( id == "winunitship_Now" )
               {
                   left = "220px";
                   top  = "-28px";
                   color = "red";
               }
               if( id == "winunitship_Target" )
               {
                   left = "220px";
                   top  = "-5px";
                   color = "blue";
               } 
               
               var sDate = ipdate.substring(4,6) + "." + ipdate.substring(6,8);
                             
               document.getElementById(id).style.display = "block";
               document.getElementById(id).innerHTML = "<table style=\"width:200px;position:relative; left:"+left+"; top:"+top+" \"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:"+color+"; font-weight: bold;font-size:12px; \">"+sDate +":"+ shipname+"</a></td></tr></table>";
            }

           function Get_FormatDateTime(value, check){
               if( check == 1 ){
                 if (value.length == 8) {
                        var yyyy = value.substring(0, 4);
                        var mm = value.substring(4, 6);
                        var dd = value.substring(6, 8);

                        var date = yyyy + "." + mm + "." + dd;                        

                        return date;
                 }
                 else
                 {
                    return "";
                 }
               }
               else
               {
                 if (value.length == 4 && value != "" && value != "0000") {
                        var hh = value.substring(0, 2);
                        var mm = value.substring(2, 4);

                        var datetime = hh + ":" + mm;

                        return datetime;
                 }
                 else
                 {
                    return "";
                 }
               }
            }

            function DateMove(value){
               Ext.net.DirectMethod.request('UP_DateMove', {
                    url: location.href,
                    params: { sDate:Ext.util.Format.date(#{dtpETADate}.getValue(), 'Y-m-d'),
                              sGubn:value  },
                    eventMask: {
                            showMask: true,
                            msg: "선박스케줄을 조회중입니다...",
                            target: "customtarget",
                            customTarget: #{grdShip}
                        }
                }
                );
           }

           function fontColor(value,record){
              if( record.data.SHIPCOME == "Y" )
              {               
                  return "<span style=\"color:red;\">" + value + "</span>";                
              }
              else if( record.data.SHIPSCHED == "Y" )
              {
                  return "<span style=\"color:blue;\">" + value + "</span>";
              }
              else
              {
                  return value;
              }
           }
           //////////////////////////////////////////////////////////////////////////
        </script>
    </ext:XScript>

</asp:Content>


<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <ext:TaskManager ID="TaskManager1" runat="server">
        <Tasks>
            <ext:Task 
                TaskID="servertime"
                Interval="3000000">
                <DirectEvents>
                    <Update OnEvent="UpdateMonitoringData"></Update>
                </DirectEvents>                    
            </ext:Task>
        </Tasks>
    </ext:TaskManager>
    <ext:Store ID="stoWorkUnitGroup" runat="server">
        <Model>
            <ext:Model runat="server">
                <Fields>
                    <ext:ModelField Name="DSUNITSAUP"        Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSUNITCODE"      Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSUNITDESC"      Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSUNITSTATUS"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSUNITCODEDETAIL"      Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSUNITDESCDETAIL"      Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSSMMETHODCODENM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSSMAREATEXT1"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSSMWKMETHODNM"  Type="String"></ext:ModelField>                    
                    <ext:ModelField Name="DSSMREVTEAMNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSSMRESSABUNNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSPONUM"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSSMWKORAPPDATE" Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSSMWKORSEQ"    Type="String"></ext:ModelField>
                </Fields>
            </ext:Model>
        </Model>
    </ext:Store>
    <ext:Store ID="stoPlantUnits" runat="server">
        <Model>
            <ext:Model ID="Model1" runat="server">
                <Fields>
                    <ext:ModelField Name="C2SAUP"       Mapping="C2SAUP"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="UNITCODE"     Mapping="C2KEYCODE" Type="String"></ext:ModelField>
                    <ext:ModelField Name="UNITDESC"     Mapping="C2NAME"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="UNITWINDOW"   Mapping="C2SCGUBN"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="UNITPOINTX"   Mapping="C2XPOINT"  Type="Int"></ext:ModelField>
                    <ext:ModelField Name="UNITPOINTY"   Mapping="C2YPOINT"  Type="Int"></ext:ModelField>
                    <ext:ModelField Name="UNITTYPE"     Mapping="C2DSGUBN"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="UNITSTATUS"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="UNITCODEDETAIL"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="UNITDESCDETAIL"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMMETHODCODENM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREATEXT1"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMWKMETHODNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMREVTEAMNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMRESSABUNNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="PONUM"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMWKORAPPDATE" Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMWKORSEQ"    Type="String"></ext:ModelField>
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="getTestData(#{stoPlantUnits});"></Load>
            <DataChanged Handler="drowUnits(#{stoPlantUnits});"></DataChanged>
        </Listeners>
    </ext:Store>
    <ext:Store ID="stoWorkingList" runat="server">
        <Model>
            <ext:Model ID="Model2" runat="server">
                <Fields>
                    <ext:ModelField Name="PONUM"    Type="String"></ext:ModelField>
                    <%--<ext:ModelField Name="SMWKORAPPDATE" Type="Date" DateFormat="yyyyMMdd"></ext:ModelField>--%>
                    <ext:ModelField Name="SMWKORAPPDATE" Type="String" ></ext:ModelField>
                    <ext:ModelField Name="SMWKORSEQ"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREATEXT1"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMREVTEAM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMREVTEAMNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMMETHODCODENM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMWKMETHOD"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMWKMETHODNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMRESSABUN"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMRESSABUNNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE1"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE1NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE2"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE2NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE3"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE3NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE4"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE4NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE5"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMSYSTEMCODE5NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE11"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE11NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE12"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE12NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE21"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE21NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE22"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE22NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE31"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE31NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE32"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE32NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE41"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE41NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE42"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE42NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE51"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE51NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE52"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMCONNCODE52NM"  Type="String"></ext:ModelField>

                    <ext:ModelField Name="SMAREACODE1"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE1NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE2"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE2NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE3"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE3NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE4"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE4NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE5"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SMAREACODE5NM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="DSPCOLOR"  Type="String"></ext:ModelField>
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="getTestData_1(#{stoWorkingList});"></Load>
            <DataChanged Handler="setWorkingList(#{stoWorkingList},#{stoPlantUnits});"></DataChanged>
        </Listeners>
    </ext:Store>

    <ext:Store ID="stoShipList" runat="server">
        <Model>
            <ext:Model runat="server">
                <Fields>
                    <ext:ModelField Name="SHDATE"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHCOMPANY"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="PIERUNITCODE"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHHANGCHA"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHHANGCHANM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHSOSOK"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHSOSOKNM"  Type="String"></ext:ModelField>                    
                    <ext:ModelField Name="SHGOKJONG"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHGOKJONGNM"  Type="String"></ext:ModelField>                    
                    <ext:ModelField Name="SHWONSAN"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHWONSANNM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHAGENT"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHAGENTNM"  Type="String"></ext:ModelField>

                    <ext:ModelField Name="SHETABUSAN"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHBUSANQTY"  Type="Float"></ext:ModelField>
                    <ext:ModelField Name="SHETAINCHE"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHINCHEQTY"  Type="Float"></ext:ModelField>

                    <ext:ModelField Name="SHETCD"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHREMARK"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="IHJUBDAT"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="IHJUBTIM"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="IHIANDAT"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="IHIANTIM"  Type="String"></ext:ModelField>                                        
                    <ext:ModelField Name="SHIPCOME"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHIPSAIL"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHIPSCHED"  Type="String"></ext:ModelField>
                    <ext:ModelField Name="SHULSANQTY"  Type="Float"></ext:ModelField>
                    <ext:ModelField Name="SHTOTALQTY"  Type="Float"></ext:ModelField>
                    <ext:ModelField Name="SHMONTHQTY"  Type="Float"></ext:ModelField>
                    <ext:ModelField Name="SHANNUALQTY"  Type="Float"></ext:ModelField>
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <DataChanged Handler="setShipList(#{stoShipList},#{stoPlantUnits});"></DataChanged>
        </Listeners>
    </ext:Store>

     <ext:Store ID="stoAmountQty" runat="server">
        <Model>
            <ext:Model runat="server">
                <Fields>
                    <ext:ModelField Name="AMGUBN"    Type="String"></ext:ModelField>
                    <ext:ModelField Name="AMPLANQTY"    Type="Float"></ext:ModelField>
                    <ext:ModelField Name="AMRESULTQTY"  Type="Float"></ext:ModelField>
                    <ext:ModelField Name="AMACHRATE"    Type="Float"></ext:ModelField>
                </Fields>
            </ext:Model>
        </Model>
    </ext:Store>

    <div style="padding:3px;height:800px;">
    <%--<ext:Viewport ID="vptMain" runat="server" Layout="BorderLayout">
        <Items>--%>
            <ext:Panel ID="pnlMain" runat="server" Region="Center" Border="true">
                <Listeners>
                    <Resize Handler="MonitorBodyResize('Main');"></Resize>
                </Listeners>
                <%--<TopBar>
                    <ext:Toolbar ID="Toolbar1" runat="server" Flat="true">
                        <Items>
                            <ext:Button ID="Button1" runat="server" Text="갱신" OnDirectClick="UpdateMonitoringData"></ext:Button>
                        </Items>
                    </ext:Toolbar>
                </TopBar>--%>
                <Content>
                    <div style="height:100%;width:100%; background-image:url('/Resources/Images/SILO/SILO_full_bg.gif'); background-repeat:no-repeat;">
                        <div id="MonitorMain" style="height:756px; width:1650px; position:relative; /*border:2px dotted #666666;*/ background-image:url('/Resources/Images/SILO/SILO_bg.gif'); background-repeat:no-repeat;">

                            <!-- 체인 컴베어 표시화면 -->
                            <div id="winMonitorSub1" class="MonitorSubWin" style="left:510px; top:0px; width:641px; height:240px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">CHAIN CONVEYOR</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub1');">×</a></div>
                                </div>
                                <div id="MonitorSub1" class="mswBody" style="height:200px;">
                                    <div style="height:70px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:70px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:70px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:100px; width:200px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                    <div style="height:100px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:100px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                </div>
                            </div>
                        
                            <!-- 체인 컴베어 표시화면 -->
                            <div id="winMonitorSub2" class="MonitorSubWin" style="left:510px; top:300px; width:221px; height:210px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">CHAIN CONVEYOR</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub2');">×</a></div>
                                </div>
                                <div id="MonitorSub2" class="mswBody" style="height:170px;">
                                    <div style="height:40px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:100px; width:200px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!--// //-->
                            <div class="MonitorSubWin" style="position:absolute; left:1110px; top:0px; width:540px; height:210px; z-index:99;">
                                <div class="mswHeader">
                                    <div class="mswTitle">작업현황</div>
                                </div>
                                <ext:GridPanel ID="GridPanel1" runat="server" Icon="Application" Title="작업현황" Height="180" Frame="true" StoreID="stoWorkingList" Padding="10" Header="false">
                                    <ColumnModel ID="ColumnModel1" runat="server">
                                        <Columns>
                                            <ext:Column ID="fullName" runat="server" Text="요청번호" Width="130" DataIndex="PONUM" Align="Center">
                                                <%--<Renderer Fn="fullName" />--%>
                                            </ext:Column>
                                            <%--<ext:DateColumn ID="DateColumn1" runat="server" DataIndex="SMWKORAPPDATE" Text="허가일자" Width="70" Align="Center" Format="yyyy-MM-dd" />--%>
                                            <ext:Column ID="Column2" runat="server" DataIndex="SMWKORAPPDATE" Text="허가일자" Width="70" Align="Center" />
                                            <ext:Column ID="Column1" runat="server" DataIndex="SMWKORSEQ" Text="순번" Width="30" Align="Center" />
                                            <ext:Column ID="Column3" runat="server" DataIndex="SMAREATEXT1" Text="작업내용" Width="150" Align="Left" Flex="1" />
                                            <ext:Column ID="Column4" runat="server" DataIndex="SMREVTEAMNM" Text="작업부서" Width="60" Align="Center" />
                                            <ext:Column ID="Column5" runat="server" DataIndex="SMMETHODCODENM" Text="작업구분" Width="80" Align="Center" />
                                        </Columns>
                                    </ColumnModel>
                                    <View>
                                        <ext:GridView ID="GridView1" runat="server">
                                            <GetRowClass Handler="return 'x-grid-row-expanded';" />
                                        </ext:GridView>        
                                    </View>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Single" />
                                    </SelectionModel>
                                    <Listeners>
                                        <CellClick Handler="grdLst_ClientCellClick(item, td, cellIndex, record, tr, rowIndex, e);"></CellClick>
                                    </Listeners>
                                </ext:GridPanel>
                            </div>
                            
                            <div id="winUnitInfos" class="MonitorSubWin" style="position:absolute; top:0px; left:0px; z-index:9999; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">설비작업 정보</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winUnitInfos');">×</a></div>
                                </div>
                                <ext:FormPanel ID="fmUnitInfos" runat="server" Title="설비작업 정보" Height="212" Width="460" BodyPadding="5" Header="false">
                                    <FieldDefaults LabelAlign="right" LabelWidth="60" LabelStyle="font-weight:bold;color:#666666;"></FieldDefaults>
                                    <TopBar>
                                       <ext:Toolbar runat ="server">
                                            <Items>
                                                 <ext:Button ID="btnPrevious" runat="server" Icon="ResultsetPrevious" Text="이전">
                                                   <Listeners>
                                                       <Click Handler = "SetWorkDetailDisPlay(#{fsUnitInfos}, 1);" ></Click>
                                                   </Listeners>
                                                 </ext:Button>
                                                 <ext:ToolbarFill runat="server"></ext:ToolbarFill>
                                                 <ext:Button ID="btnNext" runat="server" Icon="ResultsetNext" Text="다음">
                                                   <Listeners>
                                                       <Click Handler = "SetWorkDetailDisPlay(#{fsUnitInfos}, 2);" ></Click>
                                                   </Listeners>
                                                 </ext:Button>                                                
                                            </Items>
                                       </ext:Toolbar>
                                    </TopBar>
                                    <Items>
                                        <ext:FieldSet ID="fsUnitInfos" runat="server" Title="" Padding="5">
                                            <Items>
                                               <%-- <ext:FieldContainer ID="FieldContainer3" runat="server" Layout="HBoxLayout">
                                                    <Items>
                                                         <ext:TextField ID="txtUNITCODE" runat="server" FieldLabel="설비코드" Name="UNITCODE" ReadOnly="true" Width="150"  />
                                                         <ext:TextField ID="TextField10" runat="server" FieldLabel="설비명" Name="UNITDESC" ReadOnly="false" Width="285" />
                                                    </Items>
                                                </ext:FieldContainer>--%>
                                                <ext:FieldContainer ID="FieldContainer4" runat="server" Layout="HBoxLayout">
                                                    <Items>
                                                         <ext:TextField ID="TextField1" runat="server" FieldLabel="설비코드" Name="UNITCODEDETAIL" ReadOnly="true" Width="150"  />
                                                         <ext:TextField ID="TextField11" runat="server" FieldLabel="설비명" Name="UNITDESCDETAIL" ReadOnly="false" Width="285" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:TextField ID="TextField2" runat="server" FieldLabel="작업구분" Name="SMMETHODCODENM" ReadOnly="true" Width="435" />
                                                <ext:TextField ID="TextField3" runat="server" FieldLabel="작업내용" Name="SMAREATEXT1" ReadOnly="true" Width="435" />
                                                <ext:TextField ID="TextField5" runat="server" FieldLabel="작업방법" Name="SMWKMETHODNM" ReadOnly="true" Width="435" />
                                                <ext:FieldContainer ID="FieldContainer1" runat="server" Layout="HBoxLayout">
                                                    <Items>
                                                        <ext:TextField ID="TextField4" runat="server" FieldLabel="작업부서" Name="SMREVTEAMNM" ReadOnly="true" Width="235" />
                                                        <ext:TextField ID="TextField6" runat="server" FieldLabel="작업자" Name="SMRESSABUNNM" ReadOnly="true" Width="200" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:FieldContainer ID="FieldContainer2" runat="server" Layout="HBoxLayout">
                                                    <Items>
                                                        <ext:TextField ID="TextField7" runat="server" FieldLabel="요청번호" Name="PONUM" ReadOnly="true" Width="205" />
                                                        <%--<ext:DateField ID="DateField1" runat="server" FieldLabel="허가일자" Name="SMWKORAPPDATE" ReadOnly="true" Width="135" LabelWidth="60" Format="yyyy-MM-dd" />--%>
                                                        <ext:TextField ID="TextField8" runat="server" FieldLabel="허가일자" Name="SMWKORAPPDATE" ReadOnly="true" Width="135" LabelWidth="60" />
                                                        <ext:TextField ID="TextField9" runat="server" FieldLabel="허가순번" Name="SMWKORSEQ" ReadOnly="true" Width="95" LabelWidth="60" />
                                                    </Items>
                                                </ext:FieldContainer>
                                            </Items>
                                        </ext:FieldSet>
                                    </Items>
                                </ext:FormPanel>
                            </div>

                            <div id = "winShipInofs" class="MonitorSubWin" style="top:90px; left:60px; ">
                                <div class="mswHeader">
                                    <div class="mswTitle">선박입항 현황</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winShipInofs');">×</a></div>
                                </div>
                                    <ext:Panel ID="pnlSearch" runat="server" Width = "1460"  Height="500">                                  
                                       <Items>
                                         <ext:GridPanel ID="grdShip" runat="server" Width = "1460"  Height="300" Frame="true" StoreID="stoShipList" Padding="5" >
                                         <TopBar>
                                               <ext:Toolbar ID="Toolbar1"  runat ="server">
                                                    <Items>                                                         
                                                          <ext:Panel ID="Panel1" runat="server" Layout="HBoxLayout"   Border="false" Margin="5">
                                                            <LayoutConfig>
                                                                <ext:HBoxLayoutConfig Align="Middle"></ext:HBoxLayoutConfig>
                                                            </LayoutConfig>
                                                            <Items> 
                                                                  <%--<ext:ToolbarSpacer runat="server" Width="600"></ext:ToolbarSpacer>--%>
                                                                  <ext:Button ID="Button1" runat="server" Icon="ResultsetPrevious" >
                                                                   <Listeners>
                                                                       <Click Handler = "DateMove(1);" ></Click>
                                                                   </Listeners>
                                                                 </ext:Button>
                                                                 <ext:DateField ID="dtpETADate" runat="server" Format="yyyy-MM" Width="80" ReadOnly = "true" />
                                                                 <ext:Button ID="Button2" runat="server" Icon="ResultsetNext">
                                                                   <Listeners>
                                                                       <Click Handler = "DateMove(2);" ></Click>
                                                                   </Listeners>
                                                                 </ext:Button>                                                                                                                                                                             
                                                            </Items>
                                                        </ext:Panel>                                               
                                                    </Items>
                                               </ext:Toolbar>
                                            </TopBar>       
                                         <ColumnModel>
                                            <Columns>
                                            <ext:Column ID="Column6"   runat="server" DataIndex="SHHANGCHANM" Text="본 선" Width="130" Align="Left" Sortable ="false">
                                                <Renderer Handler = "return fontColor(value, record);"></Renderer>
                                            </ext:Column>
                                            <ext:Column ID="Column7"  runat="server" Text="ETA ULSAN" >
                                                <Columns>
                                                    <ext:Column ID="Column8"   runat="server" DataIndex="IHJUBDAT" Text="접안일자" Width="70"  Align="Left" Sortable ="false">
                                                       <Renderer Handler="return Get_FormatDateTime(value, 1);"></Renderer>
                                                    </ext:Column>                                                    
                                                    <ext:Column ID="Column9"   runat="server" DataIndex="IHJUBTIM" Text="접안시간" Width="60" Align="Center" Sortable ="false">
                                                        <Renderer Handler="return Get_FormatDateTime(value, 2);"></Renderer>
                                                    </ext:Column>
                                                    <ext:NumberColumn ID="NumberColumn1" runat ="server" DataIndex ="SHULSANQTY" Text ="BL수량" Align ="Right" Width ="70" Sortable ="false">
                                                          <Renderer Handler="return FormatNoZero(value, '0,000.000');"></Renderer>
                                                    </ext:NumberColumn>
                                                    <ext:Column ID="Column10"   runat="server" DataIndex="IHIANDAT" Text="이안일자" Width="70" Align="Left" Sortable ="false">
                                                       <Renderer Handler="return Get_FormatDateTime(value, 1);"></Renderer> 
                                                    </ext:Column>
                                                    <ext:Column ID="Column11"  runat="server" DataIndex="IHIANTIM" Text="이안시간" Width="60" Align="Center" Sortable ="false">
                                                        <Renderer Handler="return Get_FormatDateTime(value, 2);"></Renderer>
                                                    </ext:Column>
                                                </Columns>
                                            </ext:Column>
                                            <ext:Column ID="Column12"  runat="server" Text="ETA BUSAN" >
                                                <Columns>
                                                    <ext:Column ID="Column13"   runat="server" DataIndex="SHETABUSAN" Text="입항일자" Width="70"  Align="Left" Sortable ="false">
                                                       <Renderer Handler="return Get_FormatDateTime(value, 1);"></Renderer>
                                                    </ext:Column>                                                    
                                                    <ext:NumberColumn ID="NumberColumn2" runat ="server" DataIndex ="SHBUSANQTY" Text ="BL수량" Align ="Right" Width ="70" Sortable ="false">
                                                          <Renderer Handler="return FormatNoZero(value, '0,000.000');"></Renderer>
                                                    </ext:NumberColumn>
                                                </Columns>
                                            </ext:Column>
                                            <ext:Column ID="Column14"  runat="server" Text="ETA INCHEON" >
                                                <Columns>
                                                    <ext:Column ID="Column15"   runat="server" DataIndex="SHETAINCHE" Text="입항일자" Width="70"  Align="Left" Sortable ="false">
                                                       <Renderer Handler="return Get_FormatDateTime(value, 1);"></Renderer>
                                                    </ext:Column>                                                    
                                                    <ext:NumberColumn ID="NumberColumn3" runat ="server" DataIndex ="SHINCHEQTY" Text ="BL수량" Align ="Right" Width ="70" Sortable ="false">
                                                          <Renderer Handler="return FormatNoZero(value, '0,000.000');"></Renderer>
                                                    </ext:NumberColumn>
                                                </Columns>
                                            </ext:Column>
                                                    <ext:Column ID="Column16"   runat="server" DataIndex="SHSOSOKNM" Text="협회" Width="70" Align="Left" Sortable ="false" />
                                                    <ext:Column ID="Column17"   runat="server" DataIndex="SHGOKJONGNM" Text="곡종" Width="70" Align="Left" Sortable ="false" />
                                                    <ext:Column ID="Column18"   runat="server" DataIndex="SHWONSANNM" Text="원산지" Width="70" Align="Left" Sortable ="false" />
                                                    <ext:Column ID="Column19"   runat="server" DataIndex="SHAGENTNM" Text="대리점" Width="70" Align="Left" Sortable ="false" />
                                                    <ext:NumberColumn ID="NumberColumn4"  runat ="server" DataIndex ="SHTOTALQTY" Text ="Total Qty" Align ="Right" Width ="80" Sortable ="false">
                                                          <Renderer Handler="return FormatNoZero(value, '0,000.000');"></Renderer>
                                                    </ext:NumberColumn>
                                                    <ext:NumberColumn ID="NumberColumn5"  runat ="server" DataIndex ="SHMONTHQTY" Text ="Month Qty" Align ="Right" Width ="100" Sortable ="false">
                                                          <Renderer Handler="return FormatNoZero(value, '0,000.000');"></Renderer>
                                                    </ext:NumberColumn>
                                                    <ext:NumberColumn ID="NumberColumn6"  runat ="server" DataIndex ="SHANNUALQTY" Text ="Annual Qty" Align ="Right" Width ="100" Sortable ="false">
                                                          <Renderer Handler="return FormatNoZero(value, '0,000.000');"></Renderer>
                                                    </ext:NumberColumn>
                                                    <ext:Column ID="Column20" runat="server" DataIndex="SHETCD" Text="ETCD" Width="80" Align="Left" Sortable ="false" />
                                                    <ext:Column ID="Column21" runat="server" DataIndex="SHREMARK" Text="REMARK" Flex="1" Align="Left" Sortable ="false" />
                                            </Columns>
                                        </ColumnModel> 
                                            <View>
                                                <ext:GridView ID="GridView2" runat="server">
                                                    <GetRowClass Handler="return 'x-grid-row-expanded';" />
                                                </ext:GridView>        
                                            </View>
                                            <SelectionModel>
                                                <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" Mode="Single" />
                                            </SelectionModel>
                                        </ext:GridPanel> 
                                      </Items>
                                       <Items>
                                               <ext:GridPanel ID="grdTotalTable" runat="server" Margin = "5"  Width = "360" Title = "작업물량 집계표"  Height="170" Frame="true" StoreID="stoAmountQty" Padding="1" >
                                                 <ColumnModel>
                                                    <Columns>
                                                        <ext:Column ID="Column22"   runat="server" DataIndex="AMGUBN" Text="구분" Width="60" Align="Left" />
                                                        <ext:NumberColumn ID="NumberColumn7"  runat ="server" DataIndex ="AMPLANQTY" Text ="계획" Align ="Right" Width ="80" Sortable ="false">
                                                              <Renderer Handler="return FormatNoZero(value, '0,000');"></Renderer>
                                                        </ext:NumberColumn>
                                                        <ext:NumberColumn ID="NumberColumn8"  runat ="server" DataIndex ="AMRESULTQTY" Text ="실적" Align ="Right" Width ="120" Sortable ="false">
                                                              <Renderer Handler="return FormatNoZero(value, '0,000.000');"></Renderer>
                                                        </ext:NumberColumn>
                                                        <ext:NumberColumn ID="NumberColumn9"  runat ="server" DataIndex ="AMACHRATE" Text ="달성율(%)" Align ="Right" Width ="80" Sortable ="false">
                                                              <Renderer Handler="return FormatNoZero(value, '0,000.00');"></Renderer>
                                                        </ext:NumberColumn>
                                                    </Columns>
                                                </ColumnModel>
                                                </ext:GridPanel>                                       
                                    </Items>
                                    </ext:Panel>

                                      
                            </div>

                        </div>
                    </div>
                </Content>
            </ext:Panel>
       <%-- </Items>
    </ext:Viewport>--%>
    </div>
</asp:Content>
