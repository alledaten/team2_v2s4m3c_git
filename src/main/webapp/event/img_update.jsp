<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>이벤트 메인 이미지 변경 및 삭제</title>
 
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

  <DIV class=" review_title_line">
    <strong class ="review_title">『${eventVO.event_title}』 메인 이미지 수정 및 삭제</strong>
  </DIV>
  
  <DIV style='width: 80%; margin: 5px auto;'>

    <%-- 이미지가 존재하는 경우 이미지를 출력하고 삭제 버튼 표시 --%>
    <c:set var="event_file" value="${eventVO.event_file }" />
    <c:if test="${event_file.endsWith('jpg') || event_file.endsWith('png') || event_file.endsWith('gif')}">
      <FORM name='frm' method='POST' action='./img_delete.do' class="form-horizontal">

        <input type='hidden' name='admin_no' id='admin_no' value='${eventVO.admin_no }'>
        <input type='hidden' name='event_grp_no' id='event_grp_no' value="${param.event_grp_no }">
        <input type='hidden' name='event_no' id='event_no' value="${param.event_no }">

        <IMG src="./storage/main_images/${event_file }" style="width: 300px; margin-bottom: 10px;">
        
        <div class="form-group">   
          <div class="col-md-12">
            <input type='password' class="form-control" name='event_passwd'  value='1234' placeholder="패스워드" style='width: 20%;'>
          </div>
        </div>
        
        <button type="submit" class="btn btn-info">메인 이미지 삭제</button>
        <button type="button" 
                    onclick="location.href='./read.do?event_grp_no=${param.event_grp_no}&event_no=${param.event_no }'" 
                  class="btn btn-info">취소[조회]</button>
      </FORM> 
    </c:if> 
    
    <HR>
    <H4>새로운 메인 이미지 등록</H4>
    <%-- 이미지가 존재하는 경우 새로운 이미지 등록 폼 출력 --%>
    <FORM name='frm' method='POST' action='./img_update.do' class="form-horizontal"
                enctype="multipart/form-data">
               
       <input type='hidden' name='admin_no' id='admin_no' value='${eventVO.admin_no }'>
       <input type='hidden' name='event_grp_no' id='event_grp_no' value="${param.event_grp_no }">
       <input type='hidden' name='event_no' id='event_no' value="${param.event_no }">
          
      <div class="form-group">   
        <div class="col-md-12">
          <%-- 실제 컬럼명: event_file, Spring File 객체 대응: event_fileMF --%>
          <input type='file' class="form-control" name='event_fileMF' id='event_fileMF' 
                    value='' placeholder="파일 선택">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='event_passwd'  value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>
      
      <button type="submit" class="btn btn-info">새로운 메인 이미지 등록</button>
      <button type="button" 
                  onclick="location.href='./read.do?event_no=${eventVO.event_no}'" 
                  class="btn btn-info">취소[조회]</button>
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
  