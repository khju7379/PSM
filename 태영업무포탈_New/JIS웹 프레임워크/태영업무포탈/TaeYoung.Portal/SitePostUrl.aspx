<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SitePostUrl.aspx.cs" Inherits="TaeYoung.Portal.SitePostUrl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>  
     <script type="text/javascript">
            function OnLoad() {
                document.getElementById("frm").submit();
            }
            
        </script>
</head>
<body onload="OnLoad();">
        <form id="frm" runat="server">
            <div id="frm_Control" runat="server" style="display:none;"></div>
        </form>
    </body>
</html>

