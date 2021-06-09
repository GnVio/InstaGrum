<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <script language="javascript">
    function change(color)
    {
         document.bgColor = color;
    }
 
</script>

</head>
<body>
<div align="left">
  <input type="radio" name="bgColor" value="#151515" onclick="change(this.value)">검은색<br>
  <input type="radio" name="bgColor" value="#E6E6E6" onclick="change(this.value)">조금밝은색<br>
<audio src="music/butter.mp3" controls >
</audio>
</div>

</body>
</html>