<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 가입</h1>
	<c:if test="${not empty errorMsg}">
		<div style="color:red">${errorMsg}</div>
	</c:if>
	<form action="${pageContext.request.contextPath}/user/register.do" method="post">
		id : <input type="text" name="id" /> <br/>
		pw : <input type="password" name="pwd" /> <br/>
		name : <input type="text" name="name" /> <br/>
		email : <input type="text" name="email" /> <br/>
		address : <input type="text" name="address" /> <br/>
		<input type="submit" value="회원가입"/> <input type="reset"/><br/>
	</form>
</body>
</html>