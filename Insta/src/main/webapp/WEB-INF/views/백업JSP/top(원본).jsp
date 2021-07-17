<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>TOP</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0">  -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- 검색화면 -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
    <link rel="stylesheet" href="/css/mainpro.css">
    <!-- 로고 폰트 -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Niconne&family=Playball&family=Sacramento&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300&display=swap" rel="stylesheet">
    <script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
</head>
    <!-- 스크립트 -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="js/layer pop_up.js"></script>
    <script src="js/bookmark.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#logoutBtn").on("click", function(){
		location.href="/logout";
	});
	
    const inputBox = document.querySelector("input");
    const recommendBox = document.querySelector("#recommend");
    const texts = document.querySelectorAll(".text");

    inputBox.addEventListener("keyup", (e) => {
        if (e.target.value.length > 0) {
            recommendBox.classList.remove('invisible');
            texts.forEach((textEl) => {
                textEl.textContent = e.target.value;
            })
        } else {
            recommendBox.classList.add('invisible');
        }
    });
	

/* 	function sessionCheck() {
		var sessionEmail = '';
		$.ajax({
			type : 'POST',
			datatype : 'json',
			url : 'memberSessionCheck',
			async : false,
			success : function(result) {
				sessionEmail = result;
			},
			error : function(xhr, status, error) {
				alert('ajax error');
			}
		});
		if(sessionEmail == ''){
			var reLogin = confirm('확인 시 로그인 창으로 이동됩니다.' + '\n' + '취소시 현재 창이 유지 됩니다.');
			if(reLogin){
				location.href = 'memberLoginForm'; 
				return;
			}
		} else {
			return;
		}
	} */
	
	
	
	
	
	
/*             $("#alpreah_input").keydown(function(key) {
                if (key.keyCode == 13) {
                    //alert("text");
                	f_search($("#alpreah_input").val());
                }
            }); */
/*             
            $("#btn_w").click(function() {
       			//alert("text");
            	f_search($("#alpreah_input").val());
            }); */
            
            
            
            
            
            $("#btn_search").click(function(){
            	if($("#sea_search").val() == ''){
            		alert("아이디 또는 이름을 입력해주세요");
            	}else if(($("#sea_search").val() != '')){
          		var search_value = $("#sea_search").val();
        		var data = {"search_value":search_value};
                data= JSON.stringify(data);
                	$.ajax({
            			url:"search",
            			type:"POST",
            			data:data,
            			dataType:"json",
            			contentType:"application/json; charset=UTF-8",
            			async:false,
            			success:function(data){
            				$('#se_img').empty();
    						for(var i=0; i<data.isResult.length; i++){
	             				let id = data.isResult[i].user_id;
	            				let name = data.isResult[i].user_name;
	            				let path = data.isResult[i].user_pho_path;
	            			
	            				
	            				let inHtml = '<div class=item>'+'<img data-num = "'+ id +'" src="' + path +  '" width="30px" height="30px" class="src_img">'+
	            				'<span class="text">' + id + '</span></div>';
	            				$('#se_img').append(inHtml);
	            				$("#se_img").slideDown(500,"swing");
	            				$('#se_img').mouseleave(function(){
	            					$('#se_img').empty();
            					});
    						}
					
						
            			},  
            			error:function(err){
            				alert("error");
            			}
            		});
            	}
                });    
            
            
        	$("#se_img").on("click","img.src_img", function(){
        		var select_img2 = $(this).attr("data-num")
        		
        		console.log(select_img2);
        		
          		location.href="/test?user_id="+ select_img2;
        	});
	
	
});
</script>
<body>
<div class="container">

        <div class="header">
            <!-- <img src="project/img/Gr_logo_png_ver3.png" id="header_logo"> -->
            <h1 class="logo" id="header_logo">InstaGrum</h1>
            
            <div class="search-box">
                <input type="text" class="search-txt" id="sea_search" name ="sea_search" placeholder="Type to search">
                 <input type="button" class="btn_src" id="btn_search" name="btn_search" value="Search">
                 
                 
                	<div class="recommand" id="se_img">
					<!-- 검색 리스트 -->
					</div>
					
					
					
              </div>
            <ul id="main_menu">
                <li><a href="#sub_menu">MENU</a>
                    <ul id="sub_menu">
                        <li><a href="/memberUpdateView">회원정보수정</a></li>
                        <li><a href="/mypage">마이페이지</a></li>
                        <li><a href="#">갤러리</a></li>
                        <li><a href="#">즐겨찾기</a></li>
                        <li><a href="/friend">친구리스트</a></li>
                        <li><a id="logoutBtn">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        </div>
</body>
</html>