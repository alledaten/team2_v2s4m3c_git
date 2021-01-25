<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function() {
    $('#btn_send').on('click', send);
  }); 

  function send() {
    // alert('send() execute.');
    // return;
    
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // $('#frm').attr('action', './create_ajax.do');
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    // var params = 'contentsno=' + ${param.contentsno};
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;

    var msg = '';
    $.ajax({
      url: './create_ajax.do', // spring execute
      type: 'post',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.cnt > 0) {
          msg = "『" + $('#productgrp_name').val() + "』 카테고리 그룹을 등록했습니다."
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        } else {
          msg = "『" + $('#productgrp_name').val() + "』 카테고리 그룹 등록에 실패했습니다."
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

  function update_form(productgrp_no) {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // $('#frm').attr('action', './read_ajax.do');
    $("#btn_send").off("click");
    $('#btn_send').on('click', update_proc);
        
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = 'productgrp_no=' + productgrp_no;
    // var params = 'contentsno=' + ${param.contentsno};
    // var params = $('#frm_create').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;

    var msg = '';
    $.ajax({
      url: './read_ajax.do', // spring execute
      type: 'get',  // post, get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        var frm = $('#frm');
        $('#productgrp_no', frm).val(rdata.productgrp_no);
        $('#productgrp_name', frm).val(rdata.productgrp_name);
        $('#productgrp_seqno', frm).val(rdata.productgrp_seqno);
        $('#productgrp_visible', frm).val(rdata.productgrp_visible);

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

  function cancel() {
    $('#productgrp_no', frm).val(0);
    $('#productgrp_name', frm).val('');
    $('#productgrp_seqno', frm).val('');
    $('#productgrp_visible', frm).val('Y');

    $('#btn_send').html('등록');

    $('#panel1').html('');
    $('#panel1').hide();
  }

  function update_proc() {
    // alert('update_proc() execute.');
    // return;
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // $('#frm').attr('action', './update_ajax.do');
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    // var params = 'contentsno=' + ${param.contentsno};
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;

    var msg = '';
    $.ajax({
      url: './update_ajax.do', // spring execute
      type: 'post',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.cnt > 0) {
          msg = "『" + $('#productgrp_name').val() + "』 카테고리 그룹을 수정했습니다."
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        } else {
          msg = "『" + $('#name').val() + "』 카테고리 그룹 수정에 실패했습니다."
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

  function delete_form(productgrp_no) {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // $('#frm').attr('action', './read_ajax.do');
        
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = 'productgrp_no=' + productgrp_no;
    // var params = 'contentsno=' + ${param.contentsno};
    // var params = $('#frm_create').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;

    var msg = '';
    $.ajax({
      url: './read_ajax.do', // spring execute
      type: 'get',  // post, get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.productgrp_name.length > 0) {
          msg = "『" + rdata.name + "』 카테고리 그룹을 삭제하시겠습니까?<br>";
          msg += "카테고리 그룹을 삭제하면 복구 할 수 없습니다.";
          msg += " <button type=\"button\" onclick=\"delete_proc("+productgrp_no+", '"+rdata.productgrp_name+"')\">삭제 진행</button>";
          msg += " <button type='button' onclick='cancel()'>취소</button>";
        } else {
          msg = "『" + rdata.productgrp_name + "』 카테고리 정보가 없습니다.";
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

  function delete_proc(productgrp_no, productgrp_name) {
    // alert('update_proc() execute.');
    // return;
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // $('#frm').attr('action', './update_ajax.do');
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = 'productgrp_no=' + productgrp_no;
    // var params = 'categrpno=' + ${param.categrpno};
    // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;

    var msg = '';
    $.ajax({
      url: './delete_ajax.do', // spring execute
      type: 'post',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        if (rdata.cnt > 0) {
          msg = "『" + productgrp_name + "』 카테고리 그룹을 삭제했습니다."
          msg += " <button type='button' onclick='location.reload(true)'>확인</button>";
        } else {
          msg = "『" + productgrp_name + "』 카테고리 그룹 삭제에 실패했습니다."
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
<jsp:include page="/menu/top.jsp" />
 
  <DIV class='title_line'>카테고리 그룹</DIV>
 
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm' id='frm' method='POST' action=''>
      <!-- <input type='hidden' name='lang' id='lang' value='en'> --> <!-- ko, en -->
      <input type='hidden' name='productgrp_no' id='productgrp_no' value='0'>
              
      <label>그룹 이름</label>
      <input type='text' name='productgrp_name' id='productgrp_name' value='' required="required" style='width: 25%;'>
 
      <label>순서</label>
      <input type='number' name='productgrp_seqno' id='productgrp_seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='productgrp_visible' id='productgrp_visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="button" id='btn_send'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
    
  </DIV>
  <DIV id='panel1' style="width: 40%; text-align: center; margin: 10px auto; display: none;"></DIV> 
  
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
      <TH class="th_bs">대분류명</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">출력</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="productgrpVO" items="${list}">
      <c:set var="productgrp_no" value="${productgrpVO.productgrp_no }" />
      <TR>
        <TD class="td_bs">${productgrpVO.productgrp_seqno }</TD>
      <TD class="td_bs_left"><A href = "../product/list.do?productgrp_no=${productgrp_no}">${productgrpVO.productgrp_name }</A></TD>
      <TD class="td_bs">${productgrpVO.productgrp_rdate.substring(0, 10) }</TD>
      
      <TD class="td_bs">
        <c:choose>
          <c:when test="${productgrpVO.productgrp_visible == 'Y'}">
            <A href="./update_visible.do?productgrp_no=${productgrp_no }&productgrp_visible=${productgrpVO.productgrp_visible }"><IMG src="./images/open.png" style='width: 18px;'></A>
          </c:when>
          <c:otherwise>
            <A href="./update_visible.do?productgrp_no=${productgrp_no }&productgrp_visible=${productgrpVO.productgrp_visible }"><IMG src="./images/close.png" style='width: 18px;'></A>
          </c:otherwise>
        </c:choose>
      </TD>   
        
        <TD class="td_bs">
          <A href="javascript:update_form(${productgrp_no })" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="javascript:delete_form(${productgrp_no })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
          <A href="./update_seqno_up.do?productgrp_no=${productgrp_no }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
          <A href="./update_seqno_down.do?productgrp_no=${productgrp_no }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
 
 
<jsp:include page="/menu/bottom.jsp" />
</body>
 
</html> 
 
 
 