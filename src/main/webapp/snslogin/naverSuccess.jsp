<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"
  src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
  charset="utf-8"></script>
<script type="text/javascript"
  src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    var name = ${result}.response.name;
    var email = ${result}.response.email;
    var id = ${result}.response.id;
    var age = ${result}.response.age;
    var nickname = ${result}.response.nickname;
    var gender = ${result}.response.gender;
    var birthday = ${result}.response.birthday;
    var profile_image = ${result}.response.profile_image;
    //$("#name").html("환영합니다. "+name+"님");
    });

  response.sendRedirect("./index.do");
</script>

</head>
<body>
</body>
</html>