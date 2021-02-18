<%@ page contentType="text/html; charset=UTF-8" %>
 
<% 
request.setCharacterEncoding("utf-8"); 
String root = request.getContextPath(); 
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <form name='frm' action='./_proc.jsp' method='POST'>
  
  </form>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>

 