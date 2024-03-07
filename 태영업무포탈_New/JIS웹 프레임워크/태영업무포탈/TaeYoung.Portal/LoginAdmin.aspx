<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginAdmin.aspx.cs" Inherits="TaeYoung.Portal.LoginAdmin" %>
<!DOCTYPE html>
<html lang='ko'>
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8" />
    <title>서한그룹 포탈시스템</title>
    <link rel="shortcut icon" type="image/x-icon" href="/Resources/Resources/Images/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="/Resources/Css/Import.css" />
    <link rel="stylesheet" type="text/css" href="/Resources/Css/Control.css" />
    <script type="text/javascript" src="/Resources/Script/Domain.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-migrate-3.0.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/JIS.Control.js"></script>
    <script type="text/javascript">
        var ControlLoad = [];
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
            cmbCompany.TypeName = "Common.OrgChartBiz";
            cmbCompany.MethodName = "GetCompanyCombo2";
            cmbCompany.DataTextField = "COMPANY";
            cmbCompany.DataValueField = "COMPANYCODE";
            cmbCompany.BindList();

            svDEST_Layer.CustomParams({ 'COMPANYCODE': 'KOFCO' });

            cmbCompany.SetValue("KOFCO");
            hdnCompany.SetValue("KOFCO");

            //svDEST.SetValue("C1175");

            cmbVenderID.CallBack = function () {
                $("#hdnVenderID").val(cmbVenderID.GetValue());
            };

            cmbVenderID.TypeName = "Common.OrgChartBiz";
            cmbVenderID.MethodName = "GetVendUser";
            cmbVenderID.DataTextField = "LOGINID_ADD";
            cmbVenderID.DataValueField = "LOGINID_ADD";
            var ht = new Object();
            ht["COMPANYCODE"] = cmbCompany.GetValue();
            ht["LOGINID"] = svDEST.GetValue();

            cmbVenderID.Params(ht);
            cmbVenderID.BindList();



            svDEST_Layer.fnOnViewClick = function () {
                //$("#txtUserID2").val(svDEST.GetValue());
                //cmbVenderID.
                cmbVenderID.TypeName = "Common.OrgChartBiz";
                cmbVenderID.MethodName = "GetVendUser";
                cmbVenderID.DataTextField = "LOGINID_ADD";
                cmbVenderID.DataValueField = "LOGINID_ADD";
                var ht = new Object();
                ht["COMPANYCODE"] = cmbCompany.GetValue();
                ht["LOGINID"] = svDEST.GetValue();

                cmbVenderID.Params(ht);
                cmbVenderID.BindList();
            };
        });

        function fnCompany_Change() {
            hdnCompany.SetValue(cmbCompany.GetValue());
            svDEST_Layer.CustomParams({ 'COMPANYCODE': cmbCompany.GetValue() });
        }

        function cmbVenderID_Changed() {
            $("#hdnVenderID").val(cmbVenderID.GetValue());
        }

        $(document).ready(function () {
            initText();
            $(".login_id").click(function () {
                initText();
                $(this).css("background", "#FFFFFF url(/Resources/Images/input_text_write_id.png) no-repeat 0px 50%");
            }).blur(initText);
            $(".login_pwd").click(function () {
                initText();
                $(this).css("background", "#FFFFFF url(/Resources/Images/input_text_write_pwd.png) no-repeat 0px 50%");
            }).blur(initText);
            $(".login_id").focus();
        });

        function initText() {
            if ($(".login_id").val() == "") $(".login_id").css("background", "#FFFFFF url(/Resources/Images/input_text_id.png) no-repeat 0px 50%");
            if ($(".login_pwd").val() == "") $(".login_pwd").css("background", "#FFFFFF url(/Resources/Images/input_text_pwd.png) no-repeat 0px 50%");
        }
    </script>
</head>
<body id="wrapper">
    <form id="form1" runat="server">
    <div style="display:none;">
        <Ctl:TextBox ID="hdnCompany" runat="server"></Ctl:TextBox>
    </div>
    <div style="position:absolute; background:white;z-index:190000;top:30px;left:100px;padding:10px;">
        <div>
            <asp:TextBox ID="txtUserID" runat="server" Width="140" onkeyup="txtUserID_KeyUp();">4060125</asp:TextBox>
                    
            <asp:Button ID="btnLogin" runat="server" Width="100" Text="로그인" OnClick="btnLogin_Click" ClientIDMode="Static" />
        </div>
        <div>
            <Ctl:Combo ID="cmbCompany" runat="server" OnChange="fnCompany_Change();"></Ctl:Combo>
            <Ctl:SearchView ID="svDEST" runat="server" TypeName="Common.OrgChartBiz" MethodName="GetVendList2">
                <Ctl:SearchViewField DataField="VENDCD" TextField="VENDCD" Description="업체번호" Hidden="false" Width="80" TextBox="true" Default="true" runat="server" />
                <Ctl:SearchViewField DataField="VENDNAME" TextField="VENDNAME" Description="업체명" Hidden="false" Width="150" TextBox="true" runat="server" />
                <Ctl:SearchViewField DataField="COMPANYCODE" TextField="COMPANYCODE" Description="법인" Hidden="true" Width="100" TextBox="false" runat="server" />
            </Ctl:SearchView>
            <Ctl:Combo ID="cmbVenderID" runat="Server" OnChange="cmbVenderID_Changed();"></Ctl:Combo>
            <asp:HiddenField ID="hdnVenderID" runat="server" />
            <asp:Button ID="btnLogin2" runat="server" Width="100" Text="로그인" OnClick="btnLogin_Click2" ClientIDMode="Static" />
        </div>
    </div>

    <!--로그인시작-->
   <div id="login_body">
   
      <div id="login_copy"></div>
   
      <!--로그인박스시작-->
      <div id="login_bx">
         
         <!--로그인폼시작-->
         <div id="login_form">
         	<div id="logo">Global Portal System</div>
         	
            <div id="write">
               <input type="text" id="txt_login_id" name="" class="login_id" title="" value="" runat="server" />
               <input type="password" id="txt_login_pw" name="" class="login_pwd" title="" value="" runat="server" />
               
               <div id="remember_bx">
	            	<input type="checkbox" id="remember" runat="server">
	               <label for="remember"></label>
	               &nbsp;&nbsp;Remember Me
	            </div> 
	            <asp:LinkButton ID="btn_login" ClientIDMode="Static" runat="server" 
                    onclick="btn_login_Click">LOGIN</asp:LinkButton>
	            <%--<a href="#" id="btn_login">LOGIN</a>  --%>
            </div>
         </div>
         <!--//로그인폼끝-->
         
         <div id="copyright">Copyright 2017 SEOHAN All rights reserved </div>
         
      </div>
      <!--//로그인박스끝-->
   
   </div>
   <!--//로그인끝-->


    <div id="Search_dView" style="position: absolute; display: none; z-index: 99; height: 240px; padding:20px;border: 2px solid rgb(125, 140, 220); background-color:White;box-shadow: 0px 0px 10px #000000; -moz-box-shadow: 0px 0px 10px #000000; -webkit-box-shadow: 0px 0px 10px #000000;">
		<iframe id="Search_iView" name="Search_iView" height="240" src="/Resources/Framework/SearchViewCommon.html"
			frameborder="0" scrolling="no"></iframe>
    </div>
    </form>
</body>
</html>
