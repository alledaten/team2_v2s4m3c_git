<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>상품추천 조회</title>

<link href="../css/common.css" rel="Stylesheet" type="text/css">
<link href="../css/menu.css" rel="Stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  // 첨부 이미지 출력, dir: ../attachfile/storage/, ./storage/main_images/
  function panel_img(dir, file) {
    var tag = "";
    tag   = "<A href=\"javascript: $('#event_attachfile_panel').hide();\">"; // 이미지 감추기
    tag += "  <IMG src='" + dir + file + "' style='width: 100%;'>";
    tag += "</A>";

    $('#event_attachfile_panel').html(tag);  // 문자열을 태그로 적용
    $('#event_attachfile_panel').show();      // 패널 출력
  }

</script>
</head>

<body>
<c:set var="event_grp_no" value="${eventVO.event_grp_no}" />
<c:set var="event_no" value="${eventVO.event_no }" />
<c:set var="admin_no" value="${eventVO.admin_no }" />

<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class='title_line' style="width: 80%; margin: 30px auto; font-size: 20px; font-weight: bold;">
    <strong class ="review_title">『${eventVO.event_title}』 이벤트</strong>
  </DIV>
  
  <div style="width: 80%; margin: 5px auto;">
  <ASIDE class="aside_left">
    ${product_recommendVO.product_recommend_title } 
    <span>${product_recommendVO.product_recommend_date.substring(0, 16)}</span>
  </ASIDE>
  <ASIDE class="aside_right">
    
   <%-- 글을 등록한 회원만 메뉴 출력 --%>
   
   <c:if test="${sessionScope.admin_no == eventVO.admin_no }">
     <A href='./update.do?event_grp_no=${event_grp_no }&event_no=${event_no}'>수정</A>
       <span class='menu_divide' > | </span> 
     <A href='./delete.do?event_grp_no=${event_grp_no }&event_no=${event_no}'>삭제</A>
   
    <c:choose>
      <c:when test="${eventVO.event_file.trim().length() > 0 }"> 
        <span class='menu_divide' > | </span> 
          <A href='./img_update.do?event_grp_no=${event_grp_no }&event_no=${event_no}'>메인 이미지 변경 및 삭제</A>     
      </c:when>
      <c:otherwise>
        <span class='menu_divide' > | </span> 
          <A href='./img_create.do?event_grp_no=${event_grp_no }&event_no=${event_no}'>메인 이미지 등록</A>     
      </c:otherwise>
    </c:choose>  
    
    <span class='menu_divide' > | </span>
      <A href='../event_attachfile/create.do?event_no=${event_no }&event_grp_no=${event_grp_no }'>첨부 파일 등록</A>
    <span class='menu_divide' > | </span>
      <A href='../event_attachfile/list_by_event_no.do?event_no=${event_no }&event_grp_no=${event_grp_no }'>첨부 파일 삭제</A>
    <span class='menu_divide' > | </span> 
    </c:if>
       
    <A href='./list.do?event_grp_no=${event_grp_no }'>목록</A>
      <span class='menu_divide' > | </span>
    <A href="javascript:location.reload();">새로고침</A>  
      
  </ASIDE> 
  
  <div class='menu_line'></div>
  
  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="event_no" value="${event_no}">

      <fieldset class="fieldset">
        <ul>
          <%-- ********** 첨부 파일 이미지 목록 출력 시작 ********** --%>
          <li class="li_none">
            <DIV id='event_attachfile_panel' style="width: 70%; margin: 0px auto;"></DIV> <!-- 원본 이미지 출력 -->
          </li>
          <li class="li_none" style='text-align: center;' >
            <c:set var="event_file" value="${eventVO.event_file.toLowerCase() }" />
            <c:if test="${event_file.endsWith('jpg') || event_file.endsWith('png') || event_file.endsWith('gif')}">
              <A href="javascript:panel_img('./storage/main_images/', '${eventVO.event_file }')"><IMG src='./storage/main_images/${eventVO.event_thumb }' style='margin-top: 2px; width: 120px; height: 80px;'></A>
            </c:if>
            
            <c:forEach var="event_attachfileVO" items="${event_attachfile_list }">
              <c:set var="event_attachfile_thumb" value="${event_attachfileVO.event_attachfile_thumb.toLowerCase() }" />
              
              <c:choose>
                <c:when test="${event_attachfile_thumb.endsWith('jpg') || event_attachfile_thumb.endsWith('png') || event_attachfile_thumb.endsWith('gif')}">
                  <A href="javascript:panel_img('../event_attachfile/storage/', '${event_attachfileVO.event_attachfile_rname }')"><IMG src='../event_attachfile/storage/${event_attachfileVO.event_attachfile_thumb }' style='margin-top: 2px; width: 120px; height: 80px;'></A>
                </c:when>
              </c:choose>
            </c:forEach>
          </li>
          <%-- ********** 첨부 파일 이미지 목록 출력 종료 ********** --%>
          
          <li class="li_none">
            <DIV>${eventVO.event_content }</DIV>
          </li>
                    
          <li class="li_none">
            <DIV style='text-decoration: none;'>
              검색어(키워드): ${eventVO.event_word }
            </DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>
  </div>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>