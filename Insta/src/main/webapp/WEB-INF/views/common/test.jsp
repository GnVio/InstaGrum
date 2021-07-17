<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>main</title>
	<%@ include file="../common/libList.jsp" %>
	<link rel="stylesheet" href="/css/mainpro.css">
</head>
<body>
<%@ include file="../common/top.jsp" %>
<script>
$(document).ready(function(){

	$("#btn_add").on("click", function(){
	var user_id = $("#hidden_user_id").val();
	var friend_id = $("#hidden_friend_id").val();
	var data = {"user_id":user_id,
				"friend_id":friend_id};
	// 아래 location으로 넘기는 값을 컨트롤러에서 받아와도 되나 int로 선언하여 가져올수없음.
	// 타입을 변경해야 원하는값을 받아올수있음
	data = JSON.stringify(data);
	$.ajax({
		url:"addFriend",
		type:"POST",
		data:data,
		dataType:"json",
		contentType:"application/json; charset=UTF-8",
		async:false,
		success:function(data){
			window.location.replace("/test?user_id="+friend_id);
		},
		error:function(err){
			alert("error");
		}
		});
	});
	
	$("#btn_delete").on("click", function(){
		var user_id = $("#hidden_user_id").val();
		var friend_id = $("#hidden_friend_id").val();
		var data = {"friend_id":friend_id};
		data = JSON.stringify(data);
		$.ajax({
			url:"deleteFriend",
			type:"POST",
			data:data,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			async:false,
			success:function(data){
				window.location.replace("/test?user_id="+friend_id);
			},
			error:function(err){
				alert("error");
			}
			});
		});
	
	
	
});
</script>
        <div class="frame">
            <div class="center">
                  <div class="profile">
                      <div class="image">
                          <img id = "photo" name = "user_pho" src="${user_pho1}" width="150px" height="150px" alt="Jessica Potter">
                      </div>
                      <div class="name" name ="user_id" id = "user_id">${user_id1}</div>
                      <div class="job" name = "user_intro" id = "user_intro">${user_intro1}</div>                    
                    
          			
          			<!-- Foreach문 안에서 when 문이 작동하지 않아 아래와같이 구성함 -->    			
          			<c:choose>
          			<c:when test="${user_id1 eq member.user_id}">
						
    				</c:when>
          			<c:when test="${is_friend eq true}">
						<div class="actions">
						    <button type="button" id = "btn_delete" class="btn_add">친구</button>
						</div>
          			</c:when>
          			<c:when test="${is_friend eq false}">
						<div class="actions">
						    <button type="button" id = "btn_add" class="btn_add">친구추가</button>
						</div>
          			</c:when>

    				<c:otherwise>
    				
    				</c:otherwise>
          			</c:choose>				             
                  </div>
                  
                  <div class="stats">
                      <div class="box">
                          <span class="value">0</span>
                          <span class="parameter">게시글</span>
                  </div>

                  </div>
            </div>
        </div>
		<input type="hidden" id = "hidden_user_id" value ="${member.user_id}">
		<input type="hidden" id = "hidden_friend_id" value ="${user_id1}">
<%-- <%@ include file="../common/bottom.jsp" %> --%>
</body>
</html>