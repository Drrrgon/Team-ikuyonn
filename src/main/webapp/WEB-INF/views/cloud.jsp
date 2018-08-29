<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>메이시</title>
<meta name="description"
	content="A high-quality &amp; free Bootstrap admin dashboard template pack that comes with lots of templates and components.">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" id="main-stylesheet" data-version="1.0.0"
	href="./resources/styles/shards-dashboards.1.0.0.min.css">
<link rel="stylesheet" href="./resources/styles/extras.1.0.0.min.css">
<link rel="stylesheet" href="./resources/mail/jquery.dataTables.min.css">
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>

<script>
function getProject(){
	var userID=$("#userID").val();
	$.ajax({
		url : "getProject",
		type : "post",
		data : {
			"userID" : userID
		},
		success : function(data) {
			alert(data);
			var temp = "";
			for(var i in data){
			temp += "<tr><td>"+i+"</td>";
			temp += "<td>"+data[i].projectName+"</td>";
			temp += "<td>"+data[i].due+"</td>";
			temp += "<td>"+data[i].memberNum+"</td>";
			temp += "<td><button onclick='function("+data[i].projectSeq+")'>열기</button></td></tr>";
          }
			$("#tbody").append(temp);
		},
		error : function() {
			alert("통신실패");
		}
	});
}
	$(function() {
		$('.nav-item').children().eq(6).addClass('active');
		getProject();
	});
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<input type="hidden" value="${sessionScope.userID}" id="userID" />
	 <div class="row">
              <div class="col">
                <div class="card card-small mb-4">
                  <div class="card-header border-bottom">
                    <h6 class="m-0">참여중인 프로젝트</h6>
                  </div>
                  <div class="card-body p-0 pb-3 text-center">
                    <table class="table mb-0">
                      <thead class="bg-light">
                        <tr>
                          <th scope="col" class="border-0">#</th>
                          <th scope="col" class="border-0">프로젝트 명</th>
                          <th scope="col" class="border-0">기간</th>
                          <th scope="col" class="border-0">참여인원</th>
                          <th scope="col" class="border-0">클라우드</th>
                        </tr>
                      </thead>
                      <tbody id="tbody">
                        
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
	<script src="./resources/scripts/extras.1.0.0.min.js"></script>
</body>
</html>