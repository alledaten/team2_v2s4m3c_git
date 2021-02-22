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
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <!-- FK pay_no 지정 -->
    <input type='hidden' name='pay_no' id='pay_no' value='1'>
    <!-- FK coupon_check 지정 -->
    <input type='hidden' name='coupon_check' id='coupon_check' value='N'>
    
    <div class="form-group">   
      <div class="col-md-12">
        <label>쿠폰 금액: </label>
        <input type='text' class="form-control" id='coupon_num' name='coupon_num' value='' placeholder="쿠폰 금액" required="required" style='width: 30%;'>
      </div>
    </div>
    
    <div class="form-group">   
      <div class="col-md-12">
        <label>쿠폰 사용 기간: </label>
        <input type='text' class="form-control" id='coupon_until_rdate' name='coupon_until_rdate' value='' placeholder="2021-02-28" required="required" style='width: 30%;'>
      </div>
    </div>
    
      <div class="bottom_menu" style="padding-right: 10%;">
        <button type="submit" class="btn btn-primary">등록</button>
        <button type='button' onclick="location.href='./list.do'" class="btn btn-primary">취소</button>
      </div>
    
     <div style='clear: both;'></div>
    
  </FORM>
 
</body>
 
</html>
