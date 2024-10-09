<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    
    <form:form action="register" method="post" modelAttribute="userObj">
        <form:errors path="*" cssClass="error"/>

        <label for="username">Username :</label>
        <form:input path="name"/>
        <form:errors path="name" cssClass="error"/>  <br>

		<label for="email">Email :</label>
        <form:password path="email"/>
        <form:errors path="email" cssClass="error"/>  <br>

        <label for="password">Password :</label>
        <form:password path="password"/>
        <form:errors path="password" cssClass="error"/>  <br>

        <label for="retypePassword">Retype Password :</label>
        <form:password path="retypePassword"/>
        <form:errors path="retypePassword" cssClass="error"/> <br>

        <input type="submit" value="Register"/>
    </form:form>
</body>
</html>
