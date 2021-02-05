<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰 첨부파일 등록처리</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
</head> 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class='review_title_line'>
    <strong class ="review_title">${param.review_no }첨부파일 등록</strong>
  </DIV>
  
  <FORM name='frm' method='POST' action='./create.do' 
                enctype="multipart/form-data" class="form-horizontal">
                
    <input type='hidden' name='product_no' id='product_no' value="${param.product_no }">
    <input type='hidden' name='review_no' id='review_no' value="${param.review_no }">                       
  </FORM>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.upload_count > 0 }">
          <LI class='li_none'>
            <span class='span_success'>파일을 등록했습니다.</span>
          </LI>
          <LI class='li_none'>
            <span class='span_success'>정상 등록된 파일 ${param.upload_count} 건</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>
            <span class='span_fail'>파일 등록에 실패했습니다.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' 
                    onclick="location.href='../review/read.do?review_no=${param.review_no }'"
                    class="btn btn-info">업로드된 파일 확인</button>
        <button type='button' 
                    onclick="location.href='./list_by_review_no.do?review_no=${param.review_no}'"
                    class="btn btn-info">목록</button>
      </LI>
     </UL>
  </fieldset>
</DIV>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

