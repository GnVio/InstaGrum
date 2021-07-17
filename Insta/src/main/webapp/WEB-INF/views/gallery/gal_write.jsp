<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/common/libList.jsp"></jsp:include>
<link rel="stylesheet" href="/css/gallery_write.css">
<title>Insert title here</title>
</head>
<script>
$(document).ready(function(){
	$('#btn_addimg').on('click', function(event) {
		event.preventDefault();

		var form = $('#upload_form')[0]
		var data = new FormData(form);
		
		$('#btn_addimg').prop('disabled', true);
		
// 추가해줘야 할 것 **************************************************

 		if($('#image_section').attr('src') == ""){
 			alert("파일을 첨부하세요");
 			return;
 		}
		
		fileupload(data);
	});

// *************************************************************	
	
		// 이벤트를 바인딩해서 input에 파일이 올라올때 위의 함수를 this context로 실행합니다.
		$("#image_input").change(function(){
		   readURL(this);
	});
	
		$('#btn_no').click(function() { 
			var result = confirm('작성을 취소하시겠습니까?');
				if(result) { 
					 location.replace("/list"); } 
				else {
					
				}
	});
});
function readURL(input) {
	 if (input.files && input.files[0]) {
	  var reader = new FileReader();
	  
	  reader.onload = function (e) {
	   $('#image_section').attr('src', e.target.result);  
	  }
	  
	  reader.readAsDataURL(input.files[0]);
	  }
	};

// 그냥 그대로 붙여넣기 ***********************************************

function fileupload (data){
	$.ajax({
		type : "POST",
		enctype : 'multipart/form-data',
		url : "gal_up",
		data : data,
		processData : false,
		contentType : false,
		cache : false,
		timeout : 600000,
		success : function (result) {
			if(result == "success"){
				$('#btn_addimg').prop('disabled', false);
				alert('사진이 업로드 되었습니다.')
				location.href = "/list";
			}else{
				$('#btn_addimg').prop('disabled', false);
				alert('사진이 업로드 되지않았습니다.');
			}
		},
		error: function (e) {
			$('#btn_addimg').prop('disabled', false);
			alert('사진이 업로드 되지않았습니다.');
			return false;
		}
	});
};

// *************************************************************
</script>

<body>
<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
			<div class="gallery_write_upload_title">
				<h2 class="font2_style">Gallery upload_page</h2>
			</div>
		        <div class="file-upload">
		            <form class="image-upload-wrap" id="upload_form" method="POST" enctype="multipart/form-data">
						<input type="text" name="input_file" id="image_txt" class="image_text" placeholder="사진(이미지) 제목 또는 이름을 입력해주세요">
		                <input type="file" name="input_file" id="image_input" class="image_in">
		                <img id="image_section" class="image_set" src="${gallery.file_path }" alt="choose_image">
		            </form>
		        </div>
		        
			   	<div class="file-uploadbtn">
		        	<button id="btn_addimg" class="btn_dis btn_dis_add">추가하기</button> 
		            <button id="btn_no" class="btn_dis btn_dis_no">취소하기</button>
		        </div>       
</body>

</html>