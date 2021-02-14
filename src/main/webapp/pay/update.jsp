<%@ page contentType="text/html; charset=UTF-8" %>
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
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class="title_line">
    전통주 주문
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 전통주 ></A>
    <A href="./list.do"> 전통주 주문 > </A>
    결제 정보 등록
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
    <!-- FK communuity_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
    <!-- FK member_no 지정 -->
    <input type='hidden' name='product_no' id='product_no' value='1'>
    <!-- FK member_no 지정 -->
    <input type='hidden' name='buy_no' id='buy_no' value='2'>
    <!-- FK member_no 지정 -->
    <input type='hidden' name='pay_no' id='pay_no' value='${payVO.pay_no }'>

    
    <div class="form-group">   
      <div class="col-md-12">
        <label>결제 금액: </label>
        <input type='text' class="form-control" name='product_cost' value='${payVO.product_cost }' placeholder="10000" required="required" style='width: 30%;'>
      </div>
    </div>
    
    <div class="form-group">   
      <div class="col-md-12">
        <label>결제 방법: </label>
        <input type='text' class="form-control" name='pay_way' value='${payVO.pay_way}' placeholder="카드 결제" required="required" style='width: 80%;'>
      </div>
    </div>
     

    
      <div class="content_bottom_menu" style="padding-right: 20%;">
        <button type="submit" class="btn btn-primary">수정</button>
        <button type="button" onclick="location.href='../buy/list.do'" class="btn btn-primary">수정 취소</button>
      </div>
    
     <div style='clear: both;'></div>
    
  </FORM>
 
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
