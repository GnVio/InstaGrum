<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Home</title>
		<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function(){		
		// 클릭시 회원가입
		$("#registerBtn").on("click", function(){
			location.href="/signup";
		})
		
		// 클릭시 아이디 찾기
		$("#Btn_findid").on("click", function(){
			location.href="/findid";
		})
		
		// 클릭시 비밀번호 찾기
		$("#Btn_findpw").on("click", function(){
			location.href="/findpw";
		})
		
				// 클릭시 비밀번호 찾기
		$("#logoutBtn").on("click", function(){
			location.href="/logout";
		})
		
	
})
</script>
<body>
<form name='homeForm' method="post" action="/startlogin">
<c:choose>
		<c:when test="${member == null}">
			<div>
				<label for="userId"></label>
				<input type="text" id="user_id" name="user_id">
			</div>
			<div>
				<label for="user_pw"></label>
				<input type="password" id="user_pw" name="user_pw">
			</div>
			<div>
				<button type="submit">로그인</button>
				<button id="registerBtn" type="button">회원가입</button>
			</div>
			<div>
				<button name = "Btn_findid" id="Btn_findid" type="button">아이디 찾기</button>
				<button name = "Btn_findpw" id="Btn_findpw" type="button">비밀번호 찾기</button>
			</div>
		</c:when>
		
<%-- 		<c:otherwise>
			<div>
				<p style="color: blue;">${member.user_id}님 환영 합니다.</p>
				<button id="memberUpdateBtn" type="button">회원정보수정</button>
				<button id="logoutBtn" type="button">로그아웃</button>
				<button type="button" name = "addBtn" id="addBtn">친구추가</button>
			</div>
		</c:otherwise> --%>
</c:choose>
		<c:if test="${msg == false}">
			<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
		</c:if>

	</form>
</body>
</html>