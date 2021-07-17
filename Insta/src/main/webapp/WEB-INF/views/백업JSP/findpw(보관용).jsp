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
<script>
$(document).ready(function(){
    var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
    var getCheck= RegExp(/^[A-Za-z0-9+]{4,12}$/);
    
 	$("#findBtn").on("click", function(){
		if($('#user_id').val() == ""){
			alert("아이디를 입력하지 않았습니다");
			$('#user_id').focus();
			return false;
		}
		      
		if(!getCheck.test($("#user_id").val())){
			alert("아이디 형식에 맞게 입력해주세요 (영문+숫자 혼합 4~12자리)");
			$("#user_id").val("");
			$("#user_id").focus();
			return false;
		}
		      
		if($('#user_email').val() == ""){
			alert("이메일을 입력하지 않았습니다");
			$('#user_email').focus();
			return false;
		}
		
		if(!getMail.test($('#user_email').val())){
			alert('이메일형식에 맞게 입력해주세요');
			$('#user_email').val("");
			$('#user_email').focus();
			return false;
		}
       
	        
 		var user_email = $("#user_email").val();
		var user_id = $("#user_id").val();
		var data = {"user_id":user_id, "user_email":user_email};
		
		data = JSON.stringify(data);
		$.ajax({
			url:"findpwdoit",
			type:"POST",
			data:data,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			async:false,
			success:function(data){
/* 				alert(JSON.stringify(data.result)); */
 				if(data.result.findPw != null){
/* 					alert("비밀번호는 " + data.result.findPw + "입니다."); */
					location.href="/login";
				}else {
					alert("일치하지 않는 정보입니다.");
/* 					if(data.result.countEmail == 0 && data.result.countId == 0){
						alert("없는 ID와 Email 입니다.");
					}
					
					if(data.result.countEmail == 0 && data.result.countId == 1){
						alert("없는 Email입니다.");
					}
					
					if(data.result.countEmail == 1 && data.result.countId == 0){
						alert("없는 ID입니다.");
					}
					if(data.result.countEmail == 1 && data.result.countId == 1 && data.result.findPw == null){
						alert("ID와 Email이 일치하지않습니다.");
					} */
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
});
</script>
</head>
<body>
	<input type ="hidden" id ="saveid" value ="${user_id}">				
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>비밀번호 찾기</h3>
			</div>
			<div>
				<p>
					<label>ID</label>
					<input class="w3-input" type="text" id="user_id" name="user_id" required>
					<label>Email</label>
					<input class="w3-input" type="text" id="user_email" name="user_email" required>
				</p>
				<p class="w3-center">
					<button type="button" name = "findBtn" id="findBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
					<button type="button" id = "cancel" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
				</p>
			</div>
		</div>
	</div>
</body>
</html>