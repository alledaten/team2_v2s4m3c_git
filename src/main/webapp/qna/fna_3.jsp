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

    $('#con_inner5').hide();
    tit_a5();
    $('#btn_close5').on('click', inner5_close);
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

  function tit_a5(){
    var div5 = document.getElementById("tit_q5");
    div5.addEventListener('click', function (event) {
      $('#con_inner5').show();
    });
  }
  function inner5_close(){
    $('#con_inner5').hide();
  }
  
  </script>
</head>
 
<body>

  <div class="join" id="join">
    <h3>FAQ - 주문 / 결제 / 취소 </h3>
    <br>
  
    <div class="tit_q" id="tit_q1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png">결제 취소 / 주문 취소는 어떻게 하나요?
      </div>
    </div>
  
    <div class="con_inner1" id="con_inner1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a1"><p><IMG src="./images/A.png">주문 취소를 원하실 경우, 배송 보내기 전까지 고객센터(1234-5678)로 연락주시기 바랍니다. </p>
          <p>주문 취소를 했을 시 주문 시 사용하셨던 결제 수단에 따라 환불처리가 됩니다. </p>
                 
           <p>- 카드결제/휴대폰결제/계좌이체 : 주문취소 시에 환불 일정은 3~7일정도 소요될 수 있습니다. </p>
        </div>           
        <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close1" id="btn_close1">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 결제 방법은 어떻게 되나요?
      </div>
    </div>
  
    <div class="con_inner2" id="con_inner2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png">신용카드, 실시간 계좌이체, 가상계좌입금, 휴대폰 결제의 방법이 있습니다.</p>
          <p>KCP 결제 시스템을 이용중 입니다.</p>
          <p>실시간 계좌이체는 이체 수수료가 없고, 즉시 결제 확인이 가능합니다.</p>
          <p>반면, 가상계좌 입금은 전통주 리뷰 사이트와 무관하게 고객님에 따라 이체 수수료가 발생 할 수도 있습니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close2" id="btn_close2">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 결제 오류시 어떻게 해야 되나요?
      </div>
    </div>
  
    <div class="con_inner3" id="con_inner3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png"> 결제가 되지 않는다거나 중복 결제 하셨을 경우 고객센터(1234-5678)로 연락 부탁 드립니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close3" id="btn_close3">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 가상계좌입금 결제인데 입금주(예금주)가 달라도 상관없나요?
      </div>
    </div>
  
    <div class="con_inner4" id="con_inner4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png"> 주문자명과 입금자명을 일치하여 입금처리 해주시는 것이 가장 정확합니다. </p>
          <p>입금자명이 다를 경우 입금처리가 늦어질 수도 있사오니 입금자명을 다르게 기입하여 입금하셨을 경우에는 고객센터(1234-5678) 혹은 문의글로 말씀해주시기 바랍니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close4" id="btn_close4">닫기</button>
        </div>
      </div>
    </div><br>
  
      <div class="tit_q" id="tit_q5">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 비회원도 주문 가능한가요?
      </div>
    </div>
  
   <div class="con_inner5" id="con_inner5">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png"> 전통주 리뷰 사이트는 회원만 주문이 가능합니다.</p>
          <p>미성년자에게는 술을 판매할 수 없기 때문에 회원가입은 필수입니다.</p>
          <p>회원가입 후 다양한 서비스와 상품을 경험해 보세요.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close5" id="btn_close5">닫기</button>
        </div>
      </div>
    </div><br>
  
  </div>

</body>

</html>
