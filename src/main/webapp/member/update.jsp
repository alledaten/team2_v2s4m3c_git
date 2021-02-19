<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
    $('#btn_DaumPostcode').on('click', DaumPostcode); // 다음 우편 번호
    $('#btn_send').on('click', send); 
  });

  function send() { // 수정 처리
    // 패스워드를 입력했는지 확인
    if ($('#member_passwd').val().length <= 0) {
      msg = "패스워드를 입력해주세요.<br>"; 
      
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('패스워드 확인'); // 제목 
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
  
  <DIV class='title_line'>
    회원
  </DIV>
  <ASIDE class="aside_left">
    <A href='./list.do'>회원 목록</A> > 
    <A href='./read.do?member_no=${param.member_no}'>회원 정보</A> > 수정
  </ASIDE>
  <ASIDE class="aside_right">
    <A href='./list.do'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' id="frm" method='POST' action='./update.do' class="form-horizontal"
          enctype="multipart/form-data">
      <input type="hidden" name="member_no" value="${memberVO.member_no}" >

      <div class="form-group">   
        <label for="member_id" class="col-md-2 control-label">아이디 *</label>
        <div class="col-md-6">
          <input type="text" class="form-control" name='member_id' id='member_id' value="${memberVO.member_id }" readonly="readonly"  style="width:80%;">
        </div>
      </div>

      <div class="form-group">
        <label for="member_passwd" class="col-md-2 control-label">비밀번호 *</label>
        <div class="col-md-6">
          <input type='password' class="form-control" name='member_passwd'  id='member_passwd' value='' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_name" class="col-md-2 control-label">성명 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_name' value='${memberVO.member_name }' placeholder="이름" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_nickname" class="col-md-2 control-label">닉네임 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_nickname' value='${memberVO.member_nickname}' placeholder="별명" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_isAdult" class="col-md-2 control-label">주민등록번호 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_isAdult' value='${memberVO.member_isAdult }' placeholder="주민등록번호" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_tel" class="col-md-2 control-label">전화번호 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_tel' value='${memberVO.member_tel }' placeholder="전화번호" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_email" class="col-md-2 control-label">이메일 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_email' value='${memberVO.member_email}' placeholder="이메일" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">
        <label for="member_zipcode" class="col-md-2 control-label" style='font-size: 0.9em;'>우편번호</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='member_zipcode' id='member_zipcode' 
                 value='${memberVO.member_zipcode }' style='width: 30%;' placeholder="우편번호">
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
        <label for="member_address1" class="col-md-2 control-label">주소</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_address1' id='member_address1' value='${memberVO.member_address1}' placeholder="주소" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="member_address2" class="col-md-2 control-label">상세주소</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='member_address2' id='member_address2' value=''${memberVO.member_address2} placeholder="주소" style='width: 80%;'>
        </div>
      </div>
      
      <div class="form-group">
        <label for="file1MF" class="col-md-2 control-label">프로필사진</label>
        <div class="col-md-6">
          <%-- 실제 컬럼명: member_profilepic, Spring File 객체 대응: fiel1MF --%>
          <imb src="./storage/profile_image/${memberVO.member_profilethumb}">
          <input type='file' class="form-control" name='file1MF' id='file1MF' 
                    value='' placeholder="파일 선택" multiple="multiple">
        </div>
      </div>
      
      <div class="form-group">
        <label for="memberlevel" class="col-md-2 control-label">등급</label>
        <c:set var="memberlevel_no" value="${memberVO.memberlevel_no}" />
        <div class="col-md-6">
          <select name="memberlevel_no">
            <c:forEach var="vo" items="${memberlevelList}">
              <option value="${vo.memberlevel_no}" ${ vo.memberlevel_no == memberlevel_no ? "selected='selected'": "" } >${vo.memberlevel_name}</option>
            </c:forEach>
         </select>
        </div>
      </div>
      
      <DIV class='content_bottom_menu'>
        <button type="button" id="btn_send" class="btn btn-info">수정</button>
        <button type="button" 
                onclick="location.href='./list.do'" 
                class="btn btn-info">취소</button>
      </DIV>
       
    </FORM>
  </DIV>

  
  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

