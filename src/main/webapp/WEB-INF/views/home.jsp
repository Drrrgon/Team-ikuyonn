<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script>
 	function loginCheck(){
		var loginID = $('#loginID').val();
		var loginPW = $('#loginPW').val();
		
		if(loginID == ''){
			alert('아이디를 입력해주세요!');
			return false;
		} else if(loginPW == ''){
			alert('비밀번호를 입력해주세요!');
			return false;
		}
		// 아이디 비밀번호 유효성 검사
		$.ajax({
			url : 'loginUserCheck',
			type : 'post',
			data : {
				'userID' : loginID, 'userPW' : loginPW
			},
			success : function(flag){
				if (flag == 0){
					alert('아이디가 존재하지 않거나 비밀번호가 맞지 않습니다.');
				}
				else{
					$('#loginForm').submit();
				}
			}
		});
	return true;
}

$(function(){
	$('#loginID').on('keyup', function() {
		var loginID = $('#loginID').val();
		
		var outi = '<span id="idCheck">길이는 4~7 사이입니다</span>';
			
		if(loginID.length<4 || loginID.length>7){
			$('#loginIDR').html(outi);
			// return false;
		}else{
			$('#loginIDR').html('');
		}
	});
	$("#userID2").keyup(function(){
		var userID= $("#userID2").val();
		var chk_num = userID.search(/[0-9]/g); 
	    var chk_eng = userID.search(/[a-z]/ig);
	    

	    if(chk_num < 0 || chk_eng < 0||userID.length<4||userID.length>11)
	    { 
	    	var message="아이디는 영문,숫자 혼합 4~11자 입니다.";
	    	$("#temp").html(message);
	        return false;
	    }else{
	    	$("#temp").html("");
	    }
	});
	
	$('#loginPW').on('keyup', function() {
		var loginPW = $('#loginPW').val();
		
		var outp = '<span id="pwCheck">길이는 4~10 사이입니다</span>';
			
		if(loginPW.length<4 || loginPW.length>10){
			$('#loginPWR').html(outp);
			// return false;
		}else{
			$('#loginPWR').html('');
		}
	});
	
	var userForm = document.getElementById('joinForm');
	
    var yearBirth = new Date().getFullYear();
    var monthBirth = new Date().getMonth() + 1;
    var dayBirth = new Date().getDate();
    
    var startYear = yearBirth - 99;
    for(var i=0; i<100; i++) {
    	userForm['birthYear'].options[i] = new Option(startYear+i, startYear+i);
    }

    for (var i=0; i<12; i++) {
    	userForm['birthMonth'].options[i] = new Option(i+1, i+1);
    }
    
    
    userForm['birthYear'].value = yearBirth;
    userForm['birthMonth'].value = monthBirth;
    setDate();
    userForm['birthDay'].value = dayBirth;
});

function setDate() {
	var userForm = document.getElementById('joinForm');
	
    var year = userForm['birthYear'].value;
    var month = userForm['birthMonth'].value;
    var day = userForm['birthDay'].value;
    var dayBirth = userForm['birthDay'];
    
    var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        arrayMonth[1] = 29;
    }

    for(var i = dayBirth.length; i>0; i--) {
    	dayBirth.remove(dayBirth.selectedIndex);
    }
        
    for (var i = 1; i<=arrayMonth[month-1]; i++) {
    	dayBirth.options[i-1] = new Option(i, i);
    }

    if(day != null || day != '') {
        if(day > arrayMonth[month-1]) {
        	dayBirth.options.selectedIndex = arrayMonth[month-1]-1;
        } else {
        	dayBirth.options.selectedIndex = day-1;
        }
    }
}

