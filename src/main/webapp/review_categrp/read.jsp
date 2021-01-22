<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>상품 종류 조회폼</title>
 
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
    ${review_CategrpVO.review_categrp_name } 조회
  </DIV>
  
  <ASIDE class="aside_left">
    <A href="javascript:location.reload();">새로고침</A>   
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href='./create.do'>등록</A>
       <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
       <span class='menu_divide' >│</span>    
    <A href="../review_categrp/update.do?review_categrp_no=${review_CategrpVO.review_categrp_no }">수정</A>
       <span class='menu_divide' >│</span> 
    <A href='./list.do'>삭제</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  <DIV id='main_panel'></DIV>
 
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #FFFFFF; width: 80%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='review_categrp_no' id='review_categrp_no' value='${review_CategrpVO.review_categrp_no }'>
         
      <div class="form-group">
         <label class="col-md-2 control-label" style='font-size: 0.9em;'></label>    
            <div class="col-md-10">
               상품 종류: ${review_CategrpVO.review_categrp_name }        
            </div>
      </div>
      <div class="form-group">
         <label class="col-md-2 control-label" style='font-size: 0.9em;'></label>    
            <div class="col-md-10">
               출력 순서: ${review_CategrpVO.review_categrp_seqno }        
            </div>
      </div>

    </FORM>
  </DIV>
 
 <br><br>
  
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
  </colgroup>
 
  <thead>  
  <TR>
    <TH class="th_bs">순서</TH>
    <TH class="th_bs">상품 종류</TH>
    <TH class="th_bs">등록일</TH>
    <TH class="th_bs">기타</TH>
  </TR>
  </thead>
  
   <tbody> 
  <c:forEach var="review_CategrpVO" items="${list}"> 
    <c:set var="review_categrp_no" value="${review_CategrpVO.review_categrp_no }" />
    <TR>
      <TD class="td_bs">${review_CategrpVO.review_categrp_seqno }</TD>
      <TD class="td_bs_left"><A href="../review_categrp/read.do?review_categrp_no=${review_categrp_no }">${review_CategrpVO.review_categrp_name }</A></TD>
      <TD class="td_bs">${review_CategrpVO.review_categrp_date.substring(0, 10) }</TD>
      <TD class="td_bs">
        <A href="./read_update.do?review_categrp_no=${review_categrp_no }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?review_categrp_no=${review_categrp_no }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        <A href="./update_seqno_up.do?review_categrp_no=${review_categrp_no }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
        <A href="./update_seqno_down.do?review_categrp_no=${review_categrp_no }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
      </TD>   
    </TR>   
  </c:forEach> 
  </tbody>
 
</TABLE>
 
 
<jsp:include page="/menu/bottom.jsp" />
</body>
 
</html> 
 
 
 