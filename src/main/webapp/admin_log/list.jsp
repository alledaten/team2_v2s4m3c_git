<%@ page contentType="text/html; charset=UTF-8"%>
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

  /****************** 취소 ******************/
  function cancel() {
    $('#panel1').html('');
    $('#panel1').hide();
  }

  /****************** 삭제용 조회 ******************/
  function delete_form(admin_log_no) {
    var params = 'admin_log_no=' + admin_log_no;

    var msg = '';
    $.ajax({
      url: './read.do', // spring execute
      type: 'get',  // post, get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.admin_log_date.length > 0) {
          msg = "<div style='background-color:#FF9999; padding: 2px;'>";
          msg += rdata.admin_log_date + "("+ rdata.admin_log_ip +") 삭제하시겠습니까?<br>";
          msg += "삭제하면 복구 할 수 없습니다.<br>";
          msg += " <button type=\"button\" onclick=\"delete_proc("+rdata.admin_log_no+")\">삭제 진행</button>";
          msg += " <button type='button' onclick='cancel()'>취소</button>";
        } else {
          msg = "정보가 없습니다.";
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        }
        $('#panel1').html(msg); // 메시지 출력
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
    var gif = '';
    gif +="<div style='margin: 0px auto; text-align: center;'>";
    gif +="  <img src='./images/ani04.gif' style='width: 10%;'>";
    gif +="</div>";
      
    $('#panel1').html(gif);
    $('#panel1').show(); // 출력 */    
  }

  /****************** 삭제 처리 ******************/
  function delete_proc(admin_log_no) {
    var params = 'admin_log_no=' + admin_log_no;
    var msg = '';
    $.ajax({
      url: './delete.do', // spring execute
      type: 'post',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.cnt > 0) {
          msg = "삭제했습니다. <br>"
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        } else {
          msg = "삭제에 실패했습니다."
        }
        $('#panel1').html(msg); // 메시지 출력
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
    var gif = '';
    gif +="<div style='margin: 0px auto; text-align: center;'>";
    gif +="  <img src='./images/ani04.gif' style='width: 10%;'>";
    gif +="</div>";
      
    $('#panel1').html(gif);
    $('#panel1').show(); // 출력 */    
  }
  
</script>

</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class="title_line">
    회원 권한 관리
  </DIV>
  <ASIDE class="aside_left">
    전체 보기 
  </ASIDE>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <!--  <span class='menu_divide' >│</span> -->
  </ASIDE> 
  <DIV id='panel1' style="width: 40%; text-align: center; margin: 10px auto; display: none;"></DIV> 
  
  <TABLE class='table table-striped'>
  <colgroup>
    <col style="width: 40%;"></col>
    <col style="width: 40%;"></col>
    <col style="width: 20%;"></col>
  </colgroup>
  <thead>
    <tr>
      <th style='text-align: center;'>로그인 날짜</th>
      <th style='text-align: center;'>로그인 장소</th>
      <th style='text-align: center;'>기타</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="admin_logVO" items="${list }">
      <c:set var="admin_log_no" value="${admin_logVO.admin_log_no }" />
      <tr>
        <td style='text-align: center;'>${admin_logVO.admin_log_date}</td>
        <td style='text-align: center;'>${admin_logVO.admin_log_ip}</td>
        <td style='text-align: center;'>
          <A href="javascript:delete_form(${admin_log_no})" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</TABLE>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>