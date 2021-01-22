<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰 메인이미지 변경 및 삭제</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class="title_line">
    『${reviewVO.review_title}』 메인 이미지 변경 및 삭제
  </DIV>
  
  <ASIDE class="aside_left">
    <A href="../review_categrp/list.do">카테고리 그룹</A> > 
    <A href="../review_cate/list.do?review_categrp_no=${review_CategrpVO.review_categrp_no }">${review_CategrpVO.review_categrp_name }</A> > 
    <A href="../review/list.do?cateno=${reviewVO.review_cate_no }">${review_CateVO.review_cate_name}</A>  
  </ASIDE>
  <ASIDE class="aside_right">
    <A href=''>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <H4>메인 이미지 삭제</H4>

    <%-- 이미지가 존재하는 경우 이미지를 출력하고 삭제 버튼 표시 --%>
    <c:set var="review_file" value="${reviewVO.review_file }" />
    <c:if test="${review_file.endsWith('jpg') || review_file.endsWith('png') || review_file.endsWith('gif')}">
      <FORM name='frm' method='POST' action='./img_delete.do' class="form-horizontal">
        <!-- FK memberno 지정 -->
        <input type='hidden' name='member_no' id='member_no' value='1'>
        <!-- FK categrpno 지정 -->
        <input type='hidden' name='review_cate_no' id='review_cate_no' value="${param.review_cate_no }">
        <input type='hidden' name='review_no' id='review_no' value="${param.review_no }">
        <%-- <input type='hidden' name='nowPage' id='nowPage' value="${param.nowPage }"> --%>

        <IMG src="./storage/main_images/${review_file }" style="width: 50%; margin-bottom: 10px;">
        
        <div class="form-group">   
          <div class="col-md-12">
            <input type='password' class="form-control" name='review_passwd'  value='1234' placeholder="패스워드" style='width: 20%;'>
          </div>
        </div>
        
        <button type="submit" class="btn btn-info">메인 이미지 삭제</button>
        <button type="button" 
                    onclick="location.href='./read.do?review_no=${param.review_no}'" 
                    class="btn btn-info">취소[조회]</button>
      </FORM> 
    </c:if> 
    
    <HR>
    <H4>새로운 메인 이미지 등록</H4>
    <%-- 이미지가 존재하는 경우 새로운 이미지 등록 폼 출력 --%>
    <FORM name='frm' method='POST' action='./img_update.do' class="form-horizontal"
                enctype="multipart/form-data">
               
      <!-- FK memberno 지정 -->
      <input type='hidden' name='member_no' id='member_no' value='1'>
      <!-- FK categrpno 지정 -->
      <input type='hidden' name='review_cate_no' id='review_cate_no' value="${param.review_cate_no }">
      <input type='hidden' name='review_no' id='review_no' value="${param.review_no }">
      <%-- <input type='hidden' name='nowPage' id='nowPage' value="${param.nowPage }"> --%>
      
      <div class="form-group">   
        <div class="col-md-12">
          <%-- 실제 컬럼명: review_file, Spring File 객체 대응: review_fileMF --%>
          <input type='file' class="form-control" name='review_fileMF' id='review_fileMF' 
                    value='' placeholder="파일 선택">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='review_passwd'  value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>
      
      <button type="submit" class="btn btn-info">새로운 메인 이미지 등록</button>
      <button type="button" 
                  onclick="location.href='./read.do?review_no=${param.review_no}'" 
                  class="btn btn-info">취소[조회]</button>
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
  