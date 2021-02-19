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
  $(function() {
    $('#btn_send').on('click', send);
  }); 

  /****************** 등록 ******************/
  function send() {
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합

    var msg = '';
    $.ajax({
      url: './create.do', // spring execute
      type: 'post',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.cnt > 0) {
          msg = "『" + $('#snslogin_name').val() + "』 권한을 등록했습니다."
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        } else {
          msg = "『" + $('#snslogin_name').val() + "』 권한 등록에 실패했습니다."
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

  /****************** 수정용 조회 ******************/
  function update_form(snslogin_no) {
    $("#btn_send").off("click");
    $('#btn_send').on('click', update_proc);
    
    var params = 'snslogin_no=' + snslogin_no;
    
    var msg = '';
    $.ajax({
      url: './read.do', // spring execute
      type: 'get',  // post, get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        var frm = $('#frm');
        $('#snslogin_no', frm).val(rdata.snslogin_no);
        $('#snslogin_name', frm).val(rdata.snslogin_name);

        $('#btn_send').html('수정');
        
        $('#panel1').hide(); // 숨기기    
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

  /****************** 취소 ******************/
  function cancel() {
    $('#snslogin_no', frm).val(0);
    $('#snslogin_name', frm).val('');

    $('#btn_send').html('등록');

    $('#panel1').html('');
    $('#panel1').hide();
  }


  /****************** 수정 처리 ******************/
  function update_proc() {
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합

    var msg = '';
    $.ajax({
      url: './update.do', // spring execute
      type: 'post',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.cnt > 0) {
          msg = "『" + $('#snslogin_name').val() + "』 SNS연동 이름을 수정했습니다."
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        } else {
          msg = "『" + $('#snslogin_name').val() + "』 SNS연동 이름 수정에 실패했습니다."
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

  /****************** 삭제용 조회 ******************/
  function delete_form(snslogin_no) {
    $("#btn_send").off("click");
    $('#btn_send').on('click', delete_proc);
    
    var params = 'snslogin_no=' + snslogin_no;

    var msg = '';
    $.ajax({
      url: './read.do', // spring execute
      type: 'get',  // post, get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.snslogin_name.length > 0) {
          msg = "<div style='background-color:#FF9999; padding: 2px;'>";
          msg += "『" + rdata.snslogin_name + "』 연동을 삭제하시겠습니까?<br>";
          msg += "등급을 삭제하면 복구 할 수 없습니다.<br>";
          msg += " <button type=\"button\" onclick=\"delete_proc("+snslogin_no+", '"+rdata.snslogin_name+"')\">삭제 진행</button>";
          msg += " <button type='button' onclick='cancel()'>취소</button>";
        } else {
          msg = "『" + rdata.snslogin_name + "』 연동 정보가 없습니다.";
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
  function delete_proc(snslogin_no, snslogin_name) {
    var params = 'snslogin_no=' + snslogin_no;

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
          msg = "『" + snslogin_name + "』 연동을 삭제했습니다."
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        } else {
          msg = "『" + snslogin_name + "』 연동 삭제에 실패했습니다."
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
    회원 관리
  </DIV>
  <ASIDE class="aside_left">
    <A href='../memberlevel/list.do'>등급 목록</A>
    <span class='menu_divide' >│</span>
    <A href='../auth/list.do'>권한 목록</A>
    <span class='menu_divide' >│</span>
    <A href='./list.do'>SNS로그인 목록</A>    
  </ASIDE>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <!--  <span class='menu_divide' >│</span> -->
  </ASIDE> 
  <DIV class='menu_line'></DIV>
    <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm' id='frm' method='POST' action=''>
      <!-- <input type='hidden' name='lang' id='lang' value='en'> --> <!-- ko, en -->
        
      <label>번호</label>
      <input type='number' name='snslogin_no' id='snslogin_no' min="0" required="required" style='width: 5%;'>
         
      <label>이름</label>
      <input type='text' name='snslogin_name' id='snslogin_name' value='' required="required" style='width: 25%;'>
 
      <button type="button" id='btn_send'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
  <DIV id='panel1' style="width: 40%; text-align: center; margin: 10px auto; display: none;"></DIV> 
  
  <TABLE class='table table-striped'>
  <colgroup>
    <col style="width: 10%;"></col>
    <col style="width: 50%;"></col>
    <col style="width: 20%;"></col>
  </colgroup>
  <thead>
    <tr>
      <th style='text-align: center;'>No.</th>
      <th style='text-align: center;'>이름</th>
      <th style='text-align: center;'>기타</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="snsloginVO" items="${list }">
      <c:set var="snslogin_no" value="${snsloginVO.snslogin_no }" />
      <tr> 
        <td style='text-align: center;'>${snslogin_no}</td>
        <td style='text-align: center;'>${snsloginVO.snslogin_name}</td>
        <td style='text-align: center;'>
          <A href="javascript:update_form(${snslogin_no })" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="javascript:delete_form(${snslogin_no })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</TABLE>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 