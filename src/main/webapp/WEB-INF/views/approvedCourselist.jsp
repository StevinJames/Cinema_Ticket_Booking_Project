<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"/>
</head>
<body class="font-roboto bg-gray-100">
    <header class="bg-blue-600 text-white p-4">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">Admin Dashboard</h1>
            <nav class="flex items-center space-x-4">
                <ul class="flex space-x-4">
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/admin/dashboard">Home</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/admin/manageCourses">Approved Courses</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/admin/logout">Logout</a></li>
                </ul>
                <div class="flex items-center space-x-2">
                    <a class="font-bold hover:underline" href="${pageContext.request.contextPath}/admin/profile/${admin.id}">
                        ${admin.userName}
                    </a>
                </div>
            </nav>
        </div>
    </header>
    <main class="container mx-auto p-4">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-3xl font-bold">Approved Courses</h2>
            <div class="relative">
                <input class="border border-gray-300 rounded-lg py-2 px-4 w-64" placeholder="Search courses..." type="text"/>
                <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
            </div>
        </div>
        
        <!-- Display Global Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="success-message mb-4 p-2 bg-green-100 text-green-700 rounded">
                ${successMessage}
            </div>
        </c:if>

        <!-- Display Global Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message mb-4 p-2 bg-red-100 text-red-700 rounded">
                ${errorMessage}
            </div>
        </c:if>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <c:forEach var="course" items="${approvedCourses}"> 
                <div class="bg-white p-4 rounded-lg shadow-md">
                    <img alt="Image of the course titled ${course.title}" class="w-full h-48 object-cover rounded-t-lg" height="200" src="${pageContext.request.contextPath}/course/Photo/${course.id}" width="300"/>
                    <h2 class="text-xl font-bold mt-2">${course.title}</h2>
                    <div class="flex justify-center space-x-2 mt-2">
                        <a 
                            href="viewCourse?courseId=${course.id}"
                            class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 text-center">
                            View
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <script>
            window.onload = function() {
                // Check if the success message exists and set a timeout to hide it after 5 seconds
                const successMessage = document.querySelector('.success-message');
                if (successMessage) {
                    setTimeout(function() {
                        successMessage.style.display = 'none';
                    }, 5000); // 5000 milliseconds = 5 seconds
                }

                // Check if the error message exists and set a timeout to hide it after 5 seconds
                const errorMessage = document.querySelector('.error-message');
                if (errorMessage) {
                    setTimeout(function() {
                        errorMessage.style.display = 'none';
                    }, 5000); // 5000 milliseconds = 5 seconds
                }
            }
        </script>
    </main>
    <footer class="bg-blue-600 text-white p-4 mt-8">
        <div class="container mx-auto text-center">
            <p>© 2024 Admin Dashboard. All rights reserved.</p>
        </div>
    </footer>
</body> 
</html>