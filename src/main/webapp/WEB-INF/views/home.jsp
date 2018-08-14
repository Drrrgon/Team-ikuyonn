<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<script>
	function loginCheck(){
		var userID = document.getElementById("userID");
		var userPW = document.getElementById("userPW");
	
		if(userID.value == ""){
			alert("아이디를 입력해주세요!");
			return false;
		} else if(userPW.value == ""){
			alert("비밀번호를 입력해주세요!");
			return false;
		}
		return true;
	}
</script>
	<title>Home</title>
</head>
<body>
<h1>
	로그인 해주세요!  
</h1>			
<br/>	
		<form action="loginUser" id="login" method="post" onsubmit="return loginCheck()">
			<input type="hidden" name="action" value="login"/>
			<label> ID : </label><input type="text" id="userID" name="userID"/><br/>
			<label> Password : </label><input type="password" id="userPW" name="userPW"/><br/>
			<input type="submit" value="로그인"/>
		</form>
		<a href="joinPage"><button> 회원가입 </button></a>
</body>
</html>