function joinConfirm(){
	var userID = $('#userID').val();
	var userPW = $('#userPW').val();
	var userName = $('#userName').val();
	var userBirth = $('#userBirth').val('');
	var birthYear = $('#birthYear').val();
	var birthMonth = $('#birthMonth').val();
	var birthDay = $('#birthDay').val();
	var userPhone = $('#userPhone').val();
	
    //아이디 입력여부 검사
    if (userID == '') {
        alert('아이디를 입력하지 않았습니다.');
        // userID.focus();
        return false;
    }
    //아이디 유효성 검사 (영문소문자, 숫자만 허용)
     for (i = 0; i < userID.length; i++) {
        var ch = userID.charAt(i);
        if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
            alert('아이디는 대소문자, 숫자만 입력가능합니다.');
            // userID.focus();
            // userID.select();
            return false;
        }
    }
    //아이디에 공백 사용하지 않기
    if (userID.indexOf(' ') >= 0) {
        alert("아이디에 공백을 사용할 수 없습니다.");
        userID.focus();
        userID.select();
        return false;
    }
    
    var idReg = /^.*(?=.{4,12})(?=.*[0-9])(?=.*[a-zA-Z]).*$/g;

    //아이디 길이 체크 (4~12자)
    if (!idReg.test(userID)) {
        alert('아이디를 4~12자, 영문과 숫자를 혼합해주세요.');
        userID.focus();
        userID.select();
        return false;
    }
    
    //비밀번호 입력여부 체크
    if (userPW == "") {
        alert("비밀번호를 입력하지 않았습니다.");
        userPW.focus();
        return false;
    }
    if (userPW == userID) {
        alert("아이디와 비밀번호가 같습니다.")
        // userPW.focus();
        return false;
    }
    //비밀번호 길이 체크(4~8자 까지 허용)
    if (userPW.length<4 || userPW.length>12) {
        alert("비밀번호를 4~12자까지 입력해주세요.");
        // userPW.focus();
        // userPW.select();
        return false;
    }

/*     //비밀번호와 비밀번호 확인 일치여부 체크
    if (document.f.my_pwd.value != document.f.my_pwd1.value) {
        alert("비밀번호가 일치하지 않습니다")
        document.f.my_pwd1.value = ""
        document.f.my_pwd1.focus()
        return false;
    } */

    if (userName == "") {
        alert("이름을 입력하지 않았습니다.");
        userName.focus();
        return false;
    }
    if(userName.length<2){
        alert("이름을 2자 이상 입력해주십시오.");
        userName.focus();
        return false;
    }
    
    userBirth = new Date(birthYear, birthMonth-1, birthDay);
    $("#userBirth").val(userBirth);

    if (userPhone == "") {
        alert("전화번호를 입력하지 않았습니다!");
        return false;
    }
	if(isNaN(userPhone)){
		alert('전화번호는 숫자만 입력할 수 있습니다!');
		return false;
	}
    if (userPhone.length<10 || userPhone.length>11) {
        alert('전화번호 입력이 잘못되었습니다!');
        return false;
    }
	
	// 아이디 중복 검사
	$.ajax({
		url : 'userIDCheck',
		type : 'post',
		data : {
			'userID' : userID
		},
		success : function(data){	
			if (data != ''){
				alert('아이디가 중복됩니다!');		
			}
			else{	
				$('#joinForm').submit();
			}
		}
	});
	return true;
}
</script>

<style>
body{
	margin:0;
	color:#6a6f8c;
	background:#c8c8c8;
	font:600 16px/18px 'Open Sans',sans-serif;
}
*,:after,:before{box-sizing:border-box}
.clearfix:after,.clearfix:before{content:'';display:table}
.clearfix:after{clear:both;display:block}
a{color:inherit;text-decoration:none}

