<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="../common/libList.jsp" %>
<link rel="stylesheet" href="/css/imgSlide.css">
<link rel="stylesheet" href="/css/bookmark.css">
<link rel="stylesheet" href="/css/mainpro.css">
<script src="/js/slideshow.js?b"></script>
<link rel="stylesheet" href="/css/pstyle.css">

</head>
<script>
$(document).ready(function(){

   $("#btn_add").on("click", function(){
   var user_id = $("#hidden_user_id").val();
   var friend_id = $("#hidden_friend_id").val();
   var data = {"user_id":user_id,
            "friend_id":friend_id};
   // 아래 location으로 넘기는 값을 컨트롤러에서 받아와도 되나 int로 선언하여 가져올수없음.
   // 타입을 변경해야 원하는값을 받아올수있음
   data = JSON.stringify(data);
   $.ajax({
      url:"addFriend",
      type:"POST",
      data:data,
      dataType:"json",
      contentType:"application/json; charset=UTF-8",
      async:false,
      success:function(data){
         window.location.replace("/mypage?user_id="+friend_id);
      },
      error:function(err){
         alert("error");
      }
      });
   });
   
   $("#btn_delete2").on("click", function(){
      var user_id = $("#hidden_user_id").val();
      var friend_id = $("#hidden_friend_id").val();
      var data = {"friend_id":friend_id};
      data = JSON.stringify(data);
      $.ajax({
         url:"deleteFriend",
         type:"POST",
         data:data,
         dataType:"json",
         contentType:"application/json; charset=UTF-8",
         async:false,
         success:function(data){
            window.location.replace("/mypage?user_id="+friend_id);
         },
         error:function(err){
            alert("error");
         }
         });
      });
   
   
   $("#click_img").on("click", "div.bookmark_image", function(){
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
            $('#bookMark').text('🌈즐겨찾기 해제');
            $("#bookMark").attr("value", 1);
         }else{
            $('#bookMark').removeClass("highlighted");
            $('#bookMark').text('🌈즐겨찾기');
            $("#bookMark").attr("value", 0);
         }           
      }
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
      $('#bookMark').text('🌈즐겨찾기');
   } else{
      $('#bookMark').addClass("highlighted");
      $('#bookMark').text('🌈즐겨찾기 해제');
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
         /* '<input type="hidden" value="' + data.getFileList[j].file_path + data.getFileList[j].save_file_name + '" name="list_file_path[' + j + ']" />' + */
         '<img class="img" src="' + data.getFileList[j].file_path + data.getFileList[j].save_file_name + '" name = "inimages" value = "' + post_num + '" />';
         
      $('.postImage').append(inPostImg);
   };
   $(".postImage .img").eq(0).addClass("on");
   
   let inPostContent =
      '<div name="post_content" class="post_write_con">글내용 : ' + txt_post_content + '<div>';
      

   $('.postContent').append(inPostContent);
   
   let inPostUserId = 
      '<div class="commentList_sub_con"><b>작성자</b> : <b>' + txt_user_id + '</b>';
   
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
    <div class="container">

            <div class="frame">
            <div class="center">
                  <div class="profile">
                      <div class="image">
                          <img id = "photo" name = "user_pho" src="${user_pho1}" width="150px" height="150px">
                      </div>
                      <div class="name" name ="user_id" id = "user_id">${user_id1}</div>
               <div class="sub_name" name ="user_name" id = "user_name">${user_name1}</div>
                      <div class="sub_name" name = "user_intro" id = "user_intro">${user_intro1}</div>                    
                    
                   
                   <!-- Foreach문 안에서 when 문이 작동하지 않아 아래와같이 구성함 -->             
                   <c:choose>
                   <c:when test="${user_id1 eq member.user_id}">
                  
                </c:when>
                   <c:when test="${is_friend eq true}">
                  <div class="actions">
                      <button type="button" id = "btn_delete2" class="btn_add">친구</button>
                  </div>
                   </c:when>
                   <c:when test="${is_friend eq false}">
                  <div class="actions">
                      <button type="button" id = "btn_add" class="btn_add">친구추가</button>
                  </div>
                   </c:when>

                <c:otherwise>
                
                </c:otherwise>
                   </c:choose>                         
                  </div>
                  
                  <div class="stats">
                      <div class="box">
                          <span class="value">총 게시물</span>
                          <span class="parameter">${totalCnt}</span>    
                          
                          <span class="value">친구</span>
                          <span class="parameter">${friend_totalCnt}</span>
                  </div>

                  </div>
            </div>
        </div>
      <input type="hidden" id = "hidden_user_id" value ="${member.user_id}">
      <input type="hidden" id = "hidden_friend_id" value ="${user_id1}">
      
<!------------------------------------------------------------------------------------------------------------------------------  -->
       
            <div class="user_post_box">
            <h1 class="gal_font">My Boarder List</h1>
            <c:choose>
            <c:when test="${user_id1 eq member.user_id}">
                <h2><a type="hidden" href="postwrite">글 작성</a></h2>
            </c:when>
    		  </c:choose>
      
    <!-- 즐겨찾기 목록 -->
    <div class="bookmark-page-listing">
                <div id="click_img" class="bookmark_container">
                
                   <c:forEach var="data" items="${userBoardList}" varStatus="num">
                   <div class="bookmark_listing">
                    <div class="bookmark_image" data-num="${data.post_num }">
                        <input type="image" src="${data.file_path}" value="${num.count}" style="width:620px; height:359px;" /><br/>
                    </div>
                    </div>
                    </c:forEach>
                 
            </div>           
   </div>
</div>

</div>


<!-- ---------------------------------------------------------------------------------------------------------------------------------------------- -->

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
         <c:choose>
         <c:when test="${user_id1 eq member.user_id}">
         <div class="gal_chan">
            <input type="button" value="글 수정하기" id="btn_modify" class="btn_change">
            <input type="button" value="글 삭제하기" id="btn_delete" class="btn_change">                           
         </div>
         </c:when>
        <c:otherwise> 
		 

         </c:otherwise>
         </c:choose>
         </div>      
         </form>   
      
         <div class="gal_comment">
         <div class="popUpInsertForm" style="float:right">
      
            <div id="commentList" class="commentList"></div>
            
            <form name="commentInsertForm">
      
      <!--         <div class="input-group"> --> <!-- << 옆에 div는 지우기 -->
      
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
      <!--         </div> -->
      </form>     
      </div>
   </div>
   </div>
   </div>
</div>

<div id="popup1" class="Pstyle" > 
    <span class="b-close">X</span> 
    <div class="content" style="height: auto; width: auto;">
       <div>
          <div class="detailCommentBtn">
          <input type="hidden" id="hdn_comment_num" />
          <input type="text" id="txt_comment" class="hid_comment_box"/><br>           
          <input type="button" value="수정" id="btn_commentModify" class="button_comment_Modi"/>
          <input type="button" value="삭제" id="btn_commentDelete" class="button_comment_Modi" />
       </div>
          </div>
       </div>
      </div>

</body>
</html>