<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<TABLE class='table table-striped'>
  <colgroup>
    <col style="width: 10%;"></col>
    <col style="width: 50%;"></col>
    <col style="width: 20%;"></col>
  </colgroup>
  <thead>
    <tr>
      <th style='text-align: center;'>No.</th>
      <th style='text-align: center;'>구분</th>
      <th style='text-align: center;'>기타</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="authVO" items="${list }">
      <c:set var="auth_no" value="${authVO.auth_no }" />
      
      <tr> 
        <td style='text-align: center;'>${auth_no}</td>
        <td style='text-align: center;'>${authVO.auth_content}</td>
        <td style='text-align: center;'>
          <A href="./read_update.do?auth_no=${auth_no }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?auth_no=${auth_no }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</TABLE>