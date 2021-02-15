<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>이벤트 등록</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
 <script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">

  $(function() {
    CKEDITOR.replace('event_content');  // <TEXTAREA>태그 id 값
  });
 
</script>

</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class=" review_title_line">
    <strong class ="review_title">이벤트 등록</strong>
  </DIV>
  
  <DIV style="width: 80%; margin: 5px auto;">
    <ASIDE class="review_aside_left">
      * 표시는 필수 입력사항 입니다.
    </ASIDE>
  </DIV>
   
  <DIV style="width: 80%; margin: 5px auto;">
    <ASIDE class="review_aside_right">
      <A href='../event/list.do?event_grp_no=${param.event_grp_no }&event_word=${param.event_word}&nowPage=${param.nowPage}'>관련된 이벤트 목록</A>
        <span class='menu_divide' > | </span>
      <A href="javascript:location.reload();">새로고침</A>
    </ASIDE> 
  </DIV> 
 
  <div class='review_menu_line'></div>
  
  <DIV style='width: 80%; margin: 5px auto;'>
    <FORM name='frm' method='POST' action='./create.do' class="form-horizontal"
                enctype="multipart/form-data">
               
      <!-- FK 지정 -->
      <input type='hidden' name='admin_no' id='admin_no' value='${sessionScope.admin_no }'>
      <input type='hidden' name='event_grp_no' id='event_grp_no' value='${param.event_grp_no }'>
      
      <div class="form-group" >   
        <div class="col-md-12">
          <input type='text' class="form-control" name='event_title' placeholder="* 제목을 입력해주세요." required="required" style='width: 100%;'>
        </div>
      </div>   
      
      <div class="form-group">   
        <div class="col-md-12">
          <textarea class="form-control" name='event_content' id='event_content' rows='10' required="required" placeholder="* 내용을 입력해주세요."></textarea>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          <%-- 실제 컬럼명: file1, Spring File 객체 대응: file1MF --%>
          <input type='file' class="form-control" name='event_fileMF' id='event_fileMF' 
                    value='' placeholder="파일 선택">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='event_word'  value='' placeholder="검색어를 입력해주세요." style='width: 100%;'>
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name=event_passwd  value='' placeholder=" * 비밀번호를 입력해주세요." style='width: 20%;'>
        </div>
      </div>
      
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">등록</button>
        <button type="button" 
                    onclick="location.href='../event/list.do?event_grp_no=${param.event_grp_no}&event_word=${param.event_word }&nowPage=${param.nowPage }'" 
                    class="btn btn-info">취소[이전 페이지]</button>
      </DIV>
       
    </FORM>
  </DIV>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
  