<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#logoutBtn").on("click", function(){
		location.href="/logout";
	})
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
            				$('.id_list').empty();
    						for(var i=0; i<data.isResult.length; i++){
	             				let id = data.isResult[i].user_id;
	            				let name = data.isResult[i].user_name;
	            				let path = data.isResult[i].user_pho_path;
	            				
	            				let inHtml = '<div><input type="text" value="' + id + '"/></div>' +
	            				'<div><input type="text" value="' + name + '"/></div>' +
	            				'<div><img class ="se_img1" data-num ="' + id + '" src = "'+ path + '" style="width:200px; height:300px; object-fit:contain;"></div>';
	            				
	            				$('.id_list').append(inHtml);
	            				$(".id_list").slideDown(500,"swing");
	            				$('.id_list').mouseleave(function(){
	            					$('.id_list').empty();
            					});
    						}
					
						
            			},  
            			error:function(err){
            				alert("error");
            			}
            		});
            	}
                });       
});
</script>
<body>
	<div>
    	<h1>InstaGrum</h1>
    검색<input type= "search" id="sea_search" name ="sea_search">
  	<button type="button" id="btn_search" name="btn_search">검색</button> 
	</div>
	<div class="id_list" >
		<!-- 검색 리스트 -->
	</div>
					<button id="logoutBtn" type="button">로그아웃</button>
      <nav>
        <ul id="topMenu">
          <li><a href="#"> 메뉴 <span>▼</span></a>
            <ul>
              <li><a href="/memberUpdateView">회원정보 수정</a></li>
              <li><a href="/board_write">게시판</a></li>
              <li><a href="#">갤러리</a></li>
              <li><a href="#">즐겨찾기</a></li>
              <li><a href="#">친구</a></li>
              <li><a href="#">메뉴 관리</a></li>
            </ul>
          </li>
        </ul>
      </nav>
</body>
</html>