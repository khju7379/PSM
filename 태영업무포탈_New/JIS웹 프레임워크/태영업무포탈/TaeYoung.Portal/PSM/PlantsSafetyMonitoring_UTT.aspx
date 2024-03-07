<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlantsSafetyMonitoring_UTT.aspx.cs" Inherits="TaeYoung.Portal.PSM.PlantsSafetyMonitoring_UTT" %>

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
            
            #conBody_GridPanel1 *
            {
                font-size : 11px;
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
            
            #conBody_pnlMain_Content 
            {
                height:800px;
            }
            
            .MonitorSubWin {position:absolute; z-index:100;}
            .MonitorSubWin .mswHeader { width:100%; height:30px; background-color:#b13f6b; border-top-left-radius:8px; border-top-right-radius:8px;}
            .MonitorSubWin .mswHeader .mswTitle {color:#FFFFFF;font-size:12pt;padding:5px 15px;}
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
            div.st01 img.st04 
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
            
            
        .tValue
        {
            font-size: 13px;
            font-weight: bold;
            color: red;
        }

        * {
                  margin: 0px; padding: 0px;
	              font-family: NanumGothicBold, 나눔고딕볼드, Dotum, 돋움, Gulim, 굴림, AppleGothic, Sans-serif; font-size: 12px; color: #646464; line-height: 15px;
	              word-break: keep-all;
        }
       
    </style>
    
    <script type="text/javascript">

         function OnLoad() {            

             
            /* 설비코드 표시 */
            UP_GetUnitData();

            /*  선박 표시  */
            UP_GetShipData();          

            /* 작업현황 표시*/
            UP_GetWorkDataBinding();

            var grid = document.getElementById("gridWorkList_layer");        
            grid.classList.add('con_data_03');

            setInterval("GetTimeDataBinding()", 200000);
        }

        function GetTimeDataBinding() {

            /* 설비코드 표시 */
            UP_GetUnitData();

            /*  선박 표시  */
            UP_GetShipData();          

            /* 작업현황 표시*/
            UP_GetWorkDataBinding();

            //alert('갱신');

        }

        function UP_GetWorkDataBinding() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["P_SAUP"] = "T";

            gridWorkList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridWorkList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function UP_GetUnitData() {

            var ht = new Object();
            ht["P_SAUP"] = "T";            

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "GetUnitData", GetUnitData_After);
        }

        function GetUnitData_After(e) {

            try {
                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {                    

                    for (var i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {                      

                        setUnit(DataSet.Tables[0].Rows[i]["C2KEYCODE"],
                            DataSet.Tables[0].Rows[i]["C2NAME"],
                            DataSet.Tables[0].Rows[i]["C2SCGUBN"],
                            DataSet.Tables[0].Rows[i]["C2XPOINT"],
                            DataSet.Tables[0].Rows[i]["C2YPOINT"],
                            DataSet.Tables[0].Rows[i]["C2DSGUBN"],
                            DataSet.Tables[0].Rows[i]["UNITSTATUS"]
                        );
                    }
                }
            }
            catch (err) {
                alert(err.message);
            }
        }        

        // 설비아이템 그리기                
        function setUnit(UNITCODE, UNITDESC, UNITWINDOW, UNITPOINTX, UNITPOINTY, UNITTYPE, UNITSTATUS) {

                // 상태별 개체생성
                if (UNITWINDOW == "") return;
                var div = document.getElementById("unit_" + UNITCODE);
                if (!div) {
                    div = document.createElement("div");
                    div.id = "unit_" + UNITCODE;
                    div.style.position = "absolute";
                    var imgStr = "";
                    var ImgFileName = "";
                    var addStyle = "";
                    if (UNITTYPE == "TANK100" || UNITTYPE == "TANK200" || UNITTYPE == "TANK300" || UNITTYPE == "TANK400" || UNITTYPE == "TANK500") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:0%; top:20%; width:100%; height:60%; padding-bottom:5px;";
                        if (UNITTYPE == "TANK100") {
                            addStyle += " font-size:9px;"
                        }
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC.replace(/T-/g, "") + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC.replace(/T-/g, "") + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "AREA") {
                        //imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\">";
                        //imgStr += "<img src=\"/Resources/Images/UTT/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (UNITTYPE == "PIFE") {
                        //imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\">";
                        //imgStr += "<img src=\"/Resources/Images/UTT/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (UNITTYPE == "PUMP") {
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\">";
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"margin-top:18px;\"><table style=\"width:55px;position:relative; left:-10px;\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\" style=\"color:#000000;\">" + GetMiddleString(UNITDESC, "(", ")") + "</a></td></tr></table></div>";                        
                        imgStr += "<div class=\"unitTitle\" style=\"margin-top:18px;\"><table style=\"width:55px;position:relative; left:-10px;\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:#000000;\">" + GetMiddleString(UNITDESC, "(", ")") + "</a></td></tr></table></div>";                        
                    } else if (UNITTYPE == "SHIP") {
                        imgStr += "<a href=\"javascript:void(0);\""+GetUnitClickFunction(UNITCODE)+ "\">";
                        imgStr += "<img id='" + UNITCODE + "_01'  src=\"/Resources/Images/UTT/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_02'  src=\"/Resources/Images/UTT/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        if( UNITCODE == "T70001001" ) //용잠1부두
                        {
                          imgStr += "<div id = 'winunitship1_Now' class=\"unitTitle\" style=\"margin-top:18px; display:none; \"><table style=\"width:55px;position:relative; left:150px; top:-20px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:red;\">" + UNITDESC + "</a></td></tr></table></div>";
                          imgStr += "<div id = 'winunitship1_Target' class=\"unitTitle\" style=\"margin-top:18px; display:none; \"><table style=\"width:55px;position:relative; left:150px; top:-20px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:red;\">" + UNITDESC + "</a></td></tr></table></div>";
                        }
                        else if( UNITCODE == "T70001002" ) //용잠3부두
                        {
                          imgStr += "<div id = 'winunitship2_Now' class=\"unitTitle\" style=\"margin-top:18px; display:none;\"><table style=\"width:55px;position:relative; left:-100px; top:-20px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";
                          imgStr += "<div id = 'winunitship2_Target' class=\"unitTitle\" style=\"margin-top:18px; display:none;\"><table style=\"width:55px;position:relative; left:-100px; top:-20px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";
                        }
                        else if( UNITCODE == "T70001003" ) //utt부두(돌핀)
                        {
                          imgStr += "<div id = 'winunitship3_Now' class=\"unitTitle\" style=\"margin-top:18px; display:none;\"><table style=\"width:55px;position:relative; left:50px; top:10px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";
                          imgStr += "<div id = 'winunitship3_Target' class=\"unitTitle\" style=\"margin-top:18px; display:none;\"><table style=\"width:55px;position:relative; left:50px; top:10px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";
                        }
                        else if( UNITCODE == "T70001004" ) //용잠4부두
                        {
                          imgStr += "<div id = 'winunitship4_Now' class=\"unitTitle\" style=\"margin-top:18px; display:none;\"><table style=\"width:55px;position:relative; left:-150px; top:-20px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";
                          imgStr += "<div id = 'winunitship4_Target' class=\"unitTitle\" style=\"margin-top:18px; display:none;\"><table style=\"width:55px;position:relative; left:-150px; top:-20px \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";
                        }
                        imgStr += "</a>";
                    } else {
                        //imgStr += "<a href=\"javascript:void(0);\"" + GetUnitClickFunction(UNITCODE) + " onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<a href=\"javascript:void(0);\"" + GetUnitClickFunction(UNITCODE) + " onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\">";
                        //imgStr += "<img src=\"/Resources/Images/UTT/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_01.png\" class=\"st01\" />";
                        //imgStr += "<img src=\"/Resources/Images/UTT/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_02.png\" class=\"st02\" />";
                        //imgStr += "<img src=\"/Resources/Images/UTT/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_03.png\" class=\"st03\" />";
                        //imgStr += "<img src=\"/Resources/Images/UTT/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_04.png\" class=\"st04\" />";

                        ImgFileName = UNITCODE.substr(1, 1) + UNITCODE.substr(3, 4);

                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + ImgFileName + "_01.png\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + ImgFileName + "_02.png\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + ImgFileName + "_03.png\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + ImgFileName + "_04.png\" class=\"st04\" />";

                        //imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_01.png\" class=\"st01\" />";
                        //imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_02.png\" class=\"st02\" />";
                        //imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_03.png\" class=\"st03\" />";
                        //imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_04.png\" class=\"st04\" />";

                        imgStr += "</a>";
                    }
                    div.innerHTML = imgStr;

                    if (UNITTYPE == "AREA") {
                        div.style.zIndex = "10"
                        div.style.left = (UNITPOINTX - 7) + "px";
                        div.style.top = (UNITPOINTY - 6) + "px";
                    } else if (UNITTYPE == "PIFE") {
                        div.style.left = (UNITPOINTX - 2) + "px";
                        div.style.top = (UNITPOINTY - 2) + "px";
                    } else {
                        div.style.left = UNITPOINTX + "px";
                        div.style.top = UNITPOINTY + "px";
                    }
                }               

                if (UNITSTATUS) {
                    div.className = "mUnit st" + UNITSTATUS;
                } else {
                    div.className = "mUnit st01";
                }
                var mBody = document.getElementById("Monitor" + UNITWINDOW);
                mBody.appendChild(div);
        }
        
        
        function OpenUnitInfoWin(recordKey, UNITSTATUS, UNITWINDOW) {


            if (UNITSTATUS == "01") return;

            GetWorkDataRun(recordKey);

            document.getElementById("winUnitInfos").style.display = "";

            var rObj = document.getElementById("unit_" + recordKey);
            var x = 1650 / 2;
            var y = 756 / 2;
            var sx = 0;
            var sy = 0;

            if ( UNITWINDOW != "Main") {
                var sWin = document.getElementById("winMonitor" + UNITWINDOW);
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

        }

        // 특정설비 클릭이벤트 부여
        function GetUnitClickFunction(code) {
                var retStr = "";
                switch (code) {
                    case "T200015000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub1');\"";
                        break;
                    case "T200016000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub2');\"";
                        break;
                    case "T200017000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub3');\"";
                        break;
                    case "T200018000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub4');\"";
                        break;
                    case "T200019000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub5');\"";
                        break;
                    case "T200020000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub6');\"";
                        break;
                    case "T200021000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub7');\"";
                        break;
                    case "T200036000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub8');\"";
                        break;
                    case "T200022000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub9');\"";
                        break;
                    case "T200037000":
                        retStr = " onclick=\"OpenSubWin('winMonitorSub10');\"";
                        break;
                    case "T70001001":
                    case "T70001002":
                    case "T70001003":
                    case "T70001004":
                        retStr = " onclick=\"OpenSubWin('winShipInofs');\"";
                        break;

                }
                return retStr;
        }
        
        //문자열을 구분자 사이에 값을 가져옴
        function GetMiddleString(pStr, pfStr, tStr) {
            var fp = pStr.indexOf(pfStr);
            if (fp < 0) return "";
            fp += pfStr.length;
            var tp = pStr.indexOf(tStr, fp);
            if (tp < 0) return pStr.substr(fp);
            else return pStr.substring(fp, tp);
        }

         function setTransformStyle(obj, attrName, value) {
                var setFlags = ["", "ms", "webkit", "moz", "o"];
                for (var i = 0; i < setFlags.length; i++) {
                    obj.style[setFlags[i] + attrName] = value;
                }
         }

        // 창 화면에 따른 모니터링 화면 크기조정
        function MonitorBodyResize(winName) {            

            var winSize = { Main: { x: 1650, y: 756} };
            var wbody = document.getElementById("Monitor" + winName);
            var factorX = wbody.parentNode.offsetWidth / winSize[winName].x;
            var factorY = wbody.parentNode.offsetHeight / winSize[winName].y;        
            var factor = (factorX < factorY ? factorX : factorY);
            setTransformStyle(wbody, "Transform", "scaleX(" + factor + ") scaleY(" + factor + ")");
            setTransformStyle(wbody, "TransformOrigin", "top left");
            var mbody = document.getElementById("content");
            var fh = winSize[winName].y * factor;
            var m = parseInt((mbody.offsetHeight - fh) / 2, 10);            
            wbody.parentNode.style.paddingTop = m + "px";
        }

         function GetWorkDataRun(recordKey) {

            var ht = new Object();
            ht["P_SAUP"] = "T";
            ht["P_CODE"] = recordKey;

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "GetWorkOrder_Run", function (e) {
                var dataSet = eval(e);                

                if (ObjectCount(dataSet.Tables[0].Rows) > 0) {

                     txtUNITCODEDETAIL.SetValue(dataSet.Tables[0].Rows[0]["SMSYSTEMCODE"].toString());  //설비코드
                     txtUNITDESCDETAIL.SetValue(dataSet.Tables[0].Rows[0]["SMSYSTEMCODENM"].toString());  //설비명
                     txtSMMETHODCODENM.SetValue(dataSet.Tables[0].Rows[0]["SMMETHODCODENM"].toString());  //작업구분
                     txtSMAREATEXT.SetValue(dataSet.Tables[0].Rows[0]["SMAREATEXT1"].toString());     //작업내용
                     txtSMWKMETHODNM.SetValue(dataSet.Tables[0].Rows[0]["SMWKMETHODNM"].toString());  //작업방법

                     txtSMREVTEAMNM.SetValue(dataSet.Tables[0].Rows[0]["SMREVTEAMNM"].toString());   //작업부서
                     txtSMRESSABUNNM.SetValue(dataSet.Tables[0].Rows[0]["SMRESSABUNNM"].toString());   //작업자

                    txtPONUM.SetValue(dataSet.Tables[0].Rows[0]["PONUM"].toString());          //요청번호
                    txtSMWKORAPPDATE.SetValue(dataSet.Tables[0].Rows[0]["SMWKORAPPDATE"].toString() + '-' + dataSet.Tables[0].Rows[0]["SMWKORSEQ"].toString());  //허가번호

                    
                 }
            });
        }      

        function CloseSubWin(id) {
            document.getElementById(id).style.display = "none";
        }

        function OpenSubWin(id) {

            document.getElementById(id).style.display = "";
            if( id == "winShipInofs" ){
                  //#{grdShip}.updateLayout(false, false);
                  //#{grdShip}.getView().focusRow(#{stoShipList}.data.items.length-1);
             }
        }

        function UP_GetShipData() {

            var today = new Date();
            var DayYYMM = today.getFullYear() + CalLpad((today.getMonth() + 1));            

            var ht = new Object();
            ht["P_SHHWDATE"] = DayYYMM;            
            ht["P_KIJUNDATE"] = DayYYMM;

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "GetShipListData_UTT", GetShipData_After);
        }

        function GetShipData_After(e) {

            var recordKey = "";
            var record = "";
            var shipListid = "";
            var shipListTargetid = "";

            var shipSHIPCOMECheck1 = "";
            var shipSHIPCOMECheck2 = "";
            var shipSHIPCOMECheck3 = "";
            var shipSHIPCOMECheck4 = "";

            var shipSHIPSCHED = "";
            var iphangcnt = 0;
            var schedulcnt = 0;

            var DataSet = eval(e);

            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {                

                 //이미지 클리어
                document.getElementById("T70001001_01").style.display = "none";
                document.getElementById("T70001002_01").style.display = "none";
                document.getElementById("T70001003_01").style.display = "none";
                document.getElementById("T70001004_01").style.display = "none";
                document.getElementById("T70001001_02").style.display = "none";
                document.getElementById("T70001002_02").style.display = "none";
                document.getElementById("T70001003_02").style.display = "none";
                document.getElementById("T70001004_02").style.display = "none";
                
                document.getElementById("winunitship1_Now").style.display = "none";
                document.getElementById("winunitship1_Target").style.display = "none";
                document.getElementById("winunitship2_Now").style.display = "none";
                document.getElementById("winunitship2_Target").style.display = "none";
                document.getElementById("winunitship3_Now").style.display = "none";
                document.getElementById("winunitship3_Target").style.display = "none";
                document.getElementById("winunitship4_Now").style.display = "none";
                document.getElementById("winunitship4_Target").style.display = "none";

                for (var i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                    recordKey = DataSet.Tables[0].Rows[i]["PIERUNITCODE"];

                    if( DataSet.Tables[0].Rows[i]["SHPIER"] == "1"){ shipListid = "winunitship1_Now"; shipListTargetid = "winunitship1_Target"; }
                    else if( DataSet.Tables[0].Rows[i]["SHPIER"] == "2"){ shipListid = "winunitship3_Now"; shipListTargetid = "winunitship3_Target"; } 
                    else if( DataSet.Tables[0].Rows[i]["SHPIER"] == "3"){ shipListid = "winunitship2_Now"; shipListTargetid = "winunitship2_Target"; } 
                    else if (DataSet.Tables[0].Rows[i]["SHPIER"] == "4") { shipListid = "winunitship4_Now"; shipListTargetid = "winunitship4_Target"; }                    

                    if (recordKey) {
                        //현재 입항                                   
                        if (DataSet.Tables[0].Rows[i]["SHIPCOME"] == "Y") {
                            
                            document.getElementById(recordKey+"_01").style.display = "block";
                            setShipunitName(shipListid, DataSet.Tables[0].Rows[i]["IPDATE"], DataSet.Tables[0].Rows[i]["SHSHIPNAME"], "1");
                            iphangcnt = 1;
                        }
                        //출항 
                        if (DataSet.Tables[0].Rows[i]["SHIPSAIL"] == "Y") {
                            
                            document.getElementById(recordKey+"_01").style.display = "none";
                            document.getElementById(shipListid).style.display = "none";
                            document.getElementById(shipListTargetid).style.display = "none";
                        }

                        //부두별로 입항선박이 있는지 체크
                        if( DataSet.Tables[0].Rows[i]["SHPIER"] == "1"){ 
                            if( DataSet.Tables[0].Rows[i]["SHIPCOME"] == "Y"){ shipSHIPCOMECheck1 = "Y" }
                        }

                        //입항예정
                        if (DataSet.Tables[0].Rows[i]["SHIPSCHED"] == "Y") {                            

                            schedulcnt = 1;
                            shipSHIPSCHED = "";
                            //입합선박 이미지 있으면 입항예정 이미지는 뺀다.
                            if( data.data.SHPIER == "1" && shipSHIPCOMECheck1 != "Y")
                            {
                                shipSHIPSCHED = "Y";
                            }
                            if( data.data.SHPIER == "2" && shipSHIPCOMECheck2 != "Y")
                            {
                                shipSHIPSCHED = "Y";
                            }
                            if( data.data.SHPIER == "3" && shipSHIPCOMECheck3 != "Y")
                            {
                                shipSHIPSCHED = "Y";
                            }
                            if( data.data.SHPIER == "4" && shipSHIPCOMECheck4 != "Y")
                            {
                                shipSHIPSCHED = "Y";
                            }

                            if( shipSHIPSCHED == "Y" ){
                                 document.getElementById(recordKey+"_02").style.display = "block";
                                 setShipunitName(shipListTargetid, DataSet.Tables[0].Rows[i]["IPDATE"] ,DataSet.Tables[0].Rows[i]["SHSHIPNAME"], "2");
                            }
                            else
                            {
                                 setShipunitName(shipListTargetid, DataSet.Tables[0].Rows[i]["IPDATE"], DataSet.Tables[0].Rows[i]["SHSHIPNAME"], "2");
                            }
                        }

                    }//if (recordKey) ..end
                    if( schedulcnt > 0 && iphangcnt > 0) { break; } 
                }

            }

        }

        // 선박 이름 표현
        function setShipunitName(id, ipdate, shipname, Point) {
              var left;
              var top;
              var color;
               
               if( id == "winunitship1_Now" )
               {
                   left = "150px";
                   top  = "-25px";
                   color = "red";
               }
               if( id == "winunitship1_Target" )
               {
                   left = "150px";
                   top  = "-10px";
                   color = "blue";
               }
               if( id == "winunitship2_Now" )
               {
                   left = "-180px";
                   top  = "-25px";
                   color = "red";
               }
               if( id == "winunitship2_Target" )
               {
                   left = "-180px";
                   top  = "-10px";
                   color = "blue";
               }
               if( id == "winunitship3_Now" )
               {
                   left = "10px";
                   top  = "10px";
                   color = "red";
               }
               if( id == "winunitship3_Target" )
               {
                   left = "10px";
                   top  = "25px";
                   color = "blue";
               }
               if( id == "winunitship4_Now" )
               {
                   left = "20px";
                   top  = "10px";
                   color = "red";
               }
               if( id == "winunitship4_Target" )
               {
                   left = "20px";
                   top  = "25px";
                   color = "blue";
               }                           

               document.getElementById(id).style.display = "block";
               document.getElementById(id).innerHTML = "<table style=\"width:200px;position:relative; left:"+left+"; top:"+top+" \"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:"+color+"; font-weight: bold; font-size:12px; \">"+ipdate +":"+ shipname+"</a></td></tr></table>";
        }

        window.onresize = function() { 

            MonitorBodyResize('Main');

        }

    </script>

</asp:Content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">

  <div id="content" style="height:850px;" >
    <div style="height:100%; background-image:url('/Resources/Images/UTT/UTT_full_bg.gif'); background-repeat:no-repeat; ">
       <div id="MonitorMain" style="height:756px; width:1650px; position:relative; /*border:2px dotted #666666;*/ background-image:url('/Resources/Images/UTT/UTT_bg2.gif'); background-repeat:no-repeat;">
                             <!-- 제 1펌프실 표시화면 -->
                            <div id="winMonitorSub1" class="MonitorSubWin" style="left:890px; top:543px; width:500px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 1펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub1');">×</a></div>
                                </div>
                                <div id="MonitorSub1" class="mswBody" style="height:100px;width:490px;">
                                    <div style="height:80px; width:480px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>
                        
                            <!-- 제 2펌프실 표시화면 -->
                            <div id="winMonitorSub2" class="MonitorSubWin" style="left:557px; top:400px; width:800px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 2펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub2');">×</a></div>
                                </div>
                                <div id="MonitorSub2" class="mswBody" style="height:100px;width:790px;">
                                    <div style="height:80px; width:780px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 3펌프실 표시화면 -->
                            <div id="winMonitorSub3" class="MonitorSubWin" style="left:1020px; top:273px; width:620px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 3펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub3');">×</a></div>
                                </div>
                                <div id="MonitorSub3" class="mswBody" style="height:100px;width:610px; ">
                                    <div style="height:80px; width:600px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 4펌프실 표시화면 -->
                            <div id="winMonitorSub4" class="MonitorSubWin" style="left:557px; top:265px; width:1040px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 4펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub4');">×</a></div>
                                </div>
                                <div id="MonitorSub4" class="mswBody" style="height:100px;width:1030px;">
                                    <div style="height:80px; width:1020px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 5펌프실 표시화면 -->
                            <div id="winMonitorSub5" class="MonitorSubWin" style="left:570px; top:15px; width:410px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 5펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub5');">×</a></div>
                                </div>
                                <div id="MonitorSub5" class="mswBody" style="height:100px;width:400px;">
                                    <div style="height:80px; width:390px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 6펌프실 표시화면 -->
                            <div id="winMonitorSub6" class="MonitorSubWin" style="left:96px; top:295px; width:310px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 6펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub6');">×</a></div>
                                </div>
                                <div id="MonitorSub6" class="mswBody" style="height:100px;width:300px;">
                                    <div style="height:80px; width:290px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 7펌프실 표시화면 -->
                            <div id="winMonitorSub7" class="MonitorSubWin" style="left:1110px; top:91px; width:410px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 7펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub7');">×</a></div>
                                </div>
                                <div id="MonitorSub7" class="mswBody" style="height:75px;width:400px;">
                                    <div style="height:55px; width:390px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 8펌프실 표시화면 -->
                            <div id="winMonitorSub8" class="MonitorSubWin" style="left:755px; top:280px; width:200px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 8펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub8');">×</a></div>
                                </div>
                                <div id="MonitorSub8" class="mswBody" style="height:100px;width:190px;">
                                    <div style="height:80px; width:180px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 9펌프실 표시화면 -->
                            <div id="winMonitorSub9" class="MonitorSubWin" style="top:575px; width:870px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 9펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub9');">×</a></div>
                                </div>
                                <div id="MonitorSub9" class="mswBody" style="height:100px;width:860px;">
                                    <div style="height:80px; width:850px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>

                            <!-- 제 10펌프실 표시화면 -->
                            <div id="winMonitorSub10" class="MonitorSubWin" style="left:1290px; width:270px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">제 10펌프실</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub10');">×</a></div>
                                </div>
                                <div id="MonitorSub10" class="mswBody" style="height:100px;width:260px;">
                                    <div style="height:80px; width:250px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
                                </div>
                            </div>  
           
                            <div id="winUnitInfos" class="MonitorSubWin" style="position:absolute; top:0px; left:0px; z-index:9999; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">설비작업 정보</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winUnitInfos');">×</a></div>
                                </div>                                
                                <Ctl:Layer ID="layer1" runat="server">
		                            <table class="table_04" style="width:100%;" border="0">
                                        <colgroup>
                                            <col style="width:80px;" />
                                            <col style="width:150px;" />
                                            <col style="width:80px;" />
                                            <col style="width:*;" />
                                        </colgroup>
                                    <tr>
                                        <th><Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="설비코드" Required = "true"></Ctl:Text></th>
                                        <td>
                                            <Ctl:TextBox ID="txtUNITCODEDETAIL" runat="server" Width="120px" ></Ctl:TextBox>                                          
                                        </td>
                                        <th><Ctl:Text ID="Text1" runat="server" LangCode="TXT03" Description="설비명" Required = "true"></Ctl:Text></th>
                                        <td>
                                            <Ctl:TextBox ID="txtUNITDESCDETAIL" runat="server" Width="120px" ></Ctl:TextBox>                                          
                                        </td>
                                    </tr>  
                                    <tr>
                                        <th><Ctl:Text ID="Text2" runat="server" LangCode="TXT02" Description="작업구문" Required = "true"></Ctl:Text></th>
                                        <td colspan="3">
                                            <Ctl:TextBox ID="txtSMMETHODCODENM" runat="server" Width="200px" ></Ctl:TextBox>                                          
                                        </td>
                                    </tr>  
                                    <tr>
                                        <th><Ctl:Text ID="Text3" runat="server" LangCode="TXT02" Description="작업내용" Required = "true"></Ctl:Text></th>
                                        <td colspan="3">
                                            <Ctl:TextBox ID="txtSMAREATEXT" runat="server" Width="300px" ></Ctl:TextBox>                                          
                                        </td>
                                    </tr>  
                                    <tr>
                                        <th><Ctl:Text ID="Text4" runat="server" LangCode="TXT02" Description="작업방법" Required = "true"></Ctl:Text></th>
                                        <td colspan="3">
                                            <Ctl:TextBox ID="txtSMWKMETHODNM" runat="server" Width="300px" ></Ctl:TextBox>                                          
                                        </td>
                                    </tr>  
                                    <tr>
                                        <th><Ctl:Text ID="Text5" runat="server" LangCode="TXT02" Description="작업부서" Required = "true"></Ctl:Text></th>
                                        <td>
                                            <Ctl:TextBox ID="txtSMREVTEAMNM" runat="server" Width="100px" ></Ctl:TextBox>                                          
                                        </td>
                                        <th><Ctl:Text ID="Text6" runat="server" LangCode="TXT03" Description="작업자" Required = "true"></Ctl:Text></th>
                                        <td>
                                            <Ctl:TextBox ID="txtSMRESSABUNNM" runat="server" Width="80px" ></Ctl:TextBox>                                          
                                        </td>
                                     </tr>     
                                     <tr>
                                        <th><Ctl:Text ID="Text7" runat="server" LangCode="TXT02" Description="요청번호" Required = "true"></Ctl:Text></th>
                                        <td>
                                            <Ctl:TextBox ID="txtPONUM" runat="server" Width="150px" ></Ctl:TextBox>                                          
                                        </td>
                                        <th><Ctl:Text ID="Text8" runat="server" LangCode="TXT03" Description="허가번호" Required = "true"></Ctl:Text></th>
                                        <td>
                                            <Ctl:TextBox ID="txtSMWKORAPPDATE" runat="server" Width="100px" ></Ctl:TextBox>                                          
                                        </td>
                                     </tr>    
                                    </table>
		                        </Ctl:Layer>
                            </div>                                 

                            
                            

                            <div class="MonitorSubWin" style="position:absolute; left:10px; top:0px; width:600px; height:350px; z-index:99;">
                                   <div class="mswHeader">
                                        <div class="mswTitle">작업현황</div>
                                   <div style="background-color:white;">                                     
                                       <Ctl:Layer ID="layer2" runat="server"  DefaultHide="False">
                                            <Ctl:WebSheet ID="gridWorkList" runat="server" Paging="false" HFixation="true" Fixation = "false" Height="200" CheckBox="false" Width="100%" TypeName="PSM.PSMBiz" MethodName="GetWorkOrder_List" UseColumnSort="true" HeaderHeight="5" CellHeight="15" >
                                                <%--<Ctl:SheetField DataField="PONUM" TextField="PONUM" Description="요청번호" Width="170" HAlign="center" Align="left"  runat="server" />       --%>
                                                <Ctl:SheetField DataField="SMWKORAPPDATE" TextField="SMWKORAPPDATE" Description="허가일자" Width="60" HAlign="center" Align="left" runat="server" />                                                 
                                                <Ctl:SheetField DataField="SMWKORSEQ" TextField="SMWKORSEQ" Description="순번" Width="30" HAlign="center" Align="left" runat="server" />     
                                                <Ctl:SheetField DataField="SMAREATEXT1" TextField="SMAREATEXT1" Description="작업내용" Width="200" HAlign="center" Align="left" runat="server" />                            
                                                <Ctl:SheetField DataField="SMREVTEAMNM" TextField="SMREVTEAMNM" Description="작업부서" Width="90" HAlign="center" Align="left" runat="server" />                            
                                                <Ctl:SheetField DataField="SMMETHODCODENM" TextField="SMMETHODCODENM" Description="작업구분" Width="90" HAlign="center" Align="left" runat="server" />                            
                                            </Ctl:WebSheet>
                                      </Ctl:Layer>
                                    </div>
                                   </div>
                            </div>
       </div>
    </div>
  </div>
</asp:Content>
