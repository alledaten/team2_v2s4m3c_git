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
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class="title_line">
    커뮤니티 > Q&A 답변 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    Q&A
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="../qna/list.do">질문 목록</A>
    <!--  <span class='menu_divide' >│</span> -->
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>
  

  <!-- FK qna_no 지정 -->
  <input type="hidden" name="qna_no" id='qna_no' value="${qnaVO.qna_no }">
  <!-- FK member_no 지정 -->
  <input type='hidden' name='member_no' id='member_no' value='1'>
  
  <input type="hidden" name="answer_no" id='answer_no' value="${answerVO.answer_no }">
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 5%;">
      <col style="width: 20%;">
      <col style="width: 40%;">
      <col style="width: 15%;">
      <col style="width: 10%;">
      <col style="width: 10%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic">NO</th>
        <th class="th_basic">답변확인 이미지</th>
        <th class="th_basic">답변사항</th>
        <th class="th_basic">작성자</th> 
        <th class="th_basic">등록일</th>
        <th class="th_basic">기타</th>
      </tr>
    </thead>
      
    <tbody>
    <c:forEach var="answerVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="answer_no" value="${answerVO.answer_no}" />
      <c:set var="thumb1" value="${answerVO.thumb1 }" />
      
      <TR>
        <TD style='vertical-align: middle; class="td_bs"'>${answerVO.answer_no }</TD>
        <td style='vertical-align: middle; text-align: center;'>
              <c:choose>
                <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                  <IMG src="./storage/main_images/${thumb1 }" style="width:120px; height: 80px;"> 
                </c:when>
                <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                  ${contentsVO.file1}
                </c:otherwise>
              </c:choose>
            </td>  
        <TD class="td_bs_left"><a href="./read.do?answer_no=${answerVO.answer_no}">└re: ${answerVO.answer_content}</a></TD>
        <TD class="td_bs">관리자</TD>
        <TD class="td_bs">${answerVO.answer_rdate.substring(0, 10) }</TD>
        <TD class="td_bs">
          <A href="./update.do?answer_no=${answerVO.answer_no }"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?answer_no=${answerVO.answer_no }"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>             
  
      </TR>
    </c:forEach>
    </tbody>
    
    </table>
    
    <fieldset class='fieldset_basic'>
      <div class="content_bottom_menu" style="padding-right: 50%;">
        <button type='button' onclick="location.href='../qna/list.do'" class="btn btn-primary">질문 목록</button>
      </div>
    </fieldset>
     
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
