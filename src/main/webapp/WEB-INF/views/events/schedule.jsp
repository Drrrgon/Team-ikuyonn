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
    margin: 10% auto; /* 15% from the top and centered */
    margin-top: 6%;
    padding: 30px;
    border: 1px solid #888;
	width: 40%; /* Could be more or less, depending on screen size */
	top :0;
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
	<h4 class="modal-title">일정을 입력해주세요<span id="insertClose" class="close"></span></h4><br>
    <form id="insertForm">
    	<!-- <span>기간 반복</span><input type="radio" id="repeatTerm" name="repeatCode" value="repeatTerm">
    	<span>매일 반복</span><input type="radio" id="repeatDaily" name="repeatCode" value="repeatDaily"> -->
		<input type="hidden" id="insertUserID" value="${sessionScope.userID}" />
		<label>제목</label><input type="text" class='form-control' id="insertSummary" name="insertSummary" /><br>
		<label>내용</label><input type="text" class='form-control' id="insertDescription" name="insertDescription"/>

		<br/><span>색깔지정</span>
		<button class="jscolor {valueElement:null,value:'66ccff'}" style="width:50px; height:20px;" id="insertColor">
		</button><br/><br>

		<!-- <select name='insertColor' id='insertColor'></select>색깔 지정&nbsp;<br> -->

		<label>시작</label><input type="hidden" id="insertStartDate" name="insertStartDate"/>
    	<select name='insertStartYear' id='insertStartYear' onChange='setDate()'></select>년&nbsp;
    	<select name='insertStartMonth' id='insertStartMonth' onChange='setDate()'></select>월&nbsp;
    	<select name='insertStartDay' id='insertStartDay'></select>일&nbsp;
		<select name='insertStartHour' id='insertStartHour'></select>시&nbsp;
		<select name='insertStartMinute' id='insertStartMinute'></select>분&nbsp;<br>           
		<label>마감</label><input type="hidden" id="insertEndDate" name="insertEndDate"/>
    	<select name='insertEndYear' id='insertEndYear' onChange='setDate()'></select>년&nbsp;
    	<select name='insertEndMonth' id='insertEndMonth' onChange='setDate()'></select>월&nbsp;
    	<select name='insertEndDay' id='insertEndDay'></select>일&nbsp;
		<select name='insertEndHour' id='insertEndHour'></select>시&nbsp;
		<select name='insertEndMinute' id='insertEndMinute'></select>분&nbsp; <br>
	</form>
	<button type="button" class="btn btn-primary" id="insertEvents" style="width:200px; margin:auto;">일정 입력</button>
</div>
</div>

<div id="eventModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정입니다<span id="updateClose" class="close"></span></h4><br>
    <form id="eventDetail">
    <!-- <input type="hidden" id="projectSeq1" name="projectSeq1"/> -->
    <label>제목</label><input type="text" id="updateSummary" name="updateSummary" class='form-control' /><br>
	<label>내용</label><input type="text" id="updateDescription" name="updateDescription" class='form-control' />
	<br/><span>색깔지정</span>
	<button class="jscolor {valueElement:null, value:'66ccff'}" style="width:50px; height:20px;" id="updateColor">
	</button><br/><br/>
	<label>시작</label><input type="hidden" id="updateStartDate" name="updateStartDate"/>
	<select name="updateStartYear" id="updateStartYear" onChange="setDate0()"></select>년&nbsp;
	<select name="updateStartMonth" id="updateStartMonth" onChange="setDate0()"></select>월&nbsp;
	<select name="updateStartDay" id="updateStartDay"></select>일&nbsp;
	<select name="updateStartHour" id="updateStartHour"></select>시&nbsp;
	<select name="updateStartMinute" id="updateStartMinute"></select>분&nbsp;<br/>
	<label>마감</label><input type="hidden" id="updateEndDate" name="updateEndDate"/>
	<select name="updateEndYear" id="updateEndYear" onChange="setDate0()"></select>년&nbsp;
	<select name="updateEndMonth" id="updateEndMonth" onChange="setDate0()"></select>월&nbsp;
	<select name="updateEndDay" id="updateEndDay"></select>일&nbsp;
	<select name="updateEndHour" id="updateEndHour"></select>시&nbsp;
	<select name="updateEndMinute" id="updateEndMinute"></select>분&nbsp;<br>
	<center>
	<input data-uno="updateEvents" class="btn btn-primary" type="button" id="updateEvents" style="width:200px" value="수정"/>
	<input data-dno="deleteEvents" class="btn btn-primary" type="button" id="deleteEvents" style="width:200px" value="삭제"/>
	</center>
    </form>
