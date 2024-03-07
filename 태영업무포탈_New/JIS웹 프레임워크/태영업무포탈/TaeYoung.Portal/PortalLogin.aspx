<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PortalLogin.aspx.cs" Inherits="TaeYoung.Portal.PortalLogin" %>
<!DOCTYPE html>
<html lang='ko'>
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8" />
    <title>태영인더스트리 통합정보 시스템</title>
    <link rel="shortcut icon" type="image/x-icon" href="/Resources/Resources/Images/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="/Resources/Css/Import.css" />
    <link rel="stylesheet" type="text/css" href="/Resources/Css/Control.css" />
    <script type="text/javascript" src="/Resources/Script/Domain.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-migrate-3.0.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/JIS.Control.js"></script>
    <script type="text/javascript" src="/Resources/Script/Common.js"></script>
    <script type="text/javascript">

        var ControlLoad = [];


        function OnLoad() {

            
//            if (getCookie("memo") != "no") {
//                fn_OpenPop("OpenPopup.htm", 490, 620);
//            }

            
               // fn_OpenPop("OpenPopup.htm", 490, 620);
            
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

        function txtUserID_KeyUp() {
            //alert();
            if (event.keyCode == 13) {
                $("#btnLogin").click();
            }
        }
        function txtPassword_KeyUp() {
            //alert();
            if (event.keyCode == 13) {
                $("#btnLogin").click();
            }
        }
        $(document).ready(function () {
            $("#login_body").height($("body").height());

            $("#txt_login_id").val(readCookie("LOGIN_ID"));

            initText();
            $(".login_id").click(function () {
                initText();
                $(this).css("background", "#FFFFFF");
            }).blur(initText);
            $(".login_pwd").click(function () {
                initText();
                $(this).css("background", "#FFFFFF");
            }).blur(initText);
            $(".login_id").focus();

            if ($("#txt_login_id").val() != "") {
                $(".login_id").css("background", "#FFFFFF");
                $(".login_pwd").focus();
                $("#remember").prop("checked", true);
                $("#enremember").prop("checked", false);
            }
        });

        function initText() {

            if ($(".login_id").val() == "") $(".login_id").css("background", "#FFFFFF url(/Resources/Images/input_text_write_id.png) no-repeat 10px 50%");
            if ($(".login_pwd").val() == "") $(".login_pwd").css("background", "#FFFFFF url(/Resources/Images/input_text_write_pwd.png) no-repeat 10px 50%");
        }

        function btn_login_Click() {
            if ($("#txt_login_id").val() == "") {
                alert("아이디를 입력하세요");
                return false;
            }
            else if ($("#txt_login_pw").val() == "") {
                alert("비밀번호를 입력하세요");
                return false;
            }
            
            var tmpInterval = 0;
            if ($("#remember").is(":checked")) {
                tmpInterval = 30;
            }

            createCookie("LOGIN_ID", $("#txt_login_id").val(), tmpInterval);

            return true;
        }
    </script>
</head>
<body id="wrapper">
    <form id="form1" runat="server">
   

    <!--로그인시작-->
      <div id="login_body">        
   
         <!--로그인박스시작-->
         <div id="login_bx">
               
            <div id="logo" ></div>
            
            <div id="login_copy">
               태영인더스트리 통합정보 시스템<br/>
               <span>Create future value for customer</span> 
            </div>
         
            <!--로그인폼시작-->
            <div id="login_form">               
         	
               <ul id="write">
               
                  <li>Login</li>  
                  
                  <li>
                     <p><input type="text" id="txt_login_id" name="" class="login_id" title="" value="" runat="server" /></p>
                     <p><input type="password" id="txt_login_pw" name="" class="login_pwd" title="" value="" runat="server" /></p>
                     <table>
                        <colgroup>
                           <col width="100px" />
                           <col width="10px" />
                           <col width="100px" />
                        </colgroup>
                        <tr>
                          <td>
                              <div id="remember_bx">
                                <input type="checkbox" id="remember" runat="server">
                                 <label for="remember"></label>
                             </div>    
                          </td>                          
                          <td>
                             <div id="enremember_bx">
                               <input type="checkbox" id="enremember" runat="server">
                               <label for="enremember"></label>
                             </div>     
                          </td>
                        </tr>
                     </table>                                     
                  </li>               
                  
                  <li>
                     <asp:LinkButton ID="btn_login" ClientIDMode="Static" runat="server" onclick="btn_login_Click" OnClientClick="return btn_login_Click();"><img src="/Resources/Images/btn_login.png" alt="" /></asp:LinkButton>
                  </li>
               </ul>
               
            </div>

            <div id="idpasswrite">
               ID/PW는 대문자로 입력해주시기 바랍니다.
            </div>
            <!--//로그인폼끝-->
            
          <%--  <ul id="login_icon">
               <li></li>
               <li></li>
               <li></li>
            </ul>--%>
            
            <div id="copyright">Copyright 2021 by TAEYOUNG. All rights reserved.</div>
        </div>
        <!--//로그인박스끝-->   
    </div>
    <!--//로그인끝-->
    <div style="display:none;"><Ctl:TextBox ID="hdnCompany2" runat="server"></Ctl:TextBox></div>

    <div id="Search_dView" style="position: absolute; display: none; z-index: 99; height: 240px; padding:20px;border: 2px solid rgb(125, 140, 220); background-color:White;box-shadow: 0px 0px 10px #000000; -moz-box-shadow: 0px 0px 10px #000000; -webkit-box-shadow: 0px 0px 10px #000000;">
		<iframe id="Search_iView" name="Search_iView" height="240" src="/Resources/Framework/SearchViewCommon.html"
			frameborder="0" scrolling="no"></iframe>
    </div>
    </form>
</body>
</html>
