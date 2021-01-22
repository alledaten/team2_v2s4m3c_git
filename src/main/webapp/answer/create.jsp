<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
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
    답변 등록
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="../qna/list.do">질문 목록</A>
  </ASIDE> 
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal" enctype="multipart/form-data">>
    <!-- FK qna_no 지정 -->
    <input type="hidden" name="qna_no" id='qna_no' value="${qnaVO.qna_no }">
    <!-- FK member_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
        
    <table class="qna_read">
      <thead>
        <tr>
          <th scope="cols">질문 제목: ${qnaVO.qna_title}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
           <td>질문 내용:
                   ${qnaVO.qna_content }
           </td>
        </tr>
      </tbody>
    </table>
    
    <c:set var="answer_no" value="${answerVO.answer_no}" />
        
  <div class="form-group">   
    <div class="col-md-12">
      <textarea class="form-control" name='answer_content' id='answer_content' rows='10' placeholder="답변 내용">답변 내용</textarea>
    </div>
  </div>   

  <div class="form-group">   
    <div class="col-md-12">
      <%-- 실제 컬럼명: fiel1, Spring File 객체 대응: fiel1MF --%>
      <input type='file' class="form-control" name='file1MF' id='file1MF' 
                value='' placeholder="파일 선택">
    </div>
  </div>

  <fieldset class='fieldset_basic'>
    <ASIDE class="aside_left">
      <button style='color: #ff8040;' type='button' onclick="location.href='./list.do'" class="btn btn-primary">답변 목록(관리자용)</button>
      <button type='button' onclick="location.href='../qna/list.do'" class="btn btn-primary">질문 목록</button>
    </ASIDE>
    <ASIDE class="aside_right">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick = "history.back()" class="btn btn-primary">취소</button>
    </ASIDE>
  </fieldset>


</FORM>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
