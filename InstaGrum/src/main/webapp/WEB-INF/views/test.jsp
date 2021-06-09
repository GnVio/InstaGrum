<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../views/top.jsp" %>
<script>
$("#btn_w").click(function() {
		//alert("text");
	f_search($("#alpreah_input").val());
});
f_search = function(searchValue){
        	//location.href = "/search?value=" + searchValue;
        	$("#frmInsert").submit();
        };
        </script>
<h1>중앙 파일</h1>
<form action="insert" id="frmInsert"></form>
<input>
<%@ include file="../views/bottom.jsp" %>
</body>
</html>