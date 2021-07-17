<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/libList.jsp" %>
    <link rel="stylesheet" href="/css/friends_list.css">
	<title>Insert title here</title>
</head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
 $(document).ready(function(){
	 
	$("#select_img").on("click","img.selecct_img1", function(){
		var select_img2 = $(this).attr("data-num")
		
		console.log(select_img2);
		
  		location.href="/mypage?user_id="+ select_img2;
	});
	
});
</script>
<body>
<%@ include file="../common/top.jsp" %>
<div class="container">
        <!-- 친구리스트 -->
        <!-- 프로필 부분 -->
        <h3 class="friends_list">친구리스트</h3>
        <div class="frame2">
            <div class="center2" id="select_img">  
                <c:forEach items="${result}" var="result">
               <div class="friendListBox">
                <!-- 프로필_ 왼쪽 -->
                    <div class="profile2">
                        <div class="image_modify">
                            <img class = "selecct_img1" data-num="${result.user_id}" src="${result.user_pho_path}" width="80" height="80">
                        </div>
                    </div>
                    
                <!-- 프로필_ 오른쪽 -->
                    <div class="profile_info">
                        <input class="name2" value = "${result.user_id}" disabled>
                        <input class="sub_name2" value="${result.user_name}" disabled>
                    </div>
                </div>
                 </c:forEach>
              </div>
        </div>
        <div class="footer">
            <h1 class="txt_footer" id="footer_write">
                Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
            </h1>
        </div>
    </div>
    

<!-- 지우지말고 남겨둘것 -->
<%--  <div class="select_img" id="select_img"> 
<c:forEach items="${result}" var="result">
<input type = "text" value = "${result.user_name}">
<img class = "selecct_img1" data-num="${result.user_id}" src="${result.user_pho_path}" style="width:200px; height:300px; object-fit:contain;">
</c:forEach>
</div>  --%>

</body>
</html>