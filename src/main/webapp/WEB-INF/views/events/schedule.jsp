<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="../parts/meta.jsp" %> 
<title>일정표</title>
<!-- header -->
<%@ include file="../parts/header.jsp" %>
<link href='./resources/styles/fullcalendar.min.css' rel='stylesheet' />
<link href='./resources/styles/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='./resources/styles/scheduler.min.css' rel='stylesheet' />
<style>
.fc-license-message{
	display : none;
	z-index : 0;
}

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
	margin: 15px auto;
	padding: 0 10px;
}

.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1070; /* Sit on top */
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
    margin-top: 10%;
    padding: 20px;
    border: 1px solid #888;
    width: 50%; /* Could be more or less, depending on screen size */
    top:0;
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
<%@ include file="../parts/loadFirst-js.jsp" %>

<body class="h-100">
	<!-- sidebar -->
	<%@ include file="../parts/sidebar.jsp" %>
	<div class="main-content-container container-fluid px-4">
		<div class="col-lg-12 mt-4">
			<div class="card card-small mb-4">
				<!-- <div class="card-header border-bottom">
					<h3 class="m-0">일정표</h3>
				</div> -->
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
	<h4 class="modal-title">일정을 입력해주세요<span id="close1" class="close"></span></h4>
    <form id="insertForm">
    	<!-- <span>기간 반복</span><input type="radio" id="repeatTerm" name="repeatCode" value="repeatTerm">
    	<span>매일 반복</span><input type="radio" id="repeatDaily" name="repeatCode" value="repeatDaily"> -->
		<input type="hidden" id="userID1" value="${sessionScope.userID}" />
		<label>제목</label><input type="text" id="summary1" name="summary1" /><br />
		<label>내용</label><input type="text" id="description1" name="description1"/><br />

		<br/><span>색깔지정</span>
		<button class="jscolor {valueElement:null,value:'66ccff'}" style="width:50px; height:20px;" id="color1">
		</button><br/>

		<!-- <select name='color1' id='color1'></select>색깔 지정&nbsp;<br> -->

		<label>시작</label><input type="hidden" id="startDate1" name="startDate1"/>
    	<select name='year1' id='year1' onChange='setDate()'></select>년&nbsp;
    	<select name='month1' id='month1' onChange='setDate()'></select>월&nbsp;
    	<select name='day1' id='day1'></select>일&nbsp;
		<select name='hour1' id='hour1'></select>시&nbsp;
		<select name='minute1' id='minute1'></select>분&nbsp;<br>           
		<label>마감</label><input type="hidden" id="endDate2" name="endDate2"/>
    	<select name='year2' id='year2' onChange='setDate()'></select>년&nbsp;
    	<select name='month2' id='month2' onChange='setDate()'></select>월&nbsp;
    	<select name='day2' id='day2'></select>일&nbsp;
		<select name='hour2' id='hour2'></select>시&nbsp;
		<select name='minute2' id='minute2'></select>분&nbsp; 
	</form>
	<button type="button" id="insertEvents">일정 입력</button>
	<button type="button" id="cancelButton1">취소</button>
</div>
</div>

