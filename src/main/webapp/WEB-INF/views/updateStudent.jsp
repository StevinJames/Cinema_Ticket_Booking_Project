<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-image: url('https://corp.kaltura.com/wp-content/uploads/2022/05/5-virtual-classroom-backgrounds-02.png');
            background-size: cover;
            background-position: center;
            font-family: 'Arial', sans-serif;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen bg-gray-900 bg-opacity-50">
    <div class="absolute top-0 left-0 w-full p-4 flex justify-between items-center bg-transparent">
        <div class="text-black text-2xl font-bold">M Learning</div>
        <nav class="space-x-4">
            <a href="${pageContext.request.contextPath}/" class="text-black hover:text-gray-300">Home</a>
            <a href="#" class="text-black hover:text-gray-300">Course</a>
            <a href="${pageContext.request.contextPath}/student/logout" class="text-black border border-white px-4 py-2 rounded hover:bg-white hover:text-gray-900">Logout</a>
        </nav>
    </div>

    <div class="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg max-w-sm w-full">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-bold text-gray-800">Update Student Profile</h2>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <div class="mb-4 p-2 bg-red-100 text-red-700 rounded">
                ${errorMessage}
            </div>
        </c:if>
        <form:form action="${pageContext.request.contextPath}/student/updateProfile" modelAttribute="student" method="post" enctype="multipart/form-data">
            <!-- Name Field -->
            
            <form:hidden path="id" value="${student.id}"/>
            <div class="mb-4">
                <label for="userName" class="block text-gray-700">UserName</label>
                <div class="relative">
                    <form:input path="userName" id="userName" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your name" />
                    <i class="fas fa-user absolute right-3 top-3 text-gray-400"></i>
                </div>
                <c:if test="${not empty userNameError}">
                    <p class="text-red-500 text-sm mt-1">${userNameError}</p>
                </c:if>
            </div>
            
            <!-- Email Field -->
            <div class="mb-4">
                <label for="email" class="block text-gray-700">Email</label>
                <div class="relative">
                    <form:input type="email" path="email" id="email" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your email" />
                    <i class="fas fa-envelope absolute right-3 top-3 text-gray-400"></i>
                </div>
                <form:errors path="email" class="text-red-500 text-sm mt-1" />
            </div>
            <c:if test="${not empty emailExistsError}">
            	<div class="alert alert-danger">${emailExistsError}</div>
        		</c:if>

            <!-- Gender Field -->
            <div class="mb-4">
                <label for="gender" class="block text-gray-700">Gender</label>
                <form:select path="gender" id="gender" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <form:option value="Male" label="Male">Male</form:option>
                    <form:option value="Female" label="Female">Female</form:option>
                    <form:option value="Other" label="Other">Other</form:option>
                </form:select>
                <form:errors path="gender" class="text-red-500 text-sm mt-1" />
            </div>

            <!-- Date of Birth Field -->
            <div class="mb-4">
                <label for="dob" class="block text-gray-700">Date of Birth</label>
                <form:input type="date" path="dob" id="dob" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
                <form:errors path="dob" class="text-red-500 text-sm mt-1" />
            </div>

            <!-- City Field -->
            <div class="mb-4">
                <label for="city" class="block text-gray-700">City</label>
                <form:input path="city" id="city" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
                <form:errors path="city" class="text-red-500 text-sm mt-1" />
            </div>

            <!-- Phone Number Field -->
            <div class="mb-4">
                <label for="phoneNum" class="block text-gray-700">Phone Number</label>
                <form:input path="phoneNum" id="phoneNum" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
                <form:errors path="phoneNum" class="text-red-500 text-sm mt-1" />
            </div>
            
            <!-- Profile Photo Field -->
            <div class="mb-4">
                <label for="profilePhoto" class="block text-gray-700">Profile Photo</label>
                <div class="relative">
                    <form:input type="file" path="file" id="profilePhoto" accept="image/*" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <i class="fas fa-upload absolute right-3 top-3 text-gray-400"></i>
                </div>
                <form:errors path="file" class="text-red-500 text-sm mt-1" />
            </div>


            <!-- Bio Field -->
            <div class="mb-4">
                <label for="bio" class="block text-gray-700">Bio</label>
                <form:textarea path="bio" id="bio" rows="3" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"></form:textarea>
                <form:errors path="bio" class="text-red-500 text-sm mt-1" />
            </div>

            <p class="mt-4 text-center text-gray-700">Don't want to update? <a href="${pageContext.request.contextPath}/student/studentProfile" class="text-blue-500 hover:underline">Go back to your profile</a></p>

            <button type="submit" class="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-700 focus:outline-none">Update Profile</button>
        </form:form>
    </div>
</body>
</html>
