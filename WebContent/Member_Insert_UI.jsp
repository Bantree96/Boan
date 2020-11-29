<!--  
	���� : ������ 
	�й� : 201545047
 -->
 
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Member_Insert_UI</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="index.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready(function(){
	
});

// ��й�ȣ ��ȿ�� �˻�
function signCheck(){
	var pwd1=$("#inputPW").val(); 
	var passwdCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*-./]).{8,16}$/);
	
	if(!passwdCheck.test(pwd1)){
		alert("��й�ȣ�� �ּ� 8���̻�, \n ����,����,Ư�� ��ȣ�� �����Ͽ� ����ؾ� �մϴ�.");
		$('#inputPW').focus();
		return false;
	};
};


</script>
	<!-- center -->
	<div class="mx-auto" >
		<!-- card layout -->
		<div class="card">
		<div class="card-header">ȸ������</div>
		
		<div class="card-body">  
		<!-- onsubmit : submit�������� üũ -->
		<form action="Member_Insert_Query.jsp" onsubmit="return signCheck()" method="post">
		  <div class="form-group">
		    <label for="inputID">ID</label>
		    <input type="text" class="form-control" id="inputId" name="_id" required="required"/>
		  </div>
		  <div class="form-group">
		    <label for="inputPW">Password</label>
		    <input type="password" class="form-control" id="inputPW" name="_pw" required="required"/>
		  	<small id="passwordHelp" class="form-text text-muted">��й�ȣ�� �ּ� 8�� �̻�<br /> ����,����,Ư�� ��ȣ�� �����Ͽ� ����ؾ� �մϴ�.</small>
		  </div>
		  <hr />
		  <div class="form-group">
		    <label for="inputNAME">�̸�</label>
		    <input type="text" class="form-control" id="inputNAME" name="_name" required="required" />
		  </div>
		  <hr />
		  <a href="index.jsp" class="btn btn-danger">����</a>
		  <button type="submit" class="btn btn-primary">���</button>
		</form>
		</div>
		</div>
	</div>
</body>
</html>