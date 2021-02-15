<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>이벤트 수정</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  // window.onload=function(){
  //  CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  // };

  $(function() {
    CKEDITOR.replace('event_content');  // <TEXTAREA>태그 id 값
  });
</script> 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class='title_line' style="width: 80%; margin: 30px auto; font-size: 20px; font-weight: bold;">
    <strong class ="review_title">『${eventVO.event_title}』 수정</strong>
  </DIV>
  
  <div style="width: 80%; margin: 5px auto;">
    <A href="../event_grp/list.do?event_grp_no=${event_grpVO.event_grp_no }">${event_grpVO.event_grp_title }</A> > 
       ${eventVO.event_title}
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./update.do'
               enctype="multipart/form-data" class="form-horizontal">
      <!-- FK memberno 지정 -->
      <input type='hidden' name='admin_no' id='admin_no' value='${eventVO.admin_no }'>
      <!-- FK categrpno 지정 -->
      <input type='hidden' name='event_grp_no' id='event_grp_no' value='${param.event_grp_no }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      <input type='hidden' name='event_no' id='event_no' value='${param.event_no }'>
      
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='event_title' value="${eventVO.event_title }" 
                    placeholder="제목" required="required" style='width: 80%;' autofocus="autofocus">
        </div>
      </div>   
      
      <div class="form-group">   
        <div class="col-md-12">
          <textarea class="form-control" name='event_content' id='event_content' rows='10' style="width:80%;" placeholder="내용" >${eventVO.event_content }</textarea>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='event_word'  value='${eventVO.event_word }' placeholder="검색어" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='event_passwd'  value='' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>
      
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">수정</button>
        <button type="button" 
                    onclick="location.href='./read.do?event_no=${eventVO.event_no}'" 
                    class="btn btn-info">취소[조회]</button>
      </DIV>
              
    </FORM>
  </DIV>
</div>
  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

