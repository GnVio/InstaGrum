<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="../common/libList.jsp" %>
    <link rel="stylesheet" href="/css/imgSlide.css">
    <link rel="stylesheet" href="/css/bookmark.css">
    <script src="/js/slideshow.js?after1"></script>
    <link rel="stylesheet" href="/css/gallery_list_page.css">
    <link rel="stylesheet" href="/css/pstyle.css">
    
</head>
<script>
$(document).ready(function(){	
	//console.log("${userBookList.size()}");
	/* let list_cnt = "${userBookList.size()}";
	if(list_cnt < 1){
		$("#isBookmark").show();
	} else{
		$("#isBookmark").hide();
	} */
	
	$("#click_img").on("click", "div.div_post_num", function(){
		var post_num = $(this).attr("data-num");
		fnDetailView(post_num);
		
		$('#popup').fadeIn(200);
	});
	
	$("#closePoup").click(function(e){
		$("#popup").fadeOut(200);
	});
	
	$('#commentInsertBtn').click(function(){		
		if($('#content').val() == ""){
			alert("댓글을 작성해 주세요.");
		} else
		var content = $("#content").val();
		var post_num = $("#hdn_postNum").val();
		var data = {"content":content,
					"post_num":post_num};
		
		data = JSON.stringify(data);
		$.ajax({			
		   url:"commentinsert",
		   type:"POST",
		   data:data,
		   dataType:"json",
		   contentType:"application/json; charset=UTF-8",
		   async:false,
		   success:function(data){			
				for(var i=0; i < data.comments.length; i++){		
				}
				$('#content').val("");
				fnDetailView(post_num);		
		   },
		   error:function(err){			   
		   }
		});		
	});
	
	$('#commentList').on("click", "button.commentDeleteBtn", function(){	
		var comment_num = $(this).attr("data-num");
		var post_num = $("#hdn_postNum").val();
		$("#hdn_comment_num").val(comment_num);
		
		var jsonData = {"post_num":post_num, "comment_num":comment_num};

		jsonData = JSON.stringify(jsonData);
		$.ajax({			
		  url:"detailComment",
		  type:"POST",
		  data:jsonData,
		  dataType:"json",
		  contentType:"application/json; charset=UTF-8",
		  async:false,
		  success:function(data){	
			  console.log(data);
			  $("#txt_comment").val(data.comment_content);
		  },
		  error:function(err){
			  alert("error");
		  }
		});
		
		$('#popup1').bPopup();
		//선택한 댓글 가저오기.
				
	});
	
	$("#btn_commentModify").click(function(){
		//댓글 내용 들고오기
		var post_num = $("#hdn_postNum").val();
		var comment_num = $("#hdn_comment_num").val();
		var comment_content = $("#txt_comment").val();
		
		console.log(comment_content);
		console.log(hdn_postNum);
		var data = {"post_num":post_num,
				 		 "comment_num":comment_num,
				 		 "comment_content":comment_content};
		data = JSON.stringify(data);
		$.ajax({			
		   url:"updateComment",
		   type:"POST",
		   data:data,
		   dataType:"json",
		   contentType:"application/json; charset=UTF-8",
		   async:false,
		   success:function(data){
			   if(data.result == "success"){
				   $("#popup1").bPopup().close();
				   fnDetailView(post_num);
			   }
			   else{
				   alert("수정실패");
			   }
		   },
		   error:function(err){			   
		   }			   
		});		
	});
	
	$("#btn_commentDelete").click(function(){
		var post_num = $("#hdn_postNum").val();
		var comment_num = $("#hdn_comment_num").val();
		var data = {"post_num":post_num,
						 "hdn_commentNum":comment_num};
		
		data = JSON.stringify(data);
		$.ajax({			
		   url:"deleteComment",
		   type:"POST",
		   data:data,
		   dataType:"json",
		   contentType:"application/json; charset=UTF-8",
		   async:false,
		   success:function(data){	
			   $("#popup1").bPopup().close();			
			   fnDetailView(post_num);
		   },
		   error:function(err){			   
		   }
		 });
	});	
	
	$("#liked").click(function(){
		let likeTgle = $("#liked").val();
		
		var post_num = $("#hdn_postNum").val();
		
		let data = {"likeTgle":likeTgle, "post_num":post_num};
		if(fnLikeProc(data)){
			//debugger;
			let like_cnt = $('#ipt_postLikeCnt').val();
			if(!$("#liked").hasClass("highlighted")){
				$('#liked').addClass("highlighted");
				$('#liked').text('LIKED❤');
				like_cnt = parseInt(like_cnt) + 1;
				$("#liked").attr("value", 1);
			}else{
				$('#liked').removeClass("highlighted");
				$('#liked').text('LIKE❤');
				like_cnt = parseInt(like_cnt) - 1;
				$("#liked").attr("value", 0);
			}
			$('#ipt_postLikeCnt').val(like_cnt);  
		}
	});
	
	$("#bookMark").click(function(){
		let bookMarkTgle = $("#bookMark").val();
		
		var post_num = $("#hdn_postNum").val();
		
		let data = {"bookMarkTgle":bookMarkTgle, "post_num":post_num};
		if(fnBookMarkProc(data)){
			if(!$("#bookMark").hasClass("highlighted")){
				$('#bookMark').addClass("highlighted");
				$('#bookMark').text('즐겨찾기 해제');
				$("#bookMark").attr("value", 1);
			}else{
				$('#bookMark').removeClass("highlighted");
				$('#bookMark').text('즐겨찾기');
				$("#bookMark").attr("value", 0);
			}			  
		}
	});
	
	/* $(".prev").on("click", function (e) {
		prevClick();
	});
	
	$(".next").on("click", function (e) {
		nextClick();
	}); */
});

