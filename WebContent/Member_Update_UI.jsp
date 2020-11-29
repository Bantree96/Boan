<!--  
	성명 : 남지원 
	학번 : 201545047
 -->
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="index.css" />
<script
  src="https://code.jquery.com/jquery-3.5.1.slim.js"
  integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM="
  crossorigin="anonymous"></script>
</head>
<body>
<script type="text/javascript">

// 비밀번호 유효성 검사
function signCheck(){
	var pwd1=$("#inputPW").val(); 
	var passwdCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*-./]).{8,16}$/);
	
	// 비밀번호 수정 없음
	if(pwd1==""){
		return true;
	}
	
	// 비밀번호 수정됐을때 유효성 검사
	if(!passwdCheck.test(pwd1)){
		alert("비밀번호는 최소 8자이상, \n 영문,숫자,특수 기호를 조합하여 사용해야 합니다.");
		$('#inputPW').focus();
		return false;
	};
};

function back(){
	history.back(); //뒤로가기

}

</script>
	<!-- center -->
	<div class="mx-auto" >
		<!-- card layout -->
		<div class="card">
		<div class="card-header">정보수정</div>
		
		<div class="card-body">  
		<!-- onsubmit : submit눌렀을때 체크 -->
		<form action="Member_Update_Query.jsp" onsubmit="return signCheck()" method="post">
		  <div class="form-group">
		    <label for="inputID">ID</label>
		    <input type="text" class="form-control" id="inputId" name="_id" value=<%= session.getAttribute("__ID") %> readonly="readonly"/>
		  </div>
		  <div class="form-group">
		    <label for="inputPW">Password</label>
		    <input type="password" class="form-control" id="inputPW" name="_pw" />
		    <input type="hidden" name="_pw2" value=<%= session.getAttribute("__PW") %> />
		  	<small id="passwordHelp" class="form-text text-muted"><b>비밀번호를 입력하지 않으면 변경되지 않습니다.</b><br />비밀번호는 최소 8자 이상<br /> 영문,숫자,특수 기호를 조합하여 사용해야 합니다.</small>
		  </div>
		  <hr />
		  <div class="form-group">
		    <label for="inputNAME">이름</label>
		    <input type="text" class="form-control" id="inputNAME" name="_name" value=<%= session.getAttribute("__NAME") %> required="required" />
		  </div>
		  <hr />
		  

		  <a href="main.jsp" class="btn btn-danger">이전</a>
		  <button type="submit" class="btn btn-primary">등록</button>
		</form>
		</div>
		</div>
	</div>
</body>
</html>