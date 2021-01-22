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
    <h3>FAQ - 기타</h3>
    <br>
  
    <div class="tit_q" id="tit_q1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 신용카드 결제시 오류가 발생할 경우
      </div>
    </div>
  
    <div class="con_inner1" id="con_inner1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a1"><p><IMG src="./images/A.png">▶ 승인처리 중 에러가 발생하였습니다라고 안내창이 뜨는 경우</p>
          <p>고객님의 카드번호 혹은 유효기간입력이 잘못되었거나 혹은 카드에 문제가 발생할 경우이니 
                 고객님께서 발급받으신 카드사에 문의부탁드립니다.</p>
           <p> ☎ 주요 카드회사 고객센터
                    현대카드: 1577-6000
                    국민카드: 1588-1688
                    신한카드: 1544-7000
                    삼성카드: 1588-8700
                    롯데카드: 1588-8100
                    우리카드: 1588-9955
                    외환카드: 1588-3200
                    농협카드: 1588-1600
                    비씨카드: 1588-4000
                    KB비씨카드: 1588-9999 </p>
                 
        </div>           
        <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close1" id="btn_close1">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 해외에서도 결제 할 수 있나요?
      </div>
    </div>
  
    <div class="con_inner2" id="con_inner2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png">아직 해외배송서비스는 진행중이지 않습니다.</p>
          <p>추후 해외배송서비스도 준비중에 있으니 양해 부탁드리겠습니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close2" id="btn_close2">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 쿠폰 사용 및 등록 안내.
      </div>
    </div>
  
    <div class="con_inner3" id="con_inner3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png">쿠폰 발행 및 정책은 시스템 구현중에 있습니다.</p>
          <p>쿠폰 발급 시스템이 적용되면 별도로 공지드리겠습니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close3" id="btn_close3">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 기타 4??
      </div>
    </div>
  
    <div class="con_inner4" id="con_inner4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><IMG src="./images/A.png">
          <p>기타4 답변</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close4" id="btn_close4">닫기</button>
        </div>
      </div>
    </div><br>
  
  </div>

</body>

</html>
