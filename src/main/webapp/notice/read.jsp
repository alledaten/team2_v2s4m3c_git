<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 몰</title>

<!-- CSS --> 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery --> 
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap --> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>

<body>

<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>
    <A href="../"> 홈 </A> > <A href="../notice/list.do"> 공지사항 </A> > ${noticeVO.head }
  </DIV>

  <ASIDE class="aside_right">
    <A href="./create.do">글 등록</A>
    <span class='menu_divide' > | </span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href='./list.do'>목록</A>
    <span class='menu_divide' > | </span> 
    <A href="./update.do?noticeno=${param.noticeno }">수정</A>
    <span class='menu_divide' > | </span> 
    <A href="./read_delete.do?noticeno=${param.noticeno }">삭제</A>
    
  </ASIDE> 
  
  <div class='menu_line'></div>

  <FORM name='frm_update' id='frm_update' method='GET' action='./update.do'>
      <input type="hidden" name="noticeno" value="${noticeno}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA;'>
            <span>${noticeVO.head} | 등록일 : </span>
            <span>${noticeVO.rdate.substring(0, 16)} | </span>
            <span>조회수 : ${noticeVO.count}</span>
          </li>
          <li class="li_none">
            <DIV>${noticeVO.content }</DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>

