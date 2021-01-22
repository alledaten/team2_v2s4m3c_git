<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
 <script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class="title_line">
    커뮤니티 > Q&A 답변 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    <A href="./list.do"> Q&A > </A>
    답변 수정
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="../qna/list.do">질문 목록</A>  
  </ASIDE> 
  
  <div class='menu_line'></div>
 
        
    <table class="qna_read">
      <thead>
        <tr>
          <th scope="cols">질문 제목: ${qnaVO.qna_title}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
           <td>질문 내용: ${qnaVO.qna_content }
           </td>
        </tr>
      </tbody>
    </table>

  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
  <!-- FK qna_no 지정 -->
  <input type="hidden" name="qna_no" id='qna_no' value="${qnaVO.qna_no }">
  <!-- FK member_no 지정 -->
  <input type='hidden' name='member_no' id='member_no' value='1'>
   
  <input type='hidden' name='answer_no' id='answer_no' value='${answerVO.answer_no }'>   

      <div class="form-group">   
        <div class="col-md-12">
          <textarea class="form-control" name='answer_content' id='answer_content' rows='10' placeholder="답변 내용">${answerVO.answer_content }</textarea>
        </div>
      </div>

   
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">수정</button>
        <button type="button" 
                    onclick="location.href='./list.do?answer_no=${param.answer_no}'" 
                    class="btn btn-info">취소[목록]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
