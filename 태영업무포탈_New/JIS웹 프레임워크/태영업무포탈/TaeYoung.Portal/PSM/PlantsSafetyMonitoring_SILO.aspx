<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlantsSafetyMonitoring_SILO.aspx.cs" Inherits="TaeYoung.Portal.PSM.PlantsSafetyMonitoring_SILO" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
     <style>
        
           
            
         /*   #winUnitInfos .x-panel-header-default
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
            }*/
            
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
                height:100%;
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

        }

        function UP_GetWorkDataBinding() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["P_SAUP"] = "S";

            gridWorkList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridWorkList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function UP_GetShipData() {

            var today = new Date();
            var DayYYMM = today.getFullYear() + CalLpad((today.getMonth() + 1));            

            var ht = new Object();
            ht["P_SDATE"] = DayYYMM;
            ht["P_YEAR"] = DayYYMM.substr(0, 4);
            ht["P_EISDATE"] = DayYYMM;

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "GetShipListData", GetShipData_After);

        }

        function GetShipData_After(e) {

                var recordKey = "";              

                var shipListid = "";
                var shipListTargetid = "";

                var shipSHIPCOMECheck = "";
                var shipSHIPSCHED = "";                  
                
                document.getElementById("S70001001_01").style.display = "none";
                document.getElementById("S70001001_02").style.display = "none";                
                document.getElementById("winunitship_Now").style.display = "none";
                document.getElementById("winunitship_Target").style.display = "none";            

            var DataSet = eval(e);

            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                for (var i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {                             

                            recordKey = DataSet.Tables[0].Rows[i]["PIERUNITCODE"];                    

                             shipListid = "winunitship_Now"; 
                             shipListTargetid = "winunitship_Target";
                          
                            if (recordKey) {
                                //record = unitStore.findRecord("UNITCODE", recordKey)
                                
                                   //현재 입항
                                   if (DataSet.Tables[0].Rows[i]["SHIPCOME"] == "Y") {
                                       
                                      document.getElementById(recordKey+"_01").style.display = "block";
                                      setShipunitName(shipListid, DataSet.Tables[0].Rows[i]["IHJUBDAT"], DataSet.Tables[0].Rows[i]["SHHANGCHANM"]);

                                      shipSHIPCOMECheck = "Y";
                                   }
                                   //출항 
                                   if( DataSet.Tables[0].Rows[i]["SHIPSAIL"] == "Y"){   
                                      document.getElementById(recordKey+"_01").style.display = "none";
                                   }              
                                   //예정                    
                                if (DataSet.Tables[0].Rows[i]["SHIPSCHED"] == "Y") {
                                    
                                      shipSHIPSCHED = "";
                                      //입합선박 이미지 있으면 입항예정 이미지는 뺀다.
                                      if( shipSHIPCOMECheck != "Y")
                                      {
                                         shipSHIPSCHED = "Y";
                                      }
                                      if( shipSHIPSCHED == "Y" )
                                      {
                                    
                                         document.getElementById(recordKey+"_02").style.display = "block";
                                         setShipunitName(shipListTargetid, DataSet.Tables[0].Rows[i]["IHJUBDAT"], DataSet.Tables[0].Rows[i]["SHHANGCHANM"]);
                                      }
                                      else
                                      {
                                    
                                         setShipunitName(shipListTargetid,  DataSet.Tables[0].Rows[i]["IHJUBDAT"], DataSet.Tables[0].Rows[i]["SHHANGCHANM"]);
                                      }
                                      break;
                                   }  
                                
                            }//if (recordKey) ..end                         
                }                
            }
        }
        
        function UP_GetUnitData() {

            var ht = new Object();
            ht["P_SAUP"] = "S";            

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
                            DataSet.Tables[0].Rows[i]["UNITSTATUS"],
                        );
                    }
                }
            }
            catch (err) {
                alert(err.message);
            }
        }

        function setUnit(UNITCODE,UNITDESC,UNITWINDOW,UNITPOINTX,UNITPOINTY,UNITTYPE, UNITSTATUS) {
        
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
                    if (UNITTYPE == "TANK100") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%; padding-bottom:5px;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "TANK101") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "TANK102") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "TANK103") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"right\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "TANK200") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%; padding-bottom:5px;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "TANK201") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "TANK202") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        addStyle = "left:20%; top:20%; width:60%; height:60%;";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "TANK203") {
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"right\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "SHIP") {                       

                        imgStr += "<a href=\"javascript:void(0);\""+GetUnitClickFunction(UNITCODE)+ "\">";
                        imgStr += "<img id='" + UNITCODE + "_01'  src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_02'  src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<div id = 'winunitship_Now' class=\"unitTitle\" style=\"margin-top:18px; \"><table style=\"width:100px;position:relative; left:200px; top:-20px; display:none; \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:red;\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div id = 'winunitship_Target' class=\"unitTitle\" style=\"margin-top:18px; \"><table style=\"width:100px;position:relative; left:200px; top:-20px; display:none; \"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" style=\"color:red;\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "</a>";
                    } else if (UNITTYPE == "UNLOADER") {
                        imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (UNITTYPE == "AREA") {
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        addStyle = "padding-bottom:15px;";
                        //imgStr += "<div class=\"unitTitle st01Hide\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle st01Hide\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >" + UNITDESC + "</a></td></tr></table></div>";
                    } else if (UNITTYPE == "SUBPOINT") {
                        imgStr += "<a href=\"javascript:void(0);\"" + GetUnitClickFunction(UNITCODE) + " onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        imgStr += "</a>";
                    } else if (UNITTYPE == "CHAINCONVEYOR") {

                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_01.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_02.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_03.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITTYPE + "_04.png\" usemap=\"#unit_map_" + UNITCODE + "\" class=\"st04\" />";
                        //imgStr += "<div class=\"unitTitle\" style=\"margin-top:10px;\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";
                        imgStr += "<div class=\"unitTitle\" style=\"margin-top:13px;\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"middle\"><a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" style=\"color:#000000;\">" + UNITDESC + "</a></td></tr></table></div>";

                    } else {
                        //imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
                        imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + UNITCODE + "\',\'" + UNITSTATUS + "\',\'" + UNITWINDOW + "\');\" >";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_01.png\" class=\"st01\" />";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_02.png\" class=\"st02\" />";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_03.png\" class=\"st03\" />";
                        //imgStr += "<img src=\"/Resources/Images/SILO/" + UNITCODE.substr(0, UNITCODE.length - 3) + "_04.png\" class=\"st04\" />";

                        ImgFileName = UNITCODE.substr(1, 1) + UNITCODE.substr(3, 4);

                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_01.png\" class=\"st01\" />";
                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_02.png\" class=\"st02\" />";
                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_03.png\" class=\"st03\" />";
                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + ImgFileName + "_04.png\" class=\"st04\" />";


//                        imgStr += "<img id='" + UNITCODE + "_01' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_01.png\" class=\"st01\" />";
//                        imgStr += "<img id='" + UNITCODE + "_02' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_02.png\" class=\"st02\" />";
//                        imgStr += "<img id='" + UNITCODE + "_03' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_03.png\" class=\"st03\" />";
//                        imgStr += "<img id='" + UNITCODE + "_04' style=\"filter:alpha(opacity=100)\" src=\"/Resources/Images/SILO/" + UNITCODE.substr(1, UNITCODE.length - 4) + "_04.png\" class=\"st04\" />";

                        imgStr += "</a>";
                        if (UNITCODE == "S200025000") {
                            // 별관은 부원료창고와 겹치므로 위에 오도록 예외처리
                            div.style.zIndex = "6";
                        }
                        if (UNITCODE == "S400015000") div.style.zIndex = "3";
                        else if (UNITCODE == "S400020000") div.style.zIndex = "3";
                        else if (UNITCODE == "S400030000") div.style.zIndex = "3";
                        else if (UNITCODE == "S400035000") div.style.zIndex = "3";
                        else if (UNITCODE == "S400040000") div.style.zIndex = "3";
                    }
                    div.innerHTML = imgStr;                    
                    
                    if (UNITTYPE == "SUBPOINT") {
                        div.style.left = (UNITPOINTX - 23) + "px";
                        div.style.top = (UNITPOINTY - 66) + "px";
                    } else if (UNITTYPE == "AREA") {
                        div.style.left = (UNITPOINTX - 27) + "px";
                        div.style.top = (UNITPOINTY - 42) + "px";
                    } else {
                        div.style.left = UNITPOINTX + "px";
                        div.style.top = UNITPOINTY + "px";
                    }
                    
                }
                div.className = "mUnit st" + UNITSTATUS;
                var mBody = document.getElementById("Monitor" + UNITWINDOW);

                mBody.appendChild(div);
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

        function OpenSubWin(id) {

            document.getElementById(id).style.display = "";

            //if( id == "winShipInofs" ){
            //    #{grdShip}.updateLayout(false, false);
            //}
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

        function GetWorkDataRun(recordKey) {

            var ht = new Object();
            ht["P_SAUP"] = "S";
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
                     txtSMWKORAPPDATE.SetValue(dataSet.Tables[0].Rows[0]["SMWKORAPPDATE"].toString()+'-'+dataSet.Tables[0].Rows[0]["SMWKORSEQ"].toString());  //허가번호               
                 }
            });
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

        window.onresize = function() { 

            MonitorBodyResize('Main');

        }
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content" style="height:850px;"">
         <div style="height:100%; background-image:url('/Resources/Images/SILO/SILO_full_bg.gif'); background-repeat:no-repeat; padding-top:40px;">
              <div id="MonitorMain" style="height:756px; width:1650px; position:relative; /*border:2px dotted #666666;*/ background-image:url('/Resources/Images/SILO/SILO_bg.gif'); background-repeat:no-repeat;">
                          <!-- 체인 컴베어 표시화면 -->
                            <div id="winMonitorSub1" class="MonitorSubWin" style="left:510px; top:0px; width:641px; height:240px; display:none;">
                                <div class="mswHeader">
                                    <div class="mswTitle">CHAIN CONVEYOR</div>
                                    <div class="mswClose"><a href="javascript:CloseSubWin('winMonitorSub1');">×</a></div>
                                </div>
                                <div id="MonitorSub1" class="mswBody" style="height:200px;width:631px;">
                                    <div style="height:80px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:80px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:80px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
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
                                <div id="MonitorSub2" class="mswBody" style="height:170px;width:211px;">
                                    <div style="height:50px; width:200px; margin:5px; background-color:#f5f6f8; float:left; border-radius:8px;"></div>
                                    <div style="height:100px; width:200px; margin:5px; background-color:#f5f6f8; float:left; clear:both; border-radius:8px;"></div>
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

                                <div class="MonitorSubWin" style="position:absolute; left:1050px; top:20px; width:600px; height:210px; z-index:99;">
                                   <div class="mswHeader">
                                        <div class="mswTitle">작업현황</div>
                                       <div style="background-color:white;">
                                       <Ctl:Layer ID="layer2" runat="server"  DefaultHide="False">
                                            <Ctl:WebSheet ID="gridWorkList" runat="server" Paging="false" HFixation="true" Fixation = "false" Height="100" CheckBox="false" Width="100%" TypeName="PSM.PSMBiz" MethodName="GetWorkOrder_List" UseColumnSort="true" HeaderHeight="5" CellHeight="15" >
                                                <%--<Ctl:SheetField DataField="PONUM" TextField="PONUM" Description="요청번호" Width="170" HAlign="center" Align="left"  runat="server" />       --%>
                                                <Ctl:SheetField DataField="SMWKORAPPDATE" TextField="SMWKORAPPDATE" Description="허가일자" Width="90" HAlign="center" Align="left" runat="server" />                                                 
                                                <Ctl:SheetField DataField="SMWKORSEQ" TextField="SMWKORSEQ" Description="순번" Width="40" HAlign="center" Align="left" runat="server" />     
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
</asp:content>


