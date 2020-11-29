<!--  
	성명 : 남지원 
	학번 : 201545047
 -->
 
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>main</title>
<!--  bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="index.css" />
</head>

<body>

	<div class="mx-auto">
		<%
		out.println(session.getAttribute("__NAME")+"님 환영합니다.");
		%>
		<div class="form-group" style="width:200px">
		  <a href="Member_Update_UI.jsp" class="btn btn-lg btn-primary btn-block text-white">정보수정</a>
			<a href="Logout.jsp" class="btn btn-lg btn-danger btn-block text-white">로그아웃</a>
		</div>
		
	</div>
</body>
</html>