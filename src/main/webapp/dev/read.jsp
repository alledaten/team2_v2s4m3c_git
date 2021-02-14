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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
  /* ****************** */
  /* dev 태그 관련 */
  /* ****************** */
  
  table.dev {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5; 
    margin: 10px auto;
    width: 70%;
    border-left: 3px solid #036;
    border-right: 3px solid #036;
    border-bottom: 3px solid #036;
  }
  
  table.dev thead th {
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
  table.dev tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: center;
    text-align: center;
    border-bottom: 1px solid #ccc;
    background: #f3f6f7;
  }
  table.dev td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
  }
 
  table.dev_read {
    border-collapse: collapse;
    width: 95%;
    text-align: left;
    line-height: 1.5;
    border-left: 1px solid #ccc;
    margin: 10px auto;
  }
  
  table.dev_read thead th {
    padding: 10px;
    font-weight: bold;
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-bottom: 2px solid #c00;
    background: #dcdcd1;
  }
  table.dev_read tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    background: #008080;
  }
  table.dev_read td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
  }
  
  .dev_bottom_menu {
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
    배송 정보 확인
  </ASIDE>
  
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href="../buy/list.do">주문 목록</A>
    <span class='menu_divide' > | </span> 
    <A href='./update.do?dev_no=${devVO.dev_no }'>수정</A>
    <span class='menu_divide' > | </span> 
    <A href='./read_delete.do?dev_no=${devVO.dev_no }'>삭제</A>
  </ASIDE> 
  
  <div class='menu_line'></div>
  
  <FORM name='frm' method="get" action='./update.do'>
  <div class="dev_read">          
  <table class="dev">
    <colgroup>
      <col style="width: 15%;">
      <col style="width: 25%;">
      <col style="width: 15%;">
      <col style="width: 25%;">
      <col style="width: 20%;">
    </colgroup>
    <thead>
      <tr>
        <th colspan="5" class="th_basic" style="text-align: center;">배송 정보</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row" style="background: #9555;">배송 물품</th>
        <td colspan="4" style="text-align: left;">${productVO.product_name }</td>
      </tr>
      <tr>
        <th scope="row" style="background: #edacb1;">주문자 ID</th>
        <td style="text-align: left;">${memverVO.member_id }</td>
        <th scope="row" style="background: #edacb1;">주문자 연락처</th>
        <td colspan="2" style="text-align: left;">${memverVO.member_phone }</td>
      </tr>
      <tr>
        <th scope="row" style="background: #65acca;">받는 사람</th>
        <td style="text-align: left;">${devVO.dev_member }</td>
        <th scope="row" style="background: #65acca;">받는 사람 연락처</th>
        <td colspan="2" style="text-align: left;">${devVO.dev_phone }</td>
      </tr>
      <tr>
        <th scope="row" style="background: #65acca;">받는 사람 주소</th>
        <td colspan="4" style="text-align: left;">${devVO.address1 }${devVO.address2 }</td>
      </tr>
      <tr>
        <th scope="row" style="background: #65acca;">배송 업체</th>
        <td style="text-align: left;">우체국</td>
        <th scope="row" style="background: #65acca;">송장 번호</th>
        <td colspan="2" style="text-align: left;">${devVO.dev_number }</td>
      </tr>
      <tr>
        <th scope="row" style="background: #65acca;">배송 메세지</th>
        <td colspan="4" style="text-align: left;">${devVO.dev_message }</td>
      </tr>
      
    </tbody>
  </table>
  
  
  </div>
  <br><br><br><br><br>
  <fieldset class='fieldset_basic'>
    <ASIDE class="aside_left">
      <button type='button' onclick="location.href='../buy/list.do'" class="btn btn-primary">주문 목록</button>
    </ASIDE>
    <ASIDE class="aside_right">
      <button type='button' onclick="location.href='./update.do?dev_no=${devVO.dev_no }'" class="btn btn-primary">수정</button>
      <button type='button' onclick="location.href='./read_delete.do?dev_no=${devVO.dev_no }'" class="btn btn-primary">삭제</button>
    </ASIDE>
  </fieldset>
</FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>
