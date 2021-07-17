<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/libList.jsp" %>
	<link rel="stylesheet" href="/css/login.css">
    <title>InstaGrum Login_page</title>
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
		
		
		
	});
</script>
</head>
<body width="100%" height="100%">
<c:choose>
	<c:when test="${member == null}">
	    <form action="/startlogin" method="post" class="loginForm">
        <img src="/img/Gr_logo_png_ver3.png">
        <div class="idForm">
            <input type="text" class="txt_id" id="user_id" name="user_id" placeholder="아이디">
        </div>
        <div class="passForm">
            <input type="password" class="txt_pw" id="user_pw" name="user_pw" placeholder="비밀번호">
        </div>
        <a href="main.html"><button type="submit" class="btn_login">
            로그인
        </button>
        </a>
    <hr>
        <div class="bottomText">
            <h4>도움이 필요하신가요?</h4>
            <br>
            <a class="link_color" name = "Btn_findid" id="Btn_findid">아이디찾기</a>  
            <a class="link_color" name = "Btn_findpw" id="Btn_findpw">비밀번호찾기</a>  
            <a class="link_color" id="registerBtn">회원가입</a>  
        </div>
        <footer class="foot_text">
            <div class="foot">
                Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
            </div>
        </footer>
       </form>
      </c:when>
    </c:choose>
    		<c:if test="${msg == false}">
			<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
			</c:if>

</body>
</html>