<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/imgSlide.css">
<%@ include file="../common/libList.jsp" %>
</head>
<script>
$(document).ready(function(){		
	$("#click_img").on("click", "div.bookmark_image", function(){
		var post_num = $(this).attr("data-num");
		fnDetailView(post_num);
		
		$('#popup').bPopup();
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
				alert("댓글이 등록되었습니다");
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
	
	$("#ipt_isLikePost").click(function(){
		let likeTgle = $("#ipt_isLikePost").val();
		console.log(likeTgle);
		var post_num = $("#hdn_postNum").val();
		
		
		let data = {"likeTgle":likeTgle, "post_num":post_num};
		fnLikeProc(data);
	});
	
	$('#btn_delete').click(function(){
		var result = confirm("정말로 삭제 하시겠습니까?") ;
		
		if(!result) return;
		
		var post_num = $("#hdn_postNum").val();
		
		var data = {"post_num":post_num};
		
		data = JSON.stringify(data);
		$.ajax({
		   url:"deleteFiles",
		   type:"POST",
		   data:data,
		   dataType:"json",
		   contentType:"application/json; charset=UTF-8",
		   async:false,
		   success:function(data){
			   //console.log(JSON.stringify(data));
			   if(data.succesed == "success")
				   alert("삭제되었습니다.");
			   else
				   alert("삭제되지 않았습니다.");
			   
			   location.href = "/mypage";
		   },
		   error:function(err){
			   $("#txt_postContents").val("삭제 못함");
		   }
		});
	});
	
	//수정 버튼 클릭 시 작동
	$('#btn_modify').click(function(){
		$("#frm_postInfo").submit();
	});	
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
	
fnSetPopup = function(data){	
	$("#txt_fileUrl").attr("src", data.viewPost.file_path);
	$("#txt_postContents").val(data.viewPost.post_content);
	$("#hdn_postNum").val(data.viewPost.post_num);
	$("#post_num").val(data.viewPost.post_num);
	
	console.log(data);
	console.log(data.viewPost.post_content);

	$("#ipt_postLikeCnt").val(data.viewPost.post_like_cnt);	
	$("#ipt_isLikePost").attr("src", data.imgUrl);
	$("#ipt_isLikePost").attr("value", data.isLikePost);
	let txt_file_path = data.viewPost.file_path;
	let txt_post_content = data.viewPost.post_content;		
		
	let post_num = data.viewPost.post_num;		
	$('.postImage').empty();
	$('.postContent').empty();
	$('#commentList').empty();
	
	for(var j=0; j<data.getFileList.length; j++){
		let inPostImg =
			/* '<input type="hidden" value="' + data.getFileList[j].file_path + data.getFileList[j].save_file_name + '" name="list_file_path[' + j + ']" />' + */
			'<img class="img on" src="' + data.getFileList[j].file_path + data.getFileList[j].save_file_name + '" name = "inimages" value = "' + post_num + '" />';
			
		$('.postImage').append(inPostImg);
	};
	
	for(var j=0; j<data.getFileList.length; j++){
		let inHdnPostImg =
			'<input type="hidden" value="' + data.getFileList[j].file_path + data.getFileList[j].save_file_name + '" name="list_file_path[' + j + ']" />';
			
		$('.posHdntImage').append(inHdnPostImg);
		
	};
	
	let inPostContent =
		'<div>글내용 : <input type="text" name="post_content" value="' + txt_post_content + '"/><div>';

	$('.postContent').append(inPostContent);
		
	for(var i=0; i<data.commentList.length; i++){		
		let user_id = data.commentList[i].user_id;
		let comment_content = data.commentList[i].comment_content;
		let comment_no = data.commentList[i].comment_num;
		let buttonHtml = "";
		if(data.session_id == user_id){
			buttonHtml= '<button id = "commentDeleteBtn' + i + '" class="commentDeleteBtn" data-num="' + data.commentList[i].comment_num + '">＊</button>';
		}
		let inCommentHtml = 
			'<div><input type="text" value="' + user_id + '"/>' +
			'<input type="hidden" id="hdn_comment' + i + '" value="' + comment_no + '"/>' + 
			'<input type="text" value="' + comment_content + '"/>' + buttonHtml + 
			'</div>';
		$('#commentList').append(inCommentHtml);
	};
};

//좋아요 프로세스
fnLikeProc = function(data){
	data = JSON.stringify(data);
	
	$.ajax({			
	   url:"likeProc",
	   type:"POST",
	   data:data,
	   dataType:"json",
	   contentType:"application/json; charset=UTF-8",
	   async:false,
	   success:function(data){
		   
	   },
	   error:function(err){
		   alert("에러");
	   }
	});
};
</script>
<body>

총 글수 : ${totalCnt}
    <div class="container">
<%@ include file="../common/top.jsp" %>
        
                <!-- 즐겨찾기 목록 -->
                <div id="click_img" class="bookmark_listing">
                <div class="bookmark_container">
                	<c:forEach var="data" items="${ userBoardList}" varStatus="num">
                    <div class="bookmark_image" data-num="${data.post_num }">
                        <input width="300" height="169" type="image" src="${data.file_path}" value="${num.count}" /><br/>
                    </div>
                    </c:forEach>
                 </div>
				</div>           


<div id="popup" class="Pstyle"> 
    <span class="b-close">X</span> 
    <div class="content" style="height: auto; width: auto;">
    	<form id="frm_postInfo" action="modify" method="post">
    		<input type="hidden" id="hdn_postNum" name="hdn_postNum" value="">
    		<input type="hidden" id="post_num" name="post_num" value="">
    		<div class="posHdntImage"></div>
    		<div id="wrap">
	    		<div class="postImage" style="width:500px;height:500px;"></div>    			    		
        	</div>
        	
        	<button class="prev">PREV</button>
        	<button class="next">NEXT</button>	    
    		<div class="postContent"></div>
    	</form>
    	 <div id="commentList" class="commentList"></div>    	 
    	 <form name="commentInsertForm">
    	 <div class="input-group">
    	 	<div>
    	 	<input type="image" id="ipt_isLikePost" src="" style="height:20px;" />
    	 	<input type="text" id="ipt_postLikeCnt" value="" />
    	 	</div>		 
    	 	<input type="text" class="form-control" id="content" name="content" placeholder="댓글을 입력하세요.">		
    	 	<span class="input-group-btn">
    	 		<button class="btn btn-default" type="button" id = "commentInsertBtn" name="commentInsertBtn">등록</button>
    	 	</span>
    	 </div>
    	 </form>
    <input type="hidden" id="hdn_commentCnt" value="">
	<input type="button" value="수정" id="btn_modify">
    <input type="button" value="삭제" id="btn_delete">
	</div>
</div>

<div id="popup1" class="Pstyle"> 
    <span class="b-close">X</span> 
    <div class="content" style="height: auto; width: auto;">
    	<div>
    		<input type="hidden" id="hdn_comment_num" />
    		<input type="text" id="txt_comment"/>
    		<input type="button" value="수정" id="btn_commentModify"/><br/>
    		<input type="button" value="삭제" id="btn_commentDelete" /><br/>
    	</div>
   	</div>
</div>

<!-- 히든 값으로 줘서 바로 안보이게 하기 -->
<a type="hidden" href="postwrite" id="main_add_btn">추가하기</a>
<script src="js/slideshow.js"></script>
</div>
</body>
</html>