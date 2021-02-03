<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 커뮤니티</title>

<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

</script>
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>
    관리자 정보
  </DIV>

  <ASIDE class="aside_left">
    <A href=''>관리자</A> > 
    <A href=''>관리자 정보</A> > 수정
  </ASIDE>
  <ASIDE class="aside_right">
    <A href='./list.do'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' id="frm" method='POST' action='./update.do' class="form-horizontal"
          enctype="multipart/form-data">
      <input type="hidden" name="admin_no" value="${adminVO.admin_no}" >

      <div class="form-group">   
        <label for="admin_id" class="col-md-2 control-label">아이디 *</label>
        <div class="col-md-6">
          <input type="text" class="form-control" name='admin_id' id='admin_id' value="${adminVO.admin_id }" readonly="readonly"  style="width:80%;">
        </div>
      </div>

      <div class="form-group">
        <label for="admin_passwd" class="col-md-2 control-label">비밀번호 *</label>
        <div class="col-md-6">
          <input type='password' class="form-control" name='admin_passwd'  id='admin_passwd' value='' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>

      <div class="form-group">   
        <label for="admin_name" class="col-md-2 control-label">이름 *</label>
        <div class="col-md-6">
          <input type='text' class="form-control" name='admin_name' value='${adminVO.admin_name }' placeholder="이름" required="required" style='width: 80%;'>
        </div>
      </div>

      <DIV class='content_bottom_menu'>
        <button type="submit" id="btn_send" class="btn btn-info">수정</button>
        <button type="button" 
                onclick="location.href='./list.do'" 
                class="btn btn-info">취소</button>
      </DIV>
       
    </FORM>
  </DIV>
  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

