<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SILOBIN.aspx.cs" Inherits="TaeYoung.Template.EDU.SILOBIN" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style type="text/css">
        
    </style>
    <script type="text/javascript">

        function OnLoad() {

            

            drowUnits();

            

        }

        function drowUnits() {

            var ht = new Object();

            ht["IN_LOADGUBN"] = "1";
            ht["IN_SDATE"] = "20200810";
            ht["IN_C2SAUP"] = "S";

            PageMethods.InvokeServiceTableSync(ht, "PSM.PSMBiz", "GetBINSYSTEMCLASS", function (e) {

                // 데이터를 가져와서 콤보를 만든다.           
                var dt = eval(e).Tables[0];

                var count = ObjectCount(dt.Rows);

                for (var i = 0; i < count; i++) {
                    setUnit(dt, i);
                }

            }, function (e) {
                // Biz 연결오류
                alert("화물 콤보박스 Error");
            });

            ht = null;

        }

        function setUnit(dt, i) {

            // 상태별 개체생성
            if (dt.Rows[i]["C2SCGUBN"].toString() == "") return;

            var div = document.getElementById("unit_" + dt.Rows[i]["C2KEYCODE"].toString());

            if (!div) {
                div = document.createElement("div");
                div.id = "unit_" + dt.Rows[i]["C2KEYCODE"].toString();
                div.style.position = "absolute";
                var imgStr = "";
                var addStyle = "";

//                //var Imgsty01 = GetBinZindexValue(data)+"01";
//                //var Imgsty02 = GetBinZindexValue(data)+"02";

//                //일반 정상 BIN
//                if (data.UNITTYPE == "TANK100" || data.UNITTYPE == "TANK200D" || data.UNITTYPE == "TANK200T" || data.UNITTYPE == "TANK200U") {
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:188.33px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:188.33px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK101") { //좌측 라운드 BIN
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:90.27px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:90.27px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                    //imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:147px; height:144px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                    //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
//                } else if (data.UNITTYPE == "TANK103") { //우측 라운드 BIN
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:90.86px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:90.86px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                    //imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:147px; height:144px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                    //imgStr += "<div class=\"unitTitle\" style=\"" + addStyle + "\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\" valign=\"middle\"><a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">" + data.UNITDESC + "</a></td></tr></table></div>";
//                } else if (data.UNITTYPE == "TANK201T" || data.UNITTYPE == "TANK201D") { //일반 BIN + 스타 BIN 형태
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:90.27px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:90.27px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK202T" || data.UNITTYPE == "TANK202D") { //일반 BIN + 스타 BIN 형태
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:181.13px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:181.13px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK102") { //스타 BIN
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:181.13px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:181.13px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK500") { //상옥
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:250px; height:200px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:250px; height:200px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK600") { //상옥
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:300px; height:200px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:300px; height:200px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK700") {
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:226.1px; height:249.9px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:226.1px; height:249.9px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK701") { //좌측 라운드 BIN
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:107.1px; height:210px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:107.1px; height:210px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK702") { //스타 BIN
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:214.9px; height:215px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:214.9px; height:215px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK703") { //우측 라운드 BIN
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:107.8px; height:210px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:107.8px; height:210px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else if (data.UNITTYPE == "TANK800") { //바닥 표시 BIN
//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:226.1px; height:249.9px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_01.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:226.1px; height:249.9px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITTYPE + "_02.png\" usemap=\"#unit_map_" + data.UNITCODE + "\" class=\"st02\" />";
//                } else {
//                    //imgStr += "<a href=\"javascript:void(0);\" onmouseover=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\');\" onmouseout=\"CloseUnitInfoWin();\">";
//                    imgStr += "<a href=\"javascript:void(0);\" onclick=\"OpenUnitInfoWin(\'" + data.UNITCODE + "\','BIN');\" >";
//                    //imgStr += "<img src=\"../Resources/Images/Monitoring/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_01.png\" class=\"st01\" />";
//                    //imgStr += "<img src=\"../Resources/Images/Monitoring/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_02.png\" class=\"st02\" />";
//                    //imgStr += "<img src=\"../Resources/Images/Monitoring/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_03.png\" class=\"st03\" />";
//                    //imgStr += "<img src=\"../Resources/Images/Monitoring/SILO/" + data.UNITCODE.substr(0, data.UNITCODE.length - 3) + "_04.png\" class=\"st04\" />";

//                    imgStr += "<img id='" + data.UNITCODE + "_01' style=\"width:20%; height:20%\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITCODE.substr(1, data.UNITCODE.length - 4) + "_01.png\" class=\"st01\" />";
//                    imgStr += "<img id='" + data.UNITCODE + "_02' style=\"width:20%; height:20%\" src=\"../Resources/Images/Monitoring/SILOBIN/" + data.UNITCODE.substr(1, data.UNITCODE.length - 4) + "_02.png\" class=\"st02\" />";

//                    imgStr += "</a>";

                //                }

                if (dt.Rows[i]["C2DSGUBN"].toString() == "TANK100" || dt.Rows[i]["C2DSGUBN"].toString() == "TANK200D" || dt.Rows[i]["C2DSGUBN"].toString() == "TANK200T" || dt.Rows[i]["C2DSGUBN"].toString() == "TANK200U") {

                    imgStr += "<img id='" + dt.Rows[i]["C2KEYCODE"].toString() + "_01' style=\"width:188.33px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + dt.Rows[i]["C2DSGUBN"].toString() + "_01.png\" usemap=\"#unit_map_" + dt.Rows[i]["C2KEYCODE"].toString() + "\" class=\"st01\" />";
                    imgStr += "<img id='" + dt.Rows[i]["C2KEYCODE"].toString() + "_02' style=\"width:188.33px; height:210.63px\" src=\"../Resources/Images/Monitoring/SILOBIN/" + dt.Rows[i]["C2DSGUBN"].toString() + "_02.png\" usemap=\"#unit_map_" + dt.Rows[i]["C2KEYCODE"].toString() + "\" class=\"st02\" />";

                }

                div.innerHTML = imgStr;

                div.style.left = dt.Rows[i]["C2LXPOINT"].toString() + "px";
                div.style.top = dt.Rows[i]["C2LYPOINT"].toString() + "px";
            }

//            if (dt.Rows[i]["UNITSTATUS"].toString()) {
//                div.className = "mUnit st" + dt.Rows[i]["UNITSTATUS"].toString();
//            } else {
//                div.className = "mUnit st01";
//            }

            div.className = "mUnit st01";

            var mBody = document.getElementById("Group" + dt.Rows[i]["C2SCGUBN"].toString());
            mBody.appendChild(div);
        } 


    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">

    <!--컨텐츠시작-->
    <div id="main_body">
      <!--상단시작-->
      <div id="top">
         TANK MONITORING SYSTEM
         <div id="clock">
         </div>
      </div>
     
        
  
      <!--//확대, 트렌트 끝-->               
      
   </div>

     <!--//상단끝-->    
       <div id = "GroupMainA" class="bin">                                   
        </div>

        <div id = "GroupMainB" class="bin">                                   
        </div>       

        <div id = "GroupMainC" class="bin">                                           
        </div>    

</asp:content>