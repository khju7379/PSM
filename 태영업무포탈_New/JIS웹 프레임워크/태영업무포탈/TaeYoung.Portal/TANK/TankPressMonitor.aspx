<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TankPressMonitor.aspx.cs" Inherits="TaeYoung.Template.EDU.TankPressMonitor" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style type="text/css">
        /* 컨텐츠 */
   #main_body #containerPress {
   	position: relative;
   	/* margin: 0 auto; */
   	width: 100%;
   	background:#CCCED3;
   }
        .pressPosition {
            color: #FFF;
            font-weight: normal;
            background: #2D4D77;
            font-size:35px;
            text-align: center;
            height: 30px;	
            border:2px solid #9E9E9E;
            border-radius:15px 15px;
        }
	    .pressTitle {
            color: #FFF;
            font-weight: normal;
            background: #5587ED;
            font-size:23px;
            text-align: center;	
            height: 30px;	
            border:2px solid #9E9E9E;
            border-top-left-radius:15px 15px;
            border-top-right-radius:15px 15px;
        }
        .pressTitleBlock {
            color: #FFF;
            font-weight: normal;
            background: #9E9E9E;
            font-size:23px;
            text-align: center;	
            height: 30px;	
            border:2px solid #9E9E9E;
            border-top-left-radius:15px 15px;
            border-top-right-radius:15px 15px;
        }
        .pressContent {
            color: #000;
            background: #DCE1EC;
            font-size:25px;
            text-align: center;	
            height: 33px;	
            border:2px solid #9E9E9E; 
            border-bottom-left-radius:15px 15px;
            border-bottom-right-radius:15px 15px;
        }
        .pressWarningT {
            color: #FFF;
            font-weight: normal;
            background: #FF0000;
            font-size:23px;
            text-align: center;	
            height: 30px;	
            border:2px solid #9E9E9E;
            border-top-left-radius:15px 15px;
            border-top-right-radius:15px 15px;
        }
        .pressWarningC {
            color: #FF0000;
            background: #DCE1EC;
            font-size:25px;
            text-align: center;	
            height: 33px;	
            border:2px solid #9E9E9E; 
            border-bottom-left-radius:15px 15px;
            border-bottom-right-radius:15px 15px;
        }
    </style>
    <script type="text/javascript">

        var start_run;
        var start_reload;
        var start_Alram;
        var audio = new Audio('/Resources/Images/tank/Exclamation.mp3');

        function OnLoad() {
            // PageLoad시 이벤트 정의부분
            setInterval("dpTime()", 1000);
            run();
            start_reload = setInterval("pageRefresh();", '3610000');
            //start_reload = setInterval("pageRefresh();", '300000');
        }

        function init() {
            start_run = setInterval('run();', '20000');
        }
        function run() {

            var ht = new Object();
            var AlramCheck = "off";
            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetPress", function (e) {

                var dt = eval(e).Tables[0];
                var i;

                for (i = 0; i < ObjectCount(dt.Rows); i++) {
                    document.getElementById("txtPRESS" + dt.Rows[i]["JEGOTK"]).innerHTML = dt.Rows[i]["JEPRESS"];

                    if (dt.Rows[i]["JEGOTK"] == "904" || dt.Rows[i]["JEGOTK"] == "3007" || dt.Rows[i]["JEGOTK"] == "5001") {

                        if (dt.Rows[i]["JEPRESS"] < 3800) {

                            document.getElementById("txtTITLE" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressTitle");
                            document.getElementById("txtPRESS" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressContent");
                        }
                        else {
                            document.getElementById("txtTITLE" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressWarningT");
                            document.getElementById("txtPRESS" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressWarningC");
                            AlramCheck = "on";
                        }
                    }
                    else {
                        if (dt.Rows[i]["JEPRESS"] < 60 && dt.Rows[i]["JEPRESS"] > -40) {

                            document.getElementById("txtTITLE" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressTitle");
                            document.getElementById("txtPRESS" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressContent");
                        }
                        else {
                            //                        if (dt.Rows[i]["JEGOTK"] == "707" || dt.Rows[i]["JEGOTK"] == "709") {
                            //                            document.getElementById("txtTITLE" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressTitleBlock");
                            //                            document.getElementById("txtPRESS" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressContent");
                            //                        }
                            //                        else {
                            document.getElementById("txtTITLE" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressWarningT");
                            document.getElementById("txtPRESS" + dt.Rows[i]["JEGOTK"]).setAttribute("class", "pressWarningC");
                            AlramCheck = "on";
                            //}
                        }
                    }

                    if (i == 0) {
                        document.getElementById("txtJEGOTM").innerHTML = "최종수신시간 : " + dt.Rows[i]["JEGOTM"];
                    }
                }
                if (AlramCheck == "on") {
                    if ($("#alramState").val() == "off") {
                        SoundOn();
                        $("#alramState").val("on");
                    }
                }
                else {
                    SoundOff();
                    $("#alramState").val("off");
                }
            }, function (e) {
                // Biz 연결오류
                //alert("탱크번호 콤보박스Error");
                //saveCookie();
                //$("#txtPRESS" + dt.Rows[0]["JEGOTK"]).val();

            });
            clearInterval(start_run);
            init();
        }

        function pageRefresh() {
            clearInterval(start_run);
            clearInterval(start_reload);

            location.reload();
        }

        function SoundOn() {
            clearInterval(start_Alram);
            audio.loop = 'true';
            audio.play();
        }
        function SoundOff() {
            audio.pause();
        }

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
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--컨텐츠시작-->
    <div id="main_body">
      <!--상단시작-->
      <div id="top">
         TANK PRESS MONITORING SYSTEM
         <div id="clock">
         </div>
      </div>
      <!--//상단끝-->

      <!--버튼시작-->
      <div id="btn">
         <lable id="txtJEGOTM" style="margin-left:5px;margin-top:20px;font-size:15px;"></lable>
         <ul>
            <li>
               <a href="#" onclick="window.close();"><img src="/Resources/Images/tank/btn_icon_close.png" alt="닫기" /> 닫기</a>
            </li>
         </ul>
      </div>
      <!--//버튼끝-->

      <!--컨텐츠시작-->
      <div id="containerPress" style="z-index:1;" >
        <table border="0" cellpadding="0" cellspacing="0" id="tbMaster" align="center" width="100%" >
            <colgroup>
                <col width="9%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
            </colgroup>
<%--            <tr>
                <td colspan="2" id="txtJEGOTM2" style="font-size:15px;text-align:center;height: 21px;border:2px solid #9E9E9E;border-radius:10px 10px;background: #ffffff;">최종수신시간</td>
                <td colspan="12"></td>
            </tr>--%>
            <tr>
                <td class="pressPosition" rowspan="6">하단지</td>
                <th class="pressTitle" id="txtTITLE101">T-101</th>
                <th class="pressTitle" id="txtTITLE102">T-102</th>
                <th class="pressTitle" id="txtTITLE103">T-103</th>
                <th class="pressTitle" id="txtTITLE104">T-104</th>
                <th class="pressTitle" id="txtTITLE105">T-105</th>
                <th class="pressTitle" id="txtTITLE106">T-106</th>
                <th class="pressTitle" id="txtTITLE107">T-107</th>
                <th class="pressTitle" id="txtTITLE108">T-108</th>
                <th class="pressTitle" id="txtTITLE109">T-109</th>
                <th class="pressTitle" id="txtTITLE110">T-110</th>
                <th class="pressTitle" id="txtTITLE111">T-111</th>
                <td rowspan="2" colspan="2"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS101"></td>
                <td class="pressContent" id="txtPRESS102"></td>
                <td class="pressContent" id="txtPRESS103"></td>
                <td class="pressContent" id="txtPRESS104"></td>
                <td class="pressContent" id="txtPRESS105"></td>
                <td class="pressContent" id="txtPRESS106"></td>
                <td class="pressContent" id="txtPRESS107"></td>
                <td class="pressContent" id="txtPRESS108"></td>
                <td class="pressContent" id="txtPRESS109"></td>
                <td class="pressContent" id="txtPRESS110"></td>
                <td class="pressContent" id="txtPRESS111"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE201">T-201</th>
                <th class="pressTitle" id="txtTITLE202">T-202</th>
                <th class="pressTitle" id="txtTITLE203">T-203</th>
                <th class="pressTitle" id="txtTITLE204">T-204</th>
                <th class="pressTitle" id="txtTITLE205">T-205</th>
                <th class="pressTitle" id="txtTITLE206">T-206</th>
                <th class="pressTitle" id="txtTITLE207">T-207</th>
                <th class="pressTitle" id="txtTITLE208">T-208</th>
                <td rowspan="2" colspan="5"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS201"></td>
                <td class="pressContent" id="txtPRESS202"></td>
                <td class="pressContent" id="txtPRESS203"></td>
                <td class="pressContent" id="txtPRESS204"></td>
                <td class="pressContent" id="txtPRESS205"></td>
                <td class="pressContent" id="txtPRESS206"></td>
                <td class="pressContent" id="txtPRESS207"></td>
                <td class="pressContent" id="txtPRESS208"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE301">T-301</th>
                <th class="pressTitle" id="txtTITLE302">T-302</th>
                <th class="pressTitle" id="txtTITLE303">T-303</th>
                <th class="pressTitle" id="txtTITLE304">T-304</th>
                <th class="pressTitle" id="txtTITLE305">T-305</th>
                <th class="pressTitle" id="txtTITLE306">T-306</th>
                <th class="pressTitle" id="txtTITLE307">T-307</th>
                <th class="pressTitle" id="txtTITLE308">T-308</th>
                <th class="pressTitle" id="txtTITLE309">T-309</th>
                <th class="pressTitle" id="txtTITLE310">T-310</th>
                <td rowspan="2" colspan="3"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS301"></td>
                <td class="pressContent" id="txtPRESS302"></td>
                <td class="pressContent" id="txtPRESS303"></td>
                <td class="pressContent" id="txtPRESS304"></td>
                <td class="pressContent" id="txtPRESS305"></td>
                <td class="pressContent" id="txtPRESS306"></td>
                <td class="pressContent" id="txtPRESS307"></td>
                <td class="pressContent" id="txtPRESS308"></td>
                <td class="pressContent" id="txtPRESS309"></td>
                <td class="pressContent" id="txtPRESS310"></td>
            </tr>
            <tr><td comspan="14">　</td></tr>
            <tr>
                <td class="pressPosition" rowspan="14">상단지</td>
                <th class="pressTitle" id="txtTITLE501">T-501</th>
                <th class="pressTitle" id="txtTITLE502">T-502</th>
                <th class="pressTitle" id="txtTITLE503">T-503</th>
                <th class="pressTitle" id="txtTITLE504">T-504</th>
                <th class="pressTitle" id="txtTITLE505">T-505</th>
                <th class="pressTitle" id="txtTITLE506">T-506</th>
                <th class="pressTitle" id="txtTITLE507">T-507</th>
                <th class="pressTitle" id="txtTITLE508">T-508</th>
                <th class="pressTitle" id="txtTITLE509">T-509</th>
                <td rowspan="2" colspan="4"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS501"></td>
                <td class="pressContent" id="txtPRESS502"></td>
                <td class="pressContent" id="txtPRESS503"></td>
                <td class="pressContent" id="txtPRESS504"></td>
                <td class="pressContent" id="txtPRESS505"></td>
                <td class="pressContent" id="txtPRESS506"></td>
                <td class="pressContent" id="txtPRESS507"></td>
                <td class="pressContent" id="txtPRESS508"></td>
                <td class="pressContent" id="txtPRESS509"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE601">T-601</th>
                <th class="pressTitle" id="txtTITLE602">T-602</th>
                <th class="pressTitle" id="txtTITLE603">T-603</th>
                <th class="pressTitle" id="txtTITLE604">T-604</th>
                <th class="pressTitle" id="txtTITLE605">T-605</th>
                <th class="pressTitle" id="txtTITLE606">T-606</th>
                <th class="pressTitle" id="txtTITLE607">T-607</th>
                <th class="pressTitle" id="txtTITLE608">T-608</th>
                <td rowspan="2" colspan="5"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS601"></td>
                <td class="pressContent" id="txtPRESS602"></td>
                <td class="pressContent" id="txtPRESS603"></td>
                <td class="pressContent" id="txtPRESS604"></td>
                <td class="pressContent" id="txtPRESS605"></td>
                <td class="pressContent" id="txtPRESS606"></td>
                <td class="pressContent" id="txtPRESS607"></td>
                <td class="pressContent" id="txtPRESS608"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE701">T-701</th>
                <th class="pressTitle" id="txtTITLE702">T-702</th>
                <th class="pressTitle" id="txtTITLE703">T-703</th>
                <th class="pressTitle" id="txtTITLE704">T-704</th>
                <th class="pressTitle" id="txtTITLE705">T-705</th>
                <th class="pressTitle" id="txtTITLE706">T-706</th>
                <th class="pressTitle" id="txtTITLE707">T-707</th>
                <th class="pressTitle" id="txtTITLE708">T-708</th>
                <th class="pressTitle" id="txtTITLE709">T-709</th>
                <th class="pressTitle" id="txtTITLE710">T-710</th>
                <td rowspan="2" colspan="3"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS701"></td>
                <td class="pressContent" id="txtPRESS702"></td>
                <td class="pressContent" id="txtPRESS703"></td>
                <td class="pressContent" id="txtPRESS704"></td>
                <td class="pressContent" id="txtPRESS705"></td>
                <td class="pressContent" id="txtPRESS706"></td>
                <td class="pressContent" id="txtPRESS707"></td>
                <td class="pressContent" id="txtPRESS708"></td>
                <td class="pressContent" id="txtPRESS709"></td>
                <td class="pressContent" id="txtPRESS710"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE801">T-801</th>
                <th class="pressTitle" id="txtTITLE802">T-802</th>
                <th class="pressTitle" id="txtTITLE803">T-803</th>
                <th class="pressTitle" id="txtTITLE804">T-804</th>
                <th class="pressTitle" id="txtTITLE805">T-805</th>
                <th class="pressTitle" id="txtTITLE806">T-806</th>
                <th class="pressTitle" id="txtTITLE807">T-807</th>
                <th class="pressTitle" id="txtTITLE808">T-808</th>
                <th class="pressTitle" id="txtTITLE809">T-809</th>
                <th class="pressTitle" id="txtTITLE810">T-810</th>
                <th class="pressTitle" id="txtTITLE811">T-811</th>
                <th class="pressTitle" id="txtTITLE812">T-812</th>
                <td rowspan="2"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS801"></td>
                <td class="pressContent" id="txtPRESS802"></td>
                <td class="pressContent" id="txtPRESS803"></td>
                <td class="pressContent" id="txtPRESS804"></td>
                <td class="pressContent" id="txtPRESS805"></td>
                <td class="pressContent" id="txtPRESS806"></td>
                <td class="pressContent" id="txtPRESS807"></td>
                <td class="pressContent" id="txtPRESS808"></td>
                <td class="pressContent" id="txtPRESS809"></td>
                <td class="pressContent" id="txtPRESS810"></td>
                <td class="pressContent" id="txtPRESS811"></td>
                <td class="pressContent" id="txtPRESS812"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE901">T-901</th>
                <th class="pressTitle" id="txtTITLE902">T-902</th>
                <th class="pressTitle" id="txtTITLE903">T-903</th>
                <th class="pressTitle" id="txtTITLE904">T-904</th>
                <%--<td ></td>--%>
                <th class="pressTitle" id="txtTITLE905">T-905</th>
                <th class="pressTitle" id="txtTITLE906">T-906</th>
                <th class="pressTitle" id="txtTITLE907">T-907</th>
                <th class="pressTitle" id="txtTITLE908">T-908</th>
                <th class="pressTitle" id="txtTITLE909">T-909</th>
                <th class="pressTitle" id="txtTITLE910">T-910</th>
                <th class="pressTitle" id="txtTITLE911">T-911</th>
                <th class="pressTitle" id="txtTITLE912">T-912</th>
                <th class="pressTitle" id="txtTITLE913">T-913</th>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS901"></td>
                <td class="pressContent" id="txtPRESS902"></td>
                <td class="pressContent" id="txtPRESS903"></td>
                <td class="pressContent" id="txtPRESS904"></td>
                <%--<td ></td>--%>
                <td class="pressContent" id="txtPRESS905"></td>
                <td class="pressContent" id="txtPRESS906"></td>
                <td class="pressContent" id="txtPRESS907"></td>
                <td class="pressContent" id="txtPRESS908"></td>
                <td class="pressContent" id="txtPRESS909"></td>
                <td class="pressContent" id="txtPRESS910"></td>
                <td class="pressContent" id="txtPRESS911"></td>
                <td class="pressContent" id="txtPRESS912"></td>
                <td class="pressContent" id="txtPRESS913"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE1101">T-1101</th>
                <th class="pressTitle" id="txtTITLE1102">T-1102</th>
                <th class="pressTitle" id="txtTITLE1103">T-1103</th>
                <th class="pressTitle" id="txtTITLE1104">T-1104</th>
                <th class="pressTitle" id="txtTITLE1105">T-1105</th>
                <th class="pressTitle" id="txtTITLE1106">T-1106</th>
                <th class="pressTitle" id="txtTITLE1107">T-1107</th>
                <td rowspan="2" colspan="6"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS1101"></td>
                <td class="pressContent" id="txtPRESS1102"></td>
                <td class="pressContent" id="txtPRESS1103"></td>
                <td class="pressContent" id="txtPRESS1104"></td>
                <td class="pressContent" id="txtPRESS1105"></td>
                <td class="pressContent" id="txtPRESS1106"></td>
                <td class="pressContent" id="txtPRESS1107"></td>
            </tr>
            <tr>
                <th class="pressTitle" id="txtTITLE3001">T-3001</th>
                <th class="pressTitle" id="txtTITLE3002">T-3002</th>
                <th class="pressTitle" id="txtTITLE3003">T-3003</th>
                <th class="pressTitle" id="txtTITLE3004">T-3004</th>
                <th class="pressTitle" id="txtTITLE3005">T-3005</th>
                <th class="pressTitle" id="txtTITLE3006">T-3006</th>
                <th class="pressTitle" id="txtTITLE3007">T-3007</th>
                <td rowspan="2" colspan="7"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS3001"></td>
                <td class="pressContent" id="txtPRESS3002"></td>
                <td class="pressContent" id="txtPRESS3003"></td>
                <td class="pressContent" id="txtPRESS3004"></td>
                <td class="pressContent" id="txtPRESS3005"></td>
                <td class="pressContent" id="txtPRESS3006"></td>
                <td class="pressContent" id="txtPRESS3007"></td>
            </tr>
            <tr><td colspan="14">　</td></tr>
            <tr>
                <td class="pressPosition" rowspan="2">송유단지</td>
                <th class="pressTitle" id="txtTITLE2001">T-2001</th>
                <th class="pressTitle" id="txtTITLE2002">T-2002</th>
                <th class="pressTitle" id="txtTITLE2003">T-2003</th>
                <th class="pressTitle" id="txtTITLE2004">T-2004</th>
                <th class="pressTitle" id="txtTITLE2005">T-2005</th>
                <td rowspan="2" colspan="8"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS2001"></td>
                <td class="pressContent" id="txtPRESS2002"></td>
                <td class="pressContent" id="txtPRESS2003"></td>
                <td class="pressContent" id="txtPRESS2004"></td>
                <td class="pressContent" id="txtPRESS2005"></td>
            </tr>
            <tr><td colspan="14">　</td></tr>
            <tr>
                <td class="pressPosition" rowspan="2">해안단지</td>
                <th class="pressTitle" id="txtTITLE5001">T-5001</th>
                <th class="pressTitle" id="txtTITLE5002">T-5002</th>
                <th class="pressTitle" id="txtTITLE5003">T-5003</th>
                <th class="pressTitle" id="txtTITLE5004">T-5004</th>
                <th class="pressTitle" id="txtTITLE5005">T-5005</th>
                <th class="pressTitle" id="txtTITLE5006">T-5006</th>
                <th class="pressTitle" id="txtTITLE6001">T-6001</th>
                <th class="pressTitle" id="txtTITLE6002">T-6002</th>
                <th class="pressTitle" id="txtTITLE6003">T-6003</th>
                <th class="pressTitle" id="txtTITLE6004">T-6004</th>
                <td rowspan="2" colspan="3"></td>
            </tr>
            <tr>
                <td class="pressContent" id="txtPRESS5001"></td>
                <td class="pressContent" id="txtPRESS5002"></td>
                <td class="pressContent" id="txtPRESS5003"></td>
                <td class="pressContent" id="txtPRESS5004"></td>
                <td class="pressContent" id="txtPRESS5005"></td>
                <td class="pressContent" id="txtPRESS5006"></td>
                <td class="pressContent" id="txtPRESS6001"></td>
                <td class="pressContent" id="txtPRESS6002"></td>
                <td class="pressContent" id="txtPRESS6003"></td>
                <td class="pressContent" id="txtPRESS6004"></td>
            </tr>
            <tr><td colspan="14">　</td></tr>
        </table>
        <input type="hidden" id="alramState" value="off"/>
      </div>
      <!--//컨텐츠끝-->

      <!--하단시작-->
      <div id="btm">
         <img src="/Resources/Images/tank/btm_logo.gif" alt="" /> COPYRIGHT 2013 BY TAEYOUNG INDUSTRY PSM SYSTEM
      </div>
      <!--//하단끝-->
      
   </div>
</asp:content>