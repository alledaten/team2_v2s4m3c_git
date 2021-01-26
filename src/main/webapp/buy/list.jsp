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
 
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class="title_line">
    전통주 주문
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 전통주 목록 ></A>
    <A href="javascript:location.reload();"> 전통주 주문 ></A>
    주문 확인
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./create.do">주문 하기</A>
    <!--  <span class='menu_divide' >│</span> -->
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>
  
  <input type='hidden' name=' buy_no' id='buy_no' value='${buyVO.buy_no }'>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 5%;">
      <col style="width: 10%;">
      <col style="width: 7%;">
      <col style="width: 10%;">
      <col style="width: 15%;">
      <col style="width: 8%;">
      <col style="width: 15%;">
      <col style="width: 10%;">
      <col style="width: 10%;">
      <col style="width: 10%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic">NO</th>
        <th class="th_basic">주문 상태</th>
        <th class="th_basic">주문자</th>
        <th class="th_basic">전통주 사진</th> 
        <th class="th_basic">전통주 정보</th>
        <th class="th_basic">주문 수량</th>
        <th class="th_basic">주문 일자</th>
        <th class="th_basic">결제 정보</th>
        <th class="th_basic">배송 정보</th>
        <th class="th_basic">기타</th>
      </tr>
    </thead>
      
    <tbody>
    <c:forEach var="buyVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="buy_no" value="${buyVO.buy_no}" />
      <TR>
        <TD class="td_bs">${buyVO.buy_no }</TD>
        <TD class="td_bs">${buyVO.order_check }<br>
        </TD>
        <TD class="td_bs">홍길동</TD>
        <TD class="td_bs">전통주 사진</TD>
        <TD class="td_bs">전통주 번호</TD>
        <TD class="td_bs">${buyVO.pay_count }</TD>
        <TD class="td_bs">${buyVO.pay_rdate.substring(0, 10) }</TD>
        <TD class="td_bs">결제 확인</TD>
        <TD class="td_bs"><A href="../dev/read.do?dev_no=${devVO.dev_no }">배송 준비</TD>
        <TD class="td_bs">
          <A href="./read_update.do?buy_no=${buyVO.buy_no }"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?buy_no=${buyVO.buy_no }"><span class="glyphicon glyphicon-trash"></span></A>
<%--           <c:choose>
            <c:when test="${buyVO.pay_check == 'Y'}">
              <A href="./update_visible.do?buy_no=${buyVO.buy_no }&buy_check=${buyVO.pay_check }"><IMG src="./images/open.png"></A>
            </c:when>
            <c:otherwise>
              <A href="./update_visible.do?buy_no=${buyVO.buy_no }&buy_check=${buyVO.pay_check }"><IMG src="./images/close.png"></A>
            </c:otherwise>
          </c:choose> --%>
        </TD>             
  
      </TR>
    </c:forEach>
    </tbody>
    
    </table>
    
    <fieldset class='fieldset_basic'>
      <div class="content_bottom_menu" style="padding-right: 50%;">
        <button type="button" onclick="location.href='./create.do'" class="btn btn-primary">주문 하기</button>
      </div>
    </fieldset>
     
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
