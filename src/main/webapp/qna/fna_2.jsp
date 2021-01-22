<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
Thread.sleep(1000); // 1초
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주 리뷰 사이트</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
  <style type="text/css">
  /* **************** */
  /* join 태그 관련 */
  /* *************** */
   
   .join {
    width: 90%; 
    margin: 5px auto; 
  }
  </style> 
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() {
    $('#con_inner1').hide();
    tit_a1();
    $('#btn_close1').on('click', inner1_close);
    
    $('#con_inner2').hide();
    tit_a2();
    $('#btn_close2').on('click', inner2_close);
    
    $('#con_inner3').hide();
    tit_a3();
    $('#btn_close3').on('click', inner3_close);
    
    $('#con_inner4').hide();
    tit_a4();
    $('#btn_close4').on('click', inner4_close);
  });

  function tit_a1(){
    var div1 = document.getElementById("tit_q1");
    div1.addEventListener('click', function (event) {
      $('#con_inner1').show();
    });
  }
  function inner1_close(){
    $('#con_inner1').hide();
  }

  function tit_a2(){
    var div2 = document.getElementById("tit_q2");
    div2.addEventListener('click', function (event) {
      $('#con_inner2').show();
    });
  }
  function inner2_close(){
    $('#con_inner2').hide();
  }

  function tit_a3(){
    var div3 = document.getElementById("tit_q3");
    div3.addEventListener('click', function (event) {
      $('#con_inner3').show();
    });
  }
  function inner3_close(){
    $('#con_inner3').hide();
  }

  function tit_a4(){
    var div4 = document.getElementById("tit_q4");
    div4.addEventListener('click', function (event) {
      $('#con_inner4').show();
    });
  }
  function inner4_close(){
    $('#con_inner4').hide();
  }
  
  </script>
</head>
 
<body>

  <div class="join" id="join">
    <h3>FAQ - 전통주 상품</h3>
    <br>
  
    <div class="tit_q" id="tit_q1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png">전통주는 어디에서 등록할 수 있나요?
      </div>
    </div>
  
    <div class="con_inner1" id="con_inner1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a1"><IMG src="./images/A.png">
          전통주 등록은 양조장 및 양조인만 등록이 가능합니다.<br>
        </div>           
        <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close1" id="btn_close1">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 전통주2.
      </div>
    </div>
  
    <div class="con_inner2" id="con_inner2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><IMG src="./images/A.png">
          <p>전통주2 답변</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close2" id="btn_close2">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 전통주3?
      </div>
    </div>
  
    <div class="con_inner3" id="con_inner3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><IMG src="./images/A.png">
          <p>전통주3 답변</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close3" id="btn_close3">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 전통주 4??
      </div>
    </div>
  
    <div class="con_inner4" id="con_inner4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><IMG src="./images/A.png">
          <p>전통주4 답변</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close4" id="btn_close4">닫기</button>
        </div>
      </div>
    </div><br>
  
  </div>

</body>

</html>
