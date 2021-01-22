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
    <h3>FAQ - 회원 가입 / 정보</h3>
    <br>
  
    <div class="tit_q" id="tit_q1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png">회원정보는 어떻게 변경 할 수 있습니까?
      </div>
    </div>
  
    <div class="con_inner1" id="con_inner1">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a1"><p><IMG src="./images/A.png">
          고객님의 비밀번호 및 회원정보 변경은 로그인 후 마이페이지 회원정보 변경 에서 변경이 가능합니다.</p>
        </div>           
        <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close1" id="btn_close1">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q2" >
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 아이디 혹은 비밀번호를 잊어버렸습니다.
      </div>
    </div>
  
    <div class="con_inner2" id="con_inner2">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png"> 사이트 로그인 화면에서 [ 비밀번호 찾기 ] 또는 [ 아이디 찾기 ] 를 선택해 주십시오.</p>
          <p>기존 회원 가입 시 등록된 회원 정보로(등록된 이메일 주소) 임시 비밀번호(또는 아이디)를 발급 해드립니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close2" id="btn_close2">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 개인정보에 대한 보안은 안전한가요?
      </div>
    </div>
  
    <div class="con_inner3" id="con_inner3">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png"> 개인정보 보호를 위하여 정책적/시스템적인 보안에 최선의 노력을 다하고 있습니다.</p>
          <p>회원님의 정보보안을 위해 최소한의 개인정보를 회원가입 요건으로 하고 있으며,
          회원님의 소중한 개인정보는 ‘개인정보보호정책’에 의거하여 정보유출에 관련된 피해가 없도록 안전하게 보호되고 있습니다.</p> 
          <p>저희 사이트 관리 이외로는 절대 사용되지 않습니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close3" id="btn_close3">닫기</button>
        </div>
      </div>
    </div><br>
  
    <div class="tit_q" id="tit_q4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <IMG src="./images/Q.png"> 회원 탈퇴는 어떻게 하나요??
      </div>
    </div>
  
    <div class="con_inner4" id="con_inner4">
      <DIV style='height: auto; width: 100%; border:1px solid; vertical-align: middle;'>
        <div class="tit_a"><p><IMG src="./images/A.png"> 로그인 후 사이트 상단의 [정보수정] 메뉴로 들어가시면 회원 탈퇴하실 수 있습니다.</p>
          <p>회원 탈퇴 후 동일 정보로는 한달간 재가입이 불가능하며 적립된 마일리지나 포인트, 쿠폰도 함께 삭제됩니다.</p>
          <p>단, 사이트에서 직접 게시한 리뷰들을 등록하셨다면 별도의 삭제요청을 해주셔야 삭제가 가능합니다.</p>
        </div>           
       <div class="bottom_menu" style="padding-right: 0%;">
          <button type="button" class="btn_close4" id="btn_close4">닫기</button>
        </div>
      </div>
    </div><br>
  
  </div>


</body>

</html>
