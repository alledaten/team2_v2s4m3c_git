<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 

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
  $(function(){ 
    $('#btn_retry').on('click', function() { 
      location.href="../member/list.do"
    });

    $('#btn_home').on('click', function() { 
      location.href="${pageContext.request.contextPath}/index.do"
    });    
  });
</script>
 
</head> 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>
  회원
  </DIV>
  <ASIDE class="aside_left">
    <A href='./login.do'>로그인</A>
  </ASIDE>
  <DIV class='message'>
    <fieldset class='fieldset_basic'>
      <ul>
        <li class='li_none'>열람 권한이 없습니다.</li>
        <li class='li_none'>로그인 해 주세요</li>
        <li class='li_none'>
          <button type="button" id="btn_retry" class="btn btn-primary btn-md">로그인</button>
          <button type="button" id="btn_home" class="btn btn-primary btn-md">확인</button>
        </li>
        
      </ul>
    </fieldset>    
  </DIV>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

