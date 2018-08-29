<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>일정표</title>
<meta name="description"
	content="A high-quality &amp; free Bootstrap admin dashboard template pack that comes with lots of templates and components.">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" id="main-stylesheet" data-version="1.0.0" href="./resources/styles/shards-dashboards.1.0.0.min.css">
<link rel="stylesheet" href="./resources/styles/extras.1.0.0.min.css">
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>
<link href='./resources/styles/fullcalendar.min.css' rel='stylesheet' />
<link href='./resources/styles/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='./resources/styles/scheduler.min.css' rel='stylesheet' />
<script src='./resources/scripts/moment.min.js'></script>
<script src='./resources/scripts/jquery.min.js'></script>
<script src='./resources/scripts/fullcalendar.min.js'></script>
<script src='./resources/scripts/theme-chooser.js'></script>
<script src='./resources/scripts/scheduler.min.js'></script>
<script>
/* function nowTime(){
	startDate1.value = new Date(year1.value, month1.value-1, day1.value, hour1.value, minute1.value);		    	
	endDate2.value = new Date(year2.value, month2.value-1, day2.value, hour2.value, minute2.value);
} */

	$(function() {
				
		initThemeChooser({	
			
			init : function(themeSystem) {
				$('#calendar').fullCalendar({
					themeSystem : themeSystem,
					lang : 'ko',
					editable : true, // enable draggable events
					aspectRatio : 1.8,
					scrollTime : '00:00', // undo default 6am scrollTime
					header : {
						left : 'today prev,next',
						center : 'title',
						right : 'timelineDay,agendaWeek,month,listWeek'
					},
					defaultView : 'month',
					resourceLabelText : 'Rooms',
					resources : [ {
						id : 'a',
						title : 'Auditorium A'
					}, {
						id : 'b',
						title : 'Auditorium B',
						eventColor : 'green'
					}, {
						id : 'c',
						title : 'Auditorium C',
						eventColor : 'orange'
					}, {
						id : 'd',
						title : 'Auditorium D',
						children : [ {
							id : 'd1',
							title : 'Room D1'
						}, {
							id : 'd2',
							title : 'Room D2'
						} ]
					}, {
						id : 'e',
						title : 'Auditorium E'
					}, {
						id : 'f',
						title : 'Auditorium F',
						eventColor : 'red'
					}, {
						id : 'g',
						title : 'Auditorium G'
					}, {
						id : 'h',
						title : 'Auditorium H'
					}, {
						id : 'i',
						title : 'Auditorium I'
					} ],
					events : function(start, end, timezone, callback){							
						$.ajax({
							type : 'post',
							url : 'privateEvents',
							success : function(data) {								
								var events = [];
								$(data).each(function(index, item) {
									events.push({
										id : item.userID,
										title : item.summary,
										start : item.startDate,
										end : item.endDate
									});
								});
								callback(events);
							},
							error : function() {
								alert("수신실패");
							}
						});
					},
					dayClick : function(date, jsEvent, view){
						var modal = document.getElementById('insertModal');
						
						var span = document.getElementById('close1');
						
						var cancel = document.getElementById('cancelButton1');
						
						var insert = document.getElementById('insertEvent');
						
						modal.style.display = 'block';
						
						span.onclick = function() {
							$('#summary1').val('');
					    	$('#startDate1').val('');
					    	$('#endDate2').val('');
							modal.style.display = 'none';
						}
						
						cancel.onclick = function() {
							$('#summary1').val('');
					    	$('#startDate1').val('');
					    	$('#endDate2').val('');
							modal.style.display = 'none';
						}
						
						insert.onclick = function() {
							modal.style.display = 'none';
						}
						
						window.onclick = function(event) {
						    if (event.target == modal) {
						    	$('#summary1').val('');
						    	$('#startDate1').val('');
						    	$('#endDate2').val('');
						        modal.style.display = 'none';
						    }
						}
					},
					eventClick : function(event, jsEvent, view){
						var modal = document.getElementById('eventModal');
						
						var span = document.getElementById('close3');
						
						var cancel = document.getElementById('cancelButton3');
						
						// When the user clicks on the button, open the modal 
						modal.style.display = 'block';

						span.onclick = function() {
							modal.style.display = 'none';
						}
						
						cancel.onclick = function() {
							$('#summary3').val('');
					    	$('#startDate3').val('');
					    	$('#endDate4').val('');
							modal.style.display = 'none';
						}
						
 						// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
						    if (event.target == modal) {
						    	$('#summary3').val('');
						    	$('#startDate3').val('');
						    	$('#endDate4').val('');
						        modal.style.display = 'none';
						    }
						}
					}
				});
			},

			change : function(themeSystem) {
				$('#calendar').fullCalendar('option', 'themeSystem', themeSystem);
			}

		});

	});
	
	$(function(){
		$('#insertEvent').on('click',function(){
				startDate1.value = new Date(year1.value, month1.value-1, day1.value, hour1.value, minute1.value);		    	
		    	endDate2.value = new Date(year2.value, month2.value-1, day2.value, hour2.value, minute2.value);
				$.ajax({
					type : 'post',
					url : 'insertEvents',
					data : {
						'userID' : $('#userID1').val(),
						'summary' : $('#summary1').val(),
						'description' : $('#description1').val(),
						'startDate' : $('#startDate1').val(),
						'endDate' : $('#endDate2').val()
					},
					error : function() {
						alert("송신실패");
					}
				});
			});
		});
