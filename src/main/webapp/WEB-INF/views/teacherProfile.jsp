<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Teacher Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap" rel="stylesheet" />
</head>
<body class="font-roboto bg-gray-100">
    <header class="bg-blue-600 text-white p-4">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">M Learning</h1>
            <nav class="flex items-center space-x-4">
                <ul class="flex space-x-4">
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/teacher/courseList">Home</a></li>
                    <li><a class="hover:underline" href="AddCourse">Add Course</a></li>
                    <li><a class="hover:underline" href="${pageContext.request.contextPath}/teacher/logout">Logout</a></li>
                </ul>
                <div class="flex items-center space-x-2">
                    <!-- Display Student Photo -->
                    <img src="${pageContext.request.contextPath}/teacher/profilePhoto/${teacher.id}" 
                         alt="Teacher Photo" 
                         class="w-10 h-10 rounded-full" 
                         height="40" 
                         width="40" />
                    <!-- Display Student Name -->
                    <a class="font-bold hover:underline" href="${pageContext.request.contextPath}/teacher/profile/${teacher.id}">
                        ${teacher.userName}
                    </a>
                </div>
            </nav>
        </div>
    </header>
    <main class="container mx-auto p-4">
        <div class="bg-white p-6 rounded-lg shadow-md">
            <div class="flex justify-between items-center mb-4">
     <h1 class="text-3xl font-bold">
      Teacher Profile
     </h1>
     <a class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700" href="${pageContext.request.contextPath}/teacher/editProfile/${teacher.id}">
      Edit Profile
     </a>
    </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="flex flex-col items-center">
                    <img src="${pageContext.request.contextPath}/teacher/profilePhoto/${teacher.id}" 
                         alt="Profile Photo" 
                         class="w-40 h-40 rounded-full mb-4" 
                         height="150" 
                         width="150" />
                    
                </div>
                <div>
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 font-bold mb-2">Name</label>
                        <p class="bg-gray-100 p-2 rounded">${teacher.userName}</p>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 font-bold mb-2">Email</label>
                        <p class="bg-gray-100 p-2 rounded">${teacher.email}</p>
                    </div>
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 font-bold mb-2">Gender</label>
                        <p class="bg-gray-100 p-2 rounded">${teacher.gender}</p>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 font-bold mb-2">Subject</label>
                        <p class="bg-gray-100 p-2 rounded">${teacher.subject}</p>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 font-bold mb-2">Phone Number</label>
                        <p class="bg-gray-100 p-2 rounded">${teacher.phoneNumber}</p>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 font-bold mb-2">City</label>
                        <p class="bg-gray-100 p-2 rounded">${teacher.city}</p>
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 font-bold mb-2">Bio</label>
                        <p class="bg-gray-100 p-2 rounded">${teacher.bio}</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <footer class="bg-blue-600 text-white p-4 mt-8">
        <div class="container mx-auto text-center">
            <p>© 2024 M Learning. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