</div>
</div>
  

<script src='./resources/scripts/moment.min.js'></script>
<script src='./resources/scripts/fullcalendar.min.js'></script>
<script src='./resources/scripts/scheduler.min.js'></script>
<script src='./resources/scripts/theme-chooser.js'></script>
<script>
document.getElementById("insertStartYear").value = new Date().getFullYear();
document.getElementById("insertStartMonth").value = new Date().getMonth() + 1;
document.getElementById("insertStartDay").value = new Date().getDate();
document.getElementById("insertStartHour").value = new Date().getHours();
document.getElementById("insertStartMinute").value = new Date().getMinutes();
document.getElementById("insertEndYear").value = new Date().getFullYear();
document.getElementById("insertEndMonth").value = new Date().getMonth() + 1;
document.getElementById("insertEndDay").value = new Date().getDate();
document.getElementById("insertEndHour").value = new Date().getHours();
document.getElementById("insertEndMinute").value = new Date().getMinutes();

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
					eventStartEditable : false, // enable draggable events
					eventDurationEditable : true,
					aspectRatio : 1.8,
					scrollTime : '00:00',
					header : {
						left : 'today prev,next',
						center : 'title',
						right : 'month,listWeek'
					},
					defaultView : 'month',
					timezone : 'local',
					timeFormat: 'h(:mm)',
					eventLimit: 5,
					events : function(start, end, timezone, callback){
						var events = [];
						
						$.ajax({
							type : 'post',
							url : 'privateEvents',
  							data : {
								'userID' : $('#insertUserID').val()
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
						var span = document.getElementById('insertClose');
						
						modal.style.display = 'block';
						$("#insertModal").css({
							'overflow' : 'hidden',
							'height' : '100%'
						});
						
						span.onclick = function() {
							$('#insertSummary').val('');
					    	$('#insertDescription').val('');
					    	$('#insertColor').val('');
							modal.style.display = 'none';
						}
						
						window.onclick = function(event) {
						    if (event.target == modal) {
						    	$('#insertSummary').val('');
						    	$('#insertDescription').val('');
						    	$('#insertColor').val('');
						        modal.style.display = 'none';
						    }
						}
						
						var insertForm = document.getElementById('insertForm');
						
							    var year = yearC;
							    var month = monthC;
							    var day = dayC;
							    var hour = new Date().getHours();
							    var minute = new Date().getMinutes();
							    var color = $('#insertColor').val();
							    
							    var startYear = year - 80;
							    for(var i=0; i<100; i++) {
							    	insertForm['insertStartYear'].options[i] = new Option(startYear+i, startYear+i);
							    	insertForm['insertEndYear'].options[i] = new Option(startYear+i, startYear+i);
							    }

							    for (var i=0; i<12; i++) {
							    	insertForm['insertStartMonth'].options[i] = new Option(i+1, i+1);
							    	insertForm['insertEndMonth'].options[i] = new Option(i+1, i+1);
							    }
							    
							    for (var i=0; i<24; i++) {
							    	insertForm['insertStartHour'].options[i] = new Option(i, i);
							    	insertForm['insertEndHour'].options[i] = new Option(i, i);
							    }
							    
							    for (var i=0; i<60; i++) {
							    	insertForm['insertStartMinute'].options[i] = new Option(i, i);
							    	insertForm['insertEndMinute'].options[i] = new Option(i, i);
							    }
							    
							    insertForm['insertStartYear'].value = year;
							    insertForm['insertEndYear'].value = year;
							    insertForm['insertStartMonth'].value = month;
							    insertForm['insertEndMonth'].value = month;
							    setDate();
							    insertForm['insertStartDay'].value = day;
							    setDate();
							    insertForm['insertEndDay'].value = day;
							    insertForm['insertStartHour'].value = hour;
							    insertForm['insertEndHour'].value = hour;
							    insertForm['insertStartMinute'].value = minute;
							    insertForm['insertEndMinute'].value = minute;
					
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
								
								$("#updateSummary").val(data.summary);
								$("#updateDescription").val(data.description);
								$("#updateStartDate").val(newStart);
								$("#updateStartYear").val(startYear);
								$("#updateEndDate").val(newEnd);
								$("#updateEvents").attr('data-uno', data.eventSeq);
								$("#deleteEvents").attr('data-dno', data.eventSeq);
								/* var eventDetail = '';
								eventDetail += '<label>제목</label><input type="text" id="updateSummary" name="updateSummary" value="'+data.summary+'"/><br/>';
								eventDetail += '<label>내용</label><input type="text" id="updateDescription" name="updateDescription" value="'+data.description+'"/><br/>';
								eventDetail += '<br/><p>색깔지정</p>';
								eventDetail += '<button class="jscolor {valueElement:null, value:"66ccff"}" style="width:50px; height:20px;" id="updateColor">';
								eventDetail += '</button><br/>';
								eventDetail += '<label>시작</label><input type="hidden" id="updateStartDate" name="updateStartDate" value="'+newStart+'"/>';
								eventDetail += '<select name="updateStartYear" id="updateStartYear" onChange="setDate()" value="'+startYear+'"></select>년&nbsp';
								eventDetail += '<select name="updateStartMonth" id="updateStartMonth" onChange="setDate()"></select>월&nbsp';
								eventDetail += '<select name="updateStartDay" id="updateStartDay"></select>일&nbsp';
								eventDetail += '<select name="updateStartHour" id="updateStartHour"></select>시&nbsp';
								eventDetail += '<select name="updateStartMinute" id="updateStartMinute"></select>분&nbsp';
								eventDetail += '<label>마감</label><input type="hidden" id="updateEndDate" name="updateEndDate" value="'+newEnd+'"/>';
								eventDetail += '<select name="updateEndYear" id="updateEndYear" onChange="setDate()"></select>년&nbsp';
								eventDetail += '<select name="updateEndMonth" id="updateEndMonth" onChange="setDate()"></select>월&nbsp';
								eventDetail += '<select name="updateEndDay" id="updateEndDay"></select>일&nbsp';
								eventDetail += '<select name="updateEndHour" id="updateEndHour"></select>시&nbsp';
								eventDetail += '<select name="updateEndMinute" id="updateEndMinute"></select>분&nbsp';
								eventDetail += '<input class="updateEvents" data-uno="'+data.eventSeq+'" type="button" id="updateEvent" value="수정" onclick="location.reload()"/>';
								eventDetail += '<input class="deleteEvents" data-dno="'+data.eventSeq+'" type="button" id="deleteEvent" value="삭제" onclick="location.reload()"/>';
								
								$('#eventDetail').html(eventDetail); */		
								var eventDetail = document.getElementById('eventDetail');
								var updateStartDate = new Date(document.getElementById('updateStartDate').value);
								var updateEndDate = new Date(document.getElementById('updateEndDate').value);
								var year = new Date().getFullYear();
								var updateStartYear = updateStartDate.getFullYear();
								var updateStartMonth = updateStartDate.getMonth() + 1;
								var updateStartDay = updateStartDate.getDate();
								var updateStartHour = updateStartDate.getHours();
								var updateStartMinute = updateStartDate.getMinutes();
								var updateEndYear = updateEndDate.getFullYear();
								var updateEndMonth = updateEndDate.getMonth() + 1;
								var updateEndDay = updateEndDate.getDate();
								var updateEndHour = updateEndDate.getHours();
								var updateEndMinute = updateEndDate.getMinutes();
									    
								var startYear = year - 80;
								for(var i=0; i<100; i++) {
									eventDetail['updateStartYear'].options[i] = new Option(startYear+i, startYear+i);
									eventDetail['updateEndYear'].options[i] = new Option(startYear+i, startYear+i);
								}

								for (var i=0; i<12; i++) {
									 eventDetail['updateStartMonth'].options[i] = new Option(i+1, i+1);
									 eventDetail['updateEndMonth'].options[i] = new Option(i+1, i+1);
								}
									    
								for (var i=0; i<24; i++) {
									 eventDetail['updateStartHour'].options[i] = new Option(i, i);
									 eventDetail['updateEndHour'].options[i] = new Option(i, i);
								}
									    
								for (var i=0; i<60; i++) {
									 eventDetail['updateStartMinute'].options[i] = new Option(i, i);
									 eventDetail['updateEndMinute'].options[i] = new Option(i, i);
								}
								
								setDate0();
								eventDetail['updateStartYear'].value = updateStartYear;
								setDate0();
								eventDetail['updateEndYear'].value = updateEndYear;
								setDate0();
								eventDetail['updateStartMonth'].value = updateStartMonth;
								setDate0();
								eventDetail['updateEndMonth'].value = updateEndMonth;
								setDate0();
								eventDetail['updateStartDay'].value = updateStartDay;
								setDate0();
								eventDetail['updateEndDay'].value = updateEndDay;
								eventDetail['updateStartHour'].value = updateStartHour;
								eventDetail['updateEndHour'].value = updateEndHour;
								eventDetail['updateStartMinute'].value = updateStartMinute;
								eventDetail['updateEndMinute'].value = updateEndMinute;

								/* $("input:button.updateEvents").click(updateEvents);
								$("input:button.deleteEvents").click(deleteEvents); */
								if(data.userID != $('#insertUserID').val()){
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
						var span = document.getElementById('updateClose');
						
						// When the user clicks on the button, open the modal 
						modal.style.display = 'block';
						
						
						span.onclick = function() {
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
    	insertForm['insertColor'].options[i] = new Option(colorArray[i], colorArray[i]);
    	// insertForm['insertColor'].options = colorArray[i];
    } */
	
	function insertEvents(){
    			if($('#insertSummary').val() == '' || $('#insertDescription').val() == ''){
    				alert('일정 입력이 잘못되었습니다!');
		    		return false;
    			}
    			/* var insertStartDate = document.getElementById('insertStartDate');
    			var insertEndDate = document.getElementById('insertEndDate'); */
				var checkInsertStart = new Date(insertStartYear.value, insertStartMonth.value-1, insertStartDay.value, insertStartHour.value, insertStartMinute.value);	
		    	var checkInsertEnd = new Date(insertEndYear.value, insertEndMonth.value-1, insertEndDay.value, insertEndHour.value, insertEndMinute.value);
		    	if(checkInsertEnd < checkInsertStart){
		    		alert('날짜 입력이 잘못되었습니다!');
		    		return false;
		    	}
		    	
		    	var eventData = {
		    			'userID' : $('#insertUserID').val(),
						'summary' : $('#insertSummary').val(),
						'description' : $('#insertDescription').val(),
						'startDate' : checkInsertStart,
						'endDate' : checkInsertEnd,
						'color' : $('#insertColor').css("background-color")
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
						$('#insertSummary').val('');
				    	$('#insertDescription').val('');
				    	$('#insertColor').val('');
					},
					error : function() {
						// alert("송신실패");
					}
				});
			}
	
   		function updateEvents(){
   				var eventSeq = $(this).attr("data-uno");
				var updateSummary = $('#updateSummary').val();
				var updateDescription = $('#updateDescription').val();
				/* var startDate = document.getElementById('updateStartDate');
    			var endDate = document.getElementById('updateEndDate'); */
				if(updateSummary == '' || updateDescription == ''){
    				alert('일정 입력이 잘못되었습니다!');
		    		return false;
    			}
				var updateColor = $('#updateColor').css("background-color");
				var checkUpdateStart = new Date(updateStartYear.value, updateStartMonth.value-1, updateStartDay.value, updateStartHour.value, updateStartMinute.value);
		    	var checkUpdateEnd = new Date(updateEndYear.value, updateEndMonth.value-1, updateEndDay.value, updateEndHour.value, updateEndMinute.value);
		    	if(checkUpdateEnd < checkUpdateStart){
		    		alert('날짜 입력이 잘못되었습니다!');
		    		return false;
		    	}
		    	
				$.ajax({
					type : 'post',
					url : 'updateEvents',
					data : {'eventSeq' : eventSeq, 'summary' : updateSummary, 'description' : updateDescription,
							'startDate' : checkUpdateStart, 'endDate' : checkUpdateEnd, 'color' : updateColor},
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
		
		function setDate() {
			var insertForm = document.getElementById('insertForm');
			
			var year = insertForm['insertStartYear'].value;
		    var month = insertForm['insertStartMonth'].value;
		    var day = insertForm['insertStartDay'].value;
		    var dayInsertStart = insertForm['insertStartDay'];
		    var dayInsertEnd = insertForm['insertEndDay'];
		    
		    var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

		    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
		        arrayMonth[1] = 29;
		    }

		    for(var i = dayInsertStart.length; i>0; i--) {
		    	dayInsertStart.remove(dayInsertStart.selectedIndex);
		    }
		        
		    for (var i = 1; i<=arrayMonth[month-1]; i++) {
		    	dayInsertStart.options[i-1] = new Option(i, i);
		    }

		    if(day != null || day != '') {
		        if(day > arrayMonth[month-1]) {
		        	dayInsertStart.options.selectedIndex = arrayMonth[month-1]-1;
		        } else {
		        	dayInsertStart.options.selectedIndex = day-1;
		        }
		    }
		    
		    for(var i = dayInsertEnd.length; i>0; i--) {
		    	dayInsertEnd.remove(dayInsertEnd.selectedIndex);
		    }
		        
		    for (var i = 1; i<=arrayMonth[month-1]; i++) {
		    	dayInsertEnd.options[i-1] = new Option(i, i);
		    }

		    if(day != null || day != '') {
		        if(day > arrayMonth[month-1]) {
		        	dayInsertEnd.options.selectedIndex = arrayMonth[month-1]-1;
		        } else {
		        	dayInsertEnd.options.selectedIndex = day-1;
		        }
		    }
	}
		
		function setDate0() {
			var eventDetail = document.getElementById('eventDetail');
				
			var year0 = eventDetail['updateStartYear'].value;
			var month0 = eventDetail['updateStartMonth'].value;
			var day0 = eventDetail['updateStartDay'].value;
			var dayUpdateStart = eventDetail['updateStartDay'];
			var year1 = eventDetail['updateEndYear'].value;
			var month1 = eventDetail['updateEndMonth'].value;
			var day1 = eventDetail['updateEndDay'].value;
			var dayUpdateEnd = eventDetail['updateEndDay'];
			    
			var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

			if ((year0 % 4 == 0 && year0 % 100 != 0) || year0 % 400 == 0) {
			   arrayMonth[1] = 29;
			}
			
			for(var i = dayUpdateStart.length; i>0; i--) {
		    	dayUpdateStart.remove(dayUpdateStart.selectedIndex);
		    }
		        
		    for (var i = 1; i<=arrayMonth[month0-1]; i++) {
		    	dayUpdateStart.options[i-1] = new Option(i, i);
		    }

		    if(day0 != null || day0 != '') {
		        if(day0 > arrayMonth[month0-1]) {
		        	dayUpdateStart.options.selectedIndex = arrayMonth[month0-1]-1;
		        } else {
		        	dayUpdateStart.options.selectedIndex = day0-1;
		        }
		    }
		    
		    if ((year1 % 4 == 0 && year1 % 100 != 0) || year1 % 400 == 0) {
				   arrayMonth[1] = 29;
				}
		    
		    for(var i = dayUpdateEnd.length; i>0; i--) {
		    	dayUpdateEnd.remove(dayUpdateEnd.selectedIndex);
		    }
		        
		    for (var i = 1; i<=arrayMonth[month1-1]; i++) {
		    	dayUpdateEnd.options[i-1] = new Option(i, i);
		    }

		    if(day1 != null || day1 != '') {
		        if(day1 > arrayMonth[month1-1]) {
		        	dayUpdateEnd.options.selectedIndex = arrayMonth[month1-1]-1;
		        } else {
		        	dayUpdateEnd.options.selectedIndex = day1-1;
		        }
		    }
		}
</script>
<script src="./resources/js/jscolor.js"></script>
<script src="./resources/js/ja.js"></script>
<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/footer.jsp" %>
</body>
</html>