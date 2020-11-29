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
	    success:function(data){	// data = return값
	    	if(data!=0){
	    		$("#inputPW").val($.trim(data));
	    	} else {
	    		$("#inputPW").val("정보가 일치하지 않습니다.");
	    	}
	    }
	})	 
};

</script>
	<!-- center -->
	<div class="mx-auto" >
		<!-- card layout -->
		<div class="card">
		<div class="card-header">비밀번호 찾기</div>
		
		<div class="card-body">  
		<!-- onsubmit : submit눌렀을때 체크 -->
		
		  <div class="form-group">
		    <label for="inputID">ID</label>
		    <input type="text" class="form-control" id="inputID" name="_id" required="required"/>
		  </div>
		  <div class="form-group">
		    <label for="inputNAME">이름</label>
		    <input type="text" class="form-control" id="inputNAME" name="_name" required="required" />
		  </div>
		  <button class="btn btn-primary btn-block" onclick="repw()">비밀번호 찾기</button>
		  <hr />
		  <div class="form-group">
		    <label for="inputPW">Password</label>
		    <input type="text" class="form-control" id="inputPW" name="_pw" readonly="readonly" />
		  	<small id="passwordHelp" class="form-text text-muted">나오는 임시 비밀번호로 로그인이 가능합니다.</small>
		  </div>
		  
		  <a href="index.jsp" class="btn btn-primary">이전</a>

		</div>
		</div>
	</div>
</body>
</html>