<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class="title_line">
    전통주 주문
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 전통주 목록 ></A>
    <A href="./list.do"> 전통주 주문 > </A>
    주문 수정
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
    <!-- FK communuity_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
    <!-- FK member_no 지정 -->
    <input type='hidden' name='product_no' id='product_no' value='1'>
      
     <input type='hidden' name='buy_no' id='buy_no' value='${buyVO.buy_no }'>
          
    <div class="form-group">   
      <div class="col-md-12">
        <label>주문 수량: </label>
        <input type='number' class="form-control" name='pay_count' min='0' max='100' step='1' value='${buyVO.pay_count }' style='width: 20%;' > 
    </div>
    </div>  
      
      <div>    
      배송 정보 수정
      </div>
      
      <div>
      결제 정보 수정
      </div>
       
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">수정</button>
        <button type="button" 
                     onclick="location.href='./list.do?buy_no=${param.buy_no}'" 
                     class="btn btn-info">취소[목록]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
