<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/libList.jsp" %>
	<link rel="stylesheet" href="/css/find_idpass.css">
    <title>Find ID_page</title>
</head>
<body>
    <form method="post" class="loginForm">
        <img src="/img/Gr_logo_png_ver3.png">

        <div class="find_id_Form">
            <h3>입력하신 정보로 찾은 아이디는
            <input type="text" id = "id_confirm" value = "${find_id}" readonly="readonly" class="txt_find_id">
            입니다.</h3>
            <h4>(다시 로그인 해주십시오)</h4>
        </div>        
    <hr>
        <div class="bottomText">
            <h4>다른 도움이 필요하십니까?</h4>
            <br>
            <a class="link_color" href="/login">로그인</a>  
            <a class="link_color" href="/findpw">비밀번호찾기</a>  
        </div>
        <footer class="foot_text">
            <div class="foot">
                Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
            </div>
        </footer>
    </form>
</body>
</html>