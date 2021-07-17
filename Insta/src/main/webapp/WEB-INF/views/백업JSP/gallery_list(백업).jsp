<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/common/libList.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="/css/gallery_list_page.css">
<title>Insert title here</title>
</head>
<script>
$(document).ready(function() {
	
	$("#btn_addImg").click(function() {
		location.href="/gal_writeForm";
	});
	
	$("#btn_addImg2").click(function() {
		location.href="/gal_writeForm";
	});
	
	
	$("#img_addImg").click(function() {
		location.href="/gal_writeForm";
	});
	
	$('button.gallery_list_title.G_popOpenBtnCmmn').click(function(){
		//포스트 넘이 들어가있음
		let post_num = $(this).attr("data-num");
				
		var data = {"post_num" : post_num};
		
		fnDetailView(data);			
	
		$('#G_popUp').fadeIn(200);
	});
		
	$("#G_close_popup").click(function(){
		$('#G_popUp').fadeOut(200);
	});
	
	$("#btn_post_del").click(function(){
		let post_num = $("#hdn_post_num").val();
		var data = {"post_num" : post_num};
		data = JSON.stringify(data);
		
		$.ajax({
			url: 'deletePostGallery',
			type: 'post',
			data: data,
			dataType: 'json',   
			contentType:"application/json; charset=UTF-8", 
			async:false, 
			success: function(data){
				//alert(data);
				if(data.succesed == "success"){
					alert("삭제되었습니다.");
					$('#G_popUp').fadeOut(200);
					//$("#close_popup").click();
					location.href = "/list";
				}else{
					alert("삭제되지 않았습니다.");
				}
			},
			error: function(err){
				console.log(err);   
			}
		});
	});
		
});

fnDetailView = function(data){
	data = JSON.stringify(data);
	
	$.ajax({
		url: 'detailViewPopup2',
		type: 'post',
		data: data,
		dataType: 'json',   
		contentType:"application/json; charset=UTF-8", 
		async:false, 
		success: function(data){
			fnSetPopup(data);
		},
		error: function(err){
			console.log(err);   
		}
	});
}

fnSetPopup = function(data){
	console.log(data);
	$("#gallery_page_img").attr("src", data.file_path+data.save_file_name);
	$("#hdn_post_num").val(data.post_num);
	$("#image_txt").val(data.post_title);
}


</script>
<body>

<div class="container">
	<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	
	<!-- 갤러리/게시물 리스트 부분 -->
	<div class="gallery_page_listing">
		<h1 class="gallery_page_title">회원님이 추가한 사진(이미지) 리스트 입니다.</h1>
		<br>
		<h3 class="gallery_page_subtitle">다양한 사진을 첨부해보세요</h3>
		<button id="btn_addImg" class="btn_gallery_addimg">사진</button>
	</div>추가
	
	<div class="gallery_page_container">
		<c:choose>
			<c:when test="${galleryCnt ne 0 }">
				<c:forEach var="gallery" items="${galleryList }">
						<article class="gallery_page_box">
						<button class="gallery_list_title G_popOpenBtnCmmn" type="button" data-num="${gallery.post_num}"></button> 
						<div class="gallery_list_img">
							<img src="${gallery.file_path }" alt="choose img" class="gallery_upload_image">
						</div>
					</article> 
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="post_upload">
					<div class="file-upload">
						<h3 class="txt_noneimg">
							등록된 사진이 없습니다. "사진추가"를 이용해 사진을 첨부해보세요
							<br> (또는 여기를 클릭해서 사진을 등록해보세요)
						</h3>
					</div>
					<div class="file-upload-button">
						<button type="button" id="btn_addImg2" class="file-upload-add-btn">
							➕
							<h4 class="upload_font">여기를 클릭해주세요</h4>
						</button>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
		
		
		<div id="G_popUp" class="G_popCmmn" >
              	<div class="G_popBg" id="G_close_popup" data-num=""></div>
              	<div class="G_popInnerBox">
                 	<div class="G_pop_post">
                       <div class="gallery_list_image">
                           <div class="gallery_list_box">
                           	<input type="hidden" id="hdn_post_num"/>
                           	<input type="text" name="input_file" id="image_txt" class="gallery_image_text" disabled>
                               <img id="gallery_page_img" class="gallery_pop_page_image" src="" alt="choose img">
                           </div>
                           <button id="btn_post_del" class="btn_gallery_post_del"> 삭제</button>
                   	</div>
              		</div> 
          		</div>
          	</div>
	</div>
</div>

</body>
</html>