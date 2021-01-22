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
    // document.getElementById('btn_checkID').addEventListener('click', checkID); 동일
    $('#btn_DaumPostcode').on('click', DaumPostcode); // 다음 우편 번호
    $('#btn_close').on('click', setFocus); // Dialog창을 닫은후의 focus 이동
    $('#btn_send').on('click', send); 
  });

  // jQuery ajax 요청
  function checkID() {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    var frm = $('#frm'); // id가 frm인 태그 검색
    var id = $('#member_id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
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
      params = 'id=' + id;
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
            $('#btn_close').attr("data-focus", "member_id");
          } else {
            $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap CSS 변경
            msg = "사용 가능한 ID 입니다.";
            $('#btn_close').attr("data-focus", "member_passwd");
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
      
      // 처리중 출력
  /*     var gif = '';
      gif +="<div style='margin: 0px auto; text-align: center;'>";
      gif +="  <img src='./images/ani04.gif' style='width: 10%;'>";
      gif +="</div>";
      
      $('#panel2').html(gif);
      $('#panel2').show(); // 출력 */
      
    }

  }

  function setFocus() {  // focus 이동
    var tag = $('#btn_close').attr('data-focus'); // 포커스를 적용할 태그 id 가져오기
    $('#' + tag).focus(); // 포커스 지정
  }

  function send() { // 회원 가입 처리
    // 패스워드를 정상적으로 2번 입력했는지 확인
    if ($('#member_passwd').val() != $('#member_passwd2').val()) {
      msg = '입력된 패스워드가 일치하지 않습니다.<br>';
      msg += "패스워드를 다시 입력해주세요.<br>"; 
      
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('패스워드 일치 여부  확인'); // 제목 
      $('#modal_content').html(msg);  // 내용
      $('#modal_panel').modal();         // 다이얼로그 출력
      
      $('#btn_send').attr('data-focus', 'member_passwd');
      
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
    회원 가입
  </DIV>
  <ASIDE class="aside_left">
    * : 필수 입력
  </ASIDE>
  <ASIDE class="aside_right">
    <A href='./create.do'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' id="frm" method='POST' action='./create.do' class="form-horizontal"
          enctype="multipart/form-data">

      <div class="form-group">   
        <label for="member_id" class="col-md-2 control-label">아이디 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_id' id='member_id' value="" placeholder="아이디" required="required" autofocus="autofocus" style="width:80%;">
          <button type='button' id="btn_checkID" class="btn btn-info btn-md">중복확인</button>
          <SPAN id='id_span'></SPAN> <!-- ID 중복 관련 메시지 -->     
        </div>
      </div>

      <div class="form-group">   
        <label for="member_passwd" class="col-md-2 control-label">비밀번호 *</label>
        <div class="col-md-6">
          <input type='password' class="form-control" name='member_passwd'  id='member_passwd' value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_passwd2" class="col-md-2 control-label">비밀번호 확인*</label>
        <div class="col-md-6">
          <input type='password' class="form-control" name='member_passwd2'  id='member_passwd2' value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_name" class="col-md-2 control-label">성명 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_name' value='홍길동' placeholder="이름" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_nickname" class="col-md-2 control-label">닉네임 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_nickname' value='단풍' placeholder="별명" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_isAdult" class="col-md-2 control-label">주민등록번호 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_isAdult' value='8000001234567' placeholder="주민등록번호" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_tel" class="col-md-2 control-label">전화번호 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_tel' value='01012345678' placeholder="전화번호" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_email" class="col-md-2 control-label">이메일 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_email' value='test1@gmail.com' placeholder="이메일" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">
        <label for="member_zipcode" class="col-md-2 control-label" style='font-size: 0.9em;'>우편번호 *</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='member_zipcode' id='member_zipcode' 
                 value='' style='width: 30%;' placeholder="우편번호">
                 <input type="button" id="btn_DaumPostcode" value="우편번호 찾기" class="btn btn-info btn-md">
        </div>
      </div>  
      
      <!-- ---------- DAUM 우편번호 API 시작 ---------- -->
      <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
        <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
      </div>
      
      <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
      <script>
          // 우편번호 찾기 화면을 넣을 element
          var element_wrap = document.getElementById('wrap');
      
          function foldDaumPostcode() {
              // iframe을 넣은 element를 안보이게 한다.
              element_wrap.style.display = 'none';
          }
      
          function DaumPostcode() {
              // 현재 scroll 위치를 저장해놓는다.
              var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
              new daum.Postcode({
                  oncomplete: function(data) {
                      // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
      
                      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                      var fullAddr = data.address; // 최종 주소 변수
                      var extraAddr = ''; // 조합형 주소 변수
      
                      // 기본 주소가 도로명 타입일때 조합한다.
                      if(data.addressType === 'R'){
                          //법정동명이 있을 경우 추가한다.
                          if(data.bname !== ''){
                              extraAddr += data.bname;
                          }
                          // 건물명이 있을 경우 추가한다.
                          if(data.buildingName !== ''){
                              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                          }
                          // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                          fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                      }
      
                      // 우편번호와 주소 정보를 해당 필드에 넣는다.
                      $('#member_zipcode').val(data.zonecode); //5자리 새우편번호 사용 ★
                      $('#member_address1').val(fullAddr);  // 주소 ★
      
                      // iframe을 넣은 element를 안보이게 한다.
                      // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                      element_wrap.style.display = 'none';
      
                      // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                      document.body.scrollTop = currentScroll;
                      
                      $('#member_address2').focus(); //  ★
                  },
                  // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
                  onresize : function(size) {
                      element_wrap.style.height = size.height+'px';
                  },
                  width : '100%',
                  height : '100%'
              }).embed(element_wrap);
      
              // iframe을 넣은 element를 보이게 한다.
              element_wrap.style.display = 'block';
          }
      </script>
      <!-- ---------- DAUM 우편번호 API 종료 ---------- -->
    
      <div class="form-group">   
        <label for="member_address1" class="col-md-2 control-label">주소 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_address1' id='member_address1' value='' placeholder="주소" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_address2" class="col-md-2 control-label">상세 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_address2' id='member_address2' value='' placeholder="주소" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">
        <label for="file1MF" class="col-md-2 control-label">프로필사진</label>
        <div class="col-md-6">
          <%-- 실제 컬럼명: member_profilepic, Spring File 객체 대응: fiel1MF --%>
          <input type='file' class="form-control" name='file1MF' id='file1MF' 
                 value='' placeholder="파일 선택" multiple="multiple">
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
 
  