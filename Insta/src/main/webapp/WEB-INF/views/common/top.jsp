<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>TOP</title>
<%@ include file="../common/libList.jsp" %>
<link rel="stylesheet" href="/css/mainpro.css">
</head>
<script>
$(document).ready(function(){
	$("#logoutBtn").on("click", function(){
		location.href="/logout";
	});

	
	
	// 검색창에서 엔터키 뽑아버리기
	$(document).keypress(function(e){
		if (e.keyCode == 13) e.preventDefault();
		});
			
            $("#sea_search").keyup(function(){
            	if($("#sea_search").val() == ''){
    				$('#se_img').empty();
    				$('#se_img').css("display","none");	
            	}
            	else if(($("#sea_search").val() != '')){
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
			       			
			       				
			       				let inHtml = '<div class="item">'+'<img data-num = "'+ id +'" src="' + path +  '"width="30px" height="30px" class="src_img">'+
			       				'<span class="text">' + id + '</span></div>';
			       				$('#se_img').append(inHtml);
			       				$("#se_img").slideDown(500,"swing");
			       				
			       				$('#se_img').mouseleave(function(){
				       				$('#se_img').empty();
				       				$('#se_img').css("display","none");
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
        		
          		location.href="/mypage?user_id="+ select_img2;
        	});
        	
        	$("#header_logo").on("click",function(){
        		location.href="/board";
        	});
	
	
});
</script>
<header>
<div class="container">
        <div class="header">
            <!-- <img src="project/img/Gr_logo_png_ver3.png" id="header_logo"> -->
			<h1 class="logo" id="header_logo">InstaGrum</h1>
            
            <div class="search-box">
                <input type="text" class="search-txt" id="sea_search" name ="sea_search" placeholder="Type to search">
<!-- 				버튼클릭하지않고 키업으로 찾기위해 버튼은 주석처리
				<input type="button" class="btn_src" id="btn_search" name="btn_search" value="Search"> -->
                 
                 
                	<div class="recommend" id="se_img" style="display: none;">
					<!-- 검색 리스트 -->
					</div>
              </div>
            <ul id="main_menu">
                <li><a href="#sub_menu">MENU</a>
                    <ul id="sub_menu">
                        <li><a href="/memberUpdateView">회원정보수정</a></li>
                        <li><a href="/mypage">마이페이지</a></li>
                        <li><a href="/list">갤러리</a></li>
                        <li><a href="/bookmark">즐겨찾기</a></li>
                        <li><a href="/friend">친구리스트</a></li>
			            <hr>
                        <li><a id="logoutBtn">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        </div>
</header>
</html>