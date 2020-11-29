<!--  
	성명 : 남지원 
	학번 : 201545047
 -->
 
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>index</title>
<!--  bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="index.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>

<body>
	<div class="mx-auto">
		<form action="LoginCheck.jsp" class="form-signin" method="post">
			<h1 class="h3 mb-3 font-weight-normal">로그인</h1>
			<label for="username" class="sr-only">ID</label>
			<input type="text" id="username" name="_id" class="form-control mb-2" placeholder="ID" required="required" />
			<label for="password" class="sr-only">Password</label>
			<input type="password" id="password" name="_pw" class="form-control mb-2" placeholder="Password" required="required" />
		
			<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
			<a href="RePW.jsp" class="btn btn-lg btn btn-secondary btn-block text-white">비밀번호 찾기</a>
			
			<hr />
			<a href="Member_Insert_UI.jsp" class="btn btn-lg btn-primary btn-block text-white">회원가입</a>
		</form>
	</div>
	
	
</body>
</html>