<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    쿠폰
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 전통주 ></A>
    <A href="./list.do"> 전통주 쿠폰 > </A>
    쿠폰 확인
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href="../buy/list.do">주문 목록</A>
    <span class='menu_divide' > | </span> 
    <A href='./update.do?point_no=${pointVO.point_no }'>수정</A>
    <span class='menu_divide' > | </span> 
    <A href='./read_delete.do?point_no=${pointVO.point_no }'>삭제</A>
  </ASIDE> 
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method="get" action='./update.do'>
   <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;">
      <col style="width: 10%;">
      <col style="width: 15%;">
      <col style="width: 15%;">
      <col style="width: 15%;">
      <col style="width: 15%;">
      <col style="width: 10%;">
      <col style="width: 10%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic">NO</th>
        <th class="th_basic">결제 번호</th>
        <th class="th_basic">쿠폰 금액</th>
        <th class="th_basic">쿠폰 발급 날짜</th>
        <th class="th_basic">쿠폰 유효 기간</th>
        <th class="th_basic">쿠폰 사용 날짜</th>
        <th class="th_basic">쿠폰 사용 여부</th>
        <th class="th_basic">기타</th>
      </tr>
    </thead>
      
    <tbody>
    <c:forEach var="couponVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="coupon_no" value="${couponVO.coupon_no}" />
      <c:set var="pay_no" value="${couponVO.pay_no}" />
      <c:set var="coupon_num" value="${couponVO.coupon_num}" />
      <c:set var="coupon_rdate" value="${couponVO.coupon_rdate}" />
      <c:set var="coupon_use_rdate" value="${couponVO.coupon_use_rdate}" />
      <c:set var="coupon_until_rdate" value="${couponVO.coupon_until_rdate}" />
      <c:set var="coupon_check" value="${couponVO.coupon_check}" />
      
      <TR>
        <TD class="td_bs">${coupon_no }</TD>
        <TD class="td_bs">${pay_no }</TD>
        <TD class="td_bs">${coupon_num }</TD>
        <TD class="td_bs">${coupon_rdate }</TD>
        <TD class="td_bs">${coupon_until_rdate }</TD>
        <TD class="td_bs">${coupon_use_rdate }</TD>
        <TD class="td_bs">${coupon_check }</TD>
        <TD class="td_bs">
          <A href="./update.do?coupon_no=${coupon_no }"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?coupon_no=${coupon_no }"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>             
  
      </TR>
    </c:forEach>
    </tbody>
    
    </table>
  </div>

  <br><br><br><br><br>
  <fieldset class='fieldset_basic'>
    <ASIDE class="aside_left">
      <button type='button' onclick="location.href='./list.do'" class="btn btn-primary">쿠폰 목록</button>
    </ASIDE>
    <ASIDE class="aside_right">
      <button type='button' onclick="location.href='./update.do?coupon_no=${couponVO.coupon_no }'" class="btn btn-primary">수정</button>
      <button type='button' onclick="location.href='./read_delete.do?coupon_no=${couponVO.coupon_no }'" class="btn btn-primary">삭제</button>
    </ASIDE>
  </fieldset>
</FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>