fnDetailView = function(post_num){
	var data = {"post_num":post_num};
	data = JSON.stringify(data);
	
	$.ajax({
	   url:"detailViewPopup",
	   type:"POST",
	   data:data,
	   dataType:"json",
	   contentType:"application/json; charset=UTF-8",
	   async:false,
	   success:function(data){
		   fnSetPopup(data);
	   },
	   error:function(err){
		   $("#txt_postContents").val("글을가져오지 못했습니다.");
	   }
	});	
};
//var w = window.open("about:blank", "_blank");

fnSetPopup = function(data){
	$("#txt_fileUrl").attr("src", data.viewPost.file_path);
	$("#txt_postContents").val(data.viewPost.post_content);
	$("#hdn_postNum").val(data.viewPost.post_num);	
	
	console.log(data);	

	$("#ipt_postLikeCnt").val(data.viewPost.post_like_cnt);
	$("#liked").attr("value", data.isLikePost);
	if(data.isLikePost==0){
		$('#liked').removeClass("highlighted");
		$('#liked').text('LIKE❤');
	} else{
		$('#liked').addClass("highlighted");
		$('#liked').text('LIKED❤');
	};
	
	$("#bookMark").attr("value", data.isBookMarkPost);
	
	if(data.isBookMarkPost==0){
		$('#bookMark').removeClass("highlighted");
		$('#bookMark').text('즐겨찾기');
	} else{
		$('#bookMark').addClass("highlighted");
		$('#bookMark').text('즐겨찾기 해제');
	};
	
	let txt_file_path = data.viewPost.file_path;
	let txt_post_content = data.viewPost.post_content;
	let txt_user_id = data.viewPost.user_id;
		
	let post_num = data.viewPost.post_num;		
	$('.postImage').empty();
	$('.postContent').empty();
	$('#commentList').empty();
	$('.postUserId').empty();
	
	for(var j=0; j<data.getFileList.length; j++){
		let inPostImg =
			'<img class="img" src="' + data.getFileList[j].file_path + data.getFileList[j].save_file_name + 
			'"value = "' + post_num + '" />';
			
		$('.postImage').append(inPostImg);
	};
	
	$(".postImage .img").eq(0).addClass("on");
	let inPostContent =
		'<div id="div_content" class="post_write_con">글내용 : ' + txt_post_content + '<div>';

	$('.postContent').append(inPostContent);
		
	let inPostUserId = 
		'<div><b>작성자</b> : <b>' + txt_user_id + '</b>';
	
	$('.postUserId').append(inPostUserId);
	
	for(var i=0; i<data.commentList.length; i++){		
		let user_id = data.commentList[i].user_id;
		let comment_content = data.commentList[i].comment_content;
		let comment_no = data.commentList[i].comment_num;
		let buttonHtml = "";
		if(data.session_id == user_id){
			buttonHtml= '<button id = "commentDeleteBtn' + i + '" class="commentDeleteBtn" data-num="' + data.commentList[i].comment_num + '">댓글수정</button>';
		}
		let inCommentHtml =			
			'<div><b>' + user_id + '</b> ' +
			'<input type="hidden" id="hdn_comment' + i + '" value=' + comment_no + '/>' +
			comment_content + buttonHtml + 
			'</div>';	
		$('#commentList').append(inCommentHtml);
	};
};

