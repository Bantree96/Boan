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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<script>
function repw(){
	$.ajax({
		url:"dbGet.jsp",
	    type:"POST",
	    
	    data:{
	           "id":$('#inputID').val(),
	           "name":$('#inputNAME').val()
	    },
	    success:function(data){	// data = return��
	    	if(data!=0){
	    		$("#inputPW").val($.trim(data));
	    	} else {
	    		$("#inputPW").val("������ ��ġ���� �ʽ��ϴ�.");
	    	}
	    },
	})	 
};

</script>
	<!-- center -->
	<div class="mx-auto" >
		<!-- card layout -->
		<div class="card">
		<div class="card-header">��й�ȣ ã��</div>
		
		<div class="card-body">  
		<!-- onsubmit : submit�������� üũ -->
		
		  <div class="form-group">
		    <label for="inputID">ID</label>
		    <input type="text" class="form-control" id="inputID" name="_id" required="required"/>
		  </div>
		  <div class="form-group">
		    <label for="inputNAME">�̸�</label>
		    <input type="text" class="form-control" id="inputNAME" name="_name" required="required" />
		  </div>
		  <button class="btn btn-primary btn-block" onclick="repw()">��й�ȣ ã��</button>
		  <hr />
		  <div class="form-group">
		    <label for="inputPW">Password</label>
		    <input type="text" class="form-control" id="inputPW" name="_pw" readonly="readonly" />
		  	<small id="passwordHelp" class="form-text text-muted">������ �ӽ� ��й�ȣ�� �α����� �����մϴ�.</small>
		  </div>
		  
		  <a href="index.jsp" class="btn btn-primary">����</a>

		</div>
		</div>
	</div>
</body>
</html>