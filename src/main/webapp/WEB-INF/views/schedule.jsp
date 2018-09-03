<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="parts/meta.jsp" %> 
<title>일정표</title>
<!-- header -->
<%@ include file="parts/header.jsp" %>
<link href='./resources/styles/fullcalendar.min.css' rel='stylesheet' />
<link href='./resources/styles/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='./resources/styles/scheduler.min.css' rel='stylesheet' />
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
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/loadFirst-js.jsp" %>

<body class="h-100">
	<!-- sidebar -->
	<%@ include file="parts/sidebar.jsp" %>
	
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
    <form>
		<input type="hidden" id="userID1" value="${sessionScope.userID}" />
		<label>제목</label><input type="text" id="summary1" name="summary1" /><br />
		<label>내용</label><input type="text" id="description1" name="description1"/><br />
		<label>시작</label><input type="hidden" id="startDate1" name="startDate1"/>
		<input type="text" name="year1" size="5" maxlength="4" id="year1" />년 
		<input type="text" name="month1" size="3" maxlength="2" id="month1"/>월	
        <input type="text" name="day1" size="3" maxlength="2" id="day1"/>일
        <input type="text" name="hour1" size="3" maxlength="2" id="hour1" />시
        <input type="text" name="minute1" size="3" maxlength="2" id="minute1" />분<br />           
		<label>마감</label><input type="hidden" id="endDate2" name="endDate2"/>
		<input type="text" name="year2" size="5" maxlength="4" id="year2" />년 
		<input type="text" name="month2" size="3" maxlength="2" id="month2" />월	
        <input type="text" name="day2" size="3" maxlength="2" id="day2" />일
        <input type="text" name="hour2" size="3" maxlength="2" id="hour2" />시
        <input type="text" name="minute2" size="3" maxlength="2" id="minute2" />분
	</form>
	<button type="button" id="insertEvents" onclick="location.reload()">일정 입력</button>
	<button type="button" id="cancelButton1">취소</button>
</div>
</div>

<div id="eventModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정입니다<span id="close3" class="close">&times;</span></h4>
    <form id="eventDetail"></form>
	<button type="button" id="cancelButton3">취소</button>
</div>
</div>
  
</div>

<script src='./resources/scripts/moment.min.js'></script>
<script src='./resources/scripts/fullcalendar.min.js'></script>
<script src='./resources/scripts/scheduler.min.js'></script>
<script src='./resources/scripts/theme-chooser.js'></script>
<script>
document.getElementById("year1").value = new Date().getFullYear();
document.getElementById("month1").value = new Date().getMonth() + 1;
document.getElementById("day1").value = new Date().getDate();
document.getElementById("hour1").value = new Date().getHours();
document.getElementById("minute1").value = new Date().getMinutes();
document.getElementById("year2").value = new Date().getFullYear();
document.getElementById("month2").value = new Date().getMonth() + 1;
document.getElementById("day2").value = new Date().getDate();
document.getElementById("hour2").value = new Date().getHours();
document.getElementById("minute2").value = new Date().getMinutes();

