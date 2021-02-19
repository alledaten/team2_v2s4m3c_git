<%@ page contentType="text/html; charset=UTF-8" %>
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
    회원
  </DIV>
  <ASIDE class="aside_left">
    <A href='./list.do'>회원 목록</A> > 
    <A href='./read.do?member_no=${param.member_no}'>회원 정보</A> > 
    탈퇴
  </ASIDE>
  <ASIDE class="aside_right">
    <A href='./list.do'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
  
  <div class='menu_line'></div>
 
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${passwd_cnt == 1 }"> <!-- 패스워드 일치 -->
          <c:choose>
            <c:when test="${cnt == 1}"> <!-- 글 삭제 성공 -->
              <LI class='li_none'>
                <span class='span_success'>『${member_name}』 탈퇴했습니다.</span>
              </LI>
            </c:when>
            <c:otherwise>    <!-- 글 삭제 실패 -->
              <LI class='li_none'>
                <span class='span_fail'>『${member_name}』 탈퇴에 실패했습니다.</span>
              </LI>
              <LI class='li_none'>
                <span class='span_fail'>다시 시도해주세요.</span>
              </LI>
            </c:otherwise>
          </c:choose>
        </c:when>
        <c:otherwise> <!-- 패스워드 불일치 -->
          <LI class='li_none'>
            <span class='span_fail'>패스워드가 일치하지 않습니다. 다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      
      <c:choose>
        <c:when test="${cnt == 1 && passwd_cnt == 1}">
          <LI class='li_none'>
            <button type='button' 
                        onclick="location.href='./list.do?cateno=${param.cateno}'"
                        class="btn btn-info">목록</button>                        
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>
            <button type='button' 
                        onclick="history.back();"
                        class="btn btn-info">재시도</button>
            <button type='button' 
                        onclick="location.href='./list.do?cateno=${param.cateno}'"
                        class="btn btn-info">목록</button>                        
          </LI>
        </c:otherwise> 
      </c:choose>
      
     </UL>
  </fieldset>
 
</DIV>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

