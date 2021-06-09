<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
  <link rel="stylesheet" href="#">
  
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#alpreah_input").keydown(function(key) {
                if (key.keyCode == 13) {
                    //alert("text");
                	f_search($("#alpreah_input").val());
                }
            });
            $("#btn_w").click(function() {
       			//alert("text");
            	f_search($("#alpreah_input").val());
            });
            
        });
        var params = {
        		"consumerId" : "tester",
        		"amount" : "7",
        		"error" : 0
        	};
        	var jsonString = JSON.stringify(params);
        f_search = function(searchValue){
        	//location.href = "/search?value=" + searchValue;
        	alert("dd");
        	$.ajax({
    			url:"search",
    			type:"POST",
    			data:{"searchValue":searchValue},
    			dataType:"json",
    			contentType:"application/json; charset=UTF-8",
    			async:false,
    			success:function(data){
    				alert(JSON.stringify(data));
    				setData(data);
    				$("#alpreah_input").val(data.id);
    			},
    			error:function(err){
    				alert("error");
    			}
    		});
        };
        
        setData = function(data){
        	
        }
    </script>
<body>
	<div id="logo" align="left">
    	<a href="#">
    	<h1>InstaGrum</h1>
    검색<input type= "search" id="alpreah_input">
  	<button type="button" id="btn_w">검색</button> 
	</div>
	
      <nav>
        <ul id="topMenu">
          <li><a href="#"> 메뉴 <span>▼</span></a>
            <ul>
              <li><a href="#">회원정보 수정</a></li>
              <li><a href="#">게시판</a></li>
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