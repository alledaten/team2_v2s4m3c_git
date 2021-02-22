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
  
  <div class='menu_line'></div>
 
  <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
    <!-- FK member_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
    <!-- FK pay_no 지정 -->
    <input type='hidden' name='pay_no' id='pay_no' value='1'>
    <!-- FK point_no 지정 -->
    <input type='hidden' name='point_no' id='point_no' value='${pointVO.point_no }'>

    
    <div class="form-group">   
      <div class="col-md-12">
        <label>포인트: </label>
        <input type='text' class="form-control" id='point_num' name='point_num' value='${pointVO.point_num }' placeholder="포인트 등록" required="required" style='width: 30%;'>
      </div>
    </div>
    
    
      <div class="bottom_menu" style="padding-right: 20%;">
        <button type="submit" class="btn btn-primary">포인트 수정</button>
        <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">취소</button>
      </div>
    
     <div style='clear: both;'></div>
    
  </FORM>
 
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
