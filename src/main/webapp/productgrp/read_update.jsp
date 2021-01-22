<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="../css/style.css" rel="stylesheet" type="text/css">
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" />
 
  <DIV class='title_line'>상품 그룹 > ${productgrpVO.productgrp_name } 조회(수정)</DIV>
 
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='productgrp_no' id='productgrp_no' value='${productgrpVO.productgrp_no }'>
        
      <label>그룹 이름</label>
      <input type='text' name='productgrp_name' value="${productgrpVO.productgrp_name }" required="required" style='width: 25%;'>
 
      <label>순서</label>
      <input type='number' name='productgrp_seqno' value="${productgrpVO.productgrp_seqno }" required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='productgrp_visible'>
        <option value='Y' ${productgrpVO.productgrp_visible == 'Y' ? "selected='selected'":"" }>Y</option>
        <option value='N' ${productgrpVO.productgrp_visible == 'N' ? "selected='selected'":""}>N</option>
      </select>
       
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="location.href='./list.do'">취소</button>
    </FORM>
  </DIV>
 
  
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 20%;'/>
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>    
    <col style='width: 20%;'/>
  </colgroup>
 
  <thead>  
  <TR>
    <TH class="th_bs">순서</TH>
    <TH class="th_bs">대분류명</TH>
    <TH class="th_bs">출력</TH>
    <TH class="th_bs">기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="productgrpVO" items="${list}">
    <c:set var="productgrp_no" value="${productgrpVO.productgrp_no }" />
    <TR>
      <TD class="td_bs">${productgrpVO.productgrp_seqno }</TD>
      <TD class="td_bs_left">${productgrpVO.productgrp_name }</TD>
      <TD class="td_bs">${productgrpVO.productgrp_visible }</TD>
      <TD class="td_bs">
        <A href="./read_update.do?productgrp_no=${productgrp_no }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?productgrp_no=${productgrp_no }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        <A href="./update_seqno_up.do?productgrp_no=${productgrp_no }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
        <A href="./update_seqno_down.do?productgrp_no=${productgrp_no }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
       </TD>   

    </TR>   
  </c:forEach> 
  </tbody>
 
</TABLE>
 
 
<jsp:include page="/menu/bottom.jsp" />
</body>
 
</html> 
 
 
 