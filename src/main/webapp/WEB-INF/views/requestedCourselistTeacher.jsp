<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Teacher Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"/>
</head>
<body class="font-roboto bg-gray-100">
    <header class="bg-blue-600 text-white p-4">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">M Learning</h1>
            <nav class="flex items-center space-x-4">
                <ul class="flex space-x-4">
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/teacher/courseList">Home</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/course/createCourse">Add Course</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/teacher/RequestedcourseList">Requested Courses</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/teacher/logout">Logout</a></li>
                </ul>
                <div class="flex items-center space-x-2">
                    <img src="${pageContext.request.contextPath}/teacher/profilePhoto/${teacher.id}" 
                         alt="Profile photo of the teacher with ID ${teacher.id}" 
                         class="w-10 h-10 rounded-full" 
                         height="40" 
                         width="40" />
                    <a class="font-bold hover:underline" href="${pageContext.request.contextPath}/teacher/profile/${teacher.id}">
                        ${teacher.userName}
                    </a>
                </div>
            </nav>
        </div>
    </header>
    <main class="container mx-auto p-4">
    
    <!-- Requested Courses Section -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-4">
        <h3 class="text-xl font-bold mb-2">Requested Courses</h3>
        
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
    
        <div class="overflow-x-auto">
            <ul class="space-y-4">
                <c:forEach var="requestedCourse" items="${courses}">
                    <li class="bg-gray-50 p-4 rounded-lg shadow flex items-center justify-between">
                        <div class="flex items-center">
                            <img src="${pageContext.request.contextPath}/course/Photo/${requestedCourse.id}" 
                                 alt="Placeholder image for course ${requestedCourse.title}" 
                                 class="w-24 h-24 rounded mr-4" 
                                 height="100" 
                                 width="100" />
                            <span class="truncate text-lg font-medium">${requestedCourse.title}</span>
                             <!-- Status Labels -->
                <c:choose>
                    <c:when test="${requestedCourse.isApproved == 0}">
                        <span class="bg-yellow-500 text-white text-sm px-2 py-1 rounded-full">Pending</span>
                    </c:when>
                    <c:when test="${requestedCourse.isApproved == 1}">
                        <span class="bg-green-500 text-white text-sm px-2 py-1 rounded-full">Approved</span>
                    </c:when>
                    <c:when test="${requestedCourse.isApproved == 2}">
                        <span class="bg-red-500 text-white text-sm px-2 py-1 rounded-full">Rejected</span>
                    </c:when>
                </c:choose>
                        </div>
                        <div class="flex space-x-2">
                            <a href="viewRequestedCourse?courseId=${requestedCourse.id}" 
                            
                               class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                               View
                            </a>
                            <a href="${pageContext.request.contextPath}/course/cancelCourse/${requestedCourse.id}" 
                               class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">
                               Cancel
                            </a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
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
            <p>© 2024 M Learning. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>