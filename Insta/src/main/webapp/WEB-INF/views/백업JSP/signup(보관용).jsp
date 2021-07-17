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
	$("#idOverlap").click(function() {
        if($('#id').val() == ""){
            alert("아이디를 입력하지 않았습니다");
            $('#id').focus();
            return false;
        }
        
        else if(!getCheck.test($("#id").val())){
            alert("아이디 형식에 맞게 입력해주세요 (영문+숫자 혼합 4~12자리)");
            $("#id").val("");
            $("#id").focus();
            return false;
        }
         
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
				loop(data.isResult);
				
			},
			error:function(err){
				alert("error");
			}
		});
	});
		
	
	
	// 이메일 중복검사
	$("#emailOverlap").click(function() {
        if($('#email').val() == ""){
            alert("아이디를 입력하지 않았습니다");
            $('#email').focus();
            return false;
        }
        
        else if(!getCheck.test($("#id").val())){
            alert("이 형식에 맞게 입력해주세요 (영문+숫자 혼합 4~12자리)");
            $("#email").val("");
            $("#email").focus();
            return false;
        }
        
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
				loopE(data.isResult);
				
				
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
	 $("#confirm").click(function(){
	        if($('#pass').val() == ""){
	            alert("비밀번호를 입력하지 않았습니다");
	            $('#pass').focus();
	            return false;
	        }       
	        else if(!getPass.test($("#pass").val())){
	            alert("비밀번호 형식에 맞지 않습니다.(최소6글자 최대 20글자,영문자 + 숫자,특수문자 X)");
	            $("#pass").val("");
	            $("#pass").focus();
	            return false;
	        }
	        else{
	        	alert("성공");
	        	$("#name").focus();
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
	
		// 이메일 활성화
	 $("#email").on("propertychange change keyup paste input", function() {
		 if($("#email").val().toString().length >= 2){
		 	$("#tell").prop("disabled",false);
		 }
		 else if($("#email").val().toString().length <= 1){
			 	$("#tell").prop("disabled",true);
			 }
		});
		
		
	 
	 
	
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
	});
	
	
	  $("#gdsImg").change(function(){
		   if(this.files && this.files[0]) {
		    var reader = new FileReader;
		    reader.onload = function(data) {
		     $(".select_img img").attr("src", data.target.result).width(500);        
		    }
		    reader.readAsDataURL(this.files[0]);
		   }
		  });
	  
	  
});
	


	// 중복아이디
	var loop = function(val,id){
	if(val == 1){
		alert("아이디가 중복되었습니다.");
		$('#id').val("");
		$('#id').focus();
	}
	else if(val == 0){
		alert("사용가능한 아이디입니다.");
		$('#pass').focus();
		 $("#pass").prop("disabled",false);
	}
};

// 중복이메일
var loopE = function(val,id){
if(val == 1){
	alert("이메일이 중복되었습니다.");
	$('#email').val("");
	$('#email').focus();
}
else if(val == 0){
	alert("사용가능한 이메일입니다.");
	$('#tell').focus();
}
};
	

</script>
<body>
<div id = "center">
	    <form name="fileForm" action="write" method="post" enctype="multipart/form-data">
        <p>* ID : <input name="id" id="id" type ="text">
 		<button type="button" id="idOverlap">중복확인</button>
        </p>
        <input type = "text" id="confirm_text">
        
        
        <p>* PW : <input type = "password" name="pass" id = "pass" placeholder = "영문자+숫자" disabled>
        <input type ="button" name = "confirm" id="confirm" value = "확인">
        </p>
        
        
        <p>* Name : <input name="name" id="name" disabled></p>
        
        
        <p>* E-mail : <input name="email" id="email" placeholder ="test940@naver.com" disabled>
         		<button type="button" id="emailOverlap">중복확인</button></p>
         		
         		
        <p>* P.H : <input type ="tel" name="tell" id="tell" placeholder ="-없이" maxlength = "11" disabled></p>       
        <p> * 성별 : 
            <select name="gender" id ="gender" aria-label="성별">
                <option selected value ="선택">선택</option>
                <option value="M">남자</option>
                <option value="F">여자</option>
            </select>
        </p>
        
        <p>소개글 : <input name="intro" id="intro"></p>
        
        
        
        <p><input type="file" name="user_pho_path" id ="gdsImg"/></p>
 			<div class="select_img"><img src="" style="width:200px; height:300px; object-fit:contain;"></div>
 		
        
        <p>
            <input type = "submit" id ="save" value = "가입하기" disabled>
            <input type = "button" id="reset" value="초기화">
        </p>
        </form>
</div>
</body>
</html>