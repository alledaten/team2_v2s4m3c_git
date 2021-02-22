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
 
  <style type="text/css">
  /* **************** */
  /* 배송 태그 관련 */
  /* *************** */

div.dev_label{
 background: #ffd700;
 padding-bottom: 20px;
 width: 80%;
 margin: 10px auto;
}
form{
 border-collapse: collapse;
 margin: 20px 30px;
}
form h1{
 color: #fff;
 background:#003458;
 border-bottom: 2px solid #000;
 text-align:center;
 padding-top: 10px;
 padding-bottom: 10px;
 margin: 5px auto;
  width: 30%;
}

  /* ****************** */
  /* pay 태그 관련 */
  /* ****************** */
  
  table.pay_table {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5; 
    margin: 10px auto;
    width: 80%;
    border-left: 3px solid #036;
    border-right: 3px solid #036;
    border-bottom: 3px solid #036;
  }
  
  table.pay_table thead th {
    padding: 10px;
    font-size: 20px; 
    font-weight: bold;
    vertical-align: center;
    text-align: center;
    color: #369;
    border-left: 3px solid #ffffff;
    border-right: 3px solid #ffffff;
    border-bottom: 3px solid #036;
  }
  table.pay_table tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: center;
    text-align: left;
    border-bottom: 1px solid #ccc;
    background: #f3f6f7;
  }
  table.pay_table td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
  }
 
  table.pay_read {
    border-collapse: collapse;
    width: 95%;
    text-align: left;
    line-height: 1.5;
    border-left: 1px solid #ccc;
    margin: 10px auto;
  }
  
  table.pay_read thead th {
    padding: 10px;
    font-weight: bold;
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-bottom: 2px solid #c00;
    background: #dcdcd1;
  }
  table.pay_table_read tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    background: #008080;
  }
  table.pay_table_read td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
  }
  
  .pay_table_bottom_menu {
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
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function(){
    $('#send').on('click', submit);    // form 2개 따로 등록하기 위한 ajax

    // *********************  배송 부분 시작 ***************************
    $('#btn_DaumPostcode').on('click', DaumPostcode); // 다음 우편 번호
    $('#modal_address').on('click', my_address); // 나의 배송 주소록 팝업
    $('#address_create').on('click', create); // 나의 배송 주소록 등록
        
    // *********************  배송 부분 종료 ***************************
    
   // *********************  결제 부분 시작 ***************************
    $('input.num_only').on('keyup', num); // 결제 정보 계산식
    // $('#coupon_see').on('click', coupon); // 쿠폰 조회
    // $('#point_see').on('click', point); // 포인트 조회

   // *********************  결제 부분 종료 *************************** 
    
  });


  // 배송 form, 결제 form 각각 값 전달  
  function submit() {
    var params = $('#frm_dev, #frm_pay').serialize();

    alert('params:' + params);

    // 배송 정보 등록 처리
    $.ajax({ 
      url: './create.do',
      type: 'post',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
                 
       if (rdata.cnt > 0) { // dev 등록 성공
         alert("배송정보 등록에 성공했습니다.");

          // 결제 정보 등록 처리
          $.ajax({
           url: '../pay/create.do',
           type: 'post',  // post
           cache: false, // 응답 결과 임시 저장 취소
           async: true,  // true: 비동기 통신
           dataType: 'json', // 응답 형식: json, html, xml...
           data: params,      // 데이터
           success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
                      
            if (rdata.cnt > 0) { // pay 등록 성공
              alert("결제 정보 등록에 성공했습니다.");
              
              location.href="../buy/list.do";
              
             } else {  // pay 등록 실패
               alert("결제 정보 등록에 실패했습니다.");
                
             }
           },
           // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
           error: function(request, status, error) { // callback 함수
             var msg = 'ERROR<br><br>';
             msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
             msg += '<strong>error</strong><br>'+error + '<hr>';
             console.log(msg);
           }
         });
        } else {  // dev 등록 실패
          alert("배송 정보 등록에 실패했습니다.");
           
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });
    
  }

  // *********************  배송 부분 시작 ***************************
  
  // 주소록 모달창
  function my_address() {

    $('#modal_title').html('나의 배송 주소록'); // 제목 
    $('#modal_content').html("신규등록을 원하시면 주소록 등록 버튼을 클릭해주세요."); // 내용
    $('#modal_panel').modal();            // 다이얼로그 출력

    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: '../address/list.do',
      type: 'get',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);
        
        $('#panel2').css('text-align', 'left');
        $('#panel2').html(rdata);  // 보통 DIV, SPAN등에 출력, input 태그는 ${'#rname'}.val(rdata);
        
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
  
    $('#panel2').css('text-align', 'center');
    $('#panel2').html("<img src='./images/ani04.gif' style='width: 6%;'>");
    $('#panel2').show(); // 숨겨진 태그의 출력
    
  }

  
  // 주소록 등록
  function create() { 
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: '../address/create.do',
      type: 'get',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);
        
        $('#panel').css('text-align', 'left');
        $('#panel').html(rdata);  // 보통 DIV, SPAN등에 출력, input 태그는 ${'#rname'}.val(rdata);
        
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
  
    $('#panel').css('text-align', 'center');
    $('#panel').html("<img src='./images/ani04.gif' style='width: 6%;'>");
    $('#panel').show(); // 숨겨진 태그의 출력
  }

  
  // *********************  배송 부분 종료 ***************************
  
  // *********************  결제 부분 시작 ***************************
  
  //결제 폼 계산식
  function num(){ 
    var cnt = $(".exam input.num_sum").length;     
    console.log(cnt);
    
    for( var i=1; i< cnt; i++){
    var sum = parseInt($(this).val() || 0 );
    sum++
    console.log(sum);
    }

      var sum1 = parseInt($("#product_cost").val() || 0 ); // input 값을 가져오며 계산하지만 값이 없을경우 0이 대입된다  뒷부분에 ( || 0 ) 없을경우 합계에 오류가 생겨 NaN 값이 떨어진다
      var sum2 = parseInt($("#pay_count").val() || 0);
      var sum3 = parseInt($("#pay_coupon").val() || 0);
      var sum4 = parseInt($("#pay_point").val() || 0);
      var sum5 = parseInt($("#dev_cost").val() || 0);


      var sum = (sum1 * sum2) - sum3 - sum4 + sum5;
      console.log(sum);
      $("#pay_total").val(sum);
  }

  // 쿠폰 조회 
  function coupon(member_no) { 
    var params = 'member_no=' + member_no;
    alert(member_no);
    // return;
    $.ajax({
      url: '../coupon/read_coupon.do',
      type: 'get',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        
        $('#panel_coupon').html(rdata.coupon_num);
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
  
  }
  
  // 포인트 조회 
  function point(member_no) { 
    var params = 'member_no=' + member_no;
    // return;
    $.ajax({
      url: '../point/read_point.do',
      type: 'get',  // get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        
        $('#panel_point').html(rdata.point_num);
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
  
  }
  
  // *********************  결제 부분 종료 ***************************
  
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class="title_line">
    전통주 주문
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 전통주 ></A>
    <A href="./list.do"> 전통주 주문 > </A>
    배송 및 결제 정보 등록
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  
  <div class='menu_line'></div>
 
   <!-- **************************** 배송 부분 시작 ************************************ -->
 
   <!-- Modal 알림창 시작(나의 배송 주소록) -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4>
          <div style="padding-left:80%;">
          <button type="button" id='address_create' name='address_create' class="btn btn-warning">주소록 등록</button></div><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
              <DIV id='panel' style='display: none; margin: 10px auto; text-align: left; width: 90%;'></DIV>
              <DIV id='panel2' style='display: show; margin: 10px auto; text-align: left; width: 90%;'></DIV>
        </div>
        <div class="modal-footer">
          <button type="button" id='modal_ad' class="btn btn-default" data-dismiss="modal">확인</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">취소 [닫기]</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료(나의 배송 주소록) -->
 
  <div class='dev_label'>
  <FORM name='frm_dev' id='frm_dev' method='POST' action='./create.do' class="form-horizontal">
    <!-- FK member_no 지정 -->
    <input type='hidden' name='member_no' id='member_no' value='1'>
    <!-- FK product_no 지정 -->
    <input type='hidden' name='product_no' id='product_no' value='1'>
    <!-- FK buy_no 지정 -->
    <input type='hidden' name='buy_no' id='buy_no' value='${param.buy_no }'>
    
    <input type='hidden' name='dev_number' id='dev_number' value='0000-0000-0000'>

    <h1>배송지 정보</h1>

     <div style="padding-left:80%;">
       <button type="button" id='modal_address' name='modal_address' class="btn btn-info">나의 배송 주소록</button>
     </div>

    <div class="form-group" style="padding-left: 50px;">   
      <div class="col-md-12">
        <label>배송 받는분: </label>
        <input type='text' class="form-control" name='dev_member' value='${devVO.dev_member }' placeholder="홍길동" required="required" style='width: 30%;'>
      </div>
    </div>
    
    <div class="form-group" style="padding-left: 50px;">   
      <div class="col-md-12">
        <label>배송 받는 분 연락처: </label>
        <input type='text' class="form-control" name='dev_phone' value='${devVO.dev_phone }'  placeholder="010-1111-2222" required="required" style='width: 40%;'>
      </div>
    </div>
    
    <label style="padding-left: 50px;">배송 받는 분 주소:</label><br>
    <div class="form-group">
      <label for="zipcode" class="col-md-2 control-label" style='font-size: 0.9em;'>우편번호</label>    
      <div class="col-md-10" >
        <input type='text' class="form-control" name='zipcode' id='zipcode' 
                   value='${devVO.zipcode }'  style='width: 30%;' placeholder="우편번호">
        <input type="button" id="btn_DaumPostcode" value="우편번호 찾기" class="btn btn-info btn-md">
      </div>
    </div>  

    <div class="form-group">
      <label for="address1" class="col-md-2 control-label" style='font-size: 0.9em;'>주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='address1' id='address1' 
                   value='${devVO.address1 }'  style='width: 80%;' placeholder="주소">
      </div>
    </div>   

    <div class="form-group">
      <label for="address2" class="col-md-2 control-label" style='font-size: 0.9em;'>상세 주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='address2' id='address2' 
                   value='${devVO.address1 }'  style='width: 80%;' placeholder="상세 주소">
      </div>
    </div>   

    <div class="form-group">
      <div class="col-md-12">

<!-- ---------- DAUM 우편번호 API 시작 ---------- -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 200px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#zipcode').val(data.zonecode); //5자리 새우편번호 사용 ★
                $('#address1').val(fullAddr);  // 주소 ★

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#address2').focus(); //  ★
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ---------- DAUM 우편번호 API 종료 ---------- -->

      </div>
    </div>
    
     <div class="form-group" style="padding-left: 50px;">   
      <div class="col-md-12">
       <label>배송 메세지: </label>
        <input type='text' class="form-control" name='dev_message' value='' placeholder="빠른 배송 부탁합니다." style='width: 60%;'>
      </div>
    </div>  
    
   </div> 
   
   <!-- **************************** 배송 부분 종료 ************************************ -->
   
   <!-- **************************** 결제 부분 시작 ************************************ -->
     
 <FORM name='frm_pay' id='frm_pay' method='POST' action='../pay/create.do' class="form-horizontal">
    <!-- FK pay_count 지정 -->
    <input type='hidden' name='pay_count' id='pay_count' value='${param.pay_count }'>
 
  <div class="pay_table_div">          
  <table class="pay_table">
    <colgroup>
      <col style="width: 20%;">
      <col style="width: 30%;">
      <col style="width: 20%;">
      <col style="width: 30%;">
    </colgroup>
    <thead>
      <tr>
        <th colspan="4" class="th_basic" style="text-align: center;"><h2>결제 정보</h2></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th colspan="4" style="background: #9555; border-right: 3px solid #036; border-bottom: 3px solid #036;">
            <div class="form-group" >   
              <div class="col-md-12">
                <label>결제 방법: </label>
              <br>
              <label style="cursor: pointer;">
                <input type="radio" id='pay_way' name='pay_way' value='무통장 입금' checked="checked"> 무통장 입금
              </label>
              <br>
              <label style="cursor: pointer;">
                <input type="radio" id='pay_way' name='pay_way' value='카드 결제'> 카드 결제
              </label>
              <br>      
              <label style="cursor: pointer;">
                <input type="radio" id='pay_way' name='pay_way' value='실시간 계좌이체'> 실시간 계좌이체
              </label>
              <br>      
              <label style="cursor: pointer;">
                <input type="radio" id='pay_way' name='pay_way' value='휴대폰 결제'> 휴대폰 결제
              </label>
              <br>      
              <label style="cursor: pointer;">
                <input type="radio" id='pay_way' name='pay_way' value='카카오 페이' > 카카오 페이
              </label>
              <br>
              <label style="cursor: pointer;">
                <input type="radio" id='pay_way' name='pay_way' value='가상 계좌' > 가상 계좌
              </label>
              <br>         
              </div>
            </div>
        </th>
      </tr>
      <tr>
        <th scope="row" style="background: #65acca;">상품 금액 </th>
        <td style="text-align: left;"><input type="text" class="form-control num_only num_comma num_sum" id="product_cost" name="product_cost" value="0" placeholder=""></td>
        <th scope="row" style="background: #65acca;">상품 수량</th>
        <td style="text-align: left;">${param.pay_count } 개<input type="hidden" class="form-control num_only num_comma num_sum" id="pay_count" name="pay_count" value='${param.pay_count }' placeholder=""></td>
      </tr>
      <tr>
        <th scope="row" style="background: #FFE13C;">쿠폰 할인 </th>
        <td style="text-align: left;"><input type="text" class="form-control num_only num_comma num_sum" id="pay_coupon" name="pay_coupon" value="0" placeholder="">
         /  <DIV id='panel_coupon'></DIV>
        <button type="button" id="coupon_see" onclick="coupon(${param.member_no});" class="btn btn-info">쿠폰 조회</button>
        </td>
        <th scope="row" style="background: #FFE13C;">포인트 사용 </th>
        <td style="text-align: left;"><input type="text" class="form-control num_only num_comma num_sum" id="pay_point" name="pay_point" value="0" placeholder="">
         /  <DIV id='panel_point'></DIV>
        <button type="button" id="point_see" onclick="point(${param.member_no});" class="btn btn-info">포인트 조회</button>
        </td>
      </tr>
      <tr>
        <th scope="row" style="background: #B2FA5C;">배송료 </th>
        <td style="text-align: left;"><input type="text" class="form-control num_only num_comma num_sum" id="dev_cost" name="dev_cost" value="3000" placeholder=""></td>
        <th scope="row" style="background: #ff4040;">총 결제 금액</th>
        <td style="text-align: left;"><input type="text" class="form-control text-right font-weight-bold num_only num_comma num_sum" id="pay_total" name="pay_total" value="0" placeholder=""></td>
      </tr>
      <tr>
        <th scope="row" style="background: #ad9463;">비고</th>
        <td colspan="3" style="text-align: left;"></td>
      </tr>
      
    </tbody>
    
    </table>
    </div>
  </FORM>
    
     <!-- **************************** 결제 부분 종료 ************************************ -->
    
      <div class="content_bottom_menu" style="padding-right: 20%;">
        <button type="button" id="send" class="btn btn-primary">주문</button>
        <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">주문 취소</button>
      </div>
    
     <div style='clear: both;'></div>
    


 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
