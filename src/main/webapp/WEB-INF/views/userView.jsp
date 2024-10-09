<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Information</title>
</head>
<body>
	Id : ${user.id} <br>
	Age : ${user.age} <br>
	Name : ${user.name} <br>
	Gender : ${user.gender} <br>
	
	Frameworks : 
	${user.frameworks}   <br>
	<c:if test="${user.numbers != null && user.numbers eq 1}">
    Number 1
	</c:if>
	<br>
	Country : ${user.country}

</body>
</html>