</script>
<style>
body {
	margin: 0;
	padding: 0;
	font-size: 14px;
}

#top, #calendar.fc-unthemed {
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
}

#top {
	background: #eee;
	border-bottom: 1px solid #ddd;
	padding: 0 10px;
	line-height: 40px;
	font-size: 12px;
	color: #000;
}

#top .selector {
	display: inline-block;
	margin-right: 10px;
}

#top select {
	font: inherit; /* mock what Boostrap does, don't compete  */
}

.left {
	float: left
}

.right {
	float: right
}

.clear {
	clear: both
}

#calendar {
	max-width: 900px;
	margin: 40px auto;
	padding: 0 10px;
}

.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 5; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 50%; /* Could be more or less, depending on screen size */
}

/* The Close Button */
.close {
    color: #aaa;
    float: right;
    font-size: 21px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>
</head>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="main-content-container container-fluid px-4">
	<div class="page-header row no-gutters py-4">
		<div class="col-12 col-sm-4 text-center text-sm-left mb-0">
			<h3 class="page-title">일정표</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-8">
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<h6 class="m-0"></h6>
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item p-3">
						<div class="row">
							<div class="col">
								<div id='calendar'></div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
<div id="insertModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정을 입력해주세요<span id="close1" class="close">&times;</span></h4>
    <form id="eventsDetail">
		<input type="hidden" id="userID1" value="${sessionScope.userID}" />
		<label>제목</label><input type="text" id="summary1" name="summary1"/><br />
		<label>내용</label><input type="text" id="description1" name="description1"/><br />
		<label>시작</label><input type="hidden" id="startDate1" name="startDate1"/>
		<input type="text" name="year1" size="5" maxlength="4" id="year1" />년 
		<input type="text" name="month1" size="3" maxlength="2" id="month1" >월	
        <input type="text" name="day1" size="3" maxlength="2" id="day1" >일
        <input type="text" name="hour1" size="3" maxlength="2" id="hour1" >시
        <input type="text" name="minute1" size="3" maxlength="2" id="minute1" >분<br />           
		<label>마감</label><input type="hidden" id="endDate2" name="endDate2"/>
		<input type="text" name="year2" size="5" maxlength="4" id="year2" />년 
		<input type="text" name="month2" size="3" maxlength="2" id="month2" >월	
        <input type="text" name="day2" size="3" maxlength="2" id="day2" >일
        <input type="text" name="hour2" size="3" maxlength="2" id="hour2" >시
        <input type="text" name="minute2" size="3" maxlength="2" id="minute2" >분
	</form>
	<button type="button" id="insertEvent">일정 입력</button>
	<button type="button" id="cancelButton1">취소</button>
</div>
</div>

<div id="eventModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정을 입력해주세요<span id="close3" class="close">&times;</span></h4>
    <form id="eventsDetail">
		<input type="hidden" id="userID3" value="${sessionScope.userID}" />
		<label>제목</label><input type="text" id="summary3" name="summary3"/><br />
		<label>내용</label><input type="text" id="description3" name="description3"/><br />
		<label>시작</label><input type="hidden" id="startDate3" name="startDate3"/>
		<input type="text" name="year3" size="5" maxlength="4" id="year3" />년 
		<input type="text" name="month3" size="3" maxlength="2" id="month3" >월	
        <input type="text" name="day3" size="3" maxlength="2" id="day3" >일
        <input type="text" name="hour3" size="3" maxlength="2" id="hour3" >시
        <input type="text" name="minute3" size="3" maxlength="2" id="minute3" >분<br />           
		<label>마감</label><input type="hidden" id="endDate4" name="endDate4"/>
		<input type="text" name="year4" size="5" maxlength="4" id="year4" />년 
		<input type="text" name="month4" size="3" maxlength="2" id="month4" >월	
        <input type="text" name="day4" size="3" maxlength="2" id="day4" >일
        <input type="text" name="hour4" size="3" maxlength="2" id="hour4" >시
        <input type="text" name="minute4" size="3" maxlength="2" id="minute4" >분
	</form>
	<button type="button" id="updateEvent">수정</button>
	<button type="button" id="deleteEvent">삭제</button>
	<button type="button" id="cancelButton3">취소</button>
</div>
</div>
  
</div>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>