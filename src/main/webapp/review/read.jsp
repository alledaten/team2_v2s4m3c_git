<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰 조회</title>

<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  // 첨부 이미지 출력, dir: ../attachfile/storage/, ./storage/main_images/
  function panel_img(dir, file) {
    var tag = "";
    tag   = "<A href=\"javascript: $('#review_attachfile_panel').hide();\">"; // 이미지 감추기
    tag += "  <IMG src='" + dir + file + "' style='width: 100%;'>";
    tag += "</A>";

    $('#review_attachfile_panel').html(tag);  // 문자열을 태그로 적용
    $('#review_attachfile_panel').show();      // 패널 출력
  }

</script>

</head>

<body>
<c:set var="review_cate_no" value="${review_CateVO.review_cate_no}" />
<c:set var="review_no" value="${reviewVO.review_no }" />

<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>
    ${review_CateVO.review_cate_name }
  </DIV>
  
  <ASIDE class="aside_left">
    ${review_CategrpVO.review_categrp_name } > ${review_CateVO.review_cate_name }
  </ASIDE>
  <ASIDE class="aside_right">
   
    <c:choose>
      <c:when test="${reviewVO.review_file.trim().length() > 0 }">
        <A href='./img_update.do?review_cate_no=${review_cate_no }&review_no=${review_no}'>메인 이미지 변경/삭제</A>     
      </c:when>
      <c:otherwise>
        <A href='./img_create.do?review_cate_no=${review_cate_no }&review_no=${review_no}'>메인 이미지 등록</A>     
      </c:otherwise>
    </c:choose>  
    <span class='menu_divide' > | </span>
    <A href='../review_attachfile/create.do?review_no=${review_no }&review_cate_no=${review_cate_no }'>첨부 파일 등록</A>
    <span class='menu_divide' > | </span>
    <A href='../review_attachfile/list_by_review_no.do?review_no=${review_no }&review_cate_no=${review_cate_no }'>첨부 파일 삭제</A>
    
    <span class='menu_divide' > | </span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href='./list.do?cateno=${cateno }'>목록</A>
    <span class='menu_divide' > | </span> 
    <A href='./update.do?review_cate_no=${review_cate_no }&review_no=${review_no}&nowPage=${param.nowPage}'>수정</A>
    <span class='menu_divide' > | </span> 
    <A href='./delete.do?review_cate_no=${review_cate_no }&review_no=${review_no}&nowPage=${param.nowPage}'>삭제</A>
    
  </ASIDE> 
  
  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="review_no" value="${review_no}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA;'>
            <span>${reviewVO.review_title}</span>
            (<span>${reviewVO.review_good}</span>)
            <span>${reviewVO.review_date.substring(0, 16)}</span>
          </li>
          
          <%-- ********** 첨부 파일 이미지 목록 출력 시작 ********** --%>
          <li class="li_none">
            <DIV id='review_attachfile_panel' style="width: 70%; margin: 0px auto;"></DIV> <!-- 원본 이미지 출력 -->
          </li>
          <li class="li_none" style='text-align: center;' >
            <c:set var="review_file" value="${reviewVO.review_file.toLowerCase() }" />
            <c:if test="${review_file.endsWith('jpg') || review_file.endsWith('png') || review_file.endsWith('gif')}">
              <A href="javascript:panel_img('./storage/main_images/', '${reviewVO.review_file }')"><IMG src='./storage/main_images/${reviewVO.review_thumb }' style='margin-top: 2px; width: 120px; height: 80px;'></A>
            </c:if>
            
            <c:forEach var="review_attachfileVO" items="${review_attachfile_list }">
              <c:set var="review_attachfile_thumb" value="${review_attachfileVO.review_attachfile_thumb.toLowerCase() }" />
              
              <c:choose>
                <c:when test="${review_attachfile_thumb.endsWith('jpg') || review_attachfile_thumb.endsWith('png') || review_attachfile_thumb.endsWith('gif')}">
                  <A href="javascript:panel_img('../review_attachfile/storage/', '${review_attachfileVO.review_attachfile_rname }')"><IMG src='../review_attachfile/storage/${review_attachfileVO.review_attachfile_thumb }' style='margin-top: 2px; width: 120px; height: 80px;'></A>
                </c:when>
              </c:choose>
            </c:forEach>
          </li>
          <%-- ********** 첨부 파일 이미지 목록 출력 종료 ********** --%>
          
          <li class="li_none">
            <DIV>${reviewVO.review_content }</DIV>
          </li>
          
          <li class="li_none">
            <DIV style='text-decoration: none;'>
              평점: ${reviewVO.review_score }점
            </DIV>
          </li>
          
          <li class="li_none">
            <DIV style='text-decoration: none;'>
              검색어(키워드): ${reviewVO.review_word }
            </DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>