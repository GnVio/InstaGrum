<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <link rel="stylesheet" href="/css/join2.css">
    <title>InstaGrum Join_page</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
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
		        	$('#confirm_text').val("아이디 형식에 맞게 입력해주세요 (영문+숫자 혼합 4~12자리)")
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
	 $("#gender").on("change",function(){
		 if(($("#gender option:selected").text() == "M" || $("#gender option:selected").text() == "F")
				&& $("#id").val() != ""
 				&& $("#pass").val() != ""
				&& $("#name").val() != ""
				&& $("#email").val() != ""
				&& $("#tell").val() != ""	 
			 )
			{
			 $("#save").prop("disabled",false);
		}
		 if($("#gender option:selected").text() == "선택"){
			 $("#save").prop("disabled",true);
		 }
	 });	
	
	 // 비밀번호 확이 눌렸을때
	 $("#pass").keyup(function(){
	        if($('#pass').val() == ""){
	        	$('#confirm_pass').val("비밀번호를 입력하지 않았습니다");
				 $("#name").prop("disabled",true);
	        }       
	        else if(!getPass.test($("#pass").val())){
	        	$('#confirm_pass').val("비밀번호 형식에 맞지 않습니다.(최소6글자 최대 20글자,영문자 + 숫자,특수문자 X)");
	            $("#name").prop("disabled",true);
	        }
	        else{
	        	$('#confirm_pass').val("사용가능한 비밀번호 입니다.");
				 $("#name").prop("disabled",false);
	        }

	 });
	 
		// 이름 활성화
	 $("#name").on("propertychange change keyup paste input", function() {
		 if($("#name").val().toString().length >= 2){
		 	$("#email").prop("disabled",false);
		 }
		 else if($("#name").val().toString().length <= 1){
			 	$("#email").prop("disabled",true);
			 }
		});
	
/* 		// 이메일 활성화
	 $("#email").on("propertychange change keyup paste input", function() {
		 if($("#email").val().toString().length >= 2){
		 	$("#tell").prop("disabled",false);
		 }
		 else if($("#email").val().toString().length <= 1){
			 	$("#tell").prop("disabled",true);
			 }
		});
		 */
		
	 
	 
	
	//유효성 시작
	$("#save").click(function(){    
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

        if(!getNumber.test($('#tell').val())){
            alert("전화번호 입력이 잘못되었습니다.")
            $('#tell').val("");
            $('#tell').focus();
            return false;
            
            }
        $("#frm_signup").submit()
	});
	
	
	  $("#gdsImg").change(function(){
		   if(this.files && this.files[0]) {
		    var reader = new FileReader;
		    reader.onload = function(data) {
		     $(".select_img img").attr("src", data.target.result).width();        
		    }
		    reader.readAsDataURL(this.files[0]);
		   }
		  });
	  
	  
});
//debugger;
</script>
<body>
<div class="joinForm">
    <form action="write" method="post" id="frm_signup"  enctype="multipart/form-data">
        <img src="/img/Gr_logo_png_ver3.png">
        <h5>간단한 회원가입 후 이용해보세요</h5>
        <div class="join_form">
        
        
            <!-- 아이디 입력 -->
            <h4 class="h4_style">ID
            </h4>
            <input name="id" id="id" type ="text" class="txt_id" placeholder="사용할 아이디">
            <input disabled type="text" id="confirm_text" value="" size=70 style="background-color:transparent;border:0 solid black;text-align:center;">
            
            <!-- 비밀번호 입력 -->
            <h4 class="h4_style">Password
            </h4>
            <input type = "password" name="pass" id = "pass" class="txt_pw" placeholder = "영문자+숫자" disabled>
            <input disabled type="text" id="confirm_pass" value="" size=70 style="background-color:transparent;border:0 solid black;text-align:center;">
            
            <!-- 이름 -->
            <h4 class="h4_style">Name</h4>
            <input name="name" id="name" disabled class="txt_name" placeholder="이름" disabled>
            <input disabled type="text"value="" size=70 style="background-color:transparent;border:0 solid black;text-align:center;">
            <br>
            
            <!-- 이메일 -->
            <h4 class="h4_style">E-Mail
            </h4>
            <input name="email" id="email" type="email" class="txt_email" placeholder="이메일 : seungmistar@hanmail.net" disabled>
			<input disabled type="text" id="confirm_email" value="" size=70 style="background-color:transparent;border:0 solid black;text-align:center;">                     	
                     	
			<!-- 전화번호 -->
            <h4 class="h4_style">Phone Number</h4>
            <input type="tel" name="tell" id="tell" class="txt_phone" maxlength = "11" placeholder="전화번호 : 공백없이" disabled>
            
            
			<!-- 성별 -->
            <h4 class="h4_style">Gender</h4>
            <select name="gender" id ="gender" class="sel" aria-label="성별">
                <option selected value ="선택">선택</option>
                <option value="M">남자</option>
                <option value="F">여자</option>
            </select>
                     	
            <!-- 소개 -->
            <h4 class="h4_style">Introduce(소개글)</h4>
            <input name="intro" id="intro" type="text" class="txt_int" placeholder="hello! my name is seungmi">
            
            
            
        </div>
        <div class="join_img">
        	 <p><input type="file" name="user_pho_path" id ="gdsImg"/></p>
 			<div class="select_img"><img src="" style="width:200px; height:323px; object-fit:contain;"></div>
        </div>
    </form>
    <button id ="save" class="btn_login"> 가입하기 </button>          


            <footer class="foot_text">
                <div class="foot">
                    Developer by KimMunPark | Finsh : 2021. 07. 06 | Questions by Grum@instagrum.com
                </div>
            </footer>
            </div>
</body>
</html>