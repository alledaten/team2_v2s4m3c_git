<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
</head> 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>알림</DIV>
  
  <ASIDE class='aside_left'>
    ${productgrpVO.productgrp_name } > ${productgrpVO.productgrp_name } > 답변 등록
  </ASIDE>
  <ASIDE class='aside_right'>
    <A href='./list.do?productgrp_no=${param.productgrp_no }'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
  
  <div class='menu_line'></div>
   
  <DIV class='message'>
    <fieldset class='fieldset_basic'>
      <UL>
        <c:choose>
          <c:when test="${param.cnt == 1}">
            <LI class='li_none'>
              <span class='span_success'>답변을 등록했습니다.</span>
            </LI>
          </c:when>
          <c:otherwise>
            <LI class='li_none'>
              <span class='span_fail'>답변 등록에 실패했습니다.</span>
            </LI>
          </c:otherwise>
        </c:choose>
        <LI class='li_none'>
          <br>
          <c:choose>
            <c:when test="${param.cnt == 1 }">
              <button type='button' 
                           onclick="location.href='../product_attachfile/create.do?productgrp_no=${param.productgrp_no}&product_no=${param.product_no }'"
                           class="btn btn-info">첨부파일 등록</button>     
              <br>         
              <button type='button' 
                           onclick="location.href='./create.do?productgrp_no=${param.productgrp_no}'"
                           class="btn btn-info">새로운 컨텐츠 등록</button>
            </c:when>
            <c:otherwise>
              <button type='button' 
                           onclick="history.back();"
                           class="btn btn-info">다시 시도</button>
            </c:otherwise>
          </c:choose>
                      
          <button type='button' 
                      onclick="location.href='./list.do?productgrp_no=${param.productgrp_no}'"
                      class="btn btn-info">목록</button>
        </LI>
       </UL>
    </fieldset>
   
  </DIV>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

