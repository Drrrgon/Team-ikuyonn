<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>회원가입 페이지</title>
<link rel="stylesheet" href="./resources/css/main.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
		<h2>[ 회원가입 ]</h2><br/>
			<form action="joinUser" method="post" onsubmit="return Confirm()">
			<input type="hidden" name="action" value="join"/>
				<label> 이름 </label><input type="text" id="userName" name="userName"/><br/>
      			<label> 아이디 </label><input type="text" id="userID" name="userID"/><br/>
        		<label> 비밀번호 </label><input type="password" id="userPW" name="userPW"/><br/>
        		<label> 생년월일 </label><input type="date" id="userBirth" name="userBirth"/><br/>
        		<label> 전화번호 </label><input type="text" id="userPhone" name="userPhone"/><br/>
				<input type="submit" class="btn btn-sm btn-warning" value="확인" id="join" /> 
			</form>
	
</body>
</html>