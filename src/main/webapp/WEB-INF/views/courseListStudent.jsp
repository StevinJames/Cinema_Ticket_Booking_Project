<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Student Dashboard</title>
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
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/student/courseList">Home</a></li>
                    <li><a class="hover:underline" href="CourseListStudent">Courses</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/student/logout">Logout</a></li>
                </ul>
                <div class="flex items-center space-x-2">
                    <img src="${pageContext.request.contextPath}/student/profilePhoto/${student.id}" 
                         alt="Profile photo of the student with ID ${student.id}" 
                         class="w-10 h-10 rounded-full" 
                         height="40" 
                         width="40" />
                    <a class="font-bold hover:underline" href="${pageContext.request.contextPath}/student/profile/${student.id}">
                        ${student.userName}
                    </a>
                </div>
            </nav>
        </div>
    </header>
    <main class="container mx-auto p-4">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-3xl font-bold">Browse JSP Courses</h2>
            <div class="relative">
                <input class="border border-gray-300 rounded-lg py-2 px-4 w-64" placeholder="Search courses..." type="text"/>
                <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
            </div>
        </div>
        
        <!-- Display Global Success Message -->
        <c:if test="${not empty sessionScope.requestMessage}">
            <div class="mb-4 p-2 bg-green-100 text-green-700 rounded">
                ${sessionScope.requestMessage}
            </div>
            <c:remove var="requestMessage" scope="session"/>
        </c:if>

        <!-- Display Global Error Message -->
        <c:if test="${not empty sessionScope.failedMessage}">
            <div class="mb-4 p-2 bg-red-100 text-red-700 rounded">
                ${sessionScope.failedMessage}
            </div>
            <c:remove var="failedMessage" scope="session"/>
        </c:if>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <c:forEach var="course" items="${courses}">
                <div class="bg-white p-4 rounded-lg shadow-md">
                    <img alt="${course.title}" class="w-full h-48 object-cover rounded-t-lg" 
                         height="200" 
                         src="${pageContext.request.contextPath}/course/Photo/${course.id}" 
                         width="300"/>
                    <h2 class="text-xl font-bold mt-2">Title: ${course.title}</h2>
                    <h3 class="text-xl font-bold mt-2">Subject: ${course.teacher.subject}</h3>
                    <h4 class="text-xl font-bold mt-2">Teacher: ${course.teacher.userName}</h4>
                    <p class="text-gray-700">
                        Description: 
                        <c:choose>
                            <c:when test="${fn:length(course.description) > 100}">
                                ${fn:substring(course.description, 0, 100)}...
                            </c:when>
                            <c:otherwise>
                                ${course.description}
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <div class="flex justify-center space-x-2 mt-2">
                        <a href="viewCourse?courseId=${course.id}" 
                           class="bg-blue-600 text-white px-4 py-2 rounded shadow hover:bg-blue-700">
                            View
                        </a>
                        <a href="${pageContext.request.contextPath}/student/enroll?studentId=${student.id}&courseId=${course.id}" 
                           class="bg-green-600 text-white px-4 py-2 rounded shadow hover:bg-green-700">
                            Enroll
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
    <footer class="bg-blue-600 text-white p-4 mt-8">
        <div class="container mx-auto text-center">
            <p>© 2024 M Learning. All rights reserved.</p>
        </div>
    </footer>
</body> 
</html>