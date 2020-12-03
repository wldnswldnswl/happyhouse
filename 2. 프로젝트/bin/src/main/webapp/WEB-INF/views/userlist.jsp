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
	<h1>회원 목록</h1>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="totalUser"  value="0"/>
		<c:forEach items="${userList}" var="user" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${pageScope.user.id}</td>
				<td>${user.name}</td>
				<td>${user.email}</td>
			</tr>
			<c:set var="totalUser"  value="${totalUser+1}"/>
		</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4" align="right"> 총  ${totalUser}명</td>
			</tr>
		</tfoot>
	</table>
</body>
</html>







