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
<title>ȸ������ ����</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="index.css" />
<script
  src="https://code.jquery.com/jquery-3.5.1.slim.js"
  integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM="
  crossorigin="anonymous"></script>
</head>
<body>
<script type="text/javascript">

// ��й�ȣ ��ȿ�� �˻�
function signCheck(){
	var pwd1=$("#inputPW").val(); 
	var passwdCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*-./]).{8,16}$/);
	
	// ��й�ȣ ���� ����
	if(pwd1==""){
		return true;
	}
	
	// ��й�ȣ ���������� ��ȿ�� �˻�
	if(!passwdCheck.test(pwd1)){
		alert("����, ����, Ư�����ڰ� ���յǾ��մϴ�.");
		$('#inputPW').focus();
		return false;
	};
};

function back(){
	history.back(); //�ڷΰ���

}

</script>
	<!-- center -->
	<div class="mx-auto" >
		<!-- card layout -->
		<div class="card">
		<div class="card-header">��������</div>
		
		<div class="card-body">  
		<!-- onsubmit : submit�������� üũ -->
		<form action="Member_Update_Query.jsp" onsubmit="return signCheck()" method="post">
		  <div class="form-group">
		    <label for="inputID">ID</label>
		    <input type="text" class="form-control" id="inputId" name="_id" value=<%= session.getAttribute("__ID") %> readonly="readonly"/>
		  </div>
		  <div class="form-group">
		    <label for="inputPW">Password</label>
		    <input type="password" class="form-control" id="inputPW" name="_pw" />
		    <input type="hidden" name="_pw2" value=<%= session.getAttribute("__PW") %> />
		  	<small id="passwordHelp" class="form-text text-muted"><b>��й�ȣ�� �Է����� ������ ������� �ʽ��ϴ�.</b><br />��й�ȣ�� �ּ� 8�� �̻�<br /> ����,����,Ư�� ��ȣ�� �����Ͽ� ����ؾ� �մϴ�.</small>
		  </div>
		  <hr />
		  <div class="form-group">
		    <label for="inputNAME">�̸�</label>
		    <input type="text" class="form-control" id="inputNAME" name="_name" value=<%= session.getAttribute("__NAME") %> required="required" />
		  </div>
		  <hr />
		  

		  <a href="main.jsp" class="btn btn-danger">����</a>
		  <button type="submit" class="btn btn-primary">���</button>
		</form>
		</div>
		</div>
	</div>
</body>
</html>