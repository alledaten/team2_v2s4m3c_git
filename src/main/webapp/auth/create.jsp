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
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class="title_line">
    가을
  </DIV>
  <ASIDE class="aside_left">
    <A href=''>카테고리 그룹</A> > 
    <A href=''>카테고리</A> >
    신규 등록
  </ASIDE>
  <ASIDE class="aside_right">
    <A href=''>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">

      <div class="form-group">   
        <div class="col-md-12">
          ID : <input type='text' class="form-control" name='member_id' value='test1' placeholder="제목" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          비밀번호 : <input type='password' class="form-control" name='member_passwd'  value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          닉네임 : <input type='text' class="form-control" name='member_nickname' value='단풍' placeholder="별명" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          성명 : <input type='text' class="form-control" name='member_name' value='홍길동' placeholder="이름" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          주민등록번호 : <input type='text' class="form-control" name='member_isAdult' value='8000001234567' placeholder="주민등록번호" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          전화번호 : <input type='text' class="form-control" name='member_tel' value='01012345678' placeholder="전화번호" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          이메일 : <input type='text' class="form-control" name='member_email' value='test1@gmail.com' placeholder="이메일" required="required" style='width: 80%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          주소 : <input type='text' class="form-control" name='member_address' value='서울특별시' placeholder="주소" required="required" style='width: 80%;'>
        </div>
      </div>
      
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">가입</button>
        <button type="button" 
                    onclick="location.href='./list.do?categrpno=${param.categrpno}'" 
                    class="btn btn-info">취소[목록]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
  