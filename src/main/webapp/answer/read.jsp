<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>

<body>
<c:set var="community_no" value="${communityVO.community_no}" />

<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class="title_line">
    커뮤니티 > Q&A 답변 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    <A href="./list.do"> Q&A > </A>
    답변 확인
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href="../qna/list.do">질문 목록</A>
    <span class='menu_divide' > | </span>
    <A href='./list.do'>답변 목록</A>
    <span class='menu_divide' > | </span> 
    <A href='./update.do?answer_no=${answerVO.answer_no }'>수정</A>
    <span class='menu_divide' > | </span> 
    <A href='./read_delete.do?answer_no=${answerVO.answer_no }'>삭제</A>
  </ASIDE> 
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
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
  </FORM>
  
   <div class='qna_read'' style='width: 95%; margin: 10px auto;'>          
  <table class="qna">
    <colgroup>
      <col style="width: 100%;">
      <col style="width: 0%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic" style="text-align: left;">답변 작성일자: ${answerVO.answer_rdate.substring(0, 16) }</th>
        <th class="th_basic" style="text-align: right;"></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">【 답변 내용 】 <br><br>${answerVO.answer_content }</th>
        <td style="text-align: right;"></td>
      </tr>
    </tbody>
  </table>
  </div>
  <br><br><br><br><br>
  <fieldset class='fieldset_basic'>
    <ASIDE class="aside_left">
      <button style='color: #ff8040;' type='button' onclick="location.href='./list.do'" class="btn btn-primary">답변 목록(관리자용)</button>
      <button type='button' onclick="location.href='../qna/list.do'" class="btn btn-primary">질문 목록</button>
    </ASIDE>
    <ASIDE class="aside_right">
      <button type='button' onclick="location.href='./update.do?answer_no=${answerVO.answer_no }'" class="btn btn-primary">수정</button>
      <button type='button' onclick="location.href='./read_delete.do?answer_no=${answerVO.answer_no }'" class="btn btn-primary">삭제</button>
    </ASIDE>
  </fieldset>
</FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>
