<%@ page contentType="text/html; charset=UTF-8"%>
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
  /* fna 태그 관련 */
  /* *************** */
   
   .form_fna {
    width: 80%; 
    margin: auto; 
   } 
   .fieldset_fna {
    display: inline-block;
    width: 98%; 
    margin: 5px auto; 
    text-align: center;
    border: 8px solid;
    border-radius: 50px;
  }
  .legend_fna {
  color: white;
  width: 250px;
  border-radius: 50px;
  box-shadow: 0 0 0 5px #fff;
  }
  
  </style>
 
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  // 천단위 구분자 출력, 정규 표현식
  function comma(su) {
    return su.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
  }
</script>
<script type="text/javascript">
  $(function() {
    $('#btn_member').on('click', msg1);    // 회원가입,정보 F&A
    $('#btn_product').on('click', msg2);    // 전통주 상품 F&A
    $('#btn_order').on('click', msg3);       // 주문,결제,취소 F&A
    $('#btn_delivery').on('click', msg4);   // 배송 관련 자주하는 질문 F&A
    $('#btn_ect').on('click', msg5);         // 서비스,기타 F&A
    $('#modal_passwd').on('click', passwd_check); // 비밀글일 경우 모달창에서 비밀번호 확인  
    
  });
  

 // ------------------ F & A 관련 시작 ----------------------- 
  
  function msg1() { // 회원가입,정보 관련 자주하는 질문
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_1.jsp',
      type: 'get',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'html', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // alert(rdata);

//        if (document.getElementById('join')) {
//          $('#panel').css('text-align', 'left');
//          $('#panel').html(rdata); 
//        }       
        
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

  function msg2() { // 전통주 상품 관련 자주하는 질문
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_2.jsp',
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

  function msg3() { // 주문,결제,취소 관련 자주하는 질문
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_3.jsp',
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

  function msg4() { // 배송 관련 자주하는 질문
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_4.jsp',
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

  function msg5() { // 서비스,기타 관련 자주하는 질문
    var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    $.ajax({
      url: './fna_5.jsp',
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

  // ------------------ F & A 관련 종료 ----------------------- 

   // ------------------ 비밀 번호 확인 시작 ----------------------- 
  
  function read_ajax(qna_no, qna_check) {
    // var params= qna_check;
    // alert('params: ' + params);
   
    if (qna_check == "Y" ) {  // 비밀글
      $('#qna_no').val(qna_no);
      $('#modal_title').html('비밀번호 확인'); // 제목 
      $('#modal_content').html("비밀글이라 비밀번호를 입력해야 합니다."); // 내용
      $('#modal_panel').modal();            // 다이얼로그 출력
        
      return false;  // 실행 종료
    } else { // 비밀글이 아닐 경우
       var params = "?qna_no=" + qna_no +"&qna_word=${param.qna_word}&nowPage=${param.nowPage}";
       location.href="./read.do" + params;
      // alert(params);
       
    }
  }

  function passwd_check(qna_no, qna_passwd) { // 모달창에서 비밀번호 입력 후 맞는지 확인
    // alert("비밀 번호를 입력해 주세요.");
    var qna_no = $('#qna_no').val();
    var qna_passwd = $('#qna_passwd').val();

    var params = 'qna_no=' + qna_no + '&qna_passwd=' + qna_passwd;

    $.ajax({
      url: './passwd.do',
      type: 'get',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
          
        if (rdata.cnt > 0) { // 패스워드 일치
          var params = "?qna_no=" + qna_no +"&qna_word=${param.qna_word}&nowPage=${param.nowPage}";
          location.href="./read.do" + params;
        } else {  // 패스워드 불일치
          confirm("패스워드가 일치하지 않습니다.");
           
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

  // ------------------ 비밀 번호 확인 종료 -----------------------
   
  /* 

    
    // var pw = qna_passwd;
    var pw = "${qna_passwd}";
    alert("passwd=" + passwd + "&pw=" + pw);
    //alert("passwd=" + passwd + "&qna_passwd=" + qnapasswd);
    
    if (passwd == pw) {
      var param = "?qna_no=" + qna_no;
      location.href="./read.do" + param;
      } else {
        alert("비밀 번호가 틀립니다.");
        }

    
    
 */  

  
  </script>
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

<!-- <script>  passwd_check("${qna_passwd }");</script> -->

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
          <input type='hidden' class="form-control" name='qna_no' id='qna_no'  value="" style='width: 20%;'>
          <input type='password' class="form-control" name='qna_passwd' id='qna_passwd'  value='' placeholder="패스워드" style='width: 20%;'>
        </div>
        <div class="modal-footer">
          <button type="button" id='modal_passwd' class="btn btn-default" data-dismiss="modal">확인</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">취소 [닫기]</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료 -->
 
  <DIV class="title_line">
    커뮤니티 > Q&A 질문 게시판
  </DIV>

  <ASIDE class="aside_left">
    <A href="http://172.16.12.99:9090/team2/"> HOME ></A> 
    <A href="javascript:location.reload();"> 커뮤니티 ></A>
    Q&A
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./create.do">질문 등록</A>
    <!--  <span class='menu_divide' >│</span> -->
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>
  
    <FORM class ='form_fna'>
      <fieldset class = 'fieldset_fna'>
        <legend class='legend_fna'> F & A </legend>
        <h5>자주 하는 질문 : 가장 많이 궁금해하시는 내역을 빠르게 해결하실 수 있습니다.</h5>
      <ul>
        <li>
        <button type='button' id='btn_member' name='member' value='member'>회원가입/정보</button>
        <button type='button' id='btn_product' name='product' value='product'>전통주 상품</button>
        <button type='button' id='btn_order' name='order' value='order'>주문/결제/취소</button>
        <button type='button' id='btn_delivery' name='delivery' value='delivery'>배송 관련</button>
        <button type='button' id='btn_ect' name='ect' value='ect'>서비스/기타</button>
      </li>
    </ul>
  
        <DIV id='panel' style='display: none; margin: 10px auto; text-align: left; width: 90%;'></DIV>
     </fieldset>
  </FORM>

  
    <DIV style="text-align: right;">  
    <form name='frm' id='frm' method='get' action='./list.do'>
      <!-- FK communuity_no 지정 -->
      <input type='hidden' name='community_no' value='4'>
      
      <br>
      <c:choose>
        <c:when test="${param.qna_word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='qna_word' id='qna_word' value='${param.qna_word }' 
                     style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='qna_word' id='qna_word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.qna_word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list.do?qna_word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <h5>※ 1:1 문의는 아래 게시판을 이용해 주세요</h5>
        
  <div style='width: 100%;'>
  <form name='frm_table' id='frm_table'> 
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;">
      <col style="width: 45%;">
      <col style="width: 10%;">
      <col style="width: 10%;">
      <col style="width: 10%;">
      <col style="width: 15%;">
    </colgroup>
    <thead>
      <tr>
        <th class="th_basic">NO</th>
        <th class="th_basic">질문사항</th>
        <th class="th_basic">비밀글</th>
        <th class="th_basic">작성자</th> 
        <th class="th_basic">등록일</th>
        <th class="th_basic">기타</th>
      </tr>
    </thead>
      
    <tbody>
    <c:forEach var="qnaMemberVO" items="${list }">  <!-- request 객체에 접근 -->
      <c:set var="community_no" value="${qnaMemberVO.community_no}" />
      <c:set var="qna_no" value="${qnaMemberVO.qna_no}" />
      <c:set var="qna_title" value="${qnaMemberVO.qna_title}" />
      <c:set var="qna_passwd" value="${qnaMemberVO.qna_passwd}" />
      <c:set var="qna_rdate" value="${qnaMemberVO.qna_rdate}" />
      <c:set var="qna_count" value="${qnaMemberVO.qna_count}" />  
      <c:set var="qna_check" value="${qnaMemberVO.qna_check}" /> 
      <c:set var="indent" value="${qnaMemberVO.indent }" />
      <c:set var="ansnum" value="${qnaMemberVO.ansnum }" />
      <c:set var="mid" value="${qnaMemberVO.mid }" />       
      
      <TR>
        <TD class="td_bs">${community_no }-${qna_no}</TD>
        <TD class="td_bs_left" id="qna_title">
          <c:choose>
              <c:when test="${ansnum == 0 }"> <%-- 부모글인 경우 아이콘 출력 --%>
              </c:when>
              <c:when test="${ansnum > 0 }"> <%-- 자식글 아이콘 출력, 들여 쓰기 --%>
                  <img src='./images/white.png' style='width: ${indent * 20}px; height: 20px; opacity: 0.0;'>
                  <label>re:</label>
              </c:when>
          </c:choose>
        <a href="javascript: read_ajax(${qna_no}, '${qna_check }')"> ${qna_title}</a></TD>
        <TD class="td_bs" id ="qna_check">
          <c:choose>
            <c:when test= "${qna_check == 'Y'}">
              <IMG src="./images/lock.png">
            </c:when>
            <c:otherwise>
              <IMG src="./images/unlock.png">
            </c:otherwise>
          </c:choose>
        </TD>
        <TD class="td_bs">${mid }</TD>
        <TD class="td_bs">${qna_rdate.substring(0, 10) }</TD>
        <TD class="td_bs">
          <A href="./update.do?qna_no=${qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./delete.do?qna_no=${qna_no }&qna_word=${param.qna_word }&nowPage=${param.nowPage}"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>             
  
      </TR>
    </c:forEach>
    </tbody>

    </table>
    </form>
  </div>
          <DIV class='bottom_menu'>${paging }</DIV> 
          
    
    <fieldset style="width:58%;">
      <div class="content_bottom_menu" style="width:95%; margin: auto;">
        <button type="button" onclick="location.href='./create.do'" class="btn btn-primary">새로운 질문 등록</button>
      </div>
    </fieldset>
     
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
