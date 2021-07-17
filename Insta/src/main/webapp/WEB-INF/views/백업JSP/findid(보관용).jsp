<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
    var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	$("#findBtn").on("click", function(){
		//alert($("#saveid").val());
		
		 if($('#user_email').val() == ""){
	            alert("이메일을 입력하지 않았습니다");
	            $('#user_email').focus();
	            return false;
	        }

	        if(!getMail.test($('#user_email').val())){
	            alert('이메일형식에 맞게 입력해주세요')
	            $('#user_email').val("");
	            $('#user_email').focus();
	            return false;
	        }
	        
	        
		var user_email = $("#user_email").val();
		var data = {"user_email":user_email};
		
		data = JSON.stringify(data);
		$.ajax({
			url:"finddoit",
			type:"POST",
			data:data,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			async:false,
			success:function(data){
				if(data.user_id != "notExist"){
					alert("아이디는 " + data.user_id + "입니다.");
					location.href="/findid_confirm?user_id="+ data.user_id;
				}else{
					alert("이메일이 맞지 않습니다.");
					$('#user_email').focus();
				}
			},
			error:function(err){
				alert("error");
			}
		});
	});
	
	$("#cancel").on("click", function(){
		location.href="/login";
	});
	
	$("#search_id").on("click", function(){
		location.href="/findpw";
	});
	
	$("#singup").on("click", function(){
		location.href="/signup";
	});
});
</script>
<body>
<%-- 	<input type ="hidden" id ="saveid" value ="${user_id}">	 --%>			
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>아이디 찾기</h3>
			</div>
			<div>
				<p>
					<label>Email</label>
					<input class="w3-input" type="text" id="user_email" name="user_email" required>
				</p>
				<p class="w3-center">
					<button type="button" name = "findBtn" id="findBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
					<button type="button" name = "search_id" id="search_id" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">비밀번호 찾기</button>
					<button type="button" name = "singup" id="singup" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">회원가입</button>				
					<button type="button" id = "cancel" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
				</p>
			</div>
		</div>
	</div>
</body>
</html>