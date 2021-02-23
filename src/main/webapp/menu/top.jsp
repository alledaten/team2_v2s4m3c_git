<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="css/common.css" rel="stylesheet" type="text/css">
<link href="css/menu.css" rel="stylesheet" type="text/css">

  <!-- 화면 상단 메뉴 -->
  <div id="header">
    <div class="top_header">
      <div class="top_header_inner">
        <ul class="util">
          <c:choose>
            <c:when test="${sessionScope.member_id == null}">
              <li><a href="${pageContext.request.contextPath}/member/login.do">로그인</a></li>
              <li><a href="${pageContext.request.contextPath}/member/create.do">회원가입</a></li>
            </c:when>
            <c:otherwise>
              <li>${sessionScope.member_name } 님 환영합니다! <A href='${pageContext.request.contextPath}/member/logout.do' >로그아웃</A></li>
            </c:otherwise>
          </c:choose>
          <c:choose>
            <c:when test="${sessionScope.admin_id == null}">
              <li><a href="${pageContext.request.contextPath}/admin/login.do">관리자 로그인</a></li>
            </c:when>
            <c:otherwise>
              <li>${sessionScope.admin_id } 님 환영합니다! <A href='${pageContext.request.contextPath}/admin/logout.do' >로그아웃</A></li>
            </c:otherwise>
          </c:choose>
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
            <li><a href="${pageContext.request.contextPath}/newsgrp/list_ajax.do">전통주 뉴스</a></li>
            <li><a href="#">관련 사이트</a></li>
          </ul>
        </li>
        <li><a href="#">전통주</a>
          <ul class="depth2">
            <li><a href="${pageContext.request.contextPath}/productgrp/list.do">전통주 종류</a></li>
            <li><a href="#">갤러리</a></li>
            <li><a href='${pageContext.request.contextPath}/review/list_all.do'>리뷰 게시판</a></li>
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
            <li><a href='${pageContext.request.contextPath}/buy/create.do'> 주문</a></li>
            <li><a href='${pageContext.request.contextPath}/buy/list.do'> 조회</a></li>
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
            <li><a href="${pageContext.request.contextPath}/auth/list.do">회원권한</a></li>
            <li><a href="${pageContext.request.contextPath}/memberlevel/list.do">회원등급</a></li>
            <li><a href="${pageContext.request.contextPath}/snslogin/list.do">SNS로그인</a></li>
            <c:choose>
              <c:when test="${sessionScope.member_id != null}"> <!-- 회원 로그인된 상태라면 로그인기록이 보임 -->
                <li><a href="${pageContext.request.contextPath}/login_log/list.do">로그인 기록</a></li>
              </c:when>
              <c:when test="${sessionScope.admin_id != null}"> <!-- 관리자 로그인된 상태라면 로그인기록이 보임 -->
                <li><a href="${pageContext.request.contextPath}/admin/list.do">관리자 목록</a></li>
                <li><a href="${pageContext.request.contextPath}/admin_log/list.do">로그인 기록</a></li>
              </c:when>
              <c:otherwise>
                <!-- 로그인하지 않은 상태라면 빈칸 -->
              </c:otherwise>
            </c:choose>
          </ul>
        </li>
        <li><a href="#">이벤트</a>
          <ul class="depth2">  
          <c:choose>
              <c:when test="${sessionScope.admin_id != null}"> <!-- 관리자가 로그인된 상태라면 이벤트 목록이 보임 -->
                <li><a href='${pageContext.request.contextPath}/event_grp/list.do'>이벤트 그룹 목록</a></li>
              </c:when>
              <c:otherwise>
                <!-- 관리자로 로그인하지 않은 상태라면 관련 이벤트만 보임 (★ 이벤트가 수정된다면 링크는 수동으로 수정해야함) -->
              </c:otherwise>
            </c:choose>
         <li><a href="${pageContext.request.contextPath}/event/read.do?event_grp_no=1&event_no=1">1월 이벤트</a></li>
         <li><a href="${pageContext.request.contextPath}/event/read.do?event_grp_no=2&event_no=2">2월 이벤트</a></li>
         <li><a href="${pageContext.request.contextPath}/event/read.do?event_grp_no=3&event_no=3">특별 이벤트</a></li>       
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <DIV class="col-md-12 cont">
    <!-- 내용 출력 컬럼 -->
    <DIV class='content'>