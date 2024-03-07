<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="TaeYoung.Portal.Test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="/Resources/Framework/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-migrate-3.0.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Script/Common.js"></script>
    <script type="text/javascript">
        function SetPDF() {
            PDFViewer("pdf", "/Portal/PSM/PSMImageViewer.aspx");
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%--<object data="/Portal/PSM/PSMImageViewer.aspx" type="application/pdf">
            <p>It appears you don't have Adobe Reader or PDF support in this web browser. 
                <a href="/Portal/PSM/PSMImageViewer.aspx">Click here to download the PDF</a>. Or 
                <a href="http://get.adobe.com/reader/" target="_blank">click here to install Adobe Reader</a>.
            </p>
            <embed src="/Portal/PSM/PSMImageViewer.aspx" type="application/pdf" />
        </object>--%>
        <input type="button" value="보기" onclick="SetPDF();" />
        <div id="pdf" style="width:100%;height:900px;"></div>
    </div>
    </form>
</body>
</html>
