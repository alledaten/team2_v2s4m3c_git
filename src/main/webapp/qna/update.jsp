<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
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
  // window.onload=function(){
  //  CKEDITOR.replace('qna_content');  // <TEXTAREA>태그 id 값
  // };

  $(function() {
    CKEDITOR.replace('qna_content');  // <TEXTAREA>태그 id 값
  });
</script>

<script>
  $(function() {
    $('#modal_pop').on('click', modal_pop);  

    
  });

  function modal_pop() {
    alert("첨부파일 확인.");   
    location.href='./img_update.do?qna_no=${qna_no}';    
   $('#modal_title').html('첨부파일 확인'); // 제목 
   $('#modal_content').html(); // 내용
   $('#modal_panel').modal();            // 다이얼로그 출력
     
  }
  
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <DIV class="title_line">
    커뮤니티 > Q&A 질문 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    <A href="./list.do"> Q&A > </A>
    질문 수정
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
      <!-- FK communuity_no 지정 -->
      <input type="hidden" name="communuity_no" id='communuity_no' value="4">
      <!-- FK member_no 지정 -->
      <input type='hidden' name='member_no' id='member_no' value='1'>
      
      <input type='hidden' name='qna_no' id='qna_no' value='${qnaVO.qna_no }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
          
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control" name='qna_title' value='${qnaVO.qna_title }' placeholder="제목" required="required" style='width: 80%;'>
        </div>
      </div>   
          
      <div class="form-group">   
        <div class="col-md-12">
          <pre><textarea class="form-control" name='qna_content' id='qna_content' rows='10' placeholder="질문 내용">${qnaVO.qna_content }</textarea></pre>
        </div>
      </div>
          
      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='qna_passwd'  value='${qnaVO.qna_passwd }' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>    
      
    <div class="form-group">   
      <div class="col-md-12">
        <label>비밀글 설정:
        <input type='checkbox' class="form-control" name='qna_check' id='qna_check' value='Y' style='width: 50%;'></label>
      </div>
    </div>  
      
<%--   <!-- Modal 알림창 시작 -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
            <div class="form-group">   
              <div class="col-md-12">
                <c:choose>
                  <c:when test="${qnaVO.file1.trim().length() > 0 }">
                    <span class='menu_divide' > | </span> 
                    <A href='./img_update.do?qna_no=${qnaVO.qna_no}'>이미지 변경/삭제</A>     
                  </c:when>
                  <c:otherwise>
                    <span class='menu_divide' > | </span> 
                    <A href='./img_create.do?qna_no=${qnaVO.qna_no}'>이미지 등록</A>     
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
        </div>
        <div class="modal-footer">
          <button type="button" id='modal_file' class="btn btn-default" data-dismiss="modal">확인</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">취소 [닫기]</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료 --> --%>
    
<%--      <!-- Modal 알림창 시작 -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
   <DIV style='width: 100%;'>
    <H4>이미지 삭제</H4>

    이미지가 존재하는 경우 이미지를 출력하고 삭제 버튼 표시
    <c:set var="file1" value="${qnaVO.file1 }" />
    <c:if test="${file1.endsWith('jpg') || file1.endsWith('png') || file1.endsWith('gif')}">
      <FORM name='frm' method='POST' action='./img_delete.do' class="form-horizontal">
    <!-- FK qna_no 지정 -->
    <input type="hidden" name="qna_no" id='qna_no' value="${qnaVO.qna_no }">
    <!-- FK member_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>


    <IMG src="./storage/main_images/${file1 }" style="width: 50%; margin-bottom: 10px;">
        
        <div class="form-group">   
          <div class="col-md-12">
            <input type='password' class="form-control" name='qna_passwd'  value='${qnaVO.qna_passwd}' placeholder="패스워드" style='width: 20%;'>
          </div>
        </div>
        
        <button type="submit" class="btn btn-info">이미지 삭제</button>
        <button type="button" 
                    onclick="location.href='./read.do?qna_no=${param.qna_no}'" 
                    class="btn btn-info">취소[조회]</button>
      </FORM> 
    </c:if> 
    
    <HR>
    <H4>새로운 이미지 등록</H4>
    이미지가 존재하는 경우 새로운 이미지 등록 폼 출력
    <FORM name='frm' method='POST' action='./img_update.do' class="form-horizontal"
                enctype="multipart/form-data">
               
    <!-- FK qna_no 지정 -->
    <input type="hidden" name="qna_no" id='qna_no' value="${qnaVO.qna_no }">
    <!-- FK member_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
      
      
      <div class="form-group">   
        <div class="col-md-12">
          실제 컬럼명: file1, Spring File 객체 대응: file1MF
          <input type='file' class="form-control" name='file1MF' id='file1MF' 
                    value='' placeholder="파일 선택">
        </div>
      </div>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='password' class="form-control" name='qna_passwd'  value='${qnaVO.qna_passwd}' placeholder="패스워드" style='width: 20%;'>
        </div>
      </div>
      
      <button type="submit" class="btn btn-info">새로운 이미지 등록</button>
      <button type="button" 
                  onclick="location.href='./read.do?qna_no=${param.qna_no}'" 
                  class="btn btn-info">취소[조회]</button>
    </FORM>
  </DIV>
        </div>
        <div class="modal-footer">
          <button type="button" id='modal_file' class="btn btn-default" data-dismiss="modal">확인</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">취소 [닫기]</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료 -->  --%>
     
      <button type="button" id='modal_pop' class="btn btn-default" data-dismiss="modal">첨부파일 확인</button>
       
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">수정</button>
        <button type="button" 
                     onclick="location.href='./list.do?qna_no=${param.qna_no}&qna_word=${param.qna_word }&nowPage=${param.nowPage}'" 
                     class="btn btn-info">취소[목록]</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
