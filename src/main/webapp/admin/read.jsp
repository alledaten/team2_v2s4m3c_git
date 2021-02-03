<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
  content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
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
  <%-- <c:set var="cateno" value="${cateVO.cateno}" />
<c:set var="contentsno" value="${contentsVO.contentsno }" />
 --%>
  <jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>관리자 정보</DIV>
  <ASIDE class="aside_left">관리자 목록 > 관리자 정보</ASIDE>

  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
    <c:set var="admin_no" value="${adminVO.admin_no}" />
    <input type="hidden" name="admin_no" value="${admin_no}">
    <table class="table table-hover">
      <colgroup>
        <col style="width: 20%;"></col>
        <col style="width: 80%;"></col>
      </colgroup>
      <thead>
        <tr>
          <th>ID</th>
          <th>${adminVO.admin_id}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>이름</td>
          <td>${adminVO.admin_name }</td>
        </tr>
      </tbody>
    </table>
  </FORM>
  <ASIDE class="aside_right">
    <A href='./update.do?&admin_no=${admin_no}'>수정</A>
    <span class='menu_divide'> | </span>
    <A href='./delete.do?&admin_no=${admin_no}'>탈퇴</A>
  </ASIDE>
  <jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>

