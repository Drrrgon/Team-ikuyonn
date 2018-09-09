<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="../parts/meta.jsp" %> 
<title>메이시</title>
<!-- header -->
<%@ include file="../parts/header.jsp" %>
<style>
    .deleteProject{
        opacity: 0.7;
    }
    .listBottom{
        position:relative; 
        height: 300px; 
    }
    .projectListBottom{
        text-align: right;
        position: fixed; 
        bottom:0px;
        right:0px;   
    }
    button.createProject.btn{
        opacity: 0.7;
    }
    .writeForm{
        display: none;
        text-align: right;
    }
    .writeForm2{
        text-align: right;
    }
    #projectName{
        width: 230px;
    }
    #projectList{
        text-align: center;
    }
    #allProjectLis-cover{
        display: none;
    }
    .tableProjectName{
        width: 390px;
    }
    .table_project_deleteBtn{
        width: 50px;
    }
</style>
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/loadFirst-js.jsp" %>
</head>
<body class="h-100">
	<!-- sidebar -->

<div class="main-content-container container-fluid px-4">
	<div class="page-header row no-gutters py-4">
		<div class="col-12 col-sm-4 text-center text-sm-left mb-0">
			<h3 class="page-title">Project</h3>
		</div>
	</div>
	<div class="row" id="row1">
		<div class="col-lg-12">
			<div class="card card-small mb-4">
                <div id="joinedProjectList">
                    <div id="projectList" class="center col-md-8">      
                    </div>
                    <div class="listBottom">
                        <div id="projectListBottom" class="projectListBottom center col-md-8">
                            <span class="writeForm2"><button id="openCreateProjectBtn" class="createProject btn btn-accent">프로젝트 생성</button></span>
                                <span class="writeForm"><input id="projectName" type="text"><button id="createProjectBtn" class="createProject btn btn-accent">생성</button></span>
                        </div>	
                    </div>
                    <button id="openProjectListBtn" class="createProject btn btn-accent">전체 프로젝트</button>
                </div>
                <div id="allProjectLis-cover">
                    <div id="allProjectList" class="center col-md-8">      
                    </div>
                    
                    <button id="closeProjectListBtn" class="createProject btn btn-accent">창 닫기</button>
                </div>
			</div>
		</div>
	</div>	
