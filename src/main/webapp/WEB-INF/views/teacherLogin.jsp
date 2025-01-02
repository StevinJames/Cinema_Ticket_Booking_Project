<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Login Page</title>
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
            <a href="${pageContext.request.contextPath}/" class="text-black hover:text-gray-300">Home</a>
            <a href="#" class="text-black hover:text-gray-300">Course</a>
            <a href="#" class="text-black border border-white px-4 py-2 rounded hover:bg-white hover:text-gray-900">Login</a>
        </nav>
    </div>
    <div class="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg max-w-sm w-full">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-bold text-gray-800">Teacher Login</h2> 
        </div>
        
        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="bg-red-500 text-white px-4 py-2 rounded mb-4">
                ${errorMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty successMessage}">
            <div class="bg-red-500 text-white px-4 py-2 rounded mb-4">
                ${successMessage}
            </div>
        </c:if>

        <!-- Login Form -->
        <form:form modelAttribute="teacherLogin" action="loginTeacher" method="post" class="space-y-4">
            <!-- Email -->
            <div>
                <label for="email" class="block text-gray-700">Email</label>
                <div class="relative">
                    <form:input 
                        type="email" 
                        path="email" 
                        id="email" 
                        class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" 
                        placeholder="Email" />
                    <i class="fas fa-envelope absolute right-3 top-3 text-gray-400"></i>
                </div>
                <!-- Email Error Messages -->
                <c:if test="${not empty emailError}">
                    <p class="text-red-600 text-sm mt-1">${emailError}</p>
                </c:if>
                <c:if test="${not empty emailNotRegisteredError}">
                    <p class="text-red-600 text-sm mt-1">${emailNotRegisteredError}</p>
                </c:if>
            </div>

            <!-- Password -->
            <div>
                <label for="password" class="block text-gray-700">Password</label>
                <div class="relative">
                    <form:password 
                        path="password" 
                        id="password" 
                        class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" 
                        placeholder="Password" />
                    <i class="fas fa-lock absolute right-3 top-3 text-gray-400"></i>
                </div>
                <!-- Password Error Messages -->
                <c:if test="${not empty passwordError}">
                    <p class="text-red-600 text-sm mt-1">${passwordError}</p>
                </c:if>
            </div>

            <!-- Remember Me & Forgot Password -->
            <div class="flex items-center justify-between">
                <a href="#" class="text-blue-500 hover:underline">Forgot Password?</a>
            </div>

            <!-- Submit Button -->
            <button 
                type="submit" 
                class="w-full bg-gray-800 text-white py-2 rounded hover:bg-gray-900">
                Login
            </button>
        </form:form>

        <!-- Registration Link -->
        <p class="mt-4 text-center text-gray-700">
            Don't have an account? 
            <a 
                href="${pageContext.request.contextPath}/teacher/registration" 
                class="text-blue-500 hover:underline">
                Register
            </a>
        </p>
    </div>
</body>
</html>
