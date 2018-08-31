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
			$('#userID').html(outi);
		}else{
			$('#userID').html('');
		}
	});
	
	$('#loginPW').on('keyup', function() {
		var loginPW = $('#loginPW').val();
		
		var outp = '<span id="pwCheck">길이는 4~10 사이입니다</span>';
			
		if(loginPW.length<4 || loginPW.length>10){
			$('#userPW').html(outp);
		}else{
			$('#userPW').html('');
		}
	});
});

function joinConfirm(obj){
    //아이디 입력여부 검사
    if (obj.userID.value == '') {
        alert('아이디를 입력하지 않았습니다.');
        obj.userID.focus();
        return false;
    }
    //아이디 유효성 검사 (영문소문자, 숫자만 허용)
    for (i = 0; i < obj.userID.value.length; i++) {
        ch = obj.userID.value.charAt(i)
        if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
            alert('아이디는 대소문자, 숫자만 입력가능합니다.');
            obj.userID.focus();
            obj.userID.select();
            return false;
        }
    }
    //아이디에 공백 사용하지 않기
    if (obj.userID.value.indexOf(' ') >= 0) {
        alert("아이디에 공백을 사용할 수 없습니다.");
        obj.userID.focus();
        obj.userID.select();
        return false;
    }
    //아이디 길이 체크 (4~12자)
    if (obj.userID.value.length<4 || obj.userID.value.length>12) {
        alert('아이디를 4~12자까지 입력해주세요.');
        obj.userID.focus();
        obj.userID.select();
        return false;
    }
    //비밀번호 입력여부 체크
    if (obj.userPW.value == "") {
        alert("비밀번호를 입력하지 않았습니다.");
        obj.userPW.focus();
        return false;
    }
    if (obj.userPW.value == userID.value) {
        alert("아이디와 비밀번호가 같습니다.")
        obj.userPW.focus();
        return false;
    }
    //비밀번호 길이 체크(4~8자 까지 허용)
    if (obj.userPW.value.length<4 || obj.userPW.value.length>12) {
        alert("비밀번호를 4~12자까지 입력해주세요.");
        obj.userPW.focus();
        obj.userPW.select();
        return false;
    }

/*     //비밀번호와 비밀번호 확인 일치여부 체크
    if (document.f.my_pwd.value != document.f.my_pwd1.value) {
        alert("비밀번호가 일치하지 않습니다")
        document.f.my_pwd1.value = ""
        document.f.my_pwd1.focus()
        return false;
    } */

    if (obj.userName.value == "") {
        alert("이름을 입력하지 않았습니다.");
        obj.userName.focus();
        return false;
    }
    if(obj.userName.value.length<2){
        alert("이름을 2자 이상 입력해주십시오.");
        obj.userName.focus();
        return false;
    }
	obj.userBirth.value = new Date(obj.year.value, obj.month.value-1, obj.day.value);	
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
	background:url(https://raw.githubusercontent.com/khadkamhn/day-01-login-form/master/img/bg.jpg) no-repeat center;
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
					<div id="userID"></div>
				</div>
				<div class="group">
					<label for="pass" class="label">비밀번호</label>
					<input type="password" class="input" data-type="password" id="loginPW" name="userPW"/>
					<div id="userPW"></div>
				</div>
				<div class="group">
					<input id="check" type="checkbox" class="check" checked>
					<label for="check"><span class="icon"></span> Keep me Signed in</label>
				</div>
				<div class="group">
					<button type="button" class="button" id="loginButton" name="loginButton" onclick="loginCheck()">로그인</button>
				</div>
			</form>
				<div class="hr"></div>
				<div class="foot-lnk">
					<a href="#forgot">Forgot Password?</a>
				</div>
			</div>
			
			<div class="sign-up-htm">
			<form action="joinUser" method="post" name="join">
				<div class="group">
					<label for="user" class="label">이름</label>
					<input type="text" class="input" id="userName" name="userName"/>
				</div>
				<div class="group">
					<label for="pass" class="label">아이디</label>
					<input type="text" class="input" id="userID" name="userID"/>
				</div>
				<div class="group">
					<label for="pass" class="label">비밀번호</label>
					<input type="password" class="input" id="userPW" name="userPW"/>
				</div>
				<div class="group">
					<label for="pass" class="label">생년월일</label>
					<input type="hidden" class="input" id="userBirth" name="userBirth"/>
					<input type="text" name="year" size="5" maxlength="4" id="year" />년 
                <select name="month" id="month">
                    <option value="01">1</option>
                    <option value="02">2</option>
                    <option value="03">3</option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option value="06">6</option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option value="09">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select> 월
                <select name="day" id="day">
                    <option value="01">1</option>
                    <option value="02">2</option>
                    <option value="03">3</option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option value="06">6</option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option value="09">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                    <option value="21">21</option>
                    <option value="22">22</option>
                    <option value="23">23</option>
                    <option value="24">24</option>
                    <option value="25">25</option>
                    <option value="26">26</option>
                    <option value="27">27</option>
                    <option value="28">28</option>
                    <c:if test="${month!='2'}">
                    <option value="29">29</option>
                    <option value="30">30</option>
                    <c:if test="${month!=4 || month!=6 || month!=9 || month!=11}">
                    <option value="31">31</option>
                    </c:if>
                    </c:if>
                </select> 일
				</div>
				<div class="group">
					<label for="pass" class="label">전화번호</label>
					<input type="text" class="input" id="userPhone" name="userPhone"/>
				</div>
				<div class="group">
					<input type="submit" class="button" value="회원가입" onclick="return joinConfirm(join)">
				</div>
				</form>
				<div class="hr"></div>
				<div class="foot-lnk">
					<label for="tab-1">Already Member?</label>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>
