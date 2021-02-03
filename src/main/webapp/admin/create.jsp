<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 커뮤니티</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
  $(function() { // 자동 실행
    // id가 'btn_send'인 태그를 찾아 'click' 이벤트 처리자(핸들러)로 send 함수를 등록
    $('#btn_checkID').on('click', checkID);  
    $('#btn_close').on('click', setFocus); // Dialog창을 닫은후의 focus 이동
    $('#btn_send').on('click', send); 
  });

  /********************* ID 중복체크 ***********************/
  function checkID() {
    var frm = $('#frm'); // id가 frm인 태그 검색
    var id = $('#admin_id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = '';
    var msg = '';

    if ($.trim(id).length == 0) { // id를 입력받지 않은 경우
      msg = 'ID를 입력하세요.<br>ID 입력은 필수 입니다.<br>ID는 3자이상 권장합니다.';
      
      $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
      $('#modal_title').html('ID 중복 확인'); // 제목 
      $('#modal_content').html(msg);        // 내용
      $('#modal_panel').modal();              // 다이얼로그 출력
      return false;
    } else {  // when ID is entered
      params = 'admin_id=' + id;
      // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
      // alert('params: ' + params);

      $.ajax({
        url: './checkID.do', // spring execute
        type: 'get',  // post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = "";
          
          if (rdata.cnt > 0) {
            $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
            msg = "이미 사용중인 ID 입니다.";
            $('#btn_close').attr("data-focus", "admin_id");
          } else {
            $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap CSS 변경
            msg = "사용 가능한 ID 입니다.";
            $('#btn_close').attr("data-focus", "admin_passwd");
            // $.cookie('checkId', 'TRUE'); // Cookie 기록
          }
          
          $('#modal_title').html('ID 중복 확인'); // 제목 
          $('#modal_content').html(msg);        // 내용
          $('#modal_panel').modal();              // 다이얼로그 출력
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR\n';
          msg += 'request.status: '+request.status + '\n';
          msg += 'message: '+error;
          console.log(msg);
        }
      });
      
    }

  }

  function setFocus() {  // focus 이동
    var tag = $('#btn_close').attr('data-focus'); // 포커스를 적용할 태그 id 가져오기
    $('#' + tag).focus(); // 포커스 지정
  }

  /**************** 전송 *******************/
  function send() { // 회원 가입 처리
    // 패스워드를 정상적으로 2번 입력했는지 확인
    if ($('#admin_passwd').val() != $('#admin_passwd2').val()) {
      msg = '입력된 패스워드가 일치하지 않습니다.<br>';
      msg += "패스워드를 다시 입력해주세요.<br>"; 
      
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('패스워드 일치 여부  확인'); // 제목 
      $('#modal_content').html(msg);  // 내용
      $('#modal_panel').modal();         // 다이얼로그 출력
      
      $('#btn_send').attr('data-focus', 'admin_passwd');
      
      return false; // submit 중지
    }
  
    $('#frm').submit();
  }

</script>
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <!-- ********** Modal 알림창 시작 ********** -->
  <div id="modal_panel" class="modal fade"  role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
        </div>
        <div class="modal-footer">
          <button type="button" id="btn_close" data-focus="" class="btn btn-default" 
                  data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  <!-- ********** Modal 알림창 종료 ********** -->
  <DIV class="title_line">
    관리자 등록
  </DIV>
  <ASIDE class="aside_left">
    * : 필수 입력
  </ASIDE>
  <ASIDE class="aside_right">
    <A href='./list.do'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' id="frm" method='POST' action='./create.do' class="form-horizontal"
          enctype="multipart/form-data">

      <div class="form-group">   
        <label for="admin_id" class="col-md-2 control-label">아이디 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='admin_id' id='admin_id' value="" placeholder="아이디" required="required" autofocus="autofocus" style="width:80%;">
          <button type='button' id="btn_checkID" class="btn btn-info btn-md">중복확인</button>
          <SPAN id='id_span'></SPAN> <!-- ID 중복 관련 메시지 -->     
        </div>
      </div>

      <div class="form-group">   
        <label for="admin_passwd" class="col-md-2 control-label">비밀번호 *</label>
        <div class="col-md-6">
          <input type='password' class="form-control" name='admin_passwd'  id='admin_passwd' value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="admin_passwd2" class="col-md-2 control-label">비밀번호 확인*</label>
        <div class="col-md-6">
          <input type='password' class="form-control" name='admin_passwd2'  id='admin_passwd2' value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="admin_name" class="col-md-2 control-label">관리자명 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='admin_name' value='관리자' placeholder="관리자명" required="required" style='width: 80%;'>
        </div>
      </div>
      
      <DIV class='content_bottom_menu'>
        <button type="button" id="btn_send" class="btn btn-info">가입</button>
        <button type="button" 
                onclick="location.href='./list.do'" 
                class="btn btn-info">취소</button>
      </DIV>
       
    </FORM>
  </DIV>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
  