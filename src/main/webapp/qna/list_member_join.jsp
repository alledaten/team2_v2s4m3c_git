<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  // 천단위 구분자 출력, 정규 표현식
  function comma(su) {
    return su.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
  }
</script>
<script type="text/javascript">
  $(function() {
    $('#btn_member').on('click', msg1);  
    $('#btn_product').on('click', msg2);  
    $('#btn_order').on('click', msg3); 
    $('#btn_delivery').on('click', msg4); 
    $('#btn_ect').on('click', msg5);  
    
  });
  
  function msg1() {
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_1.jsp',
      type: 'post',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);

//        if (document.getElementById('join')) {
//          $('#panel').css('text-align', 'left');
//          $('#panel').html(rdata); 
//        }
        
        
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
    $('#panel').html("<img src='./images/ani04.gif' style='width: 10%;'>");
    $('#panel').show(); // 숨겨진 태그의 출력
  }

  function msg2() {
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_2.jsp',
      type: 'post',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);

//        if (document.getElementById('join')) {
//          $('#panel').css('text-align', 'left');
//          $('#panel').html(rdata); 
//        }
        
        
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
    $('#panel').html("<img src='./images/ani04.gif' style='width: 10%;'>");
    $('#panel').show(); // 숨겨진 태그의 출력
  }

  function msg3() {
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_3.jsp',
      type: 'post',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);

//        if (document.getElementById('join')) {
//          $('#panel').css('text-align', 'left');
//          $('#panel').html(rdata); 
//        }
        
        
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
    $('#panel').html("<img src='./images/ani04.gif' style='width: 10%;'>");
    $('#panel').show(); // 숨겨진 태그의 출력
  }

  function msg4() {
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_4.jsp',
      type: 'post',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);

//        if (document.getElementById('join')) {
//          $('#panel').css('text-align', 'left');
//          $('#panel').html(rdata); 
//        }
        
        
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
    $('#panel').html("<img src='./images/ani04.gif' style='width: 10%;'>");
    $('#panel').show(); // 숨겨진 태그의 출력
  }

  function msg5() {
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_5.jsp',
      type: 'post',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);

//        if (document.getElementById('join')) {
//          $('#panel').css('text-align', 'left');
//          $('#panel').html(rdata); 
//        }
        
        
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
    $('#panel').html("<img src='./images/ani04.gif' style='width: 10%;'>");
    $('#panel').show(); // 숨겨진 태그의 출력
  }
  
  </script>
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class="title_line">
    커뮤니티 > Q&A 질문 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    Q&A
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./create.do">질문 등록</A>
    <!--  <span class='menu_divide' >│</span> -->
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>
  
  <div>
    <FORM name='frm' id='frm' style='text-align: center;'>
    <ul>
      <h4 >자주 하는 질문 : 가장 많이 궁금해하시는 내역을 빠르게 해결하실 수 있습니다</h4>
      <li>
        <button type='button' id='btn_member' name='member' value='member'>회원 가입/정보</button>
        <button type='button' id='btn_product' name='product' value='product'>전통주 상품</button>
        <button type='button' id='btn_order' name='order' value='order'>주문 / 결제 / 취소</button>
        <button type='button' id='btn_delivery' name='delivery' value='delivery'>배송 관련</button>
        <button type='button' id='btn_ect' name='ect' value='ect'>서비스 / 기타</button>
        <div style='border-top: 2px solid; width: 50%; margin: 0px auto;'></div>
      </li>
    </ul>

    
  <DIV id='panel' style='display: none; margin: 10px auto; text-align: left; width: 90%;'></DIV>
  
  </FORM>
  </div><br>
  
  <h5>※ 1:1 문의는 아래 게시판을 이용해 주세요</h5>
        
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 5%;">
      <col style="width: 40%;">
      <col style="width: 15%;">
      <col style="width: 15%;">
      <col style="width: 10%;">
      <col style="width: 15%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic">NO</th>
        <th class="th_basic">질문사항</th>
        <th class="th_basic">작성자</th> 
        <th class="th_basic">등록일</th>
        <th class="th_basic">조회수</th>
        <th class="th_basic">기타</th>
      </tr>
    </thead>
      
    <tbody>
    <c:forEach var="qnamemberVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="community_no" value="${qnamemberVO.community_no}" />
      <c:set var="qna_no" value="${qnamemberVO.qna_no}" />
      <c:set var="qna_title" value="${qnamemberVO.qna_title}" />
      <c:set var="qna_id" value="${qnamemberVO.member_id}" />
      <c:set var="qna_rdate" value="${qnamemberVO.qna_rdate}" />
      <c:set var="qna_count" value="${qnamemberVO.qna_count}" />  
      <c:set var="qna_visible" value="${qnamemberVO.qna_visible}" />       
      
      <TR>
        <TD class="td_bs">${community_no }-${qna_no }</TD>
        <TD class="td_bs_left"><a href="./read.do?qna_no=${qna_no}">${qna_title}</a></TD>
        <TD class="td_bs">${qna_id }</TD>
        <TD class="td_bs">${qna_rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${qna_count }</TD>
        <TD class="td_bs">
          <A href="./update.do?qna_no=${qna_no }"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./delete.do?qna_no=${qna_no }"><span class="glyphicon glyphicon-trash"></span></A>
          <c:choose>
            <c:when test="${qna_visible == 'Y'}">
              <A href="./update_visible.do?qna_no=${qna_no }&qna_visible=${qna_visible }"><IMG src="./images/open.png"></A>
            </c:when>
            <c:otherwise>
              <A href="./update_visible.do?qna_no=${qna_no }&qna_visible=${qna_visible }"><IMG src="./images/close.png"></A>
            </c:otherwise>
          </c:choose>
        </TD>             
  
      </TR>
    </c:forEach>
    </tbody>
    
    </table>
    
    <fieldset class='fieldset_basic'>
      <div class="content_bottom_menu" style="padding-right: 50%;">
        <button type="button" onclick="location.href='./create.do'" class="btn btn-primary">새로운 질문 등록</button>
      </div>
    </fieldset>
     
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
