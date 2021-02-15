<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>그룹별 이벤트 목록 + 검색 + 페이징</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class='title_line' style="width: 80%; margin: 30px auto; font-size: 20px; font-weight: bold;">
    <strong class ="review_title">『${event_grpVO.event_grp_title }』</strong>
  </DIV>

  <div style="width: 80%; margin: 5px auto;">
  
  <ASIDE class="aside_right">
    <c:if test="${sessionScope.admin_id != null}">
      <A href="./create.do?event_grp_no=${event_grpVO.event_grp_no }">이벤트 등록</A>
      <span class='menu_divide' >│</span>
    </c:if>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE>  
  
  <DIV style="text-align: right;">  
    <form name='frm' id='frm' method='get' action='./list.do'>
      <input type='hidden' name='event_grp_no' value='${event_grpVO.event_grp_no }'>
      <br>
      <c:choose>
        <c:when test="${param.event_word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='event_word' id='event_word' value='${param.event_word }' 
                     style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='event_word' id='event_word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.event_word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list.do?event_grp_no=${event_grpVO.event_grp_no}&event_word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  </div>

  <div style='width: 80%; margin: 0 auto;' >
    <c:forEach var="event_adminVO" items="${list }" varStatus="status">
      <c:set var="event_no" value="${event_adminVO.event_no }" />
      <c:set var="event_grp_no" value="${event_adminVO.event_grp_no }" />
      <c:set var="event_thumb" value="${event_adminVO.event_thumb }" />
      <c:set var="event_title" value="${event_adminVO.event_title}" />
      <c:set var="event_file" value="${event_adminVO.event_file}" />
      <c:set var="event_size" value="${event_adminVO.event_size}" />
      <c:set var="event_view" value="${event_adminVO.event_view}" />
      <c:set var="admin_name" value="${event_adminVO.admin_name}" />
      <c:set var="event_date" value="${event_adminVO.event_date }" />
      
     
      <%--하나의 행에 이미지를 4개씩 출력후 행 변경 --%>
      <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <br><br>
      </c:if>
      
      <!-- 하나의 이미지, 24 * 4 = 96% -->
     
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #FFFFFF;'>
        <c:choose>
          <c:when test="${event_size > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${event_thumb.endsWith('jpg') || event_thumb.endsWith('png') || event_thumb.endsWith('gif')}"> <!-- 이미지 인경우 -->
               <%--  <a href="./read.do?review_no=${review_no}&review_word=${param.review_word }&nowPage=${param.nowPage}"> --%> 
                <a href="./read.do?event_grp_no=${event_grp_no }&event_no=${event_no }&event_word=${param.event_word }&nowPage=${param.nowPage}">   
                  <IMG src="./storage/main_images/${event_thumb }" style='width: 150px; height: 150px;'>
                </a><br><br>          
                <div style="font-size: 18px; font-weight: bold; cursor: pointer;" onclick="location.href='./read.do?event_no=${event_no}&event_word=${param.event_word }&nowPage=${param.nowPage}'">
                  ${event_title} 
                </div><br>             
                작성자: ${admin_name }｜등록일: ${event_date.substring(0, 16) }<br>
                <div style='font-size: 14px; color: #b2b2b2' >조회: ${event_view } </div>
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->

                    <a href="./read.do?event_no=${event_no}">   
                      <img src='./images/none1.png' style='width: 150px; height: 150px;'>
                    </a><br><br>

                <div style="font-size: 18px; font-weight: bold; cursor: pointer;" onclick="location.href='./read.do?event_no=${event_no}&event_word=${param.event_word }&nowPage=${param.nowPage}'">  
                  ${event_title}  
                </div><br>   
                 작성자: ${admin_name }｜등록일: ${event_date.substring(0, 16) }<br>
                <div style='font-size: 14px; color: #b2b2b2' >조회: ${event_view } </div>
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
            <a href="./read.do?event_grp_no=${event_grp_no }&event_no=${event_no }&event_word=${param.event_word }&nowPage=${param.nowPage}">
              <img src='./images/none1.png' style='width: 150px; height: 150px;'>
            </a><br><br>     
            <div style="font-size: 18px; font-weight: bold; cursor: pointer;" onclick="location.href='./read.do?event_no=${event_no}&event_word=${param.event_word }&nowPage=${param.nowPage}'">  
              ${event_title}  
            </div><br>    
             작성자: ${admin_name }｜등록일: ${event_date.substring(0, 16) }<br>
             <div style='font-size: 14px; color: #b2b2b2' >조회: ${event_view } </div>
          </c:otherwise>
        </c:choose>         
      </DIV>  
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
    <DIV class='bottom_menu'>${paging }</DIV>
  </div>
  
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>


