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
    
    <!-- Notifications Section -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-4">
        <h3 class="text-xl font-bold mb-2">Notifications</h3>
        <ul>
            <c:forEach var="notification" items="${notifications}">
                <li class="mb-1 text-gray-700 flex justify-between items-center">
    <span>${notification.message}</span>
    <a 
        href="readNotification?noti_id=${notification.id}" 
        class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
        Mark as Read
    </a>
</li>

            </c:forEach>
        </ul>
        <c:if test="${empty notifications}">
            <p class="text-gray-500">No notifications at the moment.</p>
        </c:if>
    </div>
    
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-3xl font-bold">Manage JSP Courses</h2>
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
            <c:forEach var="course" items="${courses}"> 
                <div class="bg-white p-4 rounded-lg shadow-md">
                    <img alt="${course.title}" class="w-full h-48 object-cover rounded-t-lg" height="200" src="${pageContext.request.contextPath}/course/Photo/${course.id}" width="300"/>
                    <h2 class="text-xl font-bold mt-2">Title : ${course.title}</h2>
                    <h3 class="text-xl font-bold mt-2">Subject : ${course.teacher.subject}</h3>
                    <p class="text-gray-700">Description : ${course.description}</p>
                    <a 
    href="${pageContext.request.contextPath}/course/editCourse/${course.id}"
    class="mt-2 bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 inline-block text-center">
    Edit Course
</a>

<a href="${pageContext.request.contextPath}/material/createMaterial/${course.id}" 
   class="mt-2 bg-yellow-600 text-white px-4 py-2 rounded shadow-lg transition duration-300 ease-in-out transform hover:bg-yellow-700 hover:scale-105 focus:outline-none focus:ring-4 focus:ring-yellow-400">
  Add Material
</a>

                    
   	                 <a 
   					 href="${pageContext.request.contextPath}/course/deleteCourse/${course.id}" 
    			class="mt-2 bg-red-600 text-white px-4 py-2 rounded shadow-lg transition duration-300 ease-in-out transform hover:bg-blue-700 hover:scale-105 focus:outline-none focus:ring-4 focus:ring-blue-400"
    			onclick="return confirm('Are you sure you want to delete this course?');">
    		Delete
				</a>

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
            <p>© 2024 M Learning. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>