<div id="eventModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정입니다<span id="close3" class="close"></span></h4>
    <form id="eventDetail">
    <!-- <input type="hidden" id="projectSeq1" name="projectSeq1"/> -->
    <label>제목</label><input type="text" id="summary3" name="summary3"/><br/>
	<label>내용</label><input type="text" id="description3" name="description3"/><br/>
	<br/><span>색깔지정</span>
	<button class="jscolor {valueElement:null, value:'66ccff'}" style="width:50px; height:20px;" id="color3">
	</button><br/>
	<label>시작</label><input type="hidden" id="startDate3" name="startDate3"/>
	<select name="year3" id="year3" onChange="setDate()"></select>년&nbsp;
	<select name="month3" id="month3" onChange="setDate()"></select>월&nbsp;
	<select name="day3" id="day3"></select>일&nbsp;
	<select name="hour3" id="hour3"></select>시&nbsp;
	<select name="minute3" id="minute3"></select>분&nbsp;<br>
	<label>마감</label><input type="hidden" id="endDate4" name="endDate4"/>
	<select name="year4" id="year4" onChange="setDate()"></select>년&nbsp;
	<select name="month4" id="month4" onChange="setDate()"></select>월&nbsp;
	<select name="day4" id="day4"></select>일&nbsp;
	<select name="hour4" id="hour4"></select>시&nbsp;
	<select name="minute4" id="minute4"></select>분&nbsp;
	<input data-uno="updateEvents" type="button" id="updateEvents" value="수정"/>
	<input data-dno="deleteEvents" type="button" id="deleteEvents" value="삭제"/>
    </form>
    
	<button type="button" id="cancelButton3">취소</button>
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
			$('#navbar').children().eq(0).children().eq(0).addClass('active');
	}
	
	$(function() {
		setLeftSideIcon();
		
		$("#colorPicker").click(function(){
			alert($("#colorPicker").css('background-color'));
		});
		
		initThemeChooser({	
			
			init : function(themeSystem) {
		        $('#calendar').fullCalendar({
					themeSystem : themeSystem,
					locale : 'ko',
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
					timezone : 'local',
					timeFormat: 'h(:mm)',
					eventLimit: 5,
					/* resourceLabelText : 'Rooms',
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
					} ], */
					events : function(start, end, timezone, callback){
						var events = [];
						
						$.ajax({
							type : 'post',
							url : 'privateEvents',
  							data : {
								'userID' : $('#userID1').val()
							},
							success : function(data) {
								$(data).each(function(index, item) {	
									events.push({
										id : item.userID,
										title : item.summary,
										start : item.startDate,
										end : item.endDate,
										num : item.eventSeq,
										color : item.color
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
						var dateC = date.format();
						var yearC = dateC.substring(0, 4);
						var monthC = dateC.substring(5, 7);
						var dayC = dateC.substring(8, 10);
						if(monthC<10)
							monthC = dateC.substring(6, 7);
						if(dayC<10)
							dayC = dateC.substring(9, 10);
						
						var modal = document.getElementById('insertModal');
						var span = document.getElementById('close1');
						var cancel = document.getElementById('cancelButton1');
						
						modal.style.display = 'block';
						$("#insertModal").css({
							'overflow' : 'hidden',
							'height' : '100%'
						});
						
						span.onclick = function() {
							$('#summary1').val('');
					    	$('#description1').val('');
					    	$('#color1').val('');
							modal.style.display = 'none';
						}
						
						cancel.onclick = function() {
							$('#summary1').val('');
					    	$('#description1').val('');
					    	$('#color1').val('');
							modal.style.display = 'none';
						}
						
						window.onclick = function(event) {
						    if (event.target == modal) {
						    	$('#summary1').val('');
						    	$('#description1').val('');
						    	$('#color1').val('');
						        modal.style.display = 'none';
						    }
						}
						
						var insertForm = document.getElementById('insertForm');
						
							    var year = yearC;
							    var month = monthC;
							    var day = dayC;
							    var hour = new Date().getHours();
							    var minute = new Date().getMinutes();
							    var color = $('#color1').val();
							    
							    var startYear = year - 80;
							    for(var i=0; i<100; i++) {
							    	insertForm['year1'].options[i] = new Option(startYear+i, startYear+i);
							    	insertForm['year2'].options[i] = new Option(startYear+i, startYear+i);
							    }

							    for (var i=0; i<12; i++) {
							    	insertForm['month1'].options[i] = new Option(i+1, i+1);
							    	insertForm['month2'].options[i] = new Option(i+1, i+1);
							    }
							    
							    for (var i=0; i<24; i++) {
							    	insertForm['hour1'].options[i] = new Option(i+1, i+1);
							    	insertForm['hour2'].options[i] = new Option(i+1, i+1);
							    }
							    
							    for (var i=0; i<60; i++) {
							    	insertForm['minute1'].options[i] = new Option(i+1, i+1);
							    	insertForm['minute2'].options[i] = new Option(i+1, i+1);
							    }
							    
							    insertForm['year1'].value = year;
							    insertForm['year2'].value = year;
							    insertForm['month1'].value = month;
							    insertForm['month2'].value = month;
							    setDate();
							    insertForm['day1'].value = day;
							    setDate();
							    insertForm['day2'].value = day;
							    insertForm['hour1'].value = hour;
							    insertForm['hour2'].value = hour;
							    insertForm['minute1'].value = minute;
							    insertForm['minute2'].value = minute;
						
				 		function setDate() {
							var insertForm = document.getElementById('insertForm');
							
							var year = insertForm['year1'].value;
						    var month = insertForm['month1'].value;
						    var day = insertForm['day1'].value;
						    var dayInsert1 = insertForm['day1'];
						    var dayInsert2 = insertForm['day2'];
						    
						    var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

						    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
						        arrayMonth[1] = 29;
						    }

						    for(var i = dayInsert1.length; i>0; i--) {
						    	dayInsert1.remove(dayInsert1.selectedIndex);
						    }
						        
						    for (var i = 1; i<=arrayMonth[month-1]; i++) {
						    	dayInsert1.options[i-1] = new Option(i, i);
						    }

						    if(day != null || day != '') {
						        if(day > arrayMonth[month-1]) {
						        	dayInsert1.options.selectedIndex = arrayMonth[month-1]-1;
						        } else {
						        	dayInsert1.options.selectedIndex = day-1;
						        }
						    }
						    
						    for(var i = dayInsert2.length; i>0; i--) {
						    	dayInsert2.remove(dayInsert2.selectedIndex);
						    }
						        
						    for (var i = 1; i<=arrayMonth[month-1]; i++) {
						    	dayInsert2.options[i-1] = new Option(i, i);
						    }

						    if(day != null || day != '') {
						        if(day > arrayMonth[month-1]) {
						        	dayInsert2.options.selectedIndex = arrayMonth[month-1]-1;
						        } else {
						        	dayInsert2.options.selectedIndex = day-1;
						        }
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
								var newEnd = new Date(data.endDate);
								
								// document.getElementById("projectSeq1").value = data.projectSeq;
								
								$("#summary3").val(data.summary);
								$("#description3").val(data.description);
								$("#startDate3").val(newStart);
								$("#year3").val(startYear);
								$("#endDate4").val(newEnd);
								$("#updateEvents").attr('data-uno', data.eventSeq);
								$("#deleteEvents").attr('data-dno', data.eventSeq);
								/* var eventDetail = '';
								eventDetail += '<label>제목</label><input type="text" id="summary3" name="summary3" value="'+data.summary+'"/><br/>';
								eventDetail += '<label>내용</label><input type="text" id="description3" name="description3" value="'+data.description+'"/><br/>';
								eventDetail += '<br/><p>색깔지정</p>';
								eventDetail += '<button class="jscolor {valueElement:null, value:"66ccff"}" style="width:50px; height:20px;" id="color3">';
								eventDetail += '</button><br/>';
								eventDetail += '<label>시작</label><input type="hidden" id="startDate3" name="startDate3" value="'+newStart+'"/>';
								eventDetail += '<select name="year3" id="year3" onChange="setDate()" value="'+startYear+'"></select>년&nbsp';
								eventDetail += '<select name="month3" id="month3" onChange="setDate()"></select>월&nbsp';
								eventDetail += '<select name="day3" id="day3"></select>일&nbsp';
								eventDetail += '<select name="hour3" id="hour3"></select>시&nbsp';
								eventDetail += '<select name="minute3" id="minute3"></select>분&nbsp';
								eventDetail += '<label>마감</label><input type="hidden" id="endDate4" name="endDate4" value="'+newEnd+'"/>';
								eventDetail += '<select name="year4" id="year4" onChange="setDate()"></select>년&nbsp';
								eventDetail += '<select name="month4" id="month4" onChange="setDate()"></select>월&nbsp';
								eventDetail += '<select name="day4" id="day4"></select>일&nbsp';
								eventDetail += '<select name="hour4" id="hour4"></select>시&nbsp';
								eventDetail += '<select name="minute4" id="minute4"></select>분&nbsp';
								eventDetail += '<input class="updateEvents" data-uno="'+data.eventSeq+'" type="button" id="updateEvent" value="수정" onclick="location.reload()"/>';
								eventDetail += '<input class="deleteEvents" data-dno="'+data.eventSeq+'" type="button" id="deleteEvent" value="삭제" onclick="location.reload()"/>';
								
								$('#eventDetail').html(eventDetail); */		
								var eventDetail = document.getElementById('eventDetail');
								var startDate3 = new Date(document.getElementById('startDate3').value);
								var endDate4 = new Date(document.getElementById('endDate4').value);
								var year = new Date().getFullYear();
								var year3 = startDate3.getFullYear();
								var month3 = startDate3.getMonth() + 1;
								var day3 = startDate3.getDate();
								var hour3 = startDate3.getHours();
								var minute3 = startDate3.getMinutes();
								var year4 = endDate4.getFullYear();
								var month4 = endDate4.getMonth() + 1;
								var day4 = endDate4.getDate();
								var hour4 = endDate4.getHours();
								var minute4 = endDate4.getMinutes();
									    
								var startYear = year - 80;
								for(var i=0; i<100; i++) {
									eventDetail['year3'].options[i] = new Option(startYear+i, startYear+i);
									eventDetail['year4'].options[i] = new Option(startYear+i, startYear+i);
								}

								for (var i=0; i<12; i++) {
									 eventDetail['month3'].options[i] = new Option(i+1, i+1);
									 eventDetail['month4'].options[i] = new Option(i+1, i+1);
								}
									    
								for (var i=0; i<24; i++) {
									 eventDetail['hour3'].options[i] = new Option(i+1, i+1);
									 eventDetail['hour4'].options[i] = new Option(i+1, i+1);
								}
									    
								for (var i=0; i<60; i++) {
									 eventDetail['minute3'].options[i] = new Option(i+1, i+1);
									 eventDetail['minute4'].options[i] = new Option(i+1, i+1);
								}
								
								setDate0();
								eventDetail['year3'].value = year3;
								setDate0();
								eventDetail['year4'].value = year4;
								setDate0();
								eventDetail['month3'].value = month3;
								setDate0();
								eventDetail['month4'].value = month4;
								setDate0();
								eventDetail['day3'].value = day3;
								setDate0();
								eventDetail['day4'].value = day4;
								eventDetail['hour3'].value = hour3;
								eventDetail['hour4'].value = hour4;
								eventDetail['minute3'].value = minute3;
								eventDetail['minute4'].value = minute4;

								function setDate0() {
									var eventDetail = document.getElementById('eventDetail');
										
									var year = eventDetail['year3'].value;
									var month = eventDetail['month3'].value;
									var day = eventDetail['day3'].value;
									var dayInsert3 = eventDetail['day3'];
									var dayInsert4 = eventDetail['day4'];
									    
									var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

									if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
									   arrayMonth[1] = 29;
									}
									
									for(var i = dayInsert3.length; i>0; i--) {
								    	dayInsert3.remove(dayInsert3.selectedIndex);
								    }
								        
								    for (var i = 1; i<=arrayMonth[month-1]; i++) {
								    	dayInsert3.options[i-1] = new Option(i, i);
								    }

								    if(day != null || day != '') {
								        if(day > arrayMonth[month-1]) {
								        	dayInsert3.options.selectedIndex = arrayMonth[month-1]-1;
								        } else {
								        	dayInsert3.options.selectedIndex = day-1;
								        }
								    }
								    
								    for(var i = dayInsert4.length; i>0; i--) {
								    	dayInsert4.remove(dayInsert4.selectedIndex);
								    }
								        
								    for (var i = 1; i<=arrayMonth[month-1]; i++) {
								    	dayInsert4.options[i-1] = new Option(i, i);
								    }

								    if(day != null || day != '') {
								        if(day > arrayMonth[month-1]) {
								        	dayInsert4.options.selectedIndex = arrayMonth[month-1]-1;
								        } else {
								        	dayInsert4.options.selectedIndex = day-1;
								        }
								    }
								}
								/* $("input:button.updateEvents").click(updateEvents);
								$("input:button.deleteEvents").click(deleteEvents); */
								if(data.userID != $('#userID1').val()){
									$('#updateEvents').attr("disabled", true);
									$('#deleteEvents').attr("disabled", true);
								} else{
									$('#updateEvents').attr("disabled", false);
									$('#deleteEvents').attr("disabled", false);
								}
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
							modal.style.display = 'none';
						}
						
 						// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
						    if (event.target == modal) {
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
		$('#updateEvents').on('click', updateEvents);
		$('#deleteEvents').on('click', deleteEvents);
	});
	
	/* var serviceStr="";
	var service = document.getElementsByName("repeat");
	for(var i=0; i<service.length; i++){
		if(service[i].checked==true){
			serviceStr=service[i].value;
			
		}
	}
	
	var colorArray = ['red', 'tomato', 'yellow', 'green', 'blue'];

    for (var i=0; i<colorArray.length; i++) {
    	insertForm['color1'].options[i] = new Option(colorArray[i], colorArray[i]);
    	// insertForm['color1'].options = colorArray[i];
    } */
	
	function insertEvents(){
    			if($('#summary1').val() == '' || $('#description1').val() == ''){
    				alert('일정 입력이 잘못되었습니다!');
		    		return false;
    			}
    			/* var startDate1 = document.getElementById('startDate1');
    			var endDate2 = document.getElementById('endDate2'); */
				var sd = new Date(year1.value, month1.value-1, day1.value, hour1.value, minute1.value);	
		    	var ed = new Date(year2.value, month2.value-1, day2.value, hour2.value, minute2.value);
		    	if(ed < sd){
		    		alert('날짜 입력이 잘못되었습니다!');
		    		return false;
		    	}
		    	
		    	var eventData = {
		    			'userID' : $('#userID1').val(),
						'summary' : $('#summary1').val(),
						'description' : $('#description1').val(),
						'startDate' : sd,
						'endDate' : ed,
						'color' : $('#color1').css("background-color")
		    	}
		    	
				$.ajax({
					type : 'post',
					url : 'insertEvents',
					data : eventData, 
					success : function(data){
						if(data == '1'){
						var modal1 = document.getElementById('insertModal');
						modal1.style.display = 'none';
						$("#insertModal").css({'overflow': 'hidden', 'height': '100%'});
						$("#calendar").fullCalendar('refetchEvents');}
						$('#summary1').val('');
				    	$('#description1').val('');
				    	$('#color1').val('');
					},
					error : function() {
						// alert("송신실패");
					}
				});
			}
	
   		function updateEvents(){
   				var eventSeq = $(this).attr("data-uno");
				var summary3 = $('#summary3').val();
				var description3 = $('#description3').val();
				var startDate = document.getElementById('startDate3');
    			var endDate = document.getElementById('endDate4');
				if(summary3 == '' || description3 == ''){
    				alert('일정 입력이 잘못되었습니다!');
		    		return false;
    			}
				var color3 = $('#color3').css("background-color");
				var startDate0 = new Date(year3.value, month3.value-1, day3.value, hour3.value, minute3.value);
		    	var endDate0 = new Date(year4.value, month4.value-1, day4.value, hour4.value, minute4.value);
		    	if(endDate0 < startDate0){
		    		alert('날짜 입력이 잘못되었습니다!');
		    		return false;
		    	}
		    	
				$.ajax({
					type : 'post',
					url : 'updateEvents',
					data : {'eventSeq' : eventSeq, 'summary' : summary3, 'description' : description3,
							'startDate' : startDate0, 'endDate' : endDate0, 'color' : color3},
					success : function(data){
						if(data == '1'){
						var modal2 = document.getElementById('eventModal');
						modal2.style.display = 'none';
						$("#calendar").fullCalendar('refetchEvents');}
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
						if(data == '1'){
						var modal3 = document.getElementById('eventModal');
						modal3.style.display = 'none';
						$("#calendar").fullCalendar('refetchEvents');}
					},	
					error : function() {
						// alert("송신실패");
					}
				});
			}
</script>
<script src="./resources/js/jscolor.js"></script>
<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/footer.jsp" %>
</body>
</html>