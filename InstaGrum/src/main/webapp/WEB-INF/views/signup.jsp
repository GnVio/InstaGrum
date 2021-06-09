<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    #center {
        text-align: center;
    }
</style>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function() {
	$("#reset").click(function() {
        $('#id').val("");
        $('#pass').val("");
        $('#email').val("");g
        $('#address').val("");
        $('#number').val("");
	});
});
</script>
<body>
	    <div id = "center">
        <p>아이디 : <input id="id">
         <input type ="button" id = "overap" value = "중복확인"> </p>

        <p>비밀번호 : <input id="pass" placeholder = "8~16글자(특수문자 X)">
        <input type ="button" id = "confirm" value = "확인"></p>

        <p>email : <input id="email"></p>
        <p>주소 : <input id="address"></p>
        <p>전화번호 : <input id="number" placeholder = "숫자만 입력하세요(-제외)"></p>        
        <p>
            성별 : 
            <select id="gender" aria-label="성별">
                <option value selected>선택</option>
                <option value="남자">남자</option>
                <option value="여자">여자</option>
            </select>
        </p>
        <p>
            <button id = "save">저장</button>
            <input type="button" id="reset" value="초기화">
        </p>

    </div>
    <div id = "center">
        <label id="text"></label>
    </div>
</body>
</html>