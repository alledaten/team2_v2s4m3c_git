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

</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class="title_line">
    관리자 목록
  </DIV>
  <ASIDE class="aside_left">
    전체 보기 
  </ASIDE>
  <ASIDE class="aside_right">
    <A href="./create.do">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE>
  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 10%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 30%;"></col>
        <col style="width: 30%;"></col>
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>번호</th>
          <th style='text-align: center;'>아이디</th>
          <th style='text-align: center;'>이름</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="adminVO" items="${list }">
          <c:set var="admin_no" value="${adminVO.admin_no }" />
          <tr> 
            <td style='text-align: center;'>${admin_no}</td>
            <td style='text-align: center;'><a href="./read.do?admin_no=${admin_no}">${adminVO.admin_id}</a></td>
            <td style='text-align: center;'>${adminVO.admin_name}</td>
            <td style='text-align: center;'></td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <DIV class='bottom_menu'>${paging }</DIV>
    <br><br>
  </div>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 