<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>상품 종류 수정폼</title>
 
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
 
  <DIV class='title_line'>상품 종류 > ${review_CategrpVO.review_categrp_name } 수정</DIV>
    
    <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
      <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
       <input type='hidden' name='review_categrp_no' id='review_categrp_no' value="${review_CategrpVO.review_categrp_no }">
       <input type='hidden' name='review_cate_no' id='review_cate_no' value="${review_CategrpVO.review_cate_no }">
  
       <div class="form-group">
           <label class="control-label col-md-3">상품 종류</label>
           <div class="col-md-9">
              <input type='text' name='review_categrp_name' value='${review_CategrpVO.review_categrp_name }' required="required" 
                        autofocus="autofocus" class="form-control" style='width: 25%;'>
           </div>
       </div>
       
       <div class="form-group">
          <label class="control-label col-md-3">순서</label>
          <div class="col-md-9">
             <input type='number' name='review_categrp_seqno' value='${review_CategrpVO.review_categrp_seqno }' required="required" 
                       autofocus="autofocus" class="form-control" style='width: 5%;'
                       min="1" max="9999" step="1">
          </div>
       </div>
       
        <div class="content_bottom_menu" style="padding-right: 20%;">
           <button type="submit" class="btn btn-primary">수정</button>
           <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">목록</button>
        </div>
      </form>
    </div>
  
  
<jsp:include page="/menu/bottom.jsp" />
</body>
</html> 
 
 
 