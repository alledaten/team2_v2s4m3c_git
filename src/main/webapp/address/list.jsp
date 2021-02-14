<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 

 <% 
 request.setCharacterEncoding("utf-8"); 
 String root = request.getContextPath();

 
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
 <script type="text/javascript">
   function update_ajax(address_no, address_name, address_member, address_phone, address1, address2) {
   
    $('#modal_update_title').html('주소록 수정'); // 제목 
    $('#modal_update_content').html(""); // 내용
    $('#update_modal').modal();            // 다이얼로그 출력

    var address_no = parseInt(address_no);
    var params= address_no + address_name + address_member + address_phone + address1 + address2;
    alert('params: ' + params);
    
     // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
     // alert('params: ' + params);
     // return;
     
     $.ajax({
       url: '../address/update.do',
       type: 'get',  // get
       cache: false, // 응답 결과 임시 저장 취소
       async: true,  // true: 비동기 통신
       dataType: 'html', // 응답 형식: json, html, xml...
       data: params,      // 데이터
       success: function(rdata) { // 응답이 온경우
         // alert(rdata);

         alert('params: ' + params);
         
         $('#panel').css('text-align', 'left');
         $('#panel').html(rdata);  // 보통 DIV, SPAN등에 출력, input 태그는 ${'#rname'}.val(rdata);
         
     },
     // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
     error: function(request, status, error) { // callback 함수
       var msg = 'ERROR<br><br>';
       msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
       msg += '<strong>error</strong><br>'+error + '<hr>';
       console.log(msg);
     }
   });
   
     $('#panel').css('text-align', 'center');
     $('#panel').html("<img src='./images/ani04.gif' style='width: 6%;'>");
     $('#panel').show(); // 숨겨진 태그의 출력
       
  }
</script>
 
</head>
 
<body>
  
      <!-- Modal 알림창 시작(나의 배송 주소록) -->
  <div class="modal fade" id="update_modal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_update_title'></h4>
          <div style="padding-left:80%;">
          <button type="button" id='address_update' name='address_update' class="btn btn-info">주소록 수정</button></div><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_update_content'></p>  <!-- 내용 -->
              <DIV id='panel' style='display: hidden; margin: 10px auto; text-align: left; width: 90%;'></DIV>
        </div>
        <div class="modal-footer">
          <button type="button" id='modal_ad' class="btn btn-default" data-dismiss="modal">확인</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">취소 [닫기]</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료 -->
  
  <DIV class='menu_line'></DIV>
  
  <input type='hidden' name=' member_no' id='member_no' value='1'>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 8%;">
      <col style="width: 12%;">
      <col style="width: 15%;">
      <col style="width: 15%;">
      <col style="width: 30%;">
      <col style="width: 20%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic">NO</th>
        <th class="th_basic">주소록 이름</th>
        <th class="th_basic">이름</th>
        <th class="th_basic">연락처</th>
        <th class="th_basic">주소</th>
        <th class="th_basic">기타</th>
      </tr>
    </thead>
      
    <tbody>
    <c:forEach var="addressVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="address_no" value="${addressVO.address_no}" />
      <c:set var="address_name" value="${addressVO.address_name}" />
      <c:set var="address_member" value="${addressVO.address_member}" />
      <c:set var="address_phone" value="${addressVO.address_phone}" />
      <c:set var="address1" value="${addressVO.address1}" />
      <c:set var="address2" value="${addressVO.address2}" />
      
      <TR>
        <TD class="td_bs">${address_no }</TD>
        <TD class="td_bs">${address_name }</TD>
        <TD class="td_bs">${address_member }</TD>
        <TD class="td_bs">${address_phone }</TD>
        <TD class="td_bs">${address1 }${address2 }</TD>
        <TD class="td_bs">
          <a href="javascript: update_ajax(${address_no}, '${address_name }', '${address_member }', '${address_phone }', '${address1 }', '${address2 }')"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="../address/read_delete.do?address_no=${address_no }"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>             
  
      </TR>
    </c:forEach>
    </tbody>
    
    </table>
     
</body>
 
</html>
