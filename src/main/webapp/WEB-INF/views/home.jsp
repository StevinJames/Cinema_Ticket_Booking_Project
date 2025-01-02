<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Class Home Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"/>
    <style>
        body {
            background-image: url('https://corp.kaltura.com/wp-content/uploads/2022/05/5-virtual-classroom-backgrounds-02.png');
            background-size: cover;
            background-position: center;
            font-family: 'Arial', sans-serif;
        }
    </style>
</head>
<body class="font-roboto bg-gray-100">
    <header class="bg-blue-600 text-white p-4">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">M Learning</h1>
            <nav class="flex items-center space-x-4">
                <ul class="flex space-x-4">
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/defineRole">Register</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <main class="container mx-auto p-4">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-3xl font-bold">Available Courses</h2>
            <div class="relative">
                <input class="border border-gray-300 rounded-lg py-2 px-4 w-64" placeholder="Search courses..." type="text"/>
                <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
            </div>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <c:forEach var="course" items="${courses}">
                <div class="bg-white p-4 rounded-lg shadow-md">
                    <img src="${pageContext.request.contextPath}/course/Photo/${course.id}" 
                         alt="Image for ${course.title}" 
                         class="w-full h-48 object-cover rounded-t-lg" 
                         height="200" 
                         width="300"/>
                    <h2 class="text-xl font-bold mt-2">Title: ${course.title}</h2>
                    <h3 class="text-xl font-bold mt-2">Subject: ${course.teacher.subject}</h3>
                    <h4 class="text-xl font-bold mt-2">Teacher: ${course.teacher.userName}</h4>
                    <p class="text-gray-700">${course.description}</p>
                    
                    <a href="${pageContext.request.contextPath}/student/enroll?courseId=${course.id}&studentId=${student.id}" 
                       class="mt-2 bg-green-600 text-white px-4 py-2 rounded shadow hover:bg-green-700">
                        Enroll
                    </a>
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
