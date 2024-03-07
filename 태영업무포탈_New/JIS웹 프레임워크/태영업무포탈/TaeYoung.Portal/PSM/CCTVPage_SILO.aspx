<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CCTVPage_SILO.aspx.cs" Inherits="TaeYoung.Portal.PSM.CCTVPage_SILO" %>

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
                var winSize = { Mainbg: { x: 1650, y: 796} };
                var wbody = document.getElementById(winName);
                var factorX = wbody.parentNode.offsetWidth / winSize[winName].x;
                var factorY = wbody.parentNode.offsetHeight / winSize[winName].y;
                var factor = (factorX < factorY ? factorX : factorY);
                setTransformStyle(wbody, "Transform", "scaleX(" + factor + ") scaleY(" + factor + ")");
                setTransformStyle(wbody, "TransformOrigin", "top left");
            }


            function PopUpCCTV(Location, value) {

                var strWidth = window.screen.width - 30;
                var strHeigth = window.screen.height - 100;

                var feat = "dialogWidth=" + strWidth + "px;dialogHeight=" + strHeigth + "px;";

                //크롬용
                //var feat = "dialogWidth:" + strWidth + "px;dialogHeight:" + strHeigth + "px;";

                //window.showModalDialog("CCTVPage1.aspx?param1=" + encodeURI(Location) + "&param2=" + encodeURI(value), null, feat);

                if (value == "1") {
                    window.open("http://scctv01.taeyoung.co.kr/login.html", "_blank", "fullscreen,resizable=yes,scrollbars");
                }
                else {
                    window.showModalDialog("CCTVPage1.aspx?param1=" + encodeURI(Location) + "&param2=" + encodeURI(value), null, feat);
                    //window.open("CCTVPage1.aspx?param1=" + encodeURI(Location) + "&param2=" + encodeURI(value), null, feat);
                }

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

            function WinLocation(evt, id) {

                //winToolTip.style.posLeft = event.x + 180 + document.body.scrollLeft;
                //winToolTip.style.posTop = event.y + 150 + document.body.scrollTop;

                //var left = event.x - 50 + document.body.scrollLeft;
                //var Top  = event.y + 50 + document.body.scrollTop;

                 var left = event.x  - 300;
                 var Top = event.y - 50;
                
                document.getElementById('winToolTip').style.left = left + 'px';                
                document.getElementById('winToolTip').style.top = Top + 'px';
            }

            function WinCCTV_DspText(Pointid) {

                var cctvname;

                switch (Pointid) {
                    case "S01":
                        cctvname = "ABC그룹 H/H 상옥 상부";
                        break;
                    case "S02":
                        cctvname = "SILO 계근대 방향";
                        break;
                    case "S03":
                        cctvname = "SILO 고철장 옆";
                        break;

                    case "S05":
                        cctvname = "SILO 공무 옥상";
                        break;

                    case "S04":
                        cctvname = "SILO 본관 옥상";
                        break;
                    case "S06":
                        cctvname = "장비고 앞 가교 중앙";
                        break;
                    case "S07":
                        cctvname = "SILO 연안선적장";
                        break;
                    case "S08":
                        cctvname = "T5경계 앞";
                        break;
                    case "S09":
                        cctvname = "SILO 잔교";
                        break;
                    case "S10":
                        cctvname = "에틸렌 부두";
                        break;
                    case "S11":
                        cctvname = "SILO 정문";
                        break;
                    case "T25":
                        cctvname = "항운노조 휴게실";
                        break;
                    case "S13":
                        cctvname = "SILO 부원료창고 CCP 옆";
                        break;
                    case "S14":
                        cctvname = "SILO 부원료창고 해변 측";
                        break;
                    case "S15":
                        cctvname = "SILO 소화실 옥상";
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

        </script>

    
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content" style="height:865px;"">
         <div style="height:100%; background-image:url('/Resources/Images/SILO/SILO_full_bg.gif'); background-repeat:no-repeat; ">
         
          <div id="Mainbg" style="height:796px; width:1650px; background-image:url(/Resources/Images/Layouts/CCTV_SILO.jpg); background-repeat:no-repeat;">

                        <%--SILO 본관 옥상 S4--%>           
                        <div style="position:absolute; left:330px; top:640px; cursor:pointer;">
                           <img  id = "CCTV_S4" src="/Resources/Images/Layouts/CCTV/파이_블루_아래쪽.png"  style="height:111px; width:70px;" onclick="OpenCCTV('http://SCCTV04.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S4','파이_바이올렛_아래쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S04');" onmouseout = "ImageChange('CCTV_S4','파이_블루_아래쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--항운노조 휴게실 NU18--%>           
                        <div style="position:absolute; left:120px; top:470px; cursor:pointer;">
                           <img  id = "CCTV_NU18" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:91px; width:130px;" onclick="OpenCCTV('http://TCCTV23.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_NU18','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('T25');" onmouseout = "ImageChange('CCTV_NU18','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--SILO 연안선적장 S7--%>           
                        <div style="position:absolute; left:250px; top:210px; cursor:pointer;">
                           <img  id = "CCTV_S7" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:91px; width:130px;" onclick="OpenCCTV('http://SCCTV07.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S7','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S07');" onmouseout = "ImageChange('CCTV_S7','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                          <%--SILO 잔교 PS-S3--%>           
                        <div style="position:absolute; left:360px; top:100px; cursor:pointer;">
                           <img  id = "CCTV_PS-S3" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:91px; width:130px;" onclick="OpenCCTV('http://SCCTV09.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_PS-S3','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S09');" onmouseout = "ImageChange('CCTV_PS-S3','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>
                        
                        <%--ABC그룹 H/H 상옥 S1 --%>           
                        <div style="position:absolute; left:400px; top:280px; cursor:pointer;">
                           <img  id = "CCTV_S1" src="/Resources/Images/Layouts/CCTV/타원03_아래쪽_블루.png"  style="height:50px; width:400px;" onclick="OpenCCTV('http://SCCTV01.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S1','타원03_아래쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('S01');" onmouseout = "ImageChange('CCTV_S1','타원03_아래쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--SILO 분진망 S2--%>           
                        <div style="position:absolute; left:1290px; top:650px; cursor:pointer;">
                           <img  id = "CCTV_S2" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:91px; width:130px;" onclick="OpenCCTV('http://SCCTV02.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S2','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S02');" onmouseout = "ImageChange('CCTV_S2','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--SILO 분진망 S5--%>           
                        <div style="position:absolute; left:1330px; top:630px; cursor:pointer;">
                           <img  id = "CCTV_S5" src="/Resources/Images/Layouts/CCTV/파이_블루_아래쪽.png"  style="height:79px; width:50px;" onclick="OpenCCTV('http://SCCTV05.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S5','파이_바이올렛_아래쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S05');" onmouseout = "ImageChange('CCTV_S5','파이_블루_아래쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        
                        <%--SILO 분진망 S3--%>           
                        <div style="position:absolute; left:1390px; top:580px; cursor:pointer;">
                           <img  id = "CCTV_S3" src="/Resources/Images/Layouts/CCTV/파이_블루_위쪽.png"  style="height:127px; width:80px;" onclick="OpenCCTV('http://SCCTV03.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S3','파이_바이올렛_위쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S03');" onmouseout = "ImageChange('CCTV_S3','파이_블루_위쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                          <%--장비고 앞 가교 S6--%>           
                        <div style="position:absolute; left:1280px; top:390px; cursor:pointer;">
                           <img  id = "CCTV_S6" src="/Resources/Images/Layouts/CCTV/파이_블루_아래쪽.png"  style="height:79px; width:50px;" onclick="OpenCCTV('http://SCCTV06.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S6','파이_바이올렛_아래쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S06');" onmouseout = "ImageChange('CCTV_S6','파이_블루_아래쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        
                         <%--T5경계 PS-S1--%>           
                        <div style="position:absolute; left:1320px; top:210px; cursor:pointer;">
                           <img  id = "CCTV_PS-S1" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:91px; width:130px;" onclick="OpenCCTV('http://SCCTV08.taeyoung.co.kr');" 
                                  onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_PS-S1','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S08');" onmouseout = "ImageChange('CCTV_PS-S1','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                         <%--해안단지 사무실 PS-S4--%>           
                        <div style="position:absolute; left:1px; top:210px; cursor:pointer;">
                           <img  id = "CCTV_PS-S4" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:91px; width:130px;" onclick="OpenCCTV('http://SCCTV10.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_PS-S4','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S10');" onmouseout = "ImageChange('CCTV_PS-S4','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--SILO 정문--%>           
                        <div style="position:absolute; left:365px; top:680px; cursor:pointer;">
                           <img  id = "CCTV_S11" src="/Resources/Images/Layouts/CCTV/타원02_아래쪽_블루.png"  style="height:91px; width:100px;" onclick="OpenCCTV('http://SCCTV11.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S11','타원02_아래쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('S11');" onmouseout = "ImageChange('CCTV_S11','타원02_아래쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--부원료창고 CCP 옆--%>           
                        <div style="position:absolute; left:350px; top:480px; cursor:pointer;">
                           <img  id = "CCTV_S13" src="/Resources/Images/Layouts/CCTV/타원02_왼쪽_블루.png"  style="height:70px; width:100px;" onclick="OpenCCTV('http://SCCTV13.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S13','타원02_왼쪽_바이올렛'); OpenSubWin('winToolTip'); WinCCTV_DspText('S13');" onmouseout = "ImageChange('CCTV_S13','타원02_왼쪽_블루'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--부원료창고 해변 측--%>          
                        <div style="position:absolute; left:360px; top:255px; cursor:pointer;">
                           <img  id = "CCTV_S14" src="/Resources/Images/Layouts/CCTV/파이_블루_왼쪽.png"  style="height:75px; width:100px;" onclick="OpenCCTV('http://SCCTV14.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S14','파이_바이올렛_왼쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S14');" onmouseout = "ImageChange('CCTV_S14','파이_블루_왼쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--SILO 소화실 옥상--%>           
                        <div style="position:absolute; left:1245px; top:475px; cursor:pointer;">
                           <img  id = "CCTV_S15" src="/Resources/Images/Layouts/CCTV/파이_블루_오른쪽.png"  style="height:65px; width:100px;" onclick="OpenCCTV('http://SCCTV15.taeyoung.co.kr');" 
                               onmousemove="WinLocation();"  onmouseover = "ImageChange('CCTV_S15','파이_바이올렛_오른쪽'); OpenSubWin('winToolTip'); WinCCTV_DspText('S15');" onmouseout = "ImageChange('CCTV_S15','파이_블루_오른쪽'); CloseSubWin('winToolTip'); " />
                        </div>

                        <%--툴팁 박스--%>           
                        <div id="winToolTip" class="MonitorSubWin" style="left:96px; top:295px; width:180px; display:none;">
                               <div class="mswHeader">
                                    <div id="winToolTipText"  class="mswTitle"></div>
                               </div>
                        </div>
                        
                    </div>

        </div> 
    </div>
</asp:content>