//좋아요 프로세스
fnLikeProc = function(data){
	let isLikeReturn = false;
	data = JSON.stringify(data);
	
	$.ajax({			
	   url:"likeProc",
	   type:"POST",
	   data:data,
	   dataType:"json",
	   contentType:"application/json; charset=UTF-8",
	   async:false,
	   success:function(result){
		   if(result.result=="success"){
			   isLikeReturn = true;
		   }
		   else{
			   isLikeReturn = false;
		   }
	   },
	   error:function(err){
		   alert("에러");
		   isLikeReturn = false;
	   }
	});
	return isLikeReturn;
};

fnBookMarkProc = function(data){
	let isBookMarkReturn = false;
	data = JSON.stringify(data);
	
	$.ajax({			
	   url:"bookMarkProc",
	   type:"POST",
	   data:data,
	   dataType:"json",
	   contentType:"application/json; charset=UTF-8",
	   async:false,
	   success:function(value){
		   if(value.result == "success"){
			   isBookMarkReturn = true;
		   } else {
			   isBookMarkReturn = false;
		   }
	   },
	   error:function(err){
		   alert("에러");
		   isBookMarkReturn = false;
	   }
	});
	return isBookMarkReturn;
};
</script>
<body>
<%@ include file="../common/top.jsp" %>

<div class="container2">


<div class="gallery_page_listing2">
		<h1 class="gallery_page_title2">회원님의 즐겨찾기목록 입니다.</h1>
		<h3 class="gallery_page_subtitle">다른 회원님의 글을 다시 방문해보세요</h3>
<div id="click_img" class="gallery_page_container">
	<c:choose>
		<c:when test="${userBookList.size() < 1}">
			<input id="isBookmark" type="text" value="등록된 즐겨찾기가 없습니다." />
		</c:when>
		<c:otherwise>
			<c:forEach var="data" items="${userBookList}" varStatus="num">
			<div class="gallery_page_box">
			<div class="bookmark_image">	
				<div class="div_post_num" data-num="${data.post_num}">
					<input type="image" src="${data.file_path}" value="${num.count}" class="gallery_upload_image" /><br/>
					</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>
</div>


<div id="popup" class="popCmmn">
	<div class="popBg" id="closePoup" data-num="1"></div> 
		<div class="popInnerBox">
			<div class="p_pop_post">
		   
			<form id="frm_postInfo" action="modify" method="post">
			
			<div class="gallery_img2">
				<input type="hidden" id="hdn_postNum" name="hdn_postNum" value="">
			<div class="postUserId"></div>   
			<div id="wrap">
				<div class="postImage" style="width:500px;height:500px; "></div>	    		    			    		
			</div>
				<a class="prev" >&#10094;</a>
				<a class="next" >&#10095;</a>
				
			<div class="gallery_int">		  	        		    
				<div class="postContent"></div>
			</div>
			</div>		
			</form>	
		
			<div class="gal_comment">
			<div class="popUpInsertForm" style="float:right">
		
				<div id="commentList" class="commentList"></div>
				
				<form name="commentInsertForm">
		
		<!--     	 <div class="input-group"> --> <!-- << 옆에 div는 지우기 -->
		
		<!-- 댓글 달기 부분 : 댓글이랑 좋아요/북마크 위치 바꿔주기 -->
			<div class="comment_big_box">		 
				<input type="text" class="form-control" id="content" name="content" placeholder="댓글을 입력하세요.">		
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" id = "commentInsertBtn" name="commentInsertBtn">등록</button>
				</span>
			</div> 
		 	
			<hr class="combook_line"> <!-- hr은 댓글 바로 밑에 추가  -->
		
		<!-- 좋아요, 즐겨찾기 버튼 -->   	 	
			<div class="gal_like">
				<button type="button" id="liked" class="btn_like highlighted">
					LIKE❤
				</button>
			<input type="text" class ="like_box" id="ipt_postLikeCnt" value=""  disabled/>
			<button type="button" id="bookMark" class="btn_bookmark highlighted">
			즐겨찾기
			</button>	
		</div>    
		<!--     	 </div> -->
		</form>  	
		</div>
	</div>
	</div>
	</div>
</div>

<div id="popup1" class="Pstyle"> 
    <span class="b-close">X</span> 
    <div class="content" style="height: auto; width: auto;">
    	<div>
    		<div class="detailCommentBtn">
    		<input type="hidden" id="hdn_comment_num" />
    		<input type="text" id="txt_comment" class="hid_comment_box" /><br>    		 
    		<input type="button" value="수정" id="btn_commentModify" class="button_comment_Modi"/>
    		<input type="button" value="삭제" id="btn_commentDelete" class="button_comment_Modi" />
    	</div>
    		</div>
    	</div>
   	</div>

	</div>
</body>
</html>