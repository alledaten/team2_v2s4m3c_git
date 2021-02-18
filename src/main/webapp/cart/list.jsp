<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>전통주</title>
 
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
    
<script type="text/javascript">
  $(function() {

    $("#total_sum").html("0 원");  // 초기값 0 원
  }); 

 /* 체크된 체크박스 값만 더하여 누적합계 산출 */
 function price_sum() {
   var sum=0;
   var cnt = $(".ck_box").length;
   for(var i = 0; i < cnt; i++) {
     if($(".ck_box")[i].checked == true  ) {
         sum += parseInt($(".ck_box")[i].value);
     } 
   } 
   $("#total_sum").html(sum+" 원");
}


</script>
 
</head> 
<body>
<jsp:include page="/menu/top.jsp" />
  <DIV class='title_line'>장바구니</DIV>
   <DIV class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
  </DIV> 
  
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs"><input type="checkbox" name="check_all" id="check_all"> 전체 선택
         <script>
              /*     체크박스 전체 선택/전체 해제      */
              $('#check_all').click(function() {
                 if ($('#check_all').prop("checked")) { 
                    $(".ck_box").prop("checked", true);
                    price_sum();  
                 } else {
                   $(".ck_box").prop("checked", false);
                   price_sum();
                 }
              })    
          </script> 
      </TH>   
      <TH class="th_bs">메인 이미지</TH>
      <TH class="th_bs">상품명</TH>
      <TH class="th_bs">단가</TH>
      <TH class="th_bs">수량</TH>
      <TH class="th_bs">금액</TH>
      <TH class="th_bs">날짜</TH>
      <TH class="th_bs">
          <button type="button" class="btn_select_delete" style="background:#eee; margin: 7px auto; padding: 10px 12px; ">
            선택 삭제
          </button>
          <script> /*  선택 삭제   */
              $(".btn_select_delete").click(function () {
                    var double_check = confirm("선택하신 상품이 삭제됩니다.");
                    if(double_check) {
                         var cartno_list = [];
                         
                         $("input[name='ck_box']:checked").each(function() {
                             cartno_list.push($(this).attr("data-cartno"));  
                          }); // 체크된 항목을 배열에 저장
                          var param = { 
                              "cartno_list" : cartno_list
                          };  // 카트번호 배열 저장
                          
                         $.ajax({
                             url: "./delete_ajax.do",
                             dataType: "json",
                             type: "post",
                             data: param,
                             success: function(rdata){
                                  if(rdata.result != 0) {
                                    location.href="./list.do";
                                  } else {
                                    alert("삭제 X");
                                  }
                                }, 
                                error: function(request, status, error) {
                                  var msg = 'ERROR request.status: '+request.status + '/ ' + error;

                                  console.log(msg); // Chrome console 출력
                                }  // Ajax 통신 error, 응답 코드가 200이 아닌경우, dataType이 다른경우 
                          });  //   ajax 호출
                    } 
               });
          </script>          
        </TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="cartVO" items="${list}" varStatus="i">
      <c:set var="cart_no" value="${cartVO.cart_no }" />
      <TR>
        <TD class="td_bs"><input type="checkbox" name="ck_box" class="ck_box" data-cartno="${cart_no}" 
                                               value="${cartVO.product_cost * cartVO.cart_cnt}"  onClick="price_sum()" />
              <script>
               $(".ck_box").click(function(){
                    $("#check_all").prop("checked", false);  // 전체 선택 체크박스 체크 해제
                    price_sum();
               });
              </script>                                                                                  
          </TD>
          <TD class="td_bs"><IMG src='../product/storage/main_images/${cartVO.product_thumb1 }' style='margin-top: 2px; width: 100px; height: 100px;'></TD>
          <TD class="td_bs">${cartVO.product_name }</TD>
          <TD class="td_bs">${cartVO.product_cost }</TD>
          <TD class="td_bs">${cartVO.cart_cnt }</TD>
          <TD class="td_bs">${cartVO.product_cost * cartVO.cart_cnt}</TD>
          <TD class="td_bs">${cartVO.cart_rdate.substring(0, 10) }</TD>
           <TD class="td_bs">
            <button type="button" class="btn_delete_${cart_no}" data-cartno="${cart_no}" 
                        style="background:#eee; padding: 7px 9px; ">삭제</button>
            <script> /*  선택 삭제   */
                $(".btn_delete_${cart_no}").click(function () {
                      var double_check = confirm("선택된 상품을 삭제하시겠습니까?");
                      if(double_check) {
                           var cartno_list = [];
                           
                           cartno_list.push($(this).attr("data-cartno"));  
                            var param = { 
                                "cartno_list" : cartno_list
                            };  // 카트번호 배열 저장
                            
                           $.ajax({
                               url: "./delete_ajax.do",
                               dataType: "json",
                               type: "post",
                               data: param,
                               success: function(rdata){
                                    if(rdata.result != 0) {
                                      location.href="./list.do";
                                    } else {
                                      alert("삭제 X");
                                    }
                                  }, 
                                  error: function(request, status, error) {
                                    var msg = 'ERROR request.status: '+request.status + '/ ' + error;
                                    console.log(msg); // Chrome console 출력
                                  }  // Ajax 통신 error, 응답 코드가 200이 아닌경우, dataType이 다른경우 
  
                            });  //   ajax 호출
                      } 
                 });
  
            </script>                                               
          </TD>       
      </TR>   
    </c:forEach> 
    </tbody>
    <TR style="height: 100px; font-weight: bolder; font-size: 1.4em;">
        <TD class="td_bs"  rowspan="2">결제 합계</TD>
        <TD class="td_bs"  rowspan="2" colspan="3" id="total_sum"></TD>        
      </TR>  
   
  </TABLE>
 
 
<jsp:include page="/menu/bottom.jsp" />
</body>
 
</html> 
 
 
 