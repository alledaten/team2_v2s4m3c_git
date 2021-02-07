<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/javascript">
  $(function() {
    CKEDITOR.replace('qna_content');  // <TEXTAREA>태그 id 값
  });
</script> 

<script type="text/javascript">
  $(function() {
    $('#q_check').on('click', show);    // 질문 내용 확인
    
  });

  function show() {
    $('#q_read').show();
  }
  
 </script>
</head> 
 
 <style type="text/css">
  /* ****************** */
  /* Q&A 태그 관련 */
  /* ****************** */
  
  table.qna {
    border-collapse: collapse;
    padding-left: 10%;
    text-align: left;
    line-height: 1.5; 
  }
  
  table.qna thead th {
    padding: 10px;
    font-size: 20px; 
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
  }
  table.qna tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #f3f6f7;
  }
  table.qna td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
  }
 
  table.qna_read {
    border-collapse: collapse;
    width: 95%;
    text-align: left;
    line-height: 1.5;
    border-left: 1px solid #ccc;
    margin: 10px auto;
  }
  
  table.qna_read thead th {
    padding: 10px;
    font-weight: bold;
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-bottom: 2px solid #c00;
    background: #dcdcd1;
  }
  table.qna_read tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    background: #ececec;
  }
  table.qna_read td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
  }
  
  .qna_bottom_menu {
    clear: both;
    padding-top: 20px;
    padding-right: 20px;
    text-align: right;
    width: 100%;
    background-color: #ffffff;
  }
  
  .product_read {
    width: 40%;
    float: right;
    margin: 10px; 
    border-top: none;
    border-right: none;
    border-bottom: none;
    border-left: none;
    padding: 10px;
  }
</style>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

   <DIV class="title_line">
    커뮤니티 > Q&A 질문 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    <A href="./list.do"> Q&A > </A>
    답변 등록
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./reply.do' class="form-horizontal"
                enctype="multipart/form-data">
               
      <!-- FK memberno 지정 -->
      <input type='hidden' name='member_no' id='member_no' value='1'>
      <!-- FK categrpno 지정 -->
      <input type='hidden' name='community_no' id='community_no' value='4'>
      <%-- 댓글을 붙일 부모글 번호 --%>
      <input type='hidden' name='qna_no' id='qna_no' value='${param.qna_no }'>
      
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      
      <div style="padding-left: 10%;">
      <button type="button" id='q_check' class="btn btn-default" data-dismiss="modal">질문 내용 확인</button>
      </div>

      <div name='q_read' id='q_read' style='display: none; padding-left: 10%; text-align: left; width: 80%;'>
      <table class="qna_read">
      <thead>
        <tr>
          <th scope="cols">질문 제목: ${qnaVO.qna_title}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
           <td>질문 내용:
                   ${qnaVO.qna_content }
           </td>
        </tr>
      </tbody>
    </table>
     </div> 
     <br>
     <div class="form-group" style="padding-left: 10%;">   
      <div class="col-md-12">
        <input type='text' class="form-control" name='qna_title' value='답변 테스트' placeholder="제목" required="required" style='width: 80%;'>
      </div>
    </div>   
      
    <div class="form-group" style="padding-left: 10%;">   
      <div class="col-md-12">
        <textarea class="form-control" name='qna_content' id='qna_content' rows='10' placeholder="답변 내용" style='width: 80%;'>답변 내용</textarea>
      </div>
    </div>
      
    <div class="form-group" style="padding-left: 10%;">   
      <div class="col-md-12">
        <input type='hidden' class="form-control" name='qna_passwd'  value='${qna_passwd }' placeholder="패스워드" style='width: 20%;'>
      </div>
    </div>    
      
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">답변 등록</button>
        <button type="button" 
                    onclick="history.back()" 
                    class="btn btn-info">취소</button>
      </DIV>
       
    </FORM>
  </DIV>

  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>