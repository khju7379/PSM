<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrgMapiFrame.aspx.cs" Inherits="TaeYoung.Portal.Common.OrgChart.OrgMapiFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8" />
<title></title>
<style type="text/css">
html{height:100%;}
body{height:100%;}
</style>
</head>
<body style="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
    <form id="form1" runat="server">
        <iframe id="iframe1" src="<%=strOrgmapURL%>" frameborder="0" width="100%" height="500" marginwidth="0" marginheight="0" scrolling="no"></iframe>
    </form>
</body>
</html>