.login-wrap{
	width:100%;
	margin:auto;
	max-width:525px;
	min-height:670px;
	position:relative;
	background:url(./resources/images/1.jpg) no-repeat center;
	box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);
}
.login-html{
	width:100%;
	height:100%;
	position:absolute;
	padding:90px 70px 50px 70px;
	background:rgba(40,57,101,.9);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm{
	top:0;
	left:0;
	right:0;
	bottom:0;
	position:absolute;
	transform:rotateY(180deg);
	backface-visibility:hidden;
	transition:all .4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check{
	display:none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .button{
	text-transform:uppercase;
}
.login-html .tab{
	font-size:22px;
	margin-right:15px;
	padding-bottom:5px;
	margin:0 15px 10px 0;
	display:inline-block;
	border-bottom:2px solid transparent;
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab{
	color:#fff;
	border-color:#1161ee;
}
.login-form{
	min-height:345px;
	position:relative;
	perspective:1000px;
	transform-style:preserve-3d;
}
.login-form .group{
	margin-bottom:15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .button{
	width:100%;
	color:#fff;
	display:block;
}
.login-form .group .input,
.login-form .group .button{
	border:none;
	padding:15px 20px;
	border-radius:25px;
	background:rgba(255,255,255,.1);
}
.login-form .group input[data-type="password"]{
	text-security:circle;
	-webkit-text-security:circle;
}
.login-form .group .label{
	color:#aaa;
	font-size:12px;
}
.login-form .group .button{
	background:#1161ee;
}
.login-form .group label .icon{
	width:15px;
	height:15px;
	border-radius:2px;
	position:relative;
	display:inline-block;
	background:rgba(255,255,255,.1);
}
.login-form .group label .icon:before,
.login-form .group label .icon:after{
	content:'';
	width:10px;
	height:2px;
	background:#fff;
	position:absolute;
	transition:all .2s ease-in-out 0s;
}
.login-form .group label .icon:before{
	left:3px;
	width:5px;
	bottom:6px;
	transform:scale(0) rotate(0);
}
.login-form .group label .icon:after{
	top:6px;
	right:0;
	transform:scale(0) rotate(0);
}
.login-form .group .check:checked + label{
	color:#fff;
}
.login-form .group .check:checked + label .icon{
	background:#1161ee;
}
.login-form .group .check:checked + label .icon:before{
	transform:scale(1) rotate(45deg);
}
.login-form .group .check:checked + label .icon:after{
	transform:scale(1) rotate(-45deg);
}
.login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm{
	transform:rotate(0);
}
.login-html .sign-up:checked + .tab + .login-form .sign-up-htm{
	transform:rotate(0);
}

.hr{
	height:2px;
	margin:60px 0 50px 0;
	background:rgba(255,255,255,.2);
}
.foot-lnk{
	text-align:center;
}

select{
	width:25%;
	color:#fff;
	border:none;
	padding:15px 20px;
	border-radius:25px;
	background:rgba(255,255,255,.1);
}

option{
	color:black;
}

</style>
	<title>Home</title>
</head>
<body>
<div class="login-wrap">
	<div class="login-html">
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">로그인</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">회원가입</label>
		<div class="login-form">
			<div class="sign-in-htm">
			<form id="loginForm" action="loginUser" method="post" name="login">
				<div class="group">
					<label for="user" class="label">아이디</label>
					<input type="text" class="input" id="loginID" name="userID"/>
					<div id="loginIDR"></div>
				</div>
				<div class="group">
					<label for="pass" class="label">비밀번호</label>
					<input type="password" class="input" data-type="password" id="loginPW" name="userPW"/>
					<div id="loginPWR"></div>
				</div>
				<div class="group">
				<br>
					<!-- <input id="check" type="checkbox" class="check" checked>
					<label for="check"><span class="icon"></span> Keep me Signed in</label> -->
				</div>
				<div class="group">
					<button type="button" class="button" id="loginButton" name="loginButton" onclick="loginCheck()">로그인</button>
				</div>
			</form>
				<!-- <div class="hr"></div>
				<div class="foot-lnk">
					<a href="#forgot">Forgot Password?</a>
				</div> -->
			</div>
			
			<div class="sign-up-htm">		
			<form action="joinUser" method="post" id="joinForm">
				<div class="group">
					<label for="user" class="label">이름</label>
					<input type="text" class="input" id="userName" name="userName"/>
				</div>
				<div class="group">
					<label for="pass" class="label">아이디</label>
					<input type="text" class="input" id="userID2" name="userID"/>
					<div id="temp"></div>
				</div>
				<div class="group">
					<label for="pass" class="label">비밀번호</label>
					<input type="password" class="input" id="userPW" name="userPW"/>
				</div>
 				<div class="group">
    				<label for="pass" class="label">생년월일</label>
					<input type="hidden" class="input" id="userBirth" name="userBirth"/>
    				<select name='birthYear' id='birthYear' onChange='setDate()'></select>&nbsp;년&nbsp;
    				<select name='birthMonth' id='birthMonth' onChange='setDate()'></select>&nbsp;월&nbsp;
    				<select name='birthDay' id='birthDay'></select>&nbsp;일&nbsp;
				</div>
				<div class="group">
				<label for="pass" class="label">전화번호</label>
					<input type="text" class="input" id="userPhone" size="11" maxlength="11" name="userPhone"/>
				</div>
				<div class="group">
					<button type="button" class="button" onclick="joinConfirm()">회원가입</button>
				</div>
				</form>
				<!-- <div class="hr"></div>
				<div class="foot-lnk">
					<label for="tab-1">Already Member?</label>
				</div> -->
			</div>
		</div>
	</div>
</div>

</body>
</html>
