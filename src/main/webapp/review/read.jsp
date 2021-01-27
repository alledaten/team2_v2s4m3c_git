<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰 조회</title>

<link href="../css/common.css" rel="Stylesheet" type="text/css">
<link href="../css/menu.css" rel="Stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  // 첨부 이미지 출력, dir: ../attachfile/storage/, ./storage/main_images/
  function panel_img(dir, file) {
    var tag = "";
    tag   = "<A href=\"javascript: $('#review_attachfile_panel').hide();\">"; // 이미지 감추기
    tag += "  <IMG src='" + dir + file + "' style='width: 100%;'>";
    tag += "</A>";

    $('#review_attachfile_panel').html(tag);  // 문자열을 태그로 적용
    $('#review_attachfile_panel').show();      // 패널 출력
  }

</script>


<script type="text/javascript">  
  //-------------------- 댓글 관련 시작 --------------------
  
  var frm_review_reply = $('#frm_review_reply');
  $('#review_no', frm_review_reply).on('click', check_login);             // 댓글 작성시 로그인 여부 확인
  $('#btn_create', frm_review_reply).on('click', review_reply_create);  // 댓글 작성시 로그인 여부 확인
  
  list_by_review_no_join(); // 댓글 목록
  // list_by_review_no_join_add(); // 댓글 페이징 지원 목록, 동시 접속시 페이징 문제 있음.
  
  // $("#btn_add").on("click", list_by_review_no_join_add); // 더보기 버튼 이벤트 등록, 페이징 문제 있음.
  $("#btn_add").on("click", list_by_review_no_join_add_pg); // 더보기 버튼 이벤트 등록

  // 댓글 작성시 로그인 여부 확인
  function check_login() {
    var frm_review_reply = $('#frm_review_reply');
    if ($('#member_no', frm_review_reply).val().length == 0 ) {
      $('#modal_review_title').html('댓글 등록');                                  // 제목 
      $('#modal_review_reply_content').html("로그인해야 등록 할 수 있습니다."); // 내용
      $('#modal_panel').modal();                                           // 다이얼로그 출력
      return false;                                                            // 실행 종료
    }
  }

  //댓글 등록
  function review_reply_create() {
    var frm_review_reply = $('#frm_review_reply');
    
    if (check_login() !=false) { // 로그인 한 경우만 처리
      var params = frm_review_reply.serialize();
      // alert(params);
      // return;

      // 자바스크립트: 영숫자, 한글, 공백, 특수문자: 글자수 1로 인식
      // 오라클: 한글 1자가 3바이트임으로 300자로 제한
      // alert('내용 길이: ' + $('#content', frm_reply).val().length);
      // return;
      
      if ($('#review_reply_content', frm_review_reply).val().length > 300) {
        $('#modal_review_title').html('댓글 등록');                                                  // 제목 
        $('#modal_review_reply_content').html("댓글 내용은 300자이상 입력 할 수 없습니다.");  // 내용
        $('#modal_panel').modal();                                                          // 다이얼로그 출력
        return;                                                                                  // 실행 종료
      }

      $.ajax({
        url: "../review_reply/create.do", // action 대상 주소
        type: "post",          // get, post
        cache: false,          // 브러우저의 캐시영역 사용안함.
        async: true,           // true: 비동기
        dataType: "json",   // 응답 형식: json, xml, html...
        data: params,        // 서버로 전달하는 데이터
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = ""; // 메시지 출력
          var tag = ""; // 글목록 생성 태그
          
          if (rdata.cnt > 0) {
            $('#modal_review_reply_content').attr('class', 'alert alert-success'); // CSS 변경
            msg = "댓글을 등록했습니다.";
            $('#modal_review_reply_content', frm_review_reply).val('');
            $('#modal_review_reply_passwd', frm_review_reply).val('');

            // list_by_contentsno_join(); // 댓글 목록을 새로 읽어옴
            
            $('#review_reply_list').html(''); // 댓글 목록 패널 초기화, val(''): 안됨
            $("#review_reply_list").attr("data-replypage", 1);  // 댓글이 새로 등록됨으로 1로 초기화
            
            // list_by_contentsno_join_add(); // 페이징 댓글, 페이징 문제 있음.
            // alert('댓글 목록 읽기 시작');
            global_rdata = new Array(); // 댓글을 새로 등록했음으로 배열 초기화
            list_by_review_no_join(); // 페이징 댓글
          } else {
            $('#modal_review_reply_content').attr('class', 'alert alert-danger'); // CSS 변경
            msg = "댓글 등록에 실패했습니다.";
          }
          
          $('#modal_review_title').html('댓글 등록'); // 제목 
          $('#modal_review_reply_content').html(msg);     // 내용
          $('#modal_panel').modal();           // 다이얼로그 출력
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR request.status: '+request.status + '/ ' + error;
          console.log(msg); // Chrome에 출력
        }
      });
    }
  }

  // --------------------- 댓글 출력 관련 시작 --------------------- 
  var global_rdata = new Array(); // 내용 저장
  var global_rdata_cnt = 0;         // 현재 출력한 댓글의 수, 1 page = 10개 레코드, 11개인 경우 중간 종료

  // Reply class 선언
  // {"memberno":3,"rdate":"2020-12-17 15:16:16.0","passwd":"18","replyno":32,"id":"user1","content":"18","contentsno":53}
  function Review_Reply(member_no, review_reply_date, review_reply_no, member_id, review_reply_content, review_no) {
    this.member_no = member_no;
    this.review_reply_date = review_reply_date;
    this.review_reply_no = review_reply_no;
    this.member_id = member_id;
    this.review_reply_content = review_reply_content;
    this.review_no = review_no;
  }
  
  // review_no별 포함된 댓글 전체 목록
  function list_by_review_no_join() {
    var params = 'review_no=' + ${reviewVO.review_no };

    $.ajax({
      url: "../review_reply/list_by_review_no_join.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = '';
        
        $('#review_reply_list').html(''); // 패널 초기화, val(''): 안됨
        
        for (i=0; i < rdata.list.length; i++) {
          var row = rdata.list[i];
          // alert(row.replyno);
          var review_reply = new Review_Reply(row.member_no, row.review_reply_date, row.review_reply_no, row.member_id, row.review_reply_content, row.review_no); // 객체 생성
          global_rdata.push(review_reply); // 배열에 저장
        }

        // alert('페이징된 댓글 목록 읽기 시작');
        list_by_review_no_join_add_pg() // javascript paging
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
  }

//contentsno 별 소속된 댓글 목록
  function list_by_review_no_join_add_pg() {
    var review_reply_page = parseInt($("#review_reply_list").attr("data-replypage")); // 1, 2, 3...
    var end = review_reply_page * 5;     // 5, 10, 15...
    var start = end - 5;             // 0, 5, 10..., 배열 index는 0부터 시작 
    var msg="";

    for (var i=start; i < end; i++) {
      global_rdata_cnt = global_rdata_cnt + 1; // DIV 태그에 글 출력 카운트
      if (global_rdata.length < global_rdata_cnt ) { // 1 page = 10개 레코드, 11개인 경우 중간 종료
        break;
      }

      var row = global_rdata[i]; // 배열에서 글 1건 산출
          
      msg += "<DIV member_id='"+row.review_reply_no+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
      msg += "<span style='font-weight: bold;'>" + row.member_id + "</span>";
      msg += "  " + row.rdate;
      if ('${sessionScope.member_no}' == row.member_no) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
        msg += " <A href='javascript:review_reply_delete("+row.review_reply_no+")'><IMG src='./images/delete.png'></A>";
      }
      msg += "  " + "<br>";
      msg += row.review_reply_content;
      msg += "</DIV>";
    }
    // alert(msg);
    $('#review_reply_list').append(msg);
    $("#review_reply_list").attr("data-replypage", review_reply_page+1);  // 개발자정의 속성 쓰기
    
  }
  
  //댓글 삭제 레이어 출력
  function review_reply_delete(review_reply_no) {
    
    var frm_review_reply_delete = $('#frm_review_reply_delete');
    $('#review_reply_no', frm_review_reply_delete).val(review_reply_no); // 삭제할 댓글 번호 저장
    $('#modal_panel_delete').modal();             // 삭제폼 다이얼로그 출력
  }

  //댓글 삭제 처리
  function review_reply_delete_proc(review_reply_no) {
    
    var params = $('#frm_review_reply_delete').serialize();
    $.ajax({
      url: "../review_reply/delete.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
        
        if (rdata.passwd_cnt ==1) { // 패스워드 일치
          if (rdata.delete_cnt == 1) { // 삭제 성공

            $('#btn_frm_review_reply_delete_close').trigger("click"); // 삭제폼 닫기, click 발생 ★ 
            
            $('#' + review_reply_no).remove(); // 태그 삭제 ★
              
            return; // 함수 실행 종료
          } else {  // 삭제 실패
            msg = "패스 워드는 일치하나 댓글 삭제에 실패했습니다. <br>";
            msg += " 다시한번 시도해주세요."
          }
        } else { // 패스워드 일치하지 않음.
          // alert('패스워드 불일치');
          // return;
          
          msg = "패스워드가 일치하지 않습니다.";
          $('#modal_panel_delete_msg').html(msg);

          $('#passwd', '#frm_review_reply_delete').focus();
          
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
  }

  //-------------------- 댓글 관련 종료 --------------------
</script>
</head>

<body>
<c:set var="review_cate_no" value="${review_CateVO.review_cate_no}" />
<c:set var="review_no" value="${reviewVO.review_no }" />

<jsp:include page="/menu/top.jsp" flush='false' />
  
  <!-- Modal 알림창 시작 -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_review_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_review_reply_content'></p>  <!-- 내용 -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div> 
  <!-- Modal 알림창 종료 -->
  
  <!-- -------------------- 댓글 삭제폼 시작 -------------------- -->
  <div class="modal fade" id="modal_panel_delete" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title">댓글 삭제</h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <form name='frm_review_reply_delete' id='frm_review_reply_delete'>
            <input type='hidden' name='review_reply_no' id='review_reply_no' value=''>
            
            <label>패스워드</label>
            <input type='password' name='review_reply_passwd' id='review_reply_passwd' class='form-control'>
            <DIV id='modal_panel_delete_msg' style='color: #AA0000; font-size: 1.1em;'></DIV>
          </form>
        </div>
        <div class="modal-footer">
          <button type='button' class='btn btn-danger' 
                       onclick="review_reply_delete_proc(frm_review_reply_delete.review_reply_no.value); frm_review_reply_delete.review_reply_passwd.value='';">삭제</button>

          <button type="button" class="btn btn-default" data-dismiss="modal" 
                       id='btn_frm_review_reply_delete_close'>Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- -------------------- 댓글 삭제폼 종료 -------------------- -->




  <DIV class='title_line' style="width: 80%; margin: 30px auto; font-size: 20px; font-weight: bold;">
    ${review_CateVO.review_cate_name }
  </DIV>
  
  <div style="width: 80%; margin: 5px auto;">
  <ASIDE class="aside_left">
    ${review_CategrpVO.review_categrp_name } > ${review_CateVO.review_cate_name }
  </ASIDE>
  <ASIDE class="aside_right">
   
    <c:choose>
      <c:when test="${reviewVO.review_file.trim().length() > 0 }">
        <A href='./img_update.do?review_cate_no=${review_cate_no }&review_no=${review_no}'>메인 이미지 변경/삭제</A>     
      </c:when>
      <c:otherwise>
        <A href='./img_create.do?review_cate_no=${review_cate_no }&review_no=${review_no}'>메인 이미지 등록</A>     
      </c:otherwise>
    </c:choose>  
    <span class='menu_divide' > | </span>
    <A href='../review_attachfile/create.do?review_no=${review_no }&review_cate_no=${review_cate_no }'>첨부 파일 등록</A>
    <span class='menu_divide' > | </span>
    <A href='../review_attachfile/list_by_review_no.do?review_no=${review_no }&review_cate_no=${review_cate_no }'>첨부 파일 삭제</A>
    
    <span class='menu_divide' > | </span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href='./list.do?cateno=${cateno }'>목록</A>
    <span class='menu_divide' > | </span> 
    <A href='./update.do?review_cate_no=${review_cate_no }&review_no=${review_no}&nowPage=${param.nowPage}'>수정</A>
    <span class='menu_divide' > | </span> 
    <A href='./delete.do?review_cate_no=${review_cate_no }&review_no=${review_no}&nowPage=${param.nowPage}'>삭제</A>
    
  </ASIDE> 
  
  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="review_no" value="${review_no}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA;'>
            <span>${reviewVO.review_title}</span>
            (<span>${reviewVO.review_good}</span>)
            <span>${reviewVO.review_date.substring(0, 16)}</span>
          </li>
          
          <%-- ********** 첨부 파일 이미지 목록 출력 시작 ********** --%>
          <li class="li_none">
            <DIV id='review_attachfile_panel' style="width: 70%; margin: 0px auto;"></DIV> <!-- 원본 이미지 출력 -->
          </li>
          <li class="li_none" style='text-align: center;' >
            <c:set var="review_file" value="${reviewVO.review_file.toLowerCase() }" />
            <c:if test="${review_file.endsWith('jpg') || review_file.endsWith('png') || review_file.endsWith('gif')}">
              <A href="javascript:panel_img('./storage/main_images/', '${reviewVO.review_file }')"><IMG src='./storage/main_images/${reviewVO.review_thumb }' style='margin-top: 2px; width: 120px; height: 80px;'></A>
            </c:if>
            
            <c:forEach var="review_attachfileVO" items="${review_attachfile_list }">
              <c:set var="review_attachfile_thumb" value="${review_attachfileVO.review_attachfile_thumb.toLowerCase() }" />
              
              <c:choose>
                <c:when test="${review_attachfile_thumb.endsWith('jpg') || review_attachfile_thumb.endsWith('png') || review_attachfile_thumb.endsWith('gif')}">
                  <A href="javascript:panel_img('../review_attachfile/storage/', '${review_attachfileVO.review_attachfile_rname }')"><IMG src='../review_attachfile/storage/${review_attachfileVO.review_attachfile_thumb }' style='margin-top: 2px; width: 120px; height: 80px;'></A>
                </c:when>
              </c:choose>
            </c:forEach>
          </li>
          <%-- ********** 첨부 파일 이미지 목록 출력 종료 ********** --%>
          
          <li class="li_none">
            <DIV>${reviewVO.review_content }</DIV>
          </li>
          
          <li class="li_none">
            <DIV style='text-decoration: none;'>
              평점: ${reviewVO.review_score }점
            </DIV>
          </li>
          
          <li class="li_none">
            <DIV style='text-decoration: none;'>
              검색어(키워드): ${reviewVO.review_word }
            </DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>
  </div>
  
  <!-- ---------- 댓글 영역 시작 ---------- -->
  <DIV style='width: 80%; margin: 5px auto;'>
      <HR>
      <FORM name='frm_review_reply' id='frm_review_reply'> <%-- 댓글 등록 폼 --%>
          <input type='hidden' name='review_no' id='review_no' value='${review_no}'>
          <input type='hidden' name='member_no' id='member_no' value='${sessionScope.member_no}'>
          
          <textarea name='review_reply_content' id='review_reply_content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
          <input type='password' name='review_reply_passwd' id='review_reply_passwd' placeholder="비밀번호">
          <button type='button' id='btn_create'>등록</button>
      </FORM>
      <HR>
      <DIV id='review_reply_list' data-replypage='1'>  <%-- 댓글 목록 --%>
      
      </DIV>
      <DIV id='reply_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 100%; background-color: #EEFFFF;'>
          <button id='btn_add' style='width: 100%;'>더보기 ▽</button>
      </DIV>  
    
  </DIV>
  
  <!-- ---------- 댓글 영역 종료----------  -->

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>