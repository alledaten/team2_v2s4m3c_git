<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>분류 삭제</title>
 
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
 
  <DIV class='title_line'>
    <A href="../review_categrp/list.do">상품 종류</A> >  
    <A href="./list_join.do">분류</A> > ${review_CateVO.review_cate_name } 삭제
  </DIV>
 
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <div class="msg_warning">삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type='hidden' name='review_cate_no' id='review_cate_no' value="${review_CateVO.review_cate_no }">
      <input type='hidden' name='review_categrp_no' id='review_categrp_no' value="${review_CateVO.review_categrp_no }">
      
      <label>상품 종류 번호</label>: ${review_CateVO.review_categrp_no } &nbsp;
      <label>분류</label>: ${review_CateVO.review_cate_name} &nbsp;
      <label>순서</label>: ${review_CateVO.review_cate_seqno} &nbsp;
       
      <button type="submit" id='submit'>삭제</button>
      <button type="button" onclick="location.href='./list.do?review_categrp_no=${param.review_categrp_no}'">취소</button>
    </FORM>
  </DIV>
  
  <TABLE class='table table-striped'>
    <colgroup>
      <col style="width: 10%;"/>
      <col style='width: 30%;'/>
      <col style='width: 20%;'/>
      <col style='width: 5%;'/>        
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
      <TH class="th_bs">상품 종류</TH>
      <TH class="th_bs">분류</TH>
      <TH class="th_bs">글수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="review_CateVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="cateno" value="${review_CateVO.review_cate_no}" />
      
      <TR>
        <TD class="td_bs">${review_CateVO.review_cate_seqno }</TD>
        <TD class="td_bs">${review_CateVO.review_cate_name }</TD>
        <TD class="td_bs">${review_CateVO.review_cate_date.substring(0, 10) }</TD>
        <TD class="td_bs">${review_CateVO.review_cate_cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?review_cate_no=${review_cate_no }&review_categrp_no=${review_categrp_no}"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?review_cate_no=${review_cate_no }&review_categrp_no=${review_categrp_no}"><span class="glyphicon glyphicon-trash"></span></A>
          <A href="./update_seqno_up.do?cateno=${cateno }"><span class="glyphicon glyphicon-arrow-up"></span></A>
          <A href="./update_seqno_down.do?cateno=${cateno }"><span class="glyphicon glyphicon-arrow-down"></span></A>         
        </TD>             
      </TR>
    </c:forEach>
    </tbody>
   
  </TABLE>
 
 
<jsp:include page="/menu/bottom.jsp" />
</body>
 
</html> 
 
 
 