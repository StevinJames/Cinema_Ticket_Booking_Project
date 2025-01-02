<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
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
    <div class="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg max-w-sm w-full">
        <h2 class="text-2xl font-bold text-gray-800 mb-4 text-center">Admin Login</h2>
        <form:form action="loginAdmin" modelAttribute="adminLogin" method="post">
            <!-- Email Field -->
            <div class="mb-4">
                <label for="email" class="block text-gray-700">Email</label>
                <div class="relative">
                    <form:input type="email" path="email" id="email" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your email" />
                    <i class="fas fa-envelope absolute right-3 top-3 text-gray-400"></i>
                </div>
                <form:errors path="email" class="text-red-500 text-sm mt-1" />
            </div>

            <!-- Password Field -->
            <div class="mb-4">
                <label for="password" class="block text-gray-700">Password</label>
                <div class="relative">
                    <form:password path="password" id="password" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your password" />
                    <i class="fas fa-lock absolute right-3 top-3 text-gray-400"></i>
                </div>
                <form:errors path="password" class="text-red-500 text-sm mt-1" />
            </div>

            <c:if test="${not empty loginError}">
                <div class="alert alert-danger text-red-500 text-sm">${loginError}</div>
            </c:if>

            <button type="submit" class="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-700 focus:outline-none">Login</button>
        </form:form>
    </div>
</body>
</html>
