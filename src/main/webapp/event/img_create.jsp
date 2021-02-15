<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>이벤트 메인 이미지 등록</title>
 
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
    <strong class ="review_title">『${eventVO.event_title}』 메인 이미지 등록</strong>
  </DIV>

  <DIV style='width: 80%; margin: 5px auto;'>
    <FORM name='frm' method='POST' action='./img_create.do' class="form-horizontal"
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
      
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">등록</button>
        <button type="button" 
                    onclick="location.href='./read.do?event_no=${eventVO.event_no}'" 
                    class="btn btn-info">취소[조회]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
  