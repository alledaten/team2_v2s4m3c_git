<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class="title_line">
    ${productgrpVO.productgrp_name}
  </DIV>
  <ASIDE class="aside_left">
    <A href="../productgrp/list.do?productgrp_no=${productgrpVO.productgrp_no }">${productgrpVO.productgrp_name }</A> > ${productVO.product_name} > 전체 보기 
  </ASIDE>
  <ASIDE class="aside_right">
    <A href="./create.do?productgrp_no=${productgrpVO.productgrp_no }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list.do?productgrp_no=${productgrpVO.productgrp_no }">목록형</A>    
  </ASIDE> 
  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'>
    <!-- 갤러리 Layout 시작 -->
    <c:forEach var="productVO" items="${list }" varStatus="status">
      <c:set var="product_no" value="${productVO.product_no }" />
      <c:set var="product_thumb1" value="${productVO.product_thumb1 }" />
      <c:set var="product_name" value="${productVO.product_name}" />
      <c:set var="product_cnt" value="${productVO.product_cnt}" />
      <c:set var="product_rdate" value="${productVO.product_rdate}" />
      <c:set var="memberno" value="${productVO.memberno}" />
      <c:set var="product_file1" value="${productVO.product_file1}" />
      <c:set var="product_size1" value="${productVO.product_size1}" />

      <%--하나의 행에 이미지를 4개씩 출력후 행 변경 --%>
      <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if>
      
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #EEEFFF;'>
        <c:choose>
          <c:when test="${product_size1 > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${product_thumb1.endsWith('jpg') || product_thumb1.endsWith('png') || product_thumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="./read.do?product_no=${product_no}">               
                  <IMG src="./storage/main_images/${product_thumb1 }" style='width: 100%; height: 150px;'>
                </a><br>
                ${productVO.product_name} (${productVO.product_cnt})
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                    <a href="./read.do?product_no=${product_no}">${productVO.product_file1}</a><br>
                  </DIV>
                </DIV>
                ${productVO.product_name} (${productVO.product_cnt})              
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
            <a href="./read.do?product_no=${product_no}">
              <img src='./images/none1.png' style='width: 100%; height: 150px;'>
            </a><br>
            이미지를 등록해주세요.
          </c:otherwise>
        </c:choose>         
      </DIV>  
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>