function setLeftSideIcon(){
			$('#navbar').children().eq(0).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(1).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(2).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(3).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(4).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(5).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(2).children().eq(0).addClass('active');
	}
	
	$(function() {
		setLeftSideIcon();
		
		initThemeChooser({	
			
			init : function(themeSystem) {
		        $('#calendar').fullCalendar({
					themeSystem : themeSystem,
					lang : 'ko',
					eventStartEditable : false, // enable draggable events
					eventDurationEditable : true,
					aspectRatio : 1.8,
					scrollTime : '00:00', // undo default 6am scrollTime
					header : {
						left : 'today prev,next',
						center : 'title',
						right : 'month,agendaWeek,timelineDay,listWeek'
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
  							data : {
								'userID' : $('#userID1').val()
							},
							success : function(data) {								
								var events = [];
								for(var index in data){
									if(data[index].userID=='<%=session.getAttribute("userID")%>'){
										var eColor = 'green';
									}
								}
								$(data).each(function(index, item) {
									events.push({
										id : item.userID,
										title : item.summary,
										start : item.startDate,
										end : item.endDate,
										num : item.eventSeq,
										color : eColor
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
						var eventSeq = event.num;
						
						$.ajax({
							type : 'post',
							url : 'oneEvents',
  							data : {
								'eventSeq' : eventSeq
							},
							success : function(data) {
								var newStart = new Date(data.startDate);
								var startYear = newStart.getFullYear();
								var startMonth = newStart.getMonth() + 1;
								var startDay = newStart.getDate();
								var startHour = newStart.getHours();
								var startMinute = newStart.getMinutes();
								var newEnd = new Date(data.endDate);
								var endYear = newEnd.getFullYear();
								var endMonth = newEnd.getMonth() + 1;
								var endDay = newEnd.getDate();
								var endHour = newEnd.getHours();
								var endMinute = newEnd.getMinutes();								
								
								var eventDetail = '';
								eventDetail += '<label>제목</label><input type="text" id="summary3" name="summary3" value="'+data.summary+'"/><br/>';
								eventDetail += '<label>내용</label><input type="text" id="description3" name="description3" value="'+data.description+'"/><br/>';
								eventDetail += '<label>시작</label><input type="hidden" id="startDate3" name="startDate3"/>';
								eventDetail += '<input type="text" name="year3" size="5" maxlength="4" id="year3" value="'+startYear+'"/>년 ';
								eventDetail += '<input type="text" name="month3" size="3" maxlength="2" id="month3" value="'+startMonth+'">월';
								eventDetail += '<input type="text" name="day3" size="3" maxlength="2" id="day3" value="'+startDay+'">일';
								eventDetail += '<input type="text" name="hour3" size="3" maxlength="2" id="hour3" value="'+startHour+'">시';
								eventDetail += '<input type="text" name="minute3" size="3" maxlength="2" id="minute3" value="'+startMinute+'">분<br/> ';
								eventDetail += '<label>마감</label><input type="hidden" id="endDate4" name="endDate4"/>';
								eventDetail += '<input type="text" name="year4" size="5" maxlength="4" id="year4" value="'+endYear+'"/>년 ';
								eventDetail += '<input type="text" name="month4" size="3" maxlength="2" id="month4" value="'+endMonth+'">월';
								eventDetail += '<input type="text" name="day4" size="3" maxlength="2" id="day4" value="'+endDay+'">일';
								eventDetail += '<input type="text" name="hour4" size="3" maxlength="2" id="hour4" value="'+endHour+'">시';
								eventDetail += '<input type="text" name="minute4" size="3" maxlength="2" id="minute4" value="'+endMinute+'">분<br/>';     						        
								eventDetail += '<input class="updateEvents" data-uno="'+data.eventSeq+'" type="button" id="updateEvent" value="수정" onclick="location.reload()"/>';
								eventDetail += '<input class="deleteEvents" data-dno="'+data.eventSeq+'" type="button" id="deleteEvent" value="삭제" onclick="location.reload()"/> ';
								
								$('#eventDetail').html(eventDetail);
								$("input:button.updateEvents").click(updateEvents);
								$("input:button.deleteEvents").click(deleteEvents);
							},
							error : function() {
								alert("수신실패");
							}
						});
						
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

		$('#insertEvents').on('click', insertEvents);
	});
	
	function insertEvents(){
				startDate1.value = new Date(year1.value, month1.value-1, day1.value, hour1.value, minute1.value);	
		    	endDate2.value = new Date(year2.value, month2.value-1, day2.value, hour2.value, minute2.value);
		    	// alert(startDate1.value + '\n' + endDate2.value);
		    	if(startDate1.value < endDate2.value){
		    		alert('날짜 입력이 잘못되었습니다!');
		    		return false;
		    	}
		    	
		    	var eventData = {
		    			'userID' : $('#userID1').val(),
						'summary' : $('#summary1').val(),
						'description' : $('#description1').val(),
						'startDate' : $('#startDate1').val(),
						'endDate' : $('#endDate2').val()
		    	}
		    	
				$.ajax({
					type : 'post',
					url : 'insertEvents',
					data : eventData, 
					success : function(data){
						if(data == 'success'){
						var modal1 = document.getElementById('insertModal');
						modal1.style.display = 'none';}
					},
					error : function() {
						// alert("송신실패");
					}
				});
			}
	
   		function updateEvents(){
   				// var aaa = $('#summary3').attr('value');	alert(aaa);
				var eventSeq = $(this).attr('data-uno');
				var summary3 = $('#summary3').val();
				var description3 = $('#description3').val();
				startDate3.value = new Date(year3.value, month3.value-1, day3.value, hour3.value, minute3.value);
		    	endDate4.value = new Date(year4.value, month4.value-1, day4.value, hour4.value, minute4.value);
		    	// alert(startDate3.value + '\n' + endDate4.value);
		    	if(startDate3.value < endDate4.value){
		    		alert('날짜 입력이 잘못되었습니다!');
		    		return false;
		    	}
		    	
				$.ajax({
					type : 'post',
					url : 'updateEvents',
					data : {'eventSeq' : eventSeq, 'summary' : summary3, 'description' : description3,
							'startDate' : startDate3.value, 'endDate' : endDate4.value},
					success : function(data){
						if(data == 'success'){
						var modal2 = document.getElementById('eventModal');
						modal2.style.display = 'none';}
					},
					error : function() {
						// alert("송신실패");
					}
				});
			}
	
		function deleteEvents(){
				var eventSeq = $(this).attr("data-dno");
				
				$.ajax({
					type : 'get',
					url : 'deleteEvents',
					data : {'eventSeq' : eventSeq},
					success : function(data){
						if(data == 'success'){
						var modal3 = document.getElementById('eventModal');
						modal3.style.display = 'none';}
					},	
					error : function() {
						// alert("송신실패");
					}
				});
			}
</script>
<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/footer.jsp" %>
</body>
</html>