</div>
<script>
    $(function(){
        init();
        
        $('#openCreateProjectBtn').on('click', openCreateProject);
        $('#createProjectBtn').on('click', createProject);
        $('#openProjectListBtn').on('click', openProjectList);
        $('#closeProjectListBtn').on('click', closeProjectList);
    });

    function init(){
        getJoinedProjectName();
    };
    function getJoinedProjectName(){
        var sessionID = "${sessionScope.userID}";
        $.ajax({
            url: 'getprojectInfo',
            type: 'post',
            data: {
                'userID' : sessionID
            },
            success: printProjectList
        });
    };
    function getAllProjectList(){
        $.ajax({
            url: 'getprojectInfo',
            type: 'post',
            success: printAllProjectList
        });
    }
    function printProjectList(projectList){
        $('#projectList').text('');
        var printProjectHtml = "";
        printProjectHtml += '<br/>';
        printProjectHtml += '<table id="joinedProjectListTable" border="0">';
        $('#projectList').append(printProjectHtml);
            if(projectList.length == 0){
                printProjectHtml += '<tr>';
                printProjectHtml += '<td colspan="2" class="tableProjectName">';
                printProjectHtml += "참여중인 프로젝트가 없습니다.";
                printProjectHtml += '</td>';
                printProjectHtml += '<td class="table_project_deleteBtn">';
                printProjectHtml += '</td>';
                printProjectHtml += '</tr>';
                $('#joinedProjectListTable').append(printProjectHtml);
            }
        for (let i = 0; i < projectList.length; i++) {
            printProjectHtml = "";
            printProjectHtml += '<tr>';
            printProjectHtml += '<td class="tableProjectName">';
            printProjectHtml += projectList[i].projectName;
            printProjectHtml += '</td>';
            printProjectHtml += '<td class="table_project_deleteBtn">';
            printProjectHtml += '<button class="deleteProjectBtn btn btn-accent" data-project-seq="'+projectList[i].projectSeq+'">삭제</button>';
            printProjectHtml += '</td>';
            printProjectHtml += '</tr>';
            $('#joinedProjectListTable').append(printProjectHtml);
        }
        $('.deleteProjectBtn').on('click', deleteProject);
    }
    function printAllProjectList(projectList){
        $('#allProjectList').text('');
        var printProjectHtml = "";
        printProjectHtml += '<br/>';
        printProjectHtml += '<table id="allProjectListTable" border="0">';
        $('#allProjectList').append(printProjectHtml);
            if(projectList.length == 0){
                printProjectHtml += '<tr>';
                printProjectHtml += '<td colspan="2" class="tableProjectName">';
                printProjectHtml += "프로젝트가 없습니다.";
                printProjectHtml += '</td>';
                printProjectHtml += '<td class="table_project_deleteBtn">';
                printProjectHtml += '</td>';
                printProjectHtml += '</tr>';
                $('#allProjectListTable').append(printProjectHtml);
            }
        for (let i = 0; i < projectList.length; i++) {
            printProjectHtml = "";
            printProjectHtml += '<tr>';
            printProjectHtml += '<td class="tableProjectName">';
            printProjectHtml += projectList[i].projectName;
            printProjectHtml += '</td>';
            printProjectHtml += '<td class="table_project_deleteBtn">';
            printProjectHtml += '<button class="joinProjectBtn btn btn-accent" data-project-seq="'+projectList[i].projectSeq+'">참가</button>';
            printProjectHtml += '</td>';
            printProjectHtml += '</tr>';
            $('#allProjectListTable').append(printProjectHtml);
        }
        $('.joinProjectBtn').on('click', joinProject);
    }
    function joinProject(){
        var sessionID = "${sessionScope.userID}";
        var projectSeq = $(this).attr('data-project-seq');
        console.log(projectSeq);
        var flag = confirm('정말로 삭제하시겠습니까?');
        if(flag){
            $.ajax({
               url: 'deleteProject',
               type: 'post',
               data: {
                  'userID': sessionID, 'projectSeq': projectSeq
               },
               success: printProjectList
            });
        }
    };
    function openCreateProject(){
        $('.writeForm').css('display', 'block');
        $('.writeForm2').css('display', 'none');
    };

     function closeCreateProject(){
        $('.writeForm').css('display', 'none');
        $('.writeForm2').css('display', 'block');
        // $('#projectListBottom').css('text-align', 'right');
    }

    function openProjectList(){    
        $('#allProjectLis-cover').css('display', 'block');
        $('#joinedProjectList').css('display', 'none');
        getAllProjectList();
    }

    function closeProjectList(){
        $('#allProjectLis-cover').css('display', 'none');
        $('#joinedProjectList').css('display', 'block');
    }

    function createProject(){
        var projectName = $('#projectName').val();
        if(projectName.length == 0){
            alert('프로젝트 명을 입력해 주세요!');
            $('#projectName').focus();
            $('#projectName').select();
            return false;
        }
        if(projectName.length > 15){
            alert('프로젝트 명을 15자 이하로입력해 주세요!');
            $('#projectName').focus();
            $('#projectName').select();
            return false;
        }
        var sessionID = "${sessionScope.userID}";
        $.ajax({
            url: 'createProject',
            type: 'post',
            data: {
                'userID': sessionID, 'projectName': projectName
            },
            success: function(list){
                printProjectList(list);
                $('#projectName').val('');
                closeCreateProject();
            }
        });
    }
    
    function deleteProject(){
        var sessionID = "${sessionScope.userID}";
        var projectSeq = $(this).attr('data-project-seq');
        console.log(projectSeq);
        var flag = confirm('정말로 삭제하시겠습니까?');
        if(flag){
            $.ajax({
               url: 'deleteProject',
               type: 'post',
               data: {
                  'userID': sessionID, 'projectSeq': projectSeq
               },
               success: printProjectList
            });
        }
    };

    
</script>
<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
</body>
</html>