<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
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
    질문 수정
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
      <!-- FK communuity_no 지정 -->
      <input type="hidden" name="communuity_no" id='communuity_no' value="4">
      <!-- FK member_no 지정 -->
      <input type='hidden' name='member_no' id='member_no' value='1'>
      
      <input type='hidden' name='qna_no' id='qna_no' value='${qnaVO.qna_no }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
          
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='qna_title' value='${qnaVO.qna_title }' placeholder="제목" required="required" style='width: 80%;'>
        </div>
      </div>   
          
      <div class="form-group">   
        <div class="col-md-12">
          <pre><textarea class="form-control" name='qna_content' id='qna_content' rows='10' placeholder="질문 내용">${qnaVO.qna_content }</textarea></pre>
        </div>
      </div>
          
      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='qna_passwd'  value='' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>    
       
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">수정</button>
        <button type="button" 
                     onclick="location.href='./list.do?qna_no=${param.qna_no}&qna_word=${param.qna_word }&nowPage=${param.nowPage}'" 
                     class="btn btn-info">취소[목록]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
