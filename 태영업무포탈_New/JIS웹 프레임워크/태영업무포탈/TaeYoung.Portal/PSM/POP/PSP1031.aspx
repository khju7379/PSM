﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSP1031.aspx.cs" Inherits="TaeYoung.Portal.PSM.POP.PSP1031" %>

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

        var _data = '';

        // 페이지 로드
        function OnLoad() {

            _data = "<%= Request.QueryString["param"] %>";

            /* 설비코드 표시 */
            UP_GetUnitData();            
        }

        //지역코드 선정된 지역 표시
        function UP_SetAreaCode(data) {
                        
            var rwindex = 0;

            if (data != undefined) {
                
                var ArrayCode = data.split('^');

                for (var i = 0; i < ArrayCode.length; i++) {                    

                    if (ArrayCode[i].length >= 9) {

                        gridAreaList.InsertRow();
                        gridAreaList.SetValue(rwindex, "AREACODE", ArrayCode[i]);
                        gridAreaList.SetValue(rwindex, "AREACODENM", ArrayCode[i + 1]);
                        gridAreaList.SetValue(rwindex, "ARDEL", "<img  id='" + ArrayCode[i] + "' style='cursor:pointer' src= '/Resources/Images/ext_delete.png' onclick= UP_GridDelClick(this) >");
                        
                        var div = document.getElementById("unit_" + ArrayCode[i]);
                        div.className = "mUnit st04";

                        rwindex = rwindex + 1;
                    }

                    i = i + 1;
                }
            }         

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
                            "01"
                        );
                    }

                    UP_SetAreaCode(_data);
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
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a>" + UNITDESC.replace(/T-/g, "") + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "AREA") {
                        //imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITDESC + "\',\'" + UNITTYPE + "\');\">";
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (UNITTYPE == "PIFE") {
                        //imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITDESC + "\',\'" + UNITTYPE + "\');\">";
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/UTT/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (UNITTYPE == "PUMP") {
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITDESC + "\',\'" + UNITTYPE + "\');\">";
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
                        imgStr += "<a href=\"javascript:void(0);\"" + GetUnitClickFunction(UNITCODE) + " onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITDESC + "\',\'" + UNITTYPE + "\');\">";
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

        function OpenUnitInfoWin(UNITCODE, UNITSTATUS, UNITDESC, UNITTYPE) {

            var i = 0;            

            var dt = gridAreaList.GetAllRow();

            if (dt == null) {
                i = 0;
            }
            else {
                i = ObjectCount(dt.Rows);
            }           

            //선택지역 이미지 교체
            var div = document.getElementById("unit_" + UNITCODE);

            if (i > 4 && div.className != "mUnit st04" ) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="작업지역 선택은 5곳까지 할수있습니다." Literal="true"></Ctl:Text>');
                return;
            }

            if (div.className == "mUnit st04") {                

                UP_AreaRemove(UNITCODE);
            }
            else {
                // 선택지역 grid 추가
                gridAreaList.InsertRow();
                gridAreaList.SetValue(i, "AREACODE", UNITCODE);
                gridAreaList.SetValue(i, "AREACODENM", UNITDESC);
                gridAreaList.SetValue(i, "ARDEL", "<img  id='" + UNITCODE +"' style='cursor:pointer' src= '/Resources/Images/ext_delete.png' onclick= UP_GridDelClick(this) >");
            }


            div.className = (div.className == "mUnit st01") ? (( UNITTYPE == "AREA") ? "mUnit st04" : "mUnit st02") : "mUnit st01";
        }

        function UP_AreaRemove(UNITCODE) {

            var rowindex = 0;
            var dt = gridAreaList.GetAllRow();

            for (i = 0; i < ObjectCount(dt.Rows); i++) {                

                if (UNITCODE == dt.Rows[i]["AREACODE"]) {
                    rowindex = i;
                }
            }           

            gridAreaList.RemoveRows([rowindex]);
        }        

        function UP_GridDelClick(id) {

            var index = id.parentNode.id.indexOf('_',0);
            var r = id.parentNode.id.substr(index + 1, 1);


            var row = gridAreaList.GetRow(r);
            var div = document.getElementById("unit_" + row["AREACODE"]);
            div.className = "mUnit st01";

            gridAreaList.RemoveRows([r]);
        }

        function btnSelect_Click() {

            var dt = gridAreaList.GetAllRow();

            if (dt == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="선택한 지역이 없습니다1." Literal="true"></Ctl:Text>');
                return;
            }
            else {
                if (ObjectCount(dt.Rows) <= 0) {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="선택한 지역이 없습니다2." Literal="true"></Ctl:Text>');
                    return;
                }
            }

            if (opener) {
                opener.btnAreaPopup_Callback(gridAreaList.GetAllRow());
                self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }

        function btnClose_Click() {
            self.close();
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


        window.onresize = function () {

            MonitorBodyResize('Main');

        }
    </script>
</asp:content>

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
                                                        
                            <div class="MonitorSubWin" style="position:absolute; left:10px; top:0px; width:600px; height:200px; z-index:99;">
                                   <div class="mswHeader">
                                        <div class="mswTitle">작업지역선택</div>
                                   <div style="background-color:white;">      

                                       <div class="btn_bx">
                                            <table class="table_01" style="width: 100%; height:30px;">    
                                                <colgroup>
                                                    <col width="*" />
                                                </colgroup>                
                                                <tr style="text-align:left;">                    
                                                    <td style="text-align:right;">
                                                        <Ctl:Button ID="btnSelect" runat="server" Style="Orange" LangCode="btnSelect" Description="선택" OnClientClick="btnSelect_Click();"></Ctl:Button>
                                                        <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>     
                                                    </td>
                    
                                                </tr>                                              
                                            </table>
                                       </div>

                                         <Ctl:Layer ID="layer2" runat="server"  DefaultHide="False">
                                                    <Ctl:WebSheet ID="gridAreaList" runat="server" Paging="false" HFixation="true" Fixation = "false" Height="150" CheckBox="false" Width="100%"  UseColumnSort="true" HeaderHeight="5" CellHeight="15" >
                                                        <%--<Ctl:SheetField DataField="PONUM" TextField="PONUM" Description="요청번호" Width="170" HAlign="center" Align="left"  runat="server" />       --%>
                                                        <Ctl:SheetField DataField="AREACODE" TextField="AREACODE" Description="작업지역" Width="60" HAlign="center" Align="left" runat="server" />                                                 
                                                        <Ctl:SheetField DataField="AREACODENM" TextField="AREACODENM" Description="작업지역명" Width="200" HAlign="center" Align="left" runat="server" />                            
                                                        <Ctl:SheetField DataField="ARDEL"      TextField=""     Description="" Width="30"  HAlign="center" Align="center"   runat="server" />                            
                                                    </Ctl:WebSheet>
                                         </Ctl:Layer>

                                    </div>
                                   </div>
                            </div>
       </div>
    </div>
  </div>
</asp:content>
