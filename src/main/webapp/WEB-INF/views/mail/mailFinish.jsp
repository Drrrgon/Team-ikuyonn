<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="../parts/meta.jsp"%>
<title>메이시</title>
<!-- header -->
<%@ include file="../parts/header.jsp"%>
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/loadFirst-js.jsp"%>
<style type="text/css">

</style>
</head>
<body class="h-100">

	<!-- sidebar -->
	<%@ include file="../parts/sidebar.jsp"%>
	<div class="main-content-container container-fluid px-4">
		<div id="page-wrapper">
			<div id="page-inner">
				<h2>메일 전송이 완료되었습니다.</h2>
				<button id='check' class="btn btn-primary">확인</button>
			</div>
		</div>
	</div>

	<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
	<%@ include file="../parts/footer.jsp"%>

<script type="text/javascript">
$(function(){
	$("#check").click(function(){
		location.href="writeMail";
	});
});
</script>
</body>

</html>