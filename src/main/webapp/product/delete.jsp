<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
  $(function() {  

    count_by_product_no();
  });

  // jQuery ajax 요청
  function count_by_product_no() {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = 'product_no=' + ${param.product_no};
    var msg = '';

    // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;

    $.ajax({
      url: '../product_attachfile/count_by_product_no.do', // spring execute
      type: 'get',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        var msg = "";
        if (rdata.cnt > 0) {
          msg = "현재 " + rdata.cnt + "건의 첨부 파일이 있습니다.<br><br>"
          // msg += "<button type='button' onclick='' class='btn btn-info'>첨부 파일 삭제</button>";
          msg += "<button type='button' onclick='delete_by_product_no()' class='btn btn-danger'>첨부 파일 삭제</button>";

          $('#panel1').attr("class", "msg_warning"); // 경고 style 지정
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
  
  // jQuery ajax 요청
  function delete_by_product_no() {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = 'product_no=' + ${param.product_no};
    var msg = '';

    // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;

    $.ajax({
      url: '../product_attachfile/delete_by_product_no.do', // spring execute
      type: 'post',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        var msg = "";
        if (rdata.cnt > 0) {
          msg = rdata.cnt + "건의 첨부 파일(이미지)을 삭제했습니다.<br>"
        }
        $('#panel1').html(msg); // 메시지 출력
        $('#panel1').attr("class", "msg_warning"); // 경고 style 지정
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

    $('#panel1').attr("class", "msg_default"); // 경고 style 지정  
    $('#panel1').html(gif);
    $('#panel1').show(); // 출력 */
  }

  
</script>
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>
    전통주 이름
  </DIV>

  <ASIDE class="aside_left">
    <A href="../productgrp/list.do?productgrp_no=${productgrpVO.productgrp_no }">${productgrpVO.productgrp_name }</A>  > 수정
  </ASIDE>
  <ASIDE class="aside_right">
    <A href='./list.do?productgrp_no=${param.propductgrp_no }'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method='POST' action='./delete.do'>
      <input type='hidden' name='product_no' value='${param.product_no}'>
      <input type="hidden" name="productgrp_no" value="${param.productgrp_no }">
      <input type="hidden" name="nowPage" value="${param.nowPage }">
      
      <DIV id='panel1' style="width: 40%; text-align: center; margin: 10px auto;"></DIV>
            
      <div class="form-group">   
        <div class="col-md-12" style='text-align: center; margin: 10px auto;'>
          삭제 되는글: ${productVO.product_name }<br><br>
          삭제하시겠습니까? 삭제하시면 복구 할 수 없습니다.<br><br>
          
        <div class="form-group">   
        <div class="col-md-12" style='text-align: center; margin: 10px auto;'>
          <input type='password' class="form-control" name='product_passwd'  value='' placeholder="패스워드" style='width: 20%; margin: 0px auto;'>
        </div>
      </div>
          
          <button type = "submit" class="btn btn-info">삭제 진행</button>
          <button type = "button" onclick = "history.back()" class="btn btn-info">취소</button>
        </div>
      </div>   
  </FORM>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
  
  