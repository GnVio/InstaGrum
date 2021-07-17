<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/libList.jsp" %>
    <link rel="stylesheet" href="/css/for_pass.css">
</head>
    <title>Forgot ID_page</title>
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
/*  				alert(JSON.stringify(data.result)); */
 				if(data.result.findPw != null){
					/* alert("비밀번호는 " + data.result.findPw + "입니다."); */
					/* location.href="/login" */;
					location.href="/findpw_confirm?user_pw="+ data.result.findPw;
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
<body>
    <form action="index.html" method="post" class="loginForm">
        <img src="/img/Gr_logo_png_ver3.png">
        <h5>비밀번호 찾기 페이지입니다<br>
            (가입 당시 입력하신 정보를 입력해주세요)
        </h5>
        <div class="For_pass_Form">
            <input type="email"  type="text" id="user_id" name="user_id" class="txt_for_id" placeholder="ID" required>
        </div>
        <div class="For_pass_Form">
            <input type="email" id="user_email" name="user_email" class="txt_for_email" placeholder="E-mail" required>
        </div>
        <a><button type="button" name = "findBtn" id="findBtn" class="btn_chan">
            비밀번호 찾기
        </button>
        </a>
    <hr>
        <div class="bottomText">
            <h4>다른 도움이 필요하신가요?</h4>
            <br>
            <a class="link_color" id = "cancel" href="/login">로그인</a>  
        </div>
        <footer class="foot_text">
            <div class="foot">
                Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
            </div>
        </footer>
    </form>
</body>
</html>