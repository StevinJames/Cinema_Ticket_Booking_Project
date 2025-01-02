<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose Role</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
    </style>
</head>
<body class="flex flex-col items-center justify-center min-h-screen bg-gray-100 relative">
    <img src="https://corp.kaltura.com/wp-content/uploads/2022/05/5-virtual-classroom-backgrounds-02.png" alt="Virtual classroom background with abstract shapes and vibrant colors" class="absolute inset-0 w-full h-full object-cover z-0">
    <div class="absolute top-0 left-0 w-full p-4 flex justify-between items-center bg-white bg-opacity-80 shadow-md z-10">
        <div class="text-2xl font-bold text-gray-800">M Learning</div>
        <nav class="space-x-4">
            <a href="${pageContext.request.contextPath}/" class="text-gray-800 hover:text-gray-500">Home</a>
            <a href="#" class="text-gray-800 hover:text-gray-500">Course</a>
        </nav>
    </div>

    <div class="bg-blue-100 bg-opacity-80 p-8 rounded-lg shadow-lg max-w-md w-full text-center z-10 backdrop-blur-md">
        <h2 class="text-2xl font-bold text-gray-800 mb-4">Are you a student or teacher?</h2>
        <div class="flex justify-center space-x-4">
            <a href="${pageContext.request.contextPath}/student/registration" class="bg-blue-500 text-white px-6 py-2 rounded hover:bg-blue-700">Student</a>
            <a href="${pageContext.request.contextPath}/teacher/registration" class="bg-green-500 text-white px-6 py-2 rounded hover:bg-green-700">Teacher</a>
        </div>
    </div>
</body>
</html>