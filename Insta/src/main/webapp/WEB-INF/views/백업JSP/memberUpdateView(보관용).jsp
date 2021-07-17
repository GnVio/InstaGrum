<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>회원가입</title>
	</head>
<script type="text/javascript">
	$(document).ready(function(){
		// 취소
		$("#cancle").on("click", function(){
			location.href = "/test";	    
		})

		$("#submit").on("click", function(){
			if($("#user_pw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#user_pw").focus();
				return false;
			}
			if($("#user_name").val()==""){
				alert("성명을 입력해주세요.");
				$("#user_name").focus();
				return false;
			}
		});
		
		$("#imageDelete").on("click", function(){
			$("#user_pho_path2").val("");
			$("#photo").attr("src",""); 
		})
		
		  $("#gdsImg").change(function(){
			 if(this.files && this.files[0]) {
			   var reader = new FileReader;
			    reader.onload = function(data) {
			     $(".select_img img").attr("src", data.target.result).width(500);        
			   }
			    reader.readAsDataURL(this.files[0]);
			   }
			});
});
</script>
<body>
<%@ include file="../common/top.jsp" %>
<section id="container">
			<form action="/memberUpdate" id="frmUpdate" method="post" enctype="multipart/form-data">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label>
					<input class="form-control" type="text" id="user_id" name="user_id" value="${member.user_id}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">패스워드</label>
					<input class="form-control" type="password" id="user_pw" name="user_pw" value="${member.user_pw}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">성명</label>
					<input class="form-control" type="text" id="user_name" name="user_name" value="${member.user_name}"/>
				</div>
				
				<div class="form-group has-feedback">
					<label class="control-label" for="userTell">전화번호</label>
					<input class="form-control" type="text" id="user_tel" name="user_tel" value="${member.user_tel}"/>
				</div>
				
				<div class="form-group has-feedback">
					<label class="control-label" for="user_email">이메일</label>
					<input class="form-control" type="email" id="user_email" name="user_email" value="${member.user_email}"/>
				</div>

 				<div class="form-group has-feedback">
					<label class="control-label" for="user_intro">자기소개</label>
					<input class="form-control" type="text" id="user_introduce" name="user_introduce" value="${member.user_introduce}"/>
				</div>
				
        		<p><input type="file" name="user_pho_path" id ="gdsImg"></p>
        		<p><input type = "hidden" name = "user_pho_path2" id="user_pho_path2" value ="${member.user_pho_path}"></p>
 				<div class="select_img"><img id = "photo" src="${member.user_pho_path}" style="width:200px; height:300px; object-fit:contain;">
 				</div>
				
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="submit" id="submit">회원정보수정</button>
					<button type="button" id="imageDelete">이미지 삭제</button>
					<button class="cencle btn btn-danger" type="button" id="cancle">취소</button>
				</div>
			</form>
</section>
</body>
</html>