<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CCTVPage_UTT.aspx.cs" Inherits="TaeYoung.Portal.PSM.CCTVPage_UTT" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style id="styMain" runat="server" type="text/css">     
           
            .MonitorSubWin {position:absolute; z-index:100;}
            .MonitorSubWin .mswHeader { width:100%; height:30px; background-color:#b13f6b; border-top-left-radius:8px; border-top-right-radius:8px;}
            .MonitorSubWin .mswHeader .mswTitle {color:#FFFFFF;font-size:10pt; text-align:center; padding:5px 15px;}
            .MonitorSubWin .mswHeader .mswClose {position:absolute; right:0px; top:0px; padding:3px 15px;}
            .MonitorSubWin .mswHeader .mswClose a {color:#FFFFFF; font-size:10pt; text-decoration:none;}
            .MonitorSubWin .mswBody {position:relative; width:100%; background-color:#FFFFFF; padding:5px; border-bottom-left-radius:8px; border-bottom-right-radius:8px;}
        
    </style>
     
     <script type="text/javascript" language="javascript">


            function setTransformStyle(obj, attrName, value) {
                var setFlags = ["", "ms", "webkit", "moz", "o"];
                for (var i = 0; i < setFlags.length; i++) {
                    obj.style[setFlags[i] + attrName] = value;
                }
            }

         function MonitorBodyResize(winName) {

                //var winSize = { Mainbg: { x: 1650, y: 796} };
                //var wbody = document.getElementById(winName);
                //var factorX = wbody.parentNode.offsetWidth / winSize[winName].x;
                //var factorY = wbody.parentNode.offsetHeight / winSize[winName].y;
                //var factor = (factorX < factorY ? factorX : factorY);
                //setTransformStyle(wbody, "Transform", "scaleX(" + factor + ") scaleY(" + factor + ")");
                //setTransformStyle(wbody, "TransformOrigin", "top left");

                

                var winSize = { Main: { x: 1650, y: 756} };
                var wbody = document.getElementById(winName);
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

            var temp = 0;
            var win;

            function OpenCCTV(url, value) {

                if (temp == 1) {
                    win.close();
                }
                if (value == "1") {
                    win = window.open(url, "_blank", "fullscreen,resizable=yes,scrollbars");
                }
                else {
                    win = window.open(url, "scctv", "fullscreen,resizable=yes,scrollbars");
                }
                temp = 1;
            }


            function ImageChange(id, ImageName) {

                document.getElementById(id).src = "/Resources/Images/Layouts/CCTV/" + ImageName + ".png";
            }

            function OpenSubWin(id) {
                document.getElementById(id).style.display = "";
            }

            function CloseSubWin(id) {
                document.getElementById(id).style.display = "none";
            }

            //function WinLocation(evt, id) {               

            //    winToolTip.style.posLeft = event.x + 180 + document.body.scrollLeft;
            //    winToolTip.style.posTop = event.y + 150 + document.body.scrollTop;

            //}

         function WinLocation() {           

             //var left = event.x  + document.body.scrollLeft;
             //var Top = event.y + document.body.scrollTop;

             var left = event.x  - 300;
             var Top = event.y - 50;
                
                document.getElementById('winToolTip').style.left = left + 'px';                
                document.getElementById('winToolTip').style.top = Top + 'px';
            }


            function WinCCTV_DspText(Pointid) {

                var cctvname;

                switch (Pointid) {
                    case "T01":
                        cctvname = "상단지 계근대";
                        break;
                    case "T02":
                        cctvname = "부두 정문";
                        break;
                    case "T03":
                        cctvname = "부두 중앙";
                        break;
                    case "T04":
                        cctvname = "해안단지 계근대";
                        break;
                    case "U5":
                        cctvname = "해안단지 에틸렌 부두";
                        break;
                    case "T05":
                        cctvname = "해안입구 SILO방향";
                        break;
                    case "T06":
                        cctvname = "해안입구 UTT방향";
                        break;
                    case "T07":
                        cctvname = "드럼장 입구";
                        break;
                    case "T08":
                        cctvname = "부두 담장";
                        break;
                    case "T09":
                        cctvname = "하단지 콤프레샤실";
                        break;
                    case "T10":
                        cctvname = "송유단지 T-2001앞";
                        break;
                    case "T11":
                        cctvname = "송유단지 변전실";
                        break;
                    case "T12":
                        cctvname = "상단지 T-3004";
                        break;
                    case "T13":
                        cctvname = "UTT후문 도로변";
                        break;
                    case "T14":
                        cctvname = "UTT후문 출입로";
                        break;
                    case "T15":
                        cctvname = "UTT후문 T-911방향";
                        break;

                    case "T16":
                        cctvname = "상단지 사무실 옥상";
                        break;
                    case "T17":
                        cctvname = "상단지 4펌프실(T-902옆) 상단";
                        break;

                    case "T18":
                        cctvname = "상단지 4펌프실(T-903옆) 상단";
                        break;
                    case "T19":
                        cctvname = "상단지 T-806";
                        break;
                    case "T20":
                        cctvname = "상단지 변전실 옥상";
                        break;
                    case "T21":
                        cctvname = "UTT본관 공무샵 방향";
                        break;

                    case "T22":
                        cctvname = "UTT본관 옥상";
                        break;

                    case "T23":
                        cctvname = "UTT정문 옥상";
                        break;

                    case "T24":
                        cctvname = "해안단지 사무실 옥상";
                        break;

                    case "T25":
                        cctvname = "항운노조 휴게실";
                        break;

                    case "T26":
                        cctvname = "에틸렌 부두";
                        break;

                    case "T27":
                        cctvname = "하단지 T-101";
                        break;

                    case "T28":
                        cctvname = "UTT 1부두";
                        break;

                    case "T29":
                        cctvname = "송유단지 변전실 옥상";
                        break;

                    case "T30":
                        cctvname = "송유단지 6펌프실";
                        break;

                    case "T31":
                        cctvname = "송유단지 VCU";
                        break;

                    case "S10":
                        cctvname = "에틸렌 부두";
                        break;

                    case "T32":
                        cctvname = "하단지 보일러실 입구";
                        break;

                    case "T33":
                        cctvname = "하단지 보일러실 중앙";
                        break;

                    case "T34":
                        cctvname = "상단지 사무실 옥상 4펌프실";
                        break;

                    case "T35":
                        cctvname = "하단지 펌프실";
                        break;

                    case "T36":
                        cctvname = "상단지 T-501";
                        break;

                    case "T37":
                        cctvname = "상단지 T-811";
                        break;

                    case "T38":
                        cctvname = "상단지 T-913";
                        break;

                    case "T39":
                        cctvname = "상단지 2출하장";
                        break;

                    case "T40":
                        cctvname = "상단지 경비초소";
                        break;

                    case "T41":
                        cctvname = "상단지 T-509";
                        break;

                    case "T42":
                        cctvname = "상단지 사무실 옥상 본관방향";
                        break;

                    case "T43":
                        cctvname = "UTT 1부두 방향";
                        break;

                    case "T44":
                        cctvname = "UTT 2부두 방향";
                        break;

                }

                cctvname += '(' + Pointid + ')';

                if (cctvname.length > 16) {
                    document.getElementById('winToolTip').style.width = 280 + 'px';
                }
                else {
                    document.getElementById('winToolTip').style.width = 200 + 'px';
                }

                winToolTipText.innerHTML = cctvname;
         }

         window.onresize = function() { 

            MonitorBodyResize('Mainbg');

         }			
          
        </script>

    
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content" style="height:865px;"">
         <div style="height:100%; background-image:url('/Resources/Images/UTT/UTT_full_bg.gif'); background-repeat:no-repeat; ">
         
          <div id="Mainbg" style="height:796px; width:1650px; background-image:url(/Resources/Images/Layouts/CCTV_UTT2.jpg); background-repeat:no-repeat;">
                         <%--상단지 U1--%>           
                        <div style="position:absolute; left:960px; top:180px; cursor:pointer;">
                           <img  id = "CCTV_U1" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV01.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U1','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T01');" onmouseout = "ImageChange('CCTV_U1','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--송유단지 NU1--%>           
                        <div style="position:absolute; left:410px; top:400px; cursor:pointer;">
                           <img  id = "CCTV_NU1" src="/Resources/Images/Layouts/CCTV/파이_블루_아래쪽.png"  style="height:50px; width:30px;" onclick="OpenCCTV('http://TCCTV31.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU1','파이_바이올렛_아래쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T10');" onmouseout = "ImageChange('CCTV_NU1','파이_블루_아래쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--송유단지 NU2--%>
                        <div style="position:absolute; left:120px; top:440px; cursor:pointer;">
                           <img  id = "CCTV_NU2" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV32.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU2','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T11');" onmouseout = "ImageChange('CCTV_NU2','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--송유단지 변전실 옥상 T29 --%>
                        <div style="position:absolute; left:70px; top:430px; cursor:pointer;">
                           <img  id = "CCTV_NU29" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV33.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU29','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T29');" onmouseout = "ImageChange('CCTV_NU29','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--송유단지 펌프실 T30 --%>
                        <div style="position:absolute; left:220px; top:460px; cursor:pointer;">
                           <img  id = "CCTV_NU30" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV34.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU30','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T30');" onmouseout = "ImageChange('CCTV_NU30','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--송유단지 VCU T31 --%>
                        <div style="position:absolute; left:230px; top:330px; cursor:pointer;">
                           <img  id = "CCTV_NU31" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV35.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU31','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T31');" onmouseout = "ImageChange('CCTV_NU31','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--상단지사무실 NU9--%>           
                        <div style="position:absolute; left:980px; top:140px; cursor:pointer;">
                           <img  id = "CCTV_NU9" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV14.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU9','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T16');" onmouseout = "ImageChange('CCTV_NU9','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--상단지4펌프실 NU10--%>           
                        <div style="position:absolute; left:1020px; top:160px; cursor:pointer;">
                           <img  id = "CCTV_NU10" src="/Resources/Images/Layouts/CCTV/파이_블루_왼위쪽45.png"  style="height:50px; width:50px;" onclick="OpenCCTV('http://TCCTV15.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU10','파이_바이올렛_왼위쪽45'); OpenSubWin('winToolTip'); WinCCTV_DspText('T17');" onmouseout = "ImageChange('CCTV_NU10','파이_블루_왼위쪽45'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--상단지4펌프실 NU11--%>           
                        <div style="position:absolute; left:970px; top:255px; cursor:pointer;">
                           <img  id = "CCTV_NU11" src="/Resources/Images/Layouts/CCTV/타원02_위쪽_블루.png"  style="height:49px; width:100px;" onclick="OpenCCTV('http://TCCTV16.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU11','타원02_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T18');" onmouseout = "ImageChange('CCTV_NU11','타원02_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 후문 NU6--%>           
                        <div style="position:absolute; left:700px; top:110px; cursor:pointer;">
                           <img  id = "CCTV_NU6" src="/Resources/Images/Layouts/CCTV/파이_블루_위쪽.png"  style="height:50px; width:30px;" onclick="OpenCCTV('http://TCCTV11.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU6','파이_바이올렛_위쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T13');" onmouseout = "ImageChange('CCTV_NU6','파이_블루_위쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 후문 NU7--%>           
                        <div style="position:absolute; left:720px; top:150px; cursor:pointer;">
                           <img  id = "CCTV_NU7" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV12.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU7','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T14');" onmouseout = "ImageChange('CCTV_NU7','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 후문 NU8--%>         
                        <div style="position:absolute; left:680px; top:160px; cursor:pointer;">
                           <img  id = "CCTV_NU8" src="/Resources/Images/Layouts/CCTV/파이_블루_아래쪽.png"  style="height:50px; width:30px;" onclick="OpenCCTV('http://TCCTV13.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU8','파이_바이올렛_아래쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T15');" onmouseout = "ImageChange('CCTV_NU8','파이_블루_아래쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--상단지 3000단지 NU5--%>         
                        <div style="position:absolute; left:1250px; top:20px; cursor:pointer;">
                           <img  id = "CCTV_NU5" src="/Resources/Images/Layouts/CCTV/타원02_위쪽_블루.png"  style="height:60px; width:130px;" onclick="OpenCCTV('http://TCCTV10.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU5','타원02_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T12');" onmouseout = "ImageChange('CCTV_NU5','타원02_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--상단지 변전실 NU13--%>           
                        <div style="position:absolute; left:1370px; top:230px; cursor:pointer;">
                           <img  id = "CCTV_NU13" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV18.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU13','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T20');" onmouseout = "ImageChange('CCTV_NU13','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 본관 NU14--%>           
                       <%-- <div style="position:absolute; left:1435px; top:195px; cursor:pointer;">
                           <img  id = "CCTV_NU14" src="/Resources/Images/Layouts/CCTV/파이_블루_왼위쪽45.png"  style="height:70px; width:70px;" onclick="OpenCCTV('http://TCCTV19.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU14','파이_바이올렛_왼위쪽45'); OpenSubWin('winToolTip'); WinCCTV_DspText('T21');" onmouseout = "ImageChange('CCTV_NU14','파이_블루_왼위쪽45'); CloseSubWin('winToolTip'); " />
                        </div>--%>

                        <div style="position:absolute; left:1455px; top:260px; cursor:pointer;">
                           <img  id = "CCTV_NU14" src="/Resources/Images/Layouts/CCTV/파이_블루_왼아래쪽45.png"  style="height:70px; width:70px;" onclick="OpenCCTV('http://TCCTV19.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU14','파이_오렌지_왼아래쪽45'); OpenSubWin('winToolTip'); WinCCTV_DspText('T21');" onmouseout = "ImageChange('CCTV_NU14','파이_블루_왼아래쪽45'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 본관 NU15--%>           
                        <%--<div style="position:absolute; left:1480px; top:350px; cursor:pointer;">
                           <img  id = "CCTV_NU15" src="/Resources/Images/Layouts/CCTV/파이_블루_오른아래쪽45.png"  style="height:70px; width:70px;" onclick="OpenCCTV('http://TCCTV20.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU15','파이_바이올렛_오른아래쪽45'); OpenSubWin('winToolTip'); WinCCTV_DspText('T22');" onmouseout = "ImageChange('CCTV_NU15','파이_블루_오른아래쪽45'); CloseSubWin('winToolTip'); " />
                        </div>--%>

                        <%--UTT 본관 NU16--%>           
                        <div style="position:absolute; left:1360px; top:440px; cursor:pointer;">
                           <img  id = "CCTV_NU16" src="/Resources/Images/Layouts/CCTV/파이_블루_위쪽.png"  style="height:70px; width:70px;" onclick="OpenCCTV('http://TCCTV21.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU16','파이_바이올렛_위쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T23');" onmouseout = "ImageChange('CCTV_NU16','파이_블루_위쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--상단지 NU12--%>           
                        <div style="position:absolute; left:900px; top:400px; cursor:pointer;">
                           <img  id = "CCTV_NU12" src="/Resources/Images/Layouts/CCTV/타원02_위쪽_블루.png"  style="height:49px; width:100px;" onclick="OpenCCTV('http://TCCTV17.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU12','타원02_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T19');" onmouseout = "ImageChange('CCTV_NU12','타원02_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--부두 U2 --%>           
                        <div style="position:absolute; left:1200px; top:620px; cursor:pointer;">
                           <img  id = "CCTV_U2" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:75px; width:120px;" onclick="OpenCCTV('http://TCCTV02.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U2','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T02');" onmouseout = "ImageChange('CCTV_U2','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 1부두 신규설치 --%> 
                        <%--<div style="position:absolute; left:1330px; top:610px; cursor:pointer;">
                           <img  id = "CCTV_U28" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV25.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U28','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T28');" onmouseout = "ImageChange('CCTV_U28','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>--%> 

                        <%--하단지 T-101 신규설치 --%> 
                        <div style="position:absolute; left:920px; top:500px; cursor:pointer;">
                           <img  id = "CCTV_U27" src="/Resources/Images/Layouts/CCTV/파이_블루_아래쪽.png"  style="height:50px; width:30px;" onclick="OpenCCTV('http://TCCTV26.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U27','파이_바이올렛_아래쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T27');" onmouseout = "ImageChange('CCTV_U27','파이_블루_아래쪽'); CloseSubWin('winToolTip'); " />
                        </div>


                         <%--부두 U3 --%>           
                        <div style="position:absolute; left:850px; top:630px; cursor:pointer;">
                           <img  id = "CCTV_U3" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:75px; width:150px;" onclick="OpenCCTV('http://TCCTV03.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U3','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T03');" onmouseout = "ImageChange('CCTV_U3','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--부두 U8--%>           
                        <%--
                        <div style="position:absolute; left:900px; top:570px; cursor:pointer;">
                           <img  id = "CCTV_U8" src="/Resources/Images/Layouts/CCTV/파이_블루_위쪽.png"  style="height:50px; width:30px;" onclick="OpenCCTV('http://TCCTV07.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U8','파이_바이올렛_위쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T07');" onmouseout = "ImageChange('CCTV_U8','파이_블루_위쪽'); CloseSubWin('winToolTip'); " />
                        </div>--%>

                        <div style="position:absolute; left:450px; top:480px; cursor:pointer;">
                           <img  id = "CCTV_U8" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV07.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U8','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T07');" onmouseout = "ImageChange('CCTV_U8','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>


                        <%--부두 U9--%>           
                        <div style="position:absolute; left:920px; top:610px; cursor:pointer;">
                           <img  id = "CCTV_U9" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV08.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U9','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T08');" onmouseout = "ImageChange('CCTV_U9','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--하단지 콤프레샤실 T09 --%>           
                        <div style="position:absolute; left:1530px; top:275px; cursor:pointer;">
                           <img  id = "CCTV_U10" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV09.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U10','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T09');" onmouseout = "ImageChange('CCTV_U10','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--하단지 보일러실 입구 T32 --%>           
                        <div style="position:absolute; left:1490px; top:315px; cursor:pointer;">
                           <img  id = "CCTV_U11" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV27.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U11','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T32');" onmouseout = "ImageChange('CCTV_U11','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--하단지 보일러실 중앙 T33 --%>           
                        <div style="position:absolute; left:1510px; top:295px; cursor:pointer;">
                           <img  id = "CCTV_U12" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV28.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U12','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T33');" onmouseout = "ImageChange('CCTV_U12','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--해안단지 사무실 NU17--%>           
                        <div style="position:absolute; left:640px; top:595px; cursor:pointer;">
                           <img  id = "CCTV_NU17" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV22.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU17','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T24');" onmouseout = "ImageChange('CCTV_NU17','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                       

                        <%--해안단지 사무실 U4--%>           
                        <div style="position:absolute; left:575px; top:500px; cursor:pointer;">
                           <img  id = "CCTV_U4" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:50px; width:100px;" onclick="OpenCCTV('http://TCCTV04.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U4','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T04');" onmouseout = "ImageChange('CCTV_U4','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--해안단지 사무실 PS-S4--%>           
                        <div style="position:absolute; left:550px; top:615px; cursor:pointer;">
                           <img  id = "CCTV_PS-S4" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://scctv10.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_PS-S4','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S10');" onmouseout = "ImageChange('CCTV_PS-S4','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        
                        <%--해안단지 사무실 U6--%>           
                        <div style="position:absolute; left:400px; top:480px; cursor:pointer;">
                           <img  id = "CCTV_U6" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV05.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U6','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T05');" onmouseout = "ImageChange('CCTV_U6','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--해안단지 사무실 U7--%>           
                        <div style="position:absolute; left:500px; top:480px; cursor:pointer;">
                           <img  id = "CCTV_U7" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV06.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_U7','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T06');" onmouseout = "ImageChange('CCTV_U7','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--항운노조사무실 NU18--%>           
                        <div style="position:absolute; left:100px; top:580px; cursor:pointer;">
                           <img  id = "CCTV_NU18" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:50px;" onclick="OpenCCTV('http://TCCTV23.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU18','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T25');" onmouseout = "ImageChange('CCTV_NU18','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--에틸렌 부두 NU19--%>           
                        <div style="position:absolute; left:630px; top:620px; cursor:pointer;">
                           <img  id = "CCTV_NU19" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:50px; width:100px;" onclick="OpenCCTV('http://TCCTV24.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU19','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T26');" onmouseout = "ImageChange('CCTV_NU19','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--상단지 2출하장 T39 --%>
                        <div style="position:absolute; left:1100px; top:120px; cursor:pointer;">
                           <img  id = "CCTV_NU39" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV40.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU39','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T39');" onmouseout = "ImageChange('CCTV_NU39','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--상단지 경비초소 T40 --%>
                        <div style="position:absolute; left:1450px; top:70px; cursor:pointer;">
                           <img  id = "CCTV_NU40" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV41.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU40','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T40');" onmouseout = "ImageChange('CCTV_NU40','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--T-509 T41 --%>
                        <div style="position:absolute; left:1220px; top:200px; cursor:pointer;">
                           <img  id = "CCTV_NU41" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV42.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU41','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T41');" onmouseout = "ImageChange('CCTV_NU41','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--하단지 펌프실 T35 --%>
                        <div style="position:absolute; left:1370px; top:530px; cursor:pointer;">
                           <img  id = "CCTV_NU35" src="/Resources/Images/Layouts/CCTV/타원01_위쪽_블루.png"  style="height:20px; width:40px;" onclick="OpenCCTV('http://TCCTV36.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU35','타원01_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T35');" onmouseout = "ImageChange('CCTV_NU35','타원01_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--T-501 NU36--%>           
                        <div style="position:absolute; left:1050px; top:420px; cursor:pointer;">
                           <img  id = "CCTV_NU36" src="/Resources/Images/Layouts/CCTV/타원02_위쪽_블루.png"  style="height:49px; width:100px;" onclick="OpenCCTV('http://TCCTV37.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU36','타원02_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T36');" onmouseout = "ImageChange('CCTV_NU36','타원02_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--T-811 NU37--%>           
                        <div style="position:absolute; left:740px; top:420px; cursor:pointer;">
                           <img  id = "CCTV_NU37" src="/Resources/Images/Layouts/CCTV/타원02_위쪽_블루.png"  style="height:49px; width:100px;" onclick="OpenCCTV('http://TCCTV38.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU37','타원02_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T37');" onmouseout = "ImageChange('CCTV_NU37','타원02_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                          <%--T-913 NU38--%>           
                        <div style="position:absolute; left:640px; top:290px; cursor:pointer;">
                           <img  id = "CCTV_NU38" src="/Resources/Images/Layouts/CCTV/타원02_위쪽_블루.png"  style="height:49px; width:100px;" onclick="OpenCCTV('http://TCCTV39.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU38','타원02_위쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('T38');" onmouseout = "ImageChange('CCTV_NU38','타원02_위쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                          <%--상단지사무실 옥상 4펌프실 NU34--%>  
                         <div style="position:absolute; left:980px; top:160px; cursor:pointer;">
                           <img  id = "CCTV_NU34" src="/Resources/Images/Layouts/CCTV/파이_블루_왼아래쪽45.png"  style="height:50px; width:50px;" onclick="OpenCCTV('http://TCCTV43.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU34','파이_바이올렛_왼아래쪽45'); OpenSubWin('winToolTip'); WinCCTV_DspText('T34');" onmouseout = "ImageChange('CCTV_NU34','파이_블루_왼아래쪽45'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--하단지사무실 옥상 본관방향 NU41--%>  
                        <div style="position:absolute; left:1405px; top:445px; cursor:pointer;">
                           <img  id = "CCTV_NU42" src="/Resources/Images/Layouts/CCTV/파이_블루_왼위쪽45.png"  style="height:60px; width:60px;" onclick="OpenCCTV('http://TCCTV44.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU42','파이_바이올렛_왼위쪽45'); OpenSubWin('winToolTip'); WinCCTV_DspText('T42');" onmouseout = "ImageChange('CCTV_NU42','파이_블루_왼위쪽45'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 1부두 방향 T43--%>  
                        <div style="position:absolute; left:1085px; top:645px; cursor:pointer;">
                           <img  id = "CCTV_T43" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:30px; width:60px;" onclick="OpenCCTV('http://TCCTV45.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_T43','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T43');" onmouseout = "ImageChange('CCTV_T43','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--UTT 2부두 방향 T44--%>  
                        <div style="position:absolute; left:1010px; top:645px; cursor:pointer;">
                           <img  id = "CCTV_T44" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:30px; width:60px;" onclick="OpenCCTV('http://TCCTV46.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_T44','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T44');" onmouseout = "ImageChange('CCTV_T44','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--툴팁 박스--%>           
                        <div id="winToolTip" class="MonitorSubWin" style="left:96px; top:295px; width:150px; display:none;">
                               <div class="mswHeader">
                                    <div id="winToolTipText"  class="mswTitle"></div>
                               </div>
                        </div>
                           
                    </div>                   

        </div> 
    </div>
</asp:content>


