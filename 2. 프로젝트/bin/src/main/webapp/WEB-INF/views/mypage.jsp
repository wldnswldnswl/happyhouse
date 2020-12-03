<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 정보 수정</h1>
	<form action="${pageContext.request.contextPath}/user/update.do" method="post">
<%-- 		id : <input type="text" name="id" value="${user.id}" readonly="readonly"/> <br/>
		 --%>
		id : ${requestScope.user.id } <br/>
		<input type="hidden" name="id" value="${user.id}" />
		pw : <input type="password" name="pwd" /> <br/>
		name : <input type="text" name="name" value="${user.name }"/> <br/>
		email : <input type="text" name="email" value="${user.email}"/> <br/>
		address : <input type="text" name="address" value="${user.address}"/> <br/>
		<input type="submit" value="수정"/> <input type="reset"/><br/>
	</form>
</body>
</html>