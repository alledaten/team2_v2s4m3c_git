<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰 첨부파일 등록</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class='review_title_line'>
    <strong class ="review_title">첨부파일 등록</strong>
  </DIV>

  <DIV style="width: 80%; margin: 10px auto;">
    <ASIDE class="aside_right">
      <A href='./list_by_review_no.do?review_no=${param.review_no }'>첨부파일 목록</A>
    </ASIDE> 
  </DIV>

  <DIV style='width: 80%; margin: 10px auto;'>
    <FORM name='frm' method='POST' action='./create.do' 
                enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='product_no' id='product_no' value="${param.product_no }">
      <input type='hidden' name='review_no' id='review_no' value="${param.review_no }">
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='file' class="form-control" name='review_attachfile_rnamesMF'  
                     value='' placeholder="파일 선택" multiple="multiple">
        </div>
      </div>

      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">파일 전송</button>
        <button type="button" 
                    onclick="location.href='../review/read.do?review_no=${param.review_no}'" 
                    class="btn btn-info" >취소[조회]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>


