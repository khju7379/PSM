<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CrossDomain.aspx.cs" Inherits="TaeYoung.WebTemplate.CrossDomain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        document.domain = "tTaeYoung.com";
    </script>
</head>
<body style="width:100%;height:100%;">
    <form id="form1" runat="server">
    <div style="width:100%;height:100%;">
        <iframe id="ifmTest" src="http://ep1.tTaeYoung.com/WebTemplate/Template01.aspx" width="100%" height="800px"></iframe>
    </div>
    </form>
</body>
</html>
