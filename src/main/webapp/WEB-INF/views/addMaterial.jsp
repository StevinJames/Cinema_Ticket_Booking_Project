<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Add Course - Teacher Dashboard</title>
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
        <h2 class="text-3xl font-bold mb-4">Add New Course</h2>
        
        <!-- Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="flex items-center bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4" role="alert">
                <svg class="w-6 h-6 fill-current mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                    <path d="M10 18a8 8 0 100-16 8 8 0 000 16zm-1-9h2v5h-2V9zm0-4h2v2h-2V5z"/>
                </svg>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="flex items-center bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4" role="alert">
                <svg class="w-6 h-6 fill-current mr-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                    <path d="M10 18a8 8 0 100-16 8 8 0 000 16zm-1-3h2v2h-2v-2zm0-8h2v5h-2V7z"/>
                </svg>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Form for Adding Course -->
        <form:form action="${pageContext.request.contextPath}/material/addMaterial" class="bg-white p-6 rounded-lg shadow-md" enctype="multipart/form-data" method="post" modelAttribute="material">
            
            <form:hidden path="course" value="${course.id}"/>
            
            <!-- Course Title -->
            <div class="mb-4">
                <form:label class="block text-gray-700 text-sm font-bold mb-2" path="title">Title</form:label>
                <form:input class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" path="title" placeholder="Enter Material title"/>
                <form:errors path="title" cssClass="error"/>
                <c:if test="${not empty titleError}">
                    <span class="text-red-500">${titleError}</span>
                </c:if>
            </div>
            
            <div class="mb-4">
                <form:label class="block text-gray-700 text-sm font-bold mb-2" path="resourceFile">Resource Link</form:label>
                <form:input class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" path="resourceFile" placeholder="Enter Resource Link"/>
                <form:errors path="resourceFile" cssClass="error"/>
                <c:if test="${not empty resourceFileError}">
                    <span class="text-red-500">${resourceFileError}</span>
                </c:if>
            </div>
            
            
            
            <!-- Course Description -->
            <div class="mb-4">
                <form:label class="block text-gray-700 text-sm font-bold mb-2" path="description">Description</form:label>
                <form:textarea class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" path="description" placeholder="Enter Material description" rows="4"></form:textarea>
                <form:errors path="description" cssClass="error"/>
                <c:if test="${not empty descriptionError}">
                    <span class="text-red-500">${descriptionError}</span>
                </c:if>
            </div>
            
            <!-- Submit Button -->
            <div class="flex justify-end">
                <button class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500" type="submit">
                    Add Material
                </button>
            </div>
        </form:form>
    </main>

    <!-- Footer -->
    <footer class="bg-blue-600 text-white p-4 mt-8">
        <div class="container mx-auto text-center">
            <p>© 2024 Teacher Portal. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
