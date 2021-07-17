<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/libList.jsp" %>
	<link rel="stylesheet" href="/css/for_id.css">
    <title>Forgot ID_page</title>
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
/* 					alert("아이디는 " + data.user_id + "입니다."); */
					location.href="/findid_confirm?user_id="+ data.user_id;
				}else{
					alert("이메일형식에 맞게 입력해주세요");
					$('#user_email').focus();
				}
			},
			error:function(err){
				alert("error");
			}
		});
	});
	
	$("#move_login").on("click", function(){
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
    <form action="index.html" method="post" class="loginForm">
        <img src="/img/Gr_logo_png_ver3.png">
        <h5>아이디찾기 페이지입니다<br>
            (가입 당시 입력하신정보를 입력해주세요)
        </h5>
        <div class="For_id_Form">
            <input type="email" id="user_email" name="user_email" class="txt_for_email" placeholder="이메일 주소">
        </div>
        <button type="button" name = "findBtn" id="findBtn" class="btn_find">
            아이디 찾기 
        </button>
    <hr>
        <div class="bottomText">
            <h4>다른 도움이 필요하신가요?</h4>
            <br>
            <a class="link_color" name = "search_id" id="search_id">비밀번호찾기</a>
            <a class="link_color" id="move_login">로그인</a>
            <a class="link_color" name = "singup" id="singup">회원가입</a>  
        </div>
        <footer class="foot_text">
            <div class="foot">
                Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
            </div>
        </footer>
    </form>
</body>
</html>