<%@ page contentType="text/html; charset=UTF-8"%>

<%
  // String root = request.getContextPath(); // /resort 
// ${pageContext.request.contextPath}
%>

<link href="css/common.css" rel="stylesheet" type="text/css">
<link href="css/menu.css" rel="stylesheet" type="text/css">

  <!-- 화면 상단 메뉴 -->
  <div id="header">
    <div class="top_header">
      <div class="top_header_inner">
        <ul class="util">
          <li><a href="#">로그인</a></li>
          <li><a href="${pageContext.request.contextPath}/member/create.do">회원가입</a></li>
        </ul>
      </div>
    </div>
    <div class="middle_header">
      <h1>
        <a href="http://localhost:9090/team2_git">전통주 리뷰 커뮤니티</a>
      </h1>
    </div>
    <div class="bottom_header">
      <ul class="gnb">
        <li><a href="#">공지사항</a>
          <ul class="depth2">
            <li><a href="${pageContext.request.contextPath}/notice/list.do">공지사항</a></li>
            <li><a href="#">전통주 뉴스</a></li>
            <li><a href="#">관련 사이트</a></li>
          </ul>
        </li>
        <li><a href="#">전통주</a>
          <ul class="depth2">
            <li><a href="#">전통주 종류</a></li>
            <li><a href="#">갤러리</a></li>
            <li><a href='${pageContext.request.contextPath}/review_categrp/list.do'>리뷰 게시판</a></li>
          </ul>
        </li>
        <li><a href="#">랭킹</a>
          <ul class="depth2">
            <li><a href="#">조회수</a></li>
            <li><a href="#">추천수</a></li>
            <li><a href="#">구매수</a></li>
          </ul>
        </li>
        <li><a href="#">구매하기</a>
          <ul class="depth2">
            <li><a href="#">주문</a></li>
            <li><a href="#">조회</a></li>
          </ul> 
        </li> 
        <li><a href="#">커뮤니티</a>
          <ul class="depth2">
            <li><a href="${pageContext.request.contextPath}/forum/list.do?boardgrp_no=1">자유게시판</a></li>
            <li><a href="#">술 토크</a></li>
            <li><a href="#">기타게시판</a></li>
            <li><a href='${pageContext.request.contextPath}/qna/list.do'> Q&A </a></li> 
          </ul>
        </li>
        <li><a href="#">회원</a>
          <ul class="depth2">
            <li><a href='${pageContext.request.contextPath}/member/list.do'>회원목록</a></li>
            <li><a href="${pageContext.request.contextPath}/auth/list.do">회원등급</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <DIV class="col-md-12 cont">
    <!-- 내용 출력 컬럼 -->
    <DIV class='content'>