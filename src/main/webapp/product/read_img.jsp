<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 글 + 이미지 조회하는 경우 참고  --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>
<c:set var="productgrp_no" value="${productgrpVO.productgrp_no}" />
<c:set var="product_no" value="${productVO.product_no }" />

<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class="title_line">
    ${productVO.product_name}
  </DIV>
  <ASIDE class="aside_left">
    <A href="../productgrp/list.do">전통주 그룹</A> > 
    <A href="../product/list.do?productgrp_no=${productVO.productgrp_no }">${productgrpVO.productgrp_name}</A>  
  </ASIDE>
  <ASIDE class="aside_right">
    <A href="./create.do">글 등록</A>
    <c:choose>
      <c:when test="${productVO.product_file1.trim().length() > 0 }">
        <span class='menu_divide' > | </span> 
        <A href='./img_update.do?product_no=${product_no }&product_no=${product_no}'>메인 이미지 변경/삭제</A>     
      </c:when>
      <c:otherwise>
        <span class='menu_divide' > | </span> 
        <A href='./img_create.do?productgrp_no=${productgrp_no }&product_no=${product_no}'>메인 이미지 등록</A>     
      </c:otherwise>
    </c:choose>    
    <span class='menu_divide' > | </span>
    <A href='../product_attachfile/create.do?product_no=${product_no }&productgrp_no=${productgrp_no }'>파일 등록</A>
    <span class='menu_divide' > | </span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href='./list.do?productgrp_no=${productgrp_no }'>목록</A>
    <span class='menu_divide' > | </span> 
    <A href='./update.do?productgrp_no=${productgrp_no }&product_no=${product_no}'>수정</A>
    <span class='menu_divide' > | </span> 
    <A href='./delete.do?productgrp_no=${productgrp_no }&product_no=${product_no}'>삭제</A>
    
  </ASIDE> 
  
  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="product_no" value="${product_no}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA;'>
            <span>${productVO.product_name}</span>
            (<span>${productVO.product_recom}</span>)
            <span>${productVO.product_rdate.substring(0, 16)}</span>
          </li>
          <li class="li_none">
            <c:set var="product_file1" value="${productVO.product_file1.toLowerCase() }" />
            <c:if test="${product_file1.endsWith('jpg') || product_file1.endsWith('png') || product_file1.endsWith('gif')}">
              <DIV style="width: 50%; float: left; margin-right: 10px;">
                <IMG src="./storage/main_images/${productVO.product_file1 }" style="width: 100%;">
              </DIV> 
            </c:if> 
            <DIV>${productVO.product_description }</DIV>
          </li>
          <li class="li_none">
            <DIV style='text-decoration: none;'>
              검색어(키워드): ${productVO.product_word }
            </DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>

