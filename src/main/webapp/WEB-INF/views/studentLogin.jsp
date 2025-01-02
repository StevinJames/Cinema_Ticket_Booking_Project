<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login Page</title>
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
    <div class="absolute top-0 left-0 w-full p-4 bg-transparent flex justify-between items-center">
        <div class="text-black text-2xl font-bold">M Learning</div>
        <nav class="space-x-4">
            <ul class="flex space-x-4">
                <li><a class="hover:underline" href="CourseListStudent">Home</a></li>
                <li><a class="hover:underline" href="CourseListStudent">Courses</a></li>
            </ul>
        </nav>
    </div>
    <div class="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg max-w-sm w-full">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-bold text-gray-800">Login</h2>
            <button class="text-gray-600 hover:text-gray-900"><i class="fas fa-times"></i></button>
        </div>

        <!-- Display Global Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="mb-4 p-2 bg-green-100 text-red-700 rounded">
                ${successMessage}
            </div>
        </c:if>

        <!-- Display Global Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="mb-4 p-2 bg-red-100 text-red-700 rounded">
                ${errorMessage}
            </div>
        </c:if>

        <form:form action="loginStudent" method="post" modelAttribute="studentLogin">
            <div class="mb-4">
                <label for="email" class="block text-gray-700">Email</label>
                <div class="relative">
                    <form:input path="email" id="email" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Email" value="${email}" />
                    <i class="fas fa-envelope absolute right-3 top-3 text-gray-400"></i>
                </div>
                <!-- Email Error Message -->
                <c:if test="${not empty emailError}">
                    <p class="text-red-600 text-sm mt-1">${emailError}</p>
                </c:if>
                <c:if test="${not empty emailNotRegisteredError}">
                    <p class="text-red-600 text-sm mt-1">${emailNotRegisteredError}</p>
                </c:if>
            </div>
            <div class="mb-4">
                <label for="password" class="block text-gray-700">Password</label>
                <div class="relative">
                    <form:password path="password" id="password" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Password" />
                    <i class="fas fa-lock absolute right-3 top-3 text-gray-400"></i>
                </div>
                <!-- Password Error Message -->
                <c:if test="${not empty passwordError}">
                    <p class="text-red-600 text-sm mt-1">${passwordError}</p>
                </c:if>
            </div>
            <div class="flex items-center justify-between mb-4">
                <label class="flex items-center text-gray-700">
                    <input type="checkbox" class="form-checkbox" />
                    <span class="ml-2">Remember me</span>
                </label>
                <a href="#" class="text-blue-500 hover:underline">Forgot Password?</a>
            </div>
            <button type="submit" class="w-full bg-gray-800 text-white py-2 rounded hover:bg-gray-900">Login</button>
        </form:form>
        <p class="mt-4 text-center text-gray-700">Don't have an account? <a href="${pageContext.request.contextPath}/student/registration" class="text-blue-500 hover:underline">Register</a></p>
    </div>
</body>
</html>
