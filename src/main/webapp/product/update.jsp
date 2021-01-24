<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  // window.onload=function(){
  //  CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  // };

  $(function() {
    CKEDITOR.replace('product');  // <TEXTAREA>태그 id 값
  });
</script> 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>
    카테고리 이름
  </DIV>

  <ASIDE class="aside_left">
    <A href=''>카테고리 그룹</A> > 
    <A href=''>카테고리</A> > 수정
  </ASIDE>
  <ASIDE class="aside_right">
    <A href=''>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
      <!-- FK memberno 지정 -->
      <input type='hidden' name='member_no' id='member_no' value='1'>
      <!-- FK categrpno 지정 -->
      <input type='hidden' name='productgrp_no' id='productgrp_no' value='${param.productgrp_no }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      
      <input type='hidden' name='product_no' id='product_no' value='${productVO.product_no }'>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='product_name' value="${productVO.product_name }" 
                    placeholder="제목" required="required" style='width: 80%;' autofocus="autofocus">
        </div>
      </div>   
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='product_brand' value='${productVO.product_brand }' 
                    placeholder="브랜드" required="required" style='width: 80%;' autofocus="autofocus">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='product_origin' value='${productVO.product_origin }' 
                    placeholder="원산지" required="required" style='width: 80%;' autofocus="autofocus">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='product_frequency' value='${productVO.product_frequency }' 
                    placeholder="도수" required="required" style='width: 80%;' autofocus="autofocus">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <textarea class="form-control" name='product_description' id='product_description' rows='10' placeholder="내용">${productVO.product_description }</textarea>
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='product_cost' value='${productVO.product_cost }' 
                    placeholder="가격" required="required" style='width: 80%;' autofocus="autofocus">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='product_ml' value='${productVO.product_ml }' 
                    placeholder="용량" required="required" style='width: 80%;' autofocus="autofocus">
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='product_word'  value='${productVO.product_word }' placeholder="검색어" style='width: 90%;'>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='product_passwd'  value='' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>
      
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">수정</button>
        <button type="button" 
                    onclick="location.href='./list.do?productgrp_no=${param.productgrp_no}'" 
                    class="btn btn-info">취소[목록]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>

