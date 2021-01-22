<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰 등록</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">


  $(function() {
    CKEDITOR.replace('review_content');  // <TEXTAREA>태그 id 값
  });
 
</script>

</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class="title_line">
    ${review_CateVO.review_cate_name}
  </DIV>
  
  <ASIDE class="aside_left">
    <A href="../review_categrp/list.do">상품 종류</A> > 
    <A href="../review_cate/list.do?review_categrp_no=${review_CategrpVO.review_categrp_no }">${review_CategrpVO.review_categrp_name }</A> > 
    <A href="../review/list.do?review_cate_no=${param.review_cate_no }&review_word=${param.review_word }&nowPage=${param.nowPage}">${review_CateVO.review_cate_name}</A>
    > 등록
  </ASIDE>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do' class="form-horizontal"
                enctype="multipart/form-data" >
               
      <!-- FK memberno 지정 -->
      <input type='hidden' name='member_no' id='member_no' value=1>
      <!-- FK categrpno 지정 -->
      <input type='hidden' name='review_cate_no' id='review_cate_no' value='${param.review_cate_no}' > 
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='review_title' placeholder="제목을 입력해주세요." required="required" style='width: 80%;'>
        </div>
      </div>   
      
      <div class="form-group">   
        <div class="col-md-12">
          <textarea class="form-control" name='review_content' id='review_content' rows='10' required="required" placeholder="내용"></textarea>
        </div>
      </div>

      <div class="form-group">   
        <div class="col-md-12">
          <%-- 실제 컬럼명: file1, Spring File 객체 대응: file1MF --%>
          <input type='file' class="form-control" name='review_fileMF' id='review_fileMF' 
                    value='' placeholder="파일 선택">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='number' class="form-control" name='review_score'  value='' min = '0' max = '5'  placeholder="평점" style='width: 20%;'>
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='review_word'  value='전통주,술,리뷰,평점' placeholder="검색어" style='width: 90%;'>
        </div>
      </div>
      
      

      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='review_passwd'  value='1234' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>
      
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">등록</button> 
        <button type="button" 
                    onclick="location.href='./list.do?review_cate_no=${param.review_cate_no}&review_categrp_no=${review_CategrpVO.review_categrp_no }'" 
                    class="btn btn-info">취소[목록]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
  