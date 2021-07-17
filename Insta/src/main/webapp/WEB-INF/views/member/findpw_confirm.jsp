<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<%@ include file="../common/libList.jsp" %>
	<link rel="stylesheet" href="/css/find_idpass.css">
    <title>Find ID_page</title>
    </head>
<body width="100%" height="100%">
    <form action="index.html" method="post" class="loginForm">
        <img src="/img/Gr_logo_png_ver3.png">

        <div class="find_id_Form">
            <h3>입력하신 정보로 찾은 비밀번호는
            <input type="text" value = "${find_pw}" readonly="readonly" class="txt_find_id" placeholder="찾은 비밀번호">
            입니다.</h3>
            <h4>(다시 로그인 해주십시오)</h4>
        </div>        
    <hr>
        <div class="bottomText">
            <h4>다른 도움이 필요하십니까?</h4>
            <br>
            <a class="link_color" href="/login">로그인화면으로이동</a>  
        </div>
        <footer class="foot_text">
            <div class="foot">
                Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
            </div>
        </footer>
    </form>
</body>
</html>