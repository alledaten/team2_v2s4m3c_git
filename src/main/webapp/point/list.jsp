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

</script>
 
</head>
 
<body>
  
  <DIV class='menu_line'></DIV>
  
  <input type='hidden' name=' member_no' id='member_no' value='1'>
  <input type='hidden' name=' member_no' id='member_no' value='1'>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 20%;">
      <col style="width: 20%;">
      <col style="width: 20%;">
      <col style="width: 20%;">
      <col style="width: 20%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic">NO</th>
        <th class="th_basic">회원 이름</th>
        <th class="th_basic">결제 번호</th>
        <th class="th_basic">포인트 수</th>
        <th class="th_basic">기타</th>
      </tr>
    </thead>
      
    <tbody>
    <c:forEach var="pointVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="point_no" value="${pointVO.point_no}" />
      <c:set var="member_no" value="${pointVO.member_no}" />
      <c:set var="pay_no" value="${pointVO.pay_no}" />
      <c:set var="point_num" value="${pointVO.point_num}" />
      
      <TR>
        <TD class="td_bs">${point_no }</TD>
        <TD class="td_bs">${member_no }</TD>
        <TD class="td_bs">${pay_no }</TD>
        <TD class="td_bs">${point_num }</TD>
        <TD class="td_bs">
          <A href="./update.do?point_no=${point_no }"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?point_no=${point_no }"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>             
  
      </TR>
    </c:forEach>
    </tbody>
    
    </table>
  </div>
  
      <div class="bottom_menu" style="padding-right: 10%;">
        <button type='button' onclick="location.href='./create.do'" class="btn btn-primary">포인트 등록</button>
      </div>
     
</body>
 
</html>
