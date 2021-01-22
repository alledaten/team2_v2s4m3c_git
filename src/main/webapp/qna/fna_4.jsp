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
    <h3>FAQ - 배송 </h3>
    <br>
  
    <div class="tit_q" id="tit_q1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png">배송조회는 어디에서 할 수 있나요?
      </div>
    </div>
  
    <div class="con_inner1" id="con_inner1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a1"> <p><IMG src="./images/A.png"> 홈페이지 로그인 후 오른쪽 상단 [ 마이페이지  >  주문/배송관리  > 주문내역조회 ]에서 확인 가능합니다.</p>
        </div>           
        <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close1" id="btn_close1">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 배송 기간이 얼마나 걸리나요?
      </div>
    </div>
  
    <div class="con_inner2" id="con_inner2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png">고객님께서 주문하신 상품을 실제 받으시는 날은 "예상출고일+배송일"입니다.</p>
          <p> '예상출고일'이란 근무일 기준으로 도서가 준비되는 시간만을 안내하는 것이며,
                  배송시간은 예상출고일 외 택배를 통해 고객님께 실제 배달되는 기간을 말합니다. </p>

            <p>출고예정일은 상품에 따라 준비기간이 다르며 배송 시간은 지역에 따라 약간씩 다르나 보통 1~3일정도 소요됩니다.
                   (도서산간지역은 최대 7일 소요)</p>

             <p>* 예상출고일은 영업일 기준으로 산정되며, 일요일과 공휴일 및 기타 휴무일에는 배송되지 않습니다.
                      (우체국 배송은 토요일 휴무로 배송 불가함)</p>
              <p>* 주문한 상품의 당사에 재고가 없을 때는 거래처로 다시 주문 요청한 후 출고되므로 3∼7일내외 정도 더 소요됩니다.</p>
              <p>* 천재지변 등의 불가항력적 사유로 인한 배송 지연은 그 해당기간 동안의 배송소요 기간에서 제외됩니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close2" id="btn_close2">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 배송지를 변경하고 싶어요.
      </div>
    </div>
  
    <div class="con_inner3" id="con_inner3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png">배송지변경은 주문하신 상품이 발송되기 전에만 가능합니다.</p>
          <p>고객센터(1234-5678)혹은 1:1문의에 변경하실 주소를 남겨주시면 확인하여 변경 가능여부 혹은 변경 도와드리도록 하겠습니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close3" id="btn_close3">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 무료 배송 안내.
      </div>
    </div>
  
    <div class="con_inner4" id="con_inner4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png">무료 배송은 최종 결제금액이 10만원 이상일 때 서비스 해드리고 있습니다.</p>
          <p>- 결제 금액이 10만원 미만의 금액은 5000원의 배송료가 부과됩니다.</p>
          <p>- 택배사는 빠르고 안전한 우체국 택배를 이용합니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close4" id="btn_close4">닫기</button>
        </div>
      </div>
    </div><br>
  
  </div>

</body>

</html>
