<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>이벤트 그룹별 이벤트 첨부파일 목록</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
  $(function() {
    $('#btn_delete').on('click', delete_proc); // 삭제 진행

  });

  function delete_form(event_attachfile_no) {
    $('#btn_delete').attr('data-content', event_attachfile_no); // 삭제할 파일 번호 임시 저장
    
    msg = '파일을 삭제하시겠습니까?<br>파일을 삭제하면 복구 할 수 없습니다.<br>';
    msg += '삭제 진행시 삭제진행 버튼을 클릭하세요.';
    
    $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
    $('#modal_title').html('파일 삭제'); // 제목 
    $('#modal_content').html(msg);        // 내용
    $('#modal_panel').modal();              // 다이얼로그 출력
    return false;
  }

  function delete_proc() {
    var event_attachfile_no = $('#btn_delete').attr('data-content'); // 삭제할 파일 번호 임시 저장
    var frm = $('#frm')
    $('#event_attachfile_no', frm).val(event_attachfile_no); // frm 폼에서 태그를 검색
    
    frm.submit();
  }
</script> 
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <form name='frm' id='frm' method='post' action='./delete.do'>
    <input type='hidden' name='event_attachfile_no' id='event_attachfile_no' value=''>
    <input type='hidden' name='event_no' id='event_no' value='${param.event_no }'>
    <input type='hidden' name='rurl' id='rurl' value='./list_by_event_no.do'>
        
  </form>
  
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
          <button type="button" id="btn_delete" data-focus="" data-content="" class="btn btn-default" 
                      data-dismiss="modal">삭제 진행</button>
          <button type="button" id="btn_close" data-focus="" class="btn btn-default" 
                      data-dismiss="modal">취소</button>
        </div>
      </div>
    </div>
  </div>
  <!-- ********** Modal 알림창 종료 ********** -->

  <DIV class='review_title_line'>
    <strong class ="review_title">『${eventVO.event_title}』 첨부파일 목록</strong>
  </DIV>

  <div style="width: 80%; margin: 5px auto;">
    <ASIDE class='aside_right'>
      <A href='../event_attachfile/create.do?event_no=${eventVO.event_no }&event_grp_no=${eventVO.event_grp_no }'>첨부파일 추가</A>
        <span class='menu_divide' > | </span>
      <a href="../event/read.do?event_grp_no=${eventVO.event_grp_no }&event_no=${eventVO.event_no }">관련글 조회</a>
        <span class='menu_divide' > | </span>
      <A href="javascript:location.reload();">새로고침</A>    
    </ASIDE> 
  </div>
  
  <DIV class='review_menu_line'></DIV>
  
  <DIV style='width: 80%; margin: 5px auto;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 15%;"></col>        
        <col style="width: 15%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>NO</th>
          <th style='text-align: center;'>파일</th>
          <th style='text-align: center;'>원본<br>파일명</th>
          <th style='text-align: center;'>저장<br>파일명</th>
          <th style='text-align: center;'>Preview<br>파일명</th>
          <th style='text-align: center;'>등록일</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="event_attachfileVO" items="${list }">
          <c:set var="event_no" value="${event_attachfileVO.event_no }" />
          <c:set var="event_attachfile_rname" value="${event_attachfileVO.event_attachfile_rname.toLowerCase() }" />
          <c:set var="event_attachfile_no" value="${event_attachfileVO.event_attachfile_no}" />
          <c:set var="event_attachfile_thumb" value="${event_attachfileVO.event_attachfile_thumb}" />
          <c:set var="event_attachfile_date" value="${event_attachfileVO.event_attachfile_date}" />
          <c:set var="event_attachfile_upname" value="${event_attachfileVO.event_attachfile_upname}" />

          <tr> 
            <td style='vertical-align: middle; text-align: center;'>${event_attachfile_no }</td>
            <td style='vertical-align: middle; text-align: center;'>
              <c:choose>
                <c:when test="${event_attachfile_rname.endsWith('jpg') || event_attachfile_rname.endsWith('png') || event_attachfile_rname.endsWith('gif')}">
                  <IMG src="./storage/${event_attachfile_thumb }" style="width: 120px;"> 
                </c:when>
                <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                  ${event_attachfile_rname}
                </c:otherwise>
              </c:choose>
            </td> 
            <td style='text-align: center; vertical-align: middle;'>${event_attachfile_rname}</td>
            <td style='text-align: center; vertical-align: middle;'>${event_attachfile_upname}</td>
            <td style='text-align: center; vertical-align: middle;'>${event_attachfile_thumb}</td>
            <td style='text-align: center; vertical-align: middle;'>${event_attachfile_date.substring(0, 10)}</td>
            <td style='text-align: center; vertical-align: middle;'>
              <A href="javascript: delete_form(${event_attachfile_no})"><img src="./images/delete.png" title="삭제"></A>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <br><br>
  </div>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>


