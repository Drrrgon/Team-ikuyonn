function setLeftSideIcon() {
    $('#navbar').children().eq(0).children().eq(0).attr('class',
            'nav-link ');
    $('#navbar').children().eq(1).children().eq(0).attr('class',
            'nav-link ');
    $('#navbar').children().eq(2).children().eq(0).attr('class',
            'nav-link ');
    $('#navbar').children().eq(3).children().eq(0).attr('class',
            'nav-link ');
    $('#navbar').children().eq(3).children().eq(0).addClass('active');
}
// +버튼 눌렀을 때 열리는 폼
function openInputForm(){
    $('#create_project_div').css('display', 'block');
    $('#joinedProjectDiv').css('display', 'none');
    $('#cloudDiv').css('display', 'none');
    namecardload();
}
//프로젝트 생성 창에서 뒤로가기 버튼 눌렀을 때 작동하는 펑션
function closeCreateProject(){
    $('#create_project_div').css('display', 'none');
    $('#joinedProjectDiv').css('display', 'block');
    $('#cloudDiv').css('display', 'block');
}
// 전체 프로젝트 초기화 
function initAllProjectList() {
    $('#allProjectList').text('');
    var printHtml = '<table class="table mb-0">';
    printHtml += '<thead class="bg-light">';
    printHtml += '<tr>';
    printHtml += '<th scope="col" class="border-0">#</th>';
    printHtml += '<th scope="col" class="border-0">프로젝트 명</th>';
    printHtml += '<th scope="col" class="border-0">기간</th>';
    printHtml += '<th scope="col" class="border-0">참여인원</th>';
    printHtml += '</tr>';
    printHtml += '</thead>';
    printHtml += '<tbody id="allTbody">';
    printHtml += '</tbody>';
    printHtml += '</table>';
    // tbody에 붙임
    $('#allProjectList').html(printHtml);
}
// 참가한 프로젝트 리스트 초기화
function initJoinedProjectList(){
    $('#joinedProjectList').text('');
    var printHtml ='<table class="table mb-0">';
    printHtml += '<thead class="bg-light">';
    printHtml += '<tr>';
    printHtml += '<th scope="col" class="border-0">#</th>';
    printHtml += '<th scope="col" class="border-0">프로젝트 명</th>';
    printHtml += '<th scope="col" class="border-0">기간</th>';
    printHtml += '<th scope="col" class="border-0">참여인원</th>';
    printHtml += '</tr>';
    printHtml += '</thead>';
    printHtml += '<tbody id="joinedTbody">';
    printHtml += '</tbody>';
    printHtml += '</table>';
    $('#joinedProjectList').html(printHtml);
}
// 버튼 기능
function btnFunction() {
    $('#createProjectBtn').on('click', createProject);// 프로젝트 생성 버튼
    $('#backBtn').on('click', closeCreateProject); // 프로젝트 생성 창 내의 뒤로가기 버튼
    $('#joinedProjectListHeader').on('click', function() {// 참가중인 프로젝트 문자열 버튼
        $('#allProjectList').css('display', 'none');
        $('#joinedProjectList').css('display', 'block');
        $('#cloudDiv').css('display', 'none');
    });
    $('#allProjectListHeader').on('click', function() {// 전체 프로젝트 문자열 버튼
        $('#allProjectList').css('display', 'block');
        $('#joinedProjectList').css('display', 'none');
        $('#cloudDiv').css('display', 'none');
        getAllProject();
    });
}