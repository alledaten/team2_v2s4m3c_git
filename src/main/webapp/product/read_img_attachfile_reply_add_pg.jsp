<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 글 + 이미지 조회하는 경우 참고  --%>

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


<script type="text/javascript">
// 첨부 이미지 출력, dir: ../attachfile/storage/, ./storage/main_images/
var tag = "<A href=\"javascript: $('#product_attachfile_panel').hide();\">";
tag +=  "  <IMG src='../product/storage/main_images/${productVO.product_file1.toLowerCase() }' style='width: 200px; height: 200px;'>";
tag += "</A>";
  function panel_img(dir, file) {
    tag = "";
    tag   = "<A href=\"javascript: $('#product_attachfile_panel').hide();\">"; // 이미지 감추기
    tag += "  <IMG src='" + dir + file + "' style='width: 200px; height: 200px;'>";
    tag += "</A>";

    $('#product_attachfile_panel').html(tag);  // 문자열을 태그로 적용
    $('#product_attachfile_panel').show();      // 패널 출력
  }

</script>

<script type="text/javascript">
  $(function() { // 자동 실행
    // -------------------- 댓글 관련 시작 --------------------
    var frm_product_reply = $('#frm_product_reply');
    $('#product_reply_content', frm_product_reply).on('click', check_login);  // 댓글 작성시 로그인 여부 확인
    $('#btn_create', frm_product_reply).on('click', product_reply_create);  // 댓글 작성시 로그인 여부 확인

    list_by_product_no_join(); // 댓글 목록

    $("#btn_add").on("click", list_by_product_no_join_add_pg); // 더보기 버튼 이벤트 등록
    // -------------------- 댓글 관련 종료 --------------------
    
    $('#product_attachfile_panel').html(tag); 
    $('#product_attachfile_panel').show(); 

    $('#btn_addCart').on('click', cart_check_login);  // check_login 함수 호출
    
  });
 
  // 댓글 작성시 로그인 여부 확인
  function check_login() {
    var frm_product_reply = $('#frm_product_reply');
    if ($('#member_no', frm_product_reply).val().length == 0 ) {
      $('#modal_title').html('댓글 등록'); // 제목 
      $('#modal_content').html("로그인해야 등록 할 수 있습니다."); // 내용
      $('#modal_panel').modal();            // 다이얼로그 출력
      return false;  // 실행 종료
    }
  }

  // 댓글 등록
  function product_reply_create() {
    var frm_product_reply = $('#frm_product_reply');
    
    if (check_login() !=false) { // 로그인 한 경우만 처리
      var params = frm_product_reply.serialize();
      // alert(params);
      // return;

      // 자바스크립트: 영숫자, 한글, 공백, 특수문자: 글자수 1로 인식
      // 오라클: 한글 1자가 3바이트임으로 300자로 제한
      // alert('내용 길이: ' + $('#content', frm_reply).val().length);
      // return;
      
      if ($('#product_reply_content', frm_product_reply).val().length > 300) {
        $('#modal_title').html('댓글 등록'); // 제목 
        $('#modal_content').html("댓글 내용은 300자이상 입력 할 수 없습니다."); // 내용
        $('#modal_panel').modal();           // 다이얼로그 출력
        return;  // 실행 종료
      }

      $.ajax({
        url: "../product_reply/create.do", // action 대상 주소
        type: "post",          // get, post
        cache: false,          // 브러우저의 캐시영역 사용안함.
        async: true,           // true: 비동기
        dataType: "json",   // 응답 형식: json, xml, html...
        data: params,        // 서버로 전달하는 데이터
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = ""; // 메시지 출력
          var tag = ""; // 글목록 생성 태그
          
          if (rdata.cnt > 0) {
            $('#modal_title').attr('class', 'alert alert-success'); // CSS 변경
            msg = "댓글을 등록했습니다.";
            $('#product_reply_content', frm_product_reply).val('');
            $('#product_reply_passwd', frm_product_reply).val('');

            // list_by_contentsno_join(); // 댓글 목록을 새로 읽어옴
            
            $('#product_reply_list').html(''); // 댓글 목록 패널 초기화, val(''): 안됨
            $("#product_reply_list").attr("data-replypage", 1);  // 댓글이 새로 등록됨으로 1로 초기화
            
            // list_by_contentsno_join_add(); // 페이징 댓글, 페이징 문제 있음.
            // alert('댓글 목록 읽기 시작');
            global_rdata = new Array(); // 댓글을 새로 등록했음으로 배열 초기화
            global_rdata_cnt = 0; // 목록 출력 글수
            
            list_by_product_no_join(); // 페이징 댓글
          } else {
            $('#modal_product_reply_content').attr('class', 'alert alert-danger'); // CSS 변경
            msg = "댓글 등록에 실패했습니다.";
          }
          
          $('#modal_title').html('댓글 등록'); // 제목 
          $('#modal_content').html(msg);     // 내용
          $('#modal_panel').modal();           // 다이얼로그 출력
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR request.status: '+request.status + '/ ' + error;
          console.log(msg); // Chrome에 출력
        }
      });
    }
  }

  // --------------------- 댓글 출력 관련 시작 --------------------- 
  var global_rdata = new Array(); // 내용 저장
  var global_rdata_cnt = 0;         // 현재 출력한 댓글의 수, 1 page = 10개 레코드, 11개인 경우 중간 종료

  // Reply class 선언
  // {"memberno":3,"rdate":"2020-12-17 15:16:16.0","passwd":"18","replyno":32,"id":"user1","content":"18","contentsno":53}
  function Product_reply(member_no, product_reply_rdate, product_reply_no, member_id, product_reply_content, product_no) {
    this.member_no = member_no;
    this.product_reply_rdate = product_reply_rdate;
    this.product_reply_no = product_reply_no;
    this.member_id = member_id;
    this.product_reply_content = product_reply_content;
    this.product_no = product_no;
  }
  
  // contentsno별 소속된 댓글 전체 목록
  function list_by_product_no_join() {
    var params = 'product_no=' + ${productVO.product_no };

    $.ajax({
      url: "../product_reply/list_by_product_no_join.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = '';
        
        $('#product_reply_list').html(''); // 패널 초기화, val(''): 안됨
        
        for (i=0; i < rdata.list.length; i++) {
          var row = rdata.list[i];
          // alert(row.replyno);
          var product_reply = new Product_reply(row.member_no, row.product_reply_rdate, row.product_reply_no, row.member_id, row.product_reply_content, row.product_no); // 객체 생성
          global_rdata.push(product_reply); // 배열에 저장
        }

        // alert('페이징된 댓글 목록 읽기 시작');
        list_by_product_no_join_add_pg() // javascript paging
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
    
  }

  // contentsno 별 소속된 댓글 목록
  function list_by_product_no_join_add_pg() {
    var replypage = parseInt($("#product_reply_list").attr("data-replypage")); // 1, 2, 3...
    var end = replypage * 2;     // 2, 4, 6...
    var start = end - 2;             // 0, 2, 4..., 배열 index는 0부터 시작 
    var msg="";

    for (var i=start; i < end; i++) {
      global_rdata_cnt = global_rdata_cnt + 1; // DIV 태그에 글 출력 카운트
      if (global_rdata.length < global_rdata_cnt ) { // 1 page = 10개 레코드, 11개인 경우 중간 종료
        break;
      }

      var row = global_rdata[i]; // 배열에서 글 1건 산출
          
      msg += "<DIV id='"+row.product_reply_no+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
      msg += "<span style='font-weight: bold;'>" + row.member_id + "</span>";
      msg += "  " + row.product_reply_rdate;
      if ('${sessionScope.member_no}' == row.member_no) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
        msg += " <A href='javascript:product_reply_delete("+row.product_reply_no+")'><IMG src='./images/delete.png'></A>";
      }
      msg += "  " + "<br>";
      msg += row.product_reply_content;
      msg += "</DIV>";
    }
    // alert(msg);
    $('#product_reply_list').append(msg);
    $("#product_reply_list").attr("data-replypage", replypage+1);  // 개발자정의 속성 쓰기
    
  }

  
  // 댓글 삭제 레이어 출력
  function product_reply_delete(product_reply_no) {
    // alert('replyno: ' + replyno);
    var frm_product_reply_delete = $('#frm_product_reply_delete');
    $('#product_reply_no', frm_product_reply_delete).val(product_reply_no); // 삭제할 댓글 번호 저장
    $('#modal_panel_delete').modal();             // 삭제폼 다이얼로그 출력
  }

  // 댓글 삭제 처리
  function product_reply_delete_proc(product_reply_no) {
    // alert('replyno: ' + replyno);
    var params = $('#frm_product_reply_delete').serialize();
    $.ajax({
      url: "../product_reply/delete.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
        
        if (rdata.passwd_cnt ==1) { // 패스워드 일치
          if (rdata.delete_cnt == 1) { // 삭제 성공

            $('#btn_frm_product_reply_delete_close').trigger("click"); // 삭제폼 닫기, click 발생 ★ 
            
            $('#' + product_reply_no).remove(); // 태그 삭제 ★
              
            return; // 함수 실행 종료
          } else {  // 삭제 실패
            msg = "패스 워드는 일치하나 댓글 삭제에 실패했습니다. <br>";
            msg += " 다시한번 시도해주세요."
          }
        } else { // 패스워드 일치하지 않음.
          // alert('패스워드 불일치');
          // return;
          
          msg = "패스워드가 일치하지 않습니다.";
          $('#modal_panel_delete_msg').html(msg);

          $('#product_reply_passwd', '#frm_product_reply_delete').focus();
          
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
  }
  <!-------------------------- DA: 쇼핑카트 등록 시작---------------------------->

   
  function add_cart() {
    var frm_cart = $('#frm_cart');
    if(check_login() != false) {  // 로그인 상태인 경우 카트 담기 처리
      var params = frm_cart.serialize();
      // alert(params);
      // return;
      $.ajax({
          url: "../cart/create_ajax.do", // action 대상 주소
          type: "post",
          cache: false,
          async: true,
          dataType: "json",             // 응답 형식
          data: params,
          success: function(rdata) {
            // alert(rdata);
            if(rdata.cnt == 1) {
              alert("선택하신 상품을 장바구니에 담았습니다.");
            } else {
              alert("카트 담기 X");
            } // if~else
            
          },  // function(rdata) 
          
          error: function(request, status, error) { // callback 함수
            var msg = 'ERROR request.status: '+request.status + '/ ' + error;
            console.log(msg); // Chrome에 출력
          }  // Ajax 통신 error, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      });  // $.ajax
     }  // if  
  }  // add_cart()
  
    function cart_check_login() {  
    var frm_cart = $('#frm_cart');
    if ($('#member_no', frm_cart).val().length == 0 ) {  // 로그인 상태인지 검사
      alert("로그인 후 사용 가능")
    } else {
      add_cart()
      }
  }  // check_login()
</script>
</head>

<body>
<c:set var="productgrp_no" value="${productgrpVO.productgrp_no}" />
<c:set var="product_no" value="${productVO.product_no }" />

<jsp:include page="/menu/top.jsp" flush='false' />
  <!-- Modal 알림창 시작 -->
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
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료 -->
  
  <!-- -------------------- 댓글 삭제폼 시작 -------------------- -->
  <div class="modal fade" id="modal_panel_delete" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title">댓글 삭제</h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <form name='frm_product_reply_delete' id='frm_product_reply_delete'>
            <input type='hidden' name='product_reply_no' id='product_reply_no' value=''>
            
            <label>패스워드</label>
            <input type='password' name='product_reply_passwd' id='product_reply_passwd' class='form-control'>
            <DIV id='modal_panel_delete_msg' style='color: #AA0000; font-size: 1.1em;'></DIV>
          </form>
        </div>
        <div class="modal-footer">
          <button type='button' class='btn btn-danger' 
                       onclick="product_reply_delete_proc(frm_product_reply_delete.product_reply_no.value); frm_product_reply_delete.product_reply_passwd.value='';">삭제</button>

          <button type="button" class="btn btn-default" data-dismiss="modal" 
                       id='btn_frm_product_reply_delete_close'>Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- -------------------- 댓글 삭제폼 종료 -------------------- -->
    
  <DIV class="title_line">
    ${productVO.product_name}
  </DIV>
  <ASIDE class="aside_left">
    <A href="../productgrp/list.do">전통주 그룹</A> > 
    <A href="../product/list.do?productgrp_no=${productVO.productgrp_no }&product_word=${param.product_word }&nowPage=${param.nowPage}">${productgrpVO.productgrp_name}</A>  
  </ASIDE>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href='../review/list.do?product_no=${product_no }&review_word=${review_word}&nowPage=${nowPage}'>리뷰 목록</A>
      <span class='menu_divide' > | </span>
    <c:if test="${sessionScope.member_id != null  or sessionScope.member_id_admin != null }">
      <A href="./create.do?productgrp_no=${productgrpVO.productgrp_no }">등록</A>
      <span class='menu_divide' >│</span>
      <A href='./reply.do?product_no=${product_no }&productgrp_no=${productgrp_no }'>답변</A>
      <span class='menu_divide' > | </span>
      <A href='../cart/list.do?product_no=${product_no }&productgrp_no=${productgrp_no }'>카트</A>
      <span class='menu_divide' > | </span>
      <A href='../review/create.do?productgrp_no=${productgrp_no }&product_no=${product_no}'>리뷰 등록</A>
      <span class='menu_divide' > | </span>
    </c:if>  
    <A href='./list.do?productgrp_no=${productgrp_no }&product_word=${param.product_word }&nowPage=${param.nowPage}'>목록</A>

    <%-- 글을 등록한 회원만 메뉴 출력 --%>
    <c:if test="${sessionScope.member_no == productVO.member_no or sessionScope.member_id_admin ne null }">
      <%-- 글을 등록한 회원임. ${sessionScope.memberno} / ${productVO.memberno } --%>
      <c:choose>
        <c:when test="${productVO.product_file1.trim().length() > 0 }">
          <span class='menu_divide' > | </span> 
          <A href='./img_update.do?productgrp_no=${productgrp_no }&product_no=${product_no}&nowPage=${param.nowPage}'>메인 이미지 변경/삭제</A>     
        </c:when>
        <c:otherwise>
          <span class='menu_divide' > | </span> 
          <A href='./img_create.do?productgrp_no=${productgrp_no }&product_no=${product_no}&nowPage=${param.nowPage}'>메인 이미지 등록</A>     
        </c:otherwise>
      </c:choose>    
      <span class='menu_divide' > | </span>
      <A href='../product_attachfile/create.do?product_no=${product_no }&productgrp_no=${productgrp_no }'>첨부 파일 등록</A>
      <span class='menu_divide' > | </span>
      <A href='../product_attachfile/list_by_product_no.do?product_no=${product_no }&productgrp_no=${productgrp_no }'>첨부 파일 삭제</A>
  
      <span class='menu_divide' > | </span> 
      <A href='./update.do?productgrp_no=${productgrp_no }&product_no=${product_no}&nowPage=${param.nowPage}'>수정</A>
              
      <span class='menu_divide' > | </span> 
      <A href='./delete.do?productgrp_no=${productgrp_no }&product_no=${product_no}&nowPage=${param.nowPage}'>삭제</A>
      
    </c:if>
  </ASIDE> 
  
  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="product_no" value="${product_no}">
      <fieldset class="fieldset">
        <ul>
          <DIV style='width: 80%; margin: 0px auto;'>
            <%-- ********** 첨부 파일 이미지 목록 출력 시작 ********** --%>
            <ASIDE class="aside_left">
                <li class="li_none">
                  <DIV id='product_attachfile_panel' style="margin: 0px auto;"></DIV> <!-- 원본 이미지 출력 -->
                </li>
                <li class="li_none" style='text-align: center;' >
                  <c:set var="product_file1" value="${productVO.product_file1.toLowerCase() }" />
                  <c:if test="${product_file1.endsWith('jpg') || product_file1.endsWith('png') || product_file1.endsWith('gif')}">
                    <A href="javascript:panel_img('./storage/main_images/', '${productVO.product_file1 }')"><IMG src='./storage/main_images/${productVO.product_thumb1 }' style='margin-top: 2px; width: 100px; height: 100px;'></A>
                  </c:if>
                  
                  <c:forEach var="product_attachfileVO" items="${product_attachfile_list }">
                    <c:set var="product_attachfile_thumb" value="${product_attachfileVO.product_attachfile_thumb.toLowerCase() }" />
                    
                    <c:choose>
                      <c:when test="${product_attachfile_thumb.endsWith('jpg') || product_attachfile_thumb.endsWith('png') || product_attachfile_thumb.endsWith('gif')}">
                        <A href="javascript:panel_img('../product_attachfile/storage/', '${product_attachfileVO.product_attachfile_fname }')"><IMG src='../product_attachfile/storage/${product_attachfileVO.product_attachfile_thumb }' style='margin-top: 2px; width: 100px; height: 100px;'></A>
                      </c:when>
                    </c:choose>
                  </c:forEach>
                </li>
                <%-- ********** 첨부 파일 이미지 목록 출력 종료 ********** --%>
            </ASIDE>    
            <li class="li_none">
              <h3><span>${productVO.product_name}</span></h3>
              (<span>${productVO.product_recom}</span>)
              <span>${productVO.product_rdate.substring(0, 16)}</span>
              <DIV>${productVO.product_cost } 원</DIV>
            </li>    
          </ul>
        </fieldset>
      <DIV>${productVO.product_description }</DIV>
    </FORM>
    
    
    <!-- 장바구니 -->
    <tr align="center" >
      <td colspan="2">
        <form name="frm_cart" id='frm_cart' >
            <input type="hidden" name="member_no" id="member_no" value="${sessionScope.member_no}">
            <input type="hidden" name="product_no" value="${productVO.product_no }">
              <select name="cart_cnt">
                <c:forEach begin="1" end= "100" var="i">
                  <option value = "${i }">${i }</option>
                </c:forEach>
            </select>&nbsp; 개
            <input type="submit"  id="btn_addCart" value="장바구니 담기">
          </form>
        </td>
      </tr>
      


  <!-- ---------- 댓글 영역 시작 ---------- -->
      <HR>
      <FORM name='frm_product_reply' id='frm_product_reply'> <%-- 댓글 등록 폼 --%>
          <input type='hidden' name='product_no' id='product_no' value='${product_no}'>
          <input type='hidden' name='member_no' id='member_no' value='${sessionScope.member_no}'>
          
          <textarea name='product_reply_content' id='product_reply_content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
          <input type='password' name='product_reply_passwd' id='product_reply_passwd' placeholder="비밀번호">
          <button type='button' id='btn_create'>등록</button>
      </FORM>
      <HR>
      <DIV id='product_reply_list' data-replypage='1'>  <%-- 댓글 목록 --%>
      
      </DIV>
      <DIV id='product_reply_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 100%; background-color: #EEFFFF;'>
          <button id='btn_add' style='width: 100%;'>더보기 ▽</button>
      </DIV>  
    
  </DIV>
  
  <!-- ---------- 댓글 영역 종료----------  -->
  
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>

