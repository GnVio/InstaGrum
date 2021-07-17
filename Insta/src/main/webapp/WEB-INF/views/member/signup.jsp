<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/libList.jsp" %>
	<link rel="stylesheet" href="/css/join2.css">
    <title>InstaGrum Join_page</title>
</head>
<script>
$(document).ready(function(){
     // 아이디 유효성 검사[최소글자,최대글자]
    var getCheck= RegExp(/^[A-Za-z0-9+]{4,12}$/);
    // 비밀번호 유효성 검사
    // 영문 숫자 혼합하여 6~20자 이내
    var getPass= RegExp(/^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/);
    // 이름 유효성 검사
    var getName= RegExp(/^[가-힣]+$/);
    // 이메일 유효성 검사
    var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
    // 전화번호 유효성 검사
    var getNumber = RegExp(/^[0-9]{11,11}$/);
	 
	// 아이디 중복검사
	$("#id").keyup(function() {
		var user_id = $("#id").val();
		var data = {"user_id":user_id};
		data = JSON.stringify(data);
		$.ajax({
			url:"checkId",
			type:"POST",
			data:data,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			async:false,
			success:function(data){
				if(data.isResult == 1){
					$('#confirm_text').val("아이디가 중복되었습니다.");
					$("#pass").prop("disabled",true)
				}
				else if(data.isResult == 0){
					$('#confirm_text').val("사용가능한 아이디입니다.");
					 $("#pass").prop("disabled",false);
				}
				
		        if($('#id').val().trim() == ""){
		        	$('#confirm_text').val("아이디를 입력하지 않았습니다");
					$("#pass").prop("disabled",true)
		        }
		        
		        else if(!getCheck.test($("#id").val())){
		        	$('#confirm_text').val("영문+숫자 혼합 4~12자리를 입력해주세요")
					$("#pass").prop("disabled",true)
		        }
				
			},
			error:function(err){
				alert("error");
			}
		});
	});
		
	
	
	// 이메일 중복검사
	$("#email").keyup(function() {        
		var user_email = $("#email").val();
		var data = {"user_email":user_email};
		data = JSON.stringify(data);
		$.ajax({
			url:"checkEmail",
			type:"POST",
			data:data,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			async:false,
			success:function(data){
				if(data.isResult == 1){
					$('#confirm_email').val("이메일이 중복되었습니다.");
					$("#tell").prop("disabled",true);
				}
				else if(data.isResult == 0){
					$('#confirm_email').val("사용가능한 이메일입니다.");
					$("#tell").prop("disabled",false);
				}
				
				if($('#email').val() == ""){
					$('#confirm_email').val("이메일을를 입력하지 않았습니다");
				    $("#tell").prop("disabled",true);
				}
				
				else if(!getMail.test($("#email").val())){
					$('#confirm_email').val("형식에 맞게 입력해주세요 (hyde111@naver.com)");
				    $("#tell").prop("disabled",true);
				}		
			},
			error:function(err){
				alert("error");
			}
		});
	});
	 
	//$("#name").val() != "" || $("#name").val() != null || $("#name").val() != "undifined" || $("#name").val() != undifined)
	// 성별 선택했을때 가입하기 활성화
/* 	 $("#gender").on("change",function(){
		 if($("#gender option:selected").val() == "M" || $("#gender option:selected").val() == "F"
				&& $("#id").val() != ""
 				&& $("#pass").val() != ""
				&& $("#name").val() != ""
				&& $("#email").val() != ""
				&& $("#tell").val() != "")
			{
			 $("#save").prop("disabled",false);
		}
		 if($("#gender option:selected").val() == "선택"){
			 $("#save").prop("disabled",true);
		 }
	 }); */
	
	 // 비밀번호 눌렸을때
	 $("#pass").keyup(function(){
	        if($('#pass').val() == ""){
	        	$('#confirm_pass').val("비밀번호를 입력하지 않았습니다");
				 $("#name").prop("disabled",true);
	        }       
	        else if(!getPass.test($("#pass").val())){
	        	$('#confirm_pass').val("최소6글자 최대 20글자,영문자 + 숫자,특수문자 X");
	            $("#name").prop("disabled",true);
	        }
	        else{
	        	$('#confirm_pass').val("사용가능한 비밀번호 입니다.");
				 $("#name").prop("disabled",false);
	        }

	 });
	 
		// 이름->이메일 활성화
	 $("#name").on("propertychange change keyup paste input", function() {
		 if($("#name").val().toString().length >= 2){
		 	$("#email").prop("disabled",false);
		 }
		 else if($("#name").val().toString().length <= 1){
			 	$("#email").prop("disabled",true);
			 }
		});
	 
	
	//유효성 시작
	$("#save").click(function(){
		
      	//아이디 공백 검사
      	if($("#id").val() == ""){
      		alert("아이디를 입력해주세요");
      		$("#id").focus();
      		return false;
      		}
      	
      //비밀번호 공백 검사
      	if($("#pass").val() == ""){
      		alert("비밀번호를 입력해주세요");
      		$("#pass").focus();
      		return false;
      		}
      
		
      	//이름 공백 검사
      	if($("#name").val() == ""){
      		alert("이름을 입력해주세요");
      		$("#name").focus();
      		return false;
      		}
      
     	//이름 유효성 검사
     	if(!getName.test($("#name").val())){
     		alert("이름형식에 맞게 입력해주세요")
     		$("#name").val("");
     		$("#name").focus();
     		return false;
     		}
        
        if($('#email').val() == ""){
            alert("이메일을 입력하지 않았습니다");
            $('#email').focus();
            return false;
        }

        if(!getMail.test($('#email').val())){
            alert('이메일형식에 맞게 입력해주세요')
            $('#email').val("");
            $('#email').focus();
            return false;
        }
        
        if($('#tell').val() == ""){
            alert("전화번호를 입력하지 않았습니다");
            $('#tell').focus();
            return false;
        }
        
        if($('#tell').val() == ""){
            alert("전화번호를 입력하지 않았습니다");
            $('#tell').focus();
            return false;
        }
        
        if($('#gender').val() != "M" && $('#gender').val() != "F"){
            alert("성별를 입력하지 않았습니다");
            return false;
        }

			$("#frm_signup").submit()
	});
	
	
	  $("#gdsImg").change(function(){
		   if(this.files && this.files[0]) {
		    var reader = new FileReader;
		    reader.onload = function(data) {
		     $(".select_img").attr("src", data.target.result).width();        
		    }
		    reader.readAsDataURL(this.files[0]);
		   }
		  });
	  
	  
});
//debugger;
</script>
<body>
    <form action="write" method="post" id="frm_signup"  enctype="multipart/form-data">
    <!-- 회원가입 전체적 틀 -->
    <div class="join_start">

        <!-- 회원가입 상단 부분(로고, 부제목) -->
        <div class="join_header">

            <!-- 로고 -->
            <div class="header_img_logo">
                <a href="/login"><img src="/img/Gr_logo_png_ver3.png" class="insta_logo"></a>

                <!-- 부가설명 -->
                <h5 class="header_sub_title">
                    간단한 회원가입 후 이용해보세요
                </h5>

            </div>
        </div>
        
        

        <!-- 회원가입 중간 부분(아이디, 비밀번호, 이름, 이메일, 전화번호 등등 입력 공간) -->
        <div class="join_write_info">
            
            <!-- 회원가입 왼쪽(프로필 사진 업로드) 부분 -->
            <div class="join_img_con">
                <input type="file" name="user_pho_path" id ="gdsImg" accept="image/*">
                <br><input type="hidden" name ="user_pho2" value="/img/기본이미지.jpg">
				<img class ="select_img" name = "select_img" src="/img/기본이미지.jpg" style="width:200px; height:200px; object-fit:contain;">
            </div>

            <!-- 회원가입 오른쪽(유저 정보 입력) 부분 -->
            <div class="join_info_con">
                <div class="join_user_info">

                    <!-- 아이디 입력 -->
                    <h4 class="font4_style">아이디</h4>
                    <input type="text" class="txt_info" name="id" id="id" placeholder="사용할 아이디 입력해주세요">
                    <br>
					<input type="text" id="confirm_text" value="" tabindex="-1" class="test_pass" style="text-align:center;">
    
                    <!-- 비밀번호 입력 -->
                    <h4 class="font4_style">비밀번호</h4>
                    <input disabled type = "password" name="pass" id="pass" type="password" class="txt_info" placeholder="영문, 숫자, 특수문자를 포함해서 입력해주세요">
                    <br>
                    <input type="text" id="confirm_pass" class="test_pass" value="" tabindex="-1" style="text-align:center;">

                    <!-- 이름 입력 -->
                    <h4 class="font4_style">이름</h4>
                    <input disabled name="name" id="name" type="text" class="txt_info" placeholder="사용할 이름(별명) 입력해주세요">
					<br>
					<input type="text" class="test_pass" value="" tabindex="-1">
					
                    <!-- 이메일 입력 -->
                    <h4 class="font4_style">이메일</h4>
                    <input disabled name="email" id="email" type="email" class="txt_info" placeholder="사용할 이메일 입력해주세요">
                    <br>
                    <input id="confirm_email" type="text" id="confirm_pass" class="test_pass" value="" tabindex="-1" style="text-align:center;">
                    
                    <!-- 전화번호 입력 -->
                    <h4 class="font4_style">전화번호</h4>
                    <input disabled name="tell" id="tell" type="tel" class="txt_info" maxlength="11" placeholder="ex)010-2222-3333">
                    <br>
					<input type="text" class="test_pass" value="" tabindex="-1">
					
                    <!-- 성별 선택 -->
                    <h4 class="font4_style">성별</h4>
                    <select name="gender" id ="gender" class="txt_info" placeholder="사용할 이름(별명) 입력해주세요">
                        <option value="selected">성별을 선택해주세요</option>
                        <option value="M">남자</option>
                        <option value="F">여자</option>
                    </select>
                    <br>
					<input type="text" class="test_pass" value="" tabindex="-1">

                    <!-- 상태메세지(소개글) 입력  -->
                    <h4 class="font4_style">상태메세지</h4>
                    <input name="intro" id="intro" type="text" class="txt_info" placeholder="상태메세지를 입력해주세요">
                    <br>
					
                </div>
            </div>
        </div>


            <!-- 회원가입완료 버튼 부분 -->
            <div class="join_btn_box">
                <a href="login.html" class="afont_style">
<!-- 					<input class="btn_insta_start" id ="save" value = "가입하기" disabled> -->
                     <button id ="save" class="btn_insta_start" >
                        InstaGrum 가입하기
                    </button> 
                    

                </a>
            </div>
    </div>
	</form>
</body>
</html>