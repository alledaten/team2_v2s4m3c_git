<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function() {
    $("#qna_check").change(function(){
      if($("#qna_check").is(":checked")){
          alert("비밀글로 설정합니다.");
      }else{
          alert("비밀글을 해제합니다.");
      }
  });
  });

    
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class="title_line">
    커뮤니티 > Q&A 질문 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    <A href="./list.do"> Q&A > </A>
    질문 등록
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  
  <div class='menu_line'></div>
 
 <FORM name='frm' method='POST' action='./create.do' class="form-horizontal" enctype="multipart/form-data">
    <!-- FK communuity_no 지정 -->
    <input type="hidden" name="communuity_no" id='communuity_no' value="4">
    <!-- FK member_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
      
    <div class="form-group" style="padding-left: 10%;">   
      <div class="col-md-12">
        <label>질문 제목: </label>
        <input type='text' class="form-control" name='qna_title' value='질문 테스트' placeholder="제목" required="required" style='width: 80%;'>
      </div>
    </div>   
      
    <div class="form-group" style="padding-left: 10%;">   
      <div class="col-md-12">
        <label>질문 내용: </label>
        <textarea class="form-control" name='qna_content' id='qna_content' rows='10' placeholder="질문 내용" style='width: 80%;'>질문 내용 test</textarea>
      </div>
    </div>
      
    <div class="form-group" style="padding-left: 10%;">   
      <div class="col-md-12">
        <label>비밀번호: </label>
        <input type='password' class="form-control" name='qna_passwd' id='qna_passwd'  value='1234' placeholder="패스워드" style='width: 20%;'>
      </div>
    </div>
    
   <div class="form-group" style="padding-left: 10%;">   
      <div class="col-md-12">
        <label>비밀글 설정: 
        <input type='checkbox' class="form-control" name='qna_check' id='qna_check' value='Y' style='width: 50%;'></label>
      </div>
    </div>  
    
  <div class="form-group" style="padding-left: 10%;">
    <div class="col-md-12">
      <%-- 실제 컬럼명: fiel1, Spring File 객체 대응: fiel1MF --%>
      <label>첨부파일: </label>
      <input type='file' class="form-control" name='file1MF' id='file1MF' 
                value='' placeholder="파일 선택" style='width: 80%;'>
    </div>
  </div>
      
    <div class="content_bottom_menu" style="padding-right: 20%;">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">목록(취소)</button>
    </div>
  
  </FORM>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
