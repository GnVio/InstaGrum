<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/libList.jsp" %>
<link rel="stylesheet" href="/css/chan_info.css">
    <title>InstaGrum Main_page</title>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		// 취소
		$("#cancle").on("click", function(){
			location.href = "/login";	    
		})
		
		$("#submit").on("click", function(){
			alert("수정완료 되었습니다.") 
			setTimeout(3000); 
		})

		
		$("#imageDelete").on("click", function(){
			$("#gdsImg").val("");
			$("#user_pho_path2").val("/img/기본이미지.jpg");
			$(".select_img").attr("src","/img/기본이미지.jpg"); 
		})
		
		  $("#gdsImg").change(function(){
			 if(this.files && this.files[0]) {
			   var reader = new FileReader;
			    reader.onload = function(data) {
			     $(".select_img").attr("src", data.target.result);        
			   }
			    reader.readAsDataURL(this.files[0]);
			   }
			});
});
</script>
<%@ include file="../common/top.jsp" %>
<body>
<form action="/memberUpdate" method="post" enctype="multipart/form-data">
    <div class="container">
        <!-- 회원정보 수정 -->
        <h3 class="chan_profile">회원정보수정</h3>
        <div class="frame2">
            <div class="center2">

                  <!-- 회원정보수정_ 왼쪽 -->
                  <div class="profile2">
                      <div class="image2">
                      <input type = "hidden" name = "user_pho_path2" id="user_pho_path2" value ="${member.user_pho_path}">
						<img class = "select_img" id="user_pho_path3" src="${member.user_pho_path}" style="width:200px; height:200px; object-fit:contain;">
                      </div>

                      <div class="actions1">
                        <button type = "button" class="btn_del" id="imageDelete">이미지삭제</button>
                        <input type="file" name="user_pho_path" id ="gdsImg" class="chan_img" accept="image/*">
                      </div>

                      <h4 class="chan_none2">아이디</h4>
                      <input type="text" class="txt_none2" id="user_id" name="user_id" value="${member.user_id}" disabled>
						<input type="hidden" id="user_id1" name="user_id1" value="${member.user_id}">

                      <h4 class="chan_none2">비밀번호</h4>
                      <input type="password" class="txt_none2" id="user_pw" name="user_pw" value="${member.user_pw}" disabled>
                      <input type="hidden" id="user_pw1" name="user_pw1" value="${member.user_pw}">
                      
					  <h4 class="chan_none2">이메일</h4>
                      <input type="email" class="txt_none2" id="user_email" name="user_email" value="${member.user_email}" disabled>
                      <input type="hidden" id="user_email1" name="user_email1" value="${member.user_email}">
                      
                      <h4 class="chan_none2">성별</h4>
                      <input type="text" class="txt_none2" value="${gender}" disabled>
                  </div>
                  
				<!-- 회원정보수정_ 오른쪽 -->
                  <div class="profile3">
                      <h4 class="chan_none2">이름</h4>
                      <input type="text" class="txt_not_none" id="user_name" name="user_name" value="${member.user_name}">

                      <h4 class="chan_none3">전화번호</h4>
                      <input type="tel" class="txt_not_none" id="user_tel" name="user_tel" maxlength="11" value="${member.user_tel}">
                      
					  <h4 class="chan_none3">상태명</h4>
                      <input type="text" class="txt_not_none" id="user_introduce" name="user_introduce" value="${member.user_introduce}">
                                  
                    <div class="actions2">
                        <button class="btn_secc" type="submit" id="submit">회원정보수정</button>
                        <button type = "button" class="btn_delete" id="cancle">수정취소</button>
                      </div> 
                  </div>

            </div>
           
        </div>
        <div class="footer">
            <h1 class="txt_footer" id="footer_write">
                Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
            </h1>
        </div>
    </div>
    </form>
</body>
</html>