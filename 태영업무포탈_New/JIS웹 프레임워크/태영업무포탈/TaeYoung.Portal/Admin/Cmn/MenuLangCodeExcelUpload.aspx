<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuLangCodeExcelUpload.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.MenuLangCodeExcelUpload" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:FileUpload ID="upExcel" runat="server" /><asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" />
    </div>
    </form>
</body>
</html>