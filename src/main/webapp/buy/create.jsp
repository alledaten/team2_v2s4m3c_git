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
    <A href="javascript:location.reload();"> 전통주 목록 ></A>
    <A href="./list.do"> 전통주 주문 > </A>
    주문 등록
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <!-- FK communuity_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
    <!-- FK member_no 지정 -->
    <input type='hidden' name='product_no' id='product_no' value='1'>

    <input type='hidden' name='order_check' id='order_check' value='주문 접수'>
      
      <DIV style="width: 50%; float: left; ">
        <IMG src="./images/jangsu01.jpg" style="width: 50%;">
        
        <ul>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA; width: 80%;'>
            <span>리뷰내용: 무난무난</span>
          </li>
          <li class="li_none">
            <DIV>평균 평점: 4.2 점</DIV>
          </li>
          <li class="li_none">
            <DIV>추천수: 10</DIV>
          </li>
        </ul>
        
      </DIV> 
      
      <DIV style="width: 45%; float: left; margin-right: 10px;">
        <ul>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA; width: 80%;'>
            <span style='text-align: left;'>전통주 이름: 장수 막걸리</span>
          </li>
          <li class="li_none">
            <DIV>종류: 탁주</DIV>
          </li>
          <li class="li_none">
            <DIV>원산지: 서울</DIV>
          </li>
          <li class="li_none">
            <DIV>용량: 750ml</DIV>
          </li>
          <li class="li_none">
            <DIV>도수: 5%</DIV>
          </li>
          <li class="li_none">
            <div class="form-group">   
              <div class="col-md-12">
                <label>주문 수량: </label>
                <input type='number' class="form-control" name='pay_count' min='0' max='100' step='1' value='1' style='width: 20%;' > 
            </div>
            </div>  
          </li>
        </ul>
        </div>
        
    
    <div style='clear: both;'></div>

    
      <div class="content_bottom_menu" style="padding-right: 20%;">
        <button type="submit" class="btn btn-primary">주문</button>
        <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">주문 취소</button>
      </div>
    
     <div style='clear: both;'></div>
    
  </FORM>
 
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
