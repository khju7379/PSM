<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebFormUpload.aspx.cs" Inherits="TaeYoung.Template.WebFormUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
   <form method="post" action="WebForm2.aspx" enctype="multipart/form-data">

     <b>이름</b>
     <input type="text" size="15" name="name">
     <hr>
     <b>제목</b>
     <input type="text" size="80" name="title">
     <hr>
     <b>글내용</b>
     <br>
     <textarea cols="80" rows="10" name="content"></textarea>
     <hr>
     <b>비밀번호</b>
     <input type="password" size="15" name="password">
     <hr>
     <b>첨부파일</b>
     <input type="file" size="15" name="uploadfile">
     <hr>

  <input type="submit" value="작성완료">
  <input type="button" value="취소">


</form>
</body>
</html>
