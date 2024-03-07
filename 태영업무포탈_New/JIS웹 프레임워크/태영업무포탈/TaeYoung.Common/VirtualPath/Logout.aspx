<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="TaeYoung.Common.VirtualPath.Logout" ViewStateMode="Disabled" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang='ko'>
<head>
<meta charset="utf-8" />
<title></title>
<link rel="shortcut icon" type="image/x-icon" href="/Resources/Images/favicon.ico" />
<script type="text/javascript">
	function logout() {
		parent.LogOutDir('<%= Path %>');
	}
</script>
</head>
<body onload="logout();">
    <form id="form1" runat="server">
	
    </form>
</body>
</html>
