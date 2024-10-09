<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Information</title>
<style>
.error {
	color:red;
}
</style>
</head>
<body>

	<form:form modelAttribute="userObj" action="addUser" method="post">
	
<table>

	  <tr>
		<td><form:label path="id">Id</form:label></td>
			<td><form:input path="id" /></td>
				<td><form:errors path="id" cssClass="error"></form:errors></td>
	 </tr>
	 <tr>
		<td><form:label path="age">Age</form:label></td>
			<td><form:input path="age" /></td>
				<td><form:errors path="age" cssClass="error"></form:errors></td>
	 </tr>
	 <tr>
		<td><form:label path="name">Name</form:label></td>
			<td><form:input path="name" /></td>
				<td><form:errors path="name" cssClass="error"></form:errors></td>
	 </tr>
	 
	 <tr>
		<td><form:label path="gender">Gender</form:label></td> <td>
			<form:radiobutton path="gender" value="Male" label="Male" />
			<form:radiobutton path="gender" value="Female" label="Female" />
		</td>
	</tr>
	
	<tr>
		<td>
		<form:label path="frameworks">Frameworks</form:label></td> <td>
		<form:checkboxes items="${framework}" path="frameworks"/>
		</td>
	 </tr>
	 
	 <tr>
		<td>
		<form:label path="numbers">Numbers</form:label></td> <td>
		<form:radiobuttons items="${numList}" path="numbers"/>
		</td>
	 </tr>
	 <tr>
		<td>
		<form:label path="country">Country</form:label></td> <td>
		<form:select items="${list}" path="country" multiple="multiple">
		
		</form:select>
		</td>
	 </tr>
	 <tr>
 		<td colspan="2"> <input type="submit" value="Add"/></td>
 	 </tr>
</table>
	</form:form>

</body>
</html>