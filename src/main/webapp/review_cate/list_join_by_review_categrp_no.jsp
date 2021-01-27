<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>(상품 종류 + 분류) + 상품 종류별 목록</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" />
 
  <DIV class='title_line' style="width: 80%; margin: 30px auto; font-size: 20px; font-weight: bold;">
    <A href="../review_categrp/list.do">상품 종류</A> > 
    <A href="./list_join.do">분류</A> > 
    ${review_CategrpVO.review_categrp_name } (${review_CategrpVO.review_categrp_date.substring(0, 10) })
  </DIV>
 
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' 
                action='./create.do'>

      <label>상품 종류 번호</label>
      <input type='number' name='review_categrp_no' value='' required="required" 
                min="1" max="99999" step="1" style='width: 5%;'>
         
      <label>분류</label>
      <input type='text' name='review_cate_name' value='' required="required" style='width: 25%;'>
 
      <label>순서</label>
      <input type='number' name='review_cate_seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
 
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="location.href='./list.do?review_categrp_no=${param.review_categrp_no}'">취소</button>
    </FORM>
  </DIV>
  
<TABLE class='table table-striped' style="width: 80%; margin: 10px auto;" >
  <colgroup>
    <col style="width: 10%;"/>
    <col style="width: 10%;"/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
    <col style='width: 5%;'/>        
    <col style='width: 20%;'/>
  </colgroup>
 
  <thead>  
  <TR>
    <TH class="th_bs">순서</TH>
    <TH class="th_bs">상품 종류</TH>
    <TH class="th_bs">분류</TH>
    <TH class="th_bs">등록일</TH>
    <TH class="th_bs">글수</TH>
    <TH class="th_bs">기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="Review_Categrp_Review_Cate_join" items="${list }">  <!-- request 객체에 접근 -->
    <c:set var="review_categrp_name" value="${Review_Categrp_Review_Cate_join.g_review_categrp_name}" />
    <c:set var="review_categrp_no" value="${Review_Categrp_Review_Cate_join.review_categrp_no}" />
    <c:set var="review_cate_seqno" value="${Review_Categrp_Review_Cate_join.review_cate_seqno}" />
    <c:set var="review_cate_no" value="${Review_Categrp_Review_Cate_join.review_cate_no}" />
    <c:set var="review_cate_name" value="${Review_Categrp_Review_Cate_join.review_cate_name}" />
    <c:set var="review_cate_date" value="${Review_Categrp_Review_Cate_join.review_cate_date}" />
    <c:set var="review_cate_cnt" value="${Review_Categrp_Review_Cate_join.review_cate_cnt}" />
    
    <TR>
      <TD class="td_bs">${review_cate_seqno }</TD>
      <TD class="td_bs">${review_categrp_name }</TD>
      <TD class="td_bs"><A href="../review/list.do?review_cate_no=${review_cate_no}&review_categrp_no=${review_categrp_no}">${review_cate_name }</A></TD> 
      <TD class="td_bs">${review_cate_date.substring(0, 10) }</TD>
      <TD class="td_bs">${review_cate_cnt }</TD>
      <TD class="td_bs">
        <A href="./read_update.do?review_cate_no=${review_cate_no }&review_categrp_no=${review_categrp_no}" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?review_cate_no=${review_cate_no }&review_categrp_no=${review_categrp_no}" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        <A href="./update_review_cate_seqno_up.do?review_cate_no=${review_cate_no }&review_categrp_no=${review_categrp_no}" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
        <A href="./update_review_cate_seqno_down.do?review_cate_no=${review_cate_no }&review_categrp_no=${review_categrp_no}" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
      </TD>             
    </TR>
  </c:forEach>
  </tbody>
 
</TABLE>
 
<jsp:include page="/menu/bottom.jsp" />
</body>
 
</html>

