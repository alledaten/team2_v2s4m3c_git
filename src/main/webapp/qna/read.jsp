<%@ page contentType="text/html; charset=UTF-8"%>
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

<style type="text/css">
  /* ****************** */
  /* Q&A 태그 관련 */
  /* ****************** */
  
  table.qna {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5; 
  }
  
  table.qna thead th {
    padding: 10px;
    font-size: 20px; 
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
  }
  table.qna tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #f3f6f7;
  }
  table.qna td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
  }
 
  table.qna_read {
    border-collapse: collapse;
    width: 95%;
    text-align: left;
    line-height: 1.5;
    border-left: 1px solid #ccc;
    margin: 10px auto;
  }
  
  table.qna_read thead th {
    padding: 10px;
    font-weight: bold;
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-bottom: 2px solid #c00;
    background: #dcdcd1;
  }
  table.qna_read tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    background: #ececec;
  }
  table.qna_read td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
  }
  
  .qna_bottom_menu {
    clear: both;
    padding-top: 20px;
    padding-right: 20px;
    text-align: right;
    width: 100%;
    background-color: #ffffff;
  }
  
  .product_read {
    width: 40%;
    float: right;
    margin: 10px; 
    border-top: none;
    border-right: none;
    border-bottom: none;
    border-left: none;
    padding: 10px;
  }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
  
<body>
<c:set var="community_no" value="${communityVO.community_no}" />

<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class="title_line">
    커뮤니티 > Q&A 질문 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    <A href="./list.do"> Q&A > </A>
    질문 확인
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href="./create.do">질문 등록</A>
    <span class='menu_divide' > | </span> 
    <A href='../answer/create.do?qna_no=${qnaVO.qna_no }'> 답변</A>
    <span class='menu_divide' > | </span>
    <A href='./list.do?qna_no=${qnaVO.qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}''>목록</A>
    <span class='menu_divide' > | </span> 
    <A href='./update.do?qna_no=${qnaVO.qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}'>수정</A>
    <span class='menu_divide' > | </span> 
    <A href='./delete.do?qna_no=${qnaVO.qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}'>삭제</A>
  </ASIDE> 
  
  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
  <!-- FK communuity_no 지정 -->
  <input type="hidden" name="communuity_no" id='communuity_no' value="4">
  
  <input type="hidden" name="qna_no" value="${qnaVO.qna_no}">
     
  <div class='qna_read'' style='width: 88%; margin: 10px auto;'>          
  <table class="qna">
    <colgroup>
      <col style="width: 80%;">
      <col style="width: 20%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic" style="text-align: left;">질문 제목: ${qnaVO.qna_title}</th>
        <th class="th_basic" style="text-align: right;">작성자: ${qnamemberVO.mid }</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">작성일자: ${qnaVO.qna_rdate.substring(0, 16) }</th>
        <td style="text-align: right;">비밀글:
           <c:choose>
            <c:when test="${qna_check == 'Y'}">
              <A href="./update_visible.do?qna_no=${qna_no }&qna_visible=${qna_visible }"><IMG src="./images/bimil.png"></A>
            </c:when>
            <c:otherwise>
              <A href="./update_visible.do?qna_no=${qna_no }&qna_visible=${qna_visible }"><IMG src="./images/show.png"></A>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <th scope="row">파일명: </th>
        <td></td>
      </tr>
    </tbody>
  </table>
  
          <li class="li_none">
            <c:set var="file1" value="${qnaVO.file1 }" />
            <c:if test="${file1.endsWith('jpg') || file1.endsWith('png') || file1.endsWith('gif')}">
              <DIV style="width: 50%; float: left; margin-right: 10px;">
                <IMG src="./storage/main_images/${file1 }" style="width: 100%;">
              </DIV> 
            </c:if> 
          </li>
              
  <ul>
    <li class="li_none">
      <DIV> ${qnaVO.qna_content } </DIV>
    </li>
  </ul>
  </div>
  <br><br><br><br><br>
  <fieldset class='fieldset_basic' style='width: 88%; margin: 10px auto;'>
    <ASIDE class="aside_left">
      <button type='button' onclick="location.href='./list.do?qna_no=${qnaVO.qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}'" class="btn btn-primary">목록</button>
      <button type='button' onclick="location.href='./create.do'" class="btn btn-primary">새로운 질문 등록</button>
    </ASIDE>
    <ASIDE class="aside_right">
      <button type='button' onclick="location.href='../answer/list_title.do?qna_no=${qnaVO.qna_no}'" class="btn btn-primary">답변 확인</button>
      <button type='button' onclick="location.href='./update.do?qna_no=${qnaVO.qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}'" class="btn btn-primary">수정</button>
      <button type='button' onclick="location.href='./delete.do?qna_no=${qnaVO.qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}'" class="btn btn-primary">삭제</button>
    </ASIDE>
  </fieldset>
    
    <div class="qna_bottom_menu" style="padding-right: 50%;">
      <button style='color: #ff8040;' type="button" onclick="location.href='./reply.do?qna_no=${qnaVO.qna_no  }&community_no=${qnaVO.community_no }&nowPage=${param.nowPage }'" class="btn btn-primary">답변 등록(관리자용)</button>
    </div>

</FